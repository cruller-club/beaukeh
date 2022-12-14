////////////////////////////////////////////////////////////////////////////////
// https://mika-s.github.io/javascript/random/normal-distributed/2019/05/15/generating-normally-distributed-random-numbers-in-javascript.html

function boxMullerTransform() {
  const u1 = Math.random();
  const u2 = Math.random();
  
  const z0 = Math.sqrt(-2.0 * Math.log(u1)) * Math.cos(2.0 * Math.PI * u2);
  const z1 = Math.sqrt(-2.0 * Math.log(u1)) * Math.sin(2.0 * Math.PI * u2);
  
  return { z0, z1 };
}

function getNormallyDistributedRandomNumber(mean, stddev) {
  const { z0, _ } = boxMullerTransform();
  
  return z0 * stddev + mean;
}
////////////////////////////////////////////////////////////////////////////////

const POPULATION_MEAN = 100;
const POPULATION_STDV = (POPULATION_MEAN / 3);

const SATURATION_MEAN = 50;
const SATURATION_STDV = (SATURATION_MEAN / 3);

const LIGHTNESS_MEAN = 50;
const LIGHTNESS_STDV = (LIGHTNESS_MEAN / 3);

const RADIUS_MEAN = 10;
const RADIUS_STDV = (RADIUS_MEAN / 3);

const CENTER_X_MEAN = 50;
const CENTER_X_STDV = (CENTER_X_MEAN / 3);

const CENTER_Y_MEAN = 50;
const CENTER_Y_STDV = (CENTER_Y_MEAN / 5);

function get_qual_energy(quant) {
  if(quant <= (LIGHTNESS_MEAN - (LIGHTNESS_STDV * 3))){
    return "Draculic";
  }else if(quant <= (LIGHTNESS_MEAN - (LIGHTNESS_STDV * 2))) {
    return "Vantallic";
  } else if(quant <= (LIGHTNESS_MEAN - (LIGHTNESS_STDV * 1))) {
    return "Abyssian";
  } else if(quant <= (LIGHTNESS_MEAN - (LIGHTNESS_STDV * 0))) {
    return "Shadowy";
  } else if(quant <= (LIGHTNESS_MEAN + (LIGHTNESS_STDV * 1))) {
    return "Crepescular";
  } else if(quant <= (LIGHTNESS_MEAN + (LIGHTNESS_STDV * 2))) {
    return "Luminescent";
  } else if(quant <= (LIGHTNESS_MEAN + (LIGHTNESS_STDV * 3))) {
    return "Hyperphaedrous";
  } else {
    return "Ceraphamic";
  }
}

function get_qual_aura(quant) {
  if(quant <= (SATURATION_MEAN - (SATURATION_STDV * 3))){
    return "Depthy";
  }else if(quant <= (SATURATION_MEAN - (SATURATION_STDV * 2))) {
    return "Achromic";
  } else if(quant <= (SATURATION_MEAN - (SATURATION_STDV * 1))) {
    return "Apogeean";
  } else if(quant <= (SATURATION_MEAN - (SATURATION_STDV * 0))) {
    return "Muted";
  } else if(quant <= (SATURATION_MEAN + (SATURATION_STDV * 1))) {
    return "Sottoish";
  } else if(quant <= (SATURATION_MEAN + (SATURATION_STDV * 2))) {
    return "Vivd";
  } else if(quant <= (SATURATION_MEAN + (SATURATION_STDV * 3))) {
    return "Zoirostrous";
  } else {
    return "Sirentious";
  }
}

function get_qual_density(quant) {
  if(quant <= (POPULATION_MEAN - (POPULATION_STDV * 3))){
    return "Voidesmic";
  }else if(quant <= (POPULATION_MEAN - (POPULATION_STDV * 2))) {
    return "Araiosan";
  } else if(quant <= (POPULATION_MEAN - (POPULATION_STDV * 1))) {
    return "Scattered";
  } else if(quant <= (POPULATION_MEAN - (POPULATION_STDV * 0))) {
    return "Sparse";
  } else if(quant <= (POPULATION_MEAN + (POPULATION_STDV * 1))) {
    return "Busy";
  } else if(quant <= (POPULATION_MEAN + (POPULATION_STDV * 2))) {
    return "Frenetic";
  } else if(quant <= (POPULATION_MEAN + (POPULATION_STDV * 3))) {
    return "Gravidrous";
  } else {
    return "Implosive";
  }
}

function rand_population() {
  population = Math.floor(getNormallyDistributedRandomNumber(POPULATION_MEAN, POPULATION_STDV));

  return population;
}

