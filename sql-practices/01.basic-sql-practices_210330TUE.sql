# show tables;

-- pet table 생성

# varchar는 가변데이터

create table pets(
name varchar(20), 
owner varchar(20),
species varchar(20),
gender char(1),
birth date,
death date
);

-- table scheme 확인
desc pets;

-- insert 
insert into pets values('멍멍이','성호','dog','m','2021-12-25',null); # 얜 순서대로 들어감
insert into pets(owner,name,species,gender,birth) 
		values('에옹','에옹이','cat','m','2021-12-25'); # pets() 에서 순서 지정하고 그거대로 들어감
insert into pets 
		values('마음이','성호','dog','m','2021-12-25','2031-12-25'); 
insert into pets 
		values('choco','성호','dog','m','2021-12-25','2031-12-25'); 


-- select
select * from pets;   # *는 메모리 손해가 큼 그래서 잘 안씀

select name,birth from pets;

select name, birth from pets order by birth asc;
# order by 는 뒤에 나오는거 순으로 소트해서 해줌 asc는 오름차순 dec는 내림차순 일듯?

select count(*) from pets;
# 카운트.. 인듯 3개? 3개라는 건가 봅니다 이럴땐 * 써도 됨

select count(death) from pets; 
# 해당 조건만 세지는듯

select count(*) from pets where death is not null;
# where 로 조건을 걸어줌

-- update

update pets
	set species = 'monkey'
	where name = 'choco';
    
-- delete
delete
	from pets
	where death is not null;
