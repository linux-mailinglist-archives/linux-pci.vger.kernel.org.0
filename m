Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8616643FA04
	for <lists+linux-pci@lfdr.de>; Fri, 29 Oct 2021 11:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231559AbhJ2JjW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Oct 2021 05:39:22 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:13991 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231493AbhJ2JjV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Oct 2021 05:39:21 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Hgchq5rbjzWlf2;
        Fri, 29 Oct 2021 17:34:51 +0800 (CST)
Received: from kwepemm600003.china.huawei.com (7.193.23.202) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 17:36:49 +0800
Received: from localhost.localdomain (10.67.165.2) by
 kwepemm600003.china.huawei.com (7.193.23.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.15; Fri, 29 Oct 2021 17:36:49 +0800
From:   Qi Liu <liuqi115@huawei.com>
To:     <will@kernel.org>, <mark.rutland@arm.com>, <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linuxarm@huawei.com>,
        <zhangshaokun@hisilicon.com>
Subject: [PATCH v11 1/2] docs: perf: Add description for HiSilicon PCIe PMU driver
Date:   Fri, 29 Oct 2021 17:36:31 +0800
Message-ID: <20211029093632.4350-2-liuqi115@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211029093632.4350-1-liuqi115@huawei.com>
References: <20211029093632.4350-1-liuqi115@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.165.2]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600003.china.huawei.com (7.193.23.202)
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
 .../admin-guide/perf/hisi-pcie-pmu.rst        | 106 ++++++++++++++++++
 1 file changed, 106 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/hisi-pcie-pmu.rst

diff --git a/Documentation/admin-guide/perf/hisi-pcie-pmu.rst b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
new file mode 100644
index 000000000000..294ebbdb22af
--- /dev/null
+++ b/Documentation/admin-guide/perf/hisi-pcie-pmu.rst
@@ -0,0 +1,106 @@
+================================================
+HiSilicon PCIe Performance Monitoring Unit (PMU)
+================================================
+
+On Hip09, HiSilicon PCIe Performance Monitoring Unit (PMU) could monitor
+bandwidth, latency, bus utilization and buffer occupancy data of PCIe.
+
+Each PCIe Core has a PMU to monitor multi Root Ports of this PCIe Core and
+all Endpoints downstream these Root Ports.
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
+  hisi_pcie0_0/rx_mwr_latency/ [kernel PMU event]
+  hisi_pcie0_0/rx_mwr_cnt/ [kernel PMU event]
+  ------------------------------------------
+
+  $# perf stat -e hisi_pcie0_0/rx_mwr_latency/
+  $# perf stat -e hisi_pcie0_0/rx_mwr_cnt/
+  $# perf stat -g -e hisi_pcie0_0/rx_mwr_latency/ -e hisi_pcie0_0/rx_mwr_cnt/
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
+  $# perf stat -e hisi_pcie0_0/rx_mwr_latency,port=0x1/ sleep 5
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
+  $# perf stat -e hisi_pcie0_0/rx_mrd_flux,bdf=0x3900/ sleep 5
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
+  $# perf stat -e hisi_pcie0_0/rx_mrd_flux,trig_len=0x4,trig_mode=1/ sleep 5
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
+  $# perf stat -e hisi_pcie0_0/rx_mrd_flux,thr_len=0x4,thr_mode=1/ sleep 5
-- 
2.33.0

