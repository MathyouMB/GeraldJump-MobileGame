//Normal State

if(object_fluid != noone && can_swim)                                   //If in water, change to the swim
{                                                                       //state.
    if(place_meeting(x, y, object_fluid))
    {
        state = PLAYER_STATE.swim;
        exit;
    }
}

xspeed = 0;                                                             //Set horizontal speed
if(input_left)
{
   // xspeed -= run_speed;
}
if(input_right)
{
  //  xspeed += run_speed;
}

yspeed += grav;                                                         //Apply gravity

if(input_jump)
{
if(global.dead = false){
if ( y>560){
if(!instance_exists(obJumpSound)){
instance_create(x,y,obJumpSound);
}
}
}
    if(!grounded)
    {
        if(object_wall != noone && can_wall_jump)                       //Jump off wall
        {
            if(place_meeting(x + facing, y, object_wall))
            {
                xspeed          = wall_jump_speed * -facing;            //Multiplying by -facing will set the
                yspeed          = -sqrt(2 * grav * wall_jump_height);   //speed such that the player will
                jump_current    = 0;                                    //away from the wall.
                state           = PLAYER_STATE.wall_jump;
                exit;
            }
        }
    }
    
    if(jump_current > 0)                                                //Normal jump
    {
        yspeed = -sqrt(2 * grav * jump_height);                         //This calculates the required speed to
        jump_current--;                                                 //reach the desired height.
    }
}

if(yspeed <= 0)
{
    action = PLAYER_ACTION.jump;
}
else
{
    if(grounded)
    {
        jump_current = jump_number;
        action = PLAYER_ACTION.stand;
        if(xspeed != 0)
        {
            action = PLAYER_ACTION.run;
        }
    }
    else
    {
        action = PLAYER_ACTION.fall;
        if(object_wall != noone && can_wall_slide && xspeed != 0)   //If moving into a wall while falling he
        {                                                           //should wall slide.
            if(place_meeting(x + facing, y, object_wall))
            {
                yspeed = min(yspeed, wall_slide_speed);
                action = PLAYER_ACTION.wall_slide;
            }
        }
        
        if(can_ledge_grab)
        {
            var mask_width = bbox_right - bbox_left;                //Use the mask instead of sprite in case the
            var grabx = x + facing * (0.5 * mask_width + 1);        //mask is smaller than the sprite.
            var graby = bbox_bottom - hang_height;                  //grabx is a point 1 pixel to the side of the
                                                                    //player.
            if(collision_point(grabx, graby + yspeed,
                object_solid, false, true) != noone)
            {
                if(collision_point(grabx, graby,
                    object_solid, false, true) == noone)
                {
                    while(collision_point(grabx, y - hang_height + 0.5 * sprite_height,
                        object_solid, false, true) == noone)
                    {
                        y++;
                    }
                    yspeed          = 0;
                    jump_current    = jump_number;
                    state           = PLAYER_STATE.ledge_grab;
                    exit;
                }
            }
        }
    }
    
    if(object_ladder != noone && can_climb)
    {
        if(input_up || (input_down && !grounded))
        {
            if(place_meeting(x, y, object_ladder) &&                //This collision line checks across the top
                collision_line(bbox_left, bbox_top - 1, bbox_right, //of the player mask to ensure his feet aren't
                bbox_top -1, object_ladder, false, true) != noone)  //just touching a ladder while his body is above
            {                                                       //it.
                jump_current = jump_number;
                state = PLAYER_STATE.climb;
                exit;
            }
        }
    }
}
