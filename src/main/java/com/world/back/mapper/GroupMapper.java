package com.world.back.mapper;

import com.world.back.entity.res.Group;
import org.apache.ibatis.annotations.*;

import java.util.List;
import java.util.Map;

@Mapper
public interface GroupMapper
{
    @Select("select * from dbgroup where admin_id!='admin' and (year=#{year} or #{year}=0)")
    List<Map<String, Object>> getAllGroups(Integer year);

    @Select("""
            select distinct g.*
            from dbgroup g
            join user_inst_rel uir on g.admin_id = uir.user_id
            where g.admin_id != 'admin'
              and (g.year = #{year} or #{year} = 0)
              and uir.inst_id = #{instituteId}
            """)
    List<Map<String, Object>> getAllGroupsByInstitute(@Param("year") Integer year, @Param("instituteId") Integer instituteId);

    @Insert("insert into dbgroup(admin_id, year, max_student_count) values(#{admin_id},#{year},#{max_student_count})")
    @Options(useGeneratedKeys = true, keyProperty = "id", keyColumn = "id")
    void createGroup(Group group);
    
    @Select("select id from dbgroup where year=#{year} and admin_id=#{admin_id}")
    Integer getGidByYearId(@Param("year") Integer year, @Param("admin_id") String admin_id);

    @Update("update dbgroup set admin_id=#{admin_id},max_student_count=#{max_student_count} where id=#{id}")
    int updateGroup(@Param("id") Integer id,
                    @Param("admin_id") String admin_id,
                    @Param("max_student_count") int max_student_count);

    @Delete("delete from dbinfo where gid=#{id}")
    void deleteGroupInfo(Integer id);
    
    @Delete("delete from tea_group_rel where group_id=#{id}")
    void deleteGroupRelation(Integer id);

    @Delete("delete from tea_group_rel where group_id=#{gid} and is_defense_leader!=0")
    void deleteAdmin(Integer gid);

    @Delete("delete from dbgroup where id=#{id}")
    void deleteGroup(Integer id);

    @Select("select max_student_count from dbgroup where id=#{gid}")
    Integer getMaxStudentCountByGid(Integer gid);
    
    @Select("select * from dbinfo where gid=#{id}")
    List<Map<String, Object>> getMember(Integer id);
    
    @Delete("delete from dbinfo where gid=#{group_id} and stu_id=#{student_id}")
    void deleteFromGroup(@Param("group_id") Integer group_id, @Param("student_id") String student_id);

    @Select({"<script>",
            "select g.*, u.real_name as realName",
            "from dbgroup g",
            "left join user u on g.admin_id = u.id",
            "where g.admin_id != 'admin'",
            "<if test='year != null'> and g.year = #{year} </if>",
             "<if test='adminId != null and adminId != \"\"'> and g.admin_id = #{adminId} </if>",
            "<if test='keyword != null and keyword != \"\"'>",
            "  and u.real_name like concat('%',#{keyword},'%')",
            "</if>",
            "<if test='instituteId != null'>",
            "  and g.id in (select tgr.group_id from tea_group_rel tgr join user_inst_rel uir on tgr.teacher_id = uir.user_id where uir.inst_id = #{instituteId})",
            "</if>",
            "order by g.id",
            "</script>"})
    List<Map<String, Object>> searchGroups(@Param("year") Integer year,
                                           @Param("adminId") String adminId,
                                           @Param("keyword") String keyword,
                                           @Param("instituteId") Integer instituteId);
}
