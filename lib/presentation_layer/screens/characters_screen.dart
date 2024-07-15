import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rickandmorty/business_logic_layer/characters_cubit.dart';
import 'package:flutter_rickandmorty/constants/myColors.dart';
import 'package:flutter_rickandmorty/presentation_layer/widgets/charcter_item.dart';

import '../../data_layer/models/Characters.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  late List<Character> allCaracters;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allCaracters = BlocProvider.of<CharactersCubit>(context)
        .getAllCharacters()
        .cast<Character>();
  }

  Widget buildBlocWidget() {
    return BlocBuilder<CharactersCubit, CharactersState>(
      builder: (context, state) {
        if (state is CharactersLoaded) {
          allCaracters = (state).characters.cast<Character>();
          return buildLodedListWidgets();
        } else {
          return showLodingIndecator();
        }
      },
    );
  }

  Widget showLodingIndecator() {
    return Center(
      child: CircularProgressIndicator(
        color: MyColors.myYellow,
      ),
    );
  }

  Widget buildLodedListWidgets() {
    return SingleChildScrollView(
      child: Container(
        color: MyColors.myGrey,
        child: Column(
          children: [
            buildCharactersList(),
          ],
        ),
      ),
    );
  }

  Widget buildCharactersList() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 2 / 3,
          crossAxisSpacing: 1,
          mainAxisSpacing: 1),
      shrinkWrap: true,
      physics: const ClampingScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: allCaracters.length,
      itemBuilder: (context, index) {
        return CharacterItem(character: allCaracters[index],);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyColors.myYellow,
        title: Text(
          "Characters",
          style: TextStyle(
            color: MyColors.myGrey,
          ),
        ),
      ),
      body: buildBlocWidget(),
    );
  }
}
