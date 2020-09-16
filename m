Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9401E26BC9D
	for <lists+linux-pci@lfdr.de>; Wed, 16 Sep 2020 08:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726385AbgIPGTv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Sep 2020 02:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbgIPGTe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Sep 2020 02:19:34 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B509C06174A;
        Tue, 15 Sep 2020 23:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=OKUyp8qmBFdjgjSYZqN9BFape1Q+ujb81GF9JqUrmy4=; b=iv+7DX+SEc3dNxqeIV8/nkfVbB
        b8Lum5kjOnVL9p18MOyOEipnedUAVsZV998T08r8nDJ02qfiuI/OgxE6TrNC1S/sLldjIpqNBxhiw
        MA3WIZB3Y4Zzb/Hk6uowbpUfXK9eR3CMyPDDGitUJIey9L4b8l93eS6J6bspuTpwC4xJ85gf6KbPf
        bVB8wuuk2DiR3MiZ5+m9zHgRDn6NFKEb9pbvhd9oRnAcmCJDWr66tQ9dczrwhPtFFS2fb/z2L+Etj
        MH01yErQGFs2r2jEivDe8YxNcCLorZwZ3us0tOZdbOVFAw7gUguBFGXYXX0YwNXWa827pKuo7Uftf
        hSyixgbw==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kIQmo-0006uo-Dj; Wed, 16 Sep 2020 06:19:22 +0000
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
Subject: [PATCH 1/6] ARM/dma-mapping: remove a __arch_page_to_dma #error
Date:   Wed, 16 Sep 2020 08:14:54 +0200
Message-Id: <20200916061500.1970090-2-hch@lst.de>
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

The __arch_page_to_dma hook is long gone.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/include/asm/dma-mapping.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/include/asm/dma-mapping.h b/arch/arm/include/asm/dma-mapping.h
index bdd80ddbca3451..70d95677656044 100644
--- a/arch/arm/include/asm/dma-mapping.h
+++ b/arch/arm/include/asm/dma-mapping.h
@@ -23,10 +23,6 @@ static inline const struct dma_map_ops *get_arch_dma_ops(struct bus_type *bus)
 	return NULL;
 }
 
-#ifdef __arch_page_to_dma
-#error Please update to __arch_pfn_to_dma
-#endif
-
 /*
  * dma_to_pfn/pfn_to_dma/dma_to_virt/virt_to_dma are architecture private
  * functions used internally by the DMA-mapping API to provide DMA
-- 
2.28.0

