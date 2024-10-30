String generateInitials(String name) {
  List<String> nameSplit = name.split(' ');
  String initials = '';
  for (int i = 0; i < nameSplit.length; i++) {
    initials += nameSplit[i][0];
  }
  if (nameSplit.length == 1) {
    initials += name.split('')[1];
  }
  return initials.toUpperCase();
}
