-- 210331 WED

-- 예제1 : salaries 테이블에서 현재 전체 직원의 평균급여 출력

select emp_no, salary
	from salaries
  where to_date = '9999-01-01';
#가능

select avg(salary)
	from salaries
  where to_date = '9999-01-01';
#가능  

select emp_no, avg(salary)
	from salaries
  where to_date = '9999-01-01';
#이게 mysql에서 돌아가긴 하는데 이런건 쓰면 안됨, oracle에서는 오류

select max(salary), avg(salary)
	from salaries
  where to_date = '9999-01-01';
#이렇게 집계함수 두개 쓰는건 되는데 단일이랑 집계함수 이렇게는 안된다

-- 예제2 : salaries 테이블에서 사번이 10060인 직원의 급여 평균과 총합계를 출력

select *
	from salaries
  where emp_no = 10060;
  
select avg(salary), sum(salary)
	from salaries
  where emp_no = 10060;
#avg 는 평균, sum 은 총합

-- 예제 3 : 직원의 최저 임금을 받은 시기와 최대 임금을 바든 시기를 각각 출력해보세요.

select max(salary), min(salary)
	from salaries
  where emp_no = 10060;
# select에 집계 함수가 있으면 다른 컬럼은 올 수 없다. (md파일에 적어 놨음)
# 따라서 시기는 조인 또는 서브쿼리를 통해 구해야 함.

-- 예제 4 : dept_emp 테이블에서 d008에 현재 근무하는 인원수는?

select *
	from dept_emp
  where dept_no = 'd008' and to_date = '9999-01-01';

select count(*)
	from dept_emp
  where dept_no = 'd008' and to_date = '9999-01-01';
  
-- 예제 5 : salaries 테이블에서 각 사원별로 평균연봉 출력

select avg(salary)
	from salaries;

select emp_no, avg(salary) as avg_salary
	from salaries
  group by emp_no;
# group by로 묶었다, 이렇게 하면 emp_no 별로 avg(salary)를 구할 수 있으니까
# 저렇게 집계 함수랑 저런 단일 그거랑 같이 써도 됨
 
select emp_no, avg(salary) as avg_salary
	from salaries
  group by emp_no
  order by avg(salary) desc;
# select 에서 이미 avg(salary)로 임시 테이블이 생겼기 때문에
# 그걸 가지고 소트함

-- 예제 6 : salaries 테이블에서 현재 전체 직원별로 평균급여가 35000 이상인 직원의 평균 급여를
-- 			큰 순서로 출력하세요

select emp_no, avg(salary)
	from salaries
  where to_date = '9999-01-01'
  group by emp_no;
# 여기서 avg(salary) 가지고 다시 where로 하기엔 where를 이미 지났기 때문에 where로 돌아가지 못함
# 그래서 having 을 통해 avg(salary)를 걸러낸다. where가 이미 실행이 됐음.

select emp_no, avg(salary)
	from salaries
  where to_date = '9999-01-01'
  group by emp_no
  having avg(salary) > 35000
  order by avg(salary) asc;
# 1.from 2. where 3.select에 있는 avg(salary) 4.having 5. order by
# select 에서 집계 함수가 들어갔는데 그걸 다시 조건을 걸고 싶으면 이렇게 having으로
# order by는 맨 마지막에 소트해줌

-- 예제 7 : titles 테이블에서 사원별로 몇 번의 직책 변경이 있었는지 조회해 보세요.

select emp_no, count(*)
	from titles
  group by emp_no;
#emp_no 별로 count(*) 를 구함

-- 예제 8 : titles 테이블에서 현재 직책별로 직원수를 구하되 직원수가 100명 이상인 직책만 출력하세요.

select title, count(*) as cnt
	from titles
  where to_date = '9999-01-01'
  group by title
  having cnt >= 100
  order by cnt asc;
# from 에서 테이블, where 에서 현재 직책, group by에서 그룹별로 묶어서
# select 에서 title별로 묶인 count를 구했고
# having 을 통해 count에서 100 명 이상인 직책을 구하고
# order by 에서 소트함.

-- 예제 9: 현재 근무하고 있는 여직원의 이름과 직책을 직원/이름 순으로 출력하세요.

select *
	from employees as a limit 0,10;
# limit 0,10 이러면 0번쨰부터 10개를 가져옴 이런거 게시판에서 사용.

