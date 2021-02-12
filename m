Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AAB31A393
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 18:29:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhBLR3R (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 12:29:17 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:42458 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229558AbhBLR3O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 12 Feb 2021 12:29:14 -0500
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 0010540C6A;
        Fri, 12 Feb 2021 17:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1613150894; bh=YAzvQBcZ2FkmDvQFuEb+w2DRCKmV9Y9knpRXoJDhJHs=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=c97ih4BAhi8eATO86rGBOKoACDQ70xkgh9eb5fTqRYOiWiqXuPRaAthWy//moReRF
         xv0zw+kNAqnEaxMGT1NqowrnLxKiY7GfvXuGAl2d5BCHu6vLbqhO/rmZw3/0pSQEdG
         fx7i6Mp1cJh6m6AsGRdbQ2osF2Wos+ZMDpBOLifrMsnDwBTPMDzIuIQy8N0sgYtkd+
         GzORvN1of+5BUHyU3ACKfz/pci0/Z4+A8XAiFZStH0nmPfH9MFDN/bkVKrHYtfkBUz
         qONPyhOTMvDNrzp+hdluW/BGzRd8gSES52EaqTCXQDKukrG+AZxTqTJiB4E6UPFs9W
         hPdnNA+wxc/BA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id B96BEA0063;
        Fri, 12 Feb 2021 17:28:12 +0000 (UTC)
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
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v6 1/5] misc: Add Synopsys DesignWare xData IP driver
Date:   Fri, 12 Feb 2021 18:28:03 +0100
Message-Id: <724f5d30e3a9b86448df7e32fb5ed1e814416368.1613150798.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
References: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
References: <cover.1613150798.git.gustavo.pimentel@synopsys.com>
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
index 00000000..62c6fa9
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
+#include <linux/mutex.h>
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
+	size_t sz;					/* size */
+};
+
+struct dw_xdata {
+	struct dw_xdata_region rg_region;		/* registers */
+	size_t max_wr_len;				/* max wr xfer len */
+	size_t max_rd_len;				/* max rd xfer len */
+	struct mutex mutex;
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
+		pci_dbg(dw->pdev, "xData: started %s direction\n",
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
+	pci_dbg(dw->pdev, "xData: time=%llu us, %s=%llu MB/s\n",
+		diff, write ? "write" : "read", *rate);
+}
+
+static ssize_t write_show(struct device *dev, struct device_attribute *attr,
+			  char *buf)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
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
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	pci_dbg(pdev, "xData: requested write transfer\n");
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
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
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
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	pci_dbg(pdev, "xData: requested read transfer\n");
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
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	pci_dbg(pdev, "xData: requested stop any transfer\n");
+
+	dw_xdata_stop(dw);
+
+	return size;
+}
+
+static DEVICE_ATTR_WO(stop);
+
+static struct attribute *default_attrs[] = {
+	&dev_attr_write.attr,
+	&dev_attr_read.attr,
+	&dev_attr_stop.attr,
+	NULL,
+};
+
+static const struct attribute_group xdata_attr_group = {
+	.attrs = default_attrs,
+	.name = DW_XDATA_DRIVER_NAME,
+};
+
+static int dw_xdata_pcie_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *pid)
+{
+	const struct dw_xdata_pcie_data *pdata = (void *)pid->driver_data;
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
+	mutex_init(&dw->mutex);
+
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
+	writel(lower_32_bits(addr), &(__dw_regs(dw)->addr_lsb));
+	writel(upper_32_bits(addr), &(__dw_regs(dw)->addr_msb));
+	pci_dbg(pdev, "xData: target address = 0x%.16llx\n", addr);
+
+	pci_dbg(pdev, "xData: wr_len=%zu, rd_len=%zu\n",
+		dw->max_wr_len * 4, dw->max_rd_len * 4);
+
+	/* Saving data structure reference */
+	pci_set_drvdata(pdev, dw);
+
+	/* Sysfs */
+	err = sysfs_create_group(&pdev->dev.kobj, &xdata_attr_group);
+	if (err)
+		return -ENODEV;
+
+	return 0;
+}
+
+static void dw_xdata_pcie_remove(struct pci_dev *pdev)
+{
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	if (dw)
+		dw_xdata_stop(dw);
+
+	sysfs_remove_group(&pdev->dev.kobj, &xdata_attr_group);
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

