 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GNU GENERAL PUBLIC LICENSE ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;
;; "PaleoCOOP" PaleoCOOP is an evolutionary theoretical Agent-Based Model to explore the effect of cooperation on dispersal under different climate constraints in two study sub-regions, the Altai and Tian Shan Mountains.
;; Copyright (C) 2022-2023
;; María Coto-Sarmiento, PALAEOSILKROAD project, University of Tübingen
;;
;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.
;;
;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
;; Acknowledgements: Víctor Martín Lozano, Andreas Angourakis



extensions [
  vid
  gis
  profiler
  csv
  ]

globals [


  data
  ;; qgis map
  basemap-dataset                      ;; map qgis used with QGIS extension
  min-elevation                        ;; Minimum elevation of the DEM (m)
  max-elevation                        ;; Maximum elevation of the DEM (m)
  attractors-dataset                   ;; dataset of attractors
  caves-dataset                        ;; same dataset but split by caves
  rockshelters-dataset                 ;; same dataset but split by rockshelters
  river-dataset                        ;; dataset of rivers
  lakes-dataset                        ;; dataset of lakes
  patches-region-tienshan              ;; Patches of the region Tien Shan
  patches-region-altai                 ;; Patches of the region Altai

  ; seasonality

  current-month                       ;; check the seasonality and the weather
  total-months


  ; walk

  levy-alpha
  levy-min-step

  ;;  constants of the individuals

  initial-body-temperature             ;; initial body temperature is 37
  maximum-age                          ;; max age random 50
  minimum-reproduction-age             ;; minimum reproduction age is 12

  resource-decrease-rate               ;; resources decrease over time due to the effect of humans in nature
  resource-recovery-rate               ;; resources recover over time


  radius-for-strategy

  ;; why they die

  death-hypothermia                    ;; death by high temperatures
  death-old                            ;; death by old age
  death-starvation                     ;; death by lack of energy caused by exhaustion and lack of food, etc.

  ;; global parameters

  prob-coop                            ;; probability of initial cooperation
  cost                                 ;; cost of cooperation
  punishment                           ;; punishment of cooperation. Mostly no cooperatives
  no-coop                              ;; probability hominins don't cooperate

]


;;;;;;;;;;;;;;
;;; BREEDS ;;;
;;;;;;;;;;;;;;


breed [places place]                  ;; possible attractors from Tien Shan and Altai
breed [ hominins hominin ]            ;; hominins from Tien Shan
breed [ heminins heminin ]            ;; hominins from Altai



;; DISCLAIMER! Hominins are hominins from Tien Shan and HEminins are hominins from Altai in this model

hominins-own [                        ;; display hominins from Tien Shan

  age                                 ;; age of individuals. Average human age is 25
  traits                              ;; hominins transmit and spread traits to others. Used only in to get-traits
  cooperate?                          ;; able to cooperate with hominins. True or false
  energy                              ;; energy that hominins consumed walking
  risk                                ;; perception of risk
  body-temperature                    ;; body temperature average of humans is 37ºC
  social-strategy                     ;; hominins can choose a social strategy to follow: random, cooperation, defective, tit for tat
  pay-off-tienshan                    ;; pay-off between cost and punishment
  delta-p                             ;; rate of change of cooperative population
]


heminins-own [                        ;; display hominins from Altai

  age                                 ;; age of individuals. Average human age is 25
  traits                              ;; hominins transmit and spread traits to others. Use only in to get-traits
  cooperate?                          ;; able to cooperate with hominins. True or false.
  energy                              ;; energy that hominins consumed walking
  risk                                ;; perception of risk
  body-temperature                    ;; body temperature average of humans is 37ºC
  social-strategy                     ;; hominins can choose a social strategy to follow: random, cooperation or defective
  pay-off-altai                       ;; pay-off between cost and punishment
  delta-p                             ;; rate of change of cooperative population
]


patches-own [
  elevation                          ;; convert elevation of DEM.asc dataset
  water                              ;; True or false. Distinguishes between land patches and ones covered in water AND MONTAINS


  ;; temperature                     ;; use to check if temperature split is correct.
  climate-temperature                ;; climate temperature for Tien Shan and Altai (check the differences between scenarios)
  resources                          ;; resources of the patches
  noresources?                       ;; no resources of the patches. True or false
  attractors?                        ;; identify patches as potential attractors. True or false
  origin-tienshan?                   ;; patches where humans go there in Tien Shan
  origin-altai?                      ;; patches where humans go there in Altai


]


places-own [

  attractor-resources   ;; attractors resources for places. they have more resources than the rest

]


;;;;;;;;;;;;;;;;;;;
;;; MODEL SETUP ;;;
;;;;;;;;;;;;;;;;;;;


to setup

  clear-all

  reset-timer
  show (word "Simulation " behaviorspace-run-number " started at " date-and-time)
  if maxTimeSteps = "" [set maxTimeSteps 0]

  random-seed seed

  set current-month 0
  set total-months 0

  ;; setup-constants (former magic numbers/hardcoded values)

  set initial-body-temperature 37                      ;; body temperature average of humans is 37ºC
  set maximum-age 50 * 12                              ;; max age random 50
  set minimum-reproduction-age 12 * 12                 ;; min reproduction rate is 12

  set levy-alpha 2                                     ;; by default 1.5 value alpha where the steps are + shorter - larger
  set levy-min-step 0.2

  set resource-decrease-rate 0.1
  set resource-recovery-rate 1

  set radius-for-strategy 3                            ;; this is the radius of strategy used for social pressure condition

  setup-parameters                 ;; setup all the parameters for the evolutionary equation

  setup-maps                       ;; setup the map with rivers and lakes and real points
  display-map
  display-elevation-in-patches     ;; display elevations
  setup-patches-region             ;; setup patches for Altai and TienShan. Half of the world with TianShan temperature, Half of the world with Altai, based on BioClim
  ;display-elevation               ;; use only for scale black and white

  setup-resources                  ;; setup all the resources
  setup-climate-temperature        ;; setup the climate temperature for two places: Tien Shian and Altai.


  ;; The simulation can take a long time. It is recommended not to simulate the two breeds at the same time

  setup-hominins                  ;; describe individuals in Tien Shan
  ;setup-heminins                   ;; describe individuals in Altai
  setup-places                     ;; start creating two atractor places in Tien Shan and Altai


  reset-ticks

  end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   SETUP CONSTANTS AND PARAMETERS    ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


to setup-parameters

  set prob-coop prob-cooperation                       ;; probability of cooperation
  set cost cost-cooperation                            ;; cost of cooperation. Use slider to change
  set punishment punishment-cooperation                ;; punishment cooperation. Use slider to change
  set no-coop prob-nocoop                              ;; probability individuals do not cooperate

end


 to setup-patches-region

  ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim

  set patches-region-tienshan patches with [(pxcor <= 303)]

  set patches-region-altai patches with [(pxcor > 303)]

;   ask patches [
;    ifelse (pxcor <= 266.5)
;    [ set patches-region "TienShan" ]      ;; TienShan study area
;    [ set patches-region "Altai"  ]        ;; Altai study area
;   ]

end




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; GIS and BACKGROUND  ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to setup-maps


let world-wd 0
let world-ht 0

;; load maps asc and shps files
set basemap-dataset gis:load-dataset "data/maps/DEM.asc"                        ;; Uploads the DEM map
;; set attractors-dataset gis:load-dataset "data/maps/sites_kaza.shp"           ;; old database. We integrate more database from ROCEEH project PSR_data.shp
set attractors-dataset gis:load-dataset "data/maps/PSR_data.shp"                ;; database with sites
set caves-dataset gis:load-dataset "data/maps/caves.shp"                        ;; database with caves
set rockshelters-dataset gis:load-dataset "data/maps/rockshelter.shp"           ;; database with rockshelter
set river-dataset gis:load-dataset "data/maps/rivers_clipped.shp"               ;; database with rivers
set lakes-dataset gis:load-dataset "data/maps/lake_clipped.shp"                 ;; database with lakes
gis:set-sampling-method basemap-dataset "BICUBIC_2"                             ;; Sets the resampling to bicubic (see netlogo guide) skip for elevator raster
;;; you will notice a warning, just ignore it I guess
gis:load-coordinate-system "data/maps/projection.prj" ;arreglarlo porque creo que hay un error en observer


;; set the environment in patches

let gis-wd gis:width-of basemap-dataset
let gis-ht gis:height-of basemap-dataset
ifelse gis-wd >= gis-ht
  [set world-wd world-max-dim
   set world-ht int (gis-ht * world-wd / gis-wd)]
  [set world-ht world-max-dim
   set world-wd int (gis-wd * world-ht / gis-ht)]

resize-world 0 world-wd 0 world-ht
gis:set-world-envelope gis:envelope-of basemap-dataset

set-patch-size ( 2 * patch-size-km )                                          ;; set patches size for the map

; resize-world 0 533 0 327 ;; resize the world
;gis:paint basemap 0 ;; use only if you are using black/white scale

;; Set the world envelope to the union of all datasets
gis:set-world-envelope (gis:envelope-union-of (gis:envelope-of basemap-dataset)
                                              (gis:envelope-of attractors-dataset)
                                              (gis:envelope-of river-dataset)
                                              (gis:envelope-of lakes-dataset))


gis:apply-raster basemap-dataset elevation                                   ;; give elevation values
set min-elevation gis:minimum-of basemap-dataset                             ;; max elevation Reports the highest value in the given raster dataset
set max-elevation gis:maximum-of basemap-dataset                             ;; min elevation Reports the lowest value in the given raster dataset

