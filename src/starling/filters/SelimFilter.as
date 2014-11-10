/**
 *	Copyright (c) 2013 Devon O. Wolfgang
 *
 *	Permission is hereby granted, free of charge, to any person obtaining a copy
 *	of this software and associated documentation files (the "Software"), to deal
 *	in the Software without restriction, including without limitation the rights
 *	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *	copies of the Software, and to permit persons to whom the Software is
 *	furnished to do so, subject to the following conditions:
 *
 *	The above copyright notice and this permission notice shall be included in
 *	all copies or substantial portions of the Software.
 *
 *	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 *	THE SOFTWARE.
 */

package starling.filters
{
    import flash.display3D.Context3D;
    import flash.display3D.Context3DProgramType;
    import flash.display3D.Program3D;
    
    import starling.core.Starling;
    import starling.textures.Texture;

    /**
     * Creates a 'God Rays' / fake volumetric light filter effect.
     * Only use with Context3DProfile.BASELINE (not compatible with constrained profile)
     * @author Devon O.
     */
	
    public class SelimFilter extends FragmentFilter
    {
        
        private var mShaderProgram:Program3D;

        private var mNumSteps:int;

        // lightx, lighty
        private var mLightPos:Vector.<Number> = Vector.<Number>( [ .5, .5, 1, 1 ]);

        // numsamples, density, numsamples * density, 1 / numsamples * density
        private var mVars1:Vector.<Number> = Vector.<Number>( [ 1, 1, 1, 1 ]);

        // weight, decay, exposure
        private var mVars2:Vector.<Number> = Vector.<Number>( [ 1, 1, 1, 1 ]);
		
		
        private var mLightX:Number      = 0.0;
        private var mLightY:Number      = 0.0;
        private var mWeight:Number      = .50;
        private var mDecay:Number       = .87;
        private var mExposure:Number    = .35;
        private var mDensity:Number     = 2.0;
        
        /**
         * Create a GodRaysFilter
         * @param	numSteps	Number of samples to take along the ray path (maximum 32 with Context3DProfile.BASELINE)
         * @param   numPasses   Number of passes this filter should apply (1 pass = 1 drawcall)
         */
        public function SelimFilter(numSteps:int=30, numPasses:int=1)
        {
            mNumSteps = numSteps;
            this.numPasses = numPasses;
        }
        
        public override function dispose():void
        {
            if (mShaderProgram) mShaderProgram.dispose();
            super.dispose();
        }
        
        protected override function createPrograms():void
        {
		
            var frag:String = "";
	/*
            // Calculate vector from pixel to light source in screen space.
            frag += "sub ft0.xy, v0.xy, fc0.xy \n";

            // Divide by number of samples and scale by control factor.  
            frag += "mul ft0.xy, ft0.xy, fc1.ww \n";

            // Store initial sample.  
            frag += "tex ft1,  v0, fs0 <2d, clamp, linear, mipnone> \n";

            // Set up illumination decay factor.  
            frag += "mov ft2.x, fc0.w \n";

            // Store the texcoords
            frag += "mov ft4.xy, v0.xy \n";

            for (var i:int = 0; i < mNumSteps; i++)
            {
                // Step sample location along ray. 
                frag += "sub ft4.xy, ft4.xy, ft0.xy \n";

                // Retrieve sample at new location.  
                frag += "tex ft3,  ft4.xy, fs0 <2d, clamp, linear, mipnone> \n";

                // Apply sample attenuation scale/decay factors.  
                frag += "mul ft2.y, ft2.x, fc2.x \n";
                frag += "mul ft3.xyz, ft3.xyz, ft2.yyy \n";

                // Accumulate combined color.  
                frag += "add ft1.xyz, ft1.xyz, ft3.xyz \n";

                // Update exponential decay factor.  
                frag += "mul ft2.x, ft2.x, fc2.y \n";
            }

            // Output final color with a further scale control factor. 
           // frag += "mul ft1.xyz, ft1.xyz, fc2.zzz \n";
            frag += "mov oc, ft1";
			
			*/
			
		/*	frag += 'sub ft0.xy, v0.xy,  fc1.xy \n';
			frag += "mul ft1.xy, ft0.xy, fc0.xy \n";
			frag += 'add ft2.xy, ft1.xy, fc1.xy \n';
			
			frag += "tex ft3, v0, fs0 <2d, clamp, linear, mipnone> \n";
			frag += "tex ft4, ft2.xy, fs0 <2d, clamp, linear, mipnone> \n";
			frag += "add ft3.xyzw ft3.xyzw, ft4.xyzw \n";
			//frag += "add ft3.xyz ft3.xyz, v0.xyz \n";
			frag += "mov oc, ft3"*/
				
			
			/*
			frag += "tex ft0, v0, fs0 <2d, clamp, linear, mipnone> \n";
			frag += "sub ft1.x, 	v0.x, 	fc0.x 	\n";
			frag += "mov ft1.y, 	fc1.y 			\n";
			frag += "mov ft1.z, 	fc1.z 			\n";
			frag += "mov ft1.w, 	fc1.w 			\n";
			frag += "abs ft2.xyzw, 	ft1.xyzw 		\n";
			frag += "mul ft2.x,     ft2.x, 	fc0.y   \n";
			frag += "mov oc			ft2.xyzw 		\n";
			*/
			/*
			frag += "tex ft0, 	v0, 						fs0 <2d, clamp, linear, mipnone> \n";
			frag += "mul ft1,   ft0,    					fc0 \n";
			frag += "sub ft2,   v0,    						fc1 \n";
			frag += "frc ft3,   ft2  							\n";
			frag += "sub ft3,   ft2,  						ft3 \n";
			frag += "sge ft4.xyzw,   ft3.zyxw, fc1.zzzz  		\n";
			frag += "add ft5.xywz,   ft4.xyzw,ft3.xyzw    \n";
			frag += "mov oc,	ft2 			\n";*/
			
			frag += "sub ft3.xy, v0.xy, fc0.xy \n";
			
			frag += "tex ft0, 	v0, 	fs0 <2d, clamp, linear, mipnone> \n";
			frag += "mov ft1, fc1 \n";
			frag += "sub ft2.x, v0.x, fc1.x \n";
			frag += "mul ft2.x, ft2.x, fc1.z \n";
			frag += "sat ft2.x, ft2.x \n";
			frag += "mul ft0.xyzw, ft0.xyzw, ft2.xxxx \n";
			frag += "mov oc, ft0";
			
			
			
			
			
			/*frag += "tex ft0, 	v0, 						fs0 <2d, clamp, linear, mipnone> \n";
			frag += "mul ft1.xyzw, ft0.xyzw, fc0.wwww\n";
			//frag += "mov ft1.w, fc0.w \n";
			frag += "mov oc, ft1";*/
			
			
            mShaderProgram = assembleAgal(frag);
        }
        
		private var datas:Vector.<Number> = Vector.<Number>([1,1,1,0.0]);
		private var datas2:Vector.<Number> = Vector.<Number>([1,0,10,1]);
        protected override function activate(pass:int, context:Context3D, texture:Texture):void
        {
			//datas2[0] = (100 + (59 / 2)) / texture.width;
			//datas2[1] = (100 + (58 / 2)) / texture.height;
			
			datas2[0] = mLightX / (texture.width * Starling.contentScaleFactor);
			datas2[1] = mLightY / Starling.current.nativeOverlay.stage.stageHeight;
			
			
			context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 0, datas );
          	context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 1,  datas2);	
           
           // context.setProgramConstantsFromVector(Context3DProgramType.FRAGMENT, 2, mVars2,     1 );

            context.setProgram(mShaderProgram);
        }
		
        public function set x(value:Number):void { mLightX = value; }
        public function get x():Number { return mLightX; }

        public function set y(value:Number):void { mLightY = value; }
        public function get y():Number { return mLightY; }

        public function set decay(value:Number):void { mDecay = value; }
        public function get decay():Number { return mDecay; }

        public function set exposure(value:Number):void { mExposure = value; }
        public function get exposure():Number { return mExposure; }

        public function set weight(value:Number):void { mWeight = value; }
        public function get weight():Number { return mWeight; }

        public function set density(value:Number):void { mDensity = value; }
        public function get density():Number { return mDensity; }
		
    }
}