import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/asset.dart' as Asset;
import '../utils/general.dart';
import '../widgets/profile_image_cam.dart';
import '../utils/localization.dart' show Localization;
import '../widgets/header.dart' show renderHeaderClose;
import '../widgets/edit_text_box.dart' show EditTextBox;
import '../utils/validator.dart' show Validator;

class ProfileMy extends StatefulWidget {
  @override
  _ProfileMyState createState() => _ProfileMyState();
}

class _ProfileMyState extends State<ProfileMy> {
  void _chooseImage(String type) async {
    General.instance.showDialogSpinner(context, text: Localization.of(context).trans('LOADING'));

    try {
      File imgFile = type == 'camera'
          ? await ImagePicker.pickImage(source: ImageSource.camera)
          : await ImagePicker.pickImage(source: ImageSource.gallery);

      if (imgFile != null) {

      }
    } catch (err) {
      print('err: $err');
    } finally {
      Navigator.pop(context);
    }
  }

  void _onUpdateProfile() {
    print('onUpdateProfile');
  }

  @override
  Widget build(BuildContext context) {
    var _localization = Localization.of(context);

    return Scaffold(
      appBar: renderHeaderClose(
        context: context,
        brightness: Brightness.light,
        actions: [
          IconButton(
            icon: Icon(
              Icons.save_alt,
              semanticLabel: 'update',
            ),
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(0.0),
            onPressed: _onUpdateProfile,
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 40.0),
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 24, bottom: 8),
              child: Row(
                children: <Widget>[
                  ProfileImageCam(
                    selectCamera: () => this._chooseImage('camera'),
                    selectGallery: () => this._chooseImage('gallery'),
                  ),
                ],
              ),
            ),
            EditTextBox(
              iconData: Icons.person_outline,
              margin: EdgeInsets.only(top: 24.0),
              hintText: _localization.trans('NICKNAME'),
            ),
            EditTextBox(
              iconData: Icons.email,
              margin: EdgeInsets.only(top: 8.0),
              hintText: _localization.trans('EMAIL'),
            ),
            EditTextBox(
              iconData: Icons.phone,
              margin: EdgeInsets.only(top: 8.0),
              hintText: _localization.trans('PHONE'),
            ),
            Container(
              margin: EdgeInsets.only(top: 32.0, bottom: 12.0),
              child: Divider(
                height: 1.0,
              ),
            ),
            EditTextBox(
              labelText: _localization.trans('STATUS_MESSAGE'),
              hintText: _localization.trans('STATUS_MESSAGE_HINT'),
              maxLines: 5,
            ),
          ],
        ),
      ),
    );
  }
}
