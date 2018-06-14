# SARL Elevator Simulator Controllers - BASE (for Java-based Elevator Simulator) #

This project provides a base to build [SARL](http://www.sarl.io/)-based controllers for the [Java Elevator Simulator (RMIT Version)](https://bitbucket.org/sarlrmit/elevator-sim).

The project uses the [SARL Elevator Simulator Middleware](https://bitbucket.org/sarlrmit/sarl-elevatorsim-mw) to connect to and communicate with the elevator simulator via appropriate capacities/skills.

It also relies on the [SARL-PROLOG-CAP](https://bitbucket.org/ssardina-research/sarl-prolog-cap) project that provides capacities and skills for SARL agents to use [SWI Prolog](http://www.swi-prolog.org/) for implementing the knowledge base of the agents. 

Two dummy controllers, one using SWI Prolog, are provided.


## PRE-REQUISITES

* Java Runtime Environment (JRE) and Java Compiler (javac) v1.8 (sun version recommended)
* Maven project management and comprehension tool (to meet dependencies, compile, package, run).
* [The Elevator Simulator Server (RMIT version)](https://bitbucket.org/sarlrmit/elevator-sim).
	* One can get a complete JAR file from its [Download](https://bitbucket.org/ssardina-research/elevator-sim/downloads/) section.
* SARL modules and execution engine
	* Requires environment variable `SARL_VERSION` set to the SARL version used, e.g., `export SARL_VERSION=0.7.2`
	* Version tested: 0.6.1, 0.7.2.
	* Obtained with Maven automatically from http://mvnrepository.com/artifact/io.sarl.maven).
* [SARL Elevator Simulator Middleware](https://bitbucket.org/ssardina-research/sarl-elevatorsim-mw):
	* JAR file needs to be obtained from [Download](https://bitbucket.org/ssardina-research/sarl-elevatorsim-mw/downloads/) section (for the corresponding SARL version) and install it (see instructions below)

		```
		mvn install:install-file -Dfile=sarl-elevatorsim-mw-1.0.0.7.2.jar -DgroupId=rmit.agtgrp.sarl -DartifactId=sarl-elevatorsim-mw -Dversion=1.0.0.7.2 -Dpackaging=jar
		```

		This will install the JAR file in the local maven repo in `rmit/agtgrp/sarl/sarl-elevatorsim-mw/1.0.0.7.2/` 
	
	* Refer to its web page to understand what is provided to connect your agents to the simulator and interact with it.
* [SARL-PROLOG-CAP](https://bitbucket.org/ssardina-research/sarl-prolog-cap):
	* Capacities and skills to allow the use of SWI Prolog in agents.
	* For the SWI-Prolog based knowledgebases, please refer to [this instructions](https://bitbucket.org/snippets/ssardina/bezbBx/swi-prolog-in-sarl-agent-controllers).




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
* Matthew McNally (Capston Project Coordinator and SARL Agent Developer) 
* Joshua Richards (Java Elevator Sim Server developer)
* Joshua Beale (SARL Agent Developer)
* Dylan Rock (Documentation)





## LICENSE 

This project is using the GPLv3 for open source licensing for information and the license visit GNU website (https://www.gnu.org/licenses/gpl-3.0.en.html).

This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.
