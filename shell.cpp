#ifndef SHELL_H
#define SHELL_H

#include <gtest/gtest.h>
#include <iostream>
#include <string>
#include <cstdio>

#include "atom.h"  
#include "variable.h"
#include "global.h"
#include "scanner.h"
#include "struct.h"
#include "list.h"  
#include "exp.h"   
#include "parser.h"

int main(){
    std::string str;
    std::cout<< "?- ";
    std::getline(std::cin,str);

    while(str != "halt."){
        while(str[str.size()-1] != '.'){
            if(str == ""){
                std::cout<< "?- ";
                std::getline(std::cin,str);
            }
            else if(str == "halt."){
                return 0;
            }
            else{
                std::cout<<"|   ";
                std::string str2;
                std::getline(std::cin,str2);
                str = str + str2;
                str2 = "";
            }
        }
 
        if(str == "halt.")
            return 0;
        else{
            Scanner s(str);
            Parser p(s);
            try{                                                             
                p.buildExpression();                                           
                p.getExpressionTree()->evaluate();                             
                string result = p.getExpressionTree()->getEvaluateString()+".";

                std::cout<< result<<std::endl;
            } catch (std::string & msg) {                                    
                std::cout<< "fail.";                                                 
            }                                                                
            std::cout<< "?- ";
            std::getline(std::cin,str);
        }
    }

    return 0;
}
#endif
