/* BASE.MSS CONTENTS
 * - 
 * - Landuse & landcover
 * - Water areas
 * - Water ways
 * - Administrative Boundaries
 *
 */

/* ================================================================== */
/* HILLSHADING & CONTOUR LINES
/* ================================================================== */

@contour-width: 0.8;

#contour200[zoom>=13][zoom<16] {
  line-width: @contour-width;
  line-color: @contour;
  line-smooth:0.8;
  opacity:0.4;
  [zoom>=12] {
    line-width: 2 * @contour-width;
  }
}
#contour50[zoom>=13][zoom<18] {
  line-width: @contour-width;
  line-color: @contour;
  line-smooth:0.8;
  opacity:0.4;
  [zoom>=16] {
    line-width: 2 * @contour-width;
  }
}
#contour[zoom>=16] {
  line-width: @contour-width;
  line-color: @contour;
  line-smooth:0.8;
  opacity:0.4;
}

#eudempnr09hillshade::z13[zoom=13] {
  image-filters: agg-stack-blur(1,1);
}

#eudempnr09hillshade::z14[zoom=14] {
  image-filters: agg-stack-blur(3,3);
}

#eudempnr09hillshade::z15[zoom=15] {
  image-filters: agg-stack-blur(8,8);
}

#eudempnr09hillshade::z16[zoom=16] {
  image-filters: agg-stack-blur(14,14);
}

#eudempnr09hillshade::z17[zoom=17] {
  image-filters: agg-stack-blur(24,24);
}

#landuse,
#landuse_gen1,
#landuse_gen0,
#eudempnr09hillshade {
  raster-scaling: bilinear;
  raster-comp-op:multiply;
}

#eudempnr09hillshade {
  raster-opacity:0.2;
}

/* ================================================================== */
/* MOUNTAIN LINES
/* ================================================================== */

#mountain_lines {
  [type='chair_lift'],
  [type='drag_lift'],
  [type='t-bar'],
  [type='j-bar'],
  [type='platter'],
  [type='rope_tow'] {
    [zoom >= 13] {
      line-color: @aerialway;
      line-width: 1.5;
      ::pylons {
        line-color: @aerialway;
        line-width: 6;
        line-dasharray: 1.5,30;
      }
    }
  }
}
#mountain_lines[type='dam'][zoom >= 13] {
  line-color: @aerialway;
  line-width: 3;
}

/* ================================================================== */
/* LANDUSE & LANDCOVER
/* ================================================================== */

#land[zoom>=0][zoom<6],
#shoreline_300[zoom>=6][zoom<10],
#processed_p[zoom>=10] {
  polygon-fill: @land;
  polygon-gamma: 0.75;
}

#landuse_gen0[zoom>3][zoom<=9],
#landuse_gen1[zoom>9][zoom<=12],
#landuse[zoom>12] {
  [type='bare_rock']     { polygon-fill: @rock; }
  [type='cemetery']      { polygon-fill: @cemetery; }
  [type='college']       { polygon-fill: @school; }
  [type='commercial']    { polygon-fill: @industrial; }
  [type='common']        { polygon-fill: @park; }
  [type='forest']        { polygon-fill: @wooded; }
  [type='golf_course']   { polygon-fill: @sports; }
  [type='glacier']       { polygon-fill: @glacier; }
  [type='grass']         { polygon-fill: @grass; }
  [type='grassland']     { polygon-fill: @grass; }
  [type='heath']         { polygon-fill: @heath; }
  [type='hospital']      { polygon-fill: @hospital; }
  [type='industrial']    { polygon-fill: @industrial; }
  [type='meadow']        { polygon-fill: @grass; }
  [type='park']          { polygon-fill: @park; }
  [type='parking']       { polygon-fill: @parking; }
  [type='pedestrian']    { polygon-fill: @pedestrian_fill; }
  [type='pitch']         { polygon-fill: @sports; }
  [type='residential']   { polygon-fill: @residential; }
  [type='school']        { polygon-fill: @school; }
  [type='sports_center'] { polygon-fill: @sports; }
  [type='stadium']       { polygon-fill: @sports; }
  [type='university']    { polygon-fill: @school; }
  [type='wood']          { polygon-fill: @wooded; }
}

#landuse[zoom>12] {
  [type='scree']         { polygon-pattern-file: url(img/scree.png);}
}

#landuse_overlays[type='nature_reserve'][zoom>6] {
  line-color: darken(@wooded,25%);
  line-opacity:  0.3;
  line-dasharray: 1,1;
  polygon-fill: darken(@wooded,25%);
  polygon-opacity: 0.1;
  [zoom=7] { line-width: 0.4; }
  [zoom=8] { line-width: 0.6; }
  [zoom=9] { line-width: 0.8; }
  [zoom=10] { line-width: 1.0; }
  [zoom=11] { line-width: 1.5; }
  [zoom>=12] { line-width: 2.0; }
}
 
