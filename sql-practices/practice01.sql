-- 문제1
-- 사번이 10944인 사원의 이름은(전체 이름)

select concat(first_name, ' ', last_name) as '이름'
	from employees
  where emp_no like 10944;

-- 문제2
-- 전체직원의 다음 정보를 조회하세요. 
-- 가장 선임부터 출력이 되도록 하세요. 
-- 출력은 이름, 성별,  입사일 순서이고 “이름”, “성별”, “입사일로 컬럼 이름을 대체해 보세요.

select concat(first_name, ' ', last_name) as '이름',
		gender as '성별',
        hire_date as '입사일'
	from employees
  order by hire_date asc;

-- 문제3
-- 여직원과 남직원은 각 각 몇 명이나 있나요? 
# count 사용, 쿼리는 한번에

select count(*)
	from employees
  where gender like 'M';

select count(*)
	from employees
  where gender like 'F';

-- 문제4
-- 현재 근무하고 있는 직원 수는 몇 명입니까? (salaries 테이블을 사용합니다.) 
# 헌재 -> to_date가 9999-01-01 이게 되어야 함

select count(*)
	from salaries
  where to_date like '9999-01-01';

-- 문제5
-- 부서는 총 몇 개가 있나요?
# distinct 사용, 여기선 order by 필요가 없음, distinct 로 나온 테이블에 count를 때림

select count(*)
	from departments;

-- 문제6
-- 현재 부서 매니저는 몇 명이나 있나요?
# 현재 -> to_date가 9999-99-99 되어야 함. 

select count(*)
	from dept_manager
where to_date like '9999-01-01';

-- 문제7
-- 전체 부서를 출력하려고 합니다. 순서는 부서이름이 긴 순서대로 출력해 보세요.

select dept_name
	from departments
  order by length(dept_name) desc;

-- 문제8
-- 현재 급여가 120,000이상 받는 사원은 몇 명이나 있습니까?
# 현재, 120000 이상

select count(*)
	from salaries
  where salary > '120,000' and to_date like '9999-01-01';

-- 문제9
-- 어떤 직책들이 있나요? 중복 없이 이름이 긴 순서대로 출력해 보세요.
# distinct, title에 대한 length 구하고 order by

select distinct title, length(title) 
	from titles
  order by length(title) desc;
# select에서 title이 추려졌고, 그 길이를 가지고 계산
# length를 두번 하는게 아님. select 에서 계산된걸로 order by를 함

-- 문제10
-- 현재 Engineer 직책의 사원은 총 몇 명입니까?
# 현재, title에 조건 걸어서 conut

select count(*)
	from titles
  where title like 'Engineer' and to_date like '9999-01-01';

-- 문제11
-- 사번이 13250(Zeydy)인 지원이 직책 변경 상황을 시간순으로 출력해보세요.
# 저 사람이 직책이 어떻게 변경 되었는지 시간순으로 쭉쭉쭉 적어보세요.

select title, from_date, to_date
	from titles
  where emp_no like '13250'
order by from_date asc;