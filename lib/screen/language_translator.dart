import 'package:flutter/material.dart';
import 'package:translator/translator.dart';

class LanguageTranslator extends StatefulWidget {
  const LanguageTranslator({super.key});

  @override
  State<LanguageTranslator> createState() => _LanguageTranslatorState();
}

class _LanguageTranslatorState extends State<LanguageTranslator> {
  var languages = ["English", "Hindi", "Spanish", "French", "German", "Italian", "Japanese", "Korean", "Russian", "Chinese"];
  var originLanguage = "From";
  var destinationLanguage = "To";
  var output = "";
  final _formKey = GlobalKey<FormState>();
  TextEditingController languageController = TextEditingController();

  void translate(String src, String dest, String input) async {
    if (src == "--" || dest == "--") {
      setState(() {
        output = "Please select both source and destination languages.";
      });
      return;
    }

    GoogleTranslator translator = GoogleTranslator();
    try {
      var translation = await translator.translate(input, from: src, to: dest);
      setState(() {
        output = translation.text.toString();
      });
    } catch (e) {
      setState(() {
        output = "Failed to translate: $e";
      });
    }
  }

  String getLanguageCode(String language) {
    switch (language) {
      case "English":
        return "en";
      case "Hindi":
        return "hi";
      case "Spanish":
        return "es";
      case "French":
        return "fr";
      case "German":
        return "de";
      case "Italian":
        return "it";
      case "Japanese":
        return "ja";
      case "Korean":
        return "ko";
      case "Russian":
        return "ru";
      case "Chinese":
        return "zh";
      default:
        return "--";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Language Translator"),
        centerTitle: true,
        backgroundColor: Color(0xff10223d),
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButton(
                      hint: Text(
                        originLanguage,
                        style: TextStyle(color: Colors.black),
                      ),
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                      items: languages.map((String dropDownStringItem) {
                        return DropdownMenuItem(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem, style: TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          originLanguage = value!;
                        });
                      },
                    ),
                    SizedBox(width: 40),
                    Icon(Icons.arrow_right_alt_outlined, color: Colors.black, size: 40),
                    SizedBox(width: 40),
                    DropdownButton(
                      hint: Text(
                        destinationLanguage,
                        style: TextStyle(color: Colors.black),
                      ),
                      dropdownColor: Colors.white,
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.black),
                      items: languages.map((String dropDownStringItem) {
                        return DropdownMenuItem(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem, style: TextStyle(color: Colors.black)),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          destinationLanguage = value!;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: TextFormField(
                    cursorColor: Colors.black,
                    autocorrect: false,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      labelText: "Enter Your Text...",
                      labelStyle: TextStyle(fontSize: 15, color: Colors.black),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black, width: 1),
                      ),
                      errorStyle: TextStyle(color: Colors.red, fontSize: 15),
                    ),
                    controller: languageController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Color(0xff2b3c5a)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        translate(getLanguageCode(originLanguage), getLanguageCode(destinationLanguage), languageController.text.toString());
                      }
                    },
                    child: Text("Translate", style: TextStyle(color: Colors.white)),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  "\n$output",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}