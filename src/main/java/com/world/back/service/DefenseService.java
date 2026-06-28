package com.world.back.service;

import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

@Service
public interface DefenseService
{
    void yearAdd(Integer year);

    void yearDelete(Integer year);

    List<Map<String, Object>> yearAll();

    List<Map<String, Object>> yearInstituteSummary();

    Integer getCountByYear(Integer year);

    Integer getCountByYearAndInstitute(Integer year, Integer instituteId);

    Integer getStudentCountByYear(Integer year);

    Integer getStudentCountByYearAndInstitute(Integer year, Integer instituteId);

    List<Map<String, Object>> getGroupFirstStudents(Integer year);

    Boolean saveMajorScore(Integer groupId, String studentId, Double majorScore);

    Map<String, Object> SaveCoefficients(Integer year);

    Double getAdjustmentCoefficient(Integer groupId);
}
