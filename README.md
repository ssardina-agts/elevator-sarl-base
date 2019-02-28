# SARL Elevator Simulator Controllers - BASE (for Java-based Elevator Simulator) #

This project provides a base to build [SARL](http://www.sarl.io/)-based controllers for the [Java Elevator Simulator (RMIT Version)](https://bitbucket.org/ssardina-research/elevator-sim).

The project relies on:

1. The [SARL Elevator Simulator Middleware](https://bitbucket.org/ssardina-research/sarl-elevatorsim-mw) to connect to and communicate with the elevator simulator via appropriate capacities/skills.
2. The [SARL-PROLOG-CAP](https://bitbucket.org/ssardina-research/sarl-prolog-cap) project that provides a capacity and a skill for SARL agents to use [SWI Prolog](http://www.swi-prolog.org/) for implementing the knowledge base of the agents. 
	* This in turn relies on [SWI Prolog](http://swi-prolog.org) and the bidirectoinal Java-SWI [JPL framework](https://jpl7.org) 

Two dummy controllers, one of them using SWI Prolog, are provided.

**IMPORTANT:** General support documentation relevant to this project are:

* Instructions how to run SARL systems [here](https://bitbucket.org/snippets/ssardina/6eybMg/sarl-application-general-information-setup)
* FAQ for SARL+SWI+Maven [here](https://bitbucket.org/snippets/ssardina/9er67X).


## PRE-REQUISITES

* Java Runtime Environment (JRE) and Java Compiler (javac) v1.8 (use Sun version)
* Maven project management and comprehension tool (to meet dependencies, compile, package, run).
* [The Elevator Simulator Server (RMIT version)](https://bitbucket.org/ssardina-research/elevator-sim).
	* A complete JAR file can be obtained in the [Download](https://bitbucket.org/ssardina-research/elevator-sim/downloads/) section.
* [SARL modules and execution engine](http://mvnrepository.com/artifact/io.sarl.maven). Last SARL version tested 0.8.6.
	* Requires environment variable `SARL_VERSION` set to the SARL version used, e.g., `export SARL_VERSION=0.8.6` in Linux and `set SARL_VERSION 0.8.6` in Windows.
		* In Linux/Mac, to make ECLIPSE see this environment variable, you may need to start it from CLI after the export statement (`./eclipse-sarl` in Linux or `open /Applications/eclipse`). 
		* In Windows, if `SARL_VERSION` is defined globally, then ECLIPSE will use it well.
* [SARL Elevator Simulator Middleware](https://bitbucket.org/ssardina-research/sarl-elevatorsim-mw): this provides the SARL capacity and skills to talk to the elevator simulator. 
	* Refer to the [MW capacities](https://bitbucket.org/ssardina-research/sarl-elevatorsim-mw/src/master/src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlmw/capacities/?at=master) to understand what is provided to connect your agents to the simulator and interact with it.
	* It should be obtained automatically as a Maven dependency via [JitPack](https://jitpack.io/#org.bitbucket.ssardina-research/sarl-elevatorsim-mw). 
* The [SARL-PROLOG-CAP](https://bitbucket.org/ssardina-research/sarl-prolog-cap) capacity+skill for [SWI Prolog](http://www.swi-prolog.org/) system:
	* Capacity (and skill) to allow SARL agents to have Prolog knowledge-bases. Refer to instructions and examples there.
	* Relies on [JPL](https://jpl7.org/) for the  implementation to have [SWI Prolog](http://www.swi-prolog.org/) access in agents.
	* The right version (specified in the POM file) should be obtained automatically via [JitPack](http://jitpack.io):
		* From Bitbucket repo (less reliable): [JitPack](https://jitpack.io/#org.bitbucket.ssardina-research/sarl-prolog-cap).
		* From Github clone (more reliable): [JitPack](https://jitpack.io/#ssardina-sarl/sarl-prolog-cap)

## DESCRIPTION OF DUMMY AGENTS

Both dummy controllers implement centralized (i.e., one agent controls all elevator cars) control of all cars. Cars are instructed to indefinitely iterate between the highest and lowest floor. 
Some information is reported as cars reach their destinations. 

In the SWI Prolog version, a Prolog fact is added to store each car arrival when event `CarArrivedPercept` is received. 
Also, at every arrival, the Prolog knowledge-base is dumped to the file system as a file (with timestamp).

The SWI Prolog version has two important files:

* The initial SWI knowledgebase that the agent will load: `src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_elevator.pl`
* A capacity+skill `KB_Elevator` (and a corresponding SWI-type skill) that encapsulates the meaningful Prolog queries for the domain: `src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_Elevator.sarl`
	* This capacity should be extended as Prolog's is used for the application. 


## RUNNING THE CONTROLLERS AGAINST THE SIMULATOR

To run the controllers provided in this package, follow the following 3 steps.

1. Start the [elevator simulator](https://bitbucket.org/ssardina-research/elevator-sim), either from ECLIPSE (if you have it as a project) or directly with its JAR file
2. Navigate to *File > New*, choose a simulator scenario from the available list, choose your simulation parameters, and click *Apply*.
3. Start SARL Controller you want to deploy.

You can run the SARL controller, either from ECLIPSE or from CLI (via Java or Maven), please refer to [this instructions](https://bitbucket.org/snippets/ssardina/6eybMg#markdown-header-4-running-the-sarl-application).


### EXAMPLES

By default Maven produces the JAR file without dependencies as plugin `maven-assembly-plugin` is too slow to compile. 
So, we can run the system using `exec-maven-plugin` which will run class `BootMAS` automatically and deal with all dependencies:

	mvn exec:java -Dexec.args=DummySWIMultiCarController -Dkb=src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_elevator.pl

If we have built the jar with dependencies (by enabling in `maven-assembly-plugin`), we can do:

	java -Dkb=src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_elevator.pl \
		-jar target/sarl-elevatorsim-base-1.2.0.7.2-jar-with-dependencies.jar DummySWIMultiCarController
		
Remember to set-up your system environment variables depending on your platform (Linux, Windows, etc.) to that SWI can be found.
See [this entry](https://bitbucket.org/snippets/ssardina/9er67X#markdown-header-what-environment-variables-i-should-care-about-in-linux) in the FAQ.
This variables can be set in script `set-env-vars.sh` and then exported as `source ./set-env-var.bash`

In Windows, as long as the environment variables have been correctly set up as above, everything should work well.

Check a video how to run the simulator and the agent [here](https://www.youtube.com/watch?v=rl7YRjPi5pc).
		
		

## PROJECT CONTRIBUTORS 

* Sebastian Sardina (Project Supervisor, Developer & Contact - ssardina@gmail.com)
* Matthew McNally (2017 Capstone Project Coordinator and SARL Agent Developer) 
* Joshua Richards (Java Elevator Sim Server developer)
* Joshua Beale (SARL Agent Developer)
* Dylan Rock (Documentation)


## LICENSE 

This project is using the GPLv3 for open source licensing for information and the license visit GNU website (https://www.gnu.org/licenses/gpl-3.0.en.html).

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.