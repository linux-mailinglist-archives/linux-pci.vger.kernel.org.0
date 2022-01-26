Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61ADA49D2BC
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 20:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244552AbiAZTvG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 14:51:06 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:62469 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S244546AbiAZTvF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 14:51:05 -0500
X-IronPort-AV: E=Sophos;i="5.88,319,1635174000"; 
   d="scan'208";a="108403300"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 27 Jan 2022 04:51:04 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 1F1FF4008541;
        Thu, 27 Jan 2022 04:51:00 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh@kernel.org>, linux-pci@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [RFC PATCH 2/5] PCI: endpoint: Add support to data transfer using internal dmac
Date:   Wed, 26 Jan 2022 19:50:40 +0000
Message-Id: <20220126195043.28376-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20220126195043.28376-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

For PCIe EP capable with internal DMAC, transfer data using this
when -d option is used with pcitest.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 184 ++++++++++++++----
 1 file changed, 141 insertions(+), 43 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 90d84d3bc868..f792b1a15c44 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -55,6 +55,7 @@ struct pci_epf_test {
 	struct dma_chan		*dma_chan;
 	struct completion	transfer_complete;
 	bool			dma_supported;
+	bool			internal_dmac;
 	const struct pci_epc_features *epc_features;
 };
 
@@ -148,6 +149,40 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 	return 0;
 }
 
