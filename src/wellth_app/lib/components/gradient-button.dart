import 'package:flutter/material.dart';

class MyGradientbutton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool isLoading;

  const MyGradientbutton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final gradient = const LinearGradient(
      colors: [Colors.blue, Colors.purple, Colors.orange],
    );
    final gradient2 = const LinearGradient(
      colors: [Color.fromARGB(255, 240, 80, 59), Colors.purple, Colors.blue],
    );

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      
      child: Container(

        height:30,
        width: 87,
        decoration: BoxDecoration(
          gradient: gradient2,
          borderRadius: BorderRadius.circular(9.5),
          boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            offset: const Offset(0, 3),
            blurRadius: 4,
            spreadRadius: 1,
          ),
        ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              : Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                  ),
                ),
                
        ),
      ),
    );
  }
}

/*import 'package:flutter/material.dart';

class MyGradientbutton extends StatelessWidget {
  final Function()? onTap;
  final String text;
  final bool isLoading;

  const MyGradientbutton({
    super.key,
    required this.onTap,
    required this.text,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final gradient2 = const LinearGradient(
      colors: [Color.fromARGB(255, 240, 80, 59), Colors.purple, Colors.blue],
    );

    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: 25,
        width: 87,
        decoration: BoxDecoration(
          gradient: gradient2,
          borderRadius: BorderRadius.circular(7),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              offset: const Offset(2, 3),
              blurRadius: 4,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 0,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
                  ),
                )
              : Stack(
                  children: [
                    // Text stroke (outline)
                    Text(
                      text,
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    // Text fill + shadow
                    Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Inter',
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        shadows: [
                          Shadow(
                            color: Colors.black.withOpacity(0.5),
                            offset: const Offset(1, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}*/

