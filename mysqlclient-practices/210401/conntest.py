from MySQLdb import connect, OperationalError

try:
    db = connect(
        user='webdb',
        password='webdb',
        host='localhost',
        port=3306,
        db='webdb',
        charset='utf8')

    print('ok')

except OperationalError as e:
    print(f'error : {e}')