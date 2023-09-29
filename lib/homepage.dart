import 'package:can_animation_3d/clipper_widget.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  double position = 250;
  bool isPineappleEntry = false;
  bool isOrangeEntry = true;
  bool flag = false;
  bool isOrangeVisible = true;
  bool isPineappleVisible = false;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    final curve = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(curve);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: AnimatedBuilder(
          animation: _controller,
          builder: (context, _) {
            isOrangeVisible =
                isPineappleEntry && _animation.value == 1 ? false : true;
            isPineappleVisible = isOrangeVisible ? false : true;

            return Container(
              width: double.infinity,
              height: double.infinity,
              color: !isPineappleEntry
                  ? const Color.fromRGBO(228, 255, 192, 1)
                  : const Color.fromRGBO(255, 239, 218, 1),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: isPineappleEntry
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      width: screenSize.width * _animation.value,
                      height: double.infinity,
                      color: isPineappleEntry
                          ? const Color.fromRGBO(228, 255, 192, 1)
                          : const Color.fromRGBO(255, 239, 218, 1),
                    ),
                  ),
                  ClipPath(
                    clipper: ClipperWidget(),
                    child: Container(
                      color: Colors.amber,
                      width: 148,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.asset(
                            'assets/images/empty_can.png',
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            left: isPineappleEntry
                                ? position * (1 - _animation.value)
                                : position * _animation.value,
                            child: Image.asset(
                              'assets/images/pineapple_front_content.png',
                              width: 152,
                            ),
                          ),
                          Positioned(
                            left: isOrangeEntry
                                ? -position * (1 - _animation.value)
                                : -position * _animation.value,
                            child: Image.asset(
                              'assets/images/orange_front_content.png',
                              width: 152,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 180,
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          isPineappleEntry = !isPineappleEntry;
                          isOrangeEntry = !isOrangeEntry;
                          _controller
                            ..reset()
                            ..forward();
                        });
                      },
                      child: Container(
                        width: 150,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blueAccent,
                        ),
                        child: const Center(
                          child: Text('Click Me',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              )),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            );
          }),
    );
  }
}
