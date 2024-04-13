import 'package:flutter/material.dart';

import '../assets/const.dart';

class TrackOrderPage extends StatefulWidget {
  const TrackOrderPage({super.key});

  @override
  State<TrackOrderPage> createState() => _TrackOrderPageState();
}

class _TrackOrderPageState extends State<TrackOrderPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              color: Const.hexToColor(Const.appColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Const.mContainer,
                    ),
                  ),
                  const Text(
                    Const.deliveryStatus,
                    style: Const.h11HeaderTextWhite,
                  ),
                  GestureDetector(
                    onTap: () => Navigator.pushNamed(context, '/homescreen'),
                    child: const Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.home_sharp,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TrackOrderData(
                      img: Const.odertakenIcon,
                      text: 'Order Taken',
                      icon: Icons.check,
                      color: Colors.white,
                      colorCircle: Colors.green,
                    ),
                    SizedBox(
                      height: 50,
                      child: verticalDividers(),
                    ),
                    const TrackOrderData(
                      img: Const.oderPreparedIcon,
                      text: 'Order is being prepared',
                      icon: Icons.check,
                      color: Colors.white,
                      colorCircle: Colors.green,
                    ),
                    SizedBox(
                      height: 50,
                      child: verticalDividers(),
                    ),
                    TrackOrderData(
                      img: Const.orderDeliverIcon,
                      text: 'Order is being delivered',
                      icon: Icons.phone,
                      color: Colors.white,
                      colorCircle: Const.hexToColor(Const.appColor),
                    ),
                    SizedBox(
                      height: 50,
                      child: verticalDividers(),
                    ),
                    Image.asset(
                      Const.maps,
                    ),

                    SizedBox(
                      height: 50,
                      child: verticalDividers(),
                    ),
                    const TrackOrderData(
                      img: Const.checked,
                      text: 'Order Received',
                      icon: Icons.more_horiz,
                    ),

                    // Adjust height as needed
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget verticalDividers() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: VerticalDivider(
                color: Const.hexToColor(Const.appColor),
                thickness: 2,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Expanded(
              child: VerticalDivider(
                color: Const.hexToColor(Const.appColor),
                thickness: 2,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Expanded(
              child: VerticalDivider(
                color: Const.hexToColor(Const.appColor),
                thickness: 2,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Expanded(
              child: VerticalDivider(
                color: Const.hexToColor(Const.appColor),
                thickness: 2,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
            Expanded(
              child: VerticalDivider(
                color: Const.hexToColor(Const.appColor),
                thickness: 2,
              ),
            ),
            const SizedBox(
              height: 3,
            ),
          ],
        ),
      ),
    );
  }
}

class TrackOrderData extends StatelessWidget {
  final String img;
  final String text;
  final IconData icon;
  final Color? color;
  final Color? colorCircle;

  const TrackOrderData(
      {super.key,
      required this.img,
      required this.text,
      required this.icon,
      this.color,
      this.colorCircle});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Const.hexToColor(Const.transparentButton2Color),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ClipOval(
                    child: Image.asset(
                      img,
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Text(
                text,
                style: Const.h1HeaderText,
              ),
            ],
          ),
          CircleAvatar(
            backgroundColor: colorCircle,
            child: Icon(
              icon,
              color: color,
            ),
          )
        ],
      ),
    );
  }
}
