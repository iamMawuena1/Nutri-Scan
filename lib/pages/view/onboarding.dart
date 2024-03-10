import 'package:flutter/material.dart';
import 'package:nutriscan_app/pages/screens/intro_page1.dart';
import 'package:nutriscan_app/pages/screens/intro_page2.dart';
import 'package:nutriscan_app/pages/screens/intro_page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  //controller to keep track of pages
  PageController controller = PageController();

  //keep track of last page
  bool isLastPage = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF860D9A),
      body: Stack(
        children: [
          //page view
          PageView(
            controller: controller,
            onPageChanged: (index) {
              setState(() {
                isLastPage = (index == 2);
              });
            },
            children: const [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),
          //page indicator
          Container(
            alignment: const Alignment(0, 0.9),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.jumpToPage(2);
                  },
                  child: Text(
                    "Skip",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onPrimary,
                    ),
                  ),
                ),
                //dot indicator
                SmoothPageIndicator(
                  controller: controller,
                  count: 3,
                  effect: JumpingDotEffect(
                    activeDotColor: Theme.of(context).colorScheme.onPrimary,
                    dotColor: Colors.grey,
                    dotHeight: 20,
                    dotWidth: 20,
                    spacing: 10,
                    jumpScale: 2,
                    verticalOffset: 10,
                  ),
                ),
                // next / done
                isLastPage
                    ? GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text(
                          "Done",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeIn,
                          );
                        },
                        child: Text(
                          "Next",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimary,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
