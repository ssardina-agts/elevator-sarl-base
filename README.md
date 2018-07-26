# SARL Elevator Simulator Controllers - BASE (for Java-based Elevator Simulator) #

This project provides a base to build [SARL](http://www.sarl.io/)-based controllers for the [Java Elevator Simulator (RMIT Version)](https://bitbucket.org/ssardina-research/elevator-sim).

The project uses the [SARL Elevator Simulator Middleware](https://bitbucket.org/ssardina-research/sarl-elevatorsim-mw) to connect to and communicate with the elevator simulator via appropriate capacities/skills.

It also relies on the [SARL-PROLOG-CAP](https://bitbucket.org/ssardina-research/sarl-prolog-cap) project that provides capacities and skills for SARL agents to use [SWI Prolog](http://www.swi-prolog.org/) for implementing the knowledge base of the agents. 

Two dummy controllers, one using SWI Prolog, are provided.


## PRE-REQUISITES

* Java Runtime Environment (JRE) and Java Compiler (javac) v1.8 (use Sun version)
* Maven project management and comprehension tool (to meet dependencies, compile, package, run).
* [The Elevator Simulator Server (RMIT version)](https://bitbucket.org/ssardina-research/elevator-sim).
	* One can get a complete JAR file from its [Download](https://bitbucket.org/ssardina-research/elevator-sim/downloads/) section.
* SARL modules and execution engine
	* Requires environment variable `SARL_VERSION` set to the SARL version used, e.g., `export SARL_VERSION=0.7.2`
	* Version tested: 0.6.1, 0.7.2.
	* Obtained with Maven automatically from http://mvnrepository.com/artifact/io.sarl.maven).
* [SARL Elevator Simulator Middleware](https://bitbucket.org/ssardina-research/sarl-elevatorsim-mw):
	* The right version (specified in the POM file) should be obtained automatically via [JitPack](https://jitpack.io/#org.bitbucket.ssardina-research/sarl-elevatorsim-mw).
	* JAR file can also be manually obtained from [Download](https://bitbucket.org/ssardina-research/sarl-elevatorsim-mw/downloads/) section (for the corresponding SARL version) and install it (see instructions below). For example:

		```
		mvn install:install-file -Dfile=sarl-elevatorsim-mw-1.1.0.7.2.jar -DgroupId=rmit.agtgrp.sarl -DartifactId=sarl-elevatorsim-mw -Dversion=1.1.0.7.2 -Dpackaging=jar
		```

		This will install the JAR file in the local maven repo in `rmit/agtgrp/sarl/sarl-elevatorsim-mw/1.1.0.7.2/` 
	* Refer to its web page to understand what is provided to connect your agents to the simulator and interact with it.
	
* [SARL-PROLOG-CAP](https://bitbucket.org/ssardina-research/sarl-prolog-cap) capacity+skill for [SWI Prolog](http://www.swi-prolog.org/) system:
	* Capacities and skills to allow the use of SWI Prolog knowledge-bases in agents.
	* For the SWI-Prolog based knowledgebases, please refer to [this instructions](https://bitbucket.org/snippets/ssardina/bezbBx/swi-prolog-in-sarl-agent-controllers).
	* The right version (specified in the POM file) should be obtained automatically via [JitPack](https://jitpack.io/#org.bitbucket.ssardina-research/sarl-prolog-cap).


## DESCRIPTION OF DUMMY AGENTS

Both dummy controllers implement centralized (i.e., one agent controls all elevator cars) control of all cars. Cars are instructed to indefinitely iteraate between the highest and lowest floor. 
Some information is reported as cars reach their destinations. 

In the SWI Prolog version, a Prolog fact is added to store each car arrival when event `CarArrivedPercept` is received. 
Also, at every arrival, the Prolog knowledge-base is dumped to the file system as a file (with timestamp).

The SWI Prolog version has two important files:

* The initial SWI knowledgebase that the agent will load: `src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_elevator.pl`
* A capacity+skill `KB_Elevator` that encapsulates the meaningful Prolog queries for the domain: `src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_Elevator.sarl`
	* This capacity should be extended as Prolog's is used for the application. 


## RUNNING IT

From ECLIPSE one can create a SARL Application by running `BootMAS.sarl` which is a standard Java class that boots
up the desired agent:

* The controller agent to boot is given as a program argument argument, for example, `DummyMultiCarController`
* If using the SWI Prolog controller:
	* The initial knowledgebase to load needs to be given as a VM argument using the `-Dkb=<pl file>` format.
		* For example: `-Dkb=src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_elevator.pl`
	* Under Environment tab, set the following  variables (as per instructions [here](https://bitbucket.org/snippets/ssardina/bezbBx/swi-prolog-in-sarl-agent-controllers)):
		* Variable `LD_LIBRARY_PATH` to `/usr/lib/swi-prolog/lib/amd64/`
		* Variable `LD_PRELOAD` to `libswipl.so`
		
From CLI, one should first build the system by running `mvn package`. 
This will produce the JAR file under `target/` with all the dependencies.
The JAR file already has `BootMAS` as the default starting class. 

To run the default controller:

```
java -jar target/sarl-elevatorsim-base-1.0.0.7.2-jar-with-dependencies.jar
```


To run the `DummyMultiCarController` controller:

```
java -jar target/sarl-elevatorsim-base-1.0.0.7.2-jar-with-dependencies.jar DummyMultiCarController
```

To run the `DummySWIMultiCarController` controller:

```
java -jar target/sarl-elevatorsim-base-1.0.0.7.2-jar-with-dependencies.jar DummySWIMultiCarController \
	-Dkb=src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_elevator.pl
```

Remember that to use SWI Prolog you need to first set the following environment variables:

```
export LD_PRELOAD=$LD_PRELOAD:libswipl.so
export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/lib/swi-prolog/lib/amd64/
```

This can be done by executing `source set-swi-env.bash`



		
		

## LINKS 

* [Java Elevator Simulator (RMIT Version)](https://bitbucket.org/sarlrmit/elevator-sim)
	* Original simulator: <http://elevatorsim.sourceforge.net/>
	* EI for the Elevator Simulator: <https://github.com/eishub/ElevatorSim>
* Maven:
	* Doc: <https://maven.apache.org/general.html>
	* SARL distribution: <http://mvnrepository.com/artifact/io.sarl.maven>
	* JANUS / SRE (for janus.version in pom.xml):  <http://search.maven.org/#search%7Cga%7C1%7Cjanusproject>
	* JitPack service for remote installation of dependencies from Github & Bitbucket: <https://jitpack.io>
* SARL-elevatorsim-mw Middleware Elevator infrastructure to connect SARL to elevator simulator:
	* Home page: <https://bitbucket.org/sarlrmit/sarl-elevatorsim-mw>
* SARL:
	* Main page: <http://www.sarl.io/>
	* github repo: <https://github.com/sarl/sarl>
	* User forum: <https://groups.google.com/forum/?hl=en#!forum/sarl>
* SWI Prolog:
	* Main web page: <http://www.swi-prolog.org/>
	* JPL module (bidirectional link SWI-Java) for SWI: 
		* <http://www.swi-prolog.org/pldoc/doc_for?object=section(%27packages/jpl.html%27>
		* <http://jpl7.org/740/PrologApiOverview.jsp>
* Mochalog (higher abstraction than JPL): 
	* Home Page: <https://github.com/ssardina/mochalog>
	* In JitPack: <https://jitpack.io/#ssardina/mochalog>


## PROJECT CONTRIBUTORS 

* Sebastian Sardina (Project Supervisor & Contact - ssardina@gmail.com)



## LICENSE 

This project is using the GPLv3 for open source licensing for information and the license visit GNU website (https://www.gnu.org/licenses/gpl-3.0.en.html).

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
