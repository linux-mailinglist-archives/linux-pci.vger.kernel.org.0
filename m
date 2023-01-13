Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519CA66A050
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 18:23:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbjAMRXD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 12:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjAMRWJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 12:22:09 -0500
Received: from post.baikalelectronics.com (post.baikalelectronics.com [213.79.110.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1B2DA089A;
        Fri, 13 Jan 2023 09:14:21 -0800 (PST)
Received: from post.baikalelectronics.com (localhost.localdomain [127.0.0.1])
        by post.baikalelectronics.com (Proxmox) with ESMTP id 0B5FFE0F1E;
        Fri, 13 Jan 2023 20:14:21 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        baikalelectronics.ru; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:from:from:in-reply-to:message-id
        :mime-version:references:reply-to:subject:subject:to:to; s=post;
         bh=1xwlqi+1yG9XUYgfYmvYbTkqdXEIk68+v81jHV+J+18=; b=sWjVUqg0z4FH
        U7SWH+DmbCfPbtFx5A9tVaHh+wQU9AaQl1bBuTxxhQjBkVXN58jvMH3c0lwImsB7
        fMFQqZMYL9J+0QDPEb+VqjMIwUABzsTj1h8zhNTB1RJySx67rpTxg64mx/D0nScg
        +FaB2xC0lPvoD/OCyKCySWM7Ie8gMRI=
Received: from mail.baikal.int (mail.baikal.int [192.168.51.25])
        by post.baikalelectronics.com (Proxmox) with ESMTP id ED2E7E0F13;
        Fri, 13 Jan 2023 20:14:20 +0300 (MSK)
Received: from localhost (10.8.30.26) by mail (192.168.51.25) with Microsoft
 SMTP Server (TLS) id 15.0.1395.4; Fri, 13 Jan 2023 20:14:20 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Vinod Koul <vkoul@kernel.org>, Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        Robin Murphy <robin.murphy@arm.com>,
        Jingoo Han <jingoohan1@gmail.com>, Frank Li <Frank.Li@nxp.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        caihuoqing <caihuoqing@baidu.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        <linux-pci@vger.kernel.org>, <dmaengine@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
Subject: [PATCH v9 03/27] dmaengine: dw-edma: Convert ll/dt phys-address to PCIe bus/DMA address
Date:   Fri, 13 Jan 2023 20:13:45 +0300
Message-ID: <20230113171409.30470-4-Sergey.Semin@baikalelectronics.ru>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
References: <20230113171409.30470-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.8.30.26]
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In accordance with the dw_edma_region.paddr field semantics it is supposed
to be initialized with a memory base address visible by the DW eDMA
controller. If the DMA engine is embedded into the DW PCIe Host/EP
controller, then the address should belong to the Local CPU/Application
memory. If eDMA is remotely accessible across the PCIe bus via the PCIe
memory IOs, then the address needs to be a part of the PCIe bus memory
space. The later case hasn't been well covered in the corresponding
glue-driver. Since in general the PCIe memory space doesn't have to match
the CPU memory space and the pci_dev.resource[] arrays contain the
resources defined in the CPU memory space, a proper conversion needs to be
performed, otherwise either the driver won't properly work or much worse
the memory corruption will happen. The conversion can be done by means of
the pci_bus_address() method. Let's use it to retrieve the LL, DT and CSRs
PCIe memory ranges.

Note in addition to that we need to extend the dw_edma_region.paddr field
size. The field normally contains a memory range base address to be set in
the DW eDMA Linked-List pointer register or as a base address of the
Linked-List data buffer. In accordance with [1] the LL range is supposed
to be created in the Local CPU/Application memory, but depending on the DW
eDMA utilization the memory can be created as a part of the PCIe bus
address space (as in the case of the DW PCIe EP prototype kit). Thus in
the former case the dw_edma_region.paddr field should have the dma_addr_t
type, while in the later one - pci_bus_addr_t. Seeing the corresponding
CSRs are always 64-bits wide let's convert the dw_edma_region.paddr field
type to be u64 and let the client code logic to make sure it has a valid
address visible by the DW eDMA controller. For instance the DW eDMA PCIe
glue-driver initializes the field with the addresses from the PCIe bus
memory space.

[1] DesignWare Cores PCI Express Controller Databook - DWC PCIe Root Port,
    v.5.40a, March 2019, p.1103

Fixes: 41aaff2a2ac0 ("dmaengine: Add Synopsys eDMA IP PCIe glue-logic")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Tested-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Vinod Koul <vkoul@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-pcie.c | 8 ++++----
 include/linux/dma/edma.h           | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-pcie.c b/drivers/dma/dw-edma/dw-edma-pcie.c
index d6b5e2463884..04c95cba1244 100644
--- a/drivers/dma/dw-edma/dw-edma-pcie.c
+++ b/drivers/dma/dw-edma/dw-edma-pcie.c
@@ -231,7 +231,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr += ll_block->off;
-		ll_region->paddr = pdev->resource[ll_block->bar].start;
+		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -240,7 +240,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr += dt_block->off;
-		dt_region->paddr = pdev->resource[dt_block->bar].start;
+		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
@@ -256,7 +256,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		ll_region->vaddr += ll_block->off;
-		ll_region->paddr = pdev->resource[ll_block->bar].start;
+		ll_region->paddr = pci_bus_address(pdev, ll_block->bar);
 		ll_region->paddr += ll_block->off;
 		ll_region->sz = ll_block->sz;
 
@@ -265,7 +265,7 @@ static int dw_edma_pcie_probe(struct pci_dev *pdev,
 			return -ENOMEM;
 
 		dt_region->vaddr += dt_block->off;
-		dt_region->paddr = pdev->resource[dt_block->bar].start;
+		dt_region->paddr = pci_bus_address(pdev, dt_block->bar);
 		dt_region->paddr += dt_block->off;
 		dt_region->sz = dt_block->sz;
 	}
diff --git a/include/linux/dma/edma.h b/include/linux/dma/edma.h
index 7d8062e9c544..a864978ddd27 100644
--- a/include/linux/dma/edma.h
+++ b/include/linux/dma/edma.h
@@ -18,7 +18,7 @@
 struct dw_edma;
 
 struct dw_edma_region {
-	phys_addr_t	paddr;
+	u64		paddr;
 	void __iomem	*vaddr;
 	size_t		sz;
 };
-- 
2.39.0


