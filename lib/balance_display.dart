import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

import './json_parse.dart';

// class BalanceDisplay extends StatelessWidget {
//   final AccountInfo accountInfo;

//   BalanceDisplay({Key key, this.accountInfo}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: InkWell(
//         child: Align(
//           alignment: Alignment(0.0, -0.6),
//           child: Container(
//             width: 170,
//             height: 170,
//             child: Align(
//               child: Text(
//                 accountInfo.balance.toString(),
//                 textAlign: TextAlign.center,
//                 style: TextStyle(
//                   color: Color(0xFF000000),
//                   fontSize: 25.0,
//                 ),
//               ),
//               alignment: Alignment.center,
//             ), 
//             decoration: BoxDecoration(
//               color: Color(0xffEBF5FB),
//               shape: BoxShape.circle,
//               boxShadow: <BoxShadow>[
//                 BoxShadow(
//                   color: Color(0x44000000),
//                   offset: Offset(1.0, 1.0),
//                   blurRadius: 4.0,
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

class BalanceDisplay extends StatefulWidget {

  final AccountInfo accountInfo;
  const BalanceDisplay({Key key, this.accountInfo}) : super(key: key);

  @override
  _BalanceDisplayState createState() => _BalanceDisplayState();
}

class _BalanceDisplayState extends State<BalanceDisplay> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        child: Align(
          alignment: Alignment(0.0, -0.6),
          child: Container(
            width: 170,
            height: 170,
            child: Align(
              child: Text(
                widget.accountInfo.balance.toString(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Color(0xFF000000),
                  fontSize: 25.0,
                ),
              ),
              alignment: Alignment.center,
            ), 
            decoration: BoxDecoration(
              color: Color(0xffEBF5FB),
              shape: BoxShape.circle,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Color(0x44000000),
                  offset: Offset(1.0, 1.0),
                  blurRadius: 4.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
