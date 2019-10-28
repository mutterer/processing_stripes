// This sketch draws the global temperature deviation relative to a base period
// GCAG base period: 20th century average.
// Data is from : https://datahub.io/core/global-temp#data
// Inspired by https://showyourstripes.info/

import java.util.Map;
HashMap<Integer, Float> hm;
JSONArray json;
void setup() {
  String dataUrl = "https://pkgstore.datahub.io/core/global-temp/annual_json/data/529e69dbd597709e36ce11a5d0bb7243/annual_json.json";
  json = loadJSONArray(dataUrl);
  hm = new HashMap<Integer, Float>();
  for (int i = 0; i<json.size(); i++) {
    JSONObject obs = json.getJSONObject(i);
    if (obs.getString("Source").equals("GCAG")) {
      hm.put(obs.getInt("Year"), obs.getFloat("Mean"));
    }
  }
  colorMode(HSB, 100);
  size(680, 200);
  strokeWeight(5);
}

void draw() {
  background(0);
  for (Map.Entry me : hm.entrySet()) {
    int y = (int) me.getKey();
    float m = (float) me.getValue();
    stroke((m<0)?60:100, abs(m*100), 100);
    line(width-5*(2016-y), 0, width-5*(2016-y), height);
  }
  fill(0);
  textSize(20);
  textAlign((mouseX<width/2)?LEFT:RIGHT, (mouseY>height/2)?BOTTOM:TOP);
  int year = 2016-(width-mouseX)/5;
  text ( year+ "\n" + ((hm.get(year)>0)?"+":"")+hm.get(year), mouseX, mouseY);
}
