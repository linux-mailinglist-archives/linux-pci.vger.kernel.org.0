Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C019F1ACE2C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 18:57:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732832AbgDPQ52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 12:57:28 -0400
Received: from mail-il-dmz.mellanox.com ([193.47.165.129]:39020 "EHLO
        mellanox.co.il" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1731440AbgDPQ51 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 16 Apr 2020 12:57:27 -0400
Received: from Internal Mail-Server by MTLPINE1 (envelope-from maxg@mellanox.com)
        with ESMTPS (AES256-SHA encrypted); 16 Apr 2020 19:57:25 +0300
Received: from mtr-vdi-031.wap.labs.mlnx. (mtr-vdi-031.wap.labs.mlnx [10.209.102.136])
        by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id 03GGvPXp002050;
        Thu, 16 Apr 2020 19:57:25 +0300
From:   Max Gurtovoy <maxg@mellanox.com>
To:     linux-pci@vger.kernel.org, hch@lst.de
Cc:     fbarrat@linux.ibm.com, clsoto@us.ibm.com, idanw@mellanox.com,
        maxg@mellanox.com, aneela@mellanox.com, shlomin@mellanox.com
Subject: [PATCH 1/2] powerpc/dma: Define map/unmap mmio resource callbacks
Date:   Thu, 16 Apr 2020 19:57:24 +0300
Message-Id: <20200416165725.206741-1-maxg@mellanox.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Define the map_resource/unmap_resource callbacks for the dma_iommu_ops
used by several powerpc platforms. The map_resource callback is called
when trying to map a mmio resource through the dma_map_resource()
driver API.

For now, the callback returns an invalid address for devices using
translations, but will "direct" map the resource when in bypass
mode. Previous behavior for dma_map_resource() was to always return an
invalid address.

We also call an optional platform-specific controller op in
case some setup is needed for the platform.

Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 arch/powerpc/include/asm/pci-bridge.h |  6 ++++++
 arch/powerpc/kernel/dma-iommu.c       | 35 +++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/powerpc/include/asm/pci-bridge.h b/arch/powerpc/include/asm/pci-bridge.h
index 69f4cb3..d14b4ee 100644
--- a/arch/powerpc/include/asm/pci-bridge.h
+++ b/arch/powerpc/include/asm/pci-bridge.h
@@ -44,6 +44,12 @@ struct pci_controller_ops {
 #endif
 
 	void		(*shutdown)(struct pci_controller *hose);
+	int		(*dma_map_resource)(struct pci_dev *pdev,
+					    phys_addr_t phys_addr, size_t size,
+					    enum dma_data_direction dir);
+	void		(*dma_unmap_resource)(struct pci_dev *pdev,
+					      dma_addr_t addr, size_t size,
+					      enum dma_data_direction dir);
 };
 
 /*
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index e486d1d..dc53acc 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -108,6 +108,39 @@ static void dma_iommu_unmap_sg(struct device *dev, struct scatterlist *sglist,
 		dma_direct_unmap_sg(dev, sglist, nelems, direction, attrs);
 }
 
+static dma_addr_t dma_iommu_map_resource(struct device *dev,
+					 phys_addr_t phys_addr, size_t size,
+					 enum dma_data_direction dir,
+					 unsigned long attrs)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_controller *phb = pci_bus_to_host(pdev->bus);
+
+	if (dma_iommu_map_bypass(dev, attrs)) {
+		if (phb->controller_ops.dma_map_resource &&
+		    phb->controller_ops.dma_map_resource(pdev, phys_addr, size,
+							 dir))
+			return DMA_MAPPING_ERROR;
+		return dma_direct_map_resource(dev, phys_addr, size,
+					       dir, attrs);
+	}
+	return DMA_MAPPING_ERROR;
+}
+
+static void dma_iommu_unmap_resource(struct device *dev, dma_addr_t dma_handle,
+				     size_t size, enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct pci_controller *phb = pci_bus_to_host(pdev->bus);
+
+	if (dma_iommu_map_bypass(dev, attrs)) {
+		if (phb->controller_ops.dma_unmap_resource)
+			phb->controller_ops.dma_unmap_resource(pdev, dma_handle,
+							size, dir);
+	}
+}
+
 static bool dma_iommu_bypass_supported(struct device *dev, u64 mask)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
@@ -199,6 +232,8 @@ extern void dma_iommu_sync_sg_for_device(struct device *dev,
 	.free			= dma_iommu_free_coherent,
 	.map_sg			= dma_iommu_map_sg,
 	.unmap_sg		= dma_iommu_unmap_sg,
+	.map_resource		= dma_iommu_map_resource,
+	.unmap_resource		= dma_iommu_unmap_resource,
 	.dma_supported		= dma_iommu_dma_supported,
 	.map_page		= dma_iommu_map_page,
 	.unmap_page		= dma_iommu_unmap_page,
-- 
1.8.3.1

