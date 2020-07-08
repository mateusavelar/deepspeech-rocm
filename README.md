# deepspeech-rocm
Docker file sample for deepspeech training based on ROCm for compatible AMD GPUs 
---------------------
After build the image,you can run the container as follow:

``` bash
docker run -it --network=host --device=/dev/kfd --device=/dev/dri \
--ipc=host --shm-size 16G --group-add video --cap-add=SYS_PTRACE --security-opt seccomp=unconfined \
-v /audio:/audio \
-v /home/user/deepSpeechData/checkpoints:/dps/checkpoints/ \
-v /home/user/deepSpeechData/model_export:/dps/model_export/ \
tfamd /bin/bash
```

Since:
/audio: on your machine represents the folder containing .wav files for training
/home/user/deepSpeechData/checkpoints: the place you'll save checkpoints on your host
/home/user/deepSpeechData/model_export: the place you'll save trained model

When container is up and running, you can start the training, remember to change the parameter as your needs, the following are just a sample:

``` bash
python3 -u DeepSpeech.py   \
--train_files /audio/pt/clips/train.csv   \
--dev_files /audio/pt/clips/dev.csv   \
--test_files /audio/pt/clips/test.csv   \
--train_batch_size 2   \
--dev_batch_size 18   \
--test_batch_size 10   \
--n_hidden 1024   \
--epochs 75   \
--learning_rate 0.001   \
--dropout_rate 0.20   \
--checkpoint_secs 600   \
--log_level 1   \
--checkpoint_dir /dps/checkpoints/   \
--export_dir /dps/model_export/   
```

