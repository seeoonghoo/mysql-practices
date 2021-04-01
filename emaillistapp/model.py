from MySQLdb import connect, OperationalError
from MySQLdb.cursors import DictCursor

def findall():
    try:
        # 쿼리를 때리려면 cursor가 있어야 함
        # 커서 생성
        db = conn()

        # cursor 생성
        cursor = db.cursor(DictCursor)

        # 결과를 dictionary list로 내놓음
        # [ { } , { } ] 의 형태로 커서가 리턴해줌 (인스턴스가 2개일 때)
        # { } 안에는 컬럼명 : 값 컬럼명 : 값 이런 형태로 들어있다.

        # SQL 실행
        sql = 'select no, first_name, last_name, email from emaillist order by no desc'
        cursor.execute(sql)  # sql 쿼리를 커서로 실행한다.

        # 결과 받아오기
        results = cursor.fetchall()

        # 자원 정리 (지금까지 열었던 것들을 잘라버림)
        cursor.close()
        db.close()

        # 결과 반환
        return results

    except OperationalError as e:
        print(f'error: {e}')

def insert(firstname,lastname,email):
    try:
        # 쿼리를 때리려면 cursor가 있어야 함
        # 커서 생성
        db = conn()

        # cursor 생성
        cursor = db.cursor()
        # 얘는 그냥 커서, 출력이 아니기 때문에 그냥 커서임

        # SQL 실행
        sql = 'insert into emaillist values(null, %s,%s,%s)'
        count = cursor.execute(sql, (firstname, lastname, email))  # sql 쿼리를 커서로 실행한다.
        # count는 몇 개가 들어갔나?

        # insert update delete 는 commit을 해줘야 함
        db.commit()

        # 자원 정리 (지금까지 열었던 것들을 잘라버림)
        cursor.close()
        db.close()

        # 결과 보기
        return count == 1

    except OperationalError as e:
        print(f'error: {e}')

def conn():

    return connect(
        user='webdb',
        password='webdb',
        host='localhost',
        port=3306,
        db='webdb',
        charset='utf8')

def deletebyemail(email):

    try:
        # 쿼리를 때리려면 cursor가 있어야 함
        # 커서 생성
        db = conn()

        # cursor 생성
        cursor = db.cursor()
        # 얘는 그냥 커서, 출력이 아니기 때문에 그냥 커서임

        # SQL 실행
        sql = 'delete from emaillist where email = %s'
        count = cursor.execute(sql, (email,))  # sql 쿼리를 커서로 실행한다.
        # 이 때, execute 안에 sql 다음엔 !!!튜플!!!로 해야함
        # count는 몇 개가 들어갔나?

        # insert update delete 는 commit을 해줘야 함
        db.commit()

        # 자원 정리 (지금까지 열었던 것들을 잘라버림)
        cursor.close()
        db.close()

        # 결과 보기
        return count == 1

    except OperationalError as e:
        print(f'error: {e}')