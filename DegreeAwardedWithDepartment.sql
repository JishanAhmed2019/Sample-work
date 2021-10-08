select distinct a.EMPLID,a.ACAD_PROG,a.ACAD_PLAN,c.Department, a.ACAD_PLAN_TYPE,a.CIP_CODE_PLAN,a.CIP_CODE_SUB_PLAN,a.DEGREE,a.DESCR_FORMAL,b.EDUCATION_LVL,b.DEGREE_DESCR,
a.grad_term, a.sex,a.ACAD_PLAN_DESCR,
case
    when a.USA_CITZ_STATUS = '4' then 'International'
    when a.hispanic = 'Y' and (a.USA_CITZ_STATUS <> '4' and a.USA_CITZ_STATUS is not null) then 'Hispanic'
    when a.white = 'Y' and  a.hispanic = 'N' and (a.USA_CITZ_STATUS <> '4' and a.USA_CITZ_STATUS is not null) and (a.AM_IND = 'Y' or a.asian = 'Y' or a.black = 'Y' or a.ETHNIC_NOT_SPEC = 'Y' or a.HAWIIAN_PACIF = 'Y') then '2 or more'
    when a.am_ind = 'Y' and a.hispanic = 'N' and (a.USA_CITZ_STATUS <> '4' and a.USA_CITZ_STATUS is not null) and  (a.white = 'Y' or a.asian = 'Y' or a.black = 'Y' or a.ETHNIC_NOT_SPEC = 'Y' or a.HAWIIAN_PACIF = 'Y') then '2 or more'
    when a.asian = 'Y' and  a.hispanic = 'N' and (a.USA_CITZ_STATUS <> '4' and a.USA_CITZ_STATUS is not null) and (a.white = 'Y' or a.am_ind = 'Y' or a.black = 'Y' or a.ETHNIC_NOT_SPEC = 'Y' or a.HAWIIAN_PACIF = 'Y') then '2 or more'
    when a.black = 'Y' and  a.hispanic = 'N' and (a.USA_CITZ_STATUS <> '4' and a.USA_CITZ_STATUS is not null) and (a.white = 'Y' or a.asian = 'Y' or a.am_ind = 'Y' or a.ETHNIC_NOT_SPEC = 'Y' or a.HAWIIAN_PACIF = 'Y') then '2 or more'
    when a.ethnic_not_spec = 'Y' and a.hispanic = 'N' and (a.USA_CITZ_STATUS <> '4' and a.USA_CITZ_STATUS is not null) and (a.white = 'Y' or a.asian = 'Y' or a.black = 'Y'  or a.am_ind = 'Y' or a.HAWIIAN_PACIF = 'Y') then '2 or more'
    when a.hawiian_pacif = 'Y' and a.hispanic = 'N' and  (a.USA_CITZ_STATUS <> '4' and a.USA_CITZ_STATUS is not null) and (a.white = 'Y' or a.asian = 'Y' or a.black = 'Y' or a.am_ind = 'Y' or a.ethnic_not_spec = 'Y') then '2 or more'
    when a.white = 'Y' then 'White'
    when a.am_ind = 'Y' then 'AmInd'
    when a.asian = 'Y' then 'Asian'
    when a.black = 'Y' then 'Black'
    when a.ethnic_not_spec = 'Y' then 'NotSpec'
    when a.hawiian_pacif = 'Y' then 'Hawaiian'
end as Ethnicity
from IRRPT.BGSU_GRADUATION_DETAIL_MV a
left join IRMISC.MASTER_PLAN_CODES_REF_TBL b on a.ACAD_PLAN = b.ACAD_PLAN
left join IRMISC.ACADEMIC_PROGRAM_MASTER_LIST c on c.ACAD_PLAN=a.ACAD_PLAN   --Newly added line to get the department
order by 1