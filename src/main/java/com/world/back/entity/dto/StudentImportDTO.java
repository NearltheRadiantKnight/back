package com.world.back.entity.dto;

import com.alibaba.excel.annotation.ExcelProperty;
import lombok.Data;

@Data
public class StudentImportDTO {

    @ExcelProperty("学号")
    private String id;

    @ExcelProperty("姓名")
    private String realName;

    @ExcelProperty("联系电话")
    private String tel;

    @ExcelProperty("邮箱")
    private String email;
}
