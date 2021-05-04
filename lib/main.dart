import 'package:flutter/material.dart';
import 'package:math_expressions/math_expressions.dart';
void main() {
  runApp(SimpleCalc());
}

class SimpleCalc extends StatefulWidget {
  @override
  _SimpleCalcState createState() => _SimpleCalcState();
}

class _SimpleCalcState extends State<SimpleCalc> {
  List<String>buttons =
  [
    'C','Del','%','/',
    '9','8','7','*',
    '6','5','4','-',
    '3','2','1','+',
    '0','.','Ans','=',


  ];
  String input =' ';
  String output= 'output';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(

        body: Column(
          children: [
            Expanded(
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(height:70,),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(input)),
                        Align(
                            alignment: Alignment.bottomRight,
                            child: Text(output))
                      ],
                    ),
                  ),
            )),
            Expanded(
                flex: 2,
                child: GridView.builder(
                    itemCount: 20,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4),
                    itemBuilder: (context, index)

                    {
                      return

                       Padding(
                          padding: const EdgeInsets.all(8.0),
                          child:
                          InkWell(
                            onTap: ()
                            {

                              if(index ==0)
                              {
                                setState(() {
                                  input='';
                                  output='';
                                });
                              }
                              else if(index ==1)
                              {
                                setState(() {
                                  input =input.substring(0,input.length-1);
                                });
                              }
                              else if(buttons[index]=='Ans')
                              {
                                setState(() {
                                  input =output;
                                });
                              }
                              else if(isOperator(buttons[index]))
                              {
                                if(input.endsWith('*')||
                                    input.endsWith('+')||
                                    input.endsWith('-')||
                                    input.endsWith('/')||
                                    input.endsWith('%'))
                                {
                                  print('No Operator');
                                }
                                else if(buttons[index]== '=')
                                {
                              try
                              {
                                Expression exp =Parser().parse(input);
                                double result =exp.evaluate(EvaluationType.REAL,
                                    ContextModel());

                                setState(() {
                                  output =result.toString();
                                });
                              }
                              catch(error)
                              {
                                print(error);
                                print(input);
                              }

                                }

                                else{
                                  setState(() {
                                    input =input+buttons[index];
                                  });
                                }
                              }

                              else{
                                setState(() {
                                  input =input+buttons[index];
                                });
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),

                                color: contColor(buttons[index])
                              ),
                              child:
                              Center(child:
                              Text(buttons[index],style: TextStyle(fontSize: 20
                              ,color: textColor(buttons[index])
                              ),)),
                            ),
                          ),
                        );
                    })),
          ],
        ),
      ),
    );
  }

  bool isOperator(String button)
  {
    if(button == '%'||button == '/'||
        button == '-'||button == '+'||
        button == '*'||button == '=')
    {
      return true;
    }
    else
    {
      return false;

    }
  }
Color contColor(String button)
{
if(button =='C')
{
  return Colors.green;
}
else if(button == 'Del')
{
  return Colors.red;
}
else if(isOperator(button) ==true)
{
  return Colors.blue;
}

else
  {
    return Colors.grey[300];
  }
}
Color textColor(String button)
{
if(isOperator(button) ==true || button=='C'||button=='Del')
{
  return Colors.white;
}
else
  {
    return Colors.black;
  }
}



}
