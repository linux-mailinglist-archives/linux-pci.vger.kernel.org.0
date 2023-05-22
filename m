Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAF070B3EE
	for <lists+linux-pci@lfdr.de>; Mon, 22 May 2023 05:55:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231395AbjEVDyr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 May 2023 23:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjEVDyo (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 May 2023 23:54:44 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64184BE;
        Sun, 21 May 2023 20:54:41 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R451e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0Vj6oJIJ_1684727677;
Received: from localhost.localdomain(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vj6oJIJ_1684727677)
          by smtp.aliyun-inc.com;
          Mon, 22 May 2023 11:54:38 +0800
From:   Shuai Xue <xueshuai@linux.alibaba.com>
To:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        xueshuai@linux.alibaba.com
Subject: [PATCH v5 3/4] drivers/perf: add DesignWare PCIe PMU driver
Date:   Mon, 22 May 2023 11:54:27 +0800
Message-Id: <20230522035428.69441-4-xueshuai@linux.alibaba.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
Core controller IP which provides statistics feature. The PMU is not a PCIe
Root Complex integrated End Point(RCiEP) device but only register counters
provided by each PCIe Root Port.

To facilitate collection of statistics the controller provides the
following two features for each Root Port:

- Time Based Analysis (RX/TX data throughput and time spent in each
  low-power LTSSM state)
- Event counters (Error and Non-Error for lanes)

Note, only one counter for each type and does not overflow interrupt.

This driver adds PMU devices for each PCIe Root Port. And the PMU device is
named based the BDF of Root Port. For example,

    30:03.0 PCI bridge: Device 1ded:8000 (rev 01)

the PMU device name for this Root Port is dwc_rootport_3018.

Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::

    $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/

average RX bandwidth can be calculated like this:

    PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window

Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202305170639.XU3djFZX-lkp@intel.com/
---
 drivers/perf/Kconfig        |   7 +
 drivers/perf/Makefile       |   1 +
 drivers/perf/dwc_pcie_pmu.c | 701 ++++++++++++++++++++++++++++++++++++
 3 files changed, 709 insertions(+)
 create mode 100644 drivers/perf/dwc_pcie_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 711f82400086..6ff3921d7a62 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -209,6 +209,13 @@ config MARVELL_CN10K_DDR_PMU
 	  Enable perf support for Marvell DDR Performance monitoring
 	  event on CN10K platform.
 
+config DWC_PCIE_PMU
+	tristate "Enable Synopsys DesignWare PCIe PMU Support"
+	depends on (ARM64 && PCI)
+	help
+	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
+	  monitoring event on Yitian 710 platform.
+
 source "drivers/perf/arm_cspmu/Kconfig"
 
 source "drivers/perf/amlogic/Kconfig"
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index dabc859540ce..13a6d1b286da 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -22,5 +22,6 @@ obj-$(CONFIG_MARVELL_CN10K_TAD_PMU) += marvell_cn10k_tad_pmu.o
 obj-$(CONFIG_MARVELL_CN10K_DDR_PMU) += marvell_cn10k_ddr_pmu.o
 obj-$(CONFIG_APPLE_M1_CPU_PMU) += apple_m1_cpu_pmu.o
 obj-$(CONFIG_ALIBABA_UNCORE_DRW_PMU) += alibaba_uncore_drw_pmu.o
+obj-$(CONFIG_DWC_PCIE_PMU) += dwc_pcie_pmu.o
 obj-$(CONFIG_ARM_CORESIGHT_PMU_ARCH_SYSTEM_PMU) += arm_cspmu/
 obj-$(CONFIG_MESON_DDR_PMU) += amlogic/
diff --git a/drivers/perf/dwc_pcie_pmu.c b/drivers/perf/dwc_pcie_pmu.c
new file mode 100644
index 000000000000..e4e85575ea7d
--- /dev/null
+++ b/drivers/perf/dwc_pcie_pmu.c
@@ -0,0 +1,701 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Synopsys DesignWare PCIe PMU driver
+ *
+ * Copyright (C) 2021-2023 Alibaba Inc.
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/perf_event.h>
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+#include <linux/smp.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#define DWC_PCIE_VSEC_RAS_DES_ID		0x02
+
+#define DWC_PCIE_EVENT_CNT_CTL			0x8
+
+/*
+ * Event Counter Data Select includes two parts:
+ * - 27-24: Group number(4-bit: 0..0x7)
+ * - 23-16: Event number(8-bit: 0..0x13) within the Group
+ *
+ * Put them togother as TRM used.
+ */
+#define DWC_PCIE_CNT_EVENT_SEL			GENMASK(27, 16)
+#define DWC_PCIE_CNT_LANE_SEL			GENMASK(11, 8)
+#define DWC_PCIE_CNT_STATUS			BIT(7)
+#define DWC_PCIE_CNT_ENABLE			GENMASK(4, 2)
+#define DWC_PCIE_PER_EVENT_OFF			0x1
+#define DWC_PCIE_PER_EVENT_ON			0x3
+#define DWC_PCIE_EVENT_CLEAR			GENMASK(1, 0)
+#define DWC_PCIE_EVENT_PER_CLEAR		0x1
+
+#define DWC_PCIE_EVENT_CNT_DATA			0xC
+
+#define DWC_PCIE_TIME_BASED_ANAL_CTL		0x10
+#define DWC_PCIE_TIME_BASED_REPORT_SEL		GENMASK(31, 24)
+#define DWC_PCIE_TIME_BASED_DURATION_SEL	GENMASK(15, 8)
+#define DWC_PCIE_DURATION_MANUAL_CTL		0x0
+#define DWC_PCIE_DURATION_1MS			0x1
+#define DWC_PCIE_DURATION_10MS			0x2
+#define DWC_PCIE_DURATION_100MS			0x3
+#define DWC_PCIE_DURATION_1S			0x4
+#define DWC_PCIE_DURATION_2S			0x5
+#define DWC_PCIE_DURATION_4S			0x6
+#define DWC_PCIE_DURATION_4US			0xFF
+#define DWC_PCIE_TIME_BASED_TIMER_START		BIT(0)
+#define DWC_PCIE_TIME_BASED_CNT_ENABLE		0x1
+
+#define DWC_PCIE_TIME_BASED_ANAL_DATA_REG_LOW	0x14
+#define DWC_PCIE_TIME_BASED_ANAL_DATA_REG_HIGH	0x18
+
+/* Event attributes */
+#define DWC_PCIE_CONFIG_EVENTID			GENMASK(15, 0)
+#define DWC_PCIE_CONFIG_TYPE			GENMASK(19, 16)
+#define DWC_PCIE_CONFIG_LANE			GENMASK(27, 20)
+
+#define DWC_PCIE_EVENT_ID(event)	FIELD_GET(DWC_PCIE_CONFIG_EVENTID, (event)->attr.config)
+#define DWC_PCIE_EVENT_TYPE(event)	FIELD_GET(DWC_PCIE_CONFIG_TYPE, (event)->attr.config)
+#define DWC_PCIE_EVENT_LANE(event)	FIELD_GET(DWC_PCIE_CONFIG_LANE, (event)->attr.config)
+
+enum dwc_pcie_event_type {
+	DWC_PCIE_TYPE_INVALID,
+	DWC_PCIE_TIME_BASE_EVENT,
+	DWC_PCIE_LANE_EVENT,
+};
+
+#define DWC_PCIE_LANE_EVENT_MAX_PERIOD		GENMASK_ULL(31, 0)
+#define DWC_PCIE_TIME_BASED_EVENT_MAX_PERIOD	GENMASK_ULL(63, 0)
+
+
+struct dwc_pcie_pmu {
+	struct pci_dev		*pdev;		/* Root Port device */
+	u16			ras_des;	/* RAS DES capability offset */
+	u32			nr_lanes;
+
+	struct list_head	pmu_node;
+	struct hlist_node	cpuhp_node;
+	struct pmu		pmu;
+	struct perf_event	*event;
+	int			oncpu;
+};
+
+struct dwc_pcie_pmu_priv {
+	struct device *dev;
+	struct list_head pmu_nodes;
+};
+
+#define to_dwc_pcie_pmu(p) (container_of(p, struct dwc_pcie_pmu, pmu))
+
+static struct platform_device *dwc_pcie_pmu_dev;
+static int dwc_pcie_pmu_hp_state;
+
+static ssize_t cpumask_show(struct device *dev,
+					 struct device_attribute *attr,
+					 char *buf)
+{
+	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(dev_get_drvdata(dev));
+
+	return cpumap_print_to_pagebuf(true, buf, cpumask_of(pcie_pmu->oncpu));
+}
+static DEVICE_ATTR_RO(cpumask);
+
+static struct attribute *dwc_pcie_pmu_cpumask_attrs[] = {
+	&dev_attr_cpumask.attr,
+	NULL
+};
+
+static struct attribute_group dwc_pcie_cpumask_attr_group = {
+	.attrs = dwc_pcie_pmu_cpumask_attrs,
+};
+
+struct dwc_pcie_format_attr {
+	struct device_attribute attr;
+	u64 field;
+	int config;
+};
+
+static ssize_t dwc_pcie_pmu_format_show(struct device *dev,
+					struct device_attribute *attr,
+					char *buf)
+{
+	struct dwc_pcie_format_attr *fmt = container_of(attr, typeof(*fmt), attr);
+	int lo = __ffs(fmt->field), hi = __fls(fmt->field);
+
+	return sysfs_emit(buf, "config:%d-%d\n", lo, hi);
+}
+
+#define _dwc_pcie_format_attr(_name, _cfg, _fld)				\
+	(&((struct dwc_pcie_format_attr[]) {{					\
+		.attr = __ATTR(_name, 0444, dwc_pcie_pmu_format_show, NULL),	\
+		.config = _cfg,							\
+		.field = _fld,							\
+	}})[0].attr.attr)
+
+#define dwc_pcie_format_attr(_name, _fld)	_dwc_pcie_format_attr(_name, 0, _fld)
+
+static struct attribute *dwc_pcie_format_attrs[] = {
+	dwc_pcie_format_attr(type, DWC_PCIE_CONFIG_TYPE),
+	dwc_pcie_format_attr(eventid, DWC_PCIE_CONFIG_EVENTID),
+	dwc_pcie_format_attr(lane, DWC_PCIE_CONFIG_LANE),
+	NULL,
+};
+
+static struct attribute_group dwc_pcie_format_attrs_group = {
+	.name = "format",
+	.attrs = dwc_pcie_format_attrs,
+};
+
+struct dwc_pcie_event_attr {
+	struct device_attribute attr;
+	enum dwc_pcie_event_type type;
+	u16 eventid;
+	u8 lane;
+};
+
+static ssize_t dwc_pcie_event_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct dwc_pcie_event_attr *eattr;
+
+	eattr = container_of(attr, typeof(*eattr), attr);
+
+	if (eattr->type == DWC_PCIE_LANE_EVENT)
+		return sysfs_emit(buf, "eventid=0x%x,type=0x%x,lane=?\n",
+				  eattr->eventid, eattr->type);
+
+	return sysfs_emit(buf, "eventid=0x%x,type=0x%x\n", eattr->eventid,
+		       eattr->type);
+}
+
+#define DWC_PCIE_EVENT_ATTR(_name, _type, _eventid, _lane)		\
+	(&((struct dwc_pcie_event_attr[]) {{				\
+		.attr = __ATTR(_name, 0444, dwc_pcie_event_show, NULL),	\
+		.type = _type,						\
+		.eventid = _eventid,					\
+		.lane = _lane,						\
+	}})[0].attr.attr)
+
+#define DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(_name, _eventid)		\
+	DWC_PCIE_EVENT_ATTR(_name, DWC_PCIE_TIME_BASE_EVENT, _eventid, 0)
+#define DWC_PCIE_PMU_LANE_EVENT_ATTR(_name, _eventid)			\
+	DWC_PCIE_EVENT_ATTR(_name, DWC_PCIE_LANE_EVENT, _eventid, 0)
+
+static struct attribute *dwc_pcie_pmu_time_event_attrs[] = {
+	/* Group #0 */
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(one_cycle, 0x00),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(TX_L0S, 0x01),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(RX_L0S, 0x02),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L0, 0x03),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1, 0x04),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_1, 0x05),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_2, 0x06),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(CFG_RCVRY, 0x07),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(TX_RX_L0S, 0x08),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(L1_AUX, 0x09),
+
+	/* Group #1 */
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Tx_PCIe_TLP_Data_Payload, 0x20),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Rx_PCIe_TLP_Data_Payload, 0x21),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Tx_CCIX_TLP_Data_Payload, 0x22),
+	DWC_PCIE_PMU_TIME_BASE_EVENT_ATTR(Rx_CCIX_TLP_Data_Payload, 0x23),
+
+	/*
+	 * Leave it to the user to specify the lane ID to avoid generating
+	 * a list of hundreds of events.
+	 */
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_ack_dllp, 0x600),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_update_fc_dllp, 0x601),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_ack_dllp, 0x602),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_update_fc_dllp, 0x603),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_nulified_tlp, 0x604),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_nulified_tlp, 0x605),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_duplicate_tl, 0x606),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_write, 0x700),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_memory_read, 0x701),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_configuration_write, 0x702),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_configuration_read, 0x703),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_io_write, 0x704),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_io_read, 0x705),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_completion_without_data, 0x706),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_completion_with_data, 0x707),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_message_tlp, 0x708),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_atomic, 0x709),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_tlp_with_prefix, 0x70A),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_memory_write, 0x70B),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_memory_read, 0x70C),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_io_write, 0x70F),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_io_read, 0x710),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_completion_without_data, 0x711),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_completion_with_data, 0x712),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_message_tlp, 0x713),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_atomic, 0x714),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_tlp_with_prefix, 0x715),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(tx_ccix_tlp, 0x716),
+	DWC_PCIE_PMU_LANE_EVENT_ATTR(rx_ccix_tlp, 0x717),
+
+	NULL
+};
+
+static const struct attribute_group dwc_pcie_event_attrs_group = {
+	.name = "events",
+	.attrs = dwc_pcie_pmu_time_event_attrs,
+};
+
+static const struct attribute_group *dwc_pcie_attr_groups[] = {
+	&dwc_pcie_event_attrs_group,
+	&dwc_pcie_format_attrs_group,
+	&dwc_pcie_cpumask_attr_group,
+	NULL
+};
+
+static void dwc_pcie_pmu_lane_event_enable(struct dwc_pcie_pmu *pcie_pmu,
+					   bool enable)
+{
+	struct pci_dev *pdev = pcie_pmu->pdev;
+	u16 ras_des = pcie_pmu->ras_des;
+	u32 val;
+
+	pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, &val);
+
+	/* Clear DWC_PCIE_CNT_ENABLE field first */
+	val &= ~DWC_PCIE_CNT_ENABLE;
+	if (enable)
+		val |= FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_ON);
+	else
+		val |= FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_OFF);
+
+	pci_write_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL, val);
+}
+
+static void dwc_pcie_pmu_time_based_event_enable(struct dwc_pcie_pmu *pcie_pmu,
+					  bool enable)
+{
+	struct pci_dev *pdev = pcie_pmu->pdev;
+	u16 ras_des = pcie_pmu->ras_des;
+	u32 val;
+
+	pci_read_config_dword(pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL,
+			      &val);
+
+	if (enable)
+		val |= DWC_PCIE_TIME_BASED_CNT_ENABLE;
+	else
+		val &= ~DWC_PCIE_TIME_BASED_CNT_ENABLE;
+
+	pci_write_config_dword(pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL,
+			       val);
+}
+
+static u64 dwc_pcie_pmu_read_lane_event_counter(struct dwc_pcie_pmu *pcie_pmu)
+{
+	struct pci_dev *pdev = pcie_pmu->pdev;
+	u16 ras_des = pcie_pmu->ras_des;
+	u32 val;
+
+	pci_read_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_DATA, &val);
+
+	return val;
+}
+
+static u64 dwc_pcie_pmu_read_time_based_counter(struct dwc_pcie_pmu *pcie_pmu)
+{
+	struct pci_dev *pdev = pcie_pmu->pdev;
+	u16 ras_des = pcie_pmu->ras_des;
+	u64 count;
+	u32 val;
+
+	pci_read_config_dword(
+		pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_HIGH, &val);
+	count = val;
+	count <<= 32;
+
+	pci_read_config_dword(
+		pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_DATA_REG_LOW, &val);
+
+	count += val;
+
+	return count;
+}
+
+static void dwc_pcie_pmu_event_update(struct perf_event *event)
+{
+	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
+	u64 delta, prev, now;
+
+	do {
+		prev = local64_read(&hwc->prev_count);
+
+		if (type == DWC_PCIE_LANE_EVENT)
+			now = dwc_pcie_pmu_read_lane_event_counter(pcie_pmu);
+		else if (type == DWC_PCIE_TIME_BASE_EVENT)
+			now = dwc_pcie_pmu_read_time_based_counter(pcie_pmu);
+
+	} while (local64_cmpxchg(&hwc->prev_count, prev, now) != prev);
+
+	if (type == DWC_PCIE_LANE_EVENT)
+		delta = (now - prev) & DWC_PCIE_LANE_EVENT_MAX_PERIOD;
+	else if (type == DWC_PCIE_TIME_BASE_EVENT)
+		delta = (now - prev) & DWC_PCIE_TIME_BASED_EVENT_MAX_PERIOD;
+
+	local64_add(delta, &event->count);
+}
+
+static int dwc_pcie_pmu_event_init(struct perf_event *event)
+{
+	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
+	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
+	struct perf_event *sibling;
+	u32 lane;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/* We don't support sampling */
+	if (is_sampling_event(event))
+		return -EINVAL;
+
+	/* We cannot support task bound events */
+	if (event->cpu < 0 || event->attach_state & PERF_ATTACH_TASK)
+		return -EINVAL;
+
+	if (event->group_leader != event &&
+	    !is_software_event(event->group_leader))
+		return -EINVAL;
+
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (sibling->pmu != event->pmu && !is_software_event(sibling))
+			return -EINVAL;
+	}
+
+	if (type == DWC_PCIE_LANE_EVENT) {
+		lane = DWC_PCIE_EVENT_LANE(event);
+		if (lane < 0 || lane >= pcie_pmu->nr_lanes)
+			return -EINVAL;
+	}
+
+	event->cpu = pcie_pmu->oncpu;
+
+	return 0;
+}
+
+static void dwc_pcie_pmu_set_period(struct hw_perf_event *hwc)
+{
+	local64_set(&hwc->prev_count, 0);
+}
+
+static void dwc_pcie_pmu_event_start(struct perf_event *event, int flags)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
+	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
+
+	hwc->state = 0;
+	dwc_pcie_pmu_set_period(hwc);
+
+	if (type == DWC_PCIE_LANE_EVENT)
+		dwc_pcie_pmu_lane_event_enable(pcie_pmu, true);
+	else if (type == DWC_PCIE_TIME_BASE_EVENT)
+		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, true);
+}
+
+static void dwc_pcie_pmu_event_stop(struct perf_event *event, int flags)
+{
+	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
+	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
+	struct hw_perf_event *hwc = &event->hw;
+
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
+
+	if (type == DWC_PCIE_LANE_EVENT)
+		dwc_pcie_pmu_lane_event_enable(pcie_pmu, false);
+	else if (type == DWC_PCIE_TIME_BASE_EVENT)
+		dwc_pcie_pmu_time_based_event_enable(pcie_pmu, false);
+
+	dwc_pcie_pmu_event_update(event);
+	hwc->state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int dwc_pcie_pmu_event_add(struct perf_event *event, int flags)
+{
+	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
+	struct pci_dev *pdev = pcie_pmu->pdev;
+	struct hw_perf_event *hwc = &event->hw;
+	enum dwc_pcie_event_type type = DWC_PCIE_EVENT_TYPE(event);
+	int event_id = DWC_PCIE_EVENT_ID(event);
+	int lane = DWC_PCIE_EVENT_LANE(event);
+	u16 ras_des = pcie_pmu->ras_des;
+	u32 ctrl;
+
+	/* Only one counter and it is in use */
+	if (pcie_pmu->event)
+		return -ENOSPC;
+
+	pcie_pmu->event = event;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	if (type == DWC_PCIE_LANE_EVENT) {
+		/* EVENT_COUNTER_DATA_REG needs clear manually */
+		ctrl = FIELD_PREP(DWC_PCIE_CNT_EVENT_SEL, event_id) |
+			FIELD_PREP(DWC_PCIE_CNT_LANE_SEL, lane) |
+			FIELD_PREP(DWC_PCIE_CNT_ENABLE, DWC_PCIE_PER_EVENT_OFF) |
+			FIELD_PREP(DWC_PCIE_EVENT_CLEAR, DWC_PCIE_EVENT_PER_CLEAR);
+		pci_write_config_dword(pdev, ras_des + DWC_PCIE_EVENT_CNT_CTL,
+				       ctrl);
+	} else if (type == DWC_PCIE_TIME_BASE_EVENT) {
+		/*
+		 * TIME_BASED_ANAL_DATA_REG is a 64 bit register, we can safely
+		 * use it with any manually controlled duration. And it is
+		 * cleared when next measurement starts.
+		 */
+		ctrl = FIELD_PREP(DWC_PCIE_TIME_BASED_REPORT_SEL, event_id) |
+			FIELD_PREP(DWC_PCIE_TIME_BASED_DURATION_SEL,
+				   DWC_PCIE_DURATION_MANUAL_CTL) |
+			DWC_PCIE_TIME_BASED_CNT_ENABLE;
+		pci_write_config_dword(
+			pdev, ras_des + DWC_PCIE_TIME_BASED_ANAL_CTL, ctrl);
+	}
+
+	if (flags & PERF_EF_START)
+		dwc_pcie_pmu_event_start(event, PERF_EF_RELOAD);
+
+	perf_event_update_userpage(event);
+
+	return 0;
+}
+
+static void dwc_pcie_pmu_event_del(struct perf_event *event, int flags)
+{
+	struct dwc_pcie_pmu *pcie_pmu = to_dwc_pcie_pmu(event->pmu);
+
+	dwc_pcie_pmu_event_stop(event, flags | PERF_EF_UPDATE);
+	perf_event_update_userpage(event);
+	pcie_pmu->event = NULL;
+}
+
+static int __dwc_pcie_pmu_probe(struct dwc_pcie_pmu_priv *priv)
+{
+	struct pci_dev *pdev = NULL;
+	struct dwc_pcie_pmu *pcie_pmu;
+	char *name;
+	u32 bdf;
+	int ret;
+
+	INIT_LIST_HEAD(&priv->pmu_nodes);
+
+	/* Match the rootport with VSEC_RAS_DES_ID, and register a PMU for it */
+	for_each_pci_dev(pdev) {
+		u16 vsec;
+		u32 val;
+
+		if (!(pci_is_pcie(pdev) &&
+		      pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
+			continue;
+
+		vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
+						DWC_PCIE_VSEC_RAS_DES_ID);
+		if (!vsec)
+			continue;
+
+		pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
+		if (PCI_VNDR_HEADER_REV(val) != 0x04 ||
+		    PCI_VNDR_HEADER_LEN(val) != 0x100)
+			continue;
+		pci_dbg(pdev,
+			"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
+
+		bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
+		name = devm_kasprintf(priv->dev, GFP_KERNEL, "dwc_rootport_%x",
+				      bdf);
+		if (!name)
+			return -ENOMEM;
+
+		/* All checks passed, go go go */
+		pcie_pmu = devm_kzalloc(&pdev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
+		if (!pcie_pmu) {
+			pci_dev_put(pdev);
+			return -ENOMEM;
+		}
+
+		pcie_pmu->pdev = pdev;
+		pcie_pmu->ras_des = vsec;
+		pcie_pmu->nr_lanes = pcie_get_width_cap(pdev);
+		pcie_pmu->pmu = (struct pmu){
+			.module		= THIS_MODULE,
+			.attr_groups	= dwc_pcie_attr_groups,
+			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+			.task_ctx_nr	= perf_invalid_context,
+			.event_init	= dwc_pcie_pmu_event_init,
+			.add		= dwc_pcie_pmu_event_add,
+			.del		= dwc_pcie_pmu_event_del,
+			.start		= dwc_pcie_pmu_event_start,
+			.stop		= dwc_pcie_pmu_event_stop,
+			.read		= dwc_pcie_pmu_event_update,
+		};
+
+		/* Add this instance to the list used by the offline callback */
+		ret = cpuhp_state_add_instance(dwc_pcie_pmu_hp_state,
+					       &pcie_pmu->cpuhp_node);
+		if (ret) {
+			pci_err(pcie_pmu->pdev,
+				"Error %d registering hotplug @%x\n", ret, bdf);
+			return ret;
+		}
+		ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
+		if (ret) {
+			pci_err(pcie_pmu->pdev,
+				"Error %d registering PMU @%x\n", ret, bdf);
+			cpuhp_state_remove_instance_nocalls(
+				dwc_pcie_pmu_hp_state, &pcie_pmu->cpuhp_node);
+			return ret;
+		}
+
+		/* Add registered PMUs and unregister them when this driver remove */
+		list_add(&pcie_pmu->pmu_node, &priv->pmu_nodes);
+	}
+
+	return 0;
+}
+
+static int dwc_pcie_pmu_remove(struct platform_device *pdev)
+{
+	struct dwc_pcie_pmu_priv *priv = platform_get_drvdata(pdev);
+	struct dwc_pcie_pmu *pcie_pmu;
+
+	list_for_each_entry(pcie_pmu, &priv->pmu_nodes, pmu_node) {
+		cpuhp_state_remove_instance(dwc_pcie_pmu_hp_state,
+					    &pcie_pmu->cpuhp_node);
+		perf_pmu_unregister(&pcie_pmu->pmu);
+	}
+
+	return 0;
+}
+
+static int dwc_pcie_pmu_probe(struct platform_device *pdev)
+{
+	struct dwc_pcie_pmu_priv *priv;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+	platform_set_drvdata(pdev, priv);
+
+	/* If one PMU registration fails, remove all. */
+	if (__dwc_pcie_pmu_probe(priv))
+		dwc_pcie_pmu_remove(pdev);
+
+	return 0;
+}
+
+static void dwc_pcie_pmu_migrate(struct dwc_pcie_pmu *pcie_pmu, unsigned int cpu)
+{
+	/* This PMU does NOT support interrupt, just migrate context. */
+	perf_pmu_migrate_context(&pcie_pmu->pmu, pcie_pmu->oncpu, cpu);
+	pcie_pmu->oncpu = cpu;
+}
+
+static int dwc_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
+{
+	struct dwc_pcie_pmu *pcie_pmu;
+	struct pci_dev *pdev;
+	int node;
+
+	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
+	pdev = pcie_pmu->pdev;
+	node = dev_to_node(&pdev->dev);
+
+	if (node != NUMA_NO_NODE && cpu_to_node(pcie_pmu->oncpu) != node &&
+	    cpu_to_node(cpu) == node)
+		dwc_pcie_pmu_migrate(pcie_pmu, cpu);
+
+	return 0;
+}
+
+static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
+{
+	struct dwc_pcie_pmu *pcie_pmu;
+	struct pci_dev *pdev;
+	int node;
+	cpumask_t mask;
+	unsigned int target;
+
+	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
+	if (cpu != pcie_pmu->oncpu)
+		return 0;
+
+	pdev = pcie_pmu->pdev;
+	node = dev_to_node(&pdev->dev);
+	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
+	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
+		target = cpumask_any(&mask);
+	else
+		target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target < nr_cpu_ids)
+		dwc_pcie_pmu_migrate(pcie_pmu, target);
+
+	return 0;
+}
+
+static struct platform_driver dwc_pcie_pmu_driver = {
+	.probe = dwc_pcie_pmu_probe,
+	.remove = dwc_pcie_pmu_remove,
+	.driver = {.name = "dwc_pcie_pmu",},
+};
+
+static int __init dwc_pcie_pmu_init(void)
+{
+	int ret;
+
+	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      "perf/dwc_pcie_pmu:online",
+				      dwc_pcie_pmu_online_cpu,
+				      dwc_pcie_pmu_offline_cpu);
+	if (ret < 0)
+		return ret;
+
+	dwc_pcie_pmu_hp_state = ret;
+
+	ret = platform_driver_register(&dwc_pcie_pmu_driver);
+	if (ret) {
+		cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
+		return ret;
+	}
+
+	dwc_pcie_pmu_dev = platform_device_register_simple(
+				"dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
+	if (IS_ERR(dwc_pcie_pmu_dev)) {
+		platform_driver_unregister(&dwc_pcie_pmu_driver);
+		return PTR_ERR(dwc_pcie_pmu_dev);
+	}
+
+	return 0;
+}
+
+static void __exit dwc_pcie_pmu_exit(void)
+{
+	platform_device_unregister(dwc_pcie_pmu_dev);
+	platform_driver_unregister(&dwc_pcie_pmu_driver);
+}
+
+module_init(dwc_pcie_pmu_init);
+module_exit(dwc_pcie_pmu_exit);
+
+MODULE_DESCRIPTION("PMU driver for DesignWare Cores PCI Express Controller");
+MODULE_AUTHOR("Shuai xue <xueshuai@linux.alibaba.com>");
+MODULE_AUTHOR("Wen Cheng <yinxuan_cw@linux.alibaba.com>");
+MODULE_LICENSE("GPL v2");
-- 
2.20.1.12.g72788fdb

