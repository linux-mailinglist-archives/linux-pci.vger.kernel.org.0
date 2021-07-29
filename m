Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07B763DAEF3
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbhG2Wes (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:34:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49076 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233017AbhG2Wer (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:34:47 -0400
Message-ID: <20210729222542.403833459@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yhNFc6cu/Ud2vpLDU4lJ6f445JcsOy4OWzVjDs40Mro=;
        b=p3xZHaJkiOK+NZ/1XefUN0qIt2sQAS5pIiM9GjOzxbYjxy/xTAn6RdfRVP0OIiHyPUJHBM
        gRfHa9D1yMDhIJ4qmyQifKNiAu4Cu8pmNCvj3dJ0biJ2JbuK3Zkez5XEstn7XVOeH8zykg
        +MvR5DHdv+2wWYELC1F6I2iooXJRcaBDHV/+ylj0JpRWca/6IG4HHC4qY6Pn/UbJ1ePbk0
        f81mJqwk8T4K88XNIO3gJkZecA/1RjZ7DKpt5CHQc/ASiQhj5DO8ONFOkirLQ3rYNkWh5x
        pLMEvTM3V1qOTQAJpWlxgieoSyERmJ+2t3b9ZpvsPJ7eBhMeT7MZvEi63LKweA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598082;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=yhNFc6cu/Ud2vpLDU4lJ6f445JcsOy4OWzVjDs40Mro=;
        b=caphShy0MF3PngpoeM01saNrUGgl4KkkWzDGGrSzdJ7ljg4OfvWaIk35pUL9ELuyRCQzF7
        tOXDBm3c1R4VhODg==
Date:   Thu, 29 Jul 2021 23:51:41 +0200
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Alex Williamson <alex.williamson@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        Kevin Tian <kevin.tian@intel.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-s390@vger.kernel.org,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [patch V2 02/19] PCI/MSI: Mask all unused MSI-X entries
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

When MSI-X is enabled the ordering of calls is:

  msix_map_region();
  msix_setup_entries();
  pci_msi_setup_msi_irqs();
  msix_program_entries();

This has a few interesting issues:

 1) msix_setup_entries() allocates the MSI descriptors and initializes them
    except for the msi_desc:masked member which is left zero initialized.

 2) pci_msi_setup_msi_irqs() allocates the interrupt descriptors and sets
    up the MSI interrupts which ends up in pci_write_msi_msg() unless the
    interrupt chip provides its own irq_write_msi_msg() function.

 3) msix_program_entries() does not do what the name suggests. It solely
    updates the entries array (if not NULL) and initializes the masked
    member for each MSI descriptor by reading the hardware state and then
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
Reviewed-by: Marc Zyngier <maz@kernel.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
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

