Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CFA63DAF1A
	for <lists+linux-pci@lfdr.de>; Fri, 30 Jul 2021 00:35:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234733AbhG2WfX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 29 Jul 2021 18:35:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234650AbhG2WfI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 29 Jul 2021 18:35:08 -0400
Message-ID: <20210729222543.151522318@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627598103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4d6jpf7VvfSCC5wDxxTlQqDwmyplaLXi1z26YEo5c+g=;
        b=k6cqmo7oDAI9dn6SAtLHM3xOJ7YfIzaMmn0zYmaLHw8+p+JOOHFdrCAr6dsrZHxEA1JlJX
        sbJYdL2Uarh0flzsFzbUZB/4/VnJ8zAiY579QdYjtC+9mxCKr7QCbrQzvd7FUr85XHQMld
        /xHqtjAm9EFpYv6MizgR7Kk12Q9N1XWQH+AYSQSJdUPv8KTTRk+j1P2hylaYrpuquAroVF
        oBkcEq1m8m05yWIvLjcgYAMHMA3aWVVlMyLbfXs+VaOX8nMau77j/mI97WP5lJ5lNCwNOe
        DoJjfS/7jdplfOJ3rAFwF/FoLMcqV0Ac1qLStBZy2h1LkSiA9EINHchL02tS3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627598103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=4d6jpf7VvfSCC5wDxxTlQqDwmyplaLXi1z26YEo5c+g=;
        b=qlyKSNm+nB2ii1MzIVL8ZeVE1LmzcDswofdWBSGQHuwVaSpjYrZgbOWS9UizJCyT5ohuVH
        7cFjIru2/Z4UjLBQ==
Date:   Thu, 29 Jul 2021 23:51:55 +0200
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
Subject: [patch V2 16/19] PCI/MSI: Deobfuscate virtual MSI-X
References: <20210729215139.889204656@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Handling of virtual MSI-X is obfuscated by letting pci_msix_desc_addr()
return NULL and checking the pointer.

Just use msi_desc::msi_attrib.is_virtual at the call sites and get rid of
that pointer check.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V2: New patch
---
 drivers/pci/msi.c |   25 ++++++++-----------------
 1 file changed, 8 insertions(+), 17 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -166,11 +166,7 @@ static void msi_mask_irq(struct msi_desc
 
 static void __iomem *pci_msix_desc_addr(struct msi_desc *desc)
 {
-	if (desc->msi_attrib.is_virtual)
-		return NULL;
-
-	return desc->mask_base +
-		desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
+	return desc->mask_base + desc->msi_attrib.entry_nr * PCI_MSIX_ENTRY_SIZE;
 }
 
 /*
@@ -182,14 +178,10 @@ static void __iomem *pci_msix_desc_addr(
  */
 static u32 __pci_msix_desc_mask_irq(struct msi_desc *desc, u32 flag)
 {
+	void __iomem *desc_addr = pci_msix_desc_addr(desc);
 	u32 ctrl = desc->msix_ctrl;
-	void __iomem *desc_addr;
-
-	if (pci_msi_ignore_mask)
-		return 0;
 
-	desc_addr = pci_msix_desc_addr(desc);
-	if (!desc_addr)
+	if (pci_msi_ignore_mask || desc->msi_attrib.is_virtual)
 		return 0;
 
 	ctrl &= ~PCI_MSIX_ENTRY_CTRL_MASKBIT;
@@ -256,10 +248,8 @@ void __pci_read_msi_msg(struct msi_desc
 	if (entry->msi_attrib.is_msix) {
 		void __iomem *base = pci_msix_desc_addr(entry);
 
-		if (!base) {
-			WARN_ON(1);
+		if (WARN_ON_ONCE(entry->msi_attrib.is_virtual))
 			return;
-		}
 
 		msg->address_lo = readl(base + PCI_MSIX_ENTRY_LOWER_ADDR);
 		msg->address_hi = readl(base + PCI_MSIX_ENTRY_UPPER_ADDR);
@@ -292,7 +282,7 @@ void __pci_write_msi_msg(struct msi_desc
 		void __iomem *base = pci_msix_desc_addr(entry);
 		bool unmasked = !(entry->msix_ctrl & PCI_MSIX_ENTRY_CTRL_MASKBIT);
 
-		if (!base)
+		if (entry->msi_attrib.is_virtual)
 			goto skip;
 
 		/*
@@ -744,9 +734,10 @@ static int msix_setup_entries(struct pci
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
 
-		addr = pci_msix_desc_addr(entry);
-		if (addr)
+		if (!entry->msi_attrib.is_virtual) {
+			addr = pci_msix_desc_addr(entry);
 			entry->msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
+		}
 
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 		if (masks)

