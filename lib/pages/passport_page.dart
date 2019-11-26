import 'package:baas_study/utils/auto_size_utli.dart';
import 'package:baas_study/widget/passport.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  /// 控制表单
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _accountController = TextEditingController();
  final TextEditingController _pswController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _verifyController = TextEditingController();
  bool _showPsw = false;
  bool _showClear = false;
  Color _textColor;

  /// 使用账号密码登录
  bool _accountLogin = true;

  /// 第二个输入框焦点
  FocusNode _secondFocusNode = FocusNode();

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    setState(() {
      _textColor = themeData.brightness == Brightness.light
          ? Colors.black87
          : Colors.white;
    });
    return Scaffold(
      appBar: _appBar,
      backgroundColor: themeData.appBarTheme.color,
      body: Padding(
        padding: EdgeInsets.only(
          left: _size(36),
          right: _size(36),
        ),
        child: Column(
          children: <Widget>[
            Text(
              _accountLogin ? '账号登录' : '短信登录',
              style: TextStyle(
                color: _textColor,
                fontSize: AutoSize.font(24),
              ),
            ),
            _accountLoginForm,
            Padding(
              padding: EdgeInsets.only(bottom: _size(10)),
              child: PassBtn(
                text: '登录',
                onPressed: null,
              ),
            ),
            _bottomText,
          ],
        ),
      ),
    );
  }

  /// 自定义appBar
  Widget get _appBar {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: Icon(Icons.close),
        onPressed: () {
          FocusScope.of(context).requestFocus(FocusNode());
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        Container(
          margin: EdgeInsets.only(right: _size(16)),
          child: Center(
            child: Text(
              '注册',
              style: TextStyle(
                color: _textColor,
                fontSize: AutoSize.font(16),
              ),
            ),
          ),
        )
      ],
    );
  }

  /// 表单
  Widget get _accountLoginForm {
    return Form(
      key: _formKey,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: _size(30)),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  _accountLogin ? _accountInput : _phoneInput,
                  Container(height: _size(20)),
                  _accountLogin ? _pswInput : _verifyInput,
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 账号登录输入框
  Widget get _accountInput {
    return TextFormField(
      controller: _accountController,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: '手机号/邮箱',
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              /// 保证在组件build的第一帧时才去触发取消清空内容
              WidgetsBinding.instance
                  .addPostFrameCallback((_) => _accountController.clear());
              _onChange('');
            });
          },
          child: Offstage(
            offstage: !_showClear,
            child: Icon(Icons.close),
          ),
        ),
      ),
      onChanged: _onChange,
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_secondFocusNode);
      },
    );
  }

  /// 密码输入框
  Widget get _pswInput {
    return TextFormField(
      controller: _pswController,
      focusNode: _secondFocusNode,
      obscureText: !_showPsw,
      decoration: InputDecoration(
        hintText: '密码',
        suffixIcon: GestureDetector(
          onTap: () {
            setState(() {
              _showPsw = !_showPsw;
            });
          },
          child: _showPsw ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
        ),
      ),
    );
  }

  /// 手机验证码输入框
  Widget get _phoneInput {
    return TextFormField(
      controller: _phoneController,
      keyboardType: TextInputType.number,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: '短信登录仅限中国大陆用户',
        prefixIcon: Container(
          height: _size(20),
          width: _size(20),
          child: Center(
            child: Text(
              '+86',
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontSize: AutoSize.font(20),
                color: _textColor,
              ),
            ),
          ),
        ),
      ),
      onEditingComplete: () {
        FocusScope.of(context).requestFocus(_secondFocusNode);
      },
    );
  }

  /// 验证码输入框
  Widget get _verifyInput {
    return TextFormField(
      controller: _verifyController,
      keyboardType: TextInputType.number,
      focusNode: _secondFocusNode,
      decoration: InputDecoration(
        hintText: '请输入验证码',
        suffixIcon: GestureDetector(
          onTap: () {},
          child: Container(
            height: _size(20),
            width: _size(75),
            child: Center(
              child: Text(
                '获取验证码',
                textAlign: TextAlign.justify,
                style: TextStyle(
                  fontSize: AutoSize.font(14),
                  color: Colors.blue,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// bottom文字按钮
  Widget get _bottomText {
    return _accountLogin
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              PassBottomText(
                text: '手机短信登录',
                onTab: () {
                  setState(() {
                    FocusScope.of(context).requestFocus(FocusNode());
                    _accountLogin = false;
                  });
                },
              ),
              PassBottomText(
                text: '忘记密码',
                onTab: () {},
              )
            ],
          )
        : PassBottomText(
            text: '用户名密码登录',
            onTab: () {
              setState(() {
                FocusScope.of(context).requestFocus(FocusNode());
                _accountLogin = true;
              });
            },
          );
  }

  _size(double size) {
    return AutoSize.size(size);
  }

  _onChange(String text) {
    if (text.length > 0)
      setState(() {
        _showClear = true;
      });
    else
      setState(() {
        _showClear = false;
      });
  }
}