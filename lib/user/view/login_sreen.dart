import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:inflearn_flutter/common/const/Colors.dart';
import 'package:inflearn_flutter/common/layout/default_layout.dart';
import 'package:inflearn_flutter/common/view/root_tab.dart';
import '../../common/component/custom_text_form_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String username = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    final dio = Dio();

    //localhost
    final emulatorIp = '10.0.2.2:3000'; //안스 윈도우 에뮬레이터 IP
    final simulatorIP = '127.0.0.1:3000'; // ios 시뮬레이터 IP

    final ip = Platform.isIOS ? simulatorIP : emulatorIp;

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
                  onChanged: (String value) {
                    username = value;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                CustomTextFormField(
                  hintText: '비밀번호를 입력해주세요',
                  //errorText: '에러가 있습니다',
                  obsureText: true,
                  onChanged: (String value) {
                    password = value;
                  },
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: () async {
                    final rawString = '$username:$password';
                    //final rawString = 'test@codefactory.ai:testtest';

                    Codec<String, String> StringToBase64 = utf8.fuse(base64);

                    String token = StringToBase64.encode(rawString);

                    final resp = await dio.post('http://$ip/auth/login',
                        options: Options(headers: {
                          'Authorization': 'Basic $token',
                        }));
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => RootTab(),
                      ),
                    );
                    print(resp.data);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: PRIMATY_COLOR,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    '로그인',
                  ),
                ),
                SizedBox(
                  height: 16,
                ),
                TextButton(
                  onPressed: () async {
                    final refreshtoken =
                        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6InRlc3RAY29kZWZhY3RvcnkuYWkiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoicmVmcmVzaCIsImlhdCI6MTcxMjU1NzMzMCwiZXhwIjoxNzEyNjQzNzMwfQ.pua3nwi4JWz44mKAUhTdQX6LBVEFko21Laet2qtX-KA';
                    final resp = await dio.post('http://$ip/auth/token',
                        options: Options(headers: {
                          'Authorization': 'Bearer $refreshtoken',
                        }));
                    //print(resp.data);
                  },
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
