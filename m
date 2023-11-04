Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDB587E0FB9
	for <lists+linux-pci@lfdr.de>; Sat,  4 Nov 2023 14:54:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbjKDNcf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Nov 2023 09:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKDNce (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Nov 2023 09:32:34 -0400
Received: from out30-112.freemail.mail.aliyun.com (out30-112.freemail.mail.aliyun.com [115.124.30.112])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DABBD42;
        Sat,  4 Nov 2023 06:32:30 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VvcM-Nx_1699104745;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VvcM-Nx_1699104745)
          by smtp.aliyun-inc.com;
          Sat, 04 Nov 2023 21:32:25 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     kaishen@linux.alibaba.com, helgaas@kernel.org,
        yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     chengyou@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, xueshuai@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
Subject: [PATCH v10 1/5] docs: perf: Add description for Synopsys DesignWare PCIe PMU driver
Date:   Sat,  4 Nov 2023 21:32:12 +0800
Message-Id: <20231104133216.42056-2-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231104133216.42056-1-xueshuai@linux.alibaba.com>
References: <20231104133216.42056-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Alibaba's T-Head Yitan 710 SoC includes Synopsys' DesignWare Core PCIe
controller which implements PMU for performance and functional debugging to
facilitate system maintenance.

Document it to provide guidance on how to use it.

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
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

