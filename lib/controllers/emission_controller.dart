import 'package:flutter/foundation.dart';
import '../models/emission.dart';
import '../models/diffusion.dart';

class EmissionController extends ChangeNotifier {
  final List<Emission> _emissions = [];

  List<Emission> get emissions => _emissions;

  EmissionController() {
    loadEmissions();
  }

  void loadEmissions() {
    _emissions.addAll([
      Emission(
        id: '1',
        tagStream: 'Streaming News',
        imageStream: 'assets/images/news.jpg',
        nomStream: 'Que des news',
        chaineRadio: 'Radio 4',
        diffusions: [
          Diffusion(date: '14 Août 2026 - 08:00', duree: '45 min'),
          Diffusion(date: '15 Août 2026 - 12:30', duree: '30 min'),
        ],
      ),
      Emission(
        id: '2',
        tagStream: 'Streaming Tech',
        imageStream: 'assets/images/tech.jpg',
        nomStream: 'Futur Numérique',
        chaineRadio: 'Radio Tech',
        diffusions: [
          Diffusion(date: '14 Août 2026 - 14:00', duree: '1h 15 min'),
          Diffusion(date: '16 Août 2026 - 18:00', duree: '50 min'),
        ],
      ),
      Emission(
        id: '3',
        tagStream: 'Streaming Music',
        imageStream: 'assets/images/music.jpg',
        nomStream: 'Global Grooves',
        chaineRadio: 'Radio Beats',
        diffusions: [
          Diffusion(date: '14 Août 2026 - 20:00', duree: '2h 00 min'),
          Diffusion(date: '17 Août 2026 - 21:30', duree: '1h 30 min'),
        ],
      ),
    ]);
    notifyListeners();
  }

  Emission onEmissionSelected(String id) {
    return _emissions.firstWhere((e) => e.id == id);
  }
}