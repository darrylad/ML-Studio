import 'package:flutter/material.dart';
import 'package:graphical_model_interface/pages/createnew.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 500,
            child: Column(
              children: [
                const SizedBox(height: 100),
                const Text("Models",
                    style:
                        TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                const SizedBox(height: 16),
                ListTile(
                  title: const Text('Create New'),
                  leading: const Icon(Icons.add),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CreateNew()));
                  },
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text('Model $index'),
                      onTap: () {},
                    );
                  },
                ),
                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
