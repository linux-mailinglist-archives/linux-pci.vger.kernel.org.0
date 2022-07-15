Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65639576486
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 17:36:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234928AbiGOPgr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 11:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235010AbiGOPgn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 11:36:43 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EEB5A2D1
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 08:36:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17242B82D11
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 15:36:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F0BC3411E;
        Fri, 15 Jul 2022 15:36:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657899399;
        bh=2dlhaiT/PHyRwDrAtnA08dgWECmHLItKNahH8WkarKE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h4trP2ob4A2ErmThvl4gd1T45jmNOHpJkkmZ1awCz0oVwyj3JrvX4aII3IAojU2cY
         KAL8JO4lD+5wrEwZermgbP2S6YQntn1mltQMgzIsNlxZCIOJXSSMZy41QDCWvhoDin
         WTJLS8uD2tqzjUjc81LhSAPt+6xIZ+FVx1QtG+itb+vj9LiJDiNlOnIMDp9YHYY+IP
         8hYbSXLqvxjc4bjlzYzlS84ICY7j+AKCltICffaAqHt47At18N6HHVY1jMkg+siLay
         YtRjbWZ4ccJ+VXGhP3pkiFebBRkZtEvZi0UCdnOeOYBuKMZsws2SZSYVWV4auPNq4U
         ZkfDrh/37CVxg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH 2/2] [RFC] sparc: Use generic pci_mmap_resource_range()
Date:   Fri, 15 Jul 2022 17:36:17 +0200
Message-Id: <20220715153617.3393420-2-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220715153617.3393420-1-arnd@kernel.org>
References: <20220715153617.3393420-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The main feature of the sparc specific implementation of
pci_mmap_resource_range() is that it allows mapping the entire PCI
I/O space for a PCI host bridge using the /proc/bus/pci interface on a
bridge device.

The generic implementation cannot do this, but it also appears that this
got broken for sparc by commit 9eff02e2042f ("PCI: check mmap range of
/proc/bus/pci files too"), which enforces that each address is part of
a BAR for kernels after 2.6.28.

Remove it all, assuming that the corresponding user space code has
already been changed to access /dev/ioport instead a long time ago.
The pci_iobar_pfn() function needs to be added to make it possible
to map I/O resources. This is adapted from the powerpc version.

Link: https://lore.kernel.org/lkml/1519887203.622.3.camel@infradead.org/t/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
It's quite possible that I missed something important, but it
appears that David Miller was thinking of the pre-2.6.28 behavior
that was already broken when David Woodhouse sent his series.
---
 arch/sparc/include/asm/pci.h |   1 +
 arch/sparc/kernel/pci.c      | 154 +----------------------------------
 2 files changed, 5 insertions(+), 150 deletions(-)

diff --git a/arch/sparc/include/asm/pci.h b/arch/sparc/include/asm/pci.h
index 4deddf430e5d..dff90dce6cb7 100644
--- a/arch/sparc/include/asm/pci.h
+++ b/arch/sparc/include/asm/pci.h
@@ -37,6 +37,7 @@ static inline int pci_proc_domain(struct pci_bus *bus)
 #define HAVE_PCI_MMAP
 #define arch_can_pci_mmap_io()	1
 #define HAVE_ARCH_PCI_GET_UNMAPPED_AREA
+#define ARCH_GENERIC_PCI_MMAP_RESOURCE
 #define get_pci_unmapped_area get_fb_unmapped_area
 #endif /* CONFIG_SPARC64 */
 
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index f580db840bf7..cb1ef25116e9 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -751,161 +751,15 @@ int pcibios_enable_device(struct pci_dev *dev, int mask)
 }
 
 /* Platform support for /proc/bus/pci/X/Y mmap()s. */
