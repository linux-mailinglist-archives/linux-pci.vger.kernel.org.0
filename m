Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABB611E2CD9
	for <lists+linux-pci@lfdr.de>; Tue, 26 May 2020 21:18:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391997AbgEZTNo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 26 May 2020 15:13:44 -0400
Received: from rnd-relay.smtp.broadcom.com ([192.19.229.170]:46206 "EHLO
        rnd-relay.smtp.broadcom.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2391173AbgEZTNm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 26 May 2020 15:13:42 -0400
Received: from mail-irv-17.broadcom.com (mail-irv-17.lvn.broadcom.net [10.75.242.48])
        by rnd-relay.smtp.broadcom.com (Postfix) with ESMTP id 43D5430D64C;
        Tue, 26 May 2020 12:13:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 rnd-relay.smtp.broadcom.com 43D5430D64C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1590520421;
        bh=AriK1NG87ZP5xbZZLs45I9ity+OqGcVezhDeyT3A91M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iAQGoOHfVWnQdrqOFiyoMOh6ZwAmNICLhoLV9Io/Vy4j+GREamlBNlyFf9ZtNT4fK
         c/MYDrOPasRa+Aje2nM3fHOpKsHdU757VFLNnGuObTx8Ibk/nLEMwIEWw6jwELn6yt
         pYiexCaP0qjxIqm01yifk+r5uootcBD3LZ6s/A6U=
Received: from stbsrv-and-01.and.broadcom.net (stbsrv-and-01.and.broadcom.net [10.28.16.211])
        by mail-irv-17.broadcom.com (Postfix) with ESMTP id E1083140069;
        Tue, 26 May 2020 12:13:39 -0700 (PDT)
From:   Jim Quinlan <james.quinlan@broadcom.com>
To:     linux-pci@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        bcm-kernel-feedback-list@broadcom.com, james.quinlan@broadcom.com
Cc:     Russell King <linux@armlinux.org.uk>,
        Julien Grall <julien.grall@arm.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org (moderated list:ARM PORT),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 10/14] arm: dma-mapping: Invoke dma offset func if needed
Date:   Tue, 26 May 2020 15:12:49 -0400
Message-Id: <20200526191303.1492-11-james.quinlan@broadcom.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200526191303.1492-1-james.quinlan@broadcom.com>
References: <20200526191303.1492-1-james.quinlan@broadcom.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Just like dma_pfn_offset, another offset is added to the dma/phys
translation if there happen to be multiple regions that have different
mapping offsets.

Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
---
 arch/arm/include/asm/dma-mapping.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index bdd80ddbca34..811389b4fb29 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -35,8 +35,12 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 #ifndef __arch_pfn_to_dma
 static inline dma_addr_t pfn_to_dma(struct device *dev, unsigned long pfn)
 {
-	if (dev)
+	if (dev) {
+		/* This should compile out if !CONFIG_DMA_PFN_OFFSET_MAP */
+		pfn -= dma_pfn_offset_from_phys_addr(dev, PFN_PHYS(pfn));
+
 		pfn -= dev->dma_pfn_offset;
+	}
 	return (dma_addr_t)__pfn_to_bus(pfn);
 }
 
@@ -44,9 +48,12 @@ static inline unsigned long dma_to_pfn(struct device *dev, dma_addr_t addr)
 {
 	unsigned long pfn = __bus_to_pfn(addr);
 
-	if (dev)
-		pfn += dev->dma_pfn_offset;
+	if (dev) {
+		/* This should compile out if !CONFIG_DMA_PFN_OFFSET_MAP */
+		pfn += dma_pfn_offset_from_dma_addr(dev, addr);
 
+		pfn += dev->dma_pfn_offset;
+	}
 	return pfn;
 }
 
-- 
2.17.1

