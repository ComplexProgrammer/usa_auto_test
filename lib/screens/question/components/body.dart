import 'dart:async';
import 'dart:convert';
import 'dart:io';
// import 'dart:html';
import 'package:collection/collection.dart';
import 'package:animations/animations.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pagination/flutter_pagination.dart';
import 'package:flutter_pagination/widgets/button_styles.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:usa_auto_test/constants.dart';
import 'package:usa_auto_test/models/answer.dart';
import 'package:usa_auto_test/models/book.dart';
import 'package:usa_auto_test/models/question.dart';
import 'package:usa_auto_test/models/topic.dart';
import 'package:usa_auto_test/screens/ads/banner.dart';
import 'package:usa_auto_test/screens/ads/main.dart';
import 'package:usa_auto_test/screens/question/components/CustomRadio.dart';
import 'package:usa_auto_test/screens/question/components/backdrop.dart';
import 'package:usa_auto_test/screens/question/components/time.dart';
import 'package:usa_auto_test/screens/topic/topic_screen.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/group.dart';
import '../question_screen.dart';
import 'body.dart';

int togri_javoblar_soni = 0;
int notogri_javoblar_soni = 0;
int all_question = 0;
int time = 900;
int minutes = 15;
final seconds = 0;
List<Topic> topics = [];
var adShow = false;

class selected_answer {
  int topicId;
  int questionId;
  int answerId;
  bool right;
  int time;
  selected_answer({
    required this.topicId,
    required this.questionId,
    required this.answerId,
    required this.right,
    required this.time,
  });
  Map toJson() => {
        'topicId': topicId,
        'questionId': questionId,
        'answerId': answerId,
        'right': right,
        'time': time,
      };
}

final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
List<selected_answer> selectedAnswers = [];

class Body extends StatelessWidget {
  final Topic topic;
  final Book book;
  final Group group;
  // final int tjs;
  // final int njs;

  const Body({
    super.key,
    required this.topic,
    required this.book,
    required this.group,
  });
  @override
  Widget build(BuildContext context) {
    Timer? countdownTimer;
    Duration myDuration = Duration(minutes: minutes, seconds: seconds);
    bool isPaused = false;

    // prefs.setStringList('javoblar', <String>[]);
    // prefs.setString('javoblar', '');

    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Backdrop(
            size: size,
            topic: topic,
            book: book,
            group: group,
          ),
          MyBannerAdWidget(),
          // Time(minutes: minutes, seconds: seconds),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 10),
            child: MyStatefulWidget(topic: topic, book: book, group: group),
          ),
          Padding(
            padding: const EdgeInsets.all(kDefaultPadding / 10),
            child: ElevatedButton(
              onPressed: () {
                isPaused = true;
                _showDialog(context, topic, book, group, isPaused);
              },
              child: const Text('Finish'),
            ),
          )
          // QuestionCarousel(
          //   topic: topic,
          // ),
        ],
      ),
    );
  }
}