select *
	from employees as a, titles as b;
# join 이 됩니다. 

## 얘도 중요
select a.first_name, b.title
	from employees as a, titles as b
  where a.emp_no = b.emp_no         -- join condition (큰 임시 테이블을 만드는 조건)
		and b.to_date = '9999-01-01' -- select condition (큰 임시 테이블에서 생기는 조건)
        and a.gender = 'F'			-- select condition (큰 임시 테이블에서 생기는 조건)
  order by a.first_name;
# equijoin 예제, inner join 의 종류중 하나가 equijoin
# join 하려는 테이블이 3개면 조건을 3개가 같게 걸어야 함
# a의 emp_no 랑 b의 emp_no 가 같은것을 큰 테이블로 만들고
# 두개의 조건을 만족하게 큰 임시 테이블에서 걸러서 임시 테이블을 만들고
# 거기서 select 된 것들을 order by로 출력

-- 예제 10 : 부서별로 현재 직책이 Engineer인 직원들에 대해서만 평균 급여를 구하세요.

select a.emp_no, a.dept_no, b.salary, c.title
	from dept_emp as a, salaries as b, titles as c
  where a.emp_no = b.emp_no			-- join condition
	and b.emp_no = c.emp_no			-- join condition (테이블이 3개니까 조건도 3개가 되게 걸어줘야함)
    and a.to_date = '9999-01-01'	-- select condition
    and b.to_date = '9999-01-01'	-- select condition
    and c.to_date = '9999-01-01'	-- select condition
    and c.title = 'Engineer';
# join 시키고 큰 임시 테이블 만들고 where의 select condition으로 조건 걸어서 임시 테이블 생성

select a.dept_no, avg(b.salary) as avg_salary
	from dept_emp as a, salaries as b, titles as c
  where a.emp_no = b.emp_no			-- join condition
	and b.emp_no = c.emp_no			-- join condition (테이블이 3개니까 조건도 3개가 되게 걸어줘야함)
    and a.to_date = '9999-01-01'	-- select condition
    and b.to_date = '9999-01-01'	-- select condition
    and c.to_date = '9999-01-01'	-- select condition
    and c.title = 'Engineer'
  group by a.dept_no
  order by avg_salary desc;
# dept_no 로 그룹지어서 b.salary의 평균을 구했음

select a.dept_no, d.dept_name,avg(b.salary) as avg_salary
	from dept_emp as a, salaries as b, titles as c, departments as d
  where a.emp_no = b.emp_no			-- join condition
	and b.emp_no = c.emp_no			-- join condition (테이블이 3개니까 조건도 3개가 되게 걸어줘야함)
    and a.dept_no = d.dept_no			-- join condition
    and a.to_date = '9999-01-01'	-- select condition
    and b.to_date = '9999-01-01'	-- select condition
    and c.to_date = '9999-01-01'	-- select condition
    and c.title = 'Engineer'
  group by a.dept_no
  order by avg_salary desc;
# dept_no 로 그룹지어서 b.salary의 평균을 구했음

-- 예제 11 : 현재 직책별로 급여의 총합을 구하되 Engineer 직책은 제외 하세요.
-- 			단, 총합이 2,000,000,000 이상인 직책만 나타내며 급여의 통합에 대해서는
-- 			내림차순으로 나타내세요.

select a.title, sum(b.salary) #직책별, 총합
	from titles as a, salaries as b
  where a.emp_no = b.emp_no -- join condition
	and a.to_date = '9999-01-01' -- select condition
    and b.to_date = '9999-01-01' -- select condition
    and a.title != 'engineer'	 -- select condition
  group by a.title # 직책별 
  having sum(b.salary) > 2000000000 # 총합이 2000000000 이상
  order by sum(b.salary) desc; # 내림차순
# 지금까지는 inner join 으로만 하고 있음. inner join의 equijoin 을 사용중

-- EQUIJOIN은 표준 문법이 아님 , EQUI 는 = 이거

-- ANSI / ISO SQL 1999 JOIN 문법
-- JOIN ~ ON 이게 표준 문법, 결과는 EQUIJOIN 과 같음
-- 예제 9 - 1: 현재 근무하고 있는 여직원의 이름과 직책을 직원/이름 순으로 출력하세요.
select a.first_name, b.title
	from employees as a 
    join titles as b 
    on a.emp_no = b.emp_no		-- join condition
  where b.to_date = '9999-01-01'-- select condition 
	and a.gender = 'F'			-- select condition
  order by a.first_name;
