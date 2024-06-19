import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class TryAgainWidget extends StatefulWidget {
  final Widget child;
  final VoidCallback onTapTryAgain;
  const TryAgainWidget(
      {Key? key, required this.child, required this.onTapTryAgain})
      : super(key: key);

  @override
  State<TryAgainWidget> createState() => _TryAgainWidgetState();
}

class _TryAgainWidgetState extends State<TryAgainWidget> {
  @override
  Widget build(BuildContext context) {
    double heightLine = 0;
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Stack(
      alignment: Alignment.center,
      children: [
        Opacity(
          opacity: 0,
          child: WidgetSize(
            child: widget.child,
            onChange: (Size value) {
              setState(() {
                heightLine = value.height.toDouble();
                // logPrint("HEIGHT LINE : $heightLine");
              });
            },
          ),
        ),
        Positioned.fill(
            child: Container(
          color: Colors.grey[200],
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onTapTryAgain,
              child: Container(
                width: width,
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh_rounded),
                    Text("Try Again"),
                  ],
                ),
              ),
            ),
          ),
        ))
      ],
    );
  }
}

class WidgetSize extends StatefulWidget {
  final Widget child;
  final Function onChange;

  const WidgetSize({
    required this.onChange,
    required this.child,
  });

  @override
  _WidgetSizeState createState() => _WidgetSizeState();
}

class _WidgetSizeState extends State<WidgetSize> {
  @override
  Widget build(BuildContext context) {
    SchedulerBinding.instance!.addPostFrameCallback(postFrameCallback);
    return Container(
      key: widgetKey,
      child: widget.child,
    );
  }

  var widgetKey = GlobalKey();
  var oldSize;

  void postFrameCallback(_) {
    var context = widgetKey.currentContext;
    if (context == null) return;

    var newSize = context.size;
    if (oldSize == newSize) return;

    oldSize = newSize;
    widget.onChange(newSize);
  }
}
