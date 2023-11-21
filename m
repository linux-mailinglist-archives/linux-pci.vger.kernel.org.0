Return-Path: <linux-pci+bounces-8-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BE27F231F
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 02:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 934BC1C20E34
	for <lists+linux-pci@lfdr.de>; Tue, 21 Nov 2023 01:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD59F6FDA;
	Tue, 21 Nov 2023 01:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-99.freemail.mail.aliyun.com (out30-99.freemail.mail.aliyun.com [115.124.30.99])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78168BC;
	Mon, 20 Nov 2023 17:34:12 -0800 (PST)
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=17;SR=0;TI=SMTPD_---0VwqXEgl_1700530449;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VwqXEgl_1700530449)
          by smtp.aliyun-inc.com;
          Tue, 21 Nov 2023 09:34:10 +0800
From: Shuai Xue <xueshuai@linux.alibaba.com>
To: ilkka@os.amperecomputing.com,
	kaishen@linux.alibaba.com,
	helgaas@kernel.org,
	yangyicong@huawei.com,
	will@kernel.org,
	Jonathan.Cameron@huawei.com,
	baolin.wang@linux.alibaba.com,
	robin.murphy@arm.com
Cc: chengyou@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	rdunlap@infradead.org,
	mark.rutland@arm.com,
	zhuo.song@linux.alibaba.com,
	xueshuai@linux.alibaba.com,
	renyu.zj@linux.alibaba.com
Subject: [PATCH v11 1/5] docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
Date: Tue, 21 Nov 2023 09:33:56 +0800
Message-Id: <20231121013400.18367-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231121013400.18367-1-xueshuai@linux.alibaba.com>
References: <20231121013400.18367-1-xueshuai@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alibaba's T-Head Yitan 710 SoC includes Synopsys' DesignWare Core PCIe
controller which implements PMU for performance and functional debugging to
facilitate system maintenance.

Document it to provide guidance on how to use it.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 .../admin-guide/perf/dwc_pcie_pmu.rst         | 94 +++++++++++++++++++
 Documentation/admin-guide/perf/index.rst      |  1 +
 2 files changed, 95 insertions(+)
 create mode 100644 Documentation/admin-guide/perf/dwc_pcie_pmu.rst

diff --git a/Documentation/admin-guide/perf/dwc_pcie_pmu.rst b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
new file mode 100644
index 000000000000..d47cd229d710
--- /dev/null
+++ b/Documentation/admin-guide/perf/dwc_pcie_pmu.rst
@@ -0,0 +1,94 @@
+======================================================================
+Synopsys DesignWare Cores (DWC) PCIe Performance Monitoring Unit (PMU)
+======================================================================
+
+DesignWare Cores (DWC) PCIe PMU
+===============================
+
+The PMU is a PCIe configuration space register block provided by each PCIe Root
+Port in a Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
+injection, and Statistics).
+
+As the name indicates, the RAS DES capability supports system level
+debugging, AER error injection, and collection of statistics. To facilitate
+collection of statistics, Synopsys DesignWare Cores PCIe controller
+provides the following two features:
+
+- one 64-bit counter for Time Based Analysis (RX/TX data throughput and
+  time spent in each low-power LTSSM state) and
+- one 32-bit counter for Event Counting (error and non-error events for
+  a specified lane)
+
+Note: There is no interrupt for counter overflow.
+
+Time Based Analysis
+-------------------
+
+Using this feature you can obtain information regarding RX/TX data
+throughput and time spent in each low-power LTSSM state by the controller.
+The PMU measures data in two categories:
+
+- Group#0: Percentage of time the controller stays in LTSSM states.
+- Group#1: Amount of data processed (Units of 16 bytes).
+
+Lane Event counters
+-------------------
+
+Using this feature you can obtain Error and Non-Error information in
+specific lane by the controller. The PMU event is selected by all of:
+
+- Group i
+- Event j within the Group i
+- Lane k
+
+Some of the events only exist for specific configurations.
+
+DesignWare Cores (DWC) PCIe PMU Driver
+=======================================
+
+This driver adds PMU devices for each PCIe Root Port named based on the BDF of
+the Root Port. For example,
+
+    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
+
+the PMU device name for this Root Port is dwc_rootport_3018.
+
+The DWC PCIe PMU driver registers a perf PMU driver, which provides
+description of available events and configuration options in sysfs, see
+/sys/bus/event_source/devices/dwc_rootport_{bdf}.
+
+The "format" directory describes format of the config fields of the
+perf_event_attr structure. The "events" directory provides configuration
+templates for all documented events.  For example,
+"Rx_PCIe_TLP_Data_Payload" is an equivalent of "eventid=0x22,type=0x1".
+
+The "perf list" command shall list the available events from sysfs, e.g.::
+
+    $# perf list | grep dwc_rootport
+    <...>
+    dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/        [Kernel PMU event]
+    <...>
+    dwc_rootport_3018/rx_memory_read,lane=?/               [Kernel PMU event]
+
+Time Based Analysis Event Usage
+-------------------------------
+
+Example usage of counting PCIe RX TLP data payload (Units of bytes)::
+
+    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
+
+The average RX/TX bandwidth can be calculated using the following formula:
+
+    PCIe RX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
+    PCIe TX Bandwidth = Tx_PCIe_TLP_Data_Payload / Measure_Time_Window
+
+Lane Event Usage
+-------------------------------
+
+Each lane has the same event set and to avoid generating a list of hundreds
+of events, the user need to specify the lane ID explicitly, e.g.::
+
+    $# perf stat -a -e dwc_rootport_3018/rx_memory_read,lane=4/
+
+The driver does not support sampling, therefore "perf record" will not
+work. Per-task (without "-a") perf sessions are not supported.
diff --git a/Documentation/admin-guide/perf/index.rst b/Documentation/admin-guide/perf/index.rst
index f60be04e4e33..6bc7739fddb5 100644
--- a/Documentation/admin-guide/perf/index.rst
+++ b/Documentation/admin-guide/perf/index.rst
@@ -19,6 +19,7 @@ Performance monitor support
    arm_dsu_pmu
    thunderx2-pmu
    alibaba_pmu
+   dwc_pcie_pmu
    nvidia-pmu
    meson-ddr-pmu
    cxl
-- 
2.39.3


