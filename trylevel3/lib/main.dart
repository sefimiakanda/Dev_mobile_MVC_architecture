import 'package:flutter/material.dart';

void main() => runApp(const MonApplication());

/// Point d'entrée de l'application d'émissions de streaming.
class MonApplication extends StatelessWidget {
  const MonApplication({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'StreamWave',
        theme: ThemeData(useMaterial3: true, colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber.shade700)),
        home: const MapremierePage(),
      );
}

class Emission {
  const Emission({required this.tag, required this.nom, required this.chaine, required this.couleur, required this.icone});
  final String tag;
  final String nom;
  final String chaine;
  final Color couleur;
  final IconData icone;
}

const emissions = <Emission>[
  Emission(tag: 'matin', nom: 'Le Réveil', chaine: 'Radio Nova', couleur: Color(0xFFE85D4A), icone: Icons.wb_sunny_rounded),
  Emission(tag: 'news', nom: 'Que des news', chaine: 'Radio 4', couleur: Color(0xFF4056A1), icone: Icons.newspaper_rounded),
  Emission(tag: 'jazz', nom: 'Jazz & Chill', chaine: 'Jazz FM', couleur: Color(0xFF5C3D8A), icone: Icons.piano_rounded),
  Emission(tag: 'sport', nom: 'Le Grand Match', chaine: 'Sport Live', couleur: Color(0xFF198754), icone: Icons.sports_soccer_rounded),
  Emission(tag: 'culture', nom: 'Culture Club', chaine: 'France Arts', couleur: Color(0xFFC97713), icone: Icons.palette_rounded),
  Emission(tag: 'night', nom: 'Nuits Électriques', chaine: 'Pulse Radio', couleur: Color(0xFF9C27B0), icone: Icons.nightlife_rounded),
];

/// Page d'accueil : grille, navigation, recherche et favoris.
class MapremierePage extends StatefulWidget {
  const MapremierePage({super.key});
  @override
  State<MapremierePage> createState() => _MapremierePageState();
}

class _MapremierePageState extends State<MapremierePage> {
  final Set<String> _favoris = {};
  String _recherche = '';
  int _onglet = 0;

  @override
  Widget build(BuildContext context) {
    final visibles = emissions.where((e) => '${e.nom} ${e.chaine}'.toLowerCase().contains(_recherche.toLowerCase())).toList();
    final titre = switch (_onglet) { 1 => 'Recherche', 2 => 'Mon profil', _ => 'Vos émissions en streaming' };
    final grille = partieGrilleImage(emissions: visibles, favoris: _favoris, onFavori: _basculerFavori);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber.shade700,
        foregroundColor: Colors.black87,
        title: Text(titre),
        actions: [IconButton(tooltip: 'Mes favoris', icon: Badge(isLabelVisible: _favoris.isNotEmpty, label: Text('${_favoris.length}'), child: const Icon(Icons.favorite_border_rounded)), onPressed: () => setState(() => _onglet = 2)), const SizedBox(width: 4)],
      ),
      body: switch (_onglet) {
        1 => _Recherche(value: _recherche, onChanged: (v) => setState(() => _recherche = v), child: grille),
        2 => _Profil(favoris: emissions.where((e) => _favoris.contains(e.tag)).toList(), onFavori: _basculerFavori),
        _ => grille,
      },
      bottomNavigationBar: NavigationBar(
        selectedIndex: _onglet,
        onDestinationSelected: (index) => setState(() => _onglet = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Accueil'),
          NavigationDestination(icon: Icon(Icons.search), label: 'Recherche'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }

  void _basculerFavori(Emission emission) => setState(() => _favoris.contains(emission.tag) ? _favoris.remove(emission.tag) : _favoris.add(emission.tag));
}

class _Recherche extends StatelessWidget {
  const _Recherche({required this.value, required this.onChanged, required this.child});
  final String value;
  final ValueChanged<String> onChanged;
  final Widget child;
  @override
  Widget build(BuildContext context) => Column(children: [
        Padding(padding: const EdgeInsets.fromLTRB(16, 16, 16, 4), child: TextField(autofocus: true, onChanged: onChanged, decoration: const InputDecoration(prefixIcon: Icon(Icons.search), hintText: 'Rechercher une émission', border: OutlineInputBorder()))),
        Expanded(child: child),
      ]);
}

class _Profil extends StatelessWidget {
  const _Profil({required this.favoris, required this.onFavori});
  final List<Emission> favoris;
  final ValueChanged<Emission> onFavori;
  @override
  Widget build(BuildContext context) => favoris.isEmpty
      ? const Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Icon(Icons.favorite_outline, size: 54), SizedBox(height: 12), Text('Aucun favori pour le moment')]))
      : partieGrilleImage(emissions: favoris, favoris: favoris.map((e) => e.tag).toSet(), onFavori: onFavori);
}

