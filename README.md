LinkedList-NYC
==============

LinkedList NYC issued a coding contest - this is my entry.

This entry is an ASM linked list implementation. It uses the linked list to take the hex values
that make up the 'LinkedList NYC' string and store each character as an element within the linked
list. It then prints it out to the screen.

Instructions
============

Use the accompanying Makefile to compile linkedlist.asm, then run the created 'linkedlist' executable. E.g.

> $ make
> nasm -f elf  linkedlist.asm
> gcc -o linkedlist linkedlist.o
> rm -rf linkedlist.o
> $ ./linkedlist

Competition Email
=================

This was the original email explaining the contest:

> Hi Listheads,
> 
> We were working on another joke issue, but this morning we decided it was a bit mean-spirited. Instead, this week's issue is a programming contest! Here's the deal:
> 
> Write a program that prints the text "LinkedList NYC". For example, you could write the following in Python:
> 
> print "LinkedList NYC"
> 
> But that wouldn't be much fun. The goal is to do it in the most inventive way. Here's a slightly more interesting version in Bash:
> 
> curl -s http://www.linkedlistnyc.org | sed -n 's/ *<h1>\(.*\)<\/h1>/\1/p'
> 
> Bonus points if your code contains a pun, is self-referential, or is particularly clever or elegant. It can be as long or short as you like.
>
> The winner will get five pints of ice cream delivered to his or her door by the List itself [Seriously! -Ed.]. Note: You must live within the five boroughs or an area served by the PATH train to be eligible for delivery.
> 
> Your program must:
>
> print or evaluate to the string "LinkedList NYC"
> be sent to tips@linkedlistnyc.org by 10am Saturday, Nov. 3
> include instructions for how to run it (if it's not easy and obvious)
> Peace out, cub scouts.
> 
> Nick & Dave