+/**
+ * pci_epf_test_internal_dmac_data_transfer() - Function that uses internal DMAC
+ *				to transfer data between PCIe EP and remote PCIe RC
+ * @epf_test: the EPF test device that performs the data transfer operation
+ * @dma_dst: The destination address of the data transfer. It can be a physical
+ *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
+ * @dma_src: The source address of the data transfer. It can be a physical
+ *	     address given by pci_epc_mem_alloc_addr or DMA mapping APIs.
+ * @len: The size of the data transfer
+ * @dir: Direction of data transfer
+ *
+ * Function that uses internal dmac supported by the controller to transfer data
+ * between PCIe EP and remote PCIe RC.
+ *
+ * The function returns '0' on success and negative value on failure.
+ */
+static int
+pci_epf_test_internal_dmac_data_transfer(struct pci_epf_test *epf_test,
+					 dma_addr_t dma_dst, dma_addr_t dma_src,
+					 size_t len, enum pci_epf_xfr_direction dir)
+{
+	struct pci_epf *epf = epf_test->epf;
+	int ret;
+
+	if (!epf_test->internal_dmac)
+		return -EINVAL;
+
+	ret = pci_epf_internal_dmac_xfr(epf, dma_dst, dma_src, len, dir);
+	if (ret)
+		return -EIO;
+
+	return 0;
+}
+
 /**
  * pci_epf_test_init_dma_chan() - Function to initialize EPF test DMA channel
  * @epf_test: the EPF test device that performs data transfer operation
@@ -238,6 +273,14 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	struct pci_epc *epc = epf->epc;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	bool internal_dmac = epf_test->internal_dmac;
+
+	use_dma = !!(reg->flags & FLAG_USE_DMA);
+
+	if (use_dma && internal_dmac) {
+		dev_err(dev, "Operation not supported\n");
+		return -EINVAL;
+	}
 
 	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
 	if (!src_addr) {
@@ -272,7 +315,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 	}
 
 	ktime_get_ts64(&start);
-	use_dma = !!(reg->flags & FLAG_USE_DMA);
 	if (use_dma) {
 		if (!epf_test->dma_supported) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
@@ -322,31 +364,49 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	bool internal_dmac = epf_test->internal_dmac;
 
-	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
-	if (!src_addr) {
-		dev_err(dev, "Failed to allocate address\n");
-		reg->status = STATUS_SRC_ADDR_INVALID;
-		ret = -ENOMEM;
-		goto err;
-	}
+	use_dma = !!(reg->flags & FLAG_USE_DMA);
 
-	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
-			       reg->src_addr, reg->size);
-	if (ret) {
-		dev_err(dev, "Failed to map address\n");
-		reg->status = STATUS_SRC_ADDR_INVALID;
-		goto err_addr;
+	if (use_dma && internal_dmac) {
+		phys_addr = reg->src_addr;
+		src_addr = NULL;
+	} else {
+		src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
+		if (!src_addr) {
+			dev_err(dev, "Failed to allocate address\n");
+			reg->status = STATUS_SRC_ADDR_INVALID;
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
+				       reg->src_addr, reg->size);
+		if (ret) {
+			dev_err(dev, "Failed to map address\n");
+			reg->status = STATUS_SRC_ADDR_INVALID;
+			goto err_addr;
+		}
 	}
 
-	buf = kzalloc(reg->size, GFP_KERNEL);
+	if (use_dma && internal_dmac)
+		buf = dma_alloc_coherent(dev, reg->size, &dst_phys_addr, GFP_KERNEL | GFP_DMA);
+	else
+		buf = kzalloc(reg->size, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto err_map_addr;
 	}
 
-	use_dma = !!(reg->flags & FLAG_USE_DMA);
-	if (use_dma) {
+	if (use_dma && internal_dmac) {
+		ktime_get_ts64(&start);
+		ret = pci_epf_test_internal_dmac_data_transfer(epf_test, dst_phys_addr,
+							       phys_addr, reg->size,
+							       PCIE_TO_INTERNAL);
+		if (ret)
+			dev_err(dev, "Data transfer failed\n");
+		ktime_get_ts64(&end);
+	} else if (use_dma) {
 		if (!epf_test->dma_supported) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
 			ret = -EINVAL;
@@ -383,13 +443,18 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		ret = -EIO;
 
 err_dma_map:
-	kfree(buf);
+	if (use_dma && internal_dmac)
+		dma_free_coherent(dev, reg->size, buf, dst_phys_addr);
+	else
+		kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
+	if (!(use_dma && internal_dmac))
+		pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
 
 err_addr:
-	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
+	if (!(use_dma && internal_dmac))
+		pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
 
 err:
 	return ret;
@@ -410,24 +475,36 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	bool internal_dmac = epf_test->internal_dmac;
 
-	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
-	if (!dst_addr) {
-		dev_err(dev, "Failed to allocate address\n");
-		reg->status = STATUS_DST_ADDR_INVALID;
-		ret = -ENOMEM;
-		goto err;
-	}
+	use_dma = !!(reg->flags & FLAG_USE_DMA);
 
-	ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
-			       reg->dst_addr, reg->size);
-	if (ret) {
-		dev_err(dev, "Failed to map address\n");
-		reg->status = STATUS_DST_ADDR_INVALID;
-		goto err_addr;
+	if (use_dma && internal_dmac) {
+		phys_addr = reg->dst_addr;
+		dst_addr = NULL;
+	} else {
+		dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
+		if (!dst_addr) {
+			dev_err(dev, "Failed to allocate address\n");
+			reg->status = STATUS_DST_ADDR_INVALID;
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		ret = pci_epc_map_addr(epc, epf->func_no, epf->vfunc_no, phys_addr,
+				       reg->dst_addr, reg->size);
+		if (ret) {
+			dev_err(dev, "Failed to map address\n");
+			reg->status = STATUS_DST_ADDR_INVALID;
+			goto err_addr;
+		}
 	}
 
-	buf = kzalloc(reg->size, GFP_KERNEL);
+	if (use_dma && internal_dmac)
+		buf = dma_alloc_coherent(dev, reg->size,
+					 &src_phys_addr, GFP_KERNEL | GFP_DMA);
+	else
+		buf = kzalloc(reg->size, GFP_KERNEL);
 	if (!buf) {
 		ret = -ENOMEM;
 		goto err_map_addr;
@@ -436,8 +513,15 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	get_random_bytes(buf, reg->size);
 	reg->checksum = crc32_le(~0, buf, reg->size);
 
-	use_dma = !!(reg->flags & FLAG_USE_DMA);
-	if (use_dma) {
+	if (use_dma && internal_dmac) {
+		ktime_get_ts64(&start);
+		ret = pci_epf_test_internal_dmac_data_transfer(epf_test, phys_addr,
+							       src_phys_addr, reg->size,
+							       INTERNAL_TO_PCIE);
+		if (ret)
+			dev_err(dev, "Data transfer failed\n");
+		ktime_get_ts64(&end);
+	} else if (use_dma) {
 		if (!epf_test->dma_supported) {
 			dev_err(dev, "Cannot transfer data using DMA\n");
 			ret = -EINVAL;
@@ -476,13 +560,18 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	usleep_range(1000, 2000);
 
 err_dma_map:
-	kfree(buf);
+	if (use_dma && internal_dmac)
+		dma_free_coherent(dev, reg->size, buf, src_phys_addr);
+	else
+		kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
+	if (!(use_dma && internal_dmac))
+		pci_epc_unmap_addr(epc, epf->func_no, epf->vfunc_no, phys_addr);
 
 err_addr:
-	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
+	if (!(use_dma && internal_dmac))
+		pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
 
 err:
 	return ret;
@@ -838,6 +927,7 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	struct pci_epc *epc = epf->epc;
 	bool linkup_notifier = false;
 	bool core_init_notifier = false;
+	struct device *dev = &epf->dev;
 
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
@@ -857,6 +947,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 
 	epf_test->test_reg_bar = test_reg_bar;
 	epf_test->epc_features = epc_features;
+	epf_test->internal_dmac = epc_features->internal_dmac;
+	if (epf_test->internal_dmac && epc_features->internal_dmac_mask) {
+		ret = dma_set_coherent_mask(dev, epc_features->internal_dmac_mask);
+		if (ret)
+			return ret;
+	}
 
 	ret = pci_epf_test_alloc_space(epf);
 	if (ret)
@@ -868,11 +964,13 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 			return ret;
 	}
 
-	epf_test->dma_supported = true;
+	epf_test->dma_supported = false;
 
-	ret = pci_epf_test_init_dma_chan(epf_test);
-	if (ret)
-		epf_test->dma_supported = false;
+	if (!epf_test->internal_dmac) {
+		ret = pci_epf_test_init_dma_chan(epf_test);
+		if (!ret)
+			epf_test->dma_supported = true;
+	}
 
 	if (linkup_notifier) {
 		epf->nb.notifier_call = pci_epf_test_notifier;
-- 
2.25.1

