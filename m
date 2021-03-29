Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5442234CD5B
	for <lists+linux-pci@lfdr.de>; Mon, 29 Mar 2021 11:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232210AbhC2JwJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Mar 2021 05:52:09 -0400
Received: from smtprelay-out1.synopsys.com ([149.117.73.133]:44018 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232137AbhC2Jv7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 Mar 2021 05:51:59 -0400
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 615DF400DF;
        Mon, 29 Mar 2021 09:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1617011519; bh=7VyFB/tmW8WllrEFLW1bfsX/69i4SdbVMzsdGZMBjUI=;
        h=From:To:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=TOWCgZDeNlklNhkIojwmtcMm2Wj3+E4TicZio2fNnE41kbelZUwBoZpofs4gaZ3nf
         pc8NEyfiwX8QgUl7cY4CDifV525nowo/xqA2RD16uUGb0AfXipsuJjHPntx6JLXZPm
         QAU2AlHB8o1g8+9DkilbDgsVTemBdkGzoWV970yPe0upkhXZ5CYtwdjICQdF7GIUE7
         ilJ8/oTKOyARZ00gvPy3WzbDdRFLh1ohN7fG75HIsXpz4YGvYhlv6QKjeYZ+sWYfbL
         w5xXsuH+68etXpYqkw19a5Jo47uvvbyeG/11Y30G5KBrwJtMg7qnVrH0gyZ1gEX47M
         xeYzrCBWVr4IA==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id EA15BA022E;
        Mon, 29 Mar 2021 09:51:57 +0000 (UTC)
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
Subject: [PATCH v8 5/5] FIX driver
Date:   Mon, 29 Mar 2021 11:51:38 +0200
Message-Id: <20405596c759cf6cabca83e7a9cd90113fbea557.1617011282.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
References: <cover.1617011282.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/misc/dw-xdata-pcie.c | 99 +++++++++++++++++++++++++-------------------
 1 file changed, 57 insertions(+), 42 deletions(-)

diff --git a/drivers/misc/dw-xdata-pcie.c b/drivers/misc/dw-xdata-pcie.c
index 43fdd35..011516b 100644
--- a/drivers/misc/dw-xdata-pcie.c
+++ b/drivers/misc/dw-xdata-pcie.c
@@ -21,19 +21,7 @@
 
 #define DW_XDATA_EP_MEM_OFFSET		0x8000000
 
-struct dw_xdata_pcie_data {
-	/* xData registers location */
-	enum pci_barno			rg_bar;
-	off_t				rg_off;
-	size_t				rg_sz;
-};
-
-static const struct dw_xdata_pcie_data snps_edda_data = {
-	/* xData registers location */
-	.rg_bar				= BAR_0,
-	.rg_off				= 0x00000000,   /*   0 Kbytes */
-	.rg_sz				= 0x0000012c,   /* 300  bytes */
-};
+static DEFINE_IDA(xdata_ida);
 
 #define STATUS_DONE			BIT(0)
 
@@ -71,7 +59,6 @@ struct dw_xdata_regs {
 struct dw_xdata_region {
 	phys_addr_t paddr;				/* physical address */
 	void __iomem *vaddr;				/* virtual address */
-	size_t sz;					/* size */
 };
 
 struct dw_xdata {
@@ -80,7 +67,6 @@ struct dw_xdata {
 	size_t max_rd_len;				/* max rd xfer len */
 	struct mutex mutex;
 	struct pci_dev *pdev;
-	struct device *dev;
 	struct miscdevice misc_dev;
 };
 
@@ -107,6 +93,7 @@ static void dw_xdata_stop(struct dw_xdata *dw)
 
 static void dw_xdata_start(struct dw_xdata *dw, bool write)
 {
+	struct device *dev = &dw->pdev->dev;
 	u32 control, status;
 
 	/* Stop first if xfer in progress */
@@ -144,7 +131,7 @@ static void dw_xdata_start(struct dw_xdata *dw, bool write)
 	mutex_unlock(&dw->mutex);
 
 	if (!(status & STATUS_DONE))
-		pci_dbg(dw->pdev, "xData: started %s direction\n",
+		dev_dbg(dev, "xData: started %s direction\n",
 			write ? "write" : "read");
 }
 
@@ -174,6 +161,7 @@ static u64 dw_xdata_perf_diff(u64 *m1, u64 *m2, u64 time)
 
 static void dw_xdata_perf(struct dw_xdata *dw, u64 *rate, bool write)
 {
+	struct device *dev = &dw->pdev->dev;
 	u64 data[2], time[2], diff;
 
 	mutex_lock(&dw->mutex);
@@ -206,7 +194,7 @@ static void dw_xdata_perf(struct dw_xdata *dw, u64 *rate, bool write)
 
 	mutex_unlock(&dw->mutex);
 
-	pci_dbg(dw->pdev, "xData: time=%llu us, %s=%llu MB/s\n",
+	dev_dbg(dev, "xData: time=%llu us, %s=%llu MB/s\n",
 		diff, write ? "write" : "read", *rate);
 }
 
@@ -233,7 +221,7 @@ static ssize_t write_store(struct device *dev, struct device_attribute *attr,
 	struct miscdevice *misc_dev = dev_get_drvdata(dev);
 	struct dw_xdata *dw = misc_dev_to_dw(misc_dev);
 
-	pci_dbg(dw->pdev, "xData: requested write transfer\n");
+	dev_dbg(dev, "xData: requested write transfer\n");
 
 	dw_xdata_start(dw, true);
 
@@ -260,7 +248,7 @@ static ssize_t read_store(struct device *dev, struct device_attribute *attr,
 	struct miscdevice *misc_dev = dev_get_drvdata(dev);
 	struct dw_xdata *dw = misc_dev_to_dw(misc_dev);
 
-	pci_dbg(dw->pdev, "xData: requested read transfer\n");
+	dev_dbg(dev, "xData: requested read transfer\n");
 
 	dw_xdata_start(dw, false);
 
@@ -275,7 +263,7 @@ static ssize_t stop_store(struct device *dev, struct device_attribute *attr,
 	struct miscdevice *misc_dev = dev_get_drvdata(dev);
 	struct dw_xdata *dw = misc_dev_to_dw(misc_dev);
 
-	pci_dbg(dw->pdev, "xData: requested stop any transfer\n");
+	dev_dbg(dev, "xData: requested stop any transfer\n");
 
 	dw_xdata_stop(dw);
 
@@ -296,43 +284,42 @@ ATTRIBUTE_GROUPS(xdata);
 static int dw_xdata_pcie_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *pid)
 {
-	const struct dw_xdata_pcie_data *pdata = (void *)pid->driver_data;
+	struct device *dev = &pdev->dev;
 	struct dw_xdata *dw;
+	char name[24];
 	u64 addr;
 	int err;
+	int id;
 
 	/* Enable PCI device */
 	err = pcim_enable_device(pdev);
 	if (err) {
-		pci_err(pdev, "enabling device failed\n");
+		dev_err(dev, "enabling device failed\n");
 		return err;
 	}
 
 	/* Mapping PCI BAR regions */
-	err = pcim_iomap_regions(pdev, BIT(pdata->rg_bar), pci_name(pdev));
+	err = pcim_iomap_regions(pdev, BIT(BAR_0), pci_name(pdev));
 	if (err) {
-		pci_err(pdev, "xData BAR I/O remapping failed\n");
+		dev_err(dev, "xData BAR I/O remapping failed\n");
 		return err;
 	}
 
 	pci_set_master(pdev);
 
 	/* Allocate memory */
-	dw = devm_kzalloc(&pdev->dev, sizeof(*dw), GFP_KERNEL);
+	dw = devm_kzalloc(dev, sizeof(*dw), GFP_KERNEL);
 	if (!dw)
 		return -ENOMEM;
 
 	/* Data structure initialization */
 	mutex_init(&dw->mutex);
 
-	dw->rg_region.vaddr = pcim_iomap_table(pdev)[pdata->rg_bar];
+	dw->rg_region.vaddr = pcim_iomap_table(pdev)[BAR_0];
 	if (!dw->rg_region.vaddr)
 		return -ENOMEM;
 
-	dw->rg_region.vaddr += pdata->rg_off;
-	dw->rg_region.paddr = pdev->resource[pdata->rg_bar].start;
-	dw->rg_region.paddr += pdata->rg_off;
-	dw->rg_region.sz = pdata->rg_sz;
+	dw->rg_region.paddr = pdev->resource[BAR_0].start;
 
 	dw->max_wr_len = pcie_get_mps(pdev);
 	dw->max_wr_len >>= 2;
@@ -341,11 +328,22 @@ static int dw_xdata_pcie_probe(struct pci_dev *pdev,
 	dw->max_rd_len >>= 2;
 
 	dw->pdev = pdev;
-	dw->dev = &pdev->dev;
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
 
 	dw->misc_dev.minor = MISC_DYNAMIC_MINOR;
-	dw->misc_dev.name = kstrdup(DW_XDATA_DRIVER_NAME, GFP_KERNEL);
-	dw->misc_dev.parent = &pdev->dev;
+	dw->misc_dev.parent = dev;
 	dw->misc_dev.groups = xdata_groups;
 
 	writel(0x0, &(__dw_regs(dw)->RAM_addr));
@@ -354,9 +352,9 @@ static int dw_xdata_pcie_probe(struct pci_dev *pdev,
 	addr = dw->rg_region.paddr + DW_XDATA_EP_MEM_OFFSET;
 	writel(lower_32_bits(addr), &(__dw_regs(dw)->addr_lsb));
 	writel(upper_32_bits(addr), &(__dw_regs(dw)->addr_msb));
-	pci_dbg(pdev, "xData: target address = 0x%.16llx\n", addr);
+	dev_dbg(dev, "xData: target address = 0x%.16llx\n", addr);
 
-	pci_dbg(pdev, "xData: wr_len = %zu, rd_len = %zu\n",
+	dev_dbg(dev, "xData: wr_len = %zu, rd_len = %zu\n",
 		dw->max_wr_len * 4, dw->max_rd_len * 4);
 
 	/* Saving data structure reference */
@@ -364,24 +362,41 @@ static int dw_xdata_pcie_probe(struct pci_dev *pdev,
 
 	/* Register misc device */
 	err = misc_register(&dw->misc_dev);
-	if (err)
-		return err;
+	if (err) {
+		dev_err(dev, "xData: failed to register device\n");
+		goto err_kfree_name;
+	}
 
 	return 0;
+
+err_kfree_name:
+	kfree(dw->misc_dev.name);
+
+err_ida_remove:
+	ida_simple_remove(&xdata_ida, id);
+
+	return err;
 }
 
 static void dw_xdata_pcie_remove(struct pci_dev *pdev)
 {
 	struct dw_xdata *dw = pci_get_drvdata(pdev);
+	int id;
 
-	if (dw) {
-		dw_xdata_stop(dw);
-		misc_deregister(&dw->misc_dev);
-	}
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
 }
 
 static const struct pci_device_id dw_xdata_pcie_id_table[] = {
-	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, &snps_edda_data) },
+	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, dw_xdata_pcie_id_table);
-- 
2.7.4

