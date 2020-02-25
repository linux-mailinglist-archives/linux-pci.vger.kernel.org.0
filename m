Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15DA916BCF8
	for <lists+linux-pci@lfdr.de>; Tue, 25 Feb 2020 10:07:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729153AbgBYJHS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 25 Feb 2020 04:07:18 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:57030 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729393AbgBYJHR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 25 Feb 2020 04:07:17 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 01P97A11114982;
        Tue, 25 Feb 2020 03:07:10 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1582621630;
        bh=qpB5Venlyxo4sKSWGb+++fS0KMNoB1LVzbHh61l1dmY=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=L2rjLmEk+LwoSSlj4J+0h7R3VsC+Un80FQ9z0OlPXoIdMHV/7uVxKpxpti0DAWD0O
         973Yuh5pICKTZuw+imGs/4Vj7iz7QVNxFBLpHzgFGjaZQ5u3rR38yCg8kPfcqBF/Sf
         fhxTLfdulJ+XMQ9ZKdOfJrbl5IWuXAvLUqCbvGFk=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 01P97AnA027452
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 25 Feb 2020 03:07:10 -0600
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Tue, 25
 Feb 2020 03:07:10 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Tue, 25 Feb 2020 03:07:10 -0600
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 01P973Pp052643;
        Tue, 25 Feb 2020 03:07:07 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/5] PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data
Date:   Tue, 25 Feb 2020 14:41:26 +0530
Message-ID: <20200225091130.29467-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200225091130.29467-1-kishon@ti.com>
References: <20200225091130.29467-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use dmaengine API and add support for transferring data using DMA.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 205 +++++++++++++++++-
 1 file changed, 202 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index bddff15052cc..4e5ed37110ed 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -8,6 +8,7 @@
 
 #include <linux/crc32.h>
 #include <linux/delay.h>
+#include <linux/dmaengine.h>
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -39,6 +40,8 @@
 #define STATUS_SRC_ADDR_INVALID		BIT(7)
 #define STATUS_DST_ADDR_INVALID		BIT(8)
 
+#define FLAG_USE_DMA			BIT(0)
+
 #define TIMER_RESOLUTION		1
 
 static struct workqueue_struct *kpcitest_workqueue;
@@ -48,6 +51,9 @@ struct pci_epf_test {
 	struct pci_epf		*epf;
 	enum pci_barno		test_reg_bar;
 	struct delayed_work	cmd_handler;
+	struct dma_chan		*dma_chan;
+	struct completion	transfer_complete;
+	bool			dma_supported;
 	const struct pci_epc_features *epc_features;
 };
 
