%{
#include <stdio.h>
#include <time.h>

void yyerror(const char *s);  // Corrected function declaration
int yylex(void);
%}

%token HELLO GOODBYE TIME NAME WEATHER HOWAREYOU JOKE DATE

%%

chatbot : greeting
        | farewell
        | query
        ;

greeting : HELLO { printf("Chatbot: Hello! How can I help you today?\n"); }
         ;

farewell : GOODBYE { printf("Chatbot: Goodbye! Have a great day!\n"); }
         ;

query : TIME { 
            time_t now = time(NULL);
            struct tm *local = localtime(&now);  // Corrected syntax
            printf("Chatbot: The current time is %02d:%02d.\n", local->tm_hour, local->tm_min);
         }
      | NAME { printf("Chatbot: My name is ChatGPT.\n"); }
      | WEATHER { printf("Chatbot: I can't check the weather right now, but you can check a weather website or app.\n"); }
      | HOWAREYOU { printf("Chatbot: I'm just a bunch of code, but thanks for asking! How are you?\n"); }
      | JOKE { printf("Chatbot: Why don't scientists trust atoms? Because they make up everything!\n"); }
      | DATE {
            time_t now = time(NULL);
            struct tm *local = localtime(&now);  // Corrected syntax
            printf("Chatbot: Today's date is %04d-%02d-%02d.\n", local->tm_year + 1900, local->tm_mon + 1, local->tm_mday);
         }
      ;

%%

int main() {
    printf("Chatbot: Hi! You can greet me, ask for the time, ask my name, inquire about the weather, ask how I am, request a joke, or ask for today's date. You can also say goodbye.\n");
    while (yyparse() == 0) {
        // Loop until end of input
    }
    return 0;
}

void yyerror(const char *s) {  // Corrected function definition
    fprintf(stderr, "Chatbot: I didn't understand that.\n");
}
