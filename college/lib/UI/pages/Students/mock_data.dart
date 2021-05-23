import 'package:sticky_and_expandable_list/sticky_and_expandable_list.dart';

class MockData {
  ///return a example list, by default, we have 4 sections,
  ///each section has 5 items.
  static var data_c1=[
    [
      "C1 - 12",
      "C2 - 15",
      "C3 - 30"
    ],
    [
      "C1 - 10",
      "C2 - 25",
      "C3 - 13"
    ],
    [
      "C1 - 21",
      "C2 - 13",
      "C3 - 22"
    ],
  ];
  static List<ExampleSection> getExampleSections(
      [int sectionSize = 3, int itemSize = 3]) {
    var sections = List<ExampleSection>.empty(growable: true);
    for (int i = 0; i < sectionSize; i++) {
      var section = ExampleSection()
        ..header = "Subject$i"
        ..items = data_c1[i]
        ..expanded = true;
      sections.add(section);
    }
    return sections;
  }
}

///Section model example
///
///Section model must implements ExpandableListSection<T>, each section has
///expand state, sublist. "T" is the model of each item in the sublist.
class ExampleSection implements ExpandableListSection<String> {
  //store expand state.
  bool expanded;

  //return item model list.
  List<String> items;

  //example header, optional
  String header;

  @override
  List<String> getItems() {
    return items;
  }

  @override
  bool isSectionExpanded() {
    return expanded;
  }

  @override
  void setSectionExpanded(bool expanded) {
    this.expanded = expanded;
  }
}