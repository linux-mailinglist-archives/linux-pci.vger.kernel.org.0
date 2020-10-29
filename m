Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2066C29F49E
	for <lists+linux-pci@lfdr.de>; Thu, 29 Oct 2020 20:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725910AbgJ2TN5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Oct 2020 15:13:57 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:45698 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgJ2TN4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Oct 2020 15:13:56 -0400
Received: from mailhost.synopsys.com (mdc-mailhost2.synopsys.com [10.225.0.210])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id AC490C00A7;
        Thu, 29 Oct 2020 19:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1603998835; bh=yJrnxju0+RjEGPEbn+IBcfVy4zuodrq7i2sxfkUoV/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=M0cOOaT/yRJinTR2ZbPOA2u4l1HyPOeGSOiEcJOzRehr5zOLOTKtgdUsYARjF30X0
         N8UFN8igroGS7B7/SC6U0VDG8QFjuVJb3vh2yN9N2ekUKYh6seJY5LZfUKD7q1NvsM
         TIrG+x9jmQiyzL/2u7qa6/EX9xX/2RP9c4jA7GZ0QMKk+T7lHmveAay7oDblb1feSU
         CQoDQCrxeJ9I6TSZJWAgfmhgfZcN5DtOQubEAVrtFJrhhk4x0XK9TT1L1rMTZ8kdn3
         eP/BlP38zYXqpD8pTavFNFkOzaX7xYrg2k76koXbysIDUU9yEdRvbRZalMvyLXUyD7
         hSC7imS3FCOMQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id A7CFDA01F1;
        Thu, 29 Oct 2020 19:13:52 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Joao Pinto <Joao.Pinto@synopsys.com>, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/5] misc: Add Synopsys DesignWare xData IP driver
Date:   Thu, 29 Oct 2020 20:13:36 +0100
Message-Id: <f60c0cbb87bd1505669bf0cf62c56cbaa8d4c1d2.1603998630.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
References: <cover.1603998630.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add Synopsys DesignWare xData IP driver. This driver enables/disables
the PCI traffic generator module pertain to the Synopsys DesignWare
prototype.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/dw-xdata-pcie.c | 395 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 395 insertions(+)
 create mode 100644 drivers/misc/dw-xdata-pcie.c

diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.c
new file mode 100644
index 00000000..b529dae
--- /dev/null
+++ b/drivers/misc/dw-xdata-pcie.c
@@ -0,0 +1,395 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2020 Synopsys, Inc. and/or its affiliates.
+ * Synopsys DesignWare xData driver
+ *
+ * Author: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
+ */
+
+#include <linux/pci-epf.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+#include <linux/pci.h>
+
+#define DW_XDATA_EP_MEM_OFFSET		0x8000000
+
+static DEFINE_MUTEX(xdata_lock);
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
+static int dw_xdata_command_set(const char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops xdata_command_ops = {
+	.set = dw_xdata_command_set,
+};
+
+static char command;
+module_param_cb(command, &xdata_command_ops, &command, 0644);
+MODULE_PARM_DESC(command, "xData command");
+
+static struct pci_dev *priv;
+
+union dw_xdata_control_reg {
+	u32 reg;
+	struct {
+		u32 doorbell    : 1;			/* 00 */
+		u32 is_write    : 1;			/* 01 */
+		u32 length      : 12;			/* 02..13 */
+		u32 is_64       : 1;			/* 14 */
+		u32 ep		: 1;			/* 15 */
+		u32 pattern_inc : 1;			/* 16 */
+		u32 ie		: 1;			/* 17 */
+		u32 no_addr_inc : 1;			/* 18 */
+		u32 trigger     : 1;			/* 19 */
+		u32 _reserved0  : 12;			/* 20..31 */
+	};
+} __packed;
+
+union dw_xdata_status_reg {
+	u32 reg;
+	struct {
+		u32 done	: 1;			/* 00 */
+		u32 _reserved0  : 15;			/* 01..15 */
+		u32 version     : 16;			/* 16..31 */
+	};
+} __packed;
+
+union dw_xdata_xperf_control_reg {
+	u32 reg;
+	struct {
+		u32 _reserved0  : 4;			/* 00..03 */
+		u32 reset       : 1;			/* 04 */
+		u32 enable      : 1;			/* 05 */
+		u32 _reserved1  : 26;			/* 06..31 */
+	};
+} __packed;
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
+	size_t max_wr_len;				/* max xfer len */
+	size_t max_rd_len;				/* max xfer len */
+};
+
+static inline struct dw_xdata_regs __iomem *__dw_regs(struct dw_xdata *dw)
+{
+	return dw->rg_region.vaddr;
+}
+
+#define SET(dw, name, value) \
+	writel(value, &(__dw_regs(dw)->name))
+
+#define GET(dw, name) \
+	readl(&(__dw_regs(dw)->name))
+
+#ifdef CONFIG_64BIT
+#define SET_64(dw, name, value) \
+	writel(value, &(__dw_regs(dw)->name))
+
+#define GET_64(dw, name) \
+	readq(&(__dw_regs(dw)->name))
+#endif /* CONFIG_64BIT */
+
+static void dw_xdata_stop(struct pci_dev *pdev)
+{
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+	u32 tmp = GET(dw, burst_cnt);
+
+	if (tmp & 0x80000000) {
+		tmp &= 0x7fffffff;
+		SET(dw, burst_cnt, tmp);
+	}
+}
+
+static void dw_xdata_start(struct pci_dev *pdev, bool write)
+{
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+	union dw_xdata_control_reg control;
+	union dw_xdata_status_reg status;
+
+	/* Stop first if xfer in progress */
+	dw_xdata_stop(pdev);
+
+	/* Clear status register */
+	SET(dw, status, 0x0);
+
+	/* Burst count register set for continuous until stopped */
+	SET(dw, burst_cnt, 0x80001001);
+
+	/* Pattern register */
+	SET(dw, pattern, 0x0);
+
+	/* Control register */
+	control.reg = 0x0;
+	control.doorbell = true;
+	control.is_write = write;
+	if (write)
+		control.length = dw->max_wr_len;
+	else
+		control.length = dw->max_rd_len;
+	control.pattern_inc = true;
+	control.no_addr_inc = true;
+	SET(dw, control, control.reg);
+
+	usleep_range(100, 150);
+
+	status.reg = GET(dw, status);
+	if (!status.done)
+		pci_info(pdev, "xData: started %s direction\n",
+			 write ? "write" : "read");
+}
+
+static u64 dw_xdata_perf_meas(struct pci_dev *pdev, u64 *wr, u64 *rd)
+{
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+
+	#ifdef CONFIG_64BIT
+		*wr = GET_64(dw, wr_cnt.reg);
+
+		*rd = GET_64(dw, rd_cnt.reg);
+	#else /* CONFIG_64BIT */
+		*wr = GET(dw, wr_cnt.msb);
+		*wr <<= 32;
+		*wr |= GET(dw, wr_cnt.lsb);
+
+		*rd = GET(dw, rd_cnt.msb);
+		*rd <<= 32;
+		*rd |= GET(dw, rd_cnt.lsb);
+	#endif /* CONFIG_64BIT */
+
+	return jiffies;
+}
+
+static u64 dw_xdata_perf_diff(u64 *m1, u64 *m2, u64 time)
+{
+	u64 rate;
+
+	rate = (*m1 - *m2);
+	rate *= (1000 * 1000 * 1000);
+	rate >>= 20;
+	rate = DIV_ROUND_CLOSEST_ULL(rate, time);
+
+	return rate;
+}
+
+static void dw_xdata_perf(struct pci_dev *pdev)
+{
+	struct dw_xdata *dw = pci_get_drvdata(pdev);
+	union dw_xdata_xperf_control_reg control;
+	u64 wr[2], rd[2], time[2], rate[2], diff;
+
+	/* First measurement */
+	control.reg = 0x0;
+	control.enable = false;
+	SET(dw, perf_control, control.reg);
+	time[0] = dw_xdata_perf_meas(pdev, &wr[0], &rd[0]);
+	control.enable = true;
+	SET(dw, perf_control, control.reg);
+
+	/* Delay 100ms */
+	mdelay(100);
+
+	/* Second measurement */
+	control.reg = 0x0;
+	control.enable = false;
+	SET(dw, perf_control, control.reg);
+	time[1] = dw_xdata_perf_meas(pdev, &wr[1], &rd[1]);
+	control.enable = true;
+	SET(dw, perf_control, control.reg);
+
+	/* Calculations */
+	diff = jiffies_to_nsecs(time[1] - time[0]);
+
+	/* Write performance */
+	rate[0] = dw_xdata_perf_diff(&wr[1], &wr[0], diff);
+
+	/* Read performance */
+	rate[1] = dw_xdata_perf_diff(&rd[1], &rd[0], diff);
+
+	pci_info(pdev,
+		 "xData: time=%llu us, write=%llu MB/s, read=%llu MB/s\n",
+		 diff, rate[0], rate[1]);
+}
+
+static int dw_xdata_command_set(const char *val, const struct kernel_param *kp)
+{
+	int ret = -EBUSY;
+
+	mutex_lock(&xdata_lock);
+	if (!priv)
+		goto err;
+
+	ret = param_set_charp(val, kp);
+	if (ret)
+		goto err;
+
+	switch (*val) {
+	case 'w':
+	case 'W':
+		pci_info(priv, "xData: requested write transfer\n");
+		dw_xdata_start(priv, true);
+		break;
+	case 'r':
+	case 'R':
+		pci_info(priv, "xData: requested read transfer\n");
+		dw_xdata_start(priv, false);
+		break;
+	case 'p':
+	case 'P':
+		pci_info(priv, "xData: requested performance analysis\n");
+		dw_xdata_perf(priv);
+		break;
+	default:
+		pci_info(priv, "xData: requested stop any transfer\n");
+		dw_xdata_stop(priv);
+		break;
+	}
+
+err:
+	mutex_unlock(&xdata_lock);
+
+	return ret;
+}
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
+	priv = NULL;
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
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
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
+	SET(dw, RAM_addr, 0x0);
+	SET(dw, RAM_port, 0x0);
+
+	addr = dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
+#ifdef CONFIG_64BIT
+	SET_64(dw, addr.reg, addr);
+#else /* CONFIG_64BIT */
+	SET(dw, addr.lsb, lower_32_bits(addr));
+	SET(dw, addr.msb, upper_32_bits(addr));
+#endif /* CONFIG_64BIT */
+	pci_info(pdev, "xData: target address = 0x%.16llx\n", addr);
+
+	pci_info(pdev, "xData: wr_len=%zu, rd_len=%zu\n",
+		 dw->max_wr_len * 4, dw->max_rd_len * 4);
+
+	/* Saving data structure reference */
+	pci_set_drvdata(pdev, dw);
+	priv = pdev;
+
+	return 0;
+}
+
+static void dw_xdata_pcie_remove(struct pci_dev *pdev)
+{
+	if (priv) {
+		mutex_lock(&xdata_lock);
+
+		dw_xdata_stop(priv);
+		priv = NULL;
+
+		mutex_unlock(&xdata_lock);
+	}
+}
+
+static const struct pci_device_id dw_xdata_pcie_id_table[] = {
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ }
+};
+MODULE_DEVICE_TABLE(pci, dw_xdata_pcie_id_table);
+
+static struct pci_driver dw_xdata_pcie_driver = {
+	.name		= "dw-xdata-pcie",
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

