void setup() {
  // Define Sketch Size
  size(1024, 512);
  // Load Background Image
  // Load Image
  PImage img; 
  img = loadImage("../shape.png");
  // Set Background
  background(img);
  
    

// Arrays
// Nouns
String[] nouns = {"area", "book","business","case","child","company","country","day","eye","fact","family","government","group","hand","home","job","life","lot",
"man","money","month","mother","night","number","part","people","place","point","problem","program","question","right","room","school","state","story","student",
"study","system","thing","time","water","way","week","woman","word","work","world","year"}; 
// Adjectives
String[] adjectives = {"able","bad","best",
"better","big","black","certain","clear","different","early","easy","economic","free","full","good","great","hard","high","human","important","international","large","late",
"little","local","long","low","major","national","new","old","only","other","political","possible","public","real","recent","right","small","social","special","strong",
"sure","true","white","whole","young"};

//Action Verbs
String[] verbs ={"acts","agrees","arrives","asks","bakes","brings","builds","buys","calls","climbs","closes","comes","cries","dances","dreams","drinks","eats","enters","exits","falls","fixes",
"gives","goes","grabs","helps","hits","hops","insults","jokes","jumps","kicks","laughs","leaves","lifts","listens","makes","marches","moves","nods","opens","plays","pushes",
"reads","rides","runs","sends","shouts","sings","sits","smiles","spends","stands","talks","thinks","throws","touches","turns","visits","votes","waits","walks","writes","yells"};


// Randomly choose words based on each array's lenght 

int n = int(random( nouns.length )); // random number from the total of elements in the Array 
int m = int(random( adjectives.length )); // random number from the total of elements in the Array 
int v = int(random( verbs.length )); // random number from the total of elements in the Array 
int n1 = int(random( nouns.length )); // random number from the total of elements in the Array 


// Shadow Effect
textSize(90); 
textAlign(LEFT,CENTER);
fill(125, 127, 91,40);
text(nouns[n], 305, 105);
text(verbs[v], 305, 205);
text(adjectives[m], 305, 305);
text(nouns[n1], 305, 405);


// Main text
textSize(90); 
textAlign(LEFT,CENTER);
fill(172, 157, 110,255);

text(nouns[n], 305, 100);
text(verbs[v], 300, 200);
text(adjectives[m], 300, 300);
text(nouns[n1], 300, 400);

//save Image
save("../final.png");
//exit Sketch
exit();






}
