import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:sms_autofill/sms_autofill.dart';
import 'package:water_go_app_04_08_2025/screen/main_page.dart';

class AuthCodePage extends StatefulWidget {
  final String number;

  const AuthCodePage({super.key, required this.number});

  @override
  State<AuthCodePage> createState() => _AuthCodePageState();
}

class _AuthCodePageState extends State<AuthCodePage> with CodeAutoFill {
  final List<TextEditingController> _controllers =
  List.generate(5, (_) => TextEditingController());
  final List<FocusNode> _focusNodes = List.generate(5, (_) => FocusNode());

  int _secondsLeft = 120;
  Timer? _timer;
  bool _isCodeComplete = false;
  bool _isSendingCode = false;
  bool _isConfirming = false;
  int? smsCode;

  final box = GetStorage();

  @override
  void initState() {
    super.initState();
    _startTimer();
    _focusNodes[0].requestFocus();
    listenForCode();
    avtoRunFunction();
  }

  @override
  void codeUpdated() {
    if (code != null && code!.length >= 5) {
      for (int i = 0; i < 5; i++) {
        _controllers[i].text = code![i];
      }
      _checkCodeFilled();
    }
  }

  @override
  void dispose() {
    for (var c in _controllers) {
      c.dispose();
    }
    for (var f in _focusNodes) {
      f.dispose();
    }
    _timer?.cancel();
    cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsLeft = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsLeft > 0) {
        setState(() => _secondsLeft--);
      } else {
        timer.cancel();
      }
    });
  }

  void _checkCodeFilled() {
    setState(() {
      _isCodeComplete =
          _controllers.every((controller) => controller.text.isNotEmpty);
    });
  }

  Future<void> _onConfirm() async {
    String enteredCode = _controllers.map((c) => c.text).join();
    if (smsCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Tasdiqlash kodi yuborilmoqda!")),
      );
      return;
    }
    if (enteredCode != smsCode.toString()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Xato tasdiqlash kod kiritildi!")),
      );
      return;
    }

    setState(() {
      _isConfirming = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    // ✅ API’dan kelgan misolcha ma'lumotlar
    final apiResponse = {
      "phone": widget.number,
      "name": "John Doe",
      "token": "abc123tokenXYZ"
    };

    // ✅ GetStorage’ga yozish
    box.write("phone", apiResponse["phone"]);
    box.write("name", apiResponse["name"]);
    box.write("token", apiResponse["token"]);

    setState(() {
      _isConfirming = false;
    });

    Get.offAll(() => MainPage());
  }

  Future<void> avtoRunFunction() async {
    setState(() {
      _isSendingCode = true;
    });

    await Future.delayed(const Duration(seconds: 2));
    smsCode = 44444;

    setState(() {
      _isSendingCode = false;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Tasdiqlash kodi yuborildi: $smsCode")),
    );
  }

  Widget _buildCodeField(int index) {
    return SizedBox(
      width: 60,
      height: 60,
      child: RawKeyboardListener(
        focusNode: FocusNode(skipTraversal: true),
        onKey: (event) {
          if (event is RawKeyDownEvent &&
              event.logicalKey == LogicalKeyboardKey.backspace &&
              _controllers[index].text.isEmpty &&
              index > 0) {
            _focusNodes[index - 1].requestFocus();
          }
        },
        child: TextField(
          focusNode: _focusNodes[index],
          controller: _controllers[index],
          textAlign: TextAlign.center,
          maxLength: 1,
          keyboardType: TextInputType.number,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            counterText: '',
            filled: true,
            fillColor: Colors.white.withOpacity(0.15),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.blue.shade200, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(color: Colors.blue, width: 2),
            ),
          ),
          onChanged: (value) {
            if (value.isNotEmpty && index < 4) {
              _focusNodes[index + 1].requestFocus();
            }
            _checkCodeFilled();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("SMS Tasdiqlash"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 36),
              Image.asset('assets/images/phone01.png', height: 200),
              const SizedBox(height: 36),
              const Text(
                "Telefon raqamingizga yuborilgan kodni kiriting",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  border: Border.all(color: Colors.blue.shade200),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.phone_android, color: Colors.blue.shade700),
                    const SizedBox(width: 8),
                    Text(
                      widget.number,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(5, _buildCodeField),
              ),
              const SizedBox(height: 20),
              _secondsLeft > 0
                  ? Text(
                "Qayta yuborish: 00:${_secondsLeft.toString().padLeft(2, '0')}",
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              )
                  : TextButton.icon(
                icon: const Icon(Icons.refresh, color: Colors.blue),
                label: const Text("Kodni qayta yuborish"),
                onPressed: () {
                  _startTimer();
                  avtoRunFunction();
                },
              ),
              const SizedBox(height: 40),
              _isSendingCode
                  ? const CircularProgressIndicator()
                  : SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                    _isCodeComplete ? Colors.blue : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: _isCodeComplete && !_isConfirming
                      ? _onConfirm
                      : null,
                  child: _isConfirming
                      ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                      : Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.check_circle_outline,
                        color: _isCodeComplete
                            ? Colors.white
                            : Colors.blueGrey,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Tasdiqlash",
                        style: TextStyle(
                          fontSize: 18,
                          color: _isCodeComplete
                              ? Colors.white
                              : Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
