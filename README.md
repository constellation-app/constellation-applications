# Constellation Applications

[Constellation](https://github.com/constellation-app/constellation) is a
graph-focused data visualisation and interactive analysis application enabling
data access, federation and manipulation capabilities across large and complex
data sets.

The intention of this repository is to use scripts to build different versions
of Constellation and keep the jre build logic isolated to this repository.

This repository also hosts the build scripts used to build the versions of
Constellation available on [the official website](https://constellation-app.com).

# List of Applications

## Constellation

The version of Constellation available from
[the official website](https://constellation-app.com) and includes the following
module suites:
  * [Constellation](https://github.com/constellation-app/constellation)
  * [Constellation Adaptors](https://github.com/constellation-app/constellation-adaptors)

## Constellation Cyber

A special distribution of Constellation for Cyber analysts and is also available
from the [the official website](https://constellation-app.com) and includes the
following module suites:
  * [Constellation](https://github.com/constellation-app/constellation)
  * [Constellation Adaptors](https://github.com/constellation-app/constellation-adaptors)
  * [Constellation Cyber Plugins](https://github.com/AustralianCyberSecurityCentre/constellation_cyber_plugins)

# Build Constellation Applications

## Build Constellation

Prior to building Constellation, `CoreFunctionality/src/au/gov/asd/tac/constellation/functionality/startup/Startup.java`
should be updated to specify the version number like the following:

```java
private static final String VERSION = "v1.0.0";
```

Next, navigate to `constellation-applications` and update
`constellation/build.xml` and change the line to look like

```xml
<property name="dist.version" value="v1.0.0"/>
```

Finally, to build Constellation you can use Docker and run something like this:

```bash
cd workspace
git clone https://github.com/constellation-app/constellation.git
git clone https://github.com/constellation-app/constellation-adaptors.git
git clone https://github.com/constellation-app/constellation-applications.git
sudo docker run -v "$PWD:/code" -v "$HOME/.ivy2:/root/.ivy2" --workdir \
  "/code/constellation-applications" constellationapplication/netbeans-runner:12.0.4 \
  ./build-zip.sh -a constellation -m "constellation constellation-adaptors"
```

This will build distributions of Constellation for Windows, Linux and MacOSX and will be available from `constellation-applications/constellation/dist`

NOTE: To include updated help documentation, running the applications constellation-adaptors will generate an updated toc.md file.

## Build Constellation Cyber

Prior to building Constellation, `CoreFunctionality/src/au/gov/asd/tac/constellation/functionality/startup/Startup.java`
should be updated to specify the version number like the following:

```java
private static final String VERSION = "v1.0.0";
```

Next, navigate to `constellation-applications` and update
`constellation-cyber/build.xml` and change the line to look like

```xml
<property name="dist.version" value="v1.0.0"/>
```

Also the application branding should be updated by updating `CoreUtilities/src/au/gov/asd/tac/constellation/utilities/BrandingUtilities.java`
with the title of the application being:

```java
public static final String APPLICATION_NAME = "Constellation Cyber";
```

To build Constellation you can use Docker and run something like this:

```bash
cd workspace
git clone https://github.com/constellation-app/constellation.git
git clone https://github.com/constellation-app/constellation-adaptors.git
git clone https://github.com/AustralianCyberSecurityCentre/constellation_cyber_plugins.git
git clone https://github.com/constellation-app/constellation-applications.git
sudo docker run -v "$PWD:/code" -v "$HOME/.ivy2:/root/.ivy2" --workdir \
  "/code/constellation-applications" constellationapplication/netbeans-runner:12.0.4 \
  ./build-zip.sh -a constellation-cyber \
  -m "constellation constellation-adaptors constellation_cyber_plugins"
```

This will build distributions of Constellation for Windows, Linux and MacOSX and will be available from `constellation-applications/constellation-cyber/dist`

NOTE: To include updated help documentation, running the applications constellation-adaptors and constellation_cyber_plugins will generate an updated toc.md file.

## More Information

This repository should follow everything mentioned in the Constellation
[README](https://github.com/constellation-app/constellation/blob/master/README.md).
