
//cons
var Trait1 =Base.extend({
    constructor:function(){}
    ,wig:null
    ,onFrameSignal:null
    ,val:"some data"

    ,doFrame:function() {// non - anon function, a good practice.
       // console.log('hi '+this.val);
        this.wig.mesh.rotation.x += 0.01;
        this.wig.mesh.rotation.y += 0.02;
    }

    ,initTrait:function (wig_,onFrameSignal_) {
        this.wig=wig_;
        this.doFrame();
        this.onFrameSignal=onFrameSignal_;
        this.wig.mesh.rotation.x += 0.01;
        onFrameSignal_.add(this.doFrame,this);

        this.onFrameSignal.add( function(){// Non deterministic and object disoriented, so remove
           // wig_.mesh.rotation.x += 0.01;
           // wig_.mesh.rotation.y += 0.02;
        });//()
     }
    
});//class



