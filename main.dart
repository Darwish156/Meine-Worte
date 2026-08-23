import 'package:flutter/material.dart';

void main() => runApp(const MeineWorteApp());

class MeineWorteApp extends StatelessWidget {
  const MeineWorteApp({super.key});
  @override
  Widget build(BuildContext context) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meine Worte',
        theme: ThemeData(useMaterial3: true, colorSchemeSeed: const Color(0xFF109DA2)),
        home: const HomePage(),
      );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int mode = 0;
  final List<String> sentence = [];

  final speakItems = const [
    ('🥤', 'Getränke'), ('🍽️', 'Essen'), ('🛏️', 'Schlafen'), ('🚽', 'Toilette'),
    ('👩', 'Mama'), ('👨', 'Papa'), ('🏠', 'Rausgehen'), ('🤲', 'Bitte'),
  ];
  final feelings = const [
    ('😊', 'Glücklich'), ('😢', 'Traurig'), ('😡', 'Wütend'), ('😨', 'Ängstlich'),
    ('😴', 'Müde'), ('❤️', 'Ich liebe'),
  ];

  void add(String word) => setState(() => sentence.add(word));

  @override
  Widget build(BuildContext context) {
    final modes = [
      ('🗣️💬', 'Ich möchte sprechen'), ('😊', 'Ich zeige Gefühle'),
      ('🧩', 'Ich bilde Sätze'), ('🎮', 'Meine Aktivitäten'),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Meine Worte ❤️', style: TextStyle(fontWeight: FontWeight.w900)), actions: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.language)),
      ]),
      bottomNavigationBar: NavigationBar(selectedIndex: 0, onDestinationSelected: (_) {}, destinations: const [
        NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Start'),
        NavigationDestination(icon: Icon(Icons.history), label: 'Verlauf'),
        NavigationDestination(icon: Icon(Icons.bar_chart), label: 'Fortschritt'),
        NavigationDestination(icon: Icon(Icons.star_outline), label: 'Belohnungen'),
        NavigationDestination(icon: Icon(Icons.settings_outlined), label: 'Einstellungen'),
      ]),
      body: SafeArea(child: ListView(padding: const EdgeInsets.all(14), children: [
        Card(child: Padding(padding: const EdgeInsets.all(20), child: Column(children: const [
          Text('Hallo, Champion! 🌟', style: TextStyle(fontSize: 27, fontWeight: FontWeight.w900)),
          SizedBox(height: 6), Text('Was möchtest du heute sagen?', style: TextStyle(fontSize: 17, color: Colors.grey)),
        ]))),
        const SizedBox(height: 12),
        GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 110, crossAxisSpacing: 9, mainAxisSpacing: 9), itemCount: modes.length, itemBuilder: (_, i) => _ModeCard(emoji: modes[i].$1, text: modes[i].$2, active: mode == i, onTap: () => setState(() => mode = i))),
        const SizedBox(height: 14),
        if (mode == 0) _choices(speakItems) else if (mode == 1) _choices(feelings) else if (mode == 2) _sentenceBuilder() else _activities(),
        if (sentence.isNotEmpty) _sentenceCard(),
        const SizedBox(height: 14),
        Card(color: const Color(0xFFFFF7F7), child: Padding(padding: const EdgeInsets.all(16), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text('🔒 Meine Verhaltensweisen — Abonnenten', style: TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 6), const Text('Foto hinzufügen, eine private Elternnachricht aufnehmen und den Fortschritt begleiten.'),
          const SizedBox(height: 8), OutlinedButton(onPressed: () {}, child: const Text('Verhalten hinzufügen')),
        ]))),
      ])),
    );
  }

  Widget _choices(List<(String,String)> items) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(mode == 1 ? '😊 Ich zeige Gefühle' : '🗣️💬 Ich möchte sprechen', style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
    const SizedBox(height: 10), GridView.builder(shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, mainAxisExtent: 145, crossAxisSpacing: 10, mainAxisSpacing: 10), itemCount: items.length, itemBuilder: (_, i) => _ChoiceCard(emoji: items[i].$1, label: items[i].$2, onTap: () => add(items[i].$2))),
  ]);

  Widget _sentenceBuilder() => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    const Text('🧩 Ich bilde Sätze', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)), const SizedBox(height: 10),
    Wrap(spacing: 8, runSpacing: 8, children: ['Ich', 'möchte', 'Wasser', 'Saft', 'Essen', 'Bitte'].map((x) => ActionChip(label: Text(x), onPressed: () => add(x))).toList()),
  ]);

  Widget _activities() => const Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text('🎮 Meine Aktivitäten', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)), SizedBox(height: 10),
    Card(child: ListTile(leading: Text('🧩', style: TextStyle(fontSize: 32)), title: Text('Bilder zuordnen'), subtitle: Text('Lernen und spielen'))),
    Card(child: ListTile(leading: Text('⭐', style: TextStyle(fontSize: 32)), title: Text('Sammle Sterne'), subtitle: Text('Deine Fortschritte'))),
  ]);

  Widget _sentenceCard() => Card(color: const Color(0xFFEAF8F8), child: Padding(padding: const EdgeInsets.all(15), child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [const Text('🧩 Dein Satz', style: TextStyle(fontWeight: FontWeight.w900)), TextButton(onPressed: () => setState(sentence.clear), child: const Text('Löschen'))]),
    Text(sentence.join(' '), style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
    const SizedBox(height: 8), FilledButton.icon(onPressed: () {}, icon: const Icon(Icons.volume_up), label: const Text('Satz vorlesen')),
  ]));
}

class _ModeCard extends StatelessWidget { final String emoji, text; final bool active; final VoidCallback onTap; const _ModeCard({required this.emoji, required this.text, required this.active, required this.onTap}); @override Widget build(BuildContext c) => Card(color: active ? const Color(0xFFEAF9F9) : null, child: InkWell(borderRadius: BorderRadius.circular(16), onTap: onTap, child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [Text(emoji, style: const TextStyle(fontSize: 30)), const SizedBox(height: 5), Text(text, textAlign: TextAlign.center, style: const TextStyle(fontWeight: FontWeight.w800))])))); }
class _ChoiceCard extends StatelessWidget { final String emoji,label; final VoidCallback onTap; const _ChoiceCard({required this.emoji,required this.label,required this.onTap}); @override Widget build(BuildContext c)=>Card(child: InkWell(borderRadius: BorderRadius.circular(18),onTap:onTap,child:Center(child:Column(mainAxisSize:MainAxisSize.min,children:[Text(emoji,style:const TextStyle(fontSize:55)),const SizedBox(height:6),Text(label,style:const TextStyle(fontSize:17,fontWeight:FontWeight.w800))])))); }
