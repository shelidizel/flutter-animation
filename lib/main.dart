import 'package:animations/animations.dart';
import 'package:flutter/material.dart';


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



class Page1 extends StatefulWidget {
  const Page1({super.key});

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> with TickerProviderStateMixin{

   late final AnimationController controller = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this);

   late final Animation<double> _animation;

      final Tween<double> _tween  = Tween(
      begin: 0.0,
      end: 1.0 );

    @override
  void initState() {
    _animation = _tween.animate(controller);
    controller.forward();
    super.initState();
  }
  Future pickdate(BuildContext context){
    
    return showDialog(
      context: context, 
      builder: (context){
        return FadeTransition(
          opacity: _animation,
          child: DatePickerDialog(
            initialDate: DateTime.now(), 
            firstDate: DateTime.now().subtract(Duration(days: 4000)), 
            lastDate: DateTime.now().add(Duration(days:  50))
            ),
        );
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.withOpacity(.4),
      body: Center(
        child: InkWell(
          onTap: (){
            pickdate(context);
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            color: Colors.deepPurple,
            ),
            child: FittedBox(fit: BoxFit.contain,
            child: Padding(
              padding: EdgeInsets.fromLTRB(24, 12, 24, 12),
              child: Text('Pick a date',
              style: TextStyle(
                color: Colors.white
              ),),),),
          ),
        )
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
class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

enum MusicFilterValues {All, Songs, Albums, Artists}

class _SearchPageState extends State<SearchPage> {

  MusicFilterValues selectedValue = MusicFilterValues.All;


  List<ButtonSegment<MusicFilterValues>> musicFilterButtons = [
    const ButtonSegment(
      value: MusicFilterValues.All,
      label: Text(
        'All'
      )),
    const ButtonSegment(
      value: MusicFilterValues.Songs,
      label: Text(
        'Songs'
      )),
    const ButtonSegment(
      value: MusicFilterValues.Albums,
      label: Text(
        'Albums'
      )),
    const ButtonSegment(
      value: MusicFilterValues.Artists,
      label: Text(
        'Artists'
      )),
  ];


  int selectedIdex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.withOpacity(.4),
      body:  SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SegmentedButton(
              segments: musicFilterButtons, 
              selected: <MusicFilterValues>{selectedValue},
              onSelectionChanged: (Set<MusicFilterValues> newSelection){
                setState(() {
                  selectedValue = newSelection.first;
                });
                Expanded(
                  child: Center(
                    child: IconButton(
                      onPressed: (){
                        Navigator.push(
                          context, 
                          MaterialPageRoute(
                            builder: (context) => Result()));
                      },
                      icon: Icon(
                        Icons.arrow_forward,
                        color: Colors.red,),),
                  ));
              },),
            Container(
              decoration: const BoxDecoration(
                color: Colors.blue
              ),
              child: Text(''),
            )
           ],),
      )
    );
  }

  
}

class Result extends StatelessWidget {
  const Result({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.withOpacity(.4),
      body: Center(
        child: Text('data'),
      ),
    );
  }
}


