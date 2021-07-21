Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4169A3D1712
	for <lists+linux-pci@lfdr.de>; Wed, 21 Jul 2021 21:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240167AbhGUSrp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 21 Jul 2021 14:47:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48984 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240157AbhGUSrp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 21 Jul 2021 14:47:45 -0400
Message-Id: <20210721192650.268814107@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1626895700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IZTd+XpoWYmhr0WH7I9so3BgwJiydYTy0Kw6dYqrbAw=;
        b=HZHcDVLp7V5NBpY63+8Dp2jJiSsG8UGbza6WnApcev5BkbrgJM2wwhffvBseMA0zRMyZOW
        m/Cs/XPK99CKjWBJe7vMg3mUygerqVDSxJpHk9u1hFUmRetll0fesPDk1lIcnXqUXQByu0
        xH39XewcCC1u7p8+SX8F7Av1UJbeCVMaAt0vJYzL5DcZqrVRJTHo3gLOFDCREH7nICTtlq
        FRhHwIbe6T7sCkzczTSVo235+NeBD9s2Vl7oiI44gteEZ0ip9npngKcznPMNA1eFJqQQyz
        NELgdsC4zHnds6me8UiQQbpJN9gjFSg40/+Ijvm1pzl129S74l4UJS3L4fwtlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1626895700;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=IZTd+XpoWYmhr0WH7I9so3BgwJiydYTy0Kw6dYqrbAw=;
        b=ao/br370RWx5Uo3O3m9u3vvJUwYghNoEuGR1dAbe5NzLk78cWTMOjVVfPHDGLoksSTQwi8
        5hwZZwDjKTuFGNBQ==
Date:   Wed, 21 Jul 2021 21:11:28 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org
Subject: [patch 2/8] PCI/MSI: Mask all unused MSI-X entries
References: <20210721191126.274946280@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When MSI-X is enabled the ordering of calls is:

  msix_map_region();
  msix_setup_entries();
  pci_msi_setup_msi_irqs();
  msix_program_entries();

This has a few interesting issues:

 1) msix_setup_entries() allocates the msi descriptors and initializes them
    except for the msi_desc:masked member which is left zero initialized.

 2) pci_msi_setup_msi_irqs() allocates the interrupt descriptors and sets
    up the MSI interrupts which ends up in pci_write_msi_msg() unless the
    interrupt chip provides it's own irq_write_msi_msg() function.

 3) msix_program_entries() does not do what the name suggests. It solely
    updates the entries array (if not NULL) and initializes the masked
    member for each msi descriptor by reading the hardware state and then
    masks the entry.

Obviously this has some issues:

 1) The uninitialized masked member of msi_desc prevents the enforcement
    of masking the entry in pci_write_msi_msg() depending on the cached
    masked bit. Aside of that half initialized data is a NONO in general

 2) msix_program_entries() only ensures that the actually allocated entries
    are masked. This is wrong as experimentation with crash testing and
    crash kernel kexec has shown.

    This limited testing unearthed that when the production kernel had more
    entries in use and unmasked when it crashed and the crash kernel
    allocated a smaller amount of entries, then a full scan of all entries
    found unmasked entries which were in use in the production kernel.

    This is obviously a device or emulation issue as the device reset
    should mask all MSI-X table entries, but obviously that's just part
    of the paper specification.

Cure this by:

 1) Masking all table entries in hardware
 2) Initializing msi_desc::masked in msix_setup_entries()
 3) Removing the mask dance in msix_program_entries()
 4) Renaming msix_program_entries() to msix_update_entries() to
    reflect the purpose of that function.

As the masking of unused entries has never been done the Fixes tag refers
to a commit in:
   git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git

Fixes: f036d4ea5fa7 ("[PATCH] ia32 Message Signalled Interrupt support")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
---
 drivers/pci/msi.c |   45 +++++++++++++++++++++++++++------------------
 1 file changed, 27 insertions(+), 18 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -691,6 +691,7 @@ static int msix_setup_entries(struct pci
 {
 	struct irq_affinity_desc *curmsk, *masks = NULL;
 	struct msi_desc *entry;
+	void __iomem *addr;
 	int ret, i;
 	int vec_count = pci_msix_vec_count(dev);
 
@@ -711,6 +712,7 @@ static int msix_setup_entries(struct pci
 
 		entry->msi_attrib.is_msix	= 1;
 		entry->msi_attrib.is_64		= 1;
+
 		if (entries)
 			entry->msi_attrib.entry_nr = entries[i].entry;
 		else
@@ -722,6 +724,10 @@ static int msix_setup_entries(struct pci
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
 
+		addr = pci_msix_desc_addr(entry);
+		if (addr)
+			entry->masked = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 		if (masks)
 			curmsk++;
@@ -732,26 +738,25 @@ static int msix_setup_entries(struct pci
 	return ret;
 }
 
-static void msix_program_entries(struct pci_dev *dev,
-				 struct msix_entry *entries)
+static void msix_update_entries(struct pci_dev *dev, struct msix_entry *entries)
 {
 	struct msi_desc *entry;
-	int i = 0;
-	void __iomem *desc_addr;
 
 	for_each_pci_msi_entry(entry, dev) {
-		if (entries)
-			entries[i++].vector = entry->irq;
+		if (entries) {
+			entries->vector = entry->irq;
+			entries++;
+		}
+	}
+}
 
-		desc_addr = pci_msix_desc_addr(entry);
-		if (desc_addr)
-			entry->masked = readl(desc_addr +
-					      PCI_MSIX_ENTRY_VECTOR_CTRL);
-		else
-			entry->masked = 0;
+static void msix_mask_all(void __iomem *base, int tsize)
+{
+	u32 ctrl = PCI_MSIX_ENTRY_CTRL_MASKBIT;
+	int i;
 
-		msix_mask_irq(entry, 1);
-	}
+	for (i = 0; i < tsize; i++, base += PCI_MSIX_ENTRY_SIZE)
+		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
 
 /**
@@ -768,9 +773,9 @@ static void msix_program_entries(struct
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
-	int ret;
-	u16 control;
 	void __iomem *base;
+	int ret, tsize;
+	u16 control;
 
 	/*
 	 * Some devices require MSI-X to be enabled before the MSI-X
@@ -782,12 +787,16 @@ static int msix_capability_init(struct p
 
 	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &control);
 	/* Request & Map MSI-X table region */
-	base = msix_map_region(dev, msix_table_size(control));
+	tsize = msix_table_size(control);
+	base = msix_map_region(dev, tsize);
 	if (!base) {
 		ret = -ENOMEM;
 		goto out_disable;
 	}
 
+	/* Ensure that all table entries are masked. */
+	msix_mask_all(base, tsize);
+
 	ret = msix_setup_entries(dev, base, entries, nvec, affd);
 	if (ret)
 		goto out_disable;
@@ -801,7 +810,7 @@ static int msix_capability_init(struct p
 	if (ret)
 		goto out_free;
 
-	msix_program_entries(dev, entries);
+	msix_update_entries(dev, entries);
 
 	ret = populate_msi_sysfs(dev);
 	if (ret)