end



to display-elevation-in-patches                                               ;; display elevation in patches

;; To give neutral values to side patches that may be overlooked by the DEM import (removes be NA)

  ask patches

  [ ifelse ( elevation <= 0 ) or ( elevation >= 0 )
    [ set elevation elevation ]
    [ set elevation 0 ]

    set water false
    if (elevation <= 0 or elevation >= mountain-elev) [ set water true ]  ;; I hope they can´t go to the mountains

    update-color-elev

  ]


end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; UPDATE COLOR PATCHES ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; update color elevation patches


  to update-color-elev

   ifelse (elevation <= 0)
    [ set pcolor scale-color blue elevation min-elevation 1000 ]
    [ ifelse (elevation < mountain-elev)
      [ set pcolor scale-color green elevation -1000 max-elevation ]
      [ set pcolor scale-color 36 elevation 1000 max-elevation ]
    ]

  end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; DISPLAY MAP CONTEXT ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to display-map                                ;; display all the map included the sites from the paleosilkroad project and the lakes and rivers
;display-attractors                           ;; if you want to display everything
display-rivers                                ;; display rivers
display-lakes                                 ;; display lakes
end

to display-attractors

  gis:set-drawing-color white                 ;; display archaeological places with points
  gis:draw attractors-dataset 2

 ;; let atractor-patches patches gis:intersecting attractors-dataset

end

to display-rivers
  gis:set-drawing-color blue ;set the water with rivers and lakes
  gis:draw river-dataset 1
  let river-patches patches gis:intersecting river-dataset

  ;ask river-patches
    ;[set attractors? false
     ;set water false
     ;set resources resources + 50
  ;]

end

to display-lakes
  gis:set-drawing-color blue
  gis:fill lakes-dataset 1
  let lake-patches patches gis:intersecting lakes-dataset

  ;ask lake-patches
    ;[set attractors? false
     ;set water false
     ; set resources resources + 50
  ;]

end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; if you want to split by caves and rockshelters separately ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;to display-caves
;  gis:set-drawing-color yellow
;  gis:draw caves-dataset 2
;end

;to display-rockshelters
;  gis:set-drawing-color blue
;  gis:draw rockshelters-dataset 1
;end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; SETUP TEMPERATURE (TIENSHAN AND ALTAI) ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Estimation for temperature in Altai and Tien Shan. For more info see paper:
;; Glantz, M., Van Arsdale, A., Temirbekov, S., & Beeton, T. (2018). How to survive the glacial apocalypse: Hominin mobility strategies in late Pleistocene Central Asia.
;; Quaternary International, 466, 82-92. Table 2.



to setup-climate-temperature

 if scenario = "Scenario1" [                      ;; Mean of the total of the annual temperature in Cº for glacial and interglacial scenario

    ask patches [
    ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
    [ set climate-temperature 6 ]                 ;; TienShan study area
    [ set climate-temperature -4  ]               ;; Altai study area
   ]
  ]

 if scenario = "Scenario2" [                      ;; Mean temperature in Cº for the coldest quarter in glacial scenario
    ask patches [
    ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
    [ set climate-temperature -7 ]                ;; TienShan study area
    [ set climate-temperature -21.5  ]            ;; Altai study area
   ]
  ]


  if scenario = "Scenario3" [                     ;; Mean temperature in Cº for the coldest quarter in interglacial scenario
    ask patches [
    ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
    [ set climate-temperature -9.6 ]              ;; TienShan study area
    [ set climate-temperature -20  ]              ;; Altai study area
   ]
  ]

 if scenario = "Scenario4" [                      ;; Mean temperature in Cº of the warmest quarter in interglacial scenario
    ask patches [
    ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
    [ set climate-temperature 25 ]                ;; TienShan study area
    [ set climate-temperature 19.4 ]              ;; Altai study area
   ]
  ]



end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;; SETUP HOMININS AND HEMININS ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


to setup-hominins                                             ;; create individuals from Tien Shan

  create-hominins nHominins [

    setxy 46 42                                               ;; it could be any place choosen randomly. by setxy random-xcor random-ycor
    set shape "person"
    set size 10                                               ;; set one by default
    set body-temperature initial-body-temperature             ;; body temperature average of humans is 37ºC
    set age random maximum-age                                ;; average human age is 25
    setup-initial-cooperation                                         ;; how humans start cooperate
    set energy max-energy                                     ;; all hominins start with max-energy that you can set up
    set risk human-risk                                       ;; perception of the risk in individuals. Use the slider

    ;pen-down
  ]
 end

to setup-heminins                                             ;; create individuals from Altai

  create-heminins nHominins [

   set shape "person"
   set size 10
   setxy 414 297
   set age random maximum-age                                 ;; average human age is 25
   set body-temperature initial-body-temperature              ;; body temperature average of humans is 37ºC
   setup-initial-cooperation                                          ;; how humans start cooperate
   set energy max-energy                                      ;; all hominins start with max-energy that you can set up
   set risk human-risk                                        ;; perception of the risk in individuals. Use the slider

  ]

end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; SETUP attractors PLACES ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


to setup-places                                              ;; random attractor places were created with extra resources. Reds are in Tien Shan and Blue in Altai

  make-place 1 111 69 red
  make-place 1 246 91 red
  make-place 1 57  93 red
  make-place 1 431 217 sky
  make-place 1 463 273 sky
  make-place 1 365 259 sky

end

to make-place [numb x y a-color ]
 create-places numb [
    setxy x y
    set size 5
    set shape "atractor"              ;; it does not work, use below
    ;; set shape "house"
    set attractor-resources 100       ;; extra resources
    set color a-color
    set attractors? true
  ]
end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; SETUP COOPERATION BEHAVIOUR  ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; setup of cooperation at the begining using the prob-cooperation: 0.50 is 50 % are cooperators and 50 % no cooperators (defectors)


to setup-initial-cooperation



  let num-cooperators round (prob-coop * count heminins)
  let num-cooperators-hominins round (prob-coop * count hominins)
  let cooperators-count 0
  let non-coop 0

   ask hominins [
    ifelse (cooperators-count < num-cooperators-hominins) [
      set color green
      set cooperate? true
      set traits 1
      set cooperators-count cooperators-count + 1
    ] [
      set color red
      set cooperate? false
      set traits 0
      set non-coop non-coop + 1

    ]
  ]

  ask heminins [
    ifelse (cooperators-count < num-cooperators) [
      set color green
      set cooperate? true
      set traits 1
      set cooperators-count cooperators-count + 1
    ] [
      set color red
      set cooperate? false
      set traits 0
      set non-coop non-coop + 1

    ]
  ]



; ask hominins [
;      ifelse (random-float 1.0 < prob-coop) [
;      set color green
;      set cooperate? true
;      set traits 1
;    ] [
;      set color red
;      set cooperate? false
;      set traits 0
;    ]
;  ]
;

;  ask heminins [
;      ifelse (random-float 1.0 < prob-coop) [
;      set color green
;      set cooperate? true
;      set traits 1
;    ] [
;      set color red
;      set cooperate? false
;      set traits 0
;    ]
;  ]

end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;; SETUP ENVIROMENT AND RESOURCES ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Note: Humans are looking for better resources. Here we have the assumption that more resources are located in the
;; places where we have archaeological data


to setup-resources

;; all the patches have resources with a random value of 50 except the patches with better resources with 100.
;; some places were selected according to archaological data where better resources can be found.

ask patches [
  set resources random 50 ;; patches have random resources at the beginning. Patches closer to places will have more resources than random patches.
  set attractors? false
  ]


;; TIEN SHAN RESOURCES


  ask patches  [                     ;; tien shan resources
   if (pxcor > 94
    and pxcor < 121
    and pycor > 62
    and pycor < 92) or
    (pxcor > 53
    and pxcor < 97
    and pycor > 75
    and pycor < 97)
  [set resources 100
    set attractors? true
    set origin-tienshan? true
    set noresources? false
    ;set pcolor 53  ;; if you want to see the resources select the color
  ]
  ]


 ask patches  [                       ;; tien shan resources
   if (pxcor > 235
    and pxcor < 302
    and pycor > 83
    and pycor < 99)
  [set resources 100
    set attractors? true
    set origin-tienshan? false
    set noresources? false
    ;set pcolor 53
  ]
  ]


;; ALTAI RESOURCES


 ask patches [                        ;; altai resources
    if ( pxcor > 450
     and pxcor < 481
     and pycor > 273
     and pycor < 290) or
     (pxcor > 348
    and pxcor < 387
    and pycor > 247
    and pycor < 270)
   [set resources 100
     set attractors? true
     set origin-altai? true
     set noresources? false
     ;set pcolor 53
   ]
  ]


ask patches [                          ;; altai resources
    if (pxcor > 398
    and pxcor < 447
    and pycor > 207
    and pycor < 232)
  [set resources 100
    set attractors? true
    set origin-altai? false
    set noresources? false
    ;set pcolor 53
  ]
  ]


end

