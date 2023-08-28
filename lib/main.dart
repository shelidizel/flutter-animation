import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import '';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Material Transitions'),
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

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.add), label: 'add'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'search'),
  ];
  
  List<Widget> pages = [
    Page1(),
    SearchPage()
  ];
  
  
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageTransitionSwitcher(
        transitionBuilder: (widget, primaryAnim, secAnim){
          return SharedAxisTransition(
            animation: primaryAnim, 
            secondaryAnimation: secAnim, 
            transitionType: SharedAxisTransitionType.horizontal,
            child: widget,);
        },
        duration: Duration(milliseconds: 700),
        child: pages.elementAt(selectedIndex),),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (event){
          setState(() {
            selectedIndex = event;
          });
        },
        items: items),

      floatingActionButton: OpenContainer(
        openShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12)
        ),
        transitionType: ContainerTransitionType.fadeThrough,
        transitionDuration: const Duration(milliseconds: 500),
        closedShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15)
        ),
        openColor: Colors.white,
        closedBuilder: (context, _){
          return const FloatingActionButton(
            onPressed: null,
            backgroundColor: Colors.blue,
            child: Icon(Icons.add, color: Colors.white,),);
        },
        openBuilder: (context, action) => const Page2(),
        
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}



class Page1 extends StatelessWidget {
  const Page1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.withOpacity(.4),
      body: const Center(
        child: Text('data'),
      ),
    );
  }
}
class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.withOpacity(.4),
      body: const Center(
        child: Text('data'),
      ),
    );
  }
}
class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.withOpacity(.4),
      body: const Center(
        child: Text('data'),
      ),
    );
  }
}
