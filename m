Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8CC1869EE
	for <lists+linux-pci@lfdr.de>; Mon, 16 Mar 2020 12:20:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730832AbgCPLUd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Mar 2020 07:20:33 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:47064 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730783AbgCPLUc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Mar 2020 07:20:32 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 02GBJvTe040985;
        Mon, 16 Mar 2020 06:19:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1584357597;
        bh=gTIw0Kq1JaHQ/hJkzc67wdeMK2eHR10J/tTFD8B+hek=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=t1fjiQrnwr+ztwM0Wy+P1/ctCdE5yxSfA1Q6GEOX7wXDIHkFV6ek0UwBvdxEL8NWo
         FcXieHdr+2A+3YqMV93eRSAPmMxb1LboHPATcJEIVAp4V6fVmO0chIgFZOZy3dO0u5
         W60i9wHTjoWajXctHD2DHCSHvRsSPY60ewPJgv/w=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 02GBJvoF017219
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 16 Mar 2020 06:19:57 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 16
 Mar 2020 06:19:57 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 16 Mar 2020 06:19:57 -0500
Received: from a0393678ub.india.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 02GBJiU0049775;
        Mon, 16 Mar 2020 06:19:54 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Andrew Murray <amurray@thegoodpenguin.co.uk>,
        Alan Mikhak <alan.mikhak@sifive.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     Tom Joseph <tjoseph@cadence.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Sekhar Nori <nsekhar@ti.com>
Subject: [PATCH v3 3/5] misc: pci_endpoint_test: Use streaming DMA APIs for buffer allocation
Date:   Mon, 16 Mar 2020 16:54:22 +0530
Message-ID: <20200316112424.25295-4-kishon@ti.com>
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

Use streaming DMA APIs (dma_map_single/dma_unmap_single) for buffers
transmitted/received by the endpoint device instead of allocating
a coherent memory. Also add default_data to set the alignment to
4KB since dma_map_single might not return a 4KB aligned address.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Tested-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/misc/pci_endpoint_test.c | 100 ++++++++++++++++++++++++-------
 1 file changed, 79 insertions(+), 21 deletions(-)

diff --git a/drivers/misc/pci_endpoint_test.c b/drivers/misc/pci_endpoint_test.c
index a5e317073d95..5998df1c84e9 100644
--- a/drivers/misc/pci_endpoint_test.c
+++ b/drivers/misc/pci_endpoint_test.c
@@ -341,14 +341,22 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 		goto err;
 	}
 
-	orig_src_addr = dma_alloc_coherent(dev, size + alignment,
-					   &orig_src_phys_addr, GFP_KERNEL);
+	orig_src_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_src_addr) {
 		dev_err(dev, "Failed to allocate source buffer\n");
 		ret = false;
 		goto err;
 	}
 
+	get_random_bytes(orig_src_addr, size + alignment);
+	orig_src_phys_addr = dma_map_single(dev, orig_src_addr,
+					    size + alignment, DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, orig_src_phys_addr)) {
+		dev_err(dev, "failed to map source buffer address\n");
+		ret = false;
+		goto err_src_phys_addr;
+	}
+
 	if (alignment && !IS_ALIGNED(orig_src_phys_addr, alignment)) {
 		src_phys_addr = PTR_ALIGN(orig_src_phys_addr, alignment);
 		offset = src_phys_addr - orig_src_phys_addr;
@@ -364,15 +372,21 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_UPPER_SRC_ADDR,
 				 upper_32_bits(src_phys_addr));
 
-	get_random_bytes(src_addr, size);
 	src_crc32 = crc32_le(~0, src_addr, size);
 
-	orig_dst_addr = dma_alloc_coherent(dev, size + alignment,
-					   &orig_dst_phys_addr, GFP_KERNEL);
+	orig_dst_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_dst_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
 		ret = false;
-		goto err_orig_src_addr;
+		goto err_dst_addr;
+	}
+
+	orig_dst_phys_addr = dma_map_single(dev, orig_dst_addr,
+					    size + alignment, DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, orig_dst_phys_addr)) {
+		dev_err(dev, "failed to map destination buffer address\n");
+		ret = false;
+		goto err_dst_phys_addr;
 	}
 
 	if (alignment && !IS_ALIGNED(orig_dst_phys_addr, alignment)) {
@@ -399,16 +413,22 @@ static bool pci_endpoint_test_copy(struct pci_endpoint_test *test, size_t size)
 
 	wait_for_completion(&test->irq_raised);
 
+	dma_unmap_single(dev, orig_dst_phys_addr, size + alignment,
+			 DMA_FROM_DEVICE);
+
 	dst_crc32 = crc32_le(~0, dst_addr, size);
 	if (dst_crc32 == src_crc32)
 		ret = true;
 
-	dma_free_coherent(dev, size + alignment, orig_dst_addr,
-			  orig_dst_phys_addr);
+err_dst_phys_addr:
+	kfree(orig_dst_addr);
 
-err_orig_src_addr:
-	dma_free_coherent(dev, size + alignment, orig_src_addr,
-			  orig_src_phys_addr);
+err_dst_addr:
+	dma_unmap_single(dev, orig_src_phys_addr, size + alignment,
+			 DMA_TO_DEVICE);
+
+err_src_phys_addr:
+	kfree(orig_src_addr);
 
 err:
 	return ret;
@@ -436,14 +456,23 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 		goto err;
 	}
 