void _showDialog(
    BuildContext context, Topic topic, Book book, Group group, bool isPaused) {
  int belgilanmagan_savollar =
      all_question - togri_javoblar_soni - notogri_javoblar_soni;
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      insetPadding: const EdgeInsets.symmetric(vertical: 150),
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.blueAccent,
      title: const Text(
        'Results',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      icon: const Icon(Icons.event),
      titlePadding: const EdgeInsets.all(kDefaultPadding / 2),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyBannerAdWidget(),
          if (togri_javoblar_soni != 0)
            Text(
              'Correct answers: $togri_javoblar_soni',
              style: const TextStyle(
                color: Colors.greenAccent,
              ),
            ),
          if (notogri_javoblar_soni != 0)
            Text(
              'Wrong answers: $notogri_javoblar_soni',
              style: const TextStyle(
                color: Colors.redAccent,
              ),
            ),
          if (belgilanmagan_savollar != 0)
            Text(
              'Unmarked questions:  $belgilanmagan_savollar',
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
          ElevatedButton.icon(
            onPressed: () {
              debugPrint('ElevatedButton Clicked');
              Navigator.pop(context);
              isPaused = false;
            },
            icon: const Icon(
              Icons.next_plan,
              size: 24.0,
            ),
            label: const Text('Continue'),
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          ),
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TopicScreen(
                  group: group,
                  book: book,
                ),
              ),
            ),
            icon: const Icon(
              Icons.topic,
              size: 24.0,
            ),
            label: const Text('Topics'),
          ),
          if (topic.number > 1)
            ElevatedButton.icon(
              onPressed: () => {
                if (topics.firstWhereOrNull(
                        (element) => element.number == topic.number - 1) !=
                    null)
                  {
                    topic = topics.firstWhere(
                        (element) => element.number == topic.number - 1),
                    changeTopic(context, topic, book, group, false)
                  }
              },
              icon: const Icon(
                Icons.arrow_left_outlined,
                size: 24.0,
              ),
              label: const Text('Previous ticket'),
            ),
          if (topics.length > topic.number)
            ElevatedButton.icon(
              onPressed: () => {
                if (topics.firstWhereOrNull(
                        (element) => element.number == topic.number + 1) !=
                    null)
                  {
                    topic = topics.firstWhere(
                        (element) => element.number == topic.number + 1),
                    changeTopic(context, topic, book, group, false)
                  }
              },
              icon: const Icon(
                Icons.arrow_right_outlined,
                size: 24.0,
              ),
              label: const Text('Next ticket'),
            ),
          ElevatedButton.icon(
            onPressed: () => {changeTopic(context, topic, book, group, true)},
            icon: const Icon(
              Icons.refresh,
              size: 24.0,
            ),
            label: const Text('Start over'),
            style: ElevatedButton.styleFrom(shape: const StadiumBorder()),
          ),
          MyBannerAdWidget(),
        ],
      ),

      // content: const Image(
      //   image: NetworkImage(
      //       '$baseUrl/tests/types/images/autotest.jpg'),
      // ),
      // actions: [
      //   TextButton(
      //     child: const Text('close'),
      //     onPressed: () => Navigator.pop(context),
      //   ),
      //   // TextButton(
      //   //   child: const Text('OK'),
      //   //   onPressed: () {
      //   //     Navigator.push(
      //   //       context,
      //   //       MaterialPageRoute(
      //   //         builder: (context) => TopicScreen(book: book),
      //   //       ),
      //   //     );
      //   //   },
      //   // ),
      // ],
    ),
  );
}

void _showImage(BuildContext context, Question question) {
  showDialog(
    barrierDismissible: true,
    context: context,
    builder: (context) => AlertDialog(
      scrollable: true,
      insetPadding: const EdgeInsets.symmetric(vertical: 140),
      contentPadding: EdgeInsets.zero,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Colors.amber,
      icon: const Icon(Icons.image),
      titlePadding: const EdgeInsets.all(kDefaultPadding / 2),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          MyBannerAdWidget(),
          Container(
            width: 300,
            height: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(5)),
              boxShadow: const [kDefaultShadow],
              color: Color(0xFFF709090),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage('$baseUrl/media/${question.image}'),
              ),
            ),
          ),
          MyBannerAdWidget(),
        ],
      ),
      actions: [
        TextButton(
          child: const Text("close"),
          onPressed: () => Navigator.pop(context),
        ),
      ],
    ),
  );
}

void changeTopic(BuildContext context, Topic topic, Book book, Group group,
    bool refresh) async {
  adShow = true;
  final SharedPreferences prefs = await _prefs;
  if (refresh && selectedAnswers.isNotEmpty) {
    selectedAnswers = selectedAnswers
        .where((element) => element.topicId != topic.id)
        .toList();
    prefs.setString('selected_answers', jsonEncode(selectedAnswers));
  }
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => QuestionScreen(
        topic: topic,
        book: book,
        group: group,
      ),
    ),
  );
}

void checkJavoblar(SharedPreferences prefs) async {
  // prefs.setStringList("javoblar", []);
  // prefs.setString('selected_answers', '[]');
  // final SharedPreferences prefs = await _prefs;
  final String selected_answers = prefs.getString('selected_answers') ?? '[]';
  print(selected_answers);
  var tagsJson = jsonDecode(selected_answers);
  List? tags = tagsJson != null ? List.from(tagsJson) : null;
  for (var element in tags!) {
    selectedAnswers.add(selected_answer(
        topicId: element["topicId"],
        questionId: element["questionId"],
        answerId: element["answerId"],
        right: element["right"],
        time: element["time"]));
  }
}

class MyStatefulWidget extends StatefulWidget {
  final Topic topic;
  final Book book;
  final Group group;
  const MyStatefulWidget(
      {super.key,
      required this.topic,
      required this.book,
      required this.group});

  @override
  State<MyStatefulWidget> createState() =>
      _MyStatefulWidgetState(topic, book, group);
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  static final AdRequest request = AdRequest(
    keywords: <String>['foo', 'bar'],
    contentUrl: 'http://foo.com/bar.html',
    nonPersonalizedAds: true,
  );

  InterstitialAd? _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  RewardedAd? _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  RewardedInterstitialAd? _rewardedInterstitialAd;
  int _numRewardedInterstitialLoadAttempts = 0;
  // final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late Future<String> _selected_answer;

  Future<void> setAnswer(Answer answer) async {
    selected_answer selectedAnswer = new selected_answer(
        topicId: this.topic.id,
        questionId: this.question.id,
        answerId: answer.id,
        right: answer.right,
        time: minutes);
    String json = jsonEncode(selectedAnswer);
    final SharedPreferences prefs = await _prefs;
    setState(() {
      if (selectedAnswers.isEmpty) {
        selectedAnswers.add(selectedAnswer);
      } else {
        if (selectedAnswers.firstWhereOrNull(
                (element) => element.questionId == selectedAnswer.questionId) ==
            null) {
          selectedAnswers.add(selectedAnswer);
        }
      }
      _selected_answer = prefs
          .setString('selected_answers', jsonEncode(selectedAnswers))
          .then((bool success) {
        return selectedAnswers.toString();
      });
    });
  }

  final player = AudioPlayer();
  final Topic topic;
  final Book book;
  final Group group;
  late PageController _pageController;
  int initalPage = 1;
  int questionNumber = 0;
  Question question = Question(
    id: 0,
    name_en_us: '',
    name_ru_ru: '',
    name_uz_crl: '',
    name_uz_uz: '',
    image: '',
    number: 0,
    selectedAnswer: null,
  );
  List<Question> questions = [];
  List<Answer> answers = [];
  List<RadioModel> sampleData = [];
  var loading = false;
  Answer? selectedRadio;
  _MyStatefulWidgetState(this.topic, this.book, this.group);

  Future<void> getData() async {
    final SharedPreferences prefs = await _prefs;
    checkJavoblar(prefs);
    setState(() {
      loading = true;
    });
    questions = [];
    final responseData = await http.get(
        Uri.parse("$baseUrl/GetQuestions?topic_id=${topic.id.toString()}"));
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      setState(() {
        int number = 0;
        int togri_javob_soni = 0;
        int notogri_javob_soni = 0;
        Question question = this.question;
        List<Question> questions = this.questions;
        for (Map<String, dynamic> i in data) {
          question.selectedAnswer = null;
          if (selectedAnswers.firstWhereOrNull(
                  (element) => element.questionId == Question.fromJson(i).id) !=
              null) {
            question.selectedAnswer = selectedAnswers.firstWhere(
                (element) => element.questionId == Question.fromJson(i).id);
          }
          if (question.selectedAnswer != null) {
            i["selectedAnswer"] = question.selectedAnswer;
          }
          questions.add(Question.fromJson(i));
        }
        if (questions.isNotEmpty) {
          all_question = questions.length;
          questions.sort((a, b) {
            return a.number - b.number;
          });
          for (var element in questions) {
            if (element.number > number &&
                number == element.number - 1 &&
                element.selectedAnswer?.answerId != null) {
              number = element.number;
            }
            if (element.selectedAnswer != null) {
              if (element.selectedAnswer!.right) {
                togri_javob_soni = togri_javob_soni + 1;
              } else {
                notogri_javob_soni = notogri_javob_soni + 1;
              }
            }
          }
          if (selectedAnswers
                  .where((element) => element.topicId == topic.id)
                  .length ==
              questions.length) {
            _showDialog(context, topic, book, group, true);
          } else {
            questionNumber = number + 1;
          }
          if (questionNumber == 0) {
            questionNumber = 1;
          }
          togri_javoblar_soni = togri_javob_soni;
          notogri_javoblar_soni = notogri_javob_soni;
          setData(questionNumber);
        }
        loading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    MobileAds.instance.updateRequestConfiguration(
        RequestConfiguration(testDeviceIds: [testDevice]));
    _createInterstitialAd();
    getData();
    loadTopics(book.id.toString());
    _pageController = PageController(
      viewportFraction: 0.8,
      initialPage: initalPage,
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: Platform.isAndroid
            ? 'ca-app-pub-7773722896374259/7914455903'
            : 'ca-app-pub-7773722896374259/7914455903',
        request: request,
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
            _interstitialAd!.setImmersiveMode(true);
            if (adShow) {
              adShow = false;
              _showInterstitialAd();
            }
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts < maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd!.show();
    _interstitialAd = null;
  }

  setSelectedRadio(val) {
    setState(() {
      selectedRadio = val;
    });
  }

  int currentPage = 1;
  int belgilanmagan = 0;
  bool _enabled = true;
  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Center(child: CircularProgressIndicator());
    } else {
      return Column(
        children: [
          if (!loading && all_question > 0)
            Pagination(
              paginateButtonStyles: PaginateButtonStyles(
                // backgroundColor: Colors.pink,
                activeBackgroundColor: Colors.redAccent,
                activeTextStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
              prevButtonStyles: PaginateSkipButton(
                // buttonBackgroundColor: Colors.orange,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                ),
              ),
              nextButtonStyles: PaginateSkipButton(
                // buttonBackgroundColor: Colors.purple,
                borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
              ),
              onPageChange: (number) async {
                try {
                  //player.play(UrlSource('$baseUrl/static/sounds/click.mp3'));
                  await player.play(AssetSource('raw/click.mp3'));
                } on Exception catch (_) {
                  print('sound play error');
                }
                setData(number);
                if (question.selectedAnswer == null) {
                  _enabled = true;
                } else {
                  _enabled = false;
                }
                setState(() {
                  currentPage = number;
                });
              },
              useGroup: false,
              totalPage: all_question,
              show: 2,
              currentPage: currentPage,
            ),
          Text(
            question.name_en_us.toString(),
            style: const TextStyle(
              color: Colors.blueAccent,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          if (question.image != "")
            InkWell(
              onTap: () {
                _showImage(context, question);
              },
              child: Container(
                height: 100,
                width: 150,
                decoration: BoxDecoration(
                  borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(5)),
                  boxShadow: [kDefaultShadow],
                  color: Color(0xFFF709090),
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('$baseUrl/media/${question.image}'),
                  ),
                ),
              ),
            ),
          ListView.builder(
            shrinkWrap: true,
            itemCount: sampleData.length,
            padding: EdgeInsets.all(1.0),
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                highlightColor: Colors.yellow.withOpacity(0.3),
                splashColor: Colors.red.withOpacity(0.8),
                focusColor: Colors.green.withOpacity(0.0),
                hoverColor: Colors.blue.withOpacity(0.8),
                onTap: _enabled
                    ? () async {
                        _enabled = false;
                        try {
                          if (sampleData[index].answer.right) {
                            togri_javoblar_soni = togri_javoblar_soni + 1;
                            player.play(
                              await AssetSource('raw/right.mp3'),
                            );
                          } else {
                            notogri_javoblar_soni++;
                            player.play(
                              await AssetSource('raw/wrong.mp3'),
                            );
                          }
                        } on Exception catch (_) {
                          print('sound play error');
                        }

                        setState(() {
                          for (var element in sampleData) {
                            element.answer.right
                                ? element.correctAnswer = true
                                : element.correctAnswer = false;
                          }
                          for (var element in sampleData) {
                            element.isSelected = false;
                          }
                          sampleData[index].isSelected = true;
                          setAnswer(sampleData[index].answer);
                        });
                      }
                    : null,
                child: RadioItem(sampleData[index]),
              );
            },
          ),
        ],
      );
    }
  }