# 예제 9는 equijoin, 얘는 join ~ on 이렇게 표현
# employees 테이블에 titles 테이블을 조인하는데, 
# 조건은 employees.emp_no = titles.emp_no 임.

-- NATURAL JOIN
-- 예제 9 - 1: 현재 근무하고 있는 여직원의 이름과 직책을 직원/이름 순으로 출력하세요.
select a.first_name, b.title
	from employees as a 
    natural join titles as b 
  where b.to_date = '9999-01-01' -- select condition
	and a.gender = 'F'			 -- select condition
  order by a.first_name;
# 얜 자동으로 조인. 여기서 자동으로 걸리는 조건은
# 컬럼 이름이 같은 애들을 자동으로 걸어줌

-- natural join vs join ~ on 

SELECT 
    COUNT(*)
FROM
    titles AS a
        JOIN
    salaries AS b 
    ON a.emp_no = b.emp_no
WHERE
    a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01';

select
	count(*)
from
	titles as a
		natural join
	salaries as b
where
	a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01';
# natural join 은 이름이 자동으로 걸려서 원하는거 말고 쓸데 없는게 걸릴 수 있으니까 잘 쓰지 x

-- join ~ using

select
	count(*)
from
	titles as a
		join
	salaries as b
    using (emp_no)
where
	a.to_date = '9999-01-01'
        AND b.to_date = '9999-01-01';
# using 으로 join 조건을 걸 수 있음.
# 그래서 join ~ on 이게 맞다. 이거랑 equijoin 두 개 알고 있으면 된다.

-- outer join 
-- 얘는 표준 문법 뿐이다.
-- 현재 회사의 직원의 이름과 부서 이름을 출력하세요.

-- emp, dept 를 erd 를 통해 생성

desc emp;
desc dept;
#auto_increment 이거 erd에서 설정할때 ai 체크하면 숫자가 자동으로 올라감 낫널할때 하면 좋음

insert into dept values(null, '총무');
insert into dept values(null, '개발');
insert into dept values(null, '영업');
select * from dept;

insert into emp values(null, '둘리', 2);
insert into emp values(null, '마이콜', 3);
insert into emp values(null, '또치', 2);
insert into emp values(null, '도우넛', 3);
insert into emp values(null, '길동', null);
select * from emp;
-- 현재 회사의 직원의 이름과 부서 이름을 출력하세요.

select a.name, b.name
from emp as a
join dept as b
on a.dept_no = b.no;
# 사장님 길동이가 빠짐. inner join 이라 조건이 같은거만 매칭이 되서 만들어짐.
# 이럴 때 길동이 보여주려면 outer join이 필요.

-- outer join의 종류에는 left join, right join

-- left join (더 나와야 하는 애를 왼쪽에 둠)
select a.name, b.name
from emp as a
left join dept as b
on a.dept_no = b.no;

select a.name, ifnull(b.name, '없음')
from emp as a
left join dept as b
on a.dept_no = b.no;
# 컬럼이 null일 떄, '없음' 이라고 넣어라. '' 안에 말은 암거나
# 여긴 이름/부서 나옴, 이름이 주가 됨.

-- right join
select a.name, b.name
from emp as a
right join dept as b
on a.dept_no = b.no;
# 여기도 이름/부서 나오는데 여기는 부서가 주가 됨. 이름은 없어도 되는데 부서는 있어야 함

select ifnull(a.name, '직원없음'), b.name
from emp as a
right join dept as b
on a.dept_no = b.no;


-- 서브쿼리


-- 단일행
-- WHERE의 조건식에 서브쿼리를 사용했을 때 결과가 단일행인 경우 =,!=,<,<=,>,>= 를 사용

-- 예제 1 : 현재 Fai Bale 이 근무하는 부서의 전체 직원의 사번과 이름을 출력하세요.
-- 1) 개별 쿼리로 해결 은 좋지 않음-> 가능하면 하나의 쿼리로 해결
-- 1.  Fai Bale 이 근무하는 부서를 안다.
select dept_no 
from dept_emp as a, employees as b
where a.emp_no = b.emp_no
	and to_date = '9999-01-01'
	and concat(b.first_name , ' ' ,b.last_name) = 'Fai Bale';

