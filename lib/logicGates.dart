library logic_gates;

import 'dart:math';

int orGate(int a, int b) {
  if (a == 1 || b == 1) {
    return 1;
  }
  return 0;
}


int andGate(int a, int b) {
  if (a == b && a == 1) {
    return 1;
  } 
  return 0;
}

int nandGate(int a, int b) {
  if (a == 1) {
    if (b == 1) {
      return 0;
    } else {
      return 1;
    }
  } else {
    return 1;
  }
}

int norGate(int a, int b) {
  if (a == 1) {
    return 0;
  }  else {
    if (b == 1) {
      return 0;
    } else {
      return 1;
    }
  }
}

int xorGate(int a, int b) {
  if (a == 1) {
    if (b == 1) {
      return 0;
    } else {
      return 1;
    }
  } else {
    if (b == 1) {
      return 1;
    } else {
      return 0;
    }
  }
}

int xnorGate(int a, int b) {
  if (a == 1) {
    if (b == 1) {
      return 1;
    } else {
      return 0;
    }
  } else {
    if (b == 1) {
      return 0;
    } else {
      return 1;
    }
  }
}

const ALL_GATES = [orGate, andGate, nandGate, norGate, xorGate, xnorGate];

List<List<int>> drawLogicGates(int width, int height) {
  var rng = new Random();
  List<Function> gates = [];
  for (int i = 0; i < width; i++) {
    gates.add(ALL_GATES[rng.nextInt(ALL_GATES.length)]);
  }

  List<List<int>> outputValues = [];
  List<int> currState = [];
  for (int i = 0; i < width; i++) {
    currState.add(rng.nextInt(2));
  }
  outputValues.add(currState);

  for (int j = 1; j < height; j++) {
    List<int> paddedState = List.from([0])..addAll(currState)..addAll([0]);
    currState = List<int>.generate(currState.length, (index) => 0);
    for (int i = 0; i < width; i++) {
      currState[i] = gates[i](paddedState[i], paddedState[i + 1]);
    }
    outputValues.add(currState);
  }

  return outputValues;
}