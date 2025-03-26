Return-Path: <linux-pci+bounces-24760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AC619A71630
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 13:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58B923A60BF
	for <lists+linux-pci@lfdr.de>; Wed, 26 Mar 2025 12:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD4C1ADFFB;
	Wed, 26 Mar 2025 12:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VSQ4UalF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A3n6s+JA"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DD4139566;
	Wed, 26 Mar 2025 12:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742990739; cv=none; b=UhyY/XMqp/AUQbTUSSo9NbqepS1kIXCRXI7szRseB811vMf7oy2HtrG5EIx+HQHsI97PsGyLoCs0BlMdea3GqmzHA3a6B7smiTGzOIqANR4Iy2V6uuZStWhwH9kTR9Y8IZtKtQSQkGd2uH9BEkWhLHrTLAz5xwupLfHFKpg7eY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742990739; c=relaxed/simple;
	bh=b9nNTR0ehRVtYYFFKE6+c5JfsYBJSL0NzAidy+fWVbI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ABThqaKHlF0AFDn8vlNa/WepM2Ctw1o2p57Tn3Coj6AE/LVaNuAqMFhDpYCbroErqXzD8O316CiHZ++tpcslWLqt/7FMPVUQ1ZkAhxvWeXzkojaZN3D+HStg3+ecBc4T6BirNQ/D4q9kpCsVwqe6tzM9NNqLuC+cuaWfUyDeHek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VSQ4UalF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A3n6s+JA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742990735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RNc6aiq57yiGCBRg0LL9xH6lg+TfPWpVcHs+AMtgCUY=;
	b=VSQ4UalF79QRqAVvaxuvHRSLf69VijwPTorQeq6yl+I4ZMzrIcswkQWIIUA1HiKF5MFhqm
	+hlsgp8h0mjbD57BpeMeFZVPlgtmSRET9+70unGjeV53IXJQ4enWqAgdnRuYhFA0XlH7dT
	Jt0E9UwJy2ZFmr/h9e3JmKGujP1sfQe02rGFJl0GH3Dk2hjmIhinuV0yJYm9xEofLne63A
	0Wz/s09kAfN5O3jKMHTiWiubsqsLGaCMKmrePpsZ4pgxQ0s25LoPIJa/g/qQesdJ0kjIp+
	yeYmhyGEAKFOPByBCtNDXWJJmecCRZFnQKVNX97AHh4A6gPgMLcOipzJI49Y6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742990735;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RNc6aiq57yiGCBRg0LL9xH6lg+TfPWpVcHs+AMtgCUY=;
	b=A3n6s+JARC6Qzy2kr4Da7Jz//puH+TEjoE7uM8q8BV5Xlz+3qSqJMEwrzFfm1qo453I6cd
	RqPHYnmOaCKCZwDw==
To: Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>, Daniel Gomez
 <da.gomez@kernel.org>
Cc: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Bjorn Helgaas
 <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: [PATCH] PCI/MSI: Handle the NOMASK flag correctly for all PCI/MSI
 backends
In-Reply-To: <87v7rxzct0.ffs@tglx>
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
 <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
 <Z-GbuiIYEdqVRsHj@macbook.local>
 <kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
 <Z-Gv6TG9dwKI-fvz@macbook.local> <87y0wtzg0z.ffs@tglx>
 <87v7rxzct0.ffs@tglx>
Date: Wed, 26 Mar 2025 13:05:35 +0100
Message-ID: <87iknwyp2o.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The conversion of the XEN specific global variable pci_msi_ignore_mask to a
MSI domain flag, missed the facts that:

    1) Legacy architectures do not provide a interrupt domain
    2) Parent MSI domains do not necessarily have a domain info attached
   
Both cases result in an unconditional NULL pointer dereference.

Cure this by using the existing pci_msi_domain_supports() helper, which
handles all possible cases correctly.

Fixes: c3164d2e0d18 ("PCI/MSI: Convert pci_msi_ignore_mask to per MSI domain flag")
Reported-by: Daniel Gomez <da.gomez@kernel.org>
Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Borislav Petkov <bp@alien8.de>
Tested-by: Daniel Gomez <da.gomez@kernel.org>
---
 drivers/pci/msi/msi.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)



--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -285,8 +285,6 @@ static void pci_msi_set_enable(struct pc
 static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 			      struct irq_affinity_desc *masks)
 {
-	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info = d->host_data;
 	struct msi_desc desc;
 	u16 control;
 
@@ -297,7 +295,7 @@ static int msi_setup_msi_desc(struct pci
 	/* Lies, damned lies, and MSIs */
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |= PCI_MSI_FLAGS_MASKBIT;
-	if (info->flags & MSI_FLAG_NO_MASK)
+	if (pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY))
 		control &= ~PCI_MSI_FLAGS_MASKBIT;
 
 	desc.nvec_used			= nvec;
@@ -604,20 +602,18 @@ static void __iomem *msix_map_region(str
  */
 void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 {
-	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info = d->host_data;
-
 	desc->nvec_used				= 1;
 	desc->pci.msi_attrib.is_msix		= 1;
 	desc->pci.msi_attrib.is_64		= 1;
 	desc->pci.msi_attrib.default_irq	= dev->irq;
 	desc->pci.mask_base			= dev->msix_base;
-	desc->pci.msi_attrib.can_mask		= !(info->flags & MSI_FLAG_NO_MASK) &&
-						  !desc->pci.msi_attrib.is_virtual;
 
-	if (desc->pci.msi_attrib.can_mask) {
+
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY) &&
+	    !desc->pci.msi_attrib.is_virtual) {
 		void __iomem *addr = pci_msix_desc_addr(desc);
 
+		desc->pci.msi_attrib.can_mask = 1;
 		desc->pci.msix_ctrl = readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }
@@ -715,8 +711,6 @@ static int msix_setup_interrupts(struct
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
-	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info = d->host_data;
 	int ret, tsize;
 	u16 control;
 
@@ -747,7 +741,7 @@ static int msix_capability_init(struct p
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
 
-	if (!(info->flags & MSI_FLAG_NO_MASK)) {
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY)) {
 		/*
 		 * Ensure that all table entries are masked to prevent
 		 * stale entries from firing in a crash kernel.