-- 2. 1번에서 나온 결과를 대입함
select a.emp_no, b.first_name
from dept_emp as a, employees as b
where a.emp_no = b.emp_no
	and a.dept_no = 'd004'
	and a.to_date = '9999-01-01';
    
-- 2) 서브쿼리로 해결
select a.emp_no, b.first_name
from dept_emp as a, employees as b
where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
    and a.dept_no = (	select dept_no 
						from dept_emp as a, employees as b
						where a.emp_no = b.emp_no
							and to_date = '9999-01-01'
							and concat(b.first_name , ' ' ,b.last_name) = 'Fai Bale');
# 얘는 단일행으로 나오는거임 근데 다중행이면 어떻게 하는가?

-- 예제 2 : 현재 전체 사원의 평균 연봉보다 적은 급여를 받는 사원들의 이름, 급여를 출력하세요.

select avg(salary)
from salaries
where to_date = '9999-01-01';
# 평균 연봉

select b.first_name, a.salary
from salaries as a, employees as b
where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
	and a.salary < (select avg(salary)
					from salaries
					where to_date = '9999-01-01')
order by a.salary desc;


-- 다중행
-- WHERE의 조건식에 서브쿼리를 사용했을 때 결과가 다중행인 경우 in, not in, any, all 을 사용
-- any : =any 여기 안에 있는 것 중에 암거나 하나만 같으면 된다. in과 동일.
-- any : =any, >any, <any, <>any(!=any), >=any, <=any
-- all : all(전부 해당), >all, >=all, <all, <=all, <>all(!=all, not in)

-- 예제 3 : 현재 급여가 50000 이상인 직원의 이름과 급여를 출력하세요.

-- 1) join으로 해결
select a.first_name, b.salary
from employees as a, salaries as b
where a.emp_no = b.emp_no
	and b.to_date = '9999-01-01'
    and b.salary > 50000
order by b.salary;

-- 2) 서브쿼리로 해결

select a.first_name, b.salary
from employees as a, salaries as b
where a.emp_no = b.emp_no
	and b.to_date = '9999-01-01'
    and b.salary >= any(select salary
						from salaries
						where salary > 50000
							and to_date = '9999-01-01')
order by b.salary;
#이건 내가 한건데

select a.first_name, b.salary
from employees as a, salaries as b
where a.emp_no = b.emp_no
	and b.to_date = '9999-01-01'
    and (a.emp_no,b.salary) = any(select emp_no, salary
									from salaries
									where to_date = '9999-01-01' 
										and salary > 50000)
order by b.salary;
# 이건 강사님이 하신거
# where에 저렇게 조건 두개 걸고, 서브쿼리 select 에서 두개 걸어도 된다.

select a.first_name, b.salary
from employees as a, salaries as b
where a.emp_no = b.emp_no
	and b.to_date = '9999-01-01'
    and (a.emp_no,b.salary) in (select emp_no, salary
								from salaries
								where to_date = '9999-01-01' 
									and salary > 50000)
order by b.salary;
# =any 랑 in이랑 같음

select a.first_name, b.salary
from employees as a,
    (select emp_no, salary
	from salaries
	where to_date = '9999-01-01' 
		and salary > 50000) as b
where a.emp_no = b.emp_no
order by b.salary;
# 저렇게 넣는걸 하나의 테이블이라고 생각하고 저렇게 취급해도 가능.
# 이게 좀 유용하다? 라는거 같음
# 서브쿼리가 where 뿐만 아니라 from 에도 들어갈 수 있다고 판단.

-- 예제 4 : 현재 가장 적은 직책별 평균급여를 출력해보세요.

select b.title, avg(salary)
from salaries as a, titles as b
where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01'
group by b.title;
# 직책별 평균급여

select b.title, round(avg(salary)) as avg_salary
from salaries as a, titles as b
where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01'
group by b.title
having avg_salary = (
						select min(avg_salary)
						from (
							select b.title, round(avg(salary)) as avg_salary
							from salaries as a, titles as b
							where a.emp_no = b.emp_no
								and a.to_date = '9999-01-01'
								and b.to_date = '9999-01-01'
							group by b.title)as a) ;
# 이해는 감

select b.title, avg(salary) as avg_salary
from salaries as a, titles as b
where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
	and b.to_date = '9999-01-01'
