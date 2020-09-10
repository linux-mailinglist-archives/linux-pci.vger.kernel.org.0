Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0652D263C93
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 07:41:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbgIJFlC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 01:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725855AbgIJFkx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 01:40:53 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4389C061756;
        Wed,  9 Sep 2020 22:40:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=jUBa0iu1eX5jIcAMx7CVSwzh+xe4DajZ3p568CeYFVQ=; b=kah51+ShOTTV+Jr+aRlgd0UmMs
        NcPtLrFn4E7MudK1Si/fT7/TqxK5SWVfKBVWRLJ8+JXu/KdY+ku4LFycLe+BAZegN1VB+rAFo76U3
        S177eVeSuDFVbkgbXgW0Sqyz3T3mkIm7NOn80nM5T/BGthD1RASCpvExnNdOBjrnYuw6+AB/Sa2Q+
        ckdaHE+5oXGeq3oExrsn4dz+C7/TGleVTseKtHQJPCdiCPjhMrCwXAfn7da2bLCiIDf0F7/L+sWzn
        +4HLw8QEwdsFmUsWlbEg59eM7RHmgcuGNXffoy8tU/lFefCjWvyaTfcdBvtznJphl6AMvKHV8R+WY
        hRZEQN4w==;
Received: from [2001:4bb8:184:af1:d8d0:3027:a666:4c4e] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kGFK5-0001tZ-IQ; Thu, 10 Sep 2020 05:40:42 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     iommu@lists.linux-foundation.org,
        Russell King <linux@armlinux.org.uk>,
        Santosh Shilimkar <ssantosh@kernel.org>
Cc:     Jim Quinlan <james.quinlan@broadcom.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH 2/3] ARM/keystone: move the DMA offset handling under ifdef CONFIG_ARM_LPAE
Date:   Thu, 10 Sep 2020 07:40:37 +0200
Message-Id: <20200910054038.324517-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200910054038.324517-1-hch@lst.de>
References: <20200910054038.324517-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The DMA offset notifier can only be used if PHYS_OFFSET is at least
KEYSTONE_HIGH_PHYS_START, which can't be represented by a 32-bit
phys_addr_t.  Currently the code compiles fine despite that, a pending
change to the DMA offset handling would create a compiler warning for
this case.  Add an ifdef to not compile the code except for LPAE
configs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/mach-keystone/keystone.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/mach-keystone/keystone.c b/arch/arm/mach-keystone/keystone.c
index 638808c4e12247..dcd031ba84c2e0 100644
--- a/arch/arm/mach-keystone/keystone.c
+++ b/arch/arm/mach-keystone/keystone.c
@@ -24,6 +24,7 @@
 
 #include "keystone.h"
 
+#ifdef CONFIG_ARM_LPAE
 static unsigned long keystone_dma_pfn_offset __read_mostly;
 
 static int keystone_platform_notifier(struct notifier_block *nb,
@@ -48,14 +49,17 @@ static int keystone_platform_notifier(struct notifier_block *nb,
 static struct notifier_block platform_nb = {
 	.notifier_call = keystone_platform_notifier,
 };
+#endif /* CONFIG_ARM_LPAE */
 
 static void __init keystone_init(void)
 {
+#ifdef CONFIG_ARM_LPAE
 	if (PHYS_OFFSET >= KEYSTONE_HIGH_PHYS_START) {
 		keystone_dma_pfn_offset = PFN_DOWN(KEYSTONE_HIGH_PHYS_START -
 						   KEYSTONE_LOW_PHYS_START);
 		bus_register_notifier(&platform_bus_type, &platform_nb);
 	}
+#endif
 	keystone_pm_runtime_init();
 }
 
-- 
2.28.0

