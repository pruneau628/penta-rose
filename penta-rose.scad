                                        // Penta Rose -  01

  cd5 = 50 ;                            // coté  du pentagone
   A5 = 72  ;                           // Angle au centre du pentagone
cd5s2 = cd5 /2 ;                        // demi coté du pentagone
 rcd5 = cd5s2/sin(36) ;                 // rayon du pentagone

 rh = rcd5-4;   Ht = 224  ;   zh = 10;   // coordonnées du "sommet"
                                         // avec cette valeur de zh on a un effet de spirale
Ang = 46.61 ;                            // angle de rotation pour l'homothétie
 sc = 0.7668;                            // rapport d homothétie pout le pentegone plus petit
 ne = 12 ;                               // nombre d'étage moins un
//_________________________________________________________________________________

 rcst = 0.0001;                          //  rayon de  la "sphere point"
  npt = 5 ;                              // "nombre de faces" de la "sphere point"

module pt(r,np=npt) { sphere(r=rcst,$fn=np);};                                       //  " point "
module pk(x=0,y=0,z=0) {translate(x,y,z) pt();};                                     //  cartesien
module ps(rr,Ar,zz) { translate( [ rr * cos(Ar) , rr * sin (Ar) , zz ]) pt() ; } ;   // polaire
//__________________________________________________________________________________
/*
/                                         // Aide pour le positionnement des points bas (z=0)
                                           / dodecagone externe
for (i1 = [0:11]) { hull() { ps ( rcd5, i1 * 36 , 0); ps ( rcd5, (i1 +1 )* 36 , 0);} } ;
                                           // pentagone inscrit
for (i1 = [0: 5]) { hull() { ps ( rcd5, i1 * A5 , 0); ps ( rcd5, (i1 +1 )* A5 , 0);} } ;
                                           // dodecagone interne en position
rotate([0,0,10]) {
for (i1 = [0:11]) { hull() { ps ( rcd5-10, i1 * 36 , 0); ps ( rcd5-10, (i1 +1 )* 36 , 0); } }
                                           // Cette aide permet d'avoir le posistionnement
                                           // exact des points bas
*/
                                           //points bas sur le dodecagone externe
module A () { ps ( rcd5, 8 * 36 , 0); } // A
module B () { ps ( rcd5, 7 * 36 , 0); } // B
module C () { ps ( rcd5, 6 * 36 , 0); } // C
                                            // points bas sur l'intérieur
module F () {color("Green") rotate([0,0,10]) ps ( rcd5-10, 6 * 36 , 0); } // F
module G () {color("Green") rotate([0,0,10]) ps ( rcd5-10, 5 * 36 , 0); } // G
                                            // le seul point haut ( zh )
module S () {color("Green") rotate([0,0,10]) ps ( rh, Ht , zh); } // G

                                            // tracé du contour du module initial
module M0() {
    color("Black") {
     hull () { A();B();} ;   hull () { B();C();};   hull () { C();G();}
     hull () { A();F();} ;   hull () { F();G();} ;

     hull () { S(); A();}
     hull () { S(); B();}
     hull () { S(); C();}
     hull () { S(); F();}
     hull () { S(); G();}
     }
};
//M0 ();
//M0(); rotate([0,0,A5]) M0() ; rotate([0,0,-A5 ]) M0() ;
//     rotate([0,0,144]) M0() ; rotate([0,0,-144]) M0() ;

                                                // partage du module initial en deux éléments convexes
module M11 () {  hull () { A();B();C();S();F(); } };
module M12 () {  hull () { S();C();F();G(); } };

                                                // formation du module initial M1()
module M1 () {  union () {  M11 (); M12 (); }  }

                                                // Construction du " premier tour complet "
module M2() {
M1(); rotate([0,0,A5 ]) M1() ; rotate([0,0, -A5]) M1() ;
      rotate([0,0,144]) M1() ; rotate([0,0,-144]) M1() ;
}

                                                // construction de la pièce finale(
for ( i4 = [0:1:ne] ) {
      rotate([0,0,i4* Ang]) scale( sc^i4 * [1,1,1]) M2() ;
}