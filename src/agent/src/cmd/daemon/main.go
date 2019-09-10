// +build linux darwin

/*
 * Tencent is pleased to support the open source community by making BK-CI 蓝鲸持续集成平台 available.
 *
 * Copyright (C) 2019 THL A29 Limited, a Tencent company.  All rights reserved.
 *
 * BK-CI 蓝鲸持续集成平台 is licensed under the MIT license.
 *
 * A copy of the MIT License is included in this file.
 *
 *
 * Terms of the MIT License:
 * ---------------------------------------------------
 * Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
 * LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN
 * NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
 * SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

package main

import (
	"encoding/json"
	"github.com/astaxie/beego/logs"
	"os"
	"os/exec"
	"pkg/util/fileutil"
	"pkg/util/systemutil"
	"runtime"
	"time"
)

func main() {
	runtime.GOMAXPROCS(4)
	initLog()
	defer func() {
		if err := recover(); err != nil {
			logs.Error("panic: ", err)
			systemutil.ExitProcess(1)
		}
	}()

	logs.Info("devops daemon start")
	logs.Info("pid: ", os.Getpid())

	watch()
}

var GAgentProcess *os.Process = nil

func initLog() {
	logConfig := make(map[string]string)
	logConfig["filename"] = systemutil.GetExecutableDir() + "/logs/devopsDaemon.log"
	logConfig["perm"] = "0666"
	jsonConfig, _ := json.Marshal(logConfig)
	logs.SetLogger(logs.AdapterFile, string(jsonConfig))
}

func watch() {
	workDir := systemutil.GetExecutableDir()
	var agentPath = workDir + "/devopsAgent"
	for {
		cmd := exec.Command(agentPath)
		cmd.Dir = workDir

		logs.Info("start devops agent")
		if !fileutil.Exists(agentPath) {
			logs.Error("agent file: ", agentPath, " not exists")
			logs.Info("restart after 30 seconds")
			time.Sleep(30 * time.Second)
			continue
		}

		err := fileutil.SetExecutable(agentPath)
		if err != nil {
			logs.Error("chmod failed, err: ", err.Error())
			logs.Info("restart after 30 seconds")
			time.Sleep(30 * time.Second)
			continue
		}

		err = cmd.Start()
		if err != nil {
			logs.Error("agent start failed, err: ", err.Error())
			logs.Info("restart after 30 seconds")
			time.Sleep(30 * time.Second)
			continue
		}

		GAgentProcess = cmd.Process
		logs.Info("devops agent started, pid: ", cmd.Process.Pid)
		_, err = cmd.Process.Wait()
		if err != nil {
			logs.Error("process wait error", err.Error())
		}
		logs.Info("agent process exited")

		logs.Info("restart after 30 seconds")
		time.Sleep(30 * time.Second)
	}
}
