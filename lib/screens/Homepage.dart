import 'package:flutter/material.dart';
import 'package:practicamockapi/server/mockapi.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  String Ferrari = '';
  bool isLoading = false;
  late AnimationController _animationController;
  late Animation<double> _animation;
  double progressValue = 0.0;

  String Hyundai = '';
  bool isLoadingHyundai = false;
  late AnimationController _animationControllerHyundai;
  late Animation<double> _animationHyundai;

  bool isLoadingFisherPrice = false;
  String FisherPrice = '';
  late AnimationController _animationControllerFisher;
  late Animation<double> _animationFisher;
  @override
  void initState() {
    super.initState();
    _animationControllerFisher =
        AnimationController(vsync: this, duration: Duration(seconds: 10));
    _animationFisher = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationControllerFisher,
        curve: Curves.linear,
      ),
    );
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.linear,
      ),
    );

    _animationControllerHyundai = AnimationController(
      vsync: this,
      duration: Duration(seconds: 3),
    );
    _animationHyundai = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationControllerHyundai,
        curve: Curves.linear,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationControllerHyundai.dispose();
    _animationControllerFisher.dispose();
    super.dispose();
  }

  void startAnimation() {
    _animationController.reset();
    _animationController.forward().then((value) {
      setState(() {
        isLoading = false;
        _animationController.reset();
      });
    });
  }

  void startAnimationHyundai() {
    _animationControllerHyundai.reset();
    _animationControllerHyundai.forward().then((value) {
      setState(() {
        isLoadingHyundai = false;
        _animationControllerHyundai.reset();
      });
    });
  }
  void startAnimationFisher() {
    _animationControllerFisher.reset();
    _animationControllerFisher.forward().then((value) {
      setState(() {
        isLoadingFisherPrice = false;
        _animationControllerFisher.reset();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 16.0),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    
                    child: Text('By: Dennis David Anchundia, Alias: D4NTE', style: TextStyle(color: Colors.red, fontSize: 20, ),)),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                        Ferrari = '';
                      });

                      var api = await MockApi().getFerrariInteger();

                      setState(() {
                        Ferrari = api.toString();
                      });

                      startAnimation();
                    },
                    style: ElevatedButton.styleFrom(
                      shape: CircleBorder(),
                      primary: Colors.green,
                      padding: EdgeInsets.all(34.0),
                    ),
                    child: Icon(
                      Icons.flash_on,
                      color: Colors.black,
                      size: 36.0,
                    ),
                  ),
                  SizedBox(height: 16.0),
                  if (isLoading)
                    AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Container(
                          width: 200.0,
                          height: 20.0,
                          child: Stack(
                            children: [
                              Positioned(
                                left: (1.0 - _animation.value) * 100.0,
                                child: Container(
                                  width: _animation.value * 200.0,
                                  height: 10.0,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  if (!isLoading && Ferrari.isNotEmpty) Text(Ferrari, style: TextStyle(color: Colors.green, fontSize: 24),),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoadingHyundai = true;
                  Hyundai = '';
                });

                var api = await MockApi().getHyundaiInteger();

                setState(() {
                  Hyundai = api.toString();
                });

                startAnimationHyundai();
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                primary: Colors.orange,
                padding: EdgeInsets.all(34.0),
              ),
              child: Icon(
                Icons.airport_shuttle,
                color: Colors.black,
                size: 36.0,
              ),
            ),
            SizedBox(height: 16.0),
            if (isLoadingHyundai)
              AnimatedBuilder(
                animation: _animationHyundai,
                builder: (context, child) {
                  return Container(
                    width: 200.0,
                    height: 10.0,
                    child: Stack(
                      children: [
                        Positioned(
                          left: (1.0 - _animationHyundai.value) * 100.0,
                          child: Container(
                            width: _animationHyundai.value * 200.0,
                            height: 10.0,
                            color: Colors.orange,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            if (!isLoadingHyundai && Hyundai.isNotEmpty) Text(Hyundai, style: TextStyle(color: Colors.orange, fontSize: 24),),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                setState(() {
                  isLoadingFisherPrice = true;
                  FisherPrice = '';
                });

                var api = await MockApi().getFisherPriceInteger();

                setState(() {
                  FisherPrice = api.toString();
                });

                startAnimationFisher();
              },
              style: ElevatedButton.styleFrom(
                shape: CircleBorder(),
                primary: Colors.red,
                padding: EdgeInsets.all(34.0),
              ),
              child: Icon(
                Icons.directions_walk,
                color: Colors.black,
                size: 36.0,
              ),
            ),
            SizedBox(height: 16.0,),
            AnimatedBuilder(
              animation: _animationFisher,
              builder: (context, child) {
                return Container(
                  width: 200.0,
                  height: 10.0,
                  child: Stack(
                    children: [
                      Positioned(
                        left: (1.0 - _animationFisher.value) * 100.0,
                        child: Container(
                          width: _animationFisher.value * 200.0,
                          height: 10.0,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            SizedBox(height: 16.0),
            if (!isLoadingFisherPrice && FisherPrice.isNotEmpty)
              Text(FisherPrice, style: TextStyle(color: Colors.red, fontSize: 24),),
          ],
        ),
      ),
    );
  }
}
