package com.world.back.entity.res;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.ArrayList;
import java.util.List;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class StudentImportResult {

    /** 成功导入条数 */
    private int successCount;

    /** 失败条数 */
    private int failureCount;

    /** 总处理条数 */
    private int totalCount;

    /** 失败行详情（行号 + 错误原因） */
    private List<ErrorRow> errorRows;

    public static StudentImportResult success(int count) {
        return new StudentImportResult(count, 0, count, new ArrayList<>());
    }

    public void addError(int rowNum, String reason) {
        if (errorRows == null) {
            errorRows = new ArrayList<>();
        }
        errorRows.add(new ErrorRow(rowNum, reason));
        failureCount++;
    }

    public void incrementTotal() {
        totalCount++;
    }

    public void addSuccessCount(int count) {
        successCount += count;
    }

    @Data
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ErrorRow {
        /** 行号（从1开始，表头为第1行） */
        private int rowNum;
        /** 错误原因 */
        private String reason;
    }
}
