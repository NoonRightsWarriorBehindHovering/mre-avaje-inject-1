# Preparations necessary: Download and extract JDK 21 and 20 to jdk-20 and jdk-21 folder respectively
# https://download.java.net/java/early_access/jdk21/16/GPL/openjdk-21-ea+16_linux-x64_bin.tar.gz
# https://download.oracle.com/java/20/latest/jdk-20_linux-x64_bin.tar.gz

LOG=run.log

echo 'BEGIN '$(date) > ${LOG}

echo '- - - - - -' >> ${LOG}
./javac.sh &>> ${LOG}
echo '- - - - - -' >> ${LOG}
JAVA_HOME=jdk-20 ./javac.sh &>> ${LOG}
echo '- - - - - -' >> ${LOG}
JAVA_HOME=jdk-21 ./javac.sh &>> ${LOG}
echo '- - - - - -' >> ${LOG}

echo 'END '$(date) >> ${LOG}
