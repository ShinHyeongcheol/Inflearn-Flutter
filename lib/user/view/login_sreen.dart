import 'package:flutter/material.dart';
import 'package:inflearn_flutter/common/const/Colors.dart';
import 'package:inflearn_flutter/common/layout/default_layout.dart';
import '../../common/component/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      child: SingleChildScrollView(
        //화면 드래그 했을 때 키보드 사라짐
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: SafeArea(
          top: true,
          bottom: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _Tilte(),
                SizedBox(
                  height: 16,
                ),
                _SubTilte(),
                Image.asset(
                  'asset/img/misc/logo.png',
                  width: (MediaQuery.of(context).size.width / 3),
                  height: MediaQuery.of(context).size.height / 5 * 2,
                ),
                CustomTextFormField(
                  hintText: '이메일을 입력해주세요',
                  //errorText: '에러가 있습니다',
                  onChanged: (String value) {},
                ),
                SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  //errorText: '에러가 있습니다',
                  obsureText: true,
                  onChanged: (String value) {},
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMATY_COLOR,
                    foregroundColor: Colors.white,
                  ),
                  child: Text('로그인'
                      ''),
                ),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.black,
                  ),
                  child: Text('회원가입'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Tilte extends StatelessWidget {
  const _Tilte({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '환영합니다',
      style: TextStyle(
          fontSize: 34, fontWeight: FontWeight.w500, color: Colors.black),
    );
  }
}

class _SubTilte extends StatelessWidget {
  const _SubTilte({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      '이메일과 비밀번호를 입력해서 로그인해주세요! :)',
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w300,
        color: BODY_TEXT_COLOR,
      ),
    );
  }
}
