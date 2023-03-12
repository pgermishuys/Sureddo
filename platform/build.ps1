$ErrorActionPreference = "Stop"

if ($args[0] -eq "local") {
	Write-Host "Building on local system..."
	dotnet run --project build -- $args[1..($args.Count)]
	exit 0;
}

Write-Host "Building in docker (use './build.ps1 local' to build without using docker)..."

$GitHubToken=$Env:GitHubToken
$GITHUB_RUN_NUMBER=$Env:GITHUB_RUN_NUMBER

if ($GitHubToken -eq $null -or $GitHubToken -eq "") {
	Write-Error "GitHubToken environment variable empty or missing."
}

if ($GITHUB_RUN_NUMBER -eq $null -or $GITHUB_RUN_NUMBER -eq "") {
	Write-Warning "GITHUB_RUN_NUMBER environment variable empty or missing."
}

$tag="sureddo-platform"

# Build the build environment image.
docker build `
 --build-arg GitHubToken=$GitHubToken `
 --build-arg GITHUB_RUN_NUMBER=$GITHUB_RUN_NUMBER `
 -f build.dockerfile `
 --tag $tag.

# Build inside build environment
docker run --rm --name $tag `
 -v /var/run/docker.sock:/var/run/docker.sock `
 -v $PWD/../.git:/repo/.git `
 --network host `
 $tag `
 cargo build
