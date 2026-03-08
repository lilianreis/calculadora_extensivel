import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/calculator_display.dart';
import 'widgets/calculator_grid.dart';
import '../logic/calculator_engine.dart';

class CalculatorScreen extends StatelessWidget {
  const CalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Extensible Calculator',
          style: TextStyle(fontSize: 16),
        ),
        backgroundColor: Colors.blueGrey,
        toolbarHeight: 35,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CalculatorDisplay(),
              Consumer<CalculatorEngine>(
                builder: (context, engine, child) {
                  if (engine.state.isBhaskaraMode) {
                    String prompt = 'Δ: Enter A';
                    if (engine.state.bhaskaraA != null &&
                        engine.state.bhaskaraB == null) {
                      prompt = 'A = ${engine.state.bhaskaraA} | Enter B';
                    } else if (engine.state.bhaskaraA != null &&
                        engine.state.bhaskaraB != null) {
                      prompt =
                          'A = ${engine.state.bhaskaraA}, B = ${engine.state.bhaskaraB} | Enter C';
                    }
                    return Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 4,
                      ),
                      color: Colors.blueGrey.shade50,
                      child: Text(
                        prompt,
                        style: const TextStyle(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.right,
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
              const Divider(height: 1),
              const CalculatorGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