@@ -61,6 +67,7 @@ struct pci_epf_test_reg {
 	u32	checksum;
 	u32	irq_type;
 	u32	irq_number;
+	u32	flags;
 } __packed;
 
 static struct pci_epf_header test_header = {
@@ -72,9 +79,121 @@ static struct pci_epf_header test_header = {
 
 static size_t bar_size[] = { 512, 512, 1024, 16384, 131072, 1048576 };
 
+static void pci_epf_test_dma_callback(void *param)
+{
+	struct pci_epf_test *epf_test = param;
+
+	complete(&epf_test->transfer_complete);
+}
+
+/**
+ * pci_epf_test_data_transfer() - Helper to use dmaengine API to transfer data
+ *			     between PCIe EP and remote PCIe RC
+ * @epf: the EPF device that performs the data transfer operation
+ * @dma_dst: The destination address of the data transfer. It can be a physical
+ *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
+ * @dma_src: The source address of the data transfer. It can be a physical
+ *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
+ * @len: The size of the data transfer
+ *
+ * Helper to use dmaengine API to transfer data between PCIe EP and remote PCIe
+ * RC. The source and destination address can be a physical address given by
+ * pci_epc_mem_alloc_addr or the one obtained using DMA mapping APIs.
+ *
+ * The function returns '0' on success and negative value on failure.
+ */
+static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
+				      dma_addr_t dma_dst, dma_addr_t dma_src,
+				      size_t len)
+{
+	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
+	struct dma_chan *chan = epf_test->dma_chan;
+	struct pci_epf *epf = epf_test->epf;
+	struct dma_async_tx_descriptor *tx;
+	struct device *dev = &epf->dev;
+	dma_cookie_t cookie;
+	int ret;
+
+	if (IS_ERR_OR_NULL(chan)) {
+		dev_err(dev, "Invalid DMA memcpy channel\n");
+		return -EINVAL;
+	}
+
+	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
+	if (!tx) {
+		dev_err(dev, "Failed to prepare DMA memcpy\n");
+		return -EIO;
+	}
+
+	tx->callback = pci_epf_test_dma_callback;
+	tx->callback_param = epf_test;
+	cookie = tx->tx_submit(tx);
+	reinit_completion(&epf_test->transfer_complete);
+
+	ret = dma_submit_error(cookie);
+	if (ret) {
+		dev_err(dev, "Failed to do DMA tx_submit %d\n", cookie);
+		return -EIO;
+	}
+
+	dma_async_issue_pending(chan);
+	ret = wait_for_completion_interruptible(&epf_test->transfer_complete);
+	if (ret < 0) {
+		dmaengine_terminate_sync(chan);
+		dev_err(dev, "DMA wait_for_completion_timeout\n");
+		return -ETIMEDOUT;
+	}
+
+	return 0;
+}
+
+/**
+ * pci_epf_init_dma_chan() - Helper to initialize EPF DMA channel
+ * @epf: the EPF device that has to perform the data transfer operation
+ *
+ * Helper to initialize EPF DMA channel.
+ */
+static int pci_epf_init_dma_chan(struct pci_epf_test *epf_test)
+{
+	struct pci_epf *epf = epf_test->epf;
+	struct device *dev = &epf->dev;
+	struct dma_chan *dma_chan;
+	dma_cap_mask_t mask;
+	int ret;
+
+	dma_cap_zero(mask);
+	dma_cap_set(DMA_MEMCPY, mask);
+
+	dma_chan = dma_request_chan_by_mask(&mask);
+	if (IS_ERR(dma_chan)) {
+		ret = PTR_ERR(dma_chan);
+		if (ret != -EPROBE_DEFER)
+			dev_err(dev, "Failed to get DMA channel\n");
+		return ret;
+	}
+	init_completion(&epf_test->transfer_complete);
+
+	epf_test->dma_chan = dma_chan;
+
+	return 0;
+}
+
+/**
+ * pci_epf_clean_dma_chan() - Helper to cleanup EPF DMA channel
+ * @epf: the EPF device that performed the data transfer operation
+ *
+ * Helper to cleanup EPF DMA channel.
+ */
+static void pci_epf_clean_dma_chan(struct pci_epf_test *epf_test)
+{
+	dma_release_channel(epf_test->dma_chan);
+	epf_test->dma_chan = NULL;
+}
+
 static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 {
 	int ret;
+	bool use_dma;
 	void __iomem *src_addr;
 	void __iomem *dst_addr;
 	phys_addr_t src_phys_addr;
@@ -117,8 +236,23 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err_dst_addr;
 	}
 
-	memcpy(dst_addr, src_addr, reg->size);
+	use_dma = !!(reg->flags & FLAG_USE_DMA);
+	if (use_dma) {
+		if (!epf_test->dma_supported) {
+			dev_err(dev, "Cannot transfer data using DMA\n");
+			ret = -EINVAL;
+			goto err_map_addr;
+		}
 
+		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
+						 src_phys_addr, reg->size);
+		if (ret)
+			dev_err(dev, "Data transfer failed\n");
+	} else {
+		memcpy(dst_addr, src_addr, reg->size);
+	}
+
+err_map_addr:
 	pci_epc_unmap_addr(epc, epf->func_no, dst_phys_addr);
 
 err_dst_addr:
@@ -140,10 +274,13 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	void __iomem *src_addr;
 	void *buf;
 	u32 crc32;
+	bool use_dma;
 	phys_addr_t phys_addr;
