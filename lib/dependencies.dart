import 'package:circular_countdown_timer/circular_countdown_timer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_emoji_feedback/flutter_emoji_feedback.dart';
import 'package:flutter_card_swiper/flutter_card_swiper.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

void main() {
  runApp(const ExampleApp());
}

class ExampleApp extends StatelessWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Example App', home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final emojiPresets = {
  'notoAnimatedEmojis': notoAnimatedEmojis,
  'classicEmojiPreset': classicEmojiPreset,
  'threeDEmojiPreset': threeDEmojiPreset,
  'handDrawnEmojiPreset': handDrawnEmojiPreset,
};

class _HomePageState extends State<HomePage> {
  int? rating;
  final CountDownController _countDownController = CountDownController();
  final List<String> _fruits = const [
    'Apple',
    'Banana',
    'Orange',
    'Grapes',
    'Mango',
  ];
  final CardSwiperController _cardSwiperController = CardSwiperController();
  final List<Widget> _cards = const [
    _DestinationCard(
      title: 'Santorini, Greece',
      description:
          'Whitewashed villages and unreal sunsets over the Aegean Sea.',
      imageUrl:
          'https://images.unsplash.com/photo-1505739773434-d818d0a2ab32?auto=format&fit=crop&w=800&q=80',
    ),
    _DestinationCard(
      title: 'Kyoto, Japan',
      description:
          'Ancient temples, tranquil gardens, and seasonal color bursts.',
      imageUrl:
          'https://images.unsplash.com/photo-1472214103451-9374bd1c798e?auto=format&fit=crop&w=800&q=80',
    ),
    _DestinationCard(
      title: 'Cusco, Peru',
      description:
          'Gateway to Machu Picchu with rich Incan and Spanish history.',
      imageUrl:
          'https://images.unsplash.com/photo-1519681393784-d120267933ba?auto=format&fit=crop&w=800&q=80',
    ),
  ];
  List<String> _selectedFruits = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              Card(
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Places to travel next',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      AspectRatio(
                        aspectRatio: 3 / 4,
                        child: CardSwiper(
                          controller: _cardSwiperController,
                          cardsCount: _cards.length,
                          onSwipe: (previousIndex, currentIndex, direction) {
                            ScaffoldMessenger.of(context)
                              ..clearSnackBars()
                              ..showSnackBar(
                                SnackBar(
                                  content: Text('Swiped ${direction.name}!'),
                                ),
                              );
                            return true;
                          },
                          cardBuilder: (context, index, percentX, percentY) =>
                              _cards[index],
                        ),
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        children: [
                          ElevatedButton(
                            onPressed: () => _cardSwiperController.swipe(
                              CardSwiperDirection.right,
                            ),
                            child: const Text('Swipe Next'),
                          ),
                          ElevatedButton(
                            onPressed: _cardSwiperController.undo,
                            child: const Text('Undo'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Quick Workout Timer',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      CircularCountDownTimer(
                        duration: 15,
                        initialDuration: 0,
                        controller: _countDownController,
                        width: MediaQuery.sizeOf(context).width * 0.4,
                        height: MediaQuery.sizeOf(context).width * 0.4,
                        ringColor: Colors.grey.shade300,
                        fillColor: Theme.of(context).colorScheme.primary,
                        backgroundColor: Theme.of(
                          context,
                        ).colorScheme.primary.withOpacity(0.1),
                        strokeWidth: 12,
                        strokeCap: StrokeCap.round,
                        textStyle: Theme.of(context).textTheme.headlineMedium
                            ?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                        textFormat: CountdownTextFormat.S,
                        isReverse: true,
                        autoStart: false,
                        onComplete: () {
                          ScaffoldMessenger.of(context)
                            ..clearSnackBars()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('Workout complete!'),
                              ),
                            );
                        },
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        children: [
                          ElevatedButton(
                            onPressed: _countDownController.start,
                            child: const Text('Start'),
                          ),
                          ElevatedButton(
                            onPressed: _countDownController.pause,
                            child: const Text('Pause'),
                          ),
                          ElevatedButton(
                            onPressed: _countDownController.resume,
                            child: const Text('Resume'),
                          ),
                          ElevatedButton(
                            onPressed: _countDownController.restart,
                            child: const Text('Restart'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                margin: const EdgeInsets.only(bottom: 24),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pick your favorite fruits',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      MultiSelectDialogField<String>(
                        items: _fruits
                            .map((fruit) => MultiSelectItem(fruit, fruit))
                            .toList(),
                        title: const Text('Fruits'),
                        buttonText: const Text('Select fruits'),
                        initialValue: _selectedFruits,
                        searchable: true,
                        onConfirm: (values) {
                          setState(() {
                            _selectedFruits = values;
                          });
                        },
                        chipDisplay: MultiSelectChipDisplay(
                          items: _selectedFruits
                              .map((fruit) => MultiSelectItem(fruit, fruit))
                              .toList(),
                          onTap: (value) {
                            setState(() {
                              _selectedFruits.remove(value);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ...emojiPresets.entries.map(
                (entry) => Column(
                  children: [
                    Text(entry.key),
                    EmojiFeedback(
                      initialRating: 3,
                      onChangeWaitForAnimation: true,
                      emojiPreset: entry.value,
                      labelTextStyle: Theme.of(context).textTheme.bodySmall
                          ?.copyWith(fontWeight: FontWeight.w400),
                      onChanged: (value) {
                        setState(() => rating = value);
                        // Show snackbar
                        ScaffoldMessenger.of(context)
                          ..clearSnackBars()
                          ..showSnackBar(SnackBar(content: Text('$value')));
                      },
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const Text("Custom preset builder"),
                  EmojiFeedback(
                    initialRating: 3,
                    onChangeWaitForAnimation: true,
                    presetBuilder: (p0, p1, p2) => const Icon(Icons.star),
                    labelTextStyle: Theme.of(context).textTheme.bodySmall
                        ?.copyWith(fontWeight: FontWeight.w400),
                    onChanged: (value) {
                      setState(() => rating = value);
                      // Show snackbar
                      ScaffoldMessenger.of(context)
                        ..clearSnackBars()
                        ..showSnackBar(SnackBar(content: Text('$value')));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DestinationCard extends StatelessWidget {
  const _DestinationCard({
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  final String title;
  final String description;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Ink.image(
            image: NetworkImage(imageUrl),
            fit: BoxFit.cover,
            child: const SizedBox.shrink(),
          ),
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black87],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Spacer(),
                Text(
                  title,
                  style: Theme.of(
                    context,
                  ).textTheme.headlineSmall?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 8),
                Text(
                  description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
