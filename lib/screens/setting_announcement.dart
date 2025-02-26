import 'package:flutter/material.dart';

import '../utils/localization.dart' show Localization;
import '../widgets/header.dart' show renderHeaderBack;

// One entry in the multilevel list displayed by this app.
class Entry {
  Entry(this.title, [this.children = const <Entry>[]]);

  final String title;
  final List<Entry> children;
}

class EntryItem extends StatelessWidget {
  const EntryItem(this.entry);

  final Entry entry;

  Widget _buildTiles(Entry root) {
    if (root.children.isEmpty) return ListTile(title: Text(root.title));
    return ExpansionTile(
      key: PageStorageKey<Entry>(root),
      title: Text(root.title ?? ''),
      children: root.children.map(_buildTiles).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(entry);
  }
}

class SettingAnnouncement extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);
    final List<Entry> data = <Entry>[
      Entry(_localization.trans('ANNOUNCEMENT_1'),
        <Entry>[Entry(_localization.trans('ANNOUNCEMENT_TXT_1'))],
      ),
      Entry(_localization.trans('ANNOUNCEMENT_2'),
        <Entry>[Entry(_localization.trans('ANNOUNCEMENT_TXT_2'))],
      ),
    ];
    return Scaffold(
      appBar: renderHeaderBack(
        centerTitle: false,
        context: context,
        iconColor: Theme.of(context).primaryColor,
        brightness: Brightness.light,
        title: Text(
          _localization.trans('ANNOUNCEMENT'),
          style: TextStyle(
            fontSize: 20,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
      body: Container(
        child: ListView.builder(
          itemBuilder: (BuildContext context, int index) =>
              EntryItem(data[index]),
          itemCount: data.length,
        ),
      ),
    );
  }
}
