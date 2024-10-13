import socket
from time import sleep

a=[-1.0,-1.0,-1.0,-1.0,-1.0,1,2,0.25,3,3.5,44.3,6.59,8.96,6.62,25.44,65,213,189,516,31,615,89,16,615,6,4-1.0,132,615,-1.0,-1.0,-1.0,-1.0,-1.0,44,66,73,12,32,321,69584,132,98,45869,555]

HOST = '127.0.0.1'                 # Symbolic name meaning all available interfaces
PORT = 50007                        # Arbitrary non-privileged port

with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
    s.bind((HOST, PORT))
    s.listen(1)
    conn, addr = s.accept()
    with conn:
        print('Connected by', addr)
        for i in range(len(a)):
            c=''
            while True:
                try:
                    b=conn.recv(1,socket.MSG_DONTWAIT).decode('utf-8')
                    print("in: {}".format(b))
                except (BlockingIOError):
                    b=''
                if b=='' or b=='/n':
                    break
                else:
                    c+=b
                
            print("in: {}".format(c))
            #if not data:
            #    break
            sleep(2)
            print("out: {}".format(a[i]))
            conn.sendall((str(a[i])+'\n').encode())

            
