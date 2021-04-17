Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BB4362F2A
	for <lists+linux-pci@lfdr.de>; Sat, 17 Apr 2021 12:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236118AbhDQKUf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 17 Apr 2021 06:20:35 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:17356 "EHLO
        szxga07-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236092AbhDQKU1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 17 Apr 2021 06:20:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4FMptC4HFwz7vW0;
        Sat, 17 Apr 2021 18:17:39 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 17 Apr 2021 18:19:50 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <gregkh@linuxfoundation.org>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <song.bao.hua@hisilicon.com>,
        <john.garry@huawei.com>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <yangyicong@hisilicon.com>, <linuxarm@huawei.com>
Subject: [PATCH RESEND 3/4] docs: Add HiSilicon PTT device driver documentation
Date:   Sat, 17 Apr 2021 18:17:10 +0800
Message-ID: <1618654631-42454-4-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
References: <1618654631-42454-1-git-send-email-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Document the introduction and usage of HiSilicon PTT device driver.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 Documentation/trace/hisi-ptt.rst | 326 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 326 insertions(+)
 create mode 100644 Documentation/trace/hisi-ptt.rst

diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
new file mode 100644
index 0000000..f093846
--- /dev/null
+++ b/Documentation/trace/hisi-ptt.rst
@@ -0,0 +1,326 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+======================================
+HiSilicon PCIe Tune and Trace device
+======================================
+
+Introduction
+============
+
+HiSilicon PCIe tune and trace device (PTT) is a PCIe Root Complex
+integrated Endpoint (RCiEP) device, providing the capability
+to dynamically monitor and tune the PCIe link's events (tune),
+and trace the TLP headers (trace). The two functions are independent,
+but is recommended to use them together to analyze and enhance the
+PCIe link's performance.
+
+On Kunpeng 930 SoC, the PCIe Root Complex is composed of several
+PCIe cores. Each PCIe core includes several Root Ports and a PTT
+RCiEP, like below. The PTT device is capable of tuning and
+tracing the link of the PCIe core.
+::
+          +--------------Core 0-------+
+          |       |       [   PTT   ] |
+          |       |       [Root Port]---[Endpoint]
+          |       |       [Root Port]---[Endpoint]
+          |       |       [Root Port]---[Endpoint]
+    Root Complex  |------Core 1-------+
+          |       |       [   PTT   ] |
+          |       |       [Root Port]---[ Switch ]---[Endpoint]
+          |       |       [Root Port]---[Endpoint] `-[Endpoint]
+          |       |       [Root Port]---[Endpoint]
+          +---------------------------+
+
+The PTT device driver cannot be loaded if debugfs is not mounted.
+Each PTT device will be presented under /sys/kernel/debugfs/hisi_ptt
+as its root directory, with name of its BDF number.
+::
+
+    /sys/kernel/debug/hisi_ptt/<domain>:<bus>:<device>.<function>
+
+Tune
+====
+
+PTT tune is designed for monitoring and adjusting PCIe link parameters (events).
+Currently we support events in 4 classes. The scope of the events
+covers the PCIe core to which the PTT device belongs.
+
+Each event is presented as a file under $(PTT root dir)/$(BDF)/tune, and
+mostly a simple open/read/write/close cycle will be used to tune
+the event.
+::
+    $ cd /sys/kernel/debug/hisi_ptt/$(BDF)/tune
+    $ ls
+    qos_tx_cpl    qos_tx_np    qos_tx_p
+    tx_path_rx_req_alloc_buf_level
+    tx_path_tx_req_alloc_buf_level
+    $ cat qos_tx_dp
+    1
+    $ echo 2 > qos_tx_dp
+    $ cat qos_tx_dp
+    2
+
+Current value (numerical value) of the event can be simply read
+from the file, and the desired value written to the file to tune.
+
+1. Tx path QoS control
+------------------------
+
+The following files are provided to tune the QoS of the tx path of
+the PCIe core.
+
+- qos_tx_cpl: weight of Tx completion TLPs
+- qos_tx_np: weight of Tx non-posted TLPs
+- qos_tx_p: weight of Tx posted TLPs
+
+The weight influences the proportion of certain packets on the PCIe link.
+For example, for the storage scenario, increase the proportion
+of the completion packets on the link to enhance the performance as
+more completions are consumed.
+
+The available tune data of these events is [0, 1, 2].
+Writing a negative value will return an error, and out of range
+values will be converted to 2. Note that the event value just
+indicates a probable level, but is not precise.
+
+2. Tx path buffer control
+-------------------------
+
+Following files are provided to tune the buffer of tx path of the PCIe core.
+
+- tx_path_rx_req_alloc_buf_level: watermark of Rx requested
+- tx_path_tx_req_alloc_buf_level: watermark of Tx requested
+
+These events influence the watermark of the buffer allocated for each
+type. Rx means the inbound while Tx means outbound. The packets will
+be stored in the buffer first and then posted either when the watermark
+reached or when timed out. For a busy direction, you should increase
+the related buffer watermark to avoid frequently posting and thus
+enhance the performance. In most cases just keep the default value.
+
+The available tune data of above events is [0, 1, 2].
+Writing a negative value will return an error, and out of range
+values will be converted to 2. Note that the event value just
+indicates a probable level, but is not precise.
+
+Trace
+=====
+
+PTT trace is designed for dumping the TLP headers to the memory, which
+can be used to analyze the transactions and usage condition of the PCIe
+Link. You can choose to filter the traced headers by either requester ID,
+or those downstream of a set of Root Ports on the same core of the PTT
+device. It's also supported to trace the headers of certain type and of
+certain direction.
+
+In order to start trace, you need to configure the parameters first.
+The parameters files are provided under $(PTT root dir)/$(BDF)/trace.
+::
+    $ cd /sys/kernel/debug/hisi_ptt/$(BDF)/trace
+    $ ls
+    free_buffer     filter      buflet_nums     buflet_size
+    direction       type        data            trace_on
+    data_format
+
+1. filter
+---------
+
+You can configure the filter of TLP headers through the file. The filter
+is provided as BDF numbers of either Root Port or subordinates, which
+belong to the same PCIe core. You can get the filters available and
+currently configured by reading the file, and write the desired BDF to
+the file to set the filters. There is no default filter, which means you
+must specify at least one filter before starting tracing. Writing an
+invalid BDF (not in the available list) will return a failure.
+::
+    $ echo 0000:80:04.0 > filter
+    $ cat filter
+    #### Root Ports ####
+    0000:80:00.0
+    [0000:80:04.0]
+    #### Functions ####
+    0000:81:00.0
+    0000:81:00.1
+    0000:82:00.0
+
+Note that multiple Root Ports can be specified at one time, but only
+one Endpoint function can be specified in one trace. Specifying both
+Root Port and function at the same time is not supported.
+
+If no filter is available, reading the filter will get the hint.
+::
+    $ cat filter
+    #### No available filter ####
+
+The filter can be dynamically updated, which means you can always
+get correct filter information when hotplug events happen, or
+when you manually remove/rescan the devices.
+
+2. type
+-------
+
+You can trace the TLP headers of certain types by configuring the file.
+Reading the file will get available types and current setting, and write
+the desired type to the file to configure. The default type is
+`posted_request`. Write the types not in the available list will return
+a failure.
+::
+    $ echo completion > type
+    $ cat type
+    all  posted_request  non-posted_request  [completion]
+
+3. direction
+------------
+
+You can trace the TLP headers from certain direction, which is relative
+to the Root Port or the PCIe core. Read the file to get available
+directions and current configurition, and write the desired direction
+to configure. The default value is `rx` and any invalid direction will
+return a failure. Note `rxtx_no_dma_p2p` means the headers of both
+directions, but not include P2P DMA access.
+::
+    $ echo rxtx > direction
+    $ cat direction
+    rx  tx  [rxtx]  rxtx_no_dma_p2p
+
+4. buflet_size
+--------------
+
+The traced TLP headers will be written to the memory allocated
+by the driver. The hardware accepts 4 DMA address with same size,
+and writes the buflet sequentially like below. If DMA addr 3 is
+finished and the trace is still on, it will return to addr 0.
+Driver will allocate each DMA buffer (we call it buflet).
+The finished buflet will be replaced with a new one, so
+a long time trace can be achieved.
+::
+    +->[DMA addr 0]->[DMA addr 1]->[DMA addr 2]->[DMA addr 3]-+
+    +---------------------------------------------------------+
+
+You should both configure the buflet_size and buflet_nums to
+configure the `trace buffer` to receive the TLP headers. The
+total trace buffer size is buflet_size * buflet_nums. Note
+that the trace buffer will not be allocated immediately after you
+configure the parameters, but will be allocated right before
+the trace starts.
+
+This file configures the buflet size. Read the file will get
+available buflet size and size set currently; write the desired
+size to the file to configure. The default size is 2 MiB and any
+invalid size written will return a failure.
+::
+    $ cat buflet_size
+    [2 MiB]     4 MiB
+    $ echo 4 > buflet_size
+    $ cat buflet_size
+    2 MiB     [4 MiB]
+
+5. buflet_nums
+--------------
+
+You can write the desired buflet count to the file to configure,
+and read the file to get current buflet count. The default
+value is 64. Any positive value is valid. Note that big value
+may lead to DMA memory allocation failure, and you will not be
+able to start tracing. If it happens, you should consider adjusting
+buflet_nums or buflet_size.
+::
+    $ cat buflet_nums
+    64
+    $ echo 128 > buflet_nums
+    $ cat buflet_nums
+    128
+
+6. data
+-------
+
+The file to access the traced data. You can read the file to get the
+binary blob of traced TLP headers. The format of the headers is
+4 Dword length and is just as defined by the PCIe Spec r4.0,
+Sec 2.2.4.1, or 8 Dword length with additional 4 Dword extra
+information.
+
+echo "" > data will free all the trace buffers allocated as well as
+the traced datas.
+
+7. trace_on
+-----------
+
+Start or end the trace by writing to the file, and monitor the trace
+status by reading the file.
+::
+    $ echo 1 > trace_on     # start trace
+    $ cat trace_on          # get the trace status
+    1
+    $ echo 0 > trace_on     # manually end trace
+
+The read value of the trace_on will be auto cleared if the buffer
+allocated is full. 1 indicates the trace is running and 0 for
+stopped. Writing any non-zero value to the file starts tracing.
+
+8. free_buffer
+--------------
+
+File to indicate the trace buffer status and to manually free the
+trace buffer. The read value of 1 indicates the trace buffer has
+been allocated and exists in the memory, while 0 indicates there
+is no buffer allocated. Write 1 to the file to free the trace
+buffer as well as the traced data.
+::
+    $ cat free_buffer
+    1                       # indicate the buffer exists
+    $ echo 1 > free_buffer  # free the trace buffer
+    $ cat free_buffer
+    0
+
+9. data_format
+--------------
+
+File to indicate the format of the traced TLP headers. User can
+specify the desired format of traced TLP headers. Available formats
+are 4DW, 8DW which indicates the length of each TLP headers traced.
+::
+    $ cat data_format
+    [4DW]    8DW
+    $ echo 8 > data_format
+    $ cat data_format
+    4DW     [8DW]
+
+The traced TLP header format is different from the PCIe standard.
+
+When using the 8DW data format, the entire TLP header is logged
+(Header DW0-3 shown below). For example, the TLP header for Memory
+Reads with 64-bit addresses is shown in PCIe r5.0, Figure 2-17;
+the header for Configuration Requests is shown in Figure 2.20, etc.
+
+In addition, 8DW trace buffer entries contain a timestamp and
+possibly a prefix for a PASID TLP prefix (see Figure 6-20).
+Otherwise this field will be all 0.
+
+The bit[31:11] of DW0 is always 0x1fffff, which can be
+used to distinguish the data format. 8DW format is like
+::
+    bits [                 31:11                 ][       10:0       ]
+         |---------------------------------------|-------------------|
+     DW0 [                0x1fffff               ][ Reserved (0x7ff) ]
+     DW1 [                       Prefix                              ]
+     DW2 [                     Header DW0                            ]
+     DW3 [                     Header DW1                            ]
+     DW4 [                     Header DW2                            ]
+     DW5 [                     Header DW3                            ]
+     DW6 [                   Reserved (0x0)                          ]
+     DW7 [                        Time                               ]
+
+When using the 4DW data format, DW0 of the trace buffer entry
+contains selected fields of DW0 of the TLP, together with a
+timestamp.  DW1-DW3 of the trace buffer entry contain DW1-DW3
+directly from the TLP header.
+
+4DW format is like
+::
+    bits [31:30] [ 29:25 ][24][23][22][21][    20:11   ][    10:0    ]
+         |-----|---------|---|---|---|---|-------------|-------------|
+     DW0 [ Fmt ][  Type  ][T9][T8][TH][SO][   Length   ][    Time    ]
+     DW1 [                     Header DW1                            ]
+     DW2 [                     Header DW2                            ]
+     DW3 [                     Header DW3                            ]
-- 
2.8.1

