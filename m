Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFB9845FB89
	for <lists+linux-pci@lfdr.de>; Sat, 27 Nov 2021 02:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348420AbhK0ByM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 26 Nov 2021 20:54:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348611AbhK0BwM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 26 Nov 2021 20:52:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652E2C07E5F2;
        Fri, 26 Nov 2021 17:25:51 -0800 (PST)
Message-ID: <20211126230525.548258086@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637976120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wJMUpNJgyC/5WRXAWU3ClvJ2/7JlSux0SjtaYWx+PkY=;
        b=KQsa8LeGEIc57Zd72m+GDIhPhh9BEWKrWT9ndfo4FnxNx6PgLPBEwnJHQuA2z1bZWZZD55
        JBVlXSyvJvd8nN+OqteD7p3iGqg6vrfZ/MMhG0V12X0SoW2ATWmXKwWUlOnCYkwnZ4AJ9U
        YoCwu9PiBRYGbYpkTu9q/FktsXn0gGArcxZIOKE4g8laR+yjUZMxizsSXF1hqWQ7QotPTQ
        QatZbkDn2u8nxM6JDymH30x5c7tqyCRgzvX5xHeiZ/IJlcWH0K3GpdtZ8vietOUQIjsHWk
        7mdt0a3422lv7plj4XYvor02IIjLBIszdSdEk1yTygqlBL4DuMz3Z28AMAqW2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637976120;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wJMUpNJgyC/5WRXAWU3ClvJ2/7JlSux0SjtaYWx+PkY=;
        b=wrK2XP1liHb3vRlxhPoxTVijz8zP9SFoLxf1mYgefbvDCuYqen1QbPjKa6eoz8vzzoP044
        kqqRCttaEHnmYABQ==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Marc Zygnier <maz@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Megha Dey <megha.dey@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        iommu@lists.linux-foundation.org, dmaengine@vger.kernel.org,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        Vinod Koul <vkoul@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will@kernel.org>, Sinan Kaya <okaya@kernel.org>
Subject: [patch 27/37] powerpc/pseries/msi: Let core code check for contiguous entries
References: <20211126224100.303046749@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 27 Nov 2021 02:22:00 +0100 (CET)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Set the domain info flag and remove the check.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/powerpc/platforms/pseries/msi.c |   32 +++++++++-----------------------
 1 file changed, 9 insertions(+), 23 deletions(-)

--- a/arch/powerpc/platforms/pseries/msi.c
+++ b/arch/powerpc/platforms/pseries/msi.c
@@ -321,27 +321,6 @@ static int msi_quota_for_device(struct p
 	return request;
 }
 
-static int check_msix_entries(struct pci_dev *pdev)
-{
-	struct msi_desc *entry;
-	int expected;
-
-	/* There's no way for us to express to firmware that we want
-	 * a discontiguous, or non-zero based, range of MSI-X entries.
-	 * So we must reject such requests. */
-
-	expected = 0;
-	for_each_pci_msi_entry(entry, pdev) {
-		if (entry->msi_index != expected) {
-			pr_debug("rtas_msi: bad MSI-X entries.\n");
-			return -EINVAL;
-		}
-		expected++;
-	}
-
-	return 0;
-}
-
 static void rtas_hack_32bit_msi_gen2(struct pci_dev *pdev)
 {
 	u32 addr_hi, addr_lo;
@@ -380,7 +359,7 @@ static int rtas_prepare_msi_irqs(struct
 	if (quota && quota < nvec)
 		return quota;
 
-	if (type == PCI_CAP_ID_MSIX && check_msix_entries(pdev))
+	if (type == PCI_CAP_ID_MSIX)
 		return -EINVAL;
 
 	/*
@@ -530,9 +509,16 @@ static struct irq_chip pseries_pci_msi_i
 	.irq_write_msi_msg	= pseries_msi_write_msg,
 };
 
+
+/*
+ * Set MSI_FLAG_MSIX_CONTIGUOUS as there is no way to express to
+ * firmware to request a discontiguous or non-zero based range of
+ * MSI-X entries. Core code will reject such setup attempts.
+ */
 static struct msi_domain_info pseries_msi_domain_info = {
 	.flags = (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX),
+		  MSI_FLAG_MULTI_PCI_MSI  | MSI_FLAG_PCI_MSIX |
+		  MSI_FLAG_MSIX_CONTIGUOUS),
 	.ops   = &pseries_pci_msi_domain_ops,
 	.chip  = &pseries_pci_msi_irq_chip,
 };

