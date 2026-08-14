import 'package:flutter/material.dart';
import '../models/emission.dart';

class DetailPage extends StatelessWidget {
  final Emission emission;

  const DetailPage({Key? key, required this.emission}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${emission.nomStream} (${emission.chaineRadio})'),
        backgroundColor: Colors.amber,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 250,
            child: Hero(
              tag: emission.tagStream,
              child: Image.asset(
                emission.imageStream,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Diffusions programmées :',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: emission.diffusions.length,
              itemBuilder: (context, index) {
                final diffusion = emission.diffusions[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                  child: ListTile(
                    leading: const Icon(Icons.volume_up, color: Colors.amber),
                    title: Text('Date : ${diffusion.date}'),
                    subtitle: Text('Durée : ${diffusion.duree}'),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}