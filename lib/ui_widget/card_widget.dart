import 'package:e_commerce/assets/const.dart';
import 'package:e_commerce/page/add_salad_details.dart';
import 'package:flutter/material.dart';

import '../model/infomodel.dart';

class CardWidget extends StatefulWidget {
  final SaladModel infoModel; // Mark infoModel as final
  const CardWidget({super.key, required this.infoModel});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Wrap(children: [
        Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(Const.fav)),
                Center(
                  child: SizedBox(
                    width: 100,
                    height: 100,
                    child: ClipOval(
                      child: Image.asset(
                        fit: BoxFit.cover,
                        widget.infoModel.saladImage,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(widget.infoModel.saladName),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.currency_rupee,
                          size: 20,
                          color: Const.hexToColor(Const.appColor),
                        ),
                        Text(widget.infoModel.saladPrice),
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddSaladDetails(
                                    saladImage: widget.infoModel.saladImage,
                                    saladName: widget.infoModel.saladName,
                                    saladPrice: widget.infoModel.saladPrice,
                                  ))),
                      child: SizedBox(
                        width: 25,
                        height: 25,
                        child: CircleAvatar(
                          backgroundColor: Const.hexToColor(Const.addbtnColor),
                          child: Icon(
                            Icons.add,
                            color: Const.hexToColor(Const.appColor),
                          ),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
