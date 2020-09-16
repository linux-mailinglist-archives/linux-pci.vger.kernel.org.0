Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D63C26BCDC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 08:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIPGXz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 02:23:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726193AbgIPGXw (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 02:23:52 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1FFC06174A;
        Tue, 15 Sep 2020 23:23:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=BxxgQYY1DeDYvu2hSRXigNNS2r5IsjvTJ3A6Bx2A/Zo=; b=b6RjMPuXBPV1L2xq/9cSN/gZIL
        pDJ+Ogdkdog3WRMBnL/liSbsVIm+1nFp14fjm5I64vhHz9+kGkq0qLF52sisZUBwipshSOdD0191S
        VDdtGyd17p1iEYZLfSzwwXKxUhaHHAG+JvnN90NH93XE9E1hMEzKe71YVfkU0Dgg62wMVl8xjEoCf
        5+m431sx66nExg52nA9tSj2LwJS3c1e1Xw0Q+eWPX44rHDpNRvMcn6HNNZ0sDFWW7GknRQkxrzcVY
        Z2Jlrh0MAymYlnYS9SkQSDh9shV3+9w6+Qb0BsQMvh0xi5T5YgBzH+zZViLK00ocpbknb5tvsu620
        cDacfLGA==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIQr2-0007LO-Jc; Wed, 16 Sep 2020 06:23:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-remoteproc@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH 3/6] ARM/dma-mapping: move various helpers from dma-mapping.h to dma-direct.h
Date:   Wed, 16 Sep 2020 08:14:56 +0200
Message-Id: <20200916061500.1970090-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916061500.1970090-1-hch@lst.de>
References: <20200916061500.1970090-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the helpers to translate to and from direct mapping DMA addresses
to dma-direct.h.  This not only is the most logical place, but the new
placement also avoids dependency loops with pending commits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
---
 arch/arm/common/dmabounce.c        |  2 +-
 arch/arm/include/asm/dma-direct.h  | 50 ++++++++++++++++++++++++++++++
 arch/arm/include/asm/dma-mapping.h | 50 ------------------------------
 3 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/arch/arm/common/dmabounce.c b/arch/arm/common/dmabounce.c
index f4b719bde76367..d3e00ea9208834 100644
--- a/arch/arm/common/dmabounce.c
+++ b/arch/arm/common/dmabounce.c
@@ -24,7 +24,7 @@
 #include <linux/slab.h>
 #include <linux/page-flags.h>
 #include <linux/device.h>
-#include <linux/dma-mapping.h>
+#include <linux/dma-direct.h>
 #include <linux/dmapool.h>
 #include <linux/list.h>
 #include <linux/scatterlist.h>
diff --git a/arch/arm/include/asm/dma-direct.h b/arch/arm/include/asm/dma-direct.h
index bca0de56753439..fbcf4367b5cb1a 100644
--- a/arch/arm/include/asm/dma-direct.h
+++ b/arch/arm/include/asm/dma-direct.h
@@ -2,6 +2,56 @@
 #ifndef ASM_ARM_DMA_DIRECT_H
 #define ASM_ARM_DMA_DIRECT_H 1
 
+#include <asm/memory.h>
+
+/*
+ * dma_to_pfn/pfn_to_dma/virt_to_dma are architecture private
+ * functions used internally by the DMA-mapping API to provide DMA
+ * addresses. They must not be used by drivers.
+ */
+#ifndef __arch_pfn_to_dma
+static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
+{
+	if (dev)
+		pfn -= dev->dma_pfn_offset;
+	return (dma_addr_t)__pfn_to_bus(pfn);
+}
+
+static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
+{
+	unsigned long pfn = __bus_to_pfn(addr);
+
+	if (dev)
+		pfn += dev->dma_pfn_offset;
+
+	return pfn;
+}
+
+static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
+{
+	if (dev)
+		return pfn_to_dma(dev, virt_to_pfn(addr));
+
+	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
+}
+
+#else
+static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
+{
+	return __arch_pfn_to_dma(dev, pfn);
+}
+
+static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
+{
+	return __arch_dma_to_pfn(dev, addr);
+}
+
+static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
+{
+	return __arch_virt_to_dma(dev, addr);
+}
+#endif
+
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
 {
 	unsigned int offset = paddr & ~PAGE_MASK;
diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index cf2535fb8891f5..0a1a536368c3a4 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -8,8 +8,6 @@
 #include <linux/scatterlist.h>
 #include <linux/dma-debug.h>
 
-#include <asm/memory.h>
-
 #include <xen/xen.h>
 #include <asm/xen/hypervisor.h>
 
@@ -23,54 +21,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-/*
- * dma_to_pfn/pfn_to_dma/virt_to_dma are architecture private
- * functions used internally by the DMA-mapping API to provide DMA
- * addresses. They must not be used by drivers.
- */
-#ifndef __arch_pfn_to_dma
-static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	if (dev)
-		pfn -= dev->dma_pfn_offset;
-	return (dma_addr_t)__pfn_to_bus(pfn);
-}
-
-static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
-{
-	unsigned long pfn = __bus_to_pfn(addr);
-
-	if (dev)
-		pfn += dev->dma_pfn_offset;
-
-	return pfn;
-}
-
-static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
-{
-	if (dev)
-		return pfn_to_dma(dev, virt_to_pfn(addr));
-
-	return (dma_addr_t)__virt_to_bus((unsigned long)(addr));
-}
-
-#else
-static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
-{
-	return __arch_pfn_to_dma(dev, pfn);
-}
-
-static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
-{
-	return __arch_dma_to_pfn(dev, addr);
-}
-
-static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
-{
-	return __arch_virt_to_dma(dev, addr);
-}
-#endif
-
 /**
  * arm_dma_alloc - allocate consistent memory for DMA
  * @dev: valid struct device pointer, or NULL for ISA and EISA-like devices
-- 
2.28.0

