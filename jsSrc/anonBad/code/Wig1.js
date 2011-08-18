
var Wig1 = Base.extend({
   constructor:function(){}
   ,mesh:null
   ,geometry:null
   ,material:null
   ,initWig:function (scene) {

        this.geometry = new THREE.CubeGeometry( 200, 200, 200 );
        this.material = new THREE.MeshBasicMaterial( { color: 0xff0000, wireframe: true } );

        this.mesh = new THREE.Mesh( this.geometry, this.material );
        scene.addObject( this.mesh )
    }//()

    ,addWigTrait:function (trait,onFrameSignal_) {
        trait.initTrait(this,onFrameSignal_)
    }//()

});//class

