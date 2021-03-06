# SARL Elevator Simulator Controllers - BASE

This project provides a base to build [SARL](http://www.sarl.io/)-based controllers for the [Java Elevator Simulator (RMIT Version)](https://github.com/ssardina-agts/elevator-simulator).

Two dummy controllers, one of them using SWI-Prolog for knowledge-base reasoning, are provided.

**Version convention**: `Major.Minor.<SARL Version>`. For example, 1.3.0.7.2 is version 1.3 for SARL 0.7.2.

## PRE-REQUISITES

To run this base elevator controller application one needs:

- Java SE Development Kit (JDK) Version 1.8+.
- Maven project management and comprehension tool (to meet dependencies, compile, package, run).
- [The Elevator Simulator Server (RMIT version)](https://github.com/ssardina-agts/elevator-simulator).
- [SWI-Prolog](https://www.swi-prolog.org/): a state-of-the-art implementation of Prolog.
- [JPL](https://jpl7.org/) package for SWI-Prolog: Java classes and C native functions providing a bidirectional interface between Java and Prolog.

The following  dependencies are resolved via Maven and JitPack automatically:

- [SARL modules and execution engine](http://mvnrepository.com/artifact/io.sarl.maven).
- The [SARL Elevator Simulator Middleware](https://github.com/ssardina-agts/elevator-sarl-mw), which provides the basic infrastructure, via capacities/skills, to connect to and communicate with the elevator simulator.
  - Refer to the [MW capacities](https://github.com/ssardina-agts/elevator-sarl-mw/tree/master/src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlmw/capacities) to understand what is provided to interact with the elevator simulator.
- The [SARL-PROLOG-CAP](https://github.com/ssardina-agts/sarl-prolog-cap) framework that provides agents with the skill to use [SWI-Prolog](http://www.swi-prolog.org/) for belief maintenance & management. Such framework relies, in turn, on the [JPL](https://jpl7.org/) for linking Prolog with Java.

The system has been tested under Linux Ubuntu 20.04 and Windows 10.

* In Linux, Java JDK and Maven can be obtained via the package manager. For SWI-Prolog and JPL install packages `swi-prolog` and `swi-prolog-java` via this [PPA](https://www.swi-prolog.org/build/PPA.html).
* In Windows, install Java JDK 1.8+ (make sure it is the 64-bit one), [Maven for Windows](https://maven.apache.org/guides/getting-started/windows-prerequisites.html), and [SWI-Prolog](https://www.swi-prolog.org/download/stable) with Java Interface, and make sure you add them all to your `Path` environment variable.
## VERSION MANAGEMENT

The version convention used is `Major.Minor.<SARL Version>`.

For example, 1.3.0.11.0 is version 1.3 for SARL 0.11.0.

To change the version of your application change the following entries in the POM:

1. Update `X.Y` only on the `<version>` key at the top of the file. This should happen when you actually change your application (e.g., a new feature is added or something is fixed).
2. Update the `Z` version by updating the `<sarl.version>` property.

## DESCRIPTION OF DUMMY AGENTS

Two simple dummy controllers are provided via agents:
- `DummyMultiCarController`: fully implemented in SARL/Java.
- `DummySWIMultiCarController`: implemented using SARL/Java and SWI-Prolog.

Both controller agents implement a simple centralized controller for al elevator cars, that is, the agent controls all the cars in the elevator system. Under these two controllers, cars are instructed to indefinitely iterate between the highest and lowest floors. Some information is reported as cars reach their destinations.

In the SWI-Prolog version (agent `DummySWIMultiCarController`), a Prolog fact is added to store each car arrival when event `CarArrivedPercept` is received. In turn, at every arrival, the Prolog knowledge-base is dumped to a file (with timestamp in its name) in folder `kb_elev_dump/`.

The SWI-Prolog controller relies on two important files:

- The initial SWI knowledge-base (loaded by the agent at the start): file `src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_elevator.pl`
- A capacity & skill `KB_Elevator` (and a corresponding SWI-type skill) that encapsulates the meaningful Prolog queries for the domain: file `src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_Elevator.sarl`

It is expected that as this base system is extended, both files will be further elaborated to account for a more expressive and powerful knowledge-base that the SARL agent (or agents) will use.

## RUNNING THE CONTROLLERS AGAINST THE SIMULATOR

To run the controllers provided in this application:

1. Start the [Java-based elevator simulator](https://github.com/ssardina-agts/elevator-simulator).
2. Navigate to **_File > New_**, choose a simulator scenario from the available list (usually, just "Random Rider Insertion"), change your simulation parameters (if needed), and click **_Apply_**. The simulator is now waiting for a connection from some controller.
3. Start SARL Controller you want to run. The controller should connect to the simulator.
4. Hit "_Go, Dude!_" in the simulator to start the simulation.

### EXAMPLES

First, compile the application:

```shell
$ mvn clean package
```

This will generate corresponding JAR files under `target/`. It will generate one small JAR file without the dependencies and one large JAR file with all dependencies included.

To run the application using Maven (via plugin `exec-maven-plugin`):

```bash
$ mvn exec:java \
	-Dkb=src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_elevator.pl
```

which will run class `BootMAS` and pass the Prolog KB file by setting the property `kb` (which the agent will read and use). The booting utility will ask the user which of the available controllers to run.

We can also pass the specific agent to boot to class `BootMAS` as follows

```bash
$ mvn exec:java -Dexec.args=DummySWIMultiCarController \
	-Dkb=src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_elevator.pl
```

Note that if you boot the SWI-based agent and do not pass the initial knowledgebase, the agent will give an error and terminate.

There are also specialized booting classes `BootMAS_Dummy` and `BootMAS_DummySWI` to directly boot the two dummy agents. For example:

```bash
mvn exec:java -Dexec.mainClass="BootMAS_DummySWI"
```

This `BootMAS_DummySWI` Java class will directly boot agent `DummySWIMultiCarController` with the Prolog knowledgebase set.

Finally, one can start an agent directly using Java (i.e., without maven) via Janus' built-in agent booting class `io.sarl.sre.boot.Boot` as follows:

```bash
$ java -Dkb=src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_elevator.pl \
	-jar target/elevator-sarl-base-1.5.0.11.0-with-dependencies.jar \
	io.sarl.sre.boot.Boot \
	au.edu.rmit.agtgrp.elevatorsim.sarlctrl.controllers.DummySWIMultiCarController
```

This states to run Janus agent booting class  `io.sarl.sre.boot.Boot` who will, in turn, boot up the agent `au.edu.rmit.agtgrp.elevatorsim.sarlctrl.controllers.DummySWIMultiCarController`.

Because Janus' booting class is already set as default class in the JAR, one can simply do:

```bash
$ java -Dkb=src/main/sarl/au/edu/rmit/agtgrp/elevatorsim/sarlctrl/beliefs/KB_elevator.pl \
	-jar target/elevator-sarl-base-1.5.0.11.0-with-dependencies.jar \
	au.edu.rmit.agtgrp.elevatorsim.sarlctrl.controllers.DummySWIMultiCarController
```

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