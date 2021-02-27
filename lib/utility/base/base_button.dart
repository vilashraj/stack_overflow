import 'package:flutter/material.dart';


enum buttonType{
  rounded,
  icon,
  clickableText,
  simple,
  outlined,
  roundedOutlined,
  image
}

// ignore: must_be_immutable
class BaseButton extends StatefulWidget {

  buttonType type;
  String buttonTitle;
  GestureTapCallback onTap;
  Icon icon;
  EdgeInsets padding;
  bool onlyLabel;
  String imageUrl;
  Color color;

  BaseButton(this.buttonTitle,{@required this.onTap, this.type = buttonType.simple,this.padding,this.onlyLabel = false}):assert(type != buttonType.icon);
  BaseButton.icon(this.icon,{@required this.onTap}){
    this.type = buttonType.icon;
  }
  BaseButton.image(this.imageUrl,{@required this.onTap, this.color}){
    this.type = buttonType.image;
  }

  @override
  _BaseButtonState createState() => _BaseButtonState();
}

class _BaseButtonState extends State<BaseButton> {

  double kRoundedButtonRadius = 8.0;
  double kOutlinedButtonBorderWidth = 1.0;

  Color kBorderColor;
  Color kFillColor;
  Color kTextColor;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    kFillColor = Theme.of(context).primaryTextTheme.headline1.color;
    kBorderColor = Theme.of(context).primaryTextTheme.headline1.color;
    kTextColor = Theme.of(context).primaryTextTheme.headline1.color;

    switch(widget.type){

      case buttonType.rounded:  return getBaseButton();

      case buttonType.icon: return getIconButton();

      case buttonType.clickableText: return getClickableTextButton();

      case buttonType.simple: return getBaseButton();

      case buttonType.outlined: return getBaseButton();

      case buttonType.roundedOutlined: return getBaseButton();

      case buttonType.image: return getImageButton();
    }
    return Container();

  }

  Widget getBaseButton(){
    return Container(
      child: GestureDetector(
        onTap: (){
          widget.onTap();
        },
        child: Container(
          decoration: BoxDecoration(
              color: (widget.type == buttonType.outlined || widget.type == buttonType.roundedOutlined) ? Theme.of(context).backgroundColor :  kFillColor,
              border: Border.all(
                color: (widget.type == buttonType.outlined || widget.type == buttonType.roundedOutlined) ? kBorderColor : Colors.transparent,
                width: (widget.type == buttonType.outlined || widget.type == buttonType.roundedOutlined) ? kOutlinedButtonBorderWidth : 0.0,
              ),
              borderRadius: BorderRadius.all(
                  Radius.circular(widget.type == buttonType.rounded || widget.type == buttonType.roundedOutlined?kRoundedButtonRadius:0.0)
              )
          ),
          child: Padding(
            padding: widget.padding ?? EdgeInsets.all(16.0),
            child: Center(
                child: widget.onlyLabel ? Text(
                  widget.buttonTitle,
                  style: TextStyle(
                      fontSize: 16,
                      color: (widget.type == buttonType.outlined || widget.type == buttonType.roundedOutlined) ? kTextColor : Colors.white,
                      fontWeight: FontWeight.bold),
                )  : Text(
                  widget.buttonTitle,
                  style: TextStyle(
                      fontSize: 16,
                      color: (widget.type == buttonType.outlined || widget.type == buttonType.roundedOutlined) ? kTextColor : Colors.white,
                      fontWeight: FontWeight.bold),
                )),
          ),
        ),
      ),
    );
  }

  Widget getClickableTextButton(){
    return GestureDetector(
      onTap: (){
        widget.onTap();
      } ?? (){},
      child: Text(widget.buttonTitle),
    );
  }

  Widget getIconButton(){
    return IconButton(icon: widget.icon, onPressed: (){widget.onTap();} ?? (){});
  }

  Widget getImageButton(){
    return GestureDetector(
        child: Image.asset(
          widget.imageUrl,
          width: 28,
          height: 28,
          color:
          widget.color ?? Theme.of(context).accentColor ,
        ),
        onTap: (){widget.onTap();} ?? (){});

  }
}
