from emaillistapp import model

def run_list():
    results = model.findall()
    for index, result in enumerate(results):
        print(f'{index+1}:{result["first_name"]}{result["last_name"]}:{result["email"]}')

def run_add():
    firstname = input('first name : ')
    lastname = input('last name : ')
    email = input('email : ')

    model.insert(firstname, lastname, email)

    run_list()

def run_delete():
    # 이메일을 받아서 이메일에 해당되는 사람을 지움
    email = input('삭제할 이메일 : ')
    model.deletebyemail(email)

    run_list()

def main():
    while True:
        cmd = input(f'(l)ist, (a)dd, (d)elete, (q)uit>')

        if cmd == 'q':
            break
        elif cmd == 'l':
            run_list()
        elif cmd =='a':
            run_add()
        elif cmd =='d':
            run_delete()
        else:
            print('알 수 없는 메뉴입니다.')



if __name__ == '__main__':
    main()

# __name__ == '__main__' and main()
# 앞에꺼가 만족이 되니까 뒤에껄 실행함 이렇게 해도 된다