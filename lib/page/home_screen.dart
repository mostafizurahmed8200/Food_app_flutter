import 'package:flutter/material.dart';
import 'package:food_apps/assets/const.dart';

import '../model/salad_model.dart';
import '../ui_widget/card_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  final TextEditingController _textEditingController = TextEditingController();
  late TabController _tabController;
  String? nameOfBuyer;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose the tab controller
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args != null) {
      nameOfBuyer = args.toString();
    }
  }

  final GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(); // Add GlobalKey

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        key: _scaffoldKey, // Assign GlobalKey to Scaffold
        drawer: Drawer(
          child: _navigationDrawerItem(context, nameOfBuyer),
        ),
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                _scaffoldKey.currentState?.openDrawer();
              },
              child: Image.asset(Const.menu),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: GestureDetector(
                child: Image.asset(Const.cart),
                onTap: () => Navigator.pushNamed(context, "/cartitempage"),
              ),
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hello $nameOfBuyer, What fruit salad \ncombo do you want today?",
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
                            padding:
                                const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Center(
                              child: TextFormField(
                                decoration: const InputDecoration(
                                    border: InputBorder.none,
                                    hintText: Const.searchHint,
                                    hintStyle: Const.subheaderText,
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
                Expanded(flex: 1, child: _buildAllProduct()),
                const SizedBox(height: 20),
                SizedBox(
                  height: 50,
                  child: TabBar(
                    controller: _tabController,
                    labelStyle: const TextStyle(
                        fontSize: 23,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                    unselectedLabelStyle:
                        const TextStyle(fontSize: 15, color: Colors.grey),
                    indicatorColor: Const.hexToColor(Const.appColor),
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: const [
                      Tab(
                        text: 'Hottest',
                      ),
                      Tab(text: 'Popular'),
                      Tab(text: 'New Combo'),
                      Tab(text: 'Top'),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      _buildAllProductTabs(),
                      _buildAllProductTabs(),
                      _buildAllProductTabs(),
                      _buildAllProductTabs(),
                    ],
                  ),
                ),
              ]),
        ),
      ),
    );
  }
}

//Products
_buildAllProduct() => GridView.builder(
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 1,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
    ),
    itemCount: MySaladModel.myInfoAllList.length,
    itemBuilder: (context, index) {
      final allItem = MySaladModel.myInfoAllList[index];

      return CardWidget(infoModel: allItem);
    },
    scrollDirection: Axis.horizontal);

// Tab Products
_buildAllProductTabs() => GridView.builder(
    shrinkWrap: true,
    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      mainAxisSpacing: 10.0,
      crossAxisSpacing: 10.0,
    ),
    itemCount: MySaladModel.myInfoAllList.length,
    itemBuilder: (context, index) {
      final allItem = MySaladModel.myInfoAllList[index];

      return CardWidget(infoModel: allItem);
    },
    scrollDirection: Axis.vertical);

_navigationDrawerItem(BuildContext context, String? nameOfBuyer) =>
    ListView(children: [
      Column(
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircleAvatar(
              child: Image.asset(
                Const.profilePic,
              ),
            ),
          ),
          Text(
            nameOfBuyer!,
            style: Const.h11HeaderText,
          ),
        ],
      ),
      const NaviGationButton(
        page: '/trackOrder',
        icons: Const.checked,
        text: 'Track Order',
        width: 30,
        height: 30,
      ),
      const NaviGationButton(
        page: '',
        icons: Const.favoriteFull,
        text: 'Favorite Salad',
        width: 30,
        height: 30,
      ),
      const NaviGationButton(
        page: '',
        icons: Const.checked,
        text: 'Track Order',
        width: 30,
        height: 30,
      ),
    ]);

class NaviGationButton extends StatelessWidget {
  final String text;
  final String icons;
  final double width, height;
  final String page;
  const NaviGationButton(
      {super.key,
      required this.text,
      required this.icons,
      required this.width,
      required this.height,
      required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, page);
        },
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          backgroundColor: MaterialStateProperty.all(Colors.white),
        ),
        child: ListTile(
          leading: Image.asset(
            icons,
            width: width,
            height: height,
          ),
          title: Text(
            text,
            style: Const.navTextStyle,
          ),
        ),
      ),
    );
  }
}