function rand_hue() {
 hue = Math.floor(Math.random() * 360);

 return hue;
}

function rand_saturation() {
  saturation = Math.floor(getNormallyDistributedRandomNumber(SATURATION_MEAN, SATURATION_STDV));

  return saturation;
}

function rand_lightness() {
  lightness = Math.floor(getNormallyDistributedRandomNumber(LIGHTNESS_MEAN, LIGHTNESS_STDV));

  return lightness;
}

function rand_radius() {
  radius = Math.abs(Math.floor(getNormallyDistributedRandomNumber(RADIUS_MEAN, RADIUS_STDV)));

  return radius;
}

function rand_x() {
  cx = Math.abs(Math.floor(getNormallyDistributedRandomNumber(CENTER_X_MEAN, CENTER_X_STDV)));

  return cx;
}

function rand_y() {
  cy = Math.abs(Math.floor(getNormallyDistributedRandomNumber(CENTER_Y_MEAN, CENTER_Y_STDV)));
  
  return cy;
}

function make_circle() {
  hue = rand_hue();
  saturation = rand_saturation();
  lightness = rand_lightness();
  cx = rand_x();
  cy = rand_y();
  radius = rand_radius();
  circle_string = `<circle cx="${cx}%" cy="${cy}%" r="${radius}" style="fill: hsla(${hue}, ${saturation}%, ${lightness}%, 0.15)"></circle>`;

  circle = {
    "circle_string": circle_string,
    "hue": hue,
    "saturation": saturation,
    "lightness": lightness,
    "radius": radius
  };

  return circle;
}

function make_circles(count) {
  circles = [];
  energy = 0;
  aura = 0;

  for(let i = 0; i < count; i++) {
    circle = make_circle();

    energy += circle["lightness"];
    aura += circle["saturation"];

    circles.push(circle["circle_string"]);
  }

  beaukeh = {
    "circles": circles,
    "energy": (energy / count),
    "aura": (aura / count)
  };

  return beaukeh;
}

function make_meta(lightness) {
  if(lightness <= 50) {
    $("#gimme-beaukeh").addClass("text-light");
  } else {
    $("#gimme-beaukeh").addClass("text-dark");
  }
}

function parse_cruller() {
  const params = new Proxy(new URLSearchParams(window.location.search), {
    get: (searchParams, prop) => searchParams.get(prop),
  });
  
  const CRULLER = /^[0-9a-f]{6}$/i;
  
  cruller = params.c;

  if(cruller == null) {
    return null;
  } else if(CRULLER.test(cruller)) {
    console.log(`Cruller from query string: ${cruller}`);

    parsed_cruller = {};
    parsed_cruller["red"] = parseInt(cruller.substring(0,2), 16);
    parsed_cruller["green"] = parseInt(cruller.substring(2,4), 16);
    parsed_cruller["blue"] = parseInt(cruller.substring(4,6), 16);
    parsed_cruller["avg"] = (parsed_cruller["red"] + parsed_cruller["green"] + parsed_cruller["blue"]) / 3;
    parsed_cruller["hex"] = cruller.toUpperCase();

    make_meta(parsed_cruller["avg"]);

    return parsed_cruller;
  } else {
    // Break out.
    window.location.replace("/");
  }
}

function draw_beaukeh() {
  console.log("Hello, Beaukeh!");

  cruller = parse_cruller();

  quant_population = rand_population();

  if(cruller == null) {
    // Paint background.
    background_hue = rand_hue();
    background_saturation = rand_saturation();
    background_lightness = rand_lightness();
    background = `hsl(${background_hue}, ${background_saturation}%, ${background_lightness}%)`

    $("body").css("background", background);

    $("#canvas").attr("href", "/");

    // Determine taxonomy.
    qual_density = get_qual_density(quant_population);
    qual_energy = get_qual_energy(background_lightness);
    qual_aura = get_qual_aura(background_saturation);

    $("#density").text(`${qual_density}`);
    $("#energy").text(`${qual_energy}`);
    $("#aura").text(`${qual_aura}`);
    make_meta(background_lightness);
  } else {
    $("body").css("background", `#${cruller["hex"]}`);

    $("#canvas").attr("href", `/?c=${cruller["hex"]}`)

    //$("#gimme-beaukeh").html("");
  }

  beaukeh = make_circles(quant_population);
 
  circles = beaukeh["circles"].join("");

  $("#beaukeh").html(circles);

  signature = hex_sha256(circles);
  $("#signature").html(signature);

  downloader(signature);
  $("#gimme-beaukeh").attr("download", `${signature}.png`);
}