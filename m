Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52BC257CB46
	for <lists+linux-pci@lfdr.de>; Thu, 21 Jul 2022 15:04:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233977AbiGUNDr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 Jul 2022 09:03:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233893AbiGUNDM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 21 Jul 2022 09:03:12 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EA3753AB;
        Thu, 21 Jul 2022 06:02:59 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4LpXjR4cJBz1M8JR;
        Thu, 21 Jul 2022 21:00:11 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 21 Jul 2022 21:02:56 +0800
From:   <yangyicong@huawei.com>
To:     <gregkh@linuxfoundation.org>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>, <peterz@infradead.org>,
        <corbet@lwn.net>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>
CC:     <helgaas@kernel.org>, <lorenzo.pieralisi@arm.com>,
        <suzuki.poulose@arm.com>, <joro@8bytes.org>,
        <shameerali.kolothum.thodi@huawei.com>, <mingo@redhat.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
        <linux-doc@vger.kernel.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <bagasdotme@gmail.com>
Subject: [PATCH v11 7/8] docs: trace: Add HiSilicon PTT device driver documentation
Date:   Thu, 21 Jul 2022 21:01:15 +0800
Message-ID: <20220721130116.43366-8-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220721130116.43366-1-yangyicong@huawei.com>
References: <20220721130116.43366-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

Document the introduction and usage of HiSilicon PTT device driver as well
as the sysfs attributes description provided by the driver.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 .../ABI/testing/sysfs-devices-hisi_ptt        |  61 ++++
 Documentation/trace/hisi-ptt.rst              | 298 ++++++++++++++++++
 Documentation/trace/index.rst                 |   1 +
 3 files changed, 360 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-hisi_ptt
 create mode 100644 Documentation/trace/hisi-ptt.rst

