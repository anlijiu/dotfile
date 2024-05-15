#!/usr/bin/python3

import os
import sys
import poplib  
import time
import email.header

mailserver = sys.argv[1]
mailserverPort = sys.argv[2]
user = sys.argv[3]
# passwd = sys.argv[4]

emailServer = poplib.POP3_SSL(mailserver, mailserverPort)
emailServer.user(user)  
emailServer.pass_('China123456789@360.cn')

emailMsgNum, emailSize = emailServer.stat()  
time.sleep(3)
try:
    f = open('text','r')
    data = f.read()
    f.close()
except:
    data ='0'
if int(emailMsgNum) > int(data):
    f = open('text','w')
    f.write(str(emailMsgNum))
    f.close()
    print('You have %d new mail(s)' % (int(emailMsgNum)-int(data)))
else:
    f = open('text','w')
    f.write(str(emailMsgNum))
    f.close()
    print('You have 0 new mail(s)')
for i in range(emailMsgNum)[::-1][0:7]:  
    for piece in emailServer.retr(i+1)[1]:  
        # piece = piece.decode("utf-8");
        p = piece.decode('UTF-8');
        # print('piece: %s' % p)
        if p.startswith('Subject'):  
            try:
               # 编码,  通常为 utf-8 或者 gb2312
               code = email.header.decode_header(p)[1][1]
               print('%s' % (u'\u4e3b\u9898\uff1a' + email.header.decode_header(p)[1][0].decode(code)))
            except:
               code =  email.header.decode_header(p)[0][1]
               if code == None:
                   code = 'utf-8'
               # print('%s' % (u'\u4e3b\u9898\uff1a' + email.header.decode_header(p)[1][0]))
emailServer.quit()
               #.decode(code)).encode('utf-8'))