-
-/* If the user uses a host-bridge as the PCI device, he may use
- * this to perform a raw mmap() of the I/O or MEM space behind
- * that controller.
- *
- * This can be useful for execution of x86 PCI bios initialization code
- * on a PCI card, like the xfree86 int10 stuff does.
- */
-static int __pci_mmap_make_offset_bus(struct pci_dev *pdev, struct vm_area_struct *vma,
-				      enum pci_mmap_state mmap_state)
+int pci_iobar_pfn(struct pci_dev *pdev, int bar, struct vm_area_struct *vma)
 {
 	struct pci_pbm_info *pbm = pdev->dev.archdata.host_controller;
-	unsigned long space_size, user_offset, user_size;
-
-	if (mmap_state == pci_mmap_io) {
-		space_size = resource_size(&pbm->io_space);
-	} else {
-		space_size = resource_size(&pbm->mem_space);
-	}
-
-	/* Make sure the request is in range. */
-	user_offset = vma->vm_pgoff << PAGE_SHIFT;
-	user_size = vma->vm_end - vma->vm_start;
+	resource_size_t ioaddr = pci_resource_start(pdev, bar);
 
-	if (user_offset >= space_size ||
-	    (user_offset + user_size) > space_size)
+	if (!pbm)
 		return -EINVAL;
 
-	if (mmap_state == pci_mmap_io) {
-		vma->vm_pgoff = (pbm->io_space.start +
-				 user_offset) >> PAGE_SHIFT;
-	} else {
-		vma->vm_pgoff = (pbm->mem_space.start +
-				 user_offset) >> PAGE_SHIFT;
-	}
-
-	return 0;
-}
-
-/* Adjust vm_pgoff of VMA such that it is the physical page offset
- * corresponding to the 32-bit pci bus offset for DEV requested by the user.
- *
- * Basically, the user finds the base address for his device which he wishes
- * to mmap.  They read the 32-bit value from the config space base register,
- * add whatever PAGE_SIZE multiple offset they wish, and feed this into the
- * offset parameter of mmap on /proc/bus/pci/XXX for that device.
- *
- * Returns negative error code on failure, zero on success.
- */
-static int __pci_mmap_make_offset(struct pci_dev *pdev,
-				  struct vm_area_struct *vma,
-				  enum pci_mmap_state mmap_state)
-{
-	unsigned long user_paddr, user_size;
-	int i, err;
-
-	/* First compute the physical address in vma->vm_pgoff,
-	 * making sure the user offset is within range in the
-	 * appropriate PCI space.
-	 */
-	err = __pci_mmap_make_offset_bus(pdev, vma, mmap_state);
-	if (err)
-		return err;
-
-	/* If this is a mapping on a host bridge, any address
-	 * is OK.
-	 */
-	if ((pdev->class >> 8) == PCI_CLASS_BRIDGE_HOST)
-		return err;
-
-	/* Otherwise make sure it's in the range for one of the
-	 * device's resources.
-	 */
-	user_paddr = vma->vm_pgoff << PAGE_SHIFT;
-	user_size = vma->vm_end - vma->vm_start;
-
-	for (i = 0; i <= PCI_ROM_RESOURCE; i++) {
-		struct resource *rp = &pdev->resource[i];
-		resource_size_t aligned_end;
-
-		/* Active? */
-		if (!rp->flags)
-			continue;
-
-		/* Same type? */
-		if (i == PCI_ROM_RESOURCE) {
-			if (mmap_state != pci_mmap_mem)
-				continue;
-		} else {
-			if ((mmap_state == pci_mmap_io &&
-			     (rp->flags & IORESOURCE_IO) == 0) ||
-			    (mmap_state == pci_mmap_mem &&
-			     (rp->flags & IORESOURCE_MEM) == 0))
-				continue;
-		}
-
-		/* Align the resource end to the next page address.
-		 * PAGE_SIZE intentionally added instead of (PAGE_SIZE - 1),
-		 * because actually we need the address of the next byte
-		 * after rp->end.
-		 */
-		aligned_end = (rp->end + PAGE_SIZE) & PAGE_MASK;
-
-		if ((rp->start <= user_paddr) &&
-		    (user_paddr + user_size) <= aligned_end)
-			break;
-	}
-
-	if (i > PCI_ROM_RESOURCE)
-		return -EINVAL;
-
-	return 0;
-}
-
-/* Set vm_page_prot of VMA, as appropriate for this architecture, for a pci
- * device mapping.
- */
-static void __pci_mmap_set_pgprot(struct pci_dev *dev, struct vm_area_struct *vma,
-					     enum pci_mmap_state mmap_state)
-{
-	/* Our io_remap_pfn_range takes care of this, do nothing.  */
-}
-
-/* Perform the actual remap of the pages for a PCI device mapping, as appropriate
- * for this architecture.  The region in the process to map is described by vm_start
- * and vm_end members of VMA, the BAR relative address is found in vm_pgoff.
- * The pci device structure is provided so that architectures may make mapping
- * decisions on a per-device or per-bus basis.
- *
- * Returns a negative error code on failure, zero on success.
- */
-int pci_mmap_resource_range(struct pci_dev *dev, int bar,
-			    struct vm_area_struct *vma,
-			    enum pci_mmap_state mmap_state, int write_combine)
-{
-	int ret;
-	resource_size_t start, end;
-
-	/* convert per-BAR address to PCI bus address */
-	pci_resource_to_user(dev, bar, &dev->resource[bar], &start, &end);
-	vma->vm_pgoff += start >> PAGE_SHIFT;
-
-	ret = __pci_mmap_make_offset(dev, vma, mmap_state);
-	if (ret < 0)
-		return ret;
-
-	__pci_mmap_set_pgprot(dev, vma, mmap_state);
-
-	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
-	ret = io_remap_pfn_range(vma, vma->vm_start,
-				 vma->vm_pgoff,
-				 vma->vm_end - vma->vm_start,
-				 vma->vm_page_prot);
-	if (ret)
-		return ret;
+	vma->vm_pgoff += (ioaddr + pbm->io_space.start) >> PAGE_SHIFT;
 
 	return 0;
 }
-- 
2.29.2