group by b.title
order by avg_salary
limit 0,1;
# limit은 출력하는걸 맨 마지막에 걸려서 출력해줌

-- 예제 5 : 현재 각 부서별로 최고 급여를 받는 사원의 이름과 급여를 출력해 보세요.

# where 에 서브쿼리 넣기, from에 서브쿼리 넣기 이렇게 두가지 방법
# join 써서 하는건 상관 없는듯? where a.emp_to = b.emp_to 이게 join이었지요 기억합시다
# from에 넣는거 먼저, 그리고 where에 넣는거
 
select b.emp_no, b.dept_no, max(a.salary)
from salaries as a, dept_emp as b
where a.emp_no = b.emp_no
	 and a.to_date = '9999-01-01'
     and b.to_date = '9999-01-01'
group by b.dept_no;
# 부서별 최고 

select c.dept_no, c.dept_name, a.first_name, b.max_salary
from employees as a ,
	(
    select b.emp_no, b.dept_no, max(a.salary) as max_salary
	from salaries as a, dept_emp as b
	where a.emp_no = b.emp_no
		 and a.to_date = '9999-01-01'
		 and b.to_date = '9999-01-01'
	group by b.dept_no) as b,
    departments as c
where a.emp_no = b.emp_no
	and b.dept_no = c.dept_no;
# 성공~

select d.dept_no, d.dept_name, b.first_name, a.salary
from employees as b ,
	salaries as a,
    departments as d,
    dept_emp as c
where a.emp_no = b.emp_no
	and b.emp_no = c.emp_no
    and c.dept_no = d.dept_no
	and a.to_date = '9999-01-01'
	and c.to_date = '9999-01-01'
    and (d.dept_no, a.salary) = any (select b.dept_no, max(a.salary) as max_salary
										from salaries as a, dept_emp as b
										where a.emp_no = b.emp_no
											 and a.to_date = '9999-01-01'
											 and b.to_date = '9999-01-01'
										group by b.dept_no)
order by a.salary desc;
# 내가 한거

# 강사님 풀이 --------------------------------------------------------------------------------
select a.dept_no , max(b.salary) as max_salary
from dept_emp as a, salaries as b
where a.emp_no = b.emp_no
	and a.to_date = '9999-01-01'
    and b.to_date = '9999-01-01'
group by a.dept_no;

select a.first_name, b.dept_no, d.dept_name, c.salary
from employees as a, 
	dept_emp as b, 
	salaries as c, 
    departments as d,
    (
    select a.dept_no , max(b.salary) as max_salary
	from dept_emp as a, salaries as b
	where a.emp_no = b.emp_no
		and a.to_date = '9999-01-01'
		and b.to_date = '9999-01-01'
	group by a.dept_no) as e
where a.emp_no = b.emp_no
	and b.emp_no = c.emp_no
    and b.dept_no = d.dept_no
    and b.dept_no = e.dept_no
    and c.salary = e.max_salary
    and b.to_date = '9999-01-01'
	and c.to_date = '9999-01-01';
    
select a.first_name, b.dept_no, d.dept_name, c.salary
from employees as a, 
	dept_emp as b, 
	salaries as c, 
    departments as d
where a.emp_no = b.emp_no
	and b.emp_no = c.emp_no
    and b.dept_no = d.dept_no
    and b.to_date = '9999-01-01'
	and c.to_date = '9999-01-01'
    and (b.dept_no, c.salary) = any (select a.dept_no , max(b.salary) as max_salary
									from dept_emp as a, salaries as b
									where a.emp_no = b.emp_no
										and a.to_date = '9999-01-01'
										and b.to_date = '9999-01-01'
									group by a.dept_no);
#--------------------------------------------------------------------------------------------------

select (select max(salary) from salaries where to_date = '9999-01-01');
# 그냥 뭐 이런 것도 된다.

-- 트랜젝션이란?
-- update 받는 계좌 set 잔고 = 잔고 + 10000
-- where 계좌번호 = '~~'
-- update 보내는 계좌 set 잔고 = 잔고 - 10000
-- where 계좌번호 = '~~'
-- 이렇게 하고 commit() 하면 저렇게 세팅해놓은게 한번에 실행이 됨 
-- 그니까 변경된걸 기록해놨다가 commit() 하면 이제 db에 딱딱 되는거