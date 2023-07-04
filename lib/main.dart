import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Test02',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightBlue),
        useMaterial3: true,
      ),
      home: const Homepage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return const PicturesAdder();
  }
}

class Picture {
  final Image _image;
  final List<Text> _titles;
  final Map<Icon, int> _star;
  final Text _description;
  final Map<Icon, Text> _options;
  final List<bool> _isClicked;
  Picture(this._image, this._titles, this._star, this._description, this._options,
      this._isClicked);
}

class PicturesAdder extends StatefulWidget {
  const PicturesAdder({super.key});

  @override
  State<StatefulWidget> createState() => _PicturesAdderState();
}

class _PicturesAdderState extends State<PicturesAdder> {
  final List<StatefulPicture> _list = List.empty(growable: true);
  final int maxPictures = 6;
  int _count = 0;
  Text _text = const Text('');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Test02',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.lightBlue,
        centerTitle: true,
      ),
      body: StatefulPictures(_list),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: const CircleBorder(),
              onPressed: _removePicture,
              child: const Icon(
                Icons.remove,
                size: 25,
                color: Colors.red,
              ),
            ),
            Container(
              padding: _text.data != ''
                  ? const EdgeInsets.all(7)
                  : const EdgeInsets.all(0),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.black.withOpacity(0.3)),
              child: _text,
            ),
            FloatingActionButton(
              backgroundColor: Colors.transparent,
              elevation: 0,
              shape: const CircleBorder(),
              onPressed: _addPicture,
              child: const Icon(
                Icons.add,
                size: 25,
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _addPicture() {
    setState(() {
      if (_list.length < 6 && _count >= 0) {
        ++_count;
        _list.add(StatefulPicture(Picture(
            Image.asset(
              'images/image$_count.jpg',
              fit: BoxFit.fill,
              width: 600,
              height: 240,
            ),
            [
              Text('Image ( $_count )', style: const TextStyle(fontSize: 24)),
              const Text('Autor: Lucien Erard',
                  style: TextStyle(
                      fontSize: 17, color: Color.fromRGBO(38, 50, 56, 1)))
            ],
            {
              const Icon(
                Icons.star,
                size: 25,
                color: Color.fromRGBO(255, 171, 0, 1),
              ): 0
            },
            const Text(
              'This picture was taken from a balkon',
              style: TextStyle(fontSize: 16),
            ),
            {
              const Icon(Icons.call, color: Colors.lightBlue, size: 25, ): const Text('CALL', style: TextStyle(color: Colors.lightBlue),),
              const Icon(Icons.near_me, color: Colors.lightBlue, size: 25, ): const Text('ROUTE', style: TextStyle(color: Colors.lightBlue),),
              const Icon(Icons.share, color: Colors.lightBlue, size: 25, ): const Text('SHARE', style: TextStyle(color: Colors.lightBlue),),
            },
            [false, false])));

        _text = Text(
          'Image ( $_count ) was added!',
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white,
            letterSpacing: 1.2,
          ),
        );
      } else {
        _text = const Text('');
      }
    });
  }

  void _removePicture() {
    setState(() {
      if (_count > 0) {
        _list.removeLast();
        _text = Text(
          'Image ( $_count ) was removed!',
          style: const TextStyle(
              fontSize: 16, color: Colors.white, letterSpacing: 1.2),
        );
        --_count;
      } else {
        _text = const Text('');
      }
    });
  }
}

class StatefulPictures extends StatefulWidget {
  final List<StatefulPicture> _list;
  const StatefulPictures(this._list, {super.key});

  @override
  State<StatefulWidget> createState() => _StatefulPicturesState();
}

class _StatefulPicturesState extends State<StatefulPictures> {
  @override
  Widget build(BuildContext context) {
    List<StatefulPicture> list = widget._list;
    return ListView.builder(
        itemCount: list.length,
        itemBuilder: (BuildContext context, index) {
          return list[index];
        });
  }
}

class StatelessPicture extends StatelessWidget {
  final Picture _element;
  const StatelessPicture(this._element, {super.key});

  @override
  Widget build(BuildContext context) {
    return StatefulPicture(_element);
  }
}

class StatefulPicture extends StatefulWidget {
  final Picture _element;
  const StatefulPicture(this._element, {super.key});

  @override
  State<StatefulPicture> createState() => _StatefulPictureState();
}

class _StatefulPictureState extends State<StatefulPicture> {
  Column _column(Icon icon, Text text) {
    return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  icon,
                  text,
                ],
              );
  }

  @override
  Widget build(BuildContext context) {
    Picture element = widget._element;
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(bottom: 12),
      color: Colors.lightBlueAccent[100]!.withOpacity(0.2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          element._image,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: element._titles,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: _addStar,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: element._star.keys.first,
                  ),
                  Text('${element._star.values.first}',
                      style: const TextStyle(fontSize: 15)),
                ],
              )
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FloatingActionButton(
                    onPressed: _like,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: !element._isClicked.first
                        ? const Icon(
                            Icons.favorite_border_outlined,
                            size: 25,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.favorite,
                            size: 25,
                            color: Colors.pinkAccent,
                          ),
                  ),
                  FloatingActionButton(
                    onPressed: _dislike,
                    elevation: 0,
                    backgroundColor: Colors.transparent,
                    child: !element._isClicked.last
                        ? const Icon(
                            Icons.heart_broken_outlined,
                            size: 25,
                            color: Colors.grey,
                          )
                        : const Icon(
                            Icons.heart_broken_sharp,
                            size: 25,
                            color: Colors.black,
                          ),
                  ),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _column(element._options.keys.elementAt(0), element._options.values.elementAt(0)),
              _column(element._options.keys.elementAt(1), element._options.values.elementAt(1)),
              _column(element._options.keys.elementAt(2), element._options.values.elementAt(2)),
            ],
          ),
          element._description,
        ],
      ),
    );
  }

  void _addStar() {
    setState(() {
      if (widget._element._star.values.first < 100) {
        int count = widget._element._star.values.first + 1;
        Icon star = widget._element._star.keys.first;
        widget._element._star.update(star, (value) => count,);
      }
    });
  }

  void _like() {
    setState(() {
      widget._element._isClicked[0] = !widget._element._isClicked.first;
      widget._element._isClicked[1] = false;
    });
  }

  void _dislike() {
    setState(() {
      widget._element._isClicked[1] = !widget._element._isClicked.last;
      widget._element._isClicked[0] = false;
    });
  }
}
