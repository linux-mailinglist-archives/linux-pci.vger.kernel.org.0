Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE744BE40C
	for <lists+linux-pci@lfdr.de>; Mon, 21 Feb 2022 18:58:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344481AbiBUIos (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 21 Feb 2022 03:44:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344273AbiBUIon (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 21 Feb 2022 03:44:43 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D0AF13D11;
        Mon, 21 Feb 2022 00:44:19 -0800 (PST)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4K2G2D6dXyzbbfF;
        Mon, 21 Feb 2022 16:39:48 +0800 (CST)
Received: from localhost.localdomain (10.67.164.66) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 21 Feb 2022 16:44:16 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <gregkh@linuxfoundation.org>, <helgaas@kernel.org>,
        <alexander.shishkin@linux.intel.com>, <lorenzo.pieralisi@arm.com>,
        <will@kernel.org>, <mark.rutland@arm.com>,
        <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <mike.leach@linaro.org>, <leo.yan@linaro.org>,
        <jonathan.cameron@huawei.com>, <daniel.thompson@linaro.org>,
        <joro@8bytes.org>, <john.garry@huawei.com>,
        <shameerali.kolothum.thodi@huawei.com>, <robin.murphy@arm.com>,
        <peterz@infradead.org>, <mingo@redhat.com>, <acme@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <coresight@lists.linaro.org>, <linux-pci@vger.kernel.org>,
        <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>
CC:     <prime.zeng@huawei.com>, <liuqi115@huawei.com>,
        <zhangshaokun@hisilicon.com>, <linuxarm@huawei.com>,
        <yangyicong@hisilicon.com>, <song.bao.hua@hisilicon.com>
Subject: [PATCH v4 2/8] hwtracing: Add trace function support for HiSilicon PCIe Tune and Trace device
Date:   Mon, 21 Feb 2022 16:43:01 +0800
Message-ID: <20220221084307.33712-3-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220221084307.33712-1-yangyicong@hisilicon.com>
References: <20220221084307.33712-1-yangyicong@hisilicon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.164.66]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

HiSilicon PCIe tune and trace device(PTT) is a PCIe Root Complex
integrated Endpoint(RCiEP) device, providing the capability
to dynamically monitor and tune the PCIe traffic, and trace
the TLP headers.

Add the driver for the device to enable the trace function.
This patch adds basic function of trace, including the device's
probe and initialization, functions for trace buffer allocation
and trace enable/disable, register an interrupt handler to
simply response to the DMA events. The user interface of trace
will be added in the following patch.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/Makefile                 |   1 +
 drivers/hwtracing/Kconfig        |   2 +
 drivers/hwtracing/ptt/Kconfig    |  11 +
 drivers/hwtracing/ptt/Makefile   |   2 +
 drivers/hwtracing/ptt/hisi_ptt.c | 370 +++++++++++++++++++++++++++++++
 drivers/hwtracing/ptt/hisi_ptt.h | 149 +++++++++++++
 6 files changed, 535 insertions(+)
 create mode 100644 drivers/hwtracing/ptt/Kconfig
 create mode 100644 drivers/hwtracing/ptt/Makefile
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.c
 create mode 100644 drivers/hwtracing/ptt/hisi_ptt.h

diff --git a/drivers/Makefile b/drivers/Makefile
index a110338c860c..ab3411e4eba5 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -175,6 +175,7 @@ obj-$(CONFIG_USB4)		+= thunderbolt/
 obj-$(CONFIG_CORESIGHT)		+= hwtracing/coresight/
 obj-y				+= hwtracing/intel_th/
 obj-$(CONFIG_STM)		+= hwtracing/stm/
+obj-$(CONFIG_HISI_PTT)		+= hwtracing/ptt/
 obj-$(CONFIG_ANDROID)		+= android/
 obj-$(CONFIG_NVMEM)		+= nvmem/
 obj-$(CONFIG_FPGA)		+= fpga/
diff --git a/drivers/hwtracing/Kconfig b/drivers/hwtracing/Kconfig
index 13085835a636..911ee977103c 100644
--- a/drivers/hwtracing/Kconfig
+++ b/drivers/hwtracing/Kconfig
@@ -5,4 +5,6 @@ source "drivers/hwtracing/stm/Kconfig"
 
 source "drivers/hwtracing/intel_th/Kconfig"
 
+source "drivers/hwtracing/ptt/Kconfig"
+
 endmenu
diff --git a/drivers/hwtracing/ptt/Kconfig b/drivers/hwtracing/ptt/Kconfig
new file mode 100644
index 000000000000..41fa83921a07
--- /dev/null
+++ b/drivers/hwtracing/ptt/Kconfig
@@ -0,0 +1,11 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config HISI_PTT
+	tristate "HiSilicon PCIe Tune and Trace Device"
+	depends on ARM64 && PCI && HAS_DMA && HAS_IOMEM
+	help
+	  HiSilicon PCIe Tune and Trace Device exists as a PCIe RCiEP
+	  device, and it provides support for PCIe traffic tuning and
+	  tracing TLP headers to the memory.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called hisi_ptt.
diff --git a/drivers/hwtracing/ptt/Makefile b/drivers/hwtracing/ptt/Makefile
new file mode 100644
index 000000000000..908c09a98161
--- /dev/null
+++ b/drivers/hwtracing/ptt/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_HISI_PTT) += hisi_ptt.o
diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
new file mode 100644
index 000000000000..a5b4f09ccd1e
--- /dev/null
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -0,0 +1,370 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Driver for HiSilicon PCIe tune and trace device
+ *
+ * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
+ * Author: Yicong Yang <yangyicong@hisilicon.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/dma-iommu.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/iommu.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/sysfs.h>
+
+#include "hisi_ptt.h"
+
+static u16 hisi_ptt_get_filter_val(struct pci_dev *pdev)
+{
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
+		return BIT(HISI_PCIE_CORE_PORT_ID(PCI_SLOT(pdev->devfn)));
+
+	return PCI_DEVID(pdev->bus->number, pdev->devfn);
+}
+
+static int hisi_ptt_wait_trace_hw_idle(struct hisi_ptt *hisi_ptt)
+{
+	u32 val;
+
+	return readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_STS,
+					 val, val & HISI_PTT_TRACE_IDLE,
+					 HISI_PTT_WAIT_POLL_INTERVAL_US,
+					 HISI_PTT_WAIT_TIMEOUT_US);
+}
+
+static int hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
+{
+	u32 val;
+
+	return readl_poll_timeout_atomic(hisi_ptt->iobase + HISI_PTT_TRACE_WR_STS,
+					 val, !val, HISI_PTT_RESET_POLL_INTERVAL_US,
+					 HISI_PTT_RESET_TIMEOUT_US);
+}
+
+static void hisi_ptt_free_trace_buf(struct hisi_ptt *hisi_ptt)
+{
+	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
+	struct device *dev = &hisi_ptt->pdev->dev;
+	int i;
+
+	if (!ctrl->trace_buf)
+		return;
+
+	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++)
+		if (ctrl->trace_buf[i].addr)
+			dma_free_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
+					  ctrl->trace_buf[i].addr,
+					  ctrl->trace_buf[i].dma);
+
+	kfree(ctrl->trace_buf);
+	ctrl->trace_buf = NULL;
+}
+
+static int hisi_ptt_alloc_trace_buf(struct hisi_ptt *hisi_ptt)
+{
+	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
+	struct device *dev = &hisi_ptt->pdev->dev;
+	int i;
+
+	hisi_ptt->trace_ctrl.buf_index = 0;
+
+	/* If the trace buffer has already been allocated, zero it. */
+	if (ctrl->trace_buf) {
+		for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++)
+			memset(ctrl->trace_buf[i].addr, 0, HISI_PTT_TRACE_BUF_SIZE);
+		return 0;
+	}
+
+	ctrl->trace_buf = kcalloc(HISI_PTT_TRACE_BUF_CNT, sizeof(struct hisi_ptt_dma_buffer),
+				  GFP_KERNEL);
+	if (!ctrl->trace_buf)
+		return -ENOMEM;
+
+	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; ++i) {
+		ctrl->trace_buf[i].addr = dma_alloc_coherent(dev, HISI_PTT_TRACE_BUF_SIZE,
+							     &ctrl->trace_buf[i].dma,
+							     GFP_KERNEL);
+		if (!ctrl->trace_buf[i].addr) {
+			hisi_ptt_free_trace_buf(hisi_ptt);
+			return -ENOMEM;
+		}
+	}
+
+	return 0;
+}
+
+static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
+{
+	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+	hisi_ptt->trace_ctrl.status = HISI_PTT_TRACE_STATUS_OFF;
+}
+
+static int hisi_ptt_trace_start(struct hisi_ptt *hisi_ptt)
+{
+	struct hisi_ptt_trace_ctrl *ctrl = &hisi_ptt->trace_ctrl;
+	u32 val;
+	int i;
+
+	/* Check device idle before start trace */
+	if (hisi_ptt_wait_trace_hw_idle(hisi_ptt)) {
+		pci_err(hisi_ptt->pdev, "Failed to start trace, the device is still busy.\n");
+		return -EBUSY;
+	}
+
+	/* Reset the DMA before start tracing */
+	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+	val |= HISI_PTT_TRACE_CTRL_RST;
+	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+
+	hisi_ptt_wait_dma_reset_done(hisi_ptt);
+
+	val = readl(hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+	val &= ~HISI_PTT_TRACE_CTRL_RST;
+	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+
+	/* Clear the interrupt status */
+	writel(HISI_PTT_TRACE_INT_STAT_MASK, hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
+	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
+
+	/* Configure the trace DMA buffer */
+	for (i = 0; i < HISI_PTT_TRACE_BUF_CNT; i++) {
+		writel(lower_32_bits(ctrl->trace_buf[i].dma),
+		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_LO_0 +
+		       i * HISI_PTT_TRACE_ADDR_STRIDE);
+		writel(upper_32_bits(ctrl->trace_buf[i].dma),
+		       hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_BASE_HI_0 +
+		       i * HISI_PTT_TRACE_ADDR_STRIDE);
+	}
+	writel(HISI_PTT_TRACE_BUF_SIZE, hisi_ptt->iobase + HISI_PTT_TRACE_ADDR_SIZE);
+
+	/* Set the trace control register */
+	val = FIELD_PREP(HISI_PTT_TRACE_CTRL_TYPE_SEL, ctrl->type);
+	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_RXTX_SEL, ctrl->direction);
+	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_DATA_FORMAT, ctrl->format);
+	val |= FIELD_PREP(HISI_PTT_TRACE_CTRL_TARGET_SEL, hisi_ptt->trace_ctrl.filter);
+	if (!hisi_ptt->trace_ctrl.is_port)
+		val |= HISI_PTT_TRACE_CTRL_FILTER_MODE;
+
+	/* Start the Trace */
+	val |= HISI_PTT_TRACE_CTRL_EN;
+	writel(val, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+
+	ctrl->status = HISI_PTT_TRACE_STATUS_ON;
+
+	return 0;
+}
+
+static irqreturn_t hisi_ptt_irq(int irq, void *context)
+{
+	struct hisi_ptt *hisi_ptt = context;
+	u32 status;
+
+	status = readl(hisi_ptt->iobase + HISI_PTT_TRACE_INT_STAT);
+	if (!(status & HISI_PTT_TRACE_INT_STAT_MASK))
+		return IRQ_NONE;
+
+	return IRQ_HANDLED;
+}
+
+static void hisi_ptt_irq_free_vectors(void *pdev)
+{
+	pci_free_irq_vectors(pdev);
+}
+
+static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
+{
+	struct pci_dev *pdev = hisi_ptt->pdev;
+	int ret;
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSI);
+	if (ret < 0) {
+		pci_err(pdev, "failed to allocate irq vector, ret = %d.\n", ret);
+		return ret;
+	}
+
+	ret = devm_add_action_or_reset(&pdev->dev, hisi_ptt_irq_free_vectors, pdev);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_request_irq(&pdev->dev, pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ),
+			       hisi_ptt_irq, 0, DRV_NAME, hisi_ptt);
+	if (ret) {
+		pci_err(pdev, "failed to request irq %d, ret = %d.\n",
+			pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ), ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int hisi_ptt_init_filters(struct pci_dev *pdev, void *data)
+{
+	struct hisi_ptt_filter_desc *filter;
+	struct hisi_ptt *hisi_ptt = data;
+	struct list_head *target_list;
+
+	target_list = pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ?
+		      &hisi_ptt->port_filters : &hisi_ptt->req_filters;
+
+	filter = kzalloc(sizeof(*filter), GFP_KERNEL);
+	if (!filter)
+		return -ENOMEM;
+
+	filter->pdev = pdev;
+	list_add_tail(&filter->list, target_list);
+
+	/* Update the available port mask */
+	if (pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT)
+		hisi_ptt->port_mask |= hisi_ptt_get_filter_val(pdev);
+
+	return 0;
+}
+
+static void hisi_ptt_release_filters(struct hisi_ptt *hisi_ptt)
+{
+	struct hisi_ptt_filter_desc *filter, *tfilter;
+
+	list_for_each_entry_safe(filter, tfilter, &hisi_ptt->req_filters, list) {
+		list_del(&filter->list);
+		kfree(filter);
+	}
+
+	list_for_each_entry_safe(filter, tfilter, &hisi_ptt->port_filters, list) {
+		list_del(&filter->list);
+		kfree(filter);
+	}
+}
+
+static void hisi_ptt_init_ctrls(struct hisi_ptt *hisi_ptt)
+{
+	struct pci_dev *pdev = hisi_ptt->pdev;
+	struct pci_bus *bus;
+	u32 reg;
+
+	INIT_LIST_HEAD(&hisi_ptt->port_filters);
+	INIT_LIST_HEAD(&hisi_ptt->req_filters);
+
+	/*
+	 * The device range register provides the information about the
+	 * root ports which the RCiEP can control and trace. The RCiEP
+	 * and the root ports it support are on the same PCIe core, with
+	 * same domain number but maybe different bus number. The device
+	 * range register will tell us which root ports we can support,
+	 * Bit[31:16] indicates the upper BDF numbers of the root port,
+	 * while Bit[15:0] indicates the lower.
+	 */
+	reg = readl(hisi_ptt->iobase + HISI_PTT_DEVICE_RANGE);
+	hisi_ptt->upper = FIELD_GET(HISI_PTT_DEVICE_RANGE_UPPER, reg);
+	hisi_ptt->lower = FIELD_GET(HISI_PTT_DEVICE_RANGE_LOWER, reg);
+
+	bus = pci_find_bus(pci_domain_nr(pdev->bus), PCI_BUS_NUM(hisi_ptt->upper));
+	if (bus)
+		pci_walk_bus(bus, hisi_ptt_init_filters, hisi_ptt);
+
+	hisi_ptt->trace_ctrl.default_cpu = cpumask_first(cpumask_of_node(dev_to_node(&pdev->dev)));
+}
+
+/*
+ * The DMA of PTT trace can only use direct mapping, due to some
+ * hardware restriction. Check whether there is an IOMMU or the
+ * policy of the IOMMU domain is passthrough, otherwise the trace
+ * cannot work.
+ *
+ * The PTT device is supposed to behind the ARM SMMUv3, which
+ * should have passthrough the device by a quirk.
+ */
+static int hisi_ptt_check_iommu_mapping(struct pci_dev *pdev)
+{
+	struct iommu_domain *iommu_domain;
+
+	iommu_domain = iommu_get_domain_for_dev(&pdev->dev);
+	if (!iommu_domain || iommu_domain->type == IOMMU_DOMAIN_IDENTITY)
+		return 0;
+
+	return -EOPNOTSUPP;
+}
+
+static int hisi_ptt_probe(struct pci_dev *pdev,
+			  const struct pci_device_id *id)
+{
+	struct hisi_ptt *hisi_ptt;
+	int ret;
+
+	ret = hisi_ptt_check_iommu_mapping(pdev);
+	if (ret) {
+		pci_err(pdev, "cannot work with non-direct DMA mapping.\n");
+		return ret;
+	}
+
+	hisi_ptt = devm_kzalloc(&pdev->dev, sizeof(*hisi_ptt), GFP_KERNEL);
+	if (!hisi_ptt)
+		return -ENOMEM;
+
+	mutex_init(&hisi_ptt->mutex);
+	hisi_ptt->pdev = pdev;
+	pci_set_drvdata(pdev, hisi_ptt);
+
+	ret = pcim_enable_device(pdev);
+	if (ret) {
+		pci_err(pdev, "failed to enable device, ret = %d.\n", ret);
+		return ret;
+	}
+
+	ret = pcim_iomap_regions(pdev, BIT(2), DRV_NAME);
+	if (ret) {
+		pci_err(pdev, "failed to remap io memory, ret = %d.\n", ret);
+		return ret;
+	}
+
+	hisi_ptt->iobase = pcim_iomap_table(pdev)[2];
+
+	ret = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		pci_err(pdev, "failed to set 64 bit dma mask, ret = %d.\n", ret);
+		return ret;
+	}
+	pci_set_master(pdev);
+
+	ret = hisi_ptt_register_irq(hisi_ptt);
+	if (ret)
+		return ret;
+
+	hisi_ptt_init_ctrls(hisi_ptt);
+
+	return 0;
+}
+
+void hisi_ptt_remove(struct pci_dev *pdev)
+{
+	struct hisi_ptt *hisi_ptt = pci_get_drvdata(pdev);
+
+	if (hisi_ptt->trace_ctrl.status == HISI_PTT_TRACE_STATUS_ON)
+		hisi_ptt_trace_end(hisi_ptt);
+
+	hisi_ptt_free_trace_buf(hisi_ptt);
+	hisi_ptt_release_filters(hisi_ptt);
+}
+
+static const struct pci_device_id hisi_ptt_id_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_HUAWEI, 0xa12e) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, hisi_ptt_id_tbl);
+
+static struct pci_driver hisi_ptt_driver = {
+	.name = DRV_NAME,
+	.id_table = hisi_ptt_id_tbl,
+	.probe = hisi_ptt_probe,
+	.remove = hisi_ptt_remove,
+};
+module_pci_driver(hisi_ptt_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Yicong Yang <yangyicong@hisilicon.com>");
+MODULE_DESCRIPTION("Driver for HiSilicon PCIe tune and trace device");
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
new file mode 100644
index 000000000000..8bf5b7be56c0
--- /dev/null
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -0,0 +1,149 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Driver for HiSilicon PCIe tune and trace device
+ *
+ * Copyright (c) 2022 HiSilicon Technologies Co., Ltd.
+ * Author: Yicong Yang <yangyicong@hisilicon.com>
+ */
+
+#ifndef _HISI_PTT_H
+#define _HISI_PTT_H
+
+#include <linux/bits.h>
+#include <linux/list.h>
+#include <linux/mutex.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+
+#define DRV_NAME "hisi_ptt"
+
+/*
+ * The definition of the device registers and register fields.
+ */
+#define HISI_PTT_TRACE_ADDR_SIZE	0x0800
+#define HISI_PTT_TRACE_ADDR_BASE_LO_0	0x0810
+#define HISI_PTT_TRACE_ADDR_BASE_HI_0	0x0814
+#define HISI_PTT_TRACE_ADDR_STRIDE	0x8
+#define HISI_PTT_TRACE_CTRL		0x0850
+#define   HISI_PTT_TRACE_CTRL_EN	BIT(0)
+#define   HISI_PTT_TRACE_CTRL_RST	BIT(1)
+#define   HISI_PTT_TRACE_CTRL_RXTX_SEL	GENMASK(3, 2)
+#define   HISI_PTT_TRACE_CTRL_TYPE_SEL	GENMASK(7, 4)
+#define   HISI_PTT_TRACE_CTRL_DATA_FORMAT	BIT(14)
+#define   HISI_PTT_TRACE_CTRL_FILTER_MODE	BIT(15)
+#define   HISI_PTT_TRACE_CTRL_TARGET_SEL	GENMASK(31, 16)
+#define HISI_PTT_TRACE_INT_STAT		0x0890
+#define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
+#define HISI_PTT_TRACE_INT_MASK		0x0894
+#define HISI_PTT_TRACE_WR_STS		0x08a0
+#define   HISI_PTT_TRACE_WR_STS_WRITE	GENMASK(27, 0)
+#define   HISI_PTT_TRACE_WR_STS_BUFFER	GENMASK(29, 28)
+#define HISI_PTT_TRACE_STS		0x08b0
+#define   HISI_PTT_TRACE_IDLE		BIT(0)
+#define HISI_PTT_DEVICE_RANGE		0x0fe0
+#define   HISI_PTT_DEVICE_RANGE_UPPER	GENMASK(31, 16)
+#define   HISI_PTT_DEVICE_RANGE_LOWER	GENMASK(15, 0)
+#define HISI_PTT_LOCATION		0x0fe8
+#define   HISI_PTT_CORE_ID		GENMASK(15, 0)
+#define   HISI_PTT_SICL_ID		GENMASK(31, 16)
+
+/* Parameters of PTT trace DMA part. */
+#define HISI_PTT_TRACE_DMA_IRQ			0
+#define HISI_PTT_TRACE_BUF_CNT			4
+#define HISI_PTT_TRACE_BUF_SIZE			SZ_4M
+#define HISI_PTT_TRACE_TOTAL_BUF_SIZE		(HISI_PTT_TRACE_BUF_SIZE * \
+						 HISI_PTT_TRACE_BUF_CNT)
+/* Wait time for hardware DMA to reset */
+#define HISI_PTT_RESET_TIMEOUT_US	10UL
+#define HISI_PTT_RESET_POLL_INTERVAL_US	1UL
+/* Poll timeout and interval for waiting hardware work to finish */
+#define HISI_PTT_WAIT_TIMEOUT_US	100UL
+#define HISI_PTT_WAIT_POLL_INTERVAL_US	10UL
+
+#define HISI_PCIE_CORE_PORT_ID(devfn)	(PCI_FUNC(devfn) << 1)
+
+enum hisi_ptt_trace_status {
+	HISI_PTT_TRACE_STATUS_OFF = 0,
+	HISI_PTT_TRACE_STATUS_ON,
+};
+
+/**
+ * struct hisi_ptt_dma_buffer - describe a single trace buffer of PTT trace.
+ *                              The detail of the data format is described
+ *                              in the documentation of PTT device.
+ * @dma:   DMA address of this buffer visible to the device
+ * @addr:  virtual address of this buffer visible to the cpu
+ */
+struct hisi_ptt_dma_buffer {
+	dma_addr_t dma;
+	void *addr;
+};
+
+/**
+ * struct hisi_ptt_trace_ctrl - control and status of PTT trace
+ * @trace_buf:   array of the trace buffers for holding the trace data.
+ *               the length will be HISI_PTT_TRACE_BUF_CNT.
+ * @status:      current trace status
+ * @default_cpu: default cpu to start the trace session
+ * @buf_index:   the index of current using trace buffer
+ * @is_port:     whether we're tracing root port or not
+ * @direction:   direction of the TLP headers to trace
+ * @filter:      filter value for tracing the TLP headers
+ * @format:      format of the TLP headers to trace
+ * @type:        type of the TLP headers to trace
+ */
+struct hisi_ptt_trace_ctrl {
+	struct hisi_ptt_dma_buffer *trace_buf;
+	enum hisi_ptt_trace_status status;
+	int default_cpu;
+	u32 buf_index;
+	bool is_port;
+	u32 direction:2;
+	u32 filter:16;
+	u32 format:1;
+	u32 type:4;
+};
+
+/**
+ * struct hisi_ptt_filter_desc - descriptor of the PTT trace filter
+ * @list: entry of this descriptor in the filter list
+ * @pdev: pci_dev related to this filter
+ */
+struct hisi_ptt_filter_desc {
+	struct list_head list;
+	struct pci_dev *pdev;
+};
+
+/**
+ * struct hisi_ptt - per PTT device data
+ * @trace_ctrl:   the control information of PTT trace
+ * @iobase:       base IO address of the device
+ * @pdev:         pci_dev of this PTT device
+ * @mutex:        mutex to protect the filter list and serialize the perf process.
+ * @upper:        the upper BDF range of the PCI devices managed by this PTT device
+ * @lower:        the lower BDF range of the PCI devices managed by this PTT device
+ * @port_filters: the filter list of root ports
+ * @req_filters:  the filter list of requester ID
+ * @port_mask:    port mask of the managed root ports
+ */
+struct hisi_ptt {
+	struct hisi_ptt_trace_ctrl trace_ctrl;
+	void __iomem *iobase;
+	struct pci_dev *pdev;
+	struct mutex mutex;
+	u32 upper;
+	u32 lower;
+
+	/*
+	 * The trace TLP headers can either be filtered by certain
+	 * root port, or by the requester ID. Organize the filters
+	 * by @port_filters and @req_filters here. The mask of all
+	 * the valid ports is also cached for doing sanity check
+	 * of user input.
+	 */
+	struct list_head port_filters;
+	struct list_head req_filters;
+	u16 port_mask;
+};
+
+#endif /* _HISI_PTT_H */
-- 
2.24.0

