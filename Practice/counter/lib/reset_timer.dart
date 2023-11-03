import 'dart:async';
import 'package:flutter/material.dart';

class TimerItem {
  int hours;
  int minutes;
  int seconds;
  bool isActive;
  TextEditingController hourController;
  TextEditingController minuteController;
  TextEditingController secondController;
  Timer? timer;

  TimerItem({
    this.hours = 0,
    this.minutes = 0,
    this.seconds = 0,
    this.isActive = false,
    TextEditingController? hourController,
    TextEditingController? minuteController,
    TextEditingController? secondController,
  })  : hourController = hourController ?? TextEditingController(),
        minuteController = minuteController ?? TextEditingController(),
        secondController = secondController ?? TextEditingController();

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    timer = Timer.periodic(oneSec, (Timer timer) {
      // Timer tick update logic will be added here
    });
  }

  void stopTimer() {
    if (timer != null) {
      timer!.cancel();
      isActive = false;
    }
  }

  void resetTimer() {
    stopTimer();
    hours = 0;
    minutes = 0;
    seconds = 0;
    hourController.clear();
    minuteController.clear();
    secondController.clear();
  }

  // Other methods like continueTimer will be added here if needed
}
