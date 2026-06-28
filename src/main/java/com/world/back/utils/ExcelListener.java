package com.world.back.utils;

import com.alibaba.excel.context.AnalysisContext;
import com.alibaba.excel.read.listener.ReadListener;
import com.world.back.entity.Student;
import com.world.back.entity.dto.StudentImportDTO;
import com.world.back.entity.res.StudentImportResult;
import com.world.back.mapper.StudentMapper;
import lombok.Getter;
import lombok.extern.slf4j.Slf4j;

import java.util.*;
import java.util.regex.Pattern;

/**
 * EasyExcel 读取监听器
 * 逐行读取校验，数据分批（按 BATCH_SIZE）去重数据库并入库
 */
@Slf4j
public class ExcelListener implements ReadListener<StudentImportDTO> {

    /** 手机号正则：11位数字，以1开头 */
    private static final Pattern PHONE_PATTERN = Pattern.compile("^1[3-9]\\d{9}$");

    /** 邮箱正则 */
    private static final Pattern EMAIL_PATTERN = Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    /** 批量插入每批大小 */
    private static final int BATCH_SIZE = 500;

    /** 当前批次待入库的学生（含行号） */
    private final List<StudentWithRow> studentBatch = new ArrayList<>();

    /** Excel 内部学号集合（用于内部去重） */
    private final Set<String> excelStudentIds = new HashSet<>();

    /** 导入结果 */
    @Getter
    private final StudentImportResult result = new StudentImportResult();

    private final StudentMapper studentMapper;
    private final Integer instituteId;

    public ExcelListener(StudentMapper studentMapper, Integer instituteId) {
        this.studentMapper = studentMapper;
        this.instituteId = instituteId;
    }

    @Override
    public void invoke(StudentImportDTO row, AnalysisContext context) {
        int rowNum = context.readRowHolder().getRowIndex() + 1;
        result.incrementTotal();

        // 1. 学号不能为空
        String studentId = row.getId();
        if (studentId == null || studentId.trim().isEmpty()) {
            result.addError(rowNum, "学号不能为空");
            return;
        }
        studentId = studentId.trim();

        // 2. Excel 内部去重
        if (excelStudentIds.contains(studentId)) {
            result.addError(rowNum, "学号【" + studentId + "】在Excel中重复");
            return;
        }
        excelStudentIds.add(studentId);

        // 3. 手机号格式校验
        String tel = row.getTel() != null ? row.getTel().trim() : "";
        if (!tel.isEmpty() && !PHONE_PATTERN.matcher(tel).matches()) {
            result.addError(rowNum, "手机号【" + tel + "】格式不正确，应为11位手机号");
            return;
        }

        // 4. 邮箱格式校验
        String email = row.getEmail() != null ? row.getEmail().trim() : "";
        if (!email.isEmpty() && !EMAIL_PATTERN.matcher(email).matches()) {
            result.addError(rowNum, "邮箱【" + email + "】格式不正确");
            return;
        }

        // 校验通过，构建 Student 对象
        Student student = new Student();
        student.setId(studentId);
        student.setRealName(row.getRealName() != null ? row.getRealName().trim() : "");
        student.setTel(tel);
        student.setEmail(email);
        student.setInstituteId(instituteId);

        studentBatch.add(new StudentWithRow(student, rowNum));

        if (studentBatch.size() >= BATCH_SIZE) {
            checkDbAndBatchInsert();
        }
    }

    @Override
    public void doAfterAllAnalysed(AnalysisContext context) {
        if (!studentBatch.isEmpty()) {
            checkDbAndBatchInsert();
        }
        log.info("Excel导入完成: 总计={}, 成功={}, 失败={}",
                result.getTotalCount(), result.getSuccessCount(), result.getFailureCount());
    }

    private void checkDbAndBatchInsert() {
        List<Student> toInsert = new ArrayList<>();

        for (StudentWithRow swr : studentBatch) {
            Student student = swr.student;
            int exists = studentMapper.checkStudentIdExists(student.getId());
            if (exists > 0) {
                result.addError(swr.rowNum, "学号【" + student.getId() + "】已在数据库中存在");
            } else {
                toInsert.add(student);
            }
        }

        if (!toInsert.isEmpty()) {
            try {
                studentMapper.batchInsert(toInsert);
                result.addSuccessCount(toInsert.size());
            } catch (Exception e) {
                log.error("批量插入学生失败", e);
                for (Student s : toInsert) {
                    result.addError(0, "学号【" + s.getId() + "】数据库写入失败: " + e.getMessage());
                }
            }
        }

        studentBatch.clear();
    }

    private static class StudentWithRow {
        final Student student;
        final int rowNum;

        StudentWithRow(Student student, int rowNum) {
            this.student = student;
            this.rowNum = rowNum;
        }
    }
}
