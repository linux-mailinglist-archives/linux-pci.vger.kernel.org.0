Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7991F576485
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 17:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233147AbiGOPgl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jul 2022 11:36:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiGOPgj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jul 2022 11:36:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0F3B57E17
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 08:36:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 721E5620A7
        for <linux-pci@vger.kernel.org>; Fri, 15 Jul 2022 15:36:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CA7CC34115;
        Fri, 15 Jul 2022 15:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657899397;
        bh=PmEcMeAJDQN00oV2AMtEy6Zd1MxvU5nx0IC3yGDIuGU=;
        h=From:To:Cc:Subject:Date:From;
        b=JLAr7/iifA4e6fFyE7OYXkD6mQeNPW6UJ/OyANbSlj8GMcObMgEk1ODm+gQKgQHE5
         14bhRGHfSKs7DyphVSsX2K2M3+zdJVWPJnrmNeF9qa9kJKLXdrHrzoFivs+T45CpYj
         9cdnMthsVWFgJA8lKt0Br/VOXWF5KSHRqALvSDbrumh/nFUVmqxkXpSCTp1zAzzaDd
         dsVKSYgRmx1qUgmsrXd41KuczxxeQFnSrgGAwra2J/Ya3lzJbPTwLeRLxNSqjGoAfL
         JPPAHQ94jIcSDdWD+gP9E9qQh1uHy0V8V10ZR9l0+5v12HLTVnxtpwV6fUgEhMP+xc
         t36NKcCW7VQAQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-pci@vger.kernel.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, Arnd Bergmann <arnd@arndb.de>,
        David Woodhouse <dwmw2@infradead.org>,
        "David S . Miller" <davem@davemloft.net>,
        Stafford Horne <shorne@gmail.com>
Subject: [PATCH 1/2] pci: remove pci_mmap_page_range wrapper
Date:   Fri, 15 Jul 2022 17:36:16 +0200
Message-Id: <20220715153617.3393420-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
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

The ARCH_GENERIC_PCI_MMAP_RESOURCE symbol came up in a recent discussion,
and I noticed that this was left behind by an unfinished cleanup from
2017.

The only architecture that still relies on providing its
own pci_mmap_page_range() helper instead of using the generic
pci_mmap_resource_range() is sparc. Presumably the reasons for this have
not changed, but at least this can be simplified by converting sparc to
use the same interface as the others.

The only difference between the two is the device specific offset that
gets added to or subtracted from vma->vm_pgoff.

Change the only caller of pci_mmap_page_range() in common code to subtract
this offset and call the modern interface, while adding it back in the
sparc implementation to preserve the existing behavior.

This removes the complexities of the dual interfaces from the common code,
and keeps it all specific to the sparc architecture code. According to
David Miller, the sparc code lets user space poke into the VGA I/O port
registers by mmapping the I/O space of the parent bridge device, which is
something that the generic pci_mmap_resource_range() code apparently
does not.

Cc: David Woodhouse <dwmw2@infradead.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Stafford Horne <shorne@gmail.com>
Link: https://lore.kernel.org/lkml/1519887203.622.3.camel@infradead.org/t/
Link: https://lore.kernel.org/lkml/20220714214657.2402250-3-shorne@gmail.com/
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/PCI/sysfs-pci.rst |  2 +-
 arch/sparc/kernel/pci.c         | 13 +++++++---
 drivers/pci/mmap.c              | 44 ---------------------------------
 drivers/pci/proc.c              |  7 +++++-
 include/linux/pci.h             | 12 +--------
 5 files changed, 17 insertions(+), 61 deletions(-)

diff --git a/Documentation/PCI/sysfs-pci.rst b/Documentation/PCI/sysfs-pci.rst
index 742fbd21dc1f..f495185aa88a 100644
--- a/Documentation/PCI/sysfs-pci.rst
+++ b/Documentation/PCI/sysfs-pci.rst
@@ -125,7 +125,7 @@ implementation of that functionality. To support the historical interface of
 mmap() through files in /proc/bus/pci, platforms may also set HAVE_PCI_MMAP.
 
 Alternatively, platforms which set HAVE_PCI_MMAP may provide their own
-implementation of pci_mmap_page_range() instead of defining
+implementation of pci_mmap_resource_range() instead of defining
 ARCH_GENERIC_PCI_MMAP_RESOURCE.
 
 Platforms which support write-combining maps of PCI resources must define
