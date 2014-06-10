mkdir "$(SolutionDir)include\CoreFoundation"
mkdir "$(SolutionDir)include\CoreFoundation\GNUCompatibility\"

xcopy /Y /R *.h include\CoreFoundation\

xcopy /Y /R CFBasicHashFindBucket.m include\CoreFoundation\