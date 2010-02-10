new Effect.Opacity('timing', { from: 0.0, to: 0.0, duration: 0.0 });
var is_playing = true;
function showtiming() {
	new Effect.Opacity('timing', { from: 0.0, to: 1.0, duration: 0.2 });
}
function hidetiming() {
	new Effect.Opacity('timing', { from: 1.0, to: 0.0, duration: 0.2 });
}
function togglePlay() {
	if (is_playing == true)
	{
		new Effect.Morph('current', { 
			style: 'background:#222222;border-top:3px #242424 solid;', 
			duration: 0.1 
		});
		soundManager.pauseAll();
		is_playing = false;
	}
	else
	{
		new Effect.Morph('current', { 
			style: 'background:#999;border-top:3px #242424 solid;', 
			duration: 0.1 
		});
		soundManager.resumeAll();
		is_playing = true;
	}
}
function hoverOn() {
	if ( is_playing == true )
	{
		new Effect.Morph('current', { 
			style: 'background:#888;border-top:3px #242424 solid;', 
			duration: 0.1 
		});
	}
}
function hoverOff() {
	if ( is_playing == true )
	{
		new Effect.Morph('current', { 
			style: 'background:#f5f5f5;border-top:3px #F2F2F2 solid;', 
			duration: 0.1 
		});
	}
}