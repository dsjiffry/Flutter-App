import 'package:flutter/material.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

/// This Helps reduce code duplication, I can easily generate widgets throughout my code.
mixin CustomWidgets {
  /// returns a Text Widget
  Widget getTextWidget(String text, double fontSize, int newLines,
      FontWeight fontWeight, Color color,
      {TextAlign textAlign: TextAlign.start}) {
    for (int i = 0; i < newLines; i++) {
      text = text + '\n';
    }
    return Text(
      text,
      style:
          TextStyle(fontWeight: fontWeight, color: color, fontSize: fontSize),
      textAlign: textAlign,
    );
  }

  /// returns an outlined button Widget
  Widget getOutlinedButton(
    String text,
    void Function() param1, {
    Color backgroundColor: Colors.transparent,
    Color borderColor: Colors.white70,
  }) {
    return OutlinedButton(
      onPressed: param1,
      style: OutlinedButton.styleFrom(
        primary: borderColor,
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor, width: 2),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.all(10.0),
        textStyle: TextStyle(
            color: Colors.white, fontSize: 15, fontStyle: FontStyle.normal),
      ),
      child: new Text(" " + text + " "),
    );
  }

  /// returns an Text Form Field Widget
  Widget getTextFormField(String text, IconData icon) {
    return TextFormField(
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: text,
        labelStyle: TextStyle(color: Colors.white),
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        focusedErrorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        fillColor: Colors.white,
        prefixIcon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }

  /// returns an Card Widget
  Widget getCard(String company, String description, String imageURL,
      String location, String rate, double rating, String title) {
    return Card(
        child: Column(children: <Widget>[
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
        Image.network(
          imageURL,
          height: 45,
          width: 45,
          fit: BoxFit.fitWidth,
        ),
        SmoothStarRating(
            allowHalfRating: true,
            onRated: (v) {},
            starCount: 5,
            rating: rating,
            size: 30.0,
            isReadOnly: true,
            color: Colors.yellow,
            borderColor: Colors.yellow,
            spacing: 0.0),
        getOutlinedButton('apply', () {}, borderColor: Colors.blue)
      ]),
      getTextWidget(title, 20, 0, FontWeight.bold, Colors.grey),
      getTextWidget(company, 15, 1, FontWeight.normal, Colors.grey),
      getTextWidget(rate, 20, 0, FontWeight.w300, Colors.grey),
      ExpansionTile(
        title:
            getTextWidget('Description', 15, 1, FontWeight.normal, Colors.grey),
        children: <Widget>[
          getTextWidget(description, 15, 0, FontWeight.normal, Colors.grey,
              textAlign: TextAlign.justify),
        ],
      ),
    ]));
  }
}
