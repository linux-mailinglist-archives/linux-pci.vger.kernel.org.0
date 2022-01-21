Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093E74966A3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jan 2022 21:51:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232026AbiAUUv4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 21 Jan 2022 15:51:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231881AbiAUUvz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 21 Jan 2022 15:51:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C16C06173D;
        Fri, 21 Jan 2022 12:51:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7D7C6179B;
        Fri, 21 Jan 2022 20:51:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A5DC340E7;
        Fri, 21 Jan 2022 20:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642798314;
        bh=SVl6//wpXfUNsqiviayEYDCQfk3rcNjw29GFyV3RJxU=;
        h=From:To:Cc:Subject:Date:From;
        b=NwNDuXjTFw9dFgUTKSFzekZNyRYCcGLRph1m533ktEtw9X/hg82lL5WI51UgXoD1C
         oFVXf3fwv3wMy4zTb4OTcGcMLGKvhpMWT0xW+KCD7+iRXHW2HATohbo7uXPTxUttXH
         0v3gc6mqmHBOrJ1yJl8Y+cAlHuhOIkXAE+WnPdxeTjxhCoo5rvIGX94lGULyx17Ou8
         u+bTlXE2ItLx325BWmuvG9b9zMXCUHC/3+0O1YtIs1x3mSrLl/B0B9osfFbE4DYL2x
         dmysUlkSl3Hv/URKHc9RXXXvEOqoCHzwtNHIBA0QlBxC9TG5XnHotHdjXy39q7O9Ti
         0VCCmWDnMcpjQ==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Michal Simek <monstr@monstr.eu>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v1] microblaze/PCI: Remove pci_phys_mem_access_prot() dead code
Date:   Fri, 21 Jan 2022 14:51:50 -0600
Message-Id: <20220121205150.1151607-1-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

pci_phys_mem_access_prot() is defined but never used.  Remove it.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 arch/microblaze/include/asm/pci.h |  4 ---
 arch/microblaze/pci/pci-common.c  | 49 -------------------------------
 2 files changed, 53 deletions(-)

diff --git a/arch/microblaze/include/asm/pci.h b/arch/microblaze/include/asm/pci.h
index 7c4dc5d85f53..d90528064604 100644
--- a/arch/microblaze/include/asm/pci.h
+++ b/arch/microblaze/include/asm/pci.h
@@ -61,10 +61,6 @@ extern int pci_mmap_legacy_page_range(struct pci_bus *bus,
 extern void pcibios_resource_survey(void);
 
 struct file;
-extern pgprot_t	pci_phys_mem_access_prot(struct file *file,
-					 unsigned long pfn,
-					 unsigned long size,
-					 pgprot_t prot);
 
 /* This part of code was originally in xilinx-pci.h */
 #ifdef CONFIG_PCI_XILINX
diff --git a/arch/microblaze/pci/pci-common.c b/arch/microblaze/pci/pci-common.c
index 622a4867f9e9..33bab7eec731 100644
--- a/arch/microblaze/pci/pci-common.c
+++ b/arch/microblaze/pci/pci-common.c
@@ -165,55 +165,6 @@ int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
 	return 0;
 }
 
-/*
- * This one is used by /dev/mem and fbdev who have no clue about the
- * PCI device, it tries to find the PCI device first and calls the
- * above routine
- */
-pgprot_t pci_phys_mem_access_prot(struct file *file,
-				  unsigned long pfn,
-				  unsigned long size,
-				  pgprot_t prot)
-{
-	struct pci_dev *pdev = NULL;
-	struct resource *found = NULL;
-	resource_size_t offset = ((resource_size_t)pfn) << PAGE_SHIFT;
-	int i;
-
-	if (page_is_ram(pfn))
-		return prot;
-
-	prot = pgprot_noncached(prot);
-	for_each_pci_dev(pdev) {
-		for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-			struct resource *rp = &pdev->resource[i];
-			int flags = rp->flags;
-
-			/* Active and same type? */
-			if ((flags & IORESOURCE_MEM) == 0)
-				continue;
-			/* In the range of this resource? */
-			if (offset < (rp->start & PAGE_MASK) ||
-			    offset > rp->end)
-				continue;
-			found = rp;
-			break;
-		}
-		if (found)
-			break;
-	}
-	if (found) {
-		if (found->flags & IORESOURCE_PREFETCH)
-			prot = pgprot_noncached_wc(prot);
-		pci_dev_put(pdev);
-	}
-
-	pr_debug("PCI: Non-PCI map for %llx, prot: %lx\n",
-		 (unsigned long long)offset, pgprot_val(prot));
-
-	return prot;
-}
-
 /* This provides legacy IO read access on a bus */
 int pci_legacy_read(struct pci_bus *bus, loff_t port, u32 *val, size_t size)
 {
-- 
2.25.1

