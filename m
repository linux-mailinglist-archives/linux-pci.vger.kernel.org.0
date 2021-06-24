Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 319A03B2D20
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbhFXLCk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 07:02:40 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:8299 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232136AbhFXLCj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 07:02:39 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G9cV23GzDz1BRHH;
        Thu, 24 Jun 2021 18:55:06 +0800 (CST)
Received: from dggema757-chm.china.huawei.com (10.1.198.199) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Thu, 24 Jun 2021 19:00:16 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggema757-chm.china.huawei.com (10.1.198.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 24 Jun 2021 19:00:15 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH v7 1/2] docs: perf: Add description for HiSilicon PCIe PMU driver
Date:   Thu, 24 Jun 2021 18:59:43 +0800
Message-ID: <1624532384-43002-2-git-send-email-liuqi115@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1624532384-43002-1-git-send-email-liuqi115@huawei.com>
References: <1624532384-43002-1-git-send-email-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggema757-chm.china.huawei.com (10.1.198.199)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PCIe PMU Root Complex Integrated End Point(RCiEP) device is supported on
HiSilicon HIP09 platform. Document it to provide guidance on how to
use it.

Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Qi Liu <liuqi115@huawei.com>
---
 Documentation/admin-guide/perf/hisi-pcie-pmu.rst | 104 +++++++++++++++++++++++
 1 file changed, 104 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hisi-pcie-pmu.rst

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
new file mode 100644
index 0000000..2084b53
--- /dev/null
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -0,0 +1,104 @@
+================================================
+HiSilicon PCIe Performance Monitoring Unit (PMU)
+================================================
+
+HiSilicon PCIe Performance Monitoring Unit (PMU) is a PCIe Root Complex
+integrated End Point (RCiEP) device. On Hip09, each PCIe Core has a PMU RCiEP
+to monitor multi Root Ports and all Endpoints downstream these Root Ports.
+
+HiSilicon PCIe PMU is supported to collect performance data of PCIe bus, such
+as: bandwidth, latency etc.
+
+
+HiSilicon PCIe PMU driver
+=========================
+
+The PCIe PMU driver registers a perf PMU with the name of its sicl-id and PCIe
+Core id.::
+
+  /sys/bus/event_source/hisi_pcie<sicl>_<core>
+
+PMU driver provides description of available events and filter options in sysfs,
+see /sys/bus/event_source/devices/hisi_pcie<sicl>_<core>.
+
+The "format" directory describes all formats of the config (events) and config1
+(filter options) fields of the perf_event_attr structure. The "events" directory
+describes all documented events shown in perf list.
+
+The "identifier" sysfs file allows users to identify the version of the
+PMU hardware device.
+
+The "bus" sysfs file allows users to get the bus number of Root Ports
+monitored by PMU.
+
+Example usage of perf::
+
+  $# perf list
+  hisi_pcie0_0/bw_rx/ [kernel PMU event]
+  ------------------------------------------
+
+  $# perf stat -e hisi_pcie0_0/bw_rx/ sleep 5
+
+The current driver does not support sampling. So "perf record" is unsupported.
+Also attach to a task is unsupported for PCIe PMU.
+
+Filter options
+--------------
+
+1. Target filter
+PMU could only monitor the performance of traffic downstream target Root Ports
+or downstream target Endpoint. PCIe PMU driver support "port" and "bdf"
+interfaces for users, and these two interfaces aren't supported at the same
+time.
+
+-port
+"port" filter can be used in all PCIe PMU events, target Root Port can be
+selected by configuring the 16-bits-bitmap "port". Multi ports can be selected
+for AP-layer-events, and only one port can be selected for TL/DL-layer-events.
+
+For example, if target Root Port is 0000:00:00.0 (x8 lanes), bit0 of bitmap
+should be set, port=0x1; if target Root Port is 0000:00:04.0 (x4 lanes),
+bit8 is set, port=0x100; if these two Root Ports are both monitored, port=0x101.
+
+Example usage of perf::
+
+  $# perf stat -e hisi_pcie0_0/bw_rx,port=0x1/ sleep 5
+
+-bdf
+
+"bdf" filter can only be used in bandwidth events, target Endpoint is selected
+by configuring BDF to "bdf". Counter only counts the bandwidth of message
+requested by target Endpoint.
+
+For example, "bdf=0x3900" means BDF of target Endpoint is 0000:39:00.0.
+
+Example usage of perf::
+
+  $# perf stat -e hisi_pcie0_0/bw_rx,bdf=0x3900/ sleep 5
+
+2. Trigger filter
+Event statistics start when the first time TLP length is greater/smaller
+than trigger condition. You can set the trigger condition by writing "trig_len",
+and set the trigger mode by writing "trig_mode". This filter can only be used
+in bandwidth events.
+
+For example, "trig_len=4" means trigger condition is 2^4 DW, "trig_mode=0"
+means statistics start when TLP length > trigger condition, "trig_mode=1"
+means start when TLP length < condition.
+
+Example usage of perf::
+
+  $# perf stat -e hisi_pcie0_0/bw_rx,trig_len=0x4,trig_mode=1/ sleep 5
+
+3. Threshold filter
+Counter counts when TLP length within the specified range. You can set the
+threshold by writing "thr_len", and set the threshold mode by writing
+"thr_mode". This filter can only be used in bandwidth events.
+
+For example, "thr_len=4" means threshold is 2^4 DW, "thr_mode=0" means
+counter counts when TLP length >= threshold, and "thr_mode=1" means counts
+when TLP length < threshold.
+
+Example usage of perf::
+
+  $# perf stat -e hisi_pcie0_0/bw_rx,thr_len=0x4,thr_mode=1/ sleep 5
-- 
2.7.4

