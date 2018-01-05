all: hw8 shell

hw8: hw8.o atom.o list.o struct.o scanner.h parser.h                                 
ifeq (${OS}, Windows_NT)                                                                   
	g++ -g3 -o hw8 hw8.o atom.o struct.o list.o -lgtest           
else                                                                                       
	g++ -g3 -o hw8 hw8.o atom.o struct.o list.o -lgtest -lpthread 
endif                                                                                      

shell: shell.o shell.h atom.o list.o struct.o scanner.h parser.h                                 
ifeq (${OS}, Windows_NT)                                                                   
	g++ -g3 -o shell shell.o atom.o list.o struct.o -lgtest           
else                                                                                       
	g++ -g3 -o shell shell.o atom.o list.o struct.o -lgtest -lpthread -lpthread 
endif                                                                                      

atom.o: atom.cpp atom.h variable.h
	g++ -std=gnu++0x -c atom.cpp


list.o:list.cpp list.h
		g++ -std=gnu++0x -c list.cpp
struct.o:struct.cpp struct.h
		g++ -std=gnu++0x -c struct.cpp

hw8.o: hw8.cpp scanner.h atom.h struct.h variable.h parser.h exception.h expression.h
	g++ -std=gnu++0x -c hw8.cpp

shell.o: scanner.h atom.h struct.h variable.h parser.h exception.h expression.h
	g++ -std=gnu++0x -c shell.cpp

clean:
ifeq (${OS}, Windows_NT)
	del *.o hw8 shell
else                    
	rm -f *.o hw8 shell
endif                   

stat:
	wc *.h *.cpp