+	phys_addr_t dst_phys_addr;
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
+	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
@@ -169,12 +306,38 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		goto err_map_addr;
 	}
 
-	memcpy_fromio(buf, src_addr, reg->size);
+	use_dma = !!(reg->flags & FLAG_USE_DMA);
+	if (use_dma) {
+		if (!epf_test->dma_supported) {
+			dev_err(dev, "Cannot transfer data using DMA\n");
+			ret = -EINVAL;
+			goto err_map_addr;
+		}
+
+		dst_phys_addr = dma_map_single(dma_dev, buf, reg->size,
+					       DMA_FROM_DEVICE);
+		if (dma_mapping_error(dma_dev, dst_phys_addr)) {
+			dev_err(dev, "Failed to map destination buffer addr\n");
+			ret = -ENOMEM;
+			goto err_dma_map;
+		}
+
+		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
+						 phys_addr, reg->size);
+		if (ret)
+			dev_err(dev, "Data transfer failed\n");
+
+		dma_unmap_single(dma_dev, dst_phys_addr, reg->size,
+				 DMA_FROM_DEVICE);
+	} else {
+		memcpy_fromio(buf, src_addr, reg->size);
+	}
 
 	crc32 = crc32_le(~0, buf, reg->size);
 	if (crc32 != reg->checksum)
 		ret = -EIO;
 
+err_dma_map:
 	kfree(buf);
 
 err_map_addr:
@@ -192,10 +355,13 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	int ret;
 	void __iomem *dst_addr;
 	void *buf;
+	bool use_dma;
 	phys_addr_t phys_addr;
+	phys_addr_t src_phys_addr;
 	struct pci_epf *epf = epf_test->epf;
 	struct device *dev = &epf->dev;
 	struct pci_epc *epc = epf->epc;
+	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
 
@@ -224,7 +390,32 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	get_random_bytes(buf, reg->size);
 	reg->checksum = crc32_le(~0, buf, reg->size);
 
-	memcpy_toio(dst_addr, buf, reg->size);
+	use_dma = !!(reg->flags & FLAG_USE_DMA);
+	if (use_dma) {
+		if (!epf_test->dma_supported) {
+			dev_err(dev, "Cannot transfer data using DMA\n");
+			ret = -EINVAL;
+			goto err_map_addr;
+		}
+
+		src_phys_addr = dma_map_single(dma_dev, buf, reg->size,
+					       DMA_TO_DEVICE);
+		if (dma_mapping_error(dma_dev, src_phys_addr)) {
+			dev_err(dev, "Failed to map source buffer addr\n");
+			ret = -ENOMEM;
+			goto err_dma_map;
+		}
+
+		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
+						 src_phys_addr, reg->size);
+		if (ret)
+			dev_err(dev, "Data transfer failed\n");
+
+		dma_unmap_single(dma_dev, src_phys_addr, reg->size,
+				 DMA_TO_DEVICE);
+	} else {
+		memcpy_toio(dst_addr, buf, reg->size);
+	}
 
 	/*
 	 * wait 1ms inorder for the write to complete. Without this delay L3
@@ -232,6 +423,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	 */
 	usleep_range(1000, 2000);
 
+err_dma_map:
 	kfree(buf);
 
 err_map_addr:
@@ -380,6 +572,7 @@ static void pci_epf_test_unbind(struct pci_epf *epf)
 	int bar;
 
 	cancel_delayed_work(&epf_test->cmd_handler);
+	pci_epf_clean_dma_chan(epf_test);
 	pci_epc_stop(epc);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		epf_bar = &epf->bar[bar];
@@ -550,6 +743,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		}
 	}
 
+	epf_test->dma_supported = true;
+
+	ret = pci_epf_init_dma_chan(epf_test);
+	if (ret)
+		epf_test->dma_supported = false;
+
 	if (linkup_notifier) {
 		epf->nb.notifier_call = pci_epf_test_notifier;
 		pci_epc_register_notifier(epc, &epf->nb);
-- 
2.17.1

