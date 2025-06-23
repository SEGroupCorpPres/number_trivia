import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia/number_trivia_bloc.dart';

class TriviaControls extends StatefulWidget {
  const TriviaControls({super.key});

  @override
  State<TriviaControls> createState() => _TriviaControlsState();
}

class _TriviaControlsState extends State<TriviaControls> {
  TextEditingController _controller = TextEditingController();
  String inputString = '';

  @override
  void initState() {
    _controller = TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          controller: _controller,
          decoration: InputDecoration(border: OutlineInputBorder(), hintText: 'Input a number'),
          onChanged: (value) {
            inputString = value;
          },
          onFieldSubmitted: (_){
            getTriviaWithConcreteNumber();
          },
        ),
        Column(
          spacing: 10,
          children: [
            TextButton(
              onPressed: getTriviaWithConcreteNumber,
              style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).buttonTheme.colorScheme!.onPrimary,
                textStyle: Theme.of(context).textTheme.headlineMedium,
              ),
              child: Text('Search'),
            ),
            Wrap(
              children: [
                TextButton(
                  onPressed: getTriviaWithRandomTrivia,
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  ),
                  child: Text('random/trivia'),
                ),
                TextButton(
                  onPressed: getTriviaWithRandomYear,
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  ),
                  child: Text('random/year'),
                ),
                TextButton(
                  onPressed: getTriviaWithRandomDate,
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  ),
                  child: Text('random/date'),
                ),
                TextButton(
                  onPressed: getTriviaWithRandomMath,
                  style: TextButton.styleFrom(
                    backgroundColor: Theme.of(context).buttonTheme.colorScheme!.onSecondary,
                    textStyle: Theme.of(context).textTheme.headlineMedium,
                  ),
                  child: Text('random/math'),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  void getTriviaWithConcreteNumber() {
    _controller.clear();
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForConcreteNumber(inputString));
  }

  void getTriviaWithRandomYear() {
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomYear());
  }

  void getTriviaWithRandomDate() {
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomDate());
  }

  void getTriviaWithRandomTrivia() {
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomTrivia());
  }

  void getTriviaWithRandomMath() {
    BlocProvider.of<NumberTriviaBloc>(context).add(GetTriviaForRandomMath());
  }
}