diff --git a/arch/sparc/kernel/pci.c b/arch/sparc/kernel/pci.c
index 31b0c1983286..f580db840bf7 100644
--- a/arch/sparc/kernel/pci.c
+++ b/arch/sparc/kernel/pci.c
@@ -876,17 +876,22 @@ static void __pci_mmap_set_pgprot(struct pci_dev *dev, struct vm_area_struct *vm
 
 /* Perform the actual remap of the pages for a PCI device mapping, as appropriate
  * for this architecture.  The region in the process to map is described by vm_start
- * and vm_end members of VMA, the base physical address is found in vm_pgoff.
+ * and vm_end members of VMA, the BAR relative address is found in vm_pgoff.
  * The pci device structure is provided so that architectures may make mapping
  * decisions on a per-device or per-bus basis.
  *
  * Returns a negative error code on failure, zero on success.
  */
-int pci_mmap_page_range(struct pci_dev *dev, int bar,
-			struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
+int pci_mmap_resource_range(struct pci_dev *dev, int bar,
+			    struct vm_area_struct *vma,
+			    enum pci_mmap_state mmap_state, int write_combine)
 {
 	int ret;
+	resource_size_t start, end;
+
+	/* convert per-BAR address to PCI bus address */
+	pci_resource_to_user(dev, bar, &dev->resource[bar], &start, &end);
+	vma->vm_pgoff += start >> PAGE_SHIFT;
 
 	ret = __pci_mmap_make_offset(dev, vma, mmap_state);
 	if (ret < 0)
diff --git a/drivers/pci/mmap.c b/drivers/pci/mmap.c
index b8c9011987f4..4504039056d1 100644
--- a/drivers/pci/mmap.c
+++ b/drivers/pci/mmap.c
@@ -13,27 +13,6 @@
 
 #ifdef ARCH_GENERIC_PCI_MMAP_RESOURCE
 
-/*
- * Modern setup: generic pci_mmap_resource_range(), and implement the legacy
- * pci_mmap_page_range() (if needed) as a wrapper round it.
- */
-
-#ifdef HAVE_PCI_MMAP
-int pci_mmap_page_range(struct pci_dev *pdev, int bar,
-			struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine)
-{
-	resource_size_t start, end;
-
-	pci_resource_to_user(pdev, bar, &pdev->resource[bar], &start, &end);
-
-	/* Adjust vm_pgoff to be the offset within the resource */
-	vma->vm_pgoff -= start >> PAGE_SHIFT;
-	return pci_mmap_resource_range(pdev, bar, vma, mmap_state,
-				       write_combine);
-}
-#endif
-
 static const struct vm_operations_struct pci_phys_vm_ops = {
 #ifdef CONFIG_HAVE_IOREMAP_PROT
 	.access = generic_access_phys,
@@ -70,27 +49,4 @@ int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
 				  vma->vm_page_prot);
 }
 
-#elif defined(HAVE_PCI_MMAP) /* && !ARCH_GENERIC_PCI_MMAP_RESOURCE */
-
-/*
- * Legacy setup: Implement pci_mmap_resource_range() as a wrapper around
- * the architecture's pci_mmap_page_range(), converting to "user visible"
- * addresses as necessary.
- */
-
-int pci_mmap_resource_range(struct pci_dev *pdev, int bar,
-			    struct vm_area_struct *vma,
-			    enum pci_mmap_state mmap_state, int write_combine)
-{
-	resource_size_t start, end;
-
-	/*
-	 * pci_mmap_page_range() expects the same kind of entry as coming
-	 * from /proc/bus/pci/ which is a "user visible" value. If this is
-	 * different from the resource itself, arch will do necessary fixup.
-	 */
-	pci_resource_to_user(pdev, bar, &pdev->resource[bar], &start, &end);
-	vma->vm_pgoff += start >> PAGE_SHIFT;
-	return pci_mmap_page_range(pdev, bar, vma, mmap_state, write_combine);
-}
 #endif
diff --git a/drivers/pci/proc.c b/drivers/pci/proc.c
index 31b26d8ea6cc..f967709082d6 100644
--- a/drivers/pci/proc.c
+++ b/drivers/pci/proc.c
@@ -244,6 +244,7 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 {
 	struct pci_dev *dev = pde_data(file_inode(file));
 	struct pci_filp_private *fpriv = file->private_data;
+	resource_size_t start, end;
 	int i, ret, write_combine = 0, res_bit = IORESOURCE_MEM;
 
 	if (!capable(CAP_SYS_RAWIO) ||
@@ -278,7 +279,11 @@ static int proc_bus_pci_mmap(struct file *file, struct vm_area_struct *vma)
 	    iomem_is_exclusive(dev->resource[i].start))
 		return -EINVAL;
 
-	ret = pci_mmap_page_range(dev, i, vma,
+	pci_resource_to_user(dev, i, &dev->resource[i], &start, &end);
+
+	/* Adjust vm_pgoff to be the offset within the resource */
+	vma->vm_pgoff -= start >> PAGE_SHIFT;
+	ret = pci_mmap_resource_range(dev, i, vma,
 				  fpriv->mmap_state, write_combine);
 	if (ret < 0)
 		return ret;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 81a57b498f22..060af91bafcd 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1909,24 +1909,14 @@ pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 
 #include <asm/pci.h>
 
-/* These two functions provide almost identical functionality. Depending
- * on the architecture, one will be implemented as a wrapper around the
- * other (in drivers/pci/mmap.c).
- *
+/*
  * pci_mmap_resource_range() maps a specific BAR, and vm->vm_pgoff
  * is expected to be an offset within that region.
  *
- * pci_mmap_page_range() is the legacy architecture-specific interface,
- * which accepts a "user visible" resource address converted by
- * pci_resource_to_user(), as used in the legacy mmap() interface in
- * /proc/bus/pci/.
  */
 int pci_mmap_resource_range(struct pci_dev *dev, int bar,
 			    struct vm_area_struct *vma,
 			    enum pci_mmap_state mmap_state, int write_combine);
-int pci_mmap_page_range(struct pci_dev *pdev, int bar,
-			struct vm_area_struct *vma,
-			enum pci_mmap_state mmap_state, int write_combine);
 
 #ifndef arch_can_pci_mmap_wc
 #define arch_can_pci_mmap_wc()		0
-- 
2.29.2

