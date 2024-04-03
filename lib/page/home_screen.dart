import 'package:e_commerce/assets/const.dart';
import 'package:e_commerce/ui_widget/card_widget.dart';
import 'package:flutter/material.dart';

import '../model/infomodel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Image.asset(Const.menu),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Image.asset(Const.cart),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Helow AHMED, What fruit salad \ncombo do you want today?",
                style: Const.headerText,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Container(
                      decoration: BoxDecoration(
                          color: Const.hexToColor(Const.editTextColor),
                          borderRadius: BorderRadius.circular(10)),
                      child: SizedBox(
                        height: 60,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Center(
                            child: TextFormField(
                              decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: Const.searchHint,
                                  hintStyle: Const.sub_headerText,
                                  prefixIcon:
                                      Icon(Icons.search, color: Colors.grey)),
                              controller: _textEditingController,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Image.asset(Const.setting),
                  )
                ],
              ),
              const SizedBox(height: 15),
              const Text(
                Const.recommend,
                style: Const.h1HeaderText,
              ),
              _buildAllProduct(),
            ]),
      ),
    );
  }

  _buildAllProduct() => GridView.builder(
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemCount: MyInfoModel.myInfoAllList.length,
        itemBuilder: (context, index) {
          final allItem = MyInfoModel.myInfoAllList[index];

          return CardWidget(infoModel: allItem);
        },
      );
}
