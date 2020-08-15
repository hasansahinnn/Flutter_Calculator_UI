import 'package:flutter/material.dart';
import 'package:calculators/Animations/FadeAnimation.dart';

class Calc extends StatefulWidget {
  @override
  _CalcState createState() => _CalcState();
}
class _CalcState extends State<Calc> {
  String numberOne="";
  String numberTwo="";
  String lastoperator="";
  String display="0";

  changeNumber(String number){
    if(lastoperator.isEmpty)
      numberOne+=number;
    else
      numberTwo+=number;
    setState(() {
      display=numberOne+" "+lastoperator+" "+numberTwo;
    });
  }
  changeOperators(String operator){
    if(!numberOne.isEmpty && operator!="=")
      setState(() {
        lastoperator=operator;
        display=numberOne+" "+lastoperator+" "+numberTwo;
      });
    if(operator=="=" && !numberOne.isEmpty && !numberTwo.isEmpty){print("işleme girdi");
      double result = Calc(double.parse(numberOne),double.parse(numberTwo),lastoperator);
      setState(() {
        numberOne=result!=result.ceil()?result.toStringAsPrecision(3):result.floor().toString();
        numberTwo="";
        lastoperator="";
        display=result!=result.ceil()?result.toStringAsPrecision(3):result.floor().toString();
      });
    }
  }
  delete(type){ // 1 - Only last  || 0 - All (C)
      switch(type){
        case 0:
         setState(() {
           numberOne="";
           numberTwo="";
           lastoperator="";
           display="0";
         });
          break;
        case 1:
          if(!numberTwo.isEmpty){
            print(1);
            setState(() {
              numberTwo=numberTwo.substring(0,numberTwo.length-1);
              display=numberOne+" "+lastoperator+" "+numberTwo;
            });
          }

          else if(!lastoperator.isEmpty) {
            print(2);
            setState(() {
              lastoperator = lastoperator = "";
              display = numberOne+" "+lastoperator+" "+numberTwo;
            });
          }
          else if(!numberOne.isEmpty) {
            print(3);
            print(display);
            print(display.length);
            setState(() {
              numberOne = numberOne.substring(0, numberOne.length - 1);
              display = numberOne+" "+lastoperator+" "+numberTwo;
            });
            print(display);
          }
          break;
      }

  }
  double Calc(num numberOne, num numberTwo, String operators){
    num result;
    switch (operators) {
      case "+":
        result = numberOne + numberTwo;
        break;
      case "-":
        result = numberOne - numberTwo;
        break;
      case "*":
        result = numberOne * numberTwo ;
        break;
      case "/":
        result = numberOne / numberTwo;
        break;
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(3, 9, 23, 1),
      body: Container(
        margin: EdgeInsets.only(left: 5),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            MakeResultScreen(),
            Row(
              children: <Widget>[
                MakeDeleteButton(0,"C"),
                MakeDeleteButton(1,"Sil"),
              ],
            ),
            Row(
              children: <Widget>[
                MakeNumberButton("7"),
                MakeNumberButton("8"),
                MakeNumberButton("9"),
                MakeOperator("-"),
              ],
            ),Row(
              children: <Widget>[
                MakeNumberButton("4"),
                MakeNumberButton("5"),
                MakeNumberButton("6"),
                MakeOperator("+"),
              ],
            ),
            Row(
              children: <Widget>[
                MakeNumberButton("1"),
                MakeNumberButton("2"),
                MakeNumberButton("3"),
                MakeOperator("*"),
              ],
            ),Row(
              children: <Widget>[
                MakeZeroButton("0"),
                MakeOperator("="),
                MakeOperator("/"),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget MakeNumberButton(value){
    double width = MediaQuery.of(context).size.width-30;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
        onTap: (){
      changeNumber(value);
    },
    child:FadeAnimation(1.5, Container(
      width: width/4,
      height: height/8,
      margin: EdgeInsets.only(left: 4,bottom: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      child:Container(
            width: 200,margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
           child: Text(value.toString(),style: TextStyle(color: Colors.black87.withOpacity(.7)),),
          ),
      ),
    )
    );
  }

  Widget MakeOperator(value){
    double width = MediaQuery.of(context).size.width-20;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
        onTap: (){
          changeOperators(value);
        },
        child:FadeAnimation(1.5, Container(
          width: width/4,
          height: height/8,
          margin: EdgeInsets.only(left: 4,bottom: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
          ),
          child:Container(
            width: 200,margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: Text(value.toString(),style: TextStyle(color: Colors.black87.withOpacity(.7)),),
          ),
        ),
        )
    );
  }


  Widget MakeZeroButton(value){
    double width = MediaQuery.of(context).size.width-20;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
      onTap: (){
        changeNumber(value);
      },
        child:FadeAnimation(1.5, Container(
          width: width/2,
          height: height/8,
          margin: EdgeInsets.only(left: 4,bottom: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
          ),
          child:Container(
            width: 200,margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: Text(value.toString(),style: TextStyle(color: Colors.black87.withOpacity(.7)),),
          ),
        ),
      )
    );
  }

  Widget MakeDeleteButton(value,name){
    double width = MediaQuery.of(context).size.width-20;
    double height = MediaQuery.of(context).size.height;
    return InkWell(
        onTap: (){
          delete(value);
        },
        child:FadeAnimation(1.5, Container(
          width: width/2,
          height: height/8,
          margin: EdgeInsets.only(left: 4,bottom: 5),
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white
          ),
          child:Container(
            width: 200,margin: EdgeInsets.only(bottom: 15),
            decoration: BoxDecoration(
              shape: BoxShape.rectangle,
            ),
            child: Text(name,style: TextStyle(color: Colors.black87.withOpacity(.7)),),
          ),
        ),
        )
    );
  }

  Widget MakeResultScreen(){
    double width = MediaQuery.of(context).size.width-20;
    double height = MediaQuery.of(context).size.height;
    return FadeAnimation(1.5, Container(
      width: width,
      height: height/4,
      margin: EdgeInsets.only(left: 4,bottom: 5),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white
      ),
      child:Container(
        width: 200,margin: EdgeInsets.only(bottom: 15),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
        ),
        child: TextField(
          enabled: false,
          textAlign: TextAlign.right,
          textAlignVertical: TextAlignVertical.bottom,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey.withOpacity(.8),fontSize: 40,),
              hintText: display.toString()
          ),
        ),
      ),
    ),
    );
  }
}
