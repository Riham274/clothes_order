class UnbordingContent {
  final String image;
  final String title;
  final String description;

  UnbordingContent({
    required this.image,
    required this.title,
    required this.description,
  });
}


List <UnbordingContent> contents = [
  UnbordingContent(image: "assest/screen1.png", 
  title: "Welcome to CLOTHING STORE!", 
  description: "Discover top picks and find the\n     perfect outfit just for you"),

  UnbordingContent(image: "assest/screen2.png", 
  title: "Enjoy Easy Payment", 
  description: "We offer both cash on delivery and Card \n        payment for your convenience"),

  UnbordingContent(image: "assest/screen3.png", 
  title: "Your Order is on the Way!", 
  description: "Your style is coming to\n        you in no time")
];