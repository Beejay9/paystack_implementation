import 'package:flutter/material.dart';
import 'package:internship/screens/resume_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  void contactDetails(BuildContext context) {
    showDialog(
      context: context,
      builder: ((context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: SizedBox(
            height: 250,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text('WhatsApp: +2348080292475'),
                  const Text('Facebook: Ibrahim Omobolaji Baruwa'),
                  const Text('Twitter: @omobolajibaruwa'),
                  const Text('E-mail: omobolajibaruwa@gmail.com'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    style:
                        ElevatedButton.styleFrom(shape: const StadiumBorder()),
                    child: const Text('Close'),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 110.0),
          child: isLandscape
              ? SingleChildScrollView(
                  child: Column(
                    children: [
                      const CircleAvatar(
                        radius: 100,
                        backgroundImage: AssetImage('asset/hng.jpg'),
                        // child: Image.asset('', fit: BoxFit.contain),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Ibrahim Omobolaji Baruwa',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'Flutter developer',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Text(
                          'I build beautiful and responsive flutter apps',
                          style: TextStyle(fontSize: 17),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              fixedSize: const Size(150, 50),
                            ),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(ResumeScreen.routeName);
                            },
                            child: const Text(
                              'Resume',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: const StadiumBorder(),
                              fixedSize: const Size(150, 50),
                            ),
                            onPressed: () => contactDetails(context),
                            child: const Text(
                              'Contact Me',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                )
              : Column(
                  children: [
                    const CircleAvatar(
                      radius: 100,
                      backgroundImage: AssetImage('asset/hng.jpg'),
                      // child: Image.asset('', fit: BoxFit.contain),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Ibrahim Omobolaji Baruwa',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'Flutter developer',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Text(
                        'I build beautiful and responsive flutter apps',
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            fixedSize: const Size(150, 50),
                          ),
                          onPressed: () {
                            Navigator.of(context)
                                .pushNamed(ResumeScreen.routeName);
                          },
                          child: const Text(
                            'Resume',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: const StadiumBorder(),
                            fixedSize: const Size(150, 50),
                          ),
                          onPressed: () => contactDetails(context),
                          child: const Text(
                            'Contact Me',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
