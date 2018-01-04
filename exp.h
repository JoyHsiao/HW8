#ifndef EXP_H
#define EXP_H

#include "atom.h"

class Exp {
public:
  virtual bool evaluate() = 0;
  virtual string getEvaluateString() {return "";} 
};


class MatchExp : public Exp {
public:
  MatchExp(Term* left, Term* right): _left(left), _right(right){

  }

  bool evaluate(){
    return _left->match(*_right);
  }

  string getEvaluateString(){
    if(_left->symbol() == _right->value())
        return "true";
    else
        return _left->symbol() + " = " + _right->value();
  }

private:
  Term* _left;
  Term* _right;
};

class ConjExp : public Exp {
public:
  ConjExp(Exp *left, Exp *right) : _left(left), _right(right) {

  }

  bool evaluate() {
    return (_left->evaluate() && _right->evaluate());
  }

  string getEvaluateString(){
    if(_left->getEvaluateString() == _right->getEvaluateString())
        return _left->getEvaluateString();
    else if(_left->getEvaluateString() == "true")
        return _right->getEvaluateString();
    else if(_right->getEvaluateString() == "true")
        return _left->getEvaluateString();
    else{
        if(findString(_left->getEvaluateString(), _right->getEvaluateString()))
            return _left->getEvaluateString();
        else
            return _left->getEvaluateString() + ", " + _right->getEvaluateString();
    }
  }

  bool findString(string left, string right){
    vector<string> split;
    char temp[10]={0};
    int index=0;
    for(int i=0; i< left.size(); i++){
        if(left[i] == ','){
            split.push_back(temp);
            index = 0;
            temp[i] = '\0';
        }
        else if(left[i]!=' '){
                temp[index] = left[i];
                index++;
        }
    }
    split.push_back(temp);
    
    index = 0;
    for(int i=0; i< right.size(); i++){
        if(left[i]!=' '){
            temp[index] = right[i];
            index++;
        }
    }

    for(int i=0; i< split.size(); i++){
        if(split[i] == temp)
            return true;
    }
    return false;
  }

private:
  Exp * _left;
  Exp * _right;
};

class DisjExp : public Exp {
public:
  DisjExp(Exp *left, Exp *right) : _left(left), _right(right) {

  }

  bool evaluate() {
    return (_left->evaluate() || _right->evaluate());
  }

  string getEvaluateString(){
    if(_left->evaluate() && _right->evaluate())
        return _left->getEvaluateString() + "; " + _right->getEvaluateString();
    else if(_left->evaluate())
        return _left->getEvaluateString();
  }

  //bool findString(string left, string right){
  //  vector<string> split_l, split_r;
  //  char temp[10]={0};
  //  int index=0;
  //  for(int i=0; i< left.size(); i++){
  //      if(left[i] == ','){
  //          split_l.push_back(temp);
  //          index = 0;
  //          temp[i] = '\0';
  //      }
  //      else if(left[i]!=' '){
  //              temp[index] = left[i];
  //              index++;
  //      }
  //  }
  //  split_l.push_back(temp);
  //  
  //  index = 0;
  //  for(int i=0; i< right.size(); i++){
  //      if(right[i] == ','){
  //          split_r.push_back(temp);
  //          index = 0;
  //          temp[i] = '\0';
  //      }
  //      else if(right[i]!=' '){
  //          temp[index] = right[i];
  //          index++;
  //      }
  //  }

  //  for(int i=0; i< split_l.size(); i++){
  //      for(int j=0; j< split_r.size(); j++){
  //          if(split_l[i] == split_r[j])
  //              return true;
  //      }
  //  }
  //  return false;
  //}

private:
  Exp * _left;
  Exp * _right;
};
#endif
