
enum GOAL_REPEAT { Never, Daily, Weekly }

String enumLabel( GOAL_REPEAT input){
return input.toString().split('.')[1];
}
