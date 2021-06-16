import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'colors.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              "Here you go",
              style: Theme.of(context)
                  .textTheme
                  .subtitle2
                  .copyWith(color: Colors.black45, fontSize: 8),
            ),
            InkWell(
              onTap: () {},
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Your Profile",
                    style: Theme.of(context).textTheme.headline6.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                  ),
                  Icon(
                    Icons.keyboard_arrow_down,
                    color: primaryColor,
                    size: 30,
                  )
                ],
              ),
            )
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                      child: Container(
                    margin: EdgeInsets.symmetric(vertical: 5),
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue[100],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      onTap: () {},
                      child: Row(
                        children: [
                          Icon(Icons.search),
                          SizedBox(width: 10),
                          Text("Search Jobs"),
                        ],
                      ),
                    ),
                  )),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.filter_center_focus_sharp,
                      color: primaryColor,
                    ),
                  ),
                ],
              ),

              //categories
              SizedBox(height: 20),
              Text(
                "Job Types",
                style: Theme.of(context)
                    .textTheme
                    .headline6
                    .copyWith(fontWeight: FontWeight.bold, fontSize: 15),
              ),
              Container(
                height: 90,
                child: ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    //physics: NeverScrollableScrollPhysics(),
                    itemCount: listCards.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Container(
                            padding: EdgeInsets.all(15),
                            margin: EdgeInsets.only(
                                top: 5, bottom: 2, right: 5, left: 8),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                              color: Colors.blue[50],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Image.asset(listCards[index].image),
                          ),
                          Text(
                            listCards[index].title,
                            style: Theme.of(context)
                                .textTheme
                                .headline6
                                .copyWith(
                                    fontWeight: FontWeight.bold, fontSize: 12),
                          )
                        ],
                      );
                    }),
              ),
              titleWidget(context, "Recent Opening"),
              Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 5,
                            blurRadius: 5)
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 210,
                        margin: EdgeInsets.only(bottom: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          image: DecorationImage(
                              image: AssetImage('assets/adv.jpg'),
                              fit: BoxFit.cover),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "ABC Company",
                          style: TextStyle(
                              color: primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Colors.deepOrange,
                            size: 12,
                          ),
                          Text(
                            "4.2",
                            style: TextStyle(color: Colors.black, fontSize: 10),
                          ),
                          Text(
                            "(12345 people reached)",
                            style: TextStyle(fontSize: 10),
                          ),
                          Text(
                            "     Location - Colombo-3",
                            style: TextStyle(fontSize: 10),
                          ),
                        ],
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }

  Text titleWidget(BuildContext context, String title) {
    return Text(title,
        style: Theme.of(context)
            .textTheme
            .headline6
            .copyWith(fontWeight: FontWeight.bold, fontSize: 15));
  }
}

class TypeModel {
  String image = "", title = "", remoteUrl = "";
  TypeModel(this.image, this.title, {this.remoteUrl});
}

List<TypeModel> listCards = [
  TypeModel("assets/demo/doctor.png", "Doctor",
      remoteUrl: 'assets/demo/doctor.png'),
  TypeModel("assets/demo/nurse.png", "Nurse",
      remoteUrl: 'assets/demo/nurse.png'),
  TypeModel("assets/demo/employee.png", "Engineer",
      remoteUrl: 'assets/demo/employee.png'),
  TypeModel("assets/demo/engineer.png", "Civil",
      remoteUrl: 'assets/demo/engineer.png'),
  TypeModel("assets/demo/businessman.png", "Business",
      remoteUrl: 'assets/demo/businessman.png'),
  TypeModel("assets/demo/baker.png", "Baker",
      remoteUrl: 'assets/demo/baker.png'),
  TypeModel("assets/demo/agriculture.png", "Surveyor",
      remoteUrl: 'assets/demo/agriculture.png'),
  TypeModel("assets/demo/soldier.png", "Police",
      remoteUrl: 'assets/demo/soldier.png'),
];