#landuse_overlays[type='wetland'][zoom>11] {
  [zoom>11][zoom<=14] { polygon-pattern-file:url(img/marsh-16.png); }
  [zoom>14] { polygon-pattern-file:url(img/marsh-32.png);}
  }

/* ---- BUILDINGS ---- */
#buildings[zoom>=12][zoom<=16] {
  polygon-fill:@building;
  [zoom>=14] {
    line-color:darken(@building,5%);
    line-width:0.3;
  }
  [zoom>=16] {
    line-color:darken(@building,10%);
    line-width:0.6;
  }
}
// At the highest zoom levels, render buildings in fancy pseudo-3D.
// Ordering polygons by their Y-position is necessary for this effect
// so we use a separate layer that does this for us.
#buildings[zoom>=17][type != 'hedge'] {
  building-fill:@building;
  building-height:1.25;
}

#buildings[zoom>=17][type = 'hedge'] {
  building-fill:@wooded;
  building-height:1.25;
}

/* ================================================================== */
/* WATER AREAS
/* ================================================================== */

Map { background-color: @water; }

#water_gen0[zoom>3][zoom<=9],
#water_gen1[zoom>9][zoom<=12],
#water[zoom>12] {
  polygon-fill: @water;
}

/* ================================================================== */
/* WATER WAYS
/* ================================================================== */

#waterway_low[zoom>=8][zoom<=12] {
  line-color: @water;
  [zoom=8] { line-width: 0.1; }
  [zoom=9] { line-width: 0.2; }
  [zoom=10]{ line-width: 0.4; }
  [zoom=11]{ line-width: 0.6; }
  [zoom=12]{ line-width: 0.8; }
}

#waterway_med[zoom>=13][zoom<=14] {
  line-color: @water;
  [type='river'],
  [type='canal'] {
    line-cap: round;
    line-join: round;
    [zoom=13]{ line-width: 1; }
    [zoom=14]{ line-width: 1.5; }
  }
  [type='stream'] {
    [zoom=13]{ line-width: 0.4; }
    [zoom=14]{ line-width: 0.8; }
  }
}
  
#waterway_high[zoom>=15] {
  line-color: @water;
  [type='river'],
  [type='canal'] {
    line-cap: round;
    line-join: round;
    [zoom=15]{ line-width: 2; }
    [zoom=16]{ line-width: 3; }
    [zoom=17]{ line-width: 4; }
    [zoom=18]{ line-width: 5; }
    [zoom=19]{ line-width: 6; }
    [zoom>19]{ line-width: 7; }
  }
  [type='stream'] {
    [zoom=15]{ line-width: 0.6; }
    [zoom=16]{ line-width: 0.8; }
    [zoom=17]{ line-width: 1; }
    [zoom=18]{ line-width: 1.5; }
    [zoom>18]{ line-width: 2; }
  }
  [type='ditch'],
  [type='drain'] {
    [zoom=15]{ line-width: 0.1; }
    [zoom=16]{ line-width: 0.3; }
    [zoom=17]{ line-width: 0.5; }
    [zoom=18]{ line-width: 0.7; }
    [zoom=19]{ line-width: 1; }
    [zoom>19]{ line-width: 1.5; }
  }
}

/* ================================================================== */
/* ADMINISTRATIVE BOUNDARIES
/* ================================================================== */


#admin[admin_level=2][zoom>1] {
  line-color:@admin_2;
  line-width:0.5;
  [zoom=2] { line-opacity: 0.25; }
  [zoom=3] { line-opacity: 0.3; }
  [zoom=4] { line-opacity: 0.4; }
}

#admin[admin_level='8'][zoom>10] {
  line-smooth:0.5;
  line-color:@admin_2;
  line-width:0.8;
  line-dasharray:0.8,5
}

/* ================================================================== */
/* BARRIER POINTS
/* ================================================================== */


#barrier_points[zoom>=17][stylegroup = 'divider'] {
  marker-height: 2;
  marker-fill: #c7c7c7;
  marker-line-opacity:0;
  marker-allow-overlap:true;
}

/* ================================================================== */
/* BARRIER LINES
/* ================================================================== */

#barrier_lines[zoom>=17][stylegroup = 'gate'] {
  line-width:2.5;
  line-color:#aab;
  line-dasharray:3,2;
}

#barrier_lines[zoom>=17][stylegroup = 'fence'] {
  line-width:1.75;
  line-color:#aab;
  line-dasharray:1,1;
}

#barrier_lines[zoom>=17][stylegroup = 'hedge'] {
  line-width:3;
  line-color:darken(@park,5%);

}
