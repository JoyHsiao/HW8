#all: hw8 shell
all: madRace utAtom utVariable utScanner utIterator hw8 shell

madRace: mainMadRace.o
	g++ -std=gnu11 -o madRace mainMadRace.o -lgtest -lpthread
mainMadRace.o: mainMadRace.cpp madRace.h utMadRace.h
	g++ -std=gnu11 -std=c++11 -c mainMadRace.cpp


utAtom: mainAtom.o list.o atom.o struct.o
	g++ -std=gnu11 -o utAtom mainAtom.o atom.o list.o struct.o  -lgtest -lpthread
mainAtom.o: mainAtom.cpp utList.h utAtom.h atom.h utStruct.h struct.h
	g++ -std=gnu11 -std=c++11 -c mainAtom.cpp

atom.o: atom.cpp atom.h variable.h
	g++ -std=gnu11 -std=c++11 -c atom.cpp


utVariable: mainVariable.o atom.o struct.o
		g++ -std=gnu11 -o utVariable mainVariable.o atom.o struct.o -lgtest -lpthread
mainVariable.o: mainVariable.cpp utVariable.h variable.h
		g++ -std=gnu11 -std=c++11 -c mainVariable.cpp
list.o:list.cpp list.h
		g++ -std=gnu11 -std=c++11 -c list.cpp
struct.o:struct.cpp struct.h
		g++ -std=gnu11 -std=c++11 -c struct.cpp
#exp: mainExp.o
#	g++ -std=gnu11 -o exp mainExp.o -lgtest -lpthread
#mainExp.o: mainExp.cpp exp.h global.h
#	g++ -std=gnu11 -std=c++11 -c mainExp.cpp

utScanner: mainScanner.o atom.o list.o struct.o scanner.h utScanner.h utParser.h parser.h
	g++ -std=gnu11 -o utScanner mainScanner.o atom.o list.o struct.o -lgtest -lpthread
mainScanner.o: mainScanner.cpp utScanner.h scanner.h  atom.h struct.h variable.h  utParser.h parser.h utExp.h
	g++ -std=gnu11 -std=c++11 -c mainScanner.cpp


utIterator: mainIterator.o atom.o list.o struct.o iterator.h utIterator.h
	g++ -std=gnu11 -o utIterator mainIterator.o atom.o list.o struct.o -lgtest -lpthread
mainIterator.o: mainIterator.cpp utIterator.h
	g++ -std=gnu11 -std=c++11 -c mainIterator.cpp

hw8: mainException.o atom.o list.o struct.o scanner.h parser.h
	g++ -std=gnu11 -o hw8 mainException.o atom.o struct.o list.o -lgtest -lpthread
mainException.o: mainException.cpp scanner.h atom.h struct.h variable.h parser.h exception.h expression.h
	g++ -std=gnu11 -std=c++11 -c mainException.cpp

shell: shell.o shell.h atom.o list.o struct.o scanner.h parser.h
	g++ -std=gnu11 -o shell shell.o atom.o list.o struct.o -lgtest -lpthread
shell.o: scanner.h atom.h struct.h variable.h parser.h exception.h expression.h
	g++ -std=gnu11 -std=c++11 -c shell.cpp

#utTerm: mainTerm.o term.o struct.o var.o list.o
#	g++ -std=gnu11 -o utTerm mainTerm.o term.o var.o struct.o list.o -lgtest -lpthread
#mainTerm.o: mainTerm.cpp utTerm.h term.h var.h utStruct.h struct.h list.h utList.h
#	g++ -std=gnu11 -std=c++11 -c mainTerm.cpp
#term.o: term.h term.cpp
#	g++ -std=gnu11 -std=c++11 -c term.cpp
#struct.o: struct.h struct.cpp
#	g++ -std=gnu11 -std=c++11 -c struct.cpp
#var.o: var.h var.cpp
#g++ -std=gnu11 -std=c++11 -c var.cpp
#list.o: list.h list.cpp term.h var.h
#	g++ -std=gnu11 -std=c++11 -c list.cpp
clean:
	rm -f *.o madRace utAtom utVariable utScanner utIterator hw8 shell
stat:
	wc *.h *.cpp
