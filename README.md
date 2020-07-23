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

* Constellation - The version of Constellation available from 
[the official website](https://constellation-app.com) and includes the following 
module suites:
    * [Constellation](https://github.com/constellation-app/constellation) and
    * [Constellation Adaptors](https://github.com/constellation-app/constellation-adaptors)

* Constellation Cyber - (coming soon)

# Build Constellation Applications

## Build Constellation

To build Constellation you can use Docker and run something like this:

```bash
cd workspace
git clone https://github.com/constellation-app/constellation.git
git clone https://github.com/constellation-app/constellation-adaptors.git
git clone https://github.com/constellation-app/constellation-applications.git
cd ..
sudo docker run -v "$PWD:/code" --workdir "/code/constellation-applications" constellationapplication/netbeans-runner:12 ./build-zip.sh
```

This will build distributions of Constellation for Windows, Linux and MacOSX and will be available from `constellation-applications/constellation/dist`

## More Information
This repository should follow everything mentioned in the Constellation 
[README](https://github.com/constellation-app/constellation/blob/master/README.md).