-	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
-				       GFP_KERNEL);
+	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate address\n");
 		ret = false;
 		goto err;
 	}
 
+	get_random_bytes(orig_addr, size + alignment);
+
+	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
+					DMA_TO_DEVICE);
+	if (dma_mapping_error(dev, orig_phys_addr)) {
+		dev_err(dev, "failed to map source buffer address\n");
+		ret = false;
+		goto err_phys_addr;
+	}
+
 	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
 		phys_addr =  PTR_ALIGN(orig_phys_addr, alignment);
 		offset = phys_addr - orig_phys_addr;
@@ -453,8 +482,6 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 		addr = orig_addr;
 	}
 
-	get_random_bytes(addr, size);
-
 	crc32 = crc32_le(~0, addr, size);
 	pci_endpoint_test_writel(test, PCI_ENDPOINT_TEST_CHECKSUM,
 				 crc32);
@@ -477,7 +504,11 @@ static bool pci_endpoint_test_write(struct pci_endpoint_test *test, size_t size)
 	if (reg & STATUS_READ_SUCCESS)
 		ret = true;
 
-	dma_free_coherent(dev, size + alignment, orig_addr, orig_phys_addr);
+	dma_unmap_single(dev, orig_phys_addr, size + alignment,
+			 DMA_TO_DEVICE);
+
+err_phys_addr:
+	kfree(orig_addr);
 
 err:
 	return ret;
@@ -504,14 +535,21 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 		goto err;
 	}
 
-	orig_addr = dma_alloc_coherent(dev, size + alignment, &orig_phys_addr,
-				       GFP_KERNEL);
+	orig_addr = kzalloc(size + alignment, GFP_KERNEL);
 	if (!orig_addr) {
 		dev_err(dev, "Failed to allocate destination address\n");
 		ret = false;
 		goto err;
 	}
 
+	orig_phys_addr = dma_map_single(dev, orig_addr, size + alignment,
+					DMA_FROM_DEVICE);
+	if (dma_mapping_error(dev, orig_phys_addr)) {
+		dev_err(dev, "failed to map source buffer address\n");
+		ret = false;
+		goto err_phys_addr;
+	}
+
 	if (alignment && !IS_ALIGNED(orig_phys_addr, alignment)) {
 		phys_addr = PTR_ALIGN(orig_phys_addr, alignment);
 		offset = phys_addr - orig_phys_addr;
@@ -535,11 +573,15 @@ static bool pci_endpoint_test_read(struct pci_endpoint_test *test, size_t size)
 
 	wait_for_completion(&test->irq_raised);
 
+	dma_unmap_single(dev, orig_phys_addr, size + alignment,
+			 DMA_FROM_DEVICE);
+
 	crc32 = crc32_le(~0, addr, size);
 	if (crc32 == pci_endpoint_test_readl(test, PCI_ENDPOINT_TEST_CHECKSUM))
 		ret = true;
 
-	dma_free_coherent(dev, size + alignment, orig_addr, orig_phys_addr);
+err_phys_addr:
+	kfree(orig_addr);
 err:
 	return ret;
 }
@@ -667,6 +709,12 @@ static int pci_endpoint_test_probe(struct pci_dev *pdev,
 	init_completion(&test->irq_raised);
 	mutex_init(&test->mutex);
 
+	if ((dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(48)) != 0) &&
+	    dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32)) != 0) {
+		dev_err(dev, "Cannot set DMA mask\n");
+		return -EINVAL;
+	}
+
 	err = pci_enable_device(pdev);
 	if (err) {
 		dev_err(dev, "Cannot enable PCI device\n");
@@ -783,6 +831,12 @@ static void pci_endpoint_test_remove(struct pci_dev *pdev)
 	pci_disable_device(pdev);
 }
 
+static const struct pci_endpoint_test_data default_data = {
+	.test_reg_bar = BAR_0,
+	.alignment = SZ_4K,
+	.irq_type = IRQ_TYPE_MSI,
+};
+
 static const struct pci_endpoint_test_data am654_data = {
 	.test_reg_bar = BAR_2,
 	.alignment = SZ_64K,
@@ -790,8 +844,12 @@ static const struct pci_endpoint_test_data am654_data = {
 };
 
 static const struct pci_device_id pci_endpoint_test_tbl[] = {
-	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x) },
-	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA74x),
+	  .driver_data = (kernel_ulong_t)&default_data,
+	},
+	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_DRA72x),
+	  .driver_data = (kernel_ulong_t)&default_data,
+	},
 	{ PCI_DEVICE(PCI_VENDOR_ID_FREESCALE, 0x81c0) },
 	{ PCI_DEVICE_DATA(SYNOPSYS, EDDA, NULL) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_TI, PCI_DEVICE_ID_TI_AM654),
-- 
2.17.1

