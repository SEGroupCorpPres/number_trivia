import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/bloc/number_trivia/number_trivia_bloc.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/loading_widget.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/message_display.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/trivi_display.dart';
import 'package:number_trivia/features/number_trivia/presentation/widgets/trivia_controls.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              spacing: 10,
              children: [
                BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                    if (state is Empty) {
                      return MessageDisplay(message: 'Start Searching');
                    } else if (state is LoadingNumberTriviaState) {
                      return LoadingWidget();
                    } else if (state is LoadedNumberTriviaState) {
                      return TriviaDisplay(trivia: state.trivia);
                    } else if (state is ErrorNumberTriviaState) {
                      return MessageDisplay(message: state.message);
                    }
                    return Container(height: MediaQuery.sizeOf(context).height / 3);
                  },
                ),
                TriviaControls(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
