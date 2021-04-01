
from MySQLdb import connect, OperationalError
from MySQLdb.cursors import DictCursor

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
    cursor = db.cursor(DictCursor)

    # 결과를 dictionary list로 내놓음
    # [ { } , { } ] 의 형태로 커서가 리턴해줌 (인스턴스가 2개일 때)
    # { } 안에는 컬럼명 : 값 컬럼명 : 값 이런 형태로 들어있다.

    # SQL 실행
    sql = 'select no, first_name, last_name, email from emaillist order by no desc'
    cursor.execute(sql) # sql 쿼리를 커서로 실행한다.

    # 결과 받아오기
    results = cursor.fetchall()

    # 자원 정리 (지금까지 열었던 것들을 잘라버림)
    cursor.close()
    db.close()

    # 결과 보기
    for result in results:
        print(result)

except OperationalError as e:
    print(f'error: {e}')