import org.jsoup.*;
import java.net.*;
import java.io.*;

org.jsoup.nodes.Document doc = null;

void setup(){
  size(600, 600, P3D);
  
  try{
    doc = Jsoup.connect("http://en.wikipedia.org/").get();
  
   String google = "http://www.google.com/search?q=";
   String search = "stackoverflow";
   String charset = "UTF-8";
   String userAgent = "ExampleBot 1.0 (+http://example.com/bot)"; // Change this to your company's name and bot homepage!

   Elements links = Jsoup.connect(google + URLEncoder.encode(search, charset)).userAgent(userAgent).get().select(".g>.r>a");

   for (Element link : links) {
    String title = link.text();
    String url = link.absUrl("href"); // Google returns URLs in format "http://www.google.com/url?q=<url>&sa=U&ei=<someKey>".
    url = URLDecoder.decode(url.substring(url.indexOf('=') + 1, url.indexOf('&')), "UTF-8");

    if (!url.startsWith("http")) {
        continue; // Ads/news/etc.
    }

    println("Title: " + title);
    println("URL: " + url);
  
   }
  }
  catch(IOException x){
    println(x.toString());
  }
}

void draw(){
  if(doc != null){
    text(doc.title(), width/2, height/2, -100);
    text(doc.outerHtml(), width/3, height/3, -50);
  }else{
    text("No data", width/2, height/2, 0);
  }
  
}