import string

_keyWordList = ("auto","break","case","char","const","continue","default",\
"do","double","else","enum","extern","float","for",\
"goto","if","int","long","register","return","short",\
"signed","static","sizeof","struct","switch","typedef","union",\
"unsigned","void","volatile","while")

_signList = ("+","-","*","/","%","&","|","~","^","!","<",">","=",";",",",":","(",")","[","]","{","}","?","#")

_number = ("1","2","3","4","5","6","7","8","9","0")

_identifierhead = ("a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z",\
"A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","_")

_content = ''

def getProgram():
    global _content
    myPro = open(r'New Text Document.txt','r')

    _content = myPro.read()


def removeComment():
    global _content
    state = 0
    index = -1
    for c in _content:
        index = index + 1

        if state == 0:
            if c == '/':
                state = 1
                startIndex = index

        elif state == 1:
            if c == '*':
                state = 2
            else:
                state = 0

        elif state == 2:
            if c == '*':
                state = 3
            else:
                pass

        elif state == 3:
            if c == '/':
                endIndex = index + 1
                comment = _content[startIndex:endIndex]
                _content = _content.replace(comment,'')
                index = startIndex - 1
                state = 0

        elif c == '*':
                pass
        else:
                state = 2


def lex_analysis():
    global _content
    c = 0
    state = 0
    startIndex = 0
    endIndex = 0
    index = -1
    while c < len(_content):
        #print("c=%s"%(c))
        #print("_content[c]=%s"%(_content[c]))
        #print("startIndex = %s, endIndex = %s \n"%(startIndex,endIndex))
        index = c
        if state == 0:
            '''寮�濮嬬姸鎬�'''
            if _content[index] in _identifierhead:
                '''鏍囪瘑绗�'''
                state = 1
                startIndex = index
            elif _content[index] in _signList:
                '''绗﹀彿鍜岀晫绗�'''
                state = 2
                if _content[index] == '(':
                    print("[(,L_PAREN]")
                    state = 0
                elif _content[index] == ')':
                    print("[),R_PAREN]")
                    state = 0
                elif _content[index] == '[':
                    print("[[,L_BRACKET]")
                    state = 0
                elif _content[index] == ']':
                    print("[],R_BRACKET]")
                    state = 0
                elif _content[index] == '{':
                    print("[{,L_CURLY_BRACKET]")
                    state = 0
                elif _content[index] == '}':
                    print("[},R_BRACE_BRACKET]")
                    state = 0
                    ######-------------------TODO---------------------######
                elif _content[index] == '+':
                    if _content[index+1] == '+':
                        print("[++,INC]")
                        c += 1
                        state = 0
                    elif _content[index+1] == '=':
                        print("[+=,ADD_ASSIGN]")
                        c += 1
                        state = 0
                    else:
                        print("[+,PLUS]")
                        state = 0
                #elif _content[index] == '+' and _content[index+1] != '+' and _content[index-1] != '+':
                    #print("[%s,PLUS]")
                    #state = 0
                    #TODO
                elif _content[index] == '-':
                    if  _content[index+1] == '-':
                        print("[--,DEC]")
                        c += 1
                        state = 0
                    elif _content[index+1] == '=':
                        print("[-=,MINUS_ASSIGN]")
                        c += 1
                        state = 0
                    else:
                        print("[-,MINUS]")
                        state = 0
                    #TODO
                elif _content[index] == '*':
                    print("[*,MULTIPLY]")
                    state = 0
                elif _content[index] == '/':
                    print("[/,DIVISION]")
                    state = 0
                elif _content[index] == '%':
                    print("[%,REMAINDER]")
                    state = 0
                elif _content[index] == '&':
                    if _content[index+1] == '&':
                        print("[&&,LOGICAL_AND]")
                        c += 1
                        state = 0
                    else:
                        print("[&,BITWISE_AND]")
                        state = 0
                    #TODO
                elif _content[index] == '|':
                    if _content[index+1] == '|':
                        print("[||,LOGICAL_OR]")
                        c += 1
                        state = 0
                    else:
                        print("[|,BITWISE_OR]")
                        state = 0
                    #TODO
                elif _content[index] == '~':
                    print("[~,BITWISE_NOT]")
                    state = 0
                elif _content[index] == '^':
                    print("[^,BITWISE_XOR]")
                    state = 0
                elif _content[index] == '!':
                    if _content[index+1] == '=':
                        print("[!=,NOT_EQUAL]")
                        c += 1
                        state = 0
                    else:
                        print("[!,NOT]")
                        state = 0
                elif _content[index] == '<':
                    if _content[index+1] == '=':
                        print("[<=,LESS_EQUAL]")
                        c += 1
                        state = 0
                    elif _content[index+1] == '<':
                        print("[<<,L_SHIFT]")
                        c += 1
                        state = 0
                    else:
                        print("[<,LESS_THAN]")
                        state = 0
                    #TODO
                elif _content[index] == '>':
                    if _content[index+1] == '=':
                        print("[>=,GREATER_EQUAL]")
                        c += 1
                        state = 0
                    elif _content[index+1] == '>':
                        print("[>>,R_SHIFT]")
                        c += 1
                        state = 0
                    else:
                        print("[>,GREATER_THAN]")
                        state = 0
                    #TODO
                elif _content[index] == '=':
                    print("[=,ASSIGN]")
                    state = 0
                    #TODO
                elif _content[index] == ';':
                    print("[;,SEMICOLON]")
                    state = 0
                elif _content[index] == ',':
                    print("[,,COMMA]")
                    state = 0
                elif _content[index] == ':':
                    print("[:,COLON]")
                    state = 0
                elif _content[index] == '?':
                    print("[?,TERNARY_CONDITIONAL]")
                    state = 0
                elif _content[index] == '#':
                    print("[#,NUMBER_SIGN]")
                    state = 0
            elif _content[index] == '"':
                state = 3
                startIndex = index
            elif _content[index] in _number:
                state = 4
                startIndex = index
            else:
                state = 0
        elif state == 1:
            if _content[index] in _identifierhead or _content[index] in _number:
                state = 1
            else:
                endIndex = index
                state = 0
                for x in _keyWordList:
                    if x == str(_content[startIndex:endIndex]):
                        exist = 1
                        print("[%s,%s]"%(_content[startIndex:endIndex],x.upper()))
                        break
                    else:
                        exist = 0
                if exist == 0:
                    print("[%s,IDENTIFIER]"%_content[startIndex:endIndex])
                    continue
        if state == 3:
            c += 1
            while _content[c] != '"':
                index = c
                c += 1
            endIndex = index
            print("[\"%s\",STRING]"%_content[startIndex+1:endIndex+1])
            state = 0
        if state == 4:
            if _content[index] in _number or _content[index] == '.':
                state = 4
            else:
                endIndex = index
                state = 0
                countdot = 0
                for x in _content[startIndex:endIndex]:
                    if x == '.':
                        countdot += 1
                if countdot > 1:
                    print("ERROR!MORE THAN ONE DOT")
                print("[%s,NUMBER]"%_content[startIndex:endIndex])
        c += 1
getProgram()
removeComment()
lex_analysis()
