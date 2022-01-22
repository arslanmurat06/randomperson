import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:randomperson/features/cubit/user_cubit.dart';
import 'package:randomperson/models/user.dart';
import 'dart:html' as html;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromRGBO(21, 48, 75, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                constraints: const BoxConstraints(minWidth: 300, maxWidth: 500),
                padding: const EdgeInsets.only(top: 50),
                width: MediaQuery.of(context).size.width * 0.75,
                height: 500,
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(239, 103, 63, 0.8),
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: infoWrapper(),
              ),
              const SizedBox(
                height: 50,
              ),
              fetchButton(context),
              const SizedBox(
                height: 50,
              ),
              TextButton(
                  onPressed: () => html.window.open(
                      'https://github.com/arslanmurat06/randomperson',
                      "_blank"),
                  child: const Text("Source")),
              const FittedBox(
                child: Text(
                  "'\https://randomuser.me'\ api used to fetch random people",
                  style: TextStyle(color: Colors.white60),
                ),
              ),
            ],
          ),
        ));
  }

  Widget infoWrapper() {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) {
          if (state is UserLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is UserLoaded) {
            var user = state.user;
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: double.infinity,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.center,
                      alignment: WrapAlignment.spaceEvenly,
                      children: [profileImage(user), profileName(user)],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding:
                        const EdgeInsets.only(left: 70, top: 50, right: 20),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appText("Email"),
                              appText("Phone"),
                              appText("Country"),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              appText(': ${(user.email ?? "")}'),
                              appText(': ${(user.phone ?? "")}'),
                              appText(
                                  ': ${user.location!.country} / ${user.location!.state}')
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else if (state is UserError) {
            return Text("Error happened error is " + state.error);
          } else {
            return Container();
          }
        },
      ),
    );
  }

  Widget fetchButton(BuildContext context) {
    return InkWell(
      child: Container(
        padding: EdgeInsets.all(8),
        child: const Center(
            child: FittedBox(
          child: Text(
            "Fetch Random Person",
            style: TextStyle(color: Colors.white),
          ),
        )),
        width: 150,
        height: 50,
        decoration: BoxDecoration(
            color: const Color.fromRGBO(239, 103, 63, 0.8),
            borderRadius: BorderRadius.circular(10)),
      ),
      onTap: () => {BlocProvider.of<UserCubit>(context).getRandomUser()},
    );
  }

  Widget profileName(User user) {
    return Padding(
      padding: const EdgeInsets.only(right: 30.0),
      child: Text(
        '${user.name!.first} ${user.name!.last}',
        style: const TextStyle(color: Colors.white, fontSize: 30),
      ),
    );
  }

  Widget profileImage(User user) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Color.fromRGBO(21, 48, 75, 1),
            spreadRadius: 2,
            blurRadius: 7,
            offset: Offset(0, 3),
          ),
        ],
        borderRadius: BorderRadius.circular(100),
        image: DecorationImage(
            fit: BoxFit.fill, image: NetworkImage(user.picture!.large ?? "")),
      ),
    );
  }

  Widget appText(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 10.0),
        child: FittedBox(
          child: Text(
            text,
            style: const TextStyle(fontSize: 20, color: Colors.white),
          ),
        ),
      );
}
