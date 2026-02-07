import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: SimpleAIPlanner(), debugShowCheckedModeBanner: false));

class SimpleAIPlanner extends StatefulWidget {
  const SimpleAIPlanner({super.key});

  @override
  State<SimpleAIPlanner> createState() => _SimpleAIPlannerState();
}

class _SimpleAIPlannerState extends State<SimpleAIPlanner> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _subject = '';
  int _confidence = 3;
  double _hours = 4.0;
  String? _generatedPlan;

  void _generate() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _generatedPlan = "AI Plan for $_name:\n\n"
            "Subject: $_subject (Confidence: $_confidence/5)\n"
            "Daily Goal: ${_hours.toInt()} hours\n\n"
            "Strategy: Focus on core fundamentals for 2 hours, "
            "followed by 1 hour of practice problems. "
            "Since your confidence is $_confidence, we've added extra review sessions.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('AI Study Planner'), backgroundColor: Colors.blueGrey),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Enter Study Details", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Student Name', border: OutlineInputBorder()),
                onSaved: (v) => _name = v ?? '',
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 15),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Subject Name', border: OutlineInputBorder()),
                onSaved: (v) => _subject = v ?? '',
                validator: (v) => v!.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 15),
              const Text("Confidence Level (1-5)"),
              Slider(
                value: _confidence.toDouble(),
                min: 1, max: 5, divisions: 4, label: '$_confidence',
                onChanged: (v) => setState(() => _confidence = v.toInt()),
              ),
              const Text("Daily Available Hours"),
              Slider(
                value: _hours,
                min: 1, max: 12, divisions: 11, label: '${_hours.toInt()}h',
                onChanged: (v) => setState(() => _hours = v),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _generate,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey, foregroundColor: Colors.white),
                child: const Text('Generate Adaptive Plan'),
              ),
              if (_generatedPlan != null) ...[
                const SizedBox(height: 30),
                Container(
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(color: Colors.blueGrey.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
                  child: Text(_generatedPlan!, style: const TextStyle(fontSize: 16)),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
