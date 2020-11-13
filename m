Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0032B28A8
	for <lists+linux-pci@lfdr.de>; Fri, 13 Nov 2020 23:38:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgKMWh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Nov 2020 17:37:56 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:56102 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726064AbgKMWhe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Nov 2020 17:37:34 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8EE4D40474;
        Fri, 13 Nov 2020 22:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1605307050; bh=DcMGPHdP4KeaovoDmnXPRW+915s8oLXPaf0ZlHzysA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=WyY1shy+N0e8pm487R4bGhg+IQc+9Anx5+LjqMgSGyZhC+UjUB/eVe8fMgHilfrbI
         LqSUxftmxWKkfO23lcqlWsh9U1fBej75k9sUBqKJOFOfuhrLM0U+EIF+7zJHhIR/aY
         UG0Snie8D+9+17kWccxGGqlnPv1YAFkx47VeVumblABlj8q1q40infN/Msc2TkJZsc
         y3hfSZTED0IWvspy67hyChnGGB1tTZIVkTwn3e5455J70WQKc45EpD+xGSFckyuU8z
         5rQIsYPSzhbkx7/GSFaV6URx5WrE7AQ/XYbelQ6RmM5mhrpFKQoX+/D4G8jgLYnddo
         3p6cgZiU06b1A==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 56D1EA0060;
        Fri, 13 Nov 2020 22:37:29 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 1/5] misc: Add Synopsys DesignWare xData IP driver
Date:   Fri, 13 Nov 2020 23:37:12 +0100
Message-Id: <f1e062df1be1366ddf112ee642c338fd3329ddd0.1605306931.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
References: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
References: <cover.1605306931.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys DesignWare xData IP driver. This driver enables/disables
the PCI traffic generator module pertain to the Synopsys DesignWare
prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/dw-xdata-pcie.c | 390 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 390 insertions(+)
 create mode 100644 drivers/misc/dw-xdata-pcie.c

diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.c
new file mode 100644
index 00000000..d74ff22
--- /dev/null
+++ b/drivers/misc/dw-xdata-pcie.c
@@ -0,0 +1,390 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare xData driver
+ *
+ * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+ */
+
+#include <linux/bitfield.h>
+#include <linux/pci-epf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/bitops.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+
+#define DW_XDATA_DRIVER_NAME		"dw-xdata-pcie"
+
+#define DW_XDATA_EP_MEM_OFFSET		0x8000000
+
+struct dw_xdata_pcie_data {
+	/* xData registers location */
+	enum pci_barno			rg_bar;
+	off_t				rg_off;
+	size_t				rg_sz;
+};
+
+static const struct dw_xdata_pcie_data snps_edda_data = {
+	/* xData registers location */
+	.rg_bar				= BAR_0,
+	.rg_off				= 0x00000000,   /*   0 Kbytes */
+	.rg_sz				= 0x0000012c,   /* 300  bytes */
+};
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
+union _addr {
+	u64 reg;
+	struct {
+		u32 lsb;
+		u32 msb;
+	};
+};
+
+struct dw_xdata_regs {
+	union _addr addr;				/* 0x000..0x004 */
+	u32 burst_cnt;					/* 0x008 */
+	u32 control;					/* 0x00c */
+	u32 pattern;					/* 0x010 */
+	u32 status;					/* 0x014 */
+	u32 RAM_addr;					/* 0x018 */
+	u32 RAM_port;					/* 0x01c */
+	u32 _reserved0[14];				/* 0x020..0x054 */
+	u32 perf_control;				/* 0x058 */
+	u32 _reserved1[41];				/* 0x05c..0x0fc */
+	union _addr wr_cnt;				/* 0x100..0x104 */
+	union _addr rd_cnt;				/* 0x108..0x10c */
+} __packed;
+
+struct dw_xdata_region {
+	phys_addr_t paddr;				/* physical address */
+	void __iomem *vaddr;				/* virtual address */
+	size_t sz;					/* size */
+};
+
+struct dw_xdata {
+	struct dw_xdata_region rg_region;		/* registers */
+	size_t max_wr_len;				/* max wr xfer len */
+	size_t max_rd_len;				/* max rd xfer len */
+	struct pci_dev *pdev;
+};
+
+static inline struct dw_xdata_regs __iomem *__dw_regs(struct dw_xdata *dw)
+{
+	return dw->rg_region.vaddr;
+}
+
+static void dw_xdata_stop(struct dw_xdata *dw)
+{
+	u32 burst = readl(&(__dw_regs(dw)->burst_cnt));
+
+	if (burst & BIT(31)) {
+		burst &= ~(u32)BIT(31);
+		writel(burst, &(__dw_regs(dw)->burst_cnt));
+	}
+}
+
+static void dw_xdata_start(struct dw_xdata *dw, bool write)
+{
+	u32 control, status;
+
+	/* Stop first if xfer in progress */
+	dw_xdata_stop(dw);
+
+	/* Clear status register */
+	writel(0x0, &(__dw_regs(dw)->status));
+
+	/* Burst count register set for continuous until stopped */
+	writel(0x80001001, &(__dw_regs(dw)->burst_cnt));
+
+	/* Pattern register */
+	writel(0x0, &(__dw_regs(dw)->pattern));
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
+	usleep_range(100, 150);
+
+	status = readl(&(__dw_regs(dw)->status));
+	if (!(status & STATUS_DONE))
+		pci_dbg(dw->pdev, "xData: started %s direction\n",
+			write ? "write" : "read");
+}
+
+static void dw_xdata_perf_meas(struct dw_xdata *dw, u64 *data, bool write)
+{
+	union _addr *cnt;
+
+	if (write)
+		cnt = &(__dw_regs(dw)->wr_cnt);
+	else
+		cnt = &(__dw_regs(dw)->rd_cnt);
+
+#ifdef CONFIG_64BIT
+	*data = readq(&cnt->reg);
+#else /* CONFIG_64BIT */
+	*data = readl(&cnt->msb);
+	*data <<= 32;
+	*data |= readl(&cnt->lsb);
+#endif /* CONFIG_64BIT */
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
+	u64 data[2], time[2], diff;
+
+	/* First measurement */
+	writel(0x0, &(__dw_regs(dw)->perf_control));
+	dw_xdata_perf_meas(dw, &data[0], write);
+	time[0] = jiffies;
+	writel((u32)XPERF_CONTROL_ENABLE, &(__dw_regs(dw)->perf_control));
+
+	/* Delay 100ms */
+	mdelay(100);
+
+	/* Second measurement */
+	writel(0x0, &(__dw_regs(dw)->perf_control));
+	dw_xdata_perf_meas(dw, &data[1], write);
+	time[1] = jiffies;
+	writel((u32)XPERF_CONTROL_ENABLE, &(__dw_regs(dw)->perf_control));
+
+	/* Calculations */
+	diff = jiffies_to_nsecs(time[1] - time[0]);
+	*rate = dw_xdata_perf_diff(&data[1], &data[0], diff);
+
+	pci_dbg(dw->pdev, "xData: time=%llu us, %s=%llu MB/s\n",
+		diff, write ? "write" : "read", *rate);
+}
+
+static inline struct device *kobj2device(struct kobject *kobj)
+{
+	return container_of(kobj, struct device, kobj);
+}
+
+static inline struct pci_dev *device2pci_dev(struct device *dev)
+{
+	return container_of(dev, struct pci_dev, dev);
+}
+
+static ssize_t sysfs_write_show(struct kobject *kobj,
+				struct kobj_attribute *attr, char *buf)
+{
+	struct device *dev = kobj2device(kobj);
+	struct pci_dev *pdev = device2pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+	u64 rate;
+
+	dw_xdata_perf(dw, &rate, true);
+	return sprintf(buf, "%llu MB/s\n", rate);
+}
+
+static ssize_t sysfs_write_store(struct kobject *kobj,
+				 struct kobj_attribute *attr, const char *buf,
+				 size_t count)
+{
+	struct device *dev = kobj2device(kobj);
+	struct pci_dev *pdev = device2pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	pci_dbg(pdev, "xData: requested write transfer\n");
+	dw_xdata_start(dw, true);
+
+	return count;
+}
+
+struct kobj_attribute sysfs_write_attr = __ATTR(write, 0644,
+						sysfs_write_show,
+						sysfs_write_store);
+
+static ssize_t sysfs_read_show(struct kobject *kobj,
+			       struct kobj_attribute *attr, char *buf)
+{
+	struct device *dev = kobj2device(kobj);
+	struct pci_dev *pdev = device2pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+	u64 rate;
+
+	dw_xdata_perf(dw, &rate, false);
+	return sprintf(buf, "%llu MB/s\n", rate);
+}
+
+static ssize_t sysfs_read_store(struct kobject *kobj,
+				struct kobj_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct device *dev = kobj2device(kobj);
+	struct pci_dev *pdev = device2pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	pci_dbg(pdev, "xData: requested read transfer\n");
+	dw_xdata_start(dw, false);
+
+	return count;
+}
+
+struct kobj_attribute sysfs_read_attr = __ATTR(read, 0644,
+					       sysfs_read_show,
+					       sysfs_read_store);
+
+static ssize_t sysfs_stop_store(struct kobject *kobj,
+				struct kobj_attribute *attr, const char *buf,
+				size_t count)
+{
+	struct device *dev = kobj2device(kobj);
+	struct pci_dev *pdev = device2pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	pci_dbg(pdev, "xData: requested stop any transfer\n");
+	dw_xdata_stop(dw);
+
+	return count;
+}
+
+struct kobj_attribute sysfs_stop_attr = __ATTR(stop, 0644,
+					       NULL,
+					       sysfs_stop_store);
+
+static int dw_xdata_pcie_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *pid)
+{
+	const struct dw_xdata_pcie_data *pdata = (void *)pid->driver_data;
+	struct device *dev = &pdev->dev;
+	struct dw_xdata *dw;
+	u64 addr;
+	int err;
+
+	/* Enable PCI device */
+	err = pcim_enable_device(pdev);
+	if (err) {
+		pci_err(pdev, "enabling device failed\n");
+		return err;
+	}
+
+	/* Mapping PCI BAR regions */
+	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar), pci_name(pdev));
+	if (err) {
+		pci_err(pdev, "xData BAR I/O remapping failed\n");
+		return err;
+	}
+
+	pci_set_master(pdev);
+
+	/* Allocate memory */
+	dw = devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
+	if (!dw)
+		return -ENOMEM;
+
+	/* Data structure initialization */
+	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
+	if (!dw->rg_region.vaddr)
+		return -ENOMEM;
+
+	dw->rg_region.vaddr += pdata->rg_off;
+	dw->rg_region.paddr = pdev->resource[pdata->rg_bar].start;
+	dw->rg_region.paddr += pdata->rg_off;
+	dw->rg_region.sz = pdata->rg_sz;
+
+	dw->max_wr_len = pcie_get_mps(pdev);
+	dw->max_wr_len >>= 2;
+
+	dw->max_rd_len = pcie_get_readrq(pdev);
+	dw->max_rd_len >>= 2;
+
+	dw->pdev = pdev;
+
+	writel(0x0, &(__dw_regs(dw)->RAM_addr));
+	writel(0x0, &(__dw_regs(dw)->RAM_port));
+
+	addr = dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
+#ifdef CONFIG_64BIT
+	writeq(addr, &(__dw_regs(dw)->addr.reg));
+#else /* CONFIG_64BIT */
+	writel(lower_32_bits(addr), &(__dw_regs(dw)->addr.lsb));
+	writel(upper_32_bits(addr), &(__dw_regs(dw)->addr.msb));
+#endif /* CONFIG_64BIT */
+	pci_dbg(pdev, "xData: target address = 0x%.16llx\n", addr);
+
+	pci_dbg(pdev, "xData: wr_len=%zu, rd_len=%zu\n",
+		dw->max_wr_len * 4, dw->max_rd_len * 4);
+
+	err = sysfs_create_file(&dev->kobj, &sysfs_write_attr.attr);
+	if (err)
+		return err;
+
+	err = sysfs_create_file(&dev->kobj, &sysfs_read_attr.attr);
+	if (err)
+		return err;
+
+	err = sysfs_create_file(&dev->kobj, &sysfs_stop_attr.attr);
+	if (err)
+		return err;
+
+	err = sysfs_create_link(kernel_kobj, &dev->kobj, DW_XDATA_DRIVER_NAME);
+	if (err)
+		return err;
+
+	/* Saving data structure reference */
+	pci_set_drvdata(pdev, dw);
+
+	return 0;
+}
+
+static void dw_xdata_pcie_remove(struct pci_dev *pdev)
+{
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+	struct device *dev = &pdev->dev;
+
+	if (dw)
+		dw_xdata_stop(dw);
+
+	sysfs_remove_link(kernel_kobj, DW_XDATA_DRIVER_NAME);
+	kobject_put(&dev->kobj);
+}
+
+static const struct pci_device_id dw_xdata_pcie_id_table[] = {
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
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

