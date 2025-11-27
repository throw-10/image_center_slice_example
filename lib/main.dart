import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image CenterSlice Example',
      theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
      home: const MyHomePage(title: 'Image CenterSlice Example'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final directionNotifier = ValueNotifier<TextDirection>(TextDirection.ltr);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Theme.of(context).colorScheme.inversePrimary, title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 8.0,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('images/test.png'),
            Text('start: 3.3 \ntop: 2 \nbottom: 5.33 \nend: 6.7'),
            Text('width: 20 \nheight: 15'),
            Stack(
              children: [
                Image.asset('images/test.png'),
                PositionedDirectional(start: 3.3, top: 2, bottom: 5.33, end: 6.7, child: Placeholder(strokeWidth: 1)),
              ],
            ),
            ListenableBuilder(
              listenable: directionNotifier,
              builder: (context, child) => Directionality(textDirection: directionNotifier.value, child: child!),
              child: _buildDemoWidget(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final newValue = switch (directionNotifier.value) {
            TextDirection.ltr => TextDirection.rtl,
            TextDirection.rtl => TextDirection.ltr,
          };

          directionNotifier.value = newValue;
        },
        child: ListenableBuilder(listenable: directionNotifier, builder: (context, child) => Text(directionNotifier.value.name.toUpperCase())),
      ),
    );
  }

  Widget _buildDemoWidget() {
    return Container(
      padding: EdgeInsetsDirectional.only(
        start: 3.3,
        top: 2,
        bottom: 5.33,
        end: 6.7,
      ),
      decoration: BoxDecoration(
        image: DecorationImage(
          matchTextDirection: true,
          fit: BoxFit.fill,
          image: AssetImage('images/test.png'),
          centerSlice: Rect.fromLTWH(3.3, 2, 20, 15),
        ),
      ),
      child: _buildTextField(),
    );
  }

  Widget _buildTextField() {
    final textStyle = TextStyle(fontWeight: FontWeight.w500, fontSize: 11, height: 1.35, fontStyle: FontStyle.italic);
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: 20, minHeight: 15),
      child: IntrinsicWidth(
        child: TextField(
          decoration: InputDecoration.collapsed(
            hintText: 'input text here',
            hintStyle: textStyle.copyWith(color: Colors.white54),
          ),
          maxLines: 1,
          style: textStyle.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
