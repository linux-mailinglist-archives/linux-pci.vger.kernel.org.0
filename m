Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1FE61869E5
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 12:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730799AbgCPLUC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 07:20:02 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47026 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730560AbgCPLUC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 07:20:02 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02GBJpIR040976;
        Mon, 16 Mar 2020 06:19:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584357591;
        bh=UykINQPVtXaMUOuZ44R2qSdR2FiWKOj/1P7fqQORzi4=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=ZSArFkqtIWKBaHJwiuhDeBHvYYpQ45OKx1/V94CY0Pl3U1S5JssDfJ7si+rpZoRpw
         V1om3CVxXWo7KZurOCe2HqNXYIwWvypH+Eqfs6DYORcfvCz7GDX0hDGK+RChu/VERi
         4oRbL7yEWmjXQenQSuvOSMmTwH9eDlOvGMUAZKWc=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02GBJp1g001539;
        Mon, 16 Mar 2020 06:19:51 -0500
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Mar 2020 06:19:50 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Mar 2020 06:19:50 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02GBJiTw049775;
        Mon, 16 Mar 2020 06:19:48 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v3 1/5] PCI: endpoint: functions/pci-epf-test: Add DMA support to transfer data
Date:   Mon, 16 Mar 2020 16:54:20 +0530
Message-ID: <20200316112424.25295-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200316112424.25295-1-kishon@ti.com>
References: <20200316112424.25295-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Use dmaengine API and add support for transferring data using DMA.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Tested-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 205 +++++++++++++++++-
 1 file changed, 202 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index bddff15052cc..c9d9d1780e66 100644
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
+ * pci_epf_test_data_transfer() - Function that uses dmaengine API to transfer
+ *				  data between PCIe EP and remote PCIe RC
+ * @epf_test: the EPF test device that performs the data transfer operation
+ * @dma_dst: The destination address of the data transfer. It can be a physical
+ *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
+ * @dma_src: The source address of the data transfer. It can be a physical
+ *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
+ * @len: The size of the data transfer
+ *
+ * Function that uses dmaengine API to transfer data between PCIe EP and remote
+ * PCIe RC. The source and destination address can be a physical address given
+ * by pci_epc_mem_alloc_addr or the one obtained using DMA mapping APIs.
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
+ * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
+ * @epf_test: the EPF test device that performs data transfer operation
+ *
+ * Function to initialize EPF test DMA channel.
+ */
+static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
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
+ * pci_epf_test_clean_dma_chan() - Function to cleanup EPF test DMA channel
+ * @epf: the EPF test device that performs data transfer operation
+ *
+ * Helper to cleanup EPF test DMA channel.
+ */
+static void pci_epf_test_clean_dma_chan(struct pci_epf_test *epf_test)
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
+	pci_epf_test_clean_dma_chan(epf_test);
 	pci_epc_stop(epc);
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
 		epf_bar = &epf->bar[bar];
@@ -550,6 +743,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		}
 	}
 
+	epf_test->dma_supported = true;
+
+	ret = pci_epf_test_init_dma_chan(epf_test);
+	if (ret)
+		epf_test->dma_supported = false;
+
 	if (linkup_notifier) {
 		epf->nb.notifier_call = pci_epf_test_notifier;
 		pci_epc_register_notifier(epc, &epf->nb);
-- 
2.17.1

