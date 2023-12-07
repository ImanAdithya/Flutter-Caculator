import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Widget calcbutton(String btnText, Color btnColor, Color txtColor) {
    return Container(
        width: 82.0,
        height: 82.0,
        child: FloatingActionButton(
          onPressed: () {
            calculation(btnText);
          },
          backgroundColor: btnColor, // Change the color to your desired color
          shape: CircleBorder(),
          child: Text(
            btnText,
            style: TextStyle(fontSize: 25, color: txtColor),

          ),
        )
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    '$text',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 100, color: Colors.white),
                  ),
                ),
              ],
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton("AC", Colors.grey, Colors.black),
                calcbutton("+/-", Colors.grey, Colors.black),
                calcbutton("%", Colors.grey, Colors.black),
                calcbutton("/", Colors.amber[700]!, Colors.white),
              ],
            ),

            SizedBox(height: 13,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton("7", Colors.grey[850]!, Colors.white),
                calcbutton("8", Colors.grey[850]!, Colors.white),
                calcbutton("9", Colors.grey[850]!, Colors.white),
                calcbutton("x", Colors.amber[700]!, Colors.white),
              ],
            ),

            SizedBox(height: 13,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton("4", Colors.grey[850]!, Colors.white),
                calcbutton("5", Colors.grey[850]!, Colors.white),
                calcbutton("6", Colors.grey[850]!, Colors.white),
                calcbutton("-", Colors.amber[700]!, Colors.white),
              ],
            ),

            SizedBox(height: 13,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                calcbutton("1", Colors.grey[850]!, Colors.white),
                calcbutton("2", Colors.grey[850]!, Colors.white),
                calcbutton("3", Colors.grey[850]!, Colors.white),
                calcbutton("+", Colors.amber[700]!, Colors.white),
              ],
            ),

            SizedBox(height: 13,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: 180,
                  height: 72,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(32.0),
                    // Adjust the radius as needed
                    child: FloatingActionButton(
                      onPressed: () {
                        // TODO: Add your onPressed logic here
                      },
                      backgroundColor: Colors.grey[850]!,
                      // Change the color to your desired color
                      child: Text(
                        "0",
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                calcbutton(".", Colors.grey[850]!, Colors.white),
                calcbutton("=", Colors.amber[700]!, Colors.white),
              ],
            ),
          ],
        ),
      ),
    );
  }



  //Calculator logic
  dynamic text ='0';
  double numOne = 0;
  double numTwo = 0;

  dynamic result = '';
  dynamic finalResult = '';
  dynamic opr = '';
  dynamic preOpr = '';
  void calculation(btnText) {


    if(btnText  == 'AC') {
      text ='0';
      numOne = 0;
      numTwo = 0;
      result = '';
      finalResult = '0';
      opr = '';
      preOpr = '';

    } else if( opr == '=' && btnText == '=') {

      if(preOpr == '+') {
        finalResult = add();
      } else if( preOpr == '-') {
        finalResult = sub();
      } else if( preOpr == 'x') {
        finalResult = mul();
      } else if( preOpr == '/') {
        finalResult = div();
      }

    } else if(btnText == '+' || btnText == '-' || btnText == 'x' || btnText == '/' || btnText == '=') {

      if(numOne == 0) {
        numOne = double.parse(result);
      } else {
        numTwo = double.parse(result);
      }

      if(opr == '+') {
        finalResult = add();
      } else if( opr == '-') {
        finalResult = sub();
      } else if( opr == 'x') {
        finalResult = mul();
      } else if( opr == '/') {
        finalResult = div();
      }
      preOpr = opr;
      opr = btnText;
      result = '';
    }
    else if(btnText == '%') {
      result = numOne / 100;
      finalResult = doesContainDecimal(result);
    } else if(btnText == '.') {
      if(!result.toString().contains('.')) {
        result = result.toString()+'.';
      }
      finalResult = result;
    }

    else if(btnText == '+/-') {
      result.toString().startsWith('-') ? result = result.toString().substring(1): result = '-'+result.toString();
      finalResult = result;

    }

    else {
      result = result + btnText;
      finalResult = result;
    }


    setState(() {
      text = finalResult;
    });

  }


  String add() {
    result = (numOne + numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }

  String sub() {
    result = (numOne - numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String mul() {
    result = (numOne * numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }
  String div() {
    result = (numOne / numTwo).toString();
    numOne = double.parse(result);
    return doesContainDecimal(result);
  }


  String doesContainDecimal(dynamic result) {

    if(result.toString().contains('.')) {
      List<String> splitDecimal = result.toString().split('.');
      if(!(int.parse(splitDecimal[1]) > 0))
        return result = splitDecimal[0].toString();
    }
    return result;
  }

}