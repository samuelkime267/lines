#define S smoothstep

uniform float uTime;
uniform float progress;
uniform sampler2D texture1;
uniform vec4 resolution;


varying vec2 vUv;
varying vec3 vPosition;


float PI = 3.141592653589793238;


vec4 Line(vec2 uv, float speed, float height, vec3 col,float uTime) {
	uv.y += S(1., 0., abs(uv.x)) * sin(uTime * speed + uv.x * height) * 0.5;

	return vec4(S(.06 * //creates the line 
								S(.2, .9, abs(uv.x)), 0., abs(uv.y) - .004) * col, 1.0) * //modulating thickness
								S(1., .3, abs(uv.x));
}


// float Line(vec2 uv, float speed, float height, float uTime) {
// 	float wave = sin(uv.x*height+uTime*(1.5 + speed)) //actual wave
//                  *smoothstep(.9, 0., abs(uv.x))*0.45; //amplitude ramp 
    
//     float line = smoothstep(0.12* //creates the line 
//                  smoothstep(0.2, 1., abs(uv.x))+0.016, 0.009, abs(uv.y+wave))* //modulating thickness
//                  smoothstep(1.1, .5, abs(uv.x)); //value fade
//     return line; 
// }



vec3 colorLines(vec2 uv , float uTime){
	uv = uv*2.0 -1.0;
	float value= 0.;
	for(float i = 0.; i<=10.; i+=1.0){

		float wave = sin(uv.x*i+4.0+uTime*(1.5 + i*0.1)) //actual wave
                 *smoothstep(.9, 0., abs(uv.x))*0.45; //amplitude ramp 
    
    float line = smoothstep(0.12* //creates the line 
                 smoothstep(0.2, 1., abs(uv.x))+0.016, 0.009, abs(uv.y+wave) * 5.)* //modulating thickness
                 smoothstep(1.1, .5, abs(uv.x)); //value fade
		

		value += line * (1.1-(i*0.15));
		// value += Line(uv, i*0.1, i+4.0, uTime) * (1.1-(i*0.15));
	}
	vec3 col = vec3(value*mix(vec3(0.6,0.4, 0.45), vec3(0.05, 0.18, 0.6), abs(uv.x)));
	col+= 0.1;

	// Output to screen
	return vec3(col);
}



void main()	{
	vec2 newUvPos = (vUv - 0.5) / 0.55;
	vec4 line = Line(newUvPos, 3., 100. ,vec3(0.44,0.12,0.89), uTime);

	float linesNo = 10.;
	vec4 lines = vec4 (0.);
	for (float i = 0.; i <= linesNo; i += 1.) {
			float t = i / linesNo;
			lines += Line(newUvPos, 1.+t , 4. + t, vec3(.2 + t * .7, .2 + t * .4, 0.3), uTime);
	}

	gl_FragColor = vec4(vec3(lines), 1.);
	// gl_FragColor = vec4(vec3(line), 1.);
	// gl_FragColor = vec4(vUv, 0., 1.);
	// gl_FragColor = vec4(newUvPos, 0., 1.);






	// vec3 lines = colorLines(vUv,uTime); 


	// gl_FragColor = vec4(vec3(lines.x), 1.);
	// float i = 200.;

	// float wave = sin(vUv.x*i+4.0+uTime*(1.5 + i*0.1)) //actual wave
  //                *smoothstep(.9, 0., abs(vUv.x))*0.45; //amplitude ramp 
	// float wave1 = cos(vUv.y*i+4.0+uTime*(1.5 + i*0.1)) //actual wave
  //                *smoothstep(.9, 0., abs(vUv.y))*0.45; //amplitude ramp 
	// gl_FragColor = vec4(vec3(smoothstep(wave, wave1, sin(cos(uTime) -5.) * 10.)), 1.);
}