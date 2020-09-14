Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54F42268640
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 09:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725999AbgINHkZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 03:40:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbgINHkY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 03:40:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23A5C06174A;
        Mon, 14 Sep 2020 00:40:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=m2uI/54b6zhcK5JH2Qkk+DNhltSMOgJF9o6JCspd/6M=; b=V9WRKrWMbS/Pw5aOnQOrYjrdVI
        ZbvSca4rQofspafvq5fqw7JXd5Alt/v7rsNdTXCZuY41+QJPockPjspbkuctRZgBXGxqJuKWxEn4O
        Ad/mMESvpm6ndMm7D+bJOh1j44XyiCz5nFHdE4r1X2e3kPuqp3ps2fiQIx4r8dOLOgC0oBa6pcQ3D
        3smyizrG3e4oGEmRhzG1djOB0eHWYcjkINxaKZaK7CRXaPGyDu8fvsPRJYtUyo8eImRwq0uofrb0M
        A6iW3pGZDYLiNQGRBD1uMqEGXXzUZ5kR7YhMUkpxeIbCiL8LywRq72ebHPHto7OwcercW2QuyJWA4
        pK0DXiUQ==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHj60-0000Ds-AY; Mon, 14 Sep 2020 07:40:16 +0000
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
Subject: [PATCH 2/6] ARM/dma-mapping: remove dma_to_virt
Date:   Mon, 14 Sep 2020 09:33:39 +0200
Message-Id: <20200914073343.1579578-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914073343.1579578-1-hch@lst.de>
References: <20200914073343.1579578-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

dma_to_virt is entirely unused, remove it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h        | 18 +-----------------
 arch/arm/mach-omap1/include/mach/memory.h |  4 ----
 2 files changed, 1 insertion(+), 21 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index 70d95677656044..cf2535fb8891f5 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -24,7 +24,7 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 }
 
 /*
- * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
+ * dma_to_pfn/pfn_to_dma/virt_to_dma are architecture private
  * functions used internally by the DMA-mapping API to provide DMA
  * addresses. They must not be used by drivers.
  */
@@ -46,17 +46,6 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 	return pfn;
 }
 
-static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
-{
-	if (dev) {
-		unsigned long pfn = dma_to_pfn(dev, addr);
-
-		return phys_to_virt(__pfn_to_phys(pfn));
-	}
-
-	return (void *)__bus_to_virt((unsigned long)addr);
-}
-
 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 {
 	if (dev)
@@ -76,11 +65,6 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 	return __arch_dma_to_pfn(dev, addr);
 }
 
-static inline void *dma_to_virt(struct device *dev, dma_addr_t addr)
-{
-	return __arch_dma_to_virt(dev, addr);
-}
-
 static inline dma_addr_t virt_to_dma(struct device *dev, void *addr)
 {
 	return __arch_virt_to_dma(dev, addr);
diff --git a/arch/arm/mach-omap1/include/mach/memory.h b/arch/arm/mach-omap1/include/mach/memory.h
index 1142560e0078f5..e43697c3297bf2 100644
--- a/arch/arm/mach-omap1/include/mach/memory.h
+++ b/arch/arm/mach-omap1/include/mach/memory.h
@@ -41,10 +41,6 @@
 	   __phys_to_pfn(__dma);				\
 	})
 
-#define __arch_dma_to_virt(dev, addr)	({ (void *) (is_lbus_device(dev) ? \
-						lbus_to_virt(addr) : \
-						__phys_to_virt(addr)); })
-
 #define __arch_virt_to_dma(dev, addr)	({ unsigned long __addr = (unsigned long)(addr); \
 					   (dma_addr_t) (is_lbus_device(dev) ? \
 						virt_to_lbus(__addr) : \
-- 
2.28.0