diff --git a/Documentation/ABI/testing/sysfs-devices-hisi_ptt b/Documentation/ABI/testing/sysfs-devices-hisi_ptt
new file mode 100644
index 000000000000..98622162409c
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-devices-hisi_ptt
@@ -0,0 +1,61 @@
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune
+Date:		July 2022
+KernelVersion:	5.20
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	This directory contains files for tuning the PCIe link
+		parameters(events). Each file is named after the event
+		of the PCIe link.
+
+		See Documentation/trace/hisi-ptt.rst for more information.
+
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_cpl
+Date:		July 2022
+KernelVersion:	5.20
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	(RW) Controls the weight of Tx completion TLPs, which influence
+		the proportion of outbound completion TLPs on the PCIe link.
+		The available tune data is [0, 1, 2]. Writing a negative value
+		will return an error, and out of range values will be converted
+		to 2. The value indicates a probable level of the event.
+
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_np
+Date:		July 2022
+KernelVersion:	5.20
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	(RW) Controls the weight of Tx non-posted TLPs, which influence
+		the proportion of outbound non-posted TLPs on the PCIe link.
+		The available tune data is [0, 1, 2]. Writing a negative value
+		will return an error, and out of range values will be converted
+		to 2. The value indicates a probable level of the event.
+
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/qos_tx_p
+Date:		July 2022
+KernelVersion:	5.20
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	(RW) Controls the weight of Tx posted TLPs, which influence the
+		proportion of outbound posted TLPs on the PCIe link.
+		The available tune data is [0, 1, 2]. Writing a negative value
+		will return an error, and out of range values will be converted
+		to 2. The value indicates a probable level of the event.
+
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/rx_alloc_buf_level
+Date:		July 2022
+KernelVersion:	5.20
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	(RW) Control the allocated buffer watermark for inbound packets.
+		The packets will be stored in the buffer first and then transmitted
+		either when the watermark reached or when timed out.
+		The available tune data is [0, 1, 2]. Writing a negative value
+		will return an error, and out of range values will be converted
+		to 2. The value indicates a probable level of the event.
+
+What:		/sys/devices/hisi_ptt<sicl_id>_<core_id>/tune/tx_alloc_buf_level
+Date:		July 2022
+KernelVersion:	5.20
+Contact:	Yicong Yang <yangyicong@hisilicon.com>
+Description:	(RW) Control the allocated buffer watermark of outbound packets.
+		The packets will be stored in the buffer first and then transmitted
+		either when the watermark reached or when timed out.
+		The available tune data is [0, 1, 2]. Writing a negative value
+		will return an error, and out of range values will be converted
+		to 2. The value indicates a probable level of the event.
diff --git a/Documentation/trace/hisi-ptt.rst b/Documentation/trace/hisi-ptt.rst
new file mode 100644
index 000000000000..4f87d8e21065
--- /dev/null
+++ b/Documentation/trace/hisi-ptt.rst
@@ -0,0 +1,298 @@
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
+tracing the links of the PCIe core.
+::
+
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
+The PTT device driver registers one PMU device for each PTT device.
+The name of each PTT device is composed of 'hisi_ptt' prefix with
+the id of the SICL and the Core where it locates. The Kunpeng 930
+SoC encapsulates multiple CPU dies (SCCL, Super CPU Cluster) and
+IO dies (SICL, Super I/O Cluster), where there's one PCIe Root
+Complex for each SICL.
+::
+
+    /sys/devices/hisi_ptt<sicl_id>_<core_id>
+
+Tune
+====
+
+PTT tune is designed for monitoring and adjusting PCIe link parameters (events).
+Currently we support events in 2 classes. The scope of the events
+covers the PCIe core to which the PTT device belongs.
+
+Each event is presented as a file under $(PTT PMU dir)/tune, and
+a simple open/read/write/close cycle will be used to tune the event.
+::
+
+    $ cd /sys/devices/hisi_ptt<sicl_id>_<core_id>/tune
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
+1. Tx Path QoS Control
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
+2. Tx Path Buffer Control
+-------------------------
+
+Following files are provided to tune the buffer of tx path of the PCIe core.
+
+- rx_alloc_buf_level: watermark of Rx requested
+- tx_alloc_buf_level: watermark of Tx requested
+
+These events influence the watermark of the buffer allocated for each
+type. Rx means the inbound while Tx means outbound. The packets will
+be stored in the buffer first and then transmitted either when the
+watermark reached or when timed out. For a busy direction, you should
+increase the related buffer watermark to avoid frequently posting and
+thus enhance the performance. In most cases just keep the default value.
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
+Link. You can choose to filter the traced headers by either Requester ID,
+or those downstream of a set of Root Ports on the same core of the PTT
+device. It's also supported to trace the headers of certain type and of
+certain direction.
+
+You can use the perf command `perf record` to set the parameters, start
+trace and get the data. It's also supported to decode the trace
+data with `perf report`. The control parameters for trace is inputted
+as event code for each events, which will be further illustrated later.
+An example usage is like
+::
+
+    $ perf record -e hisi_ptt0_2/filter=0x80001,type=1,direction=1,
+      format=1/ -- sleep 5
+
+This will trace the TLP headers downstream root port 0000:00:10.1 (event
+code for event 'filter' is 0x80001) with type of posted TLP requests,
+direction of inbound and traced data format of 8DW.
+
+1. Filter
+---------
+
+The TLP headers to trace can be filtered by the Root Ports or the Requester ID
+of the Endpoint, which are located on the same core of the PTT device. You can
+set the filter by specifying the `filter` parameter which is required to start
+the trace. The parameter value is 20 bit. Bit 19 indicates the filter type.
+1 for Root Port filter and 0 for Requester filter. Bit[15:0] indicates the
+filter value. The value for a Root Port is a mask of the core port id which is
+calculated from its PCI Slot ID as (slotid & 7) * 2. The value for a Requester
+is the Requester ID (Device ID of the PCIe function). Bit[18:16] is currently
+reserved for extension.
+
+For example, if the desired filter is Endpoint function 0000:01:00.1 the filter
+value will be 0x00101. If the desired filter is Root Port 0000:00:10.0 then
+then filter value is calculated as 0x80001.
+
+Note that multiple Root Ports can be specified at one time, but only one
+Endpoint function can be specified in one trace. Specifying both Root Port
+and function at the same time is not supported. Driver maintains a list of
+available filters and will check the invalid inputs.
+
+Currently the available filters are detected in driver's probe. If the supported
+devices are removed/added after probe, you may need to reload the driver to update
+the filters.
+
+2. Type
+-------
+
+You can trace the TLP headers of certain types by specifying the `type`
+parameter, which is required to start the trace. The parameter value is
+8 bit. Current supported types and related values are shown below:
+
+- 8'b00000001: posted requests (P)
+- 8'b00000010: non-posted requests (NP)
+- 8'b00000100: completions (CPL)
+
+You can specify multiple types when tracing inbound TLP headers, but can only
+specify one when tracing outbound TLP headers.
+
+3. Direction
+------------
+
+You can trace the TLP headers from certain direction, which is relative
+to the Root Port or the PCIe core, by specifying the `direction` parameter.
+This is optional and the default parameter is inbound. The parameter value
+is 4 bit. When the desired format is 4DW, directions and related values
+supported are shown below:
+
+- 4'b0000: inbound TLPs (P, NP, CPL)
+- 4'b0001: outbound TLPs (P, NP, CPL)
+- 4'b0010: outbound TLPs (P, NP, CPL) and inbound TLPs (P, NP, CPL B)
+- 4'b0011: outbound TLPs (P, NP, CPL) and inbound TLPs (CPL A)
+
+When the desired format is 8DW, directions and related values supported are
+shown below:
+
+- 4'b0000: reserved
+- 4'b0001: outbound TLPs (P, NP, CPL)
+- 4'b0010: inbound TLPs (P, NP, CPL B)
+- 4'b0011: inbound TLPs (CPL A)
+
+Inbound completions are classified into two types:
+
+- completion A (CPL A): completion of CHI/DMA/Native non-posted requests, except for CPL B
+- completion B (CPL B): completion of DMA remote2local and P2P non-posted requests
+
+4. Format
+--------------
+
+You can change the format of the traced TLP headers by specifying the
+`format` parameter. The default format is 4DW. The parameter value is 4 bit.
+Current supported formats and related values are shown below:
+
+- 4'b0000: 4DW length per TLP header
+- 4'b0001: 8DW length per TLP header
+
+The traced TLP header format is different from the PCIe standard.
+
+When using the 8DW data format, the entire TLP header is logged
+(Header DW0-3 shown below). For example, the TLP header for Memory
+Reads with 64-bit addresses is shown in PCIe r5.0, Figure 2-17;
+the header for Configuration Requests is shown in Figure 2.20, etc.
+
+In addition, 8DW trace buffer entries contain a timestamp and
+possibly a prefix for a PASID TLP prefix (see Figure 6-20, PCIe r5.0).
+Otherwise this field will be all 0.
+
+The bit[31:11] of DW0 is always 0x1fffff, which can be
+used to distinguish the data format. 8DW format is like
+::
+
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
+
+    bits [31:30] [ 29:25 ][24][23][22][21][    20:11   ][    10:0    ]
+         |-----|---------|---|---|---|---|-------------|-------------|
+     DW0 [ Fmt ][  Type  ][T9][T8][TH][SO][   Length   ][    Time    ]
+     DW1 [                     Header DW1                            ]
+     DW2 [                     Header DW2                            ]
+     DW3 [                     Header DW3                            ]
+
+5. Memory Management
+--------------------
+
+The traced TLP headers will be written to the memory allocated
+by the driver. The hardware accepts 4 DMA address with same size,
+and writes the buffer sequentially like below. If DMA addr 3 is
+finished and the trace is still on, it will return to addr 0.
+::
+
+    +->[DMA addr 0]->[DMA addr 1]->[DMA addr 2]->[DMA addr 3]-+
+    +---------------------------------------------------------+
+
+Driver will allocate each DMA buffer of 4MiB. The finished buffer
+will be copied to the perf AUX buffer allocated by the perf core.
+Once the AUX buffer is full while the trace is still on, driver
+will commit the AUX buffer first and then apply for a new one with
+the same size. The size of AUX buffer is default to 16MiB. User can
+adjust the size by specifying the `-m` parameter of the perf command.
+
+6. Decoding
+-----------
+
+You can decode the traced data with `perf report -D` command (currently
+only support to dump the raw trace data). The traced data will be decoded
+according to the format described previously (take 8DW as an example):
+::
+
+    [...perf headers and other information]
+    . ... HISI PTT data: size 4194304 bytes
+    .  00000000: 00 00 00 00                                 Prefix
+    .  00000004: 01 00 00 60                                 Header DW0
+    .  00000008: 0f 1e 00 01                                 Header DW1
+    .  0000000c: 04 00 00 00                                 Header DW2
+    .  00000010: 40 00 81 02                                 Header DW3
+    .  00000014: 33 c0 04 00                                 Time
+    .  00000020: 00 00 00 00                                 Prefix
+    .  00000024: 01 00 00 60                                 Header DW0
+    .  00000028: 0f 1e 00 01                                 Header DW1
+    .  0000002c: 04 00 00 00                                 Header DW2
+    .  00000030: 40 00 81 02                                 Header DW3
+    .  00000034: 02 00 00 00                                 Time
+    .  00000040: 00 00 00 00                                 Prefix
+    .  00000044: 01 00 00 60                                 Header DW0
+    .  00000048: 0f 1e 00 01                                 Header DW1
+    .  0000004c: 04 00 00 00                                 Header DW2
+    .  00000050: 40 00 81 02                                 Header DW3
+    [...]
diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index f9b7bcb5a630..dd423113b7b1 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -32,3 +32,4 @@ Linux Tracing Technologies
    sys-t
    coresight/index
    user_events
+   hisi-ptt
-- 
2.24.0

