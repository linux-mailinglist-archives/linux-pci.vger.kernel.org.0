Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701F434CD7D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 12:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhC2KAI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 06:00:08 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:49700 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232112AbhC2J7y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 05:59:54 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 3B82CC04A1;
        Mon, 29 Mar 2021 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617011993; bh=xzA2O6P/KYV2tiSSvYURCn/hoBaRcA/RULkC6RPQenM=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=YnTN0luhL3ULSSfStKDVUA2/ScPMON8dYE2iBaZ/yCCl/yDICWrsDv69gQod1Jz0A
         g5EjQtoImFDJv3sx44tID5xA+5lZZU3fEb9jYSv4WXSzFVuevc0uwXjNO1KoGwUXnr
         rRMdp0a47/UBoa1R6r6KTY4x+uA+NFDybR4/ijTEYVsabErlOscEN0+qi60ZCREZ5S
         8RGgtcaqVq7gf3G2u9CcFzfzrAU+Z/hCOPE/fWlZzDAkkA6ygfts4DY7Dn7BW6pKZN
         t/OiaDkVUjVIIY5CabDnjDBVV3Bb01s+8RcD2qjRaJDM/aEa5GeyPfqEhUbzTxu7cW
         jiBUwqK+OiJHA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id E81C2A022F;
        Mon, 29 Mar 2021 09:59:51 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     linux-doc@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v9 1/4] misc: Add Synopsys DesignWare xData IP driver
Date:   Mon, 29 Mar 2021 11:59:37 +0200
Message-Id: <183abddce62cc6738ee7797a8b82f83d9dab9fb4.1617011831.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011831.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys DesignWare xData IP driver. This driver enables/disables
the PCI traffic generator module pertain to the Synopsys DesignWare
prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/Kconfig         |  10 ++
 drivers/misc/Makefile        |   1 +
 drivers/misc/dw-xdata-pcie.c | 416 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 427 insertions(+)
 create mode 100644 drivers/misc/dw-xdata-pcie.c

diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
index f532c59..e6af9ff 100644
--- a/drivers/misc/Kconfig
+++ b/drivers/misc/Kconfig
@@ -402,6 +402,16 @@ config SRAM
 config SRAM_EXEC
 	bool
 
+config DW_XDATA_PCIE
+	depends on PCI
+	tristate "Synopsys DesignWare xData PCIe driver"
+	help
+	  This driver allows controlling Synopsys DesignWare PCIe traffic
+	  generator IP also known as xData, present in Synopsys DesignWare
+	  PCIe Endpoint prototype.
+
+	  If unsure, say N.
+
 config PCI_ENDPOINT_TEST
 	depends on PCI
 	select CRC32
diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
index 99b6f15..5411996 100644
--- a/drivers/misc/Makefile
+++ b/drivers/misc/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_SRAM_EXEC)		+= sram-exec.o
 obj-$(CONFIG_GENWQE)		+= genwqe/
 obj-$(CONFIG_ECHO)		+= echo/
 obj-$(CONFIG_CXL_BASE)		+= cxl/
+obj-$(CONFIG_DW_XDATA_PCIE)	+= dw-xdata-pcie.o
 obj-$(CONFIG_PCI_ENDPOINT_TEST)	+= pci_endpoint_test.o
 obj-$(CONFIG_OCXL)		+= ocxl/
 obj-$(CONFIG_BCM_VK)		+= bcm-vk/
diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.c
new file mode 100644
index 00000000..011516b
--- /dev/null
+++ b/drivers/misc/dw-xdata-pcie.c
@@ -0,0 +1,416 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare xData driver
+ *
+ * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+ */
+
+#include <linux/miscdevice.h>
+#include <linux/bitfield.h>
+#include <linux/pci-epf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/bitops.h>
+#include <linux/mutex.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+
+#define DW_XDATA_DRIVER_NAME		"dw-xdata-pcie"
+
+#define DW_XDATA_EP_MEM_OFFSET		0x8000000
+
+static DEFINE_IDA(xdata_ida);
+
+#define STATUS_DONE			BIT(0)
+
+#define CONTROL_DOORBELL		BIT(0)
+#define CONTROL_IS_WRITE		BIT(1)
+#define CONTROL_LENGTH(a)		FIELD_PREP(GENMASK(13, 2), a)
+#define CONTROL_PATTERN_INC		BIT(16)
+#define CONTROL_NO_ADDR_INC		BIT(18)
+
+#define XPERF_CONTROL_ENABLE		BIT(5)
+
+#define BURST_REPEAT			BIT(31)
+#define BURST_VALUE			0x1001
+
+#define PATTERN_VALUE			0x0
+
+struct dw_xdata_regs {
+	u32 addr_lsb;					/* 0x000 */
+	u32 addr_msb;					/* 0x004 */
+	u32 burst_cnt;					/* 0x008 */
+	u32 control;					/* 0x00c */
+	u32 pattern;					/* 0x010 */
+	u32 status;					/* 0x014 */
+	u32 RAM_addr;					/* 0x018 */
+	u32 RAM_port;					/* 0x01c */
+	u32 _reserved0[14];				/* 0x020..0x054 */
+	u32 perf_control;				/* 0x058 */
+	u32 _reserved1[41];				/* 0x05c..0x0fc */
+	u32 wr_cnt_lsb;					/* 0x100 */
+	u32 wr_cnt_msb;					/* 0x104 */
+	u32 rd_cnt_lsb;					/* 0x108 */
+	u32 rd_cnt_msb;					/* 0x10c */
+} __packed;
+
+struct dw_xdata_region {
+	phys_addr_t paddr;				/* physical address */
+	void __iomem *vaddr;				/* virtual address */
+};
+
+struct dw_xdata {
+	struct dw_xdata_region rg_region;		/* registers */
+	size_t max_wr_len;				/* max wr xfer len */
+	size_t max_rd_len;				/* max rd xfer len */
+	struct mutex mutex;
+	struct pci_dev *pdev;
+	struct miscdevice misc_dev;
+};
+
+static inline struct dw_xdata_regs __iomem *__dw_regs(struct dw_xdata *dw)
+{
+	return dw->rg_region.vaddr;
+}
+
+static void dw_xdata_stop(struct dw_xdata *dw)
+{
+	u32 burst;
+
+	mutex_lock(&dw->mutex);
+
+	burst = readl(&(__dw_regs(dw)->burst_cnt));
+
+	if (burst & BURST_REPEAT) {
+		burst &= ~(u32)BURST_REPEAT;
+		writel(burst, &(__dw_regs(dw)->burst_cnt));
+	}
+
+	mutex_unlock(&dw->mutex);
+}
+
+static void dw_xdata_start(struct dw_xdata *dw, bool write)
+{
+	struct device *dev = &dw->pdev->dev;
+	u32 control, status;
+
+	/* Stop first if xfer in progress */
+	dw_xdata_stop(dw);
+
+	mutex_lock(&dw->mutex);
+
+	/* Clear status register */
+	writel(0x0, &(__dw_regs(dw)->status));
+
+	/* Burst count register set for continuous until stopped */
+	writel(BURST_REPEAT | BURST_VALUE, &(__dw_regs(dw)->burst_cnt));
+
+	/* Pattern register */
+	writel(PATTERN_VALUE, &(__dw_regs(dw)->pattern));
+
+	/* Control register */
+	control = CONTROL_DOORBELL | CONTROL_PATTERN_INC | CONTROL_NO_ADDR_INC;
+	if (write) {
+		control |= CONTROL_IS_WRITE;
+		control |= CONTROL_LENGTH(dw->max_wr_len);
+	} else {
+		control |= CONTROL_LENGTH(dw->max_rd_len);
+	}
+	writel(control, &(__dw_regs(dw)->control));
+
+	/*
+	 * The xData HW block needs about 100 ms to initiate the traffic
+	 * generation according this HW block datasheet.
+	 */
+	usleep_range(100, 150);
+
+	status = readl(&(__dw_regs(dw)->status));
+
+	mutex_unlock(&dw->mutex);
+
+	if (!(status & STATUS_DONE))
+		dev_dbg(dev, "xData: started %s direction\n",
+			write ? "write" : "read");
+}
+
+static void dw_xdata_perf_meas(struct dw_xdata *dw, u64 *data, bool write)
+{
+	if (write) {
+		*data = readl(&(__dw_regs(dw)->wr_cnt_msb));
+		*data <<= 32;
+		*data |= readl(&(__dw_regs(dw)->wr_cnt_lsb));
+	} else {
+		*data = readl(&(__dw_regs(dw)->rd_cnt_msb));
+		*data <<= 32;
+		*data |= readl(&(__dw_regs(dw)->rd_cnt_lsb));
+	}
+}
+
+static u64 dw_xdata_perf_diff(u64 *m1, u64 *m2, u64 time)
+{
+	u64 rate = (*m1 - *m2);
+
+	rate *= (1000 * 1000 * 1000);
+	rate >>= 20;
+	rate = DIV_ROUND_CLOSEST_ULL(rate, time);
+
+	return rate;
+}
+
+static void dw_xdata_perf(struct dw_xdata *dw, u64 *rate, bool write)
+{
+	struct device *dev = &dw->pdev->dev;
+	u64 data[2], time[2], diff;
+
+	mutex_lock(&dw->mutex);
+
+	/* First acquisition of current count frames */
+	writel(0x0, &(__dw_regs(dw)->perf_control));
+	dw_xdata_perf_meas(dw, &data[0], write);
+	time[0] = jiffies;
+	writel((u32)XPERF_CONTROL_ENABLE, &(__dw_regs(dw)->perf_control));
+
+	/*
+	 * Wait 100ms between the 1st count frame acquisition and the 2nd
+	 * count frame acquisition, in order to calculate the speed later
+	 */
+	mdelay(100);
+
+	/* Second acquisition of current count frames */
+	writel(0x0, &(__dw_regs(dw)->perf_control));
+	dw_xdata_perf_meas(dw, &data[1], write);
+	time[1] = jiffies;
+	writel((u32)XPERF_CONTROL_ENABLE, &(__dw_regs(dw)->perf_control));
+
+	/*
+	 * Speed calculation
+	 *
+	 * rate = (2nd count frames - 1st count frames) / (time elapsed)
+	 */
+	diff = jiffies_to_nsecs(time[1] - time[0]);
+	*rate = dw_xdata_perf_diff(&data[1], &data[0], diff);
+
+	mutex_unlock(&dw->mutex);
+
+	dev_dbg(dev, "xData: time=%llu us, %s=%llu MB/s\n",
+		diff, write ? "write" : "read", *rate);
+}
+
+static struct dw_xdata *misc_dev_to_dw(struct miscdevice *misc_dev)
+{
+	return container_of(misc_dev, struct dw_xdata, misc_dev);
+}
+
+static ssize_t write_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct miscdevice *misc_dev = dev_get_drvdata(dev);
+	struct dw_xdata *dw = misc_dev_to_dw(misc_dev);
+	u64 rate;
+
+	dw_xdata_perf(dw, &rate, true);
+
+	return sysfs_emit(buf, "%llu\n", rate);
+}
+
+static ssize_t write_store(struct device *dev, struct device_attribute *attr,
+			   const char *buf, size_t size)
+{
+	struct miscdevice *misc_dev = dev_get_drvdata(dev);
+	struct dw_xdata *dw = misc_dev_to_dw(misc_dev);
+
+	dev_dbg(dev, "xData: requested write transfer\n");
+
+	dw_xdata_start(dw, true);
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(write);
+
+static ssize_t read_show(struct device *dev, struct device_attribute *attr,
+			 char *buf)
+{
+	struct miscdevice *misc_dev = dev_get_drvdata(dev);
+	struct dw_xdata *dw = misc_dev_to_dw(misc_dev);
+	u64 rate;
+
+	dw_xdata_perf(dw, &rate, false);
+
+	return sysfs_emit(buf, "%llu\n", rate);
+}
+
+static ssize_t read_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	struct miscdevice *misc_dev = dev_get_drvdata(dev);
+	struct dw_xdata *dw = misc_dev_to_dw(misc_dev);
+
+	dev_dbg(dev, "xData: requested read transfer\n");
+
+	dw_xdata_start(dw, false);
+
+	return size;
+}
+
+static DEVICE_ATTR_RW(read);
+
+static ssize_t stop_store(struct device *dev, struct device_attribute *attr,
+			  const char *buf, size_t size)
+{
+	struct miscdevice *misc_dev = dev_get_drvdata(dev);
+	struct dw_xdata *dw = misc_dev_to_dw(misc_dev);
+
+	dev_dbg(dev, "xData: requested stop any transfer\n");
+
+	dw_xdata_stop(dw);
+
+	return size;
+}
+
+static DEVICE_ATTR_WO(stop);
+
+static struct attribute *xdata_attrs[] = {
+	&dev_attr_write.attr,
+	&dev_attr_read.attr,
+	&dev_attr_stop.attr,
+	NULL,
+};
+
+ATTRIBUTE_GROUPS(xdata);
+
+static int dw_xdata_pcie_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *pid)
+{
+	struct device *dev = &pdev->dev;
+	struct dw_xdata *dw;
+	char name[24];
+	u64 addr;
+	int err;
+	int id;
+
+	/* Enable PCI device */
+	err = pcim_enable_device(pdev);
+	if (err) {
+		dev_err(dev, "enabling device failed\n");
+		return err;
+	}
+
+	/* Mapping PCI BAR regions */
+	err = pcim_iomap_regions(pdev, BIT(BAR_0), pci_name(pdev));
+	if (err) {
+		dev_err(dev, "xData BAR I/O remapping failed\n");
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	/* Allocate memory */
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	/* Data structure initialization */
+	mutex_init(&dw->mutex);
+
+	dw->rg_region.vaddr = pcim_iomap_table(pdev)[BAR_0];
+	if (!dw->rg_region.vaddr)
+		return -ENOMEM;
+
+	dw->rg_region.paddr = pdev->resource[BAR_0].start;
+
+	dw->max_wr_len = pcie_get_mps(pdev);
+	dw->max_wr_len >>= 2;
+
+	dw->max_rd_len = pcie_get_readrq(pdev);
+	dw->max_rd_len >>= 2;
+
+	dw->pdev = pdev;
+
+	id = ida_simple_get(&xdata_ida, 0, 0, GFP_KERNEL);
+	if (id < 0) {
+		dev_err(dev, "xData: unable to get id\n");
+		return id;
+	}
+
+	snprintf(name, sizeof(name), DW_XDATA_DRIVER_NAME ".%d", id);
+	dw->misc_dev.name = kstrdup(name, GFP_KERNEL);
+	if (!dw->misc_dev.name) {
+		err = -ENOMEM;
+		goto err_ida_remove;
+	}
+
+	dw->misc_dev.minor = MISC_DYNAMIC_MINOR;
+	dw->misc_dev.parent = dev;
+	dw->misc_dev.groups = xdata_groups;
+
+	writel(0x0, &(__dw_regs(dw)->RAM_addr));
+	writel(0x0, &(__dw_regs(dw)->RAM_port));
+
+	addr = dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
+	writel(lower_32_bits(addr), &(__dw_regs(dw)->addr_lsb));
+	writel(upper_32_bits(addr), &(__dw_regs(dw)->addr_msb));
+	dev_dbg(dev, "xData: target address = 0x%.16llx\n", addr);
+
+	dev_dbg(dev, "xData: wr_len = %zu, rd_len = %zu\n",
+		dw->max_wr_len * 4, dw->max_rd_len * 4);
+
+	/* Saving data structure reference */
+	pci_set_drvdata(pdev, dw);
+
+	/* Register misc device */
+	err = misc_register(&dw->misc_dev);
+	if (err) {
+		dev_err(dev, "xData: failed to register device\n");
+		goto err_kfree_name;
+	}
+
+	return 0;
+
+err_kfree_name:
+	kfree(dw->misc_dev.name);
+
+err_ida_remove:
+	ida_simple_remove(&xdata_ida, id);
+
+	return err;
+}
+
+static void dw_xdata_pcie_remove(struct pci_dev *pdev)
+{
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+	int id;
+
+	if (sscanf(dw->misc_dev.name, DW_XDATA_DRIVER_NAME ".%d", &id) != 1)
+		return;
+
+	if (id < 0)
+		return;
+
+	dw_xdata_stop(dw);
+	misc_deregister(&dw->misc_dev);
+	kfree(dw->misc_dev.name);
+	ida_simple_remove(&xdata_ida, id);
+}
+
+static const struct pci_device_id dw_xdata_pcie_id_table[] = {
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, dw_xdata_pcie_id_table);
+
+static struct pci_driver dw_xdata_pcie_driver = {
+	.name		= DW_XDATA_DRIVER_NAME,
+	.id_table	= dw_xdata_pcie_id_table,
+	.probe		= dw_xdata_pcie_probe,
+	.remove		= dw_xdata_pcie_remove,
+};
+
+module_pci_driver(dw_xdata_pcie_driver);
+
+MODULE_LICENSE("GPL v2");
+MODULE_DESCRIPTION("Synopsys DesignWare xData PCIe driver");
+MODULE_AUTHOR("Gustavo Pimentel <gustavo.pimentel@synopsys.com>");
+
-- 
2.7.4