to update-temperature

  ;; temperature is changing every three months. Remember the simulation is split by two enviromments: Tien Shan and Altai with different temperatures

  set current-month current-month + 1
   if current-month = 13 [
    set total-months total-months + 12
    set current-month 1 ; Start again
  ]
  ;print (word "Current Month: " current-month)


  if scenario = "Scenario1" [

  ;; Mean of the total of the annual temperature in Cº for glacial and interglacial scenario
  if current-month = 1 or current-month = 2 or current-month = 12 [     ;; winter time
    ask patches [
      ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature -0.98 ]           ;; TienShan study area
        [ set climate-temperature -16.4 ]           ;; Altai study area
    ]
  ]

    if current-month = 3 or current-month = 4 or current-month = 5 [    ;; spring time
      ask patches [
      ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature 11.26 ]           ;; TienShan study area
        [ set climate-temperature 2.60 ]            ;; Altai study area
    ]
  ]

    if current-month = 6 or current-month = 7 or current-month = 8 [    ;; summer time
      ask patches [
      ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature 24.42 ]           ;; TienShan study area
        [ set climate-temperature 19.37 ]           ;; Altai study area
    ]
  ]

    if current-month = 9 or current-month = 10 or current-month = 11 [   ;; autunn time
       ask patches [
       ifelse (pxcor <= 266.5)                  ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature 12.35 ]           ;; TienShan study area
        [ set climate-temperature 3.97 ]           ;; Altai study area
    ]
  ]
]

  if scenario = "Scenario4" [

    if current-month = 1 or current-month = 2 or current-month = 12 [     ;; winter time
      ask patches [
      ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature 3.67 ]            ;; TienShan study area
        [ set climate-temperature -10.05 ]          ;; Altai study area
    ]
  ]

    if current-month = 3 or current-month = 4 or current-month = 5 [    ;; spring time
      ask patches [
      ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature 16.64 ]           ;; TienShan study area
        [ set climate-temperature 9.83 ]            ;; Altai study area
    ]
  ]

     if current-month = 6 or current-month = 7 or current-month = 8 [    ;; summer time
      ask patches [
      ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature 31.59 ]           ;; TienShan study area
        [ set climate-temperature 27.18 ]                ;; Altai study area
    ]
  ]

    if current-month = 9 or current-month = 10 or current-month = 11 [   ;;autunn time

        ask patches [
        ifelse (pxcor <= 266.5)                     ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature 18.76 ]           ;; TienShan study area
        [ set climate-temperature 10.88 ]           ;; Altai study area
    ]
   ]
  ]


  if scenario = "Scenario2" or scenario = "Scenario3" [


    if current-month = 1 or current-month = 2 or current-month = 12 [     ;; winter time
      ask patches [
      ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature -7 ]              ;; TienShan study area
        [ set climate-temperature -20 ]             ;; Altai study area
    ]
  ]

    if current-month = 3 or current-month = 4 or current-month = 5 [    ;; spring time
      ask patches [
      ifelse (pxcor <= 266.5)                        ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature 7.29 ]             ;; TienShan study area
        [ set climate-temperature -4.42 ]            ;; Altai study area
    ]
  ]

    if current-month = 6 or current-month = 7 or current-month = 8 [    ;; summer time
      ask patches [
      ifelse (pxcor <= 266.5)                       ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature  19.20 ]                ;; TienShan study area
        [ set climate-temperature  11.54 ]                ;; Altai study area
    ]
  ]

      if current-month = 9 or current-month = 10 or current-month = 11 [   ;;autunn time

        ask patches [
        ifelse (pxcor <= 266.5)                     ;; half of the world with TianShan temperature, half of the world with Altai, based on BioClim
        [ set climate-temperature 4.95 ]           ;; TienShan study area
        [ set climate-temperature -2.92 ]           ;; Altai study area
    ]
   ]
  ]


end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; SELECT SOCIAL STRATEGIES and COOPERATION ;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

to select-strategy ;; they are moving according to get better resources

;set radius-for-strategy 3