  void setData(int questionNumber) {
    if (questionNumber > questions.length) {
      questionNumber = 1;
      _enabled = false;
    }
    question = questions.firstWhere((it) => it.number == questionNumber);
    currentPage = question.number;
    loadAswers(question.id.toString());
    if (selectedAnswers
            .firstWhereOrNull((element) => element.questionId == question.id) !=
        null) {
      question.selectedAnswer = selectedAnswers
          .firstWhere((element) => element.questionId == question.id);
    }
  }

  Future<void> loadAswers(String questionId) async {
    answers = [];
    sampleData = [];
    final responseData = await http
        .get(Uri.parse("$baseUrl/GetAnswers?question_id=$questionId"));
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);

      setState(() {
        for (Map<String, dynamic> i in data) {
          answers.add(Answer.fromJson(i));
        }
        var index = 0;
        String buttonText = '';
        for (Answer i in answers) {
          index++;
          if (index == 1) buttonText = 'A';
          if (index == 2) buttonText = 'B';
          if (index == 3) buttonText = 'C';
          if (index == 4) buttonText = 'D';
          if (index == 5) buttonText = 'E';
          if (index == 6) buttonText = 'F';
          if (index == 7) buttonText = 'G';
          if (index == 8) buttonText = 'H';
          if (index == 9) buttonText = 'J';
          if (index == 10) buttonText = 'K';
          sampleData.add(RadioModel(question, i, false, false, buttonText));
        }
      });
    }
  }

  Future<void> loadTopics(String bookId) async {
    setState(() {
      loading = true;
    });
    topics = [];
    final responseData =
        await http.get(Uri.parse("$baseUrl/GetTopics?book_id=$bookId"));
    if (responseData.statusCode == 200) {
      final data = jsonDecode(responseData.body);
      setState(() {
        for (Map<String, dynamic> i in data) {
          topics.add(Topic.fromJson(i));
        }
        loading = false;
      });
    }
  }
}
