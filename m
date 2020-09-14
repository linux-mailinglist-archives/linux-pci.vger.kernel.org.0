Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95E1E268658
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 09:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726050AbgINHoq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 03:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725968AbgINHop (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 03:44:45 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8974CC06174A;
        Mon, 14 Sep 2020 00:44:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=rZz7WEucbLzmcSBpKZVSsyybm+o08I+OYE053DvRjjM=; b=t4keXE5TDnxAHF6g8hogs4VgZL
        ULo2k/B8+ruC5jsQr27s/sQblW82iX+G9AIpOhhy6JQY5XjSgIU2JThFVtAqqJOprPd9Y1mcTxzFJ
        7xexc8gEJwRKQ68VQSDLyUs1lCl/V0ZwaUXP7JJpJhCHRS7vhIr1gvV2PwcjkInHgO6yQUAvm/Qi0
        L9HoU2awqpjY9vMbIUOhixXqveqkDZy0oProfsCjI+Yzty2QtJxZmUDWg4i0FDGXer1pmo6yH1+6/
        sda/7CKX4v4tUq/CEuOgohNyWCKUA6LPDJuza3QFbgZSg55jsHqgvpUvIsbRnDSKiqAu4+j++J2ey
        YPPprpGA==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHjAE-0000Rh-Gw; Mon, 14 Sep 2020 07:44:38 +0000
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
Subject: [PATCH 4/6] ARM/keystone: move the DMA offset handling under ifdef CONFIG_ARM_LPAE
Date:   Mon, 14 Sep 2020 09:33:41 +0200
Message-Id: <20200914073343.1579578-5-hch@lst.de>
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

The DMA offset notifier can only be used if PHYS_OFFSET is at least
KEYSTONE_HIGH_PHYS_START, which can't be represented by a 32-bit
phys_addr_t.  Currently the code compiles fine despite that, a pending
change to the DMA offset handling would create a compiler warning for
this case.  Add an ifdef to not compile the code except for LPAE
configs.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Robin Murphy <robin.murphy@arm.com>
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

