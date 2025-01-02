import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';

class SplitPage extends StatelessWidget {
  const SplitPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Navigate to HomePage after 3 seconds
     Future.delayed(Duration(seconds: 5), () {
      Navigator.pushNamed(context, '/homepage');
    });
    return Scaffold(
       body: Center(
        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
                SizedBox(
                height: 150,
                width: 150,
                child: Lottie.asset('assets/fire.json'),
             ),
            
             //gap between fire animation and text
             SizedBox(height: 20,),

             //text

              AnimatedTextKit(
                animatedTexts: [
                TypewriterAnimatedText(
                  'Consistency Tracker',
                  textStyle: GoogleFonts.lobster(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.tertiary, // Complementary color
                    letterSpacing: 2.0,
                    shadows: [
                      Shadow(
                        offset: Offset(3, 3),
                        blurRadius: 4,
                        color: Colors.grey.withOpacity(0.4),
                      ),
                    ],
                  ),
                  speed: const Duration(milliseconds: 100), // Typing speed
                ),
                    ],
                    totalRepeatCount: 1,
                    pause: const Duration(milliseconds: 500),
                    displayFullTextOnTap: true,
                    stopPauseOnTap: true,
              ),

              //gap between text and loading
              SizedBox(height: 50,),

      
             //loading Animation
             SizedBox(
              height: 300,
              width: 300,
              child: Lottie.asset('assets/consistency.json'),
             )



          ],
        )
       ),
    );
  }
}
