from MySQLdb import connect, OperationalError

try:
    # 쿼리를 때리려면 cursor가 있어야 함
    # 커서 생성
    db = connect(
        user='webdb',
        password='webdb',
        host='localhost',
        port=3306,
        db='webdb',
        charset='utf8')

    # cursor 생성
    cursor = db.cursor()
    # 얘는 그냥 커서, 출력이 아니기 때문에 그냥 커서임

    # SQL 실행
    sql = 'insert into emaillist values(null, "나다","가","ganada@gmail.com")'
    count = cursor.execute(sql) # sql 쿼리를 커서로 실행한다.
    # count는 몇 개가 들어갔나?

    # insert update delete 는 commit을 해줘야 함
    db.commit()

    # 자원 정리 (지금까지 열었던 것들을 잘라버림)
    cursor.close()
    db.close()

    # 결과 보기
    print(f'실행결과 : {count == 1}')

except OperationalError as e:
    print(f'error: {e}')