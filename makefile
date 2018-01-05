all: utAtom utVariable utScanner utIterator hw8 shell

hw8: mainException.o atom.o list.o struct.o scanner.h parser.h                                 
ifeq (${OS}, Windows_NT)                                                                   
	g++ -g3 -o hw8 mainException.o atom.o struct.o list.o -lgtest           
else                                                                                       
	g++ -g3 -o hw8 mainException.o atom.o struct.o list.o -lgtest -lpthread 
endif                                                                                      

shell: shell.o shell.h atom.o list.o struct.o scanner.h parser.h                                 
ifeq (${OS}, Windows_NT)                                                                   
	g++ -g3 -o shell shell.o atom.o list.o struct.o -lgtest -lpthread           
else                                                                                       
	g++ -g3 -o shell shell.o atom.o list.o struct.o -lgtest -lpthread -lpthread 
endif                                                                                      

utAtom: mainAtom.o list.o atom.o struct.o
	g++ -o utAtom mainAtom.o atom.o list.o struct.o  -lgtest -lpthread
mainAtom.o: mainAtom.cpp utList.h utAtom.h atom.h utStruct.h struct.h
	g++ -std=gnu++0x -c mainAtom.cpp

atom.o: atom.cpp atom.h variable.h
	g++ -std=gnu++0x -c atom.cpp


utVariable: mainVariable.o atom.o struct.o
		g++ -o utVariable mainVariable.o atom.o struct.o -lgtest -lpthread
mainVariable.o: mainVariable.cpp utVariable.h variable.h
		g++ -std=gnu++0x -c mainVariable.cpp
list.o:list.cpp list.h
		g++ -std=gnu++0x -c list.cpp
struct.o:struct.cpp struct.h
		g++ -std=gnu++0x -c struct.cpp

utScanner: mainScanner.o atom.o list.o struct.o scanner.h utScanner.h utParser.h parser.h
	g++ -o utScanner mainScanner.o atom.o list.o struct.o -lgtest -lpthread
mainScanner.o: mainScanner.cpp utScanner.h scanner.h  atom.h struct.h variable.h  utParser.h parser.h utExp.h
	g++ -std=gnu++0x -c mainScanner.cpp


utIterator: mainIterator.o atom.o list.o struct.o iterator.h utIterator.h
	g++ -o utIterator mainIterator.o atom.o list.o struct.o -lgtest -lpthread
mainIterator.o: mainIterator.cpp utIterator.h
	g++ -std=gnu++0x -c mainIterator.cpp

mainException.o: mainException.cpp scanner.h atom.h struct.h variable.h parser.h exception.h expression.h
	g++ -std=gnu++0x -c mainException.cpp

shell.o: scanner.h atom.h struct.h variable.h parser.h exception.h expression.h
	g++ -std=gnu++0x -c shell.cpp

clean:
	rm -f *.o madRace utAtom utVariable utScanner utIterator hw8 shell
stat:
	wc *.h *.cpp