/// Grille adaptative : le nombre de colonnes dépend de l'espace disponible.
class partieGrilleImage extends StatelessWidget {
  const partieGrilleImage({super.key, required this.emissions, required this.favoris, required this.onFavori});
  final List<Emission> emissions;
  final Set<String> favoris;
  final ValueChanged<Emission> onFavori;
  @override
  Widget build(BuildContext context) {
    if (emissions.isEmpty) return const Center(child: Text('Aucune émission trouvée.'));
    return LayoutBuilder(builder: (context, constraints) {
      final colonnes = (constraints.maxWidth / 190).floor().clamp(2, 4);
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: colonnes, mainAxisSpacing: 16, crossAxisSpacing: 16, childAspectRatio: .75),
        itemCount: emissions.length,
        itemBuilder: (context, index) => IdentificationStreaming(emission: emissions[index], estFavori: favoris.contains(emissions[index].tag), onFavori: () => onFavori(emissions[index])),
      );
    });
  }
}

/// Carte réutilisable, avec transition Hero vers le détail.
class IdentificationStreaming extends StatelessWidget {
  const IdentificationStreaming({super.key, required this.emission, required this.estFavori, required this.onFavori});
  final Emission emission;
  final bool estFavori;
  final VoidCallback onFavori;
  @override
  Widget build(BuildContext context) => Card(
        clipBehavior: Clip.antiAlias,
        elevation: 4,
        child: InkWell(
          onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => AlbumStreaming(emission: emission))),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: Hero(tag: emission.tag, child: _VisuelEmission(emission: emission))),
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 10, 6, 10),
              child: Row(children: [
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [Text(emission.nom, maxLines: 1, overflow: TextOverflow.ellipsis, style: Theme.of(context).textTheme.titleMedium), Text(emission.chaine, style: Theme.of(context).textTheme.bodySmall)])),
                IconButton(onPressed: onFavori, icon: Icon(estFavori ? Icons.favorite : Icons.favorite_border, color: estFavori ? Colors.red : null)),
              ]),
            ),
          ]),
        ),
      );
}

class _VisuelEmission extends StatelessWidget {
  const _VisuelEmission({required this.emission});
  final Emission emission;
  @override
  Widget build(BuildContext context) => Container(color: emission.couleur, alignment: Alignment.center, child: Icon(emission.icone, color: Colors.white, size: 68));
}

/// Fiche détaillée et liste des diffusions récentes d'une émission.
class AlbumStreaming extends StatelessWidget {
  const AlbumStreaming({super.key, required this.emission});
  final Emission emission;
  @override
  Widget build(BuildContext context) {
    const diffusions = [('Aujourd’hui', '42 min'), ('Hier', '38 min'), ('12 août 2026', '51 min')];
    return Scaffold(
      appBar: AppBar(title: Text(emission.nom)),
      body: ListView(padding: const EdgeInsets.all(20), children: [
        AspectRatio(aspectRatio: 1.5, child: Hero(tag: emission.tag, child: ClipRRect(borderRadius: BorderRadius.circular(24), child: _VisuelEmission(emission: emission)))),
        const SizedBox(height: 20), Text(emission.nom, style: Theme.of(context).textTheme.headlineMedium), Text(emission.chaine, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: emission.couleur)),
        const SizedBox(height: 24), Text('Diffusions récentes', style: Theme.of(context).textTheme.titleLarge), const SizedBox(height: 8),
        ...diffusions.map((d) => Card(child: ListTile(leading: IconButton(onPressed: () => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Lecture de ${emission.nom}'))), icon: const Icon(Icons.volume_up_rounded)), title: Text(d.$1), trailing: Text(d.$2)))),
      ]),
    );
  }
}