;; hominins no cooperatives can become in cooperatives based on Henrich and Boyd evolutionary model

  ask hominins with [cooperate? = false] [
   ; if any? hominins with [cooperate? = true] in-radius 1 [
    if any? hominins with [cooperate? = true] in-radius radius-for-strategy [
      set pay-off-tienshan get-payoff-tienshan
      set delta-p get-deltap-tienshan
      if random-float 1 < delta-p [
        set cooperate? true
        set color green
    ]
   ]
  ]

  ask heminins with [cooperate? = false] [
    if any? heminins with [cooperate? = true] in-radius radius-for-strategy [ ;; cambiar el radio
      set pay-off-altai get-payoff-altai
      set delta-p get-deltap-altai
      if random-float 1 < delta-p [
        set cooperate? true
        set color green
    ]
   ]
  ]


;; hominins cooperatives can become in no cooperatives: 1. probability of no cooperation in no-attractors, 2. defectors around in attractors resources (social pressure) and 3. low resources (high probability * 2)

  ask hominins with [cooperate? = true] [
   ; if any? patches with [attractors? = false] in-radius 3 [
    if any? patches with [attractors? = false] in-radius radius-for-strategy [
      if random-float 1.0 < no-coop [
        set cooperate? false
        set color red
      ]
    ]
    if any? patches with [attractors? = true and resources > 20]  in-radius radius-for-strategy [
    if random-float 1.0 < no-coop [
        set cooperate? false
        set color red
      ]
    ]
    if any? patches with [attractors? = true and resources < 20]  in-radius radius-for-strategy [
    if random-float 1.0 < no-coop * 2 [
        set cooperate? false
        set color red
      ]
    ]
  ]



   ask heminins with [cooperate? = true] [
    if any? patches with [attractors? = false] in-radius radius-for-strategy [
      if random-float 1.0 < no-coop [
        set cooperate? false
        set color red
      ]
    ]
    if any? patches with [attractors? = true and resources > 20]  in-radius radius-for-strategy [
    if random-float 1.0 < no-coop [
        set cooperate? false
        set color red
      ]
    ]
    if any? patches with [attractors? = true and resources < 20]  in-radius radius-for-strategy [
    if random-float 1.0 < no-coop * 2 [
        set cooperate? false
        set color red
      ]
    ]
  ]

 end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;; TO REPORT COOPERATION EQUATION BY HENRICH AND BOYD ;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;Cooperation equation based on:

;;Henrich, J., & Boyd, R. (2001).
;;Why people punish defectors: Weak conformist transmission can stabilize costly enforcement of norms in cooperative dilemmas.
;;Journal of theoretical biology, 208(1), 79-89.
;;DOI: https://doi.org/10.1006/jtbi.2000.2202

to-report get-payoff-tienshan

  setup-parameters

  report ( 1 - no-coop ) * ( count hominins with [cooperate? = true] * ( 1 - no-coop ) * punishment - cost )
  ;report count hominins with [cooperate? = true] * punishment - cost ;; without using no-coop as a variable
end

to-report get-payoff-altai

  setup-parameters

  report ( 1 - no-coop ) * ( count heminins with [cooperate? = true] * ( 1 - no-coop ) * punishment - cost )
  ; report count heminins with [cooperate? = true] * punishment - cost ;; without using no-coop as a variable
end

to-report get-deltap-tienshan

  setup-parameters

  report (count hominins with [cooperate? = true] / count hominins) * (1 - (count hominins with [cooperate? = true] / count hominins) ) * ( (1 - alpha) * get-payoff-tienshan / ( abs (( 1 - no-coop ) * (count hominins * ( 1 - no-coop ) * punishment - cost))) + alpha * ( 2 * (count hominins with [cooperate? = true] / count hominins) - 1 ) ) ;; adding prob. no cooperation
  ;report count hominins with [cooperate? = true] * (1 - (count hominins with [cooperate? = true] / nHominins) ) * (1 - alpha) *  get-payoff-tienshan / (nHominins * abs (nHominins * punishment - cost))  ;; no conformist
  ;report (count hominins with [cooperate? = true] / nHominins) * (1 - (count hominins with [cooperate? = true] / nHominins) ) * ( (1 - alpha) *  get-payoff-tienshan / ( abs (nHominins * punishment - cost)) + alpha * ( 2 * (count hominins with [cooperate? = true] / nHominins) - 1 ) ) ;; conformism added

end

to-report get-deltap-altai

  setup-parameters

  report (count heminins with [cooperate? = true] / count heminins) * (1 - (count heminins with [cooperate? = true] / count heminins) ) * ( (1 - alpha) * get-payoff-altai / ( abs (( 1 - no-coop ) * (count heminins * ( 1 - no-coop ) * punishment - cost))) + alpha * ( 2 * (count heminins with [cooperate? = true] / count heminins) - 1 ) ) ;; adding prob. no cooperation

end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; CHECK ENVIROMMENTS AND POSSIBLE SCENARIOS ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; CORREGIR ESTO QUE ESTÁ MAL
to check-scenarios


  if scenario = "Scenario1" [Scenario1] ;; scenario with annual temperature conditions (glacial and interglacial)
  if scenario = "Scenario2" [Scenario2] ;; scenario with coldest temperature condition (glacial)
  if scenario = "Scenario3" [Scenario3] ;; scenario with coldest temperature condition (interglacial)
  if scenario = "Scenario4" [Scenario4] ;; scenario with warmest temperature (interglacial)

end


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; SCENARIO 1 ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;


;; Scenario with annual temperature average


to Scenario1  ;; Scenario with annual temp average


   if random-float 1.0 <= learning-rate                                            ;; hominins need to learn the path to arrive to attractor places
    [check-scenario-1]

end


to check-scenario-1


   ;; scenario 1 TIEN SHAN ;;

    ask hominins with [cooperate? = true] [
    let patches-tienshan patches-region-tienshan with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 25                                                  ;; cooperatives consume less resources than no cooperatives
      found-places                                                                  ;; hominins try to found new places where they find more resources.
    ]
    [
      ifelse any? patches-tienshan in-radius 40
      [ face one-of patches-tienshan in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [ consume-energy
        check-temperature
      ]
    ]
  ]


  ask hominins with [cooperate? = false] [
    let patches-tienshan patches-region-tienshan with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 45                                                  ;; defectors consume more resources because they don´t care about people!
      found-places                                                                  ;; hominins try to found new places where they find more resources.
    ]
    [
      ifelse any? patches-tienshan in-radius 40
      [face one-of patches-tienshan in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [ consume-energy
        check-temperature
      ]
    ]
  ]


  ;; scenario 1 ALTAI ;;

  ask heminins with [cooperate? = true] [
    let patches-altai patches-region-altai with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 30
      found-places
    ]
    [
      ifelse any? patches-altai in-radius 40
      [face one-of patches-altai in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [ consume-energy
        check-temperature
      ]
    ]
  ]


  ask heminins with [cooperate? = false] [
    let patches-altai patches-region-altai with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 50
      found-places
    ]
    [
      ifelse any? patches-altai in-radius 40
      [face one-of patches-altai in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [ consume-energy
        check-temperature
      ]
    ]
  ]



;; individuals can get extra energy using the attractor points randomly located in both areas. Now is in found places


end


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; SCENARIO 2 ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;


;; scenario with coldest temperature condition (glacial)


;; hominins will spend more energy
;; hominins will consume more resources than other scenarios (no cooperative will consume more)


;; Scenario 2 TIEN SHAN ;;


to Scenario2 ;; glacial coldest condition

  if random-float 1.0 <= learning-rate
     [check-scenario-2]

end

to check-scenario-2

    ask hominins with [cooperate? = true] [
    let patches-tienshan patches-region-tienshan with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 20 ;; hominins consume more resources
      found-places ;; hominins try to found new places where they find more resources.
    ]
    [
      ifelse any? patches-tienshan in-radius 40
      [face one-of patches-tienshan in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [consume-energy
      check-temperature
      ]
    ]
  ]


 ask hominins with [cooperate? = false] [
    let patches-tienshan patches-region-tienshan with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 40 ;; hominins no cooperative consume more resources
      found-places ;; hominins try to found new places where they find more resources.
    ]
    [
      ifelse any? patches-tienshan in-radius 40
      [face one-of patches-tienshan in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [consume-energy
       check-temperature
      ]
    ]
  ]


  ;; Scenario 2 ALTAI ;;


    ask heminins with [cooperate? = true] [
    let patches-altai patches-region-altai with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 25
      found-places
    ]
    [
      ifelse any? patches-altai in-radius 40
      [face one-of patches-altai in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [consume-energy
      check-temperature
      ]
    ]
  ]

  ask heminins with [cooperate? = false] [
    let patches-altai patches-region-altai with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 45
      found-places
    ]
    [
      ifelse any? patches-altai in-radius 40
      [face one-of patches-altai in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [consume-energy
       check-temperature
      ]
    ]
  ]

end


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; SCENARIO 3 ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;


;; scenario with coldest temperature condition (interglacial)

;; hominins will spend more energy
;; hominins will consume more resources than other scenarios (no cooperative will consume more)


to Scenario3 ;; glacial coldest condition

  if random-float 1.0 <= learning-rate
     [check-scenario-3]

end

to check-scenario-3

    ask hominins with [cooperate? = true] [
    let patches-tienshan patches-region-tienshan with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 20
      found-places
    ]
    [
      ifelse any? patches-tienshan in-radius 40
      [face one-of patches-tienshan in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [consume-energy
       check-temperature
      ]
    ]
  ]


  ask hominins with [cooperate? = false] [
    let patches-tienshan patches-region-tienshan with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 40
      found-places
    ]
    [
      ifelse any? patches-tienshan in-radius 40
      [face one-of patches-tienshan in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [consume-energy
       check-temperature
      ]
    ]
  ]


  ask heminins with [cooperate? = true] [
    let patches-altai patches-region-altai with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 25
      found-places
    ]
    [
      ifelse any? patches-altai in-radius 40
      [face one-of patches-altai in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [consume-energy
      check-temperature
      ]
    ]
  ]


  ask heminins with [cooperate? = false] [
    let patches-altai patches-region-altai with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 45
      found-places
    ]
    [
      ifelse any? patches-altai in-radius 40
      [face one-of patches-altai in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [consume-energy
       check-temperature
      ]
    ]
  ]




end


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;; SCENARIO 4 ;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;


;; scenario with warmest temperature (glacial and interglacial)



to Scenario4 ;; warmest conditions

   if random-float 1.0 <= learning-rate
     [check-scenario4]

end

to check-scenario4


    ask hominins with [cooperate? = true] [
    let patches-tienshan patches-region-tienshan with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 20
      found-places
    ]
    [
      ifelse any? patches-tienshan in-radius 40 ; estaba puesto 30
      [face one-of patches-tienshan in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [ consume-energy
        check-temperature
      ]
    ]
  ]


  ask hominins with [cooperate? = false] [
    let patches-tienshan patches-region-tienshan with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 40
      found-places
    ]
    [
      ifelse any? patches-tienshan in-radius 40
      [face one-of patches-tienshan in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [ consume-energy
        check-temperature
      ]
    ]
  ]



  ask heminins with [cooperate? = true] [
    let patches-altai patches-region-altai with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 25
      found-places
    ]
    [
      ifelse any? patches-altai in-radius 40
      [face one-of patches-altai in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [ consume-energy
        check-temperature
      ]
    ]
  ]



  ask heminins with [cooperate? = false] [
    let patches-altai patches-region-altai with [resources > 80]
    ifelse [resources] of patch-here > 80
    [
      consume-energy
      check-temperature
      set resources resources - 45 ;; hominins no cooperative consume more resources
      found-places ;; hominins try to found new places where they find more resources.
    ]
    [
      ifelse any? patches-altai in-radius 40
      [face one-of patches-altai in-radius 40
       forward 1
       consume-energy
       check-temperature
      ]
      [ consume-energy
        check-temperature
      ]
    ]
  ]

end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;  HUMANS DO THINGS ACCORDING TO DIFFERENT SCENARIOS  ;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;;;;;;;;;;;;;;;;;;;;
;;;   ENERGY     ;;;
;;;;;;;;;;;;;;;;;;;;


to consume-energy

  ;; energy 1% = 0.01 y 0.1% = 0.001
  ;; individuals consume energy differently when they are close to attractors places (less energy) and they are far from them (more energy)


 ;;;; CONSUME ENERGY IN SCENARIO 1 ;;;;

  if scenario = "Scenario1" [

    ask hominins [

      ifelse attractors? = true [
        set risk risk - 0.1
        ifelse risk <= human-risk [
        set energy energy - 0.01 ]
        [set energy energy - 0.1 ]
    ]
    [
        set energy energy - 0.1
        set risk risk + 0.1
        if risk > 80 [
        set energy energy - 0.12
        ]
      ]
    ]


    ask heminins [

      ifelse attractors? = true [
        set risk risk - 0.15
        ifelse risk <= human-risk [
        set energy energy - 0.015 ]
        [set energy energy - 0.15 ]
    ]
    [  ;; Altai is more extreme so humans spend more energy and the perception of the risk is higher than Tien Shan
        set energy energy - 0.15
        set risk risk + 0.15
        if risk > 80 [
        set energy energy - 0.20
        ]
      ]
    ]

   ]


  ;;;; CONSUME ENERGY IN SCENARIO 2 ;;;;


  if scenario = "Scenario2" [

    ask hominins [

      ifelse attractors? = true [
       set risk risk - 0.2
       ifelse risk <= human-risk [
        set energy energy - 0.02
      ][set energy energy - 0.15]
    ]
    [
        set energy energy - 0.2
        set risk risk + 0.4
        if risk > 80 [
        set energy energy - 0.25
        ]
      ]
    ]


    ask heminins [
        ifelse attractors? = true [
          set risk risk - 0.3
          ifelse risk <= human-risk [
          set energy energy - 0.025
          ][set energy energy - 0.20]
          ]
          [
        set energy energy - 0.3
        set risk risk + 0.5
        if risk > 80 [
        set energy energy - 0.30
        ]
      ]
    ]

   ]


   ;;;; CONSUME ENERGY IN SCENARIO 3 ;;;;

   if scenario = "Scenario3" [

     ask hominins [

      ifelse attractors? = true [
        set risk risk - 0.2
        ifelse risk <= human-risk [
        set energy energy - 0.02
      ][set energy energy - 0.15]
    ]
      [
        set energy energy - 0.2
        set risk risk + 0.4
        if risk > 80 [
        set energy energy - 0.25
        ]
      ]
    ]

      ask heminins [

        ifelse attractors? = true [
          set risk risk - 0.3
          ifelse risk <= human-risk [
          set energy energy - 0.025
      ][  set energy energy - 0.20]
    ]
        [
         set energy energy - 0.3
         set risk risk + 0.5
         if risk > 80 [
         set energy energy - 0.30
        ]
      ]
    ]

   ]


 ;;;; CONSUME ENERGY IN SCENARIO 4 ;;;;

  ;; temperature between interglacial and glacial are a bit similar bt regions (Altai and Tien Shan) so we include the same energy bt hominins and heminins bc the variation bt temperatures is not a lot

  if scenario = "Scenario4" [

      ask hominins [

       ifelse attractors? = true [
        set risk risk - 0.1
        ifelse risk <= human-risk [
        set energy energy - 0.01
      ][ set energy energy - 0.1]
    ] [
        set energy energy - 0.11
        set risk risk + 0.1
        if risk > 80 [
        set energy energy - 0.12

        ]
      ]
    ]

     ask heminins [
      ifelse attractors? = true [
        set risk risk - 0.1
        ifelse risk <= human-risk [
        set energy energy - 0.01
      ][ set energy energy - 0.1]
      ][
        set energy energy - 0.11
        set risk risk + 0.1
        if risk > 80 [
        set energy energy - 0.12
        ]
      ]
      ]

    ]



  ;; When humans have not energy they die

  ask hominins [
    if energy >= max-energy [set energy max-energy]                                        ;; they cannot exceed the limit of energy using max-energy slider
    if energy <= 0 [set death-starvation death-starvation + 1 die]                         ;; no energy of course die
  ]

  ask heminins [
    if energy >= max-energy [set energy max-energy]
    if energy <= 0 [set death-starvation death-starvation + 1 die]                         ;; no energy of course die
  ]


end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;   BODY TEMPERATURE   ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; cooling-rate varies depending on more or less extreme scenarios

to check-temperature


  ;; temperature for Scenario 1 ;;

  if scenario = "Scenario1" [


  let cooling-rate 0.000032

  ask hominins [

  ifelse any? places in-radius 30 [
      if body-temperature < 37 [set body-temperature body-temperature + 1]
      if body-temperature >= 37 [set body-temperature body-temperature]
    ]
    [
    set body-temperature body-temperature - (body-temperature - climate-temperature) * cooling-rate
    ]
    if body-temperature <= 30 [set death-hypothermia death-hypothermia + 1 die]
   ]


   ask heminins [

   ifelse any? places in-radius 30 [
      if body-temperature < 37 [set body-temperature body-temperature + 1]
      if body-temperature >= 37 [set body-temperature body-temperature]
    ]
    [
    set body-temperature body-temperature - (body-temperature - climate-temperature) * cooling-rate
    ]
    if body-temperature <= 30 [set death-hypothermia death-hypothermia + 1 die]
   ]
  ]


  ;; temperature for Scenario 2 ;;


  if scenario = "Scenario2" [


  let cooling-rate 0.00032

  ask hominins [

  ifelse any? places in-radius 30 [
      if body-temperature < 37 [set body-temperature body-temperature + 1]
      if body-temperature >= 37 [set body-temperature body-temperature]
    ]
    [
    set body-temperature body-temperature - (body-temperature - climate-temperature) * cooling-rate
    ]
    if body-temperature <= 30 [set death-hypothermia death-hypothermia + 1 die]
   ]


   ask heminins [

   ifelse any? places in-radius 30 [
      if body-temperature < 37 [set body-temperature body-temperature + 1]
      if body-temperature >= 37 [set body-temperature body-temperature]
    ]
    [
    set body-temperature body-temperature - (body-temperature - climate-temperature) * cooling-rate
    ]
    if body-temperature <= 30 [set death-hypothermia death-hypothermia + 1 die]
   ]
  ]

 ;; temperature for Scenario 3 ;;


  if scenario = "Scenario3" [

  let cooling-rate 0.00032

  ask hominins [

  ifelse any? places in-radius 30 [
      if body-temperature < 37 [set body-temperature body-temperature + 1]
      if body-temperature >= 37 [set body-temperature body-temperature]
    ]
    [
    set body-temperature body-temperature - (body-temperature - climate-temperature) * cooling-rate
    ]
    if body-temperature <= 30 [set death-hypothermia death-hypothermia + 1 die]
   ]


   ask heminins [

   ifelse any? places in-radius 30 [
      if body-temperature < 37 [set body-temperature body-temperature + 1]
      if body-temperature >= 37 [set body-temperature body-temperature]
    ]
    [
    set body-temperature body-temperature - (body-temperature - climate-temperature) * cooling-rate
    ]
    if body-temperature <= 30 [set death-hypothermia death-hypothermia + 1 die]
   ]
]



 ;; temperature for Scenario 4 ;;

  if scenario = "Scenario4" [


  let cooling-rate 0.000032

  ask hominins [

  ifelse any? places in-radius 30 [
      if body-temperature < 37 [set body-temperature body-temperature + 1]
      if body-temperature >= 37 [set body-temperature body-temperature]
    ]
    [
    set body-temperature body-temperature - (body-temperature - climate-temperature) * cooling-rate
    ]
    if body-temperature <= 30 [set death-hypothermia death-hypothermia + 1 die]
   ]


   ask heminins [

   ifelse any? places in-radius 30 [
      if body-temperature < 37 [set body-temperature body-temperature + 1]
      if body-temperature >= 37 [set body-temperature body-temperature]
    ]
    [
    set body-temperature body-temperature - (body-temperature - climate-temperature) * cooling-rate
    ]
    if body-temperature <= 30 [set death-hypothermia death-hypothermia + 1 die]
   ]
  ]



end

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  FOUND PLACES AND MOVE   ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Humans can found new attraction places with additional resources if they are cooperative and the resources are equal to or greater than 50


to found-places

  ask hominins-here with [cooperate? = true] [
    if any? hominins-on neighbors and resources >= 50 [
      found-newplaces-tienshan
    ]
  ]

  ask heminins-here with [cooperate? = true] [
    if any? heminins-on neighbors and resources >= 50 [
      found-newplaces-altai
    ]
  ]



ask places [

    if any? hominins in-radius 5 [
      set attractor-resources attractor-resources - 1
      if attractor-resources = 0 [die]
      ask hominins [ set energy energy + 0.1 ]                  ;; hominins can rest so they got more energy
    ]

    if any? heminins in-radius 5 [
      set attractor-resources attractor-resources - 1
      if attractor-resources = 0 [die]
      ask heminins [ set energy energy + 0.1 ]
    ]

  ]

end

;; Attractor places can be found within a 5 radius of another attraction place

to found-newplaces-tienshan
  if not any? places in-radius 5 [
  hatch-places 1   [
    set size 5
    set shape "atractor"
    set attractor-resources 100
    set color red
    ]
  ]

end


to found-newplaces-altai
  if not any? places in-radius 5 [
  hatch-places 1   [
    set size 5
    set shape "atractor"
    set attractor-resources 100
    set color sky
    ]
  ]


   ;ask places [if attractor-resources = 0 [die]]  ; if the resources go to zero then the place is destroyed

end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;    UPDATE RESOURCES and FUNCTIONS    ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



;; when resources are scarce, humans need to move to find new places with resources. Here we test the mobility of humans and their survival in the face of a lack of resources


to update-resources

;; updating resources. When resources are lower than they expected then hominins move to other places
;set resource-recovery-rate 1
;set resource-decrease-rate 0.1


   ;; resources regenerate over time


  ask patches with [noresources? = true] [
    ifelse resources < 100 [
      set resources resources + resource-recovery-rate
    ][
     set resources resources
      set pcolor yellow
      set noresources? false
    ]
  ]


  ;; TIEN SHAN RESOURCES



  ask patches [
    if origin-tienshan? = true and noresources? = false [
      set resources resources - resource-decrease-rate
      if resources <= 20 [
      set pcolor black
      set noresources? true
      ]
    ]
  ]

  ask hominins [
        if noresources? = true [
          face one-of patches with [origin-tienshan? = false]
          forward 150
    ]
      ]

  ask patches [
    if origin-tienshan? = false and noresources? = false [
       set resources resources - resource-decrease-rate
       if resources <= 20 [
       set pcolor black
       set noresources? true
       ]
      ]
     ]


  ask hominins [
            if noresources? = true [
              face one-of patches with [origin-tienshan? = true]
              forward 120
            ]
  ]



  ;;; ALTAI RESOURCES


  ask patches [
    if origin-altai? = true and noresources? = false [
      set resources resources - resource-decrease-rate
      if resources <= 20 [
      set pcolor black
      set noresources? true
      ]
    ]
  ]

  ask heminins [
        if noresources? = true [
          face one-of patches with [origin-altai? = false]
          forward 50
    ]
      ]

  ask patches [
        if origin-altai? = false and noresources? = false [
          set resources resources - resource-decrease-rate
          if resources <= 20 [
          set pcolor black
          set noresources? true
          ]
      ]
  ]

  ask heminins [
            if noresources? = true [
              face one-of patches with [origin-tienshan? = true]
              forward 50
            ]
  ]


end



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; MONITORING THINGS and UPDATE LABELS ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


to update-labels



  ;; update energy, age and temperature

   ask hominins
  [
    set label ""

    if show-energy-tienshan? [ set label precision energy 3 ]

    if age? [ set label precision age 0 ]

    if show-temperature-tienshan? [ set label precision body-temperature 3 ]
  ]


   ask heminins
  [
    set label ""

    if show-energy-altai? [ set label precision energy 3 ]

    if age? [ set label precision age 0 ]

    if show-temperature-altai? [ set label precision body-temperature 3 ]
  ]



  ;; update places resources

 ask places [
    ifelse show-resources?
      [ set label precision attractor-resources 0 ]
      [ set label "" ]
  ]


end





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; GET TRAITS (COOPERATIVE VS NO COOPERATIVE) ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; hominins adopt one social strategy from 12 age old when they grow


to get-traits

 ask hominins [
     if age = 12 and color = black [
      let nc count hominins with [traits = 1] in-radius 1
      let nnc count hominins with [traits = 0] in-radius 1
      if nc > nnc [
      set color green
      set cooperate? true
      set traits 1
      ]
      if nnc > nc [
      set color red
      set cooperate? false
      set traits 0
      ]
      if nnc = nc [
        ifelse (random-float 1.0 < prob-cooperation) [
          set color green
          set cooperate? true
          set traits 1
          ] [
          set color red
          set cooperate? false
          set traits 0
        ]
      ]
      if nnc = 0 and nc = 0 [
      set color red
      set cooperate? false
      set traits 0
      ]
    ]
  ]


  ask heminins [
     if age = 12 and color = black [
      let nc count heminins with [traits = 1] in-radius 1
      let nnc count heminins with [traits = 0] in-radius 1
      if nc > nnc [
      set color green
      set cooperate? true
      set traits 1
      ]
      if nnc > nc [
      set color red
      set cooperate? false
      set traits 0
      ]
      if nnc = nc [
        ifelse (random-float 1.0 < prob-cooperation) [
          set color green
          set cooperate? true
          set traits 1
          ] [
          set color red
          set cooperate? false
          set traits 0
        ]
      ]
      if nnc = 0 and nc = 0 [
      set color red
      set cooperate? false
      set traits 0
      ]
    ]
  ]

end




;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;  HUMANS MOVEMENTS  ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;

to move-humans ;; you can choose between two different random walks: pearson one or levy

    ask hominins [

    set heading random-float 360
    ;rt random 360
    if patch-ahead hominin-speed != nobody and
      [water] of patch-ahead hominin-speed = false
      [ forward hominin-speed ]
  ]


    ask heminins [
    set heading random-float 360
    if patch-ahead hominin-speed != nobody and
      [water] of patch-ahead hominin-speed = false
      [ forward hominin-speed ]
  ]
    ;move-to one-of patches with [water = false]

end


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; LIFESPAN OF HOMININS: how they born and how they die ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


to get-older-and-reproduce ; they have to die and reproduce naturally

;; hominins get older (they died over 50 but you can choose the chance of dying)
;; hominins reproduce over 12


ask hominins [

    set age age + 1
    if age > maximum-age [set death-old death-old + 1 die]                      ;; they die over 50
    ;;if age > 50 * 12 and random-float 100 < 3 [ die ]
    if age > minimum-reproduction-age and random-float 100 < 10 [               ;; humans have a 10 % chance of having a baby if they're over 12
      hatch 1 [
        set body-temperature initial-body-temperature                           ;; body temperature average of humans is 37ºC
        set age 0                                                               ;; average human age is 25
        set color black
        set energy max-energy                                                   ;; all hominins start with 0 energy consumed
        set risk human-risk                                                     ;; risk of hominins. how they start
        get-traits                                                              ;; how they get traits to be cooperative or not
       ]
      ]
     ]


ask heminins [

    set age age + 1
    if age > maximum-age [set death-old death-old + 1 die]                      ;; they die over 50
    if age > minimum-reproduction-age and random-float 100 < 10 [               ;; humans have a 10 % chance of having a baby if they're over 12
      hatch 1 [
        set body-temperature initial-body-temperature                           ;; body temperature average of humans is 37ºC
        set age 0                                                               ;; average human age is 25
        set color black
        set energy max-energy                                                   ;; all hominins start with 0 energy consumed
        set risk human-risk                                                     ;; risk of hominins. how they start
        get-traits                                                              ;; how they get traits to be cooperative or not
       ]
      ]
     ]

end





;;;;;;;;;;;;;;;;;;;;;;;
;;; VIDEO RECORDING ;;;
;;;;;;;;;;;;;;;;;;;;;;;

to start-recorder
  carefully [ vid:start-recorder ] [ user-message error-message ]
end

to reset-recorder
  let message (word
    "If you reset the recorder, the current recording will be lost."
    "Are you sure you want to reset the recorder?")
  if vid:recorder-status = "inactive" or user-yes-or-no? message [
    vid:reset-recorder
  ]
end

to save-recording
  if vid:recorder-status = "inactive" [
    user-message "The recorder is inactive. There is nothing to save."
    stop
  ]
  ; user for movie location
  user-message (word
    "Choose a name for your movie file (the "
    ".mp4 extension will be automatically added).")
  let path user-new-file
  if not is-string? path [ stop ]  ; stop if user canceled
  ; export the movie
  carefully [
    vid:save-recording path
    user-message (word "Exported movie to " path ".")
  ] [
    user-message error-message
  ]
end


;;;;;;;;;;;;;;;;;;;;;;;;
;;;;   CSV FILES    ;;;;
;;;;;;;;;;;;;;;;;;;;;;;;

to export-file-to-csv

  ;export-plot "New Places" "places.csv"
  ;export-plot "Population" "population.csv"

end


;;;;;;;;;;;;;;
;;; TO GO! ;;;
;;;;;;;;;;;;;;

to go

  if vid:recorder-status = "recording" [ vid:record-view ]

  update-resources                   ;; update all the resources
  update-temperature                 ;; update the temperature for each scenario
  move-humans                        ;; move hominins
  get-older-and-reproduce            ;; getting older and reproduce
  check-scenarios                    ;; check four possible scenarios
  get-traits                         ;; update get-traits by 12 (cooperative or defectors)
  select-strategy                    ;; selection bt cooperative and no cooperative. Equations from Henrich et al.
  update-labels                      ;; using off/on to see updates labels (age, energy)

  if ticks >= maxTimeSteps
  [
    show (word "Simulation " behaviorspace-run-number " finished at " date-and-time)
    show (word "Simulation duration: " timer " s")
    show (word "This is the end my only friend")
    stop                                                       ;; stop the simulation when time steps exceed the maxTimeSteps value

  ]

  tick

end




;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                    NOTES                                                                      ;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;to move-humans ;; you can choose between two different random walks: pearson one or levy
;
;
;  if (movements = "random walk") [
;
;    ask hominins [
;
;    set heading random-float 360
;    ;rt random 360
;    if patch-ahead hominin-speed != nobody and
;      [water] of patch-ahead hominin-speed = false
;      [ forward hominin-speed ]
;  ]
;
;
;
;    ask heminins [
;    set heading random-float 360
;    if patch-ahead hominin-speed != nobody and
;      [water] of patch-ahead hominin-speed = false
;      [ forward hominin-speed ]]
;    ;move-to one-of patches with [water = false]
;    ]
;
;
;
;   if (movements = "lèvy walk") [
;
;     ask hominins [
;
;     set heading random-float 360
;
;     let levy-step levy-min-step * (random-float 1) ^ (-1 / levy-alpha)
;     ;let alpha-walk 2 ;estaba por defecto 1.5 value alpha where the steps are + shorter - larger
;     ;let minstep 0.2
;     if patch-ahead levy-step != nobody and
;      [water] of patch-ahead levy-step = false
;      [fd levy-step]
;
;     ;fd minstep * (random-float 1) ^ (-1 / alpha-walk)
;     ]
;
;    ask heminins [
;     set heading random-float 360
;
;     let levy-step levy-min-step * (random-float 1) ^ (-1 / levy-alpha)
;     if patch-ahead levy-step != nobody and
;      [water] of patch-ahead levy-step = false
;      [fd levy-step]
;     ]
;    ]
;
;end



;to consume-energy
;
;  ;; energy 1% = 0.01 y 0.1% = 0.001
;  ;; individuals consume energy differently when they are close to attractors places (less energy) and they are far from them (more energy)
;
;
; ;;;; CONSUME ENERGY IN SCENARIO 1 ;;;;
;
;  if scenario = "Scenario1" [
;
;    ask hominins with [attractors? = true] [
;      set risk risk - 0.1
;      ifelse risk <= human-risk [
;       set energy energy - 0.01 ]
;      [set energy energy - 0.1 ]
;    ]
;    ask hominins with [attractors? = false]
;      [
;        set energy energy - 0.1
;        set risk risk + 0.1
;        if risk > 80 [
;        set energy energy - 0.12
;        ]
;      ]
;
;
;    ask heminins with [attractors? = true] [
;      set risk risk - 0.15
;      ifelse risk <= human-risk [
;      set energy energy - 0.015 ]
;      [set energy energy - 0.15 ]
;    ]
;    ask heminins with [attractors? = false]                          ;; Altai is more extreme so humans spend more energy and the perception of the risk is higher than Tien Shan
;      [
;        set energy energy - 0.15
;        set risk risk + 0.15
;        if risk > 80 [
;        set energy energy - 0.20
;        ]
;      ]
;  ]



  ;;;; CONSUME ENERGY IN SCENARIO 2 ;;;;


;  if scenario = "Scenario2" [
;
;    ask hominins with [attractors? = true] [
;      set risk risk - 0.2
;      ifelse risk <= human-risk [
;        set energy energy - 0.02
;       ;ask hominins with [cooperate? = false] [set energy energy - 0.002] ;; no cooperative consume more energy
;       ;ask hominins with [cooperate? = true] [set energy energy - 0.001]
;      ][
;        set energy energy - 0.15
;      ]
;    ]
;    ask hominins with [attractors? = false]
;      [
;        set energy energy - 0.2
;        set risk risk + 0.4
;        if risk > 80 [
;        set energy energy - 0.25
;        ]
;      ]
;
;
;    ask heminins with [attractors? = true] [
;      set risk risk - 0.3
;      ifelse risk <= human-risk [
;       set energy energy - 0.025
;      ][
;        set energy energy - 0.20
;      ]
;    ]
;
;    ask heminins with [attractors? = false] [
;        set energy energy - 0.3
;        set risk risk + 0.5
;        if risk > 80 [
;        set energy energy - 0.30
;        ]
;      ]
;
;  ]
;
;   ;;;; CONSUME ENERGY IN SCENARIO 3 ;;;;
;
;   if scenario = "Scenario3" [
;
;    ask hominins with [attractors? = true] [
;      set risk risk - 0.2
;      ifelse risk <= human-risk [
;      set energy energy - 0.02
;       ;ask hominins with [cooperate? = false] [set energy energy + 0.25] ;; no cooperative consume more energy
;       ;ask hominins with [cooperate? = true] [set energy energy + 0.2]
;      ][
;        set energy energy - 0.15
;
;      ]
;    ]
;    ask hominins with [attractors? = false]
;      [
;        set energy energy - 0.2
;        set risk risk + 0.4
;        if risk > 80 [
;        set energy energy - 0.25
;
;        ]
;      ]
;
;      ask heminins with [attractors? = true] [
;      set risk risk - 0.3
;      ifelse risk <= human-risk [
;       set energy energy - 0.025
;      ][
;        set energy energy - 0.20
;      ]
;    ]
;
;    ask heminins with [attractors? = false] [
;        set energy energy - 0.3
;        set risk risk + 0.5
;        if risk > 80 [
;        set energy energy - 0.30
;        ]
;      ]
;
;  ]
;
;
; ;;;; CONSUME ENERGY IN SCENARIO 4 ;;;;
;
;  ;; temperature between interglacial and glacial are a bit similar bt regions (Altai and Tien Shan) so we include the same energy bt hominins and heminins bc the variation bt temperatures is not a lot
;
;  if scenario = "Scenario4" [
;
;      ask hominins with [attractors? = true] [
;      set risk risk - 0.1
;      ifelse risk <= human-risk [
;       set energy energy - 0.01
;      ][
;        set energy energy - 0.1
;
;      ]
;    ]
;    ask hominins with [attractors? = false]
;      [
;        set energy energy - 0.11
;        set risk risk + 0.1
;        if risk > 80 [
;        set energy energy - 0.12
;
;        ]
;      ]
;
;     ask heminins with [attractors? = true] [
;      set risk risk - 0.1
;      ifelse risk <= human-risk [
;       set energy energy - 0.01
;      ][
;        set energy energy - 0.1
;
;      ]
;    ]
;    ask heminins with [attractors? = false]
;      [
;        set energy energy - 0.11
;        set risk risk + 0.1
;        if risk > 80 [
;        set energy energy - 0.12
;
;        ]
;      ]
;
;  ]
;
;
;  ;; When humans have not energy they die
;
;  ask hominins [
;    if energy >= max-energy [set energy max-energy]                                        ;; they cannot exceed the limit of energy using max-energy slider
;    if energy <= 0 [set death-starvation death-starvation + 1 die]                         ;; no energy of course die
;  ]
;
;  ask heminins [
;    if energy >= max-energy [set energy max-energy]
;    if energy <= 0 [set death-starvation death-starvation + 1 die]                                        ;; no energy of course die
;  ]
;
;
;end
@#$#@#$#@
GRAPHICS-WINDOW
593
28
1135
365
-1
-1
1.0
1
10
1
1
1
0
0
0
1
0
533
0
327
1
1
1
months
30.0

BUTTON
13
39
86
72
setup
setup
NIL
1
T
OBSERVER
NIL
1
NIL
NIL
1

BUTTON
152
39
215
72
go
go
T
1
T
OBSERVER
NIL
3
NIL
NIL
1

SLIDER
12
573
184
606
nHominins
nHominins
0
100
10.0
1
1
NIL
HORIZONTAL

BUTTON
87
39
151
72
step
go
NIL
1
T
OBSERVER
NIL
2
NIL
NIL
1

TEXTBOX
10
432
340
476
*** Hominins (Tien Shan and Altai) ***
18
0.0
1

TEXTBOX
712
405
1100
451
*** Cooperation dynamics ***
18
0.0
1

MONITOR
10
466
153
511
total hominins (Tien Shan)
count hominins
0
1
11

INPUTBOX
93
79
174
140
maxTimeSteps
1200.0
1
0
Number

SLIDER
372
455
547
488
learning-rate
learning-rate
0.0
1
1.0
0.1
1
NIL
HORIZONTAL

SLIDER
373
502
545
535
human-risk
human-risk
0
100
5.0
1
1
NIL
HORIZONTAL

PLOT
1177
22
1547
247
Population
time
frequency
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"hominins (Tien Shan)" 1.0 0 -4079321 true "" "if plots-on? [plot count hominins]"
"hominins (Altai)" 1.0 0 -14454117 true "" "if plots-on? [plot count heminins]"

TEXTBOX
1470
1054
1620
1078
*** Video ***
20
0.0
1

BUTTON
1456
1089
1589
1122
NIL
start-recorder
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1457
1164
1729
1197
NIL
reset-recorder
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
1590
1089
1729
1122
NIL
save-recording
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
1459
1121
1729
1166
NIL
vid:recorder-status
17
1
11

BUTTON
12
78
86
111
profiler
setup                  ;; set up the model\nprofiler:start         ;; start profiling\nrepeat 250 [ go ]      ;; run something you want to measure\nprofiler:stop          ;; stop profiling\nprint profiler:report  ;; view the results\nprofiler:reset         ;; clear the data
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
279
80
408
113
NIL
display-attractors
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

TEXTBOX
276
10
510
54
*** Display maps *** 
18
0.0
1

INPUTBOX
16
289
120
349
world-max-dim
533.0
1
0
Number

TEXTBOX
53
10
203
32
*** Init ***
18
0.0
1

TEXTBOX
268
41
532
71
#Press display-map after setup ;-)
12
0.0
1

TEXTBOX
19
264
169
282
#Map dimensions
12
0.0
1

INPUTBOX
125
289
224
349
patch-size-km
0.5
1
0
Number

BUTTON
1742
1164
1855
1197
csv file
export-file-to-csv
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

INPUTBOX
15
353
124
413
mountain-elev
1700.0
1
0
Number

MONITOR
19
210
76
255
years
ticks / 12
0
1
11

SLIDER
10
620
185
653
hominin-speed
hominin-speed
0
1
0.75
0.05
1
patches
HORIZONTAL

MONITOR
82
210
152
255
generations
ticks / 360\n;; 1 generation = aprox. 30 years
0
1
11

SLIDER
373
552
546
585
max-energy
max-energy
0
100
100.0
1
1
NIL
HORIZONTAL

TEXTBOX
243
156
579
200
*** Scenarios and Climate conditions ***
18
0.0
1

CHOOSER
341
190
479
235
scenario
scenario
"Scenario1" "Scenario2" "Scenario3" "Scenario4"
2

TEXTBOX
1248
369
1398
387
NIL
12
0.0
1

MONITOR
12
517
139
562
total hominins (Altai)
count heminins
17
1
11

TEXTBOX
834
485
918
503
NIL
11
0.0
1

PLOT
1178
256
1549
459
Strategies (Tien Shan)
ticks
hominins
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"cooperators" 1.0 0 -8732573 true "" "if plots-on? [plot count hominins with [cooperate? = true]]"
"defectors" 1.0 0 -2139308 true "" "if plots-on? [plot count hominins with [cooperate? = false]]"

TEXTBOX
181
96
283
126
#1200 = 100 years
12
0.0
1

SLIDER
373
599
546
632
prob-cooperation
prob-cooperation
0
1.0
0.5
0.01
1
NIL
HORIZONTAL

TEXTBOX
27
810
264
852
*** Hominins functions ***
18
0.0
1

TEXTBOX
28
916
112
934
NIL
11
0.0
1

SWITCH
23
908
172
941
show-energy-altai?
show-energy-altai?
1
1
-1000

SWITCH
24
956
128
989
age?
age?
1
1
-1000

SWITCH
22
1093
156
1126
show-resources?
show-resources?
1
1
-1000

TEXTBOX
868
461
1103
491
# Cooperative hominins in Tien Shan
12
0.0
1

TEXTBOX
868
545
1076
575
# Cooperative hominins in Altai
12
0.0
1

MONITOR
883
486
968
531
cooperative?
count hominins with [cooperate? = true]
17
1
11

MONITOR
986
486
1088
531
no cooperative?
count hominins with [cooperate? = false]
17
1
11

MONITOR
883
572
968
617
cooperative?
count heminins with [cooperate? = true]
17
1
11

MONITOR
986
572
1088
617
no cooperative?
count heminins with [cooperate? = false]
17
1
11

SLIDER
600
456
772
489
alpha
alpha
0
1
0.5
0.01
1
NIL
HORIZONTAL

SLIDER
600
502
772
535
cost-cooperation
cost-cooperation
0
100
20.0
1
1
NIL
HORIZONTAL

SLIDER
601
550
773
583
punishment-cooperation
punishment-cooperation
0
100
7.0
1
1
NIL
HORIZONTAL

PLOT
1177
481
1548
709
Strategies (Altai)
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"cooperators" 1.0 0 -8732573 true "" "if plots-on? [plot count heminins with [cooperate? = true]]"
"defectors" 1.0 0 -2139308 true "" "if plots-on? [plot count heminins with [cooperate? = false]]"

MONITOR
600
654
703
699
payoff-tienshan
get-payoff-tienshan
17
1
11

MONITOR
713
655
850
700
delta-tienshan
get-deltap-tienshan
17
1
11

SLIDER
601
595
836
628
prob-nocoop
prob-nocoop
0
0.01
0.001
0.001
1
NIL
HORIZONTAL

SWITCH
23
1001
247
1034
show-temperature-tienshan?
show-temperature-tienshan?
1
1
-1000

BUTTON
422
80
516
114
clean-maps
clear-drawing
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SWITCH
23
865
220
898
show-energy-tienshan?
show-energy-tienshan?
1
1
-1000

PLOT
1583
796
1883
999
New Places
NIL
NIL
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"tien-shan" 1.0 0 -2674135 true "" "if plots-on? [plot count places with [ color = red ]]"
"altai" 1.0 0 -13791810 true "" "if plots-on? [plot count places with [ color = sky ]]"

MONITOR
601
713
705
758
payoff-altai
get-payoff-altai
17
1
11

MONITOR
716
713
854
758
delta-altai
get-deltap-altai
17
1
11

SWITCH
22
1048
219
1081
show-temperature-altai?
show-temperature-altai?
1
1
-1000

INPUTBOX
14
124
85
184
seed
1000.0
1
0
Number

TEXTBOX
359
405
564
449
*** Social dynamics ***
18
0.0
1

SWITCH
1581
25
1702
58
plots-on?
plots-on?
1
1
-1000

PLOT
1177
760
1552
1002
death-causes
months
number of individuals
0.0
10.0
0.0
10.0
true
true
"" ""
PENS
"hypothermia" 1.0 0 -13791810 true "" "if plots-on? [plot death-hypothermia]"
"too-old" 1.0 0 -10899396 true "" "if plots-on? [plot death-old]"
"starvation" 1.0 0 -2674135 true "" "if plots-on? [plot death-starvation]"

MONITOR
401
314
494
359
NIL
current-month
17
1
11

@#$#@#$#@
## WHAT IS IT?

PaleoCOOP is an evolutionary theoretical Agent-Based Model to explore the effect of cooperation on dispersal under different climate constraints in two study sub-regions, the Altai and Tian Shan Mountains.

## HOW IT WORKS


First, we will select the scenario and the strategy taken. During the simulation, they compete with resources and select one strategy (cooperate or defect). In each step, they consume resources, interact with each other and walk. 

So, for the model, we create three stages:


**1.** Humans need to learn how to arrive at one place with resources

**2.** Humans seek a location with resources and learn to navigate there. Upon arrival, they settle and begin consuming available resources.

**3.** When resources are not optimal, they need to move and look for new optimal resources. 
                              


## HOW TO USE IT

This model works with GIS library and use DEM for the map and shapefiles for rivers, lakes and archaeological data. 

**INIT**: includes setup, step, and go, and maximum timestep. Let´s them work!

**DISPLAY MAP**: display the archaeological data and then clean maps: clean everything!

**HOMININS**: Selection of the number of humans (it works the same for Tian Shan and Altai). Select also the type of movements (Lévy walk and Random walk) and the speed. 

**SOCIAL DYNAMICS**: energy, risk that they percieve in the enviromment and learning (they have to learn how to reach to available resources)

**COOPERATION DYNAMICS**: functions based on the cooperation equation. For more info: read the comments in the code

**HOMININ FUNCTIONS**: is my model working? Use these functions to see what is happening. 


## THINGS TO NOTICE

** The simulation can take veeery long time. It is recommended only simulate one human group (Tian Shan or Altai).



## THINGS TO TRY

Change scenarios to see how they react under extreme climate enviromments

Change movements of the individuals: Lévy walk or Random walk

Change cooperation features using the sliders: cost of cooperation, probability of cooperation, alpha to see if you can find some patterns. 

Try to change the number of start population in the model. 

Change the learning-rate of the model to see how long it takes to learn the path to find available resources and how it influences the survival cost.




## RELATED MODELS


The model uses different models from the Netlogo Library:

* Path
* WarFruit
* Virus
* Ant Adaptation
* Random walk
* Cooperation
* Wave When Hale Wale (WWHW) (for Lévy Walk and Random Walk)

Netlogo Version 6.2.1



## CREDITS AND REFERENCES

Coding by María Coto-Sarmiento

This model is based on the following work:

Henrich, J., & Boyd, R. (2001). Why people punish defectors: Weak conformist transmission can stabilize costly enforcement of norms in cooperative dilemmas. Journal of theoretical biology, 208(1), 79-89.

Raichlen, D. A., Wood, B. M., Gordon, A. D., Mabulla, A. Z., Marlowe, F. W., & Pontzer, H. (2014). Evidence of Lévy walk foraging patterns in human hunter–gatherers. Proceedings of the National Academy of Sciences, 111(2), 728-733.

Santos, J. I., Pereda, M., Zurro, D., Álvarez, M., Caro, J., Galán, J. M., & Briz i Godino, I. (2015). Effect of resource spatial correlation and hunter-fisher-gatherer mobility on social cooperation in Tierra del Fuego. PLoS One, 10(4), e0121888.



Estimation for temperature in Altai and Tien Shan. For more info see paper:

Glantz, M., Van Arsdale, A., Temirbekov, S., & Beeton, T. (2018). How to survive the glacial apocalypse: Hominin mobility strategies in late Pleistocene Central Asia.
Quaternary International, 466, 82-92. Table 2.


## OPEN SCIENCE

PaleoCOOP Model was written on NetLogo software 6.2.2 and the code, data and sources are available at Github archive is openly available here https://github.com/Mcotsar/PaleoCOOP. 
As part of open science and transparency policies in archaeology, the agent-based model was performed according to practices following the ODD document protocol
Code, data, sources, protocolos and supplementary information on the model can be also found here https://doi.org/10.17605/OSF.IO/JM3ZY. 

If you have any questions, comments, feedback because it does not work, you can write to 



Thanks to Andreas Angourakis and Víctor Martín Lozano for the feedback!
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

atractor
false
0
Polygon -7500403 true true 15 300 150 15 285 300 210 300 150 150 90 300 45 300

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.2.2
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
<experiments>
  <experiment name="Scenario_1_prob50_tienshan_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plots-on?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-altai?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario_1_prob80_tienshan_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plots-on?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-altai?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario_4_prob50_tienshan_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plots-on?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-altai?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario4&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario_4_prob80_tienshan_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plots-on?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-altai?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario4&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario_2_prob80_tienshan_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plots-on?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-altai?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario2&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario_2_prob50_tienshan_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plots-on?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-altai?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario2&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario_3_prob80_tienshan_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plots-on?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-altai?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario3&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario_3_prob50_tienshan_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="plots-on?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-temperature-altai?">
      <value value="true"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-tienshan?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario3&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario_1_prob50_altai_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario_1_prob80_altai_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario_2_prob50_altai_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <exitCondition>not any? heminins</exitCondition>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario2&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario_2_prob80_altai_test" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <timeLimit steps="1200"/>
    <exitCondition>not any? heminins</exitCondition>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="world-max-dim">
      <value value="533"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-resources?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="show-energy-altai?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="patch-size-km">
      <value value="0.5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="age?">
      <value value="false"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="mountain-elev">
      <value value="1700"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario2&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario1_probcoop_TienShan" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? hominins</exitCondition>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.2"/>
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario2_probcoop_TienShan" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? hominins</exitCondition>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.2"/>
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario2&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario3_probcoop_TienShan" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? hominins</exitCondition>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.2"/>
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario3&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario4_probcoop_TienShan" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? hominins</exitCondition>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.2"/>
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario4&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario1_probcoop_Altai" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? heminins</exitCondition>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.2"/>
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario2_probcoop_Altai" repetitions="1" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? heminins</exitCondition>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.2"/>
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario2&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario3_probcoop_Altai" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? heminins</exitCondition>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.2"/>
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario3&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario4_probcoop_Altai" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? heminins</exitCondition>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.2"/>
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario4&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario1_alpha_TienShan" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? hominins</exitCondition>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario2_alpha_TienShan" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? hominins</exitCondition>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario2&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario3_alpha_TienShan" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? hominins</exitCondition>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario3&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario4_alpha_TienShan" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? hominins</exitCondition>
    <metric>count hominins with [cooperate? = true]</metric>
    <metric>count hominins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-tienshan</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario4&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario1_alpha_Altai" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? heminins</exitCondition>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario1&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario2_alpha_Altai" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? heminins</exitCondition>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario2&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario3_alpha_Altai" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? heminins</exitCondition>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario3&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario4_alpha_Altai" repetitions="1" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? heminins</exitCondition>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario4&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
  <experiment name="Scenario4_alpha_Altai_all" repetitions="2" sequentialRunOrder="false" runMetricsEveryStep="true">
    <setup>setup</setup>
    <go>go</go>
    <exitCondition>not any? heminins</exitCondition>
    <metric>count heminins with [cooperate? = true]</metric>
    <metric>count heminins with [cooperate? = false]</metric>
    <metric>death-hypothermia</metric>
    <metric>death-old</metric>
    <metric>death-starvation</metric>
    <metric>get-deltap-altai</metric>
    <enumeratedValueSet variable="prob-nocoop">
      <value value="0.001"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="alpha">
      <value value="0.2"/>
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="cost-cooperation">
      <value value="10"/>
      <value value="20"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="movements">
      <value value="&quot;random walk&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="seed">
      <value value="1000"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="human-risk">
      <value value="5"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="maxTimeSteps">
      <value value="1200"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="nHominins">
      <value value="10"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="hominin-speed">
      <value value="0.75"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="punishment-cooperation">
      <value value="7"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="max-energy">
      <value value="100"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="prob-cooperation">
      <value value="0.2"/>
      <value value="0.5"/>
      <value value="0.8"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="scenario">
      <value value="&quot;Scenario1&quot;"/>
      <value value="&quot;Scenario2&quot;"/>
      <value value="&quot;Scenario3&quot;"/>
      <value value="&quot;Scenario4&quot;"/>
    </enumeratedValueSet>
    <enumeratedValueSet variable="learning-rate">
      <value value="1"/>
    </enumeratedValueSet>
  </experiment>
</experiments>
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
