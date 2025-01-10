Return-Path: <linux-pci+bounces-19628-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B719A092DA
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 15:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948DC3A8A20
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jan 2025 14:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DED902101A4;
	Fri, 10 Jan 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b="ioInHy/H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BB6210194
	for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2025 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736517755; cv=none; b=T4a9w9vQuAsvbzDMXCAFdWtd68FcqXLH1ntDt9V68IUEcTH0SZEy6i1eIHEHci2w/2xXYEtbdZbWJ3mwEx+YrUkdLpFE6yMdCkRqqikazEyx+t5VigAq9T9xtnEf3yYIHrC1BEdWE5bL6rdudPyr8bBsH7yGpfwSaof1nzUrAqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736517755; c=relaxed/simple;
	bh=NA2qf4BofQl5Z9fSyXzPqlQB2uDCZs5Xl7Dvz/os7cs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mIKx1XpThXcWLxaaSkCNV7SHBX/plL/O0YT+BQPW8S2bTCMSnGeL6SqsxHze4k0SBLNGZ0asTido+WrKTfHo1RDwIKS3Hfcxhk4QI8xCgOEjvsc2vmYcByL+4MQCBTbWzvnK8ZRFRMGK7vVpPjdAgXWkjhhhxMkIkvpZ86twrfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com; spf=pass smtp.mailfrom=cloud.com; dkim=pass (1024-bit key) header.d=citrix.com header.i=@citrix.com header.b=ioInHy/H; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=citrix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloud.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ab2bb0822a4so421680766b.3
        for <linux-pci@vger.kernel.org>; Fri, 10 Jan 2025 06:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=citrix.com; s=google; t=1736517752; x=1737122552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bXUrrXc7otEMLuPDik4Ot8RLIKG6b+qL1a+y6J/W2hw=;
        b=ioInHy/Hne0Q8ZAZ8B+MwMM+jT+XTI6RZbPdRWtH6bBtbUVNY9llbrh9U+CZ/u375V
         vqStTDCgMGErS6ddzWVUlzbyjDxCSQaSMhrvA+//Dhbskb8yGZDtdR7bmCFlwpFPeQjJ
         PUszz6S/6SrUU8ECw5NoMdd8qImptR+bCM6ak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736517752; x=1737122552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bXUrrXc7otEMLuPDik4Ot8RLIKG6b+qL1a+y6J/W2hw=;
        b=d4i88DFrypzPGKqCpyc+sPr3tr4molzFi6VYTX00XNUuWBt2mwGyw3b8dXnTafiXqr
         Y/uS9k0z9aa1KdQo4vMjsbMt4n2sXBGBtFBuE7Tvbk1NnEl07C7Ma7YTUyC6i+PXUlb1
         4XrGI/jgzo4pPR+eb+XPLRPyzeaA16Ma4e4YZpFufdtZi1pqnChF6of+LluDzl8gn1BD
         3K0+5OjHtxOYKYPX2+4e3gnk/4CkpQAGfMFAZGYbNOuwxI4vV7yLwammCHz5ty//hXif
         TTUSZoRMhrwlTMVl40DubgsvMz+H0I5CBnfepEWTxeEVZ2OXLEZRYrffb60Yt+dAG4AE
         aI4A==
X-Forwarded-Encrypted: i=1; AJvYcCWsKYBiaYW14zcB7CxgO0MIBDR4bGja3KEhKwPn+NwpdyZqtdHPZjq5VMJqGyHv0K5pvQTIsZlc2BE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+72tGdLa7aIhEQqg3JoIikVxc71+/cEx82glnfHQWcbnBfojd
	vZgmcSW5bP13ka3bNqLICST4lhni73E5XbvTh7H5VAP0Swv5DguPSSNvHLIJ2zA=
X-Gm-Gg: ASbGncsa0VZHe5f9OJWSpncU3i40Oix7kNichl3Mr9tRvtOUB6ZxsVihlNWny7peN+7
	QeYLscs+o6PCYTuMxiV7abrD8LVVLfWTYBPLWcd9JXuB/bKIiJTEVEGG+GToFRGmM8XYZ9AQmOH
	wrK/Por8O/o8qsuSuX8hVSRJ2a99uCfpFVkk2doGeMd3alT5c8KGWAW93syyUl/poghhAN4svtW
	M7x5sDlQw/UktCaiaBMG3jkpboDD82VCf/cP2uIYJqP7CaRYwMDEWjfPgZooJSxnKc=
X-Google-Smtp-Source: AGHT+IGy+s65n1QI7kpn2XGnPHW44cwj7nn4OvI00oi9CML5cFM7+b0vWH7nmPweruWMP0Y17IUp2g==
X-Received: by 2002:a17:906:7311:b0:a9a:bbcc:5092 with SMTP id a640c23a62f3a-ab2ab6bfb7amr910685366b.39.1736517721914;
        Fri, 10 Jan 2025 06:02:01 -0800 (PST)
Received: from localhost ([84.78.159.3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab2c95b09a6sm168510666b.145.2025.01.10.06.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 06:02:01 -0800 (PST)
From: Roger Pau Monne <roger.pau@citrix.com>
To: linux-kernel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-pci@vger.kernel.org
Cc: Roger Pau Monne <roger.pau@citrix.com>,
	Juergen Gross <jgross@suse.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 3/3] pci/msi: remove pci_msi_ignore_mask
Date: Fri, 10 Jan 2025 15:01:50 +0100
Message-ID: <20250110140152.27624-4-roger.pau@citrix.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20250110140152.27624-1-roger.pau@citrix.com>
References: <20250110140152.27624-1-roger.pau@citrix.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Setting pci_msi_ignore_mask inhibits the toggling of the mask bit for both MSI
and MSI-X entries globally, regardless of the IRQ chip they are using.  Only
Xen sets the pci_msi_ignore_mask when routing physical interrupts over event
channels, to prevent PCI code from attempting to toggle the maskbit, as it's
Xen that controls the bit.

However, the pci_msi_ignore_mask being global will affect devices that use MSI
interrupts but are not routing those interrupts over event channels (not using
the Xen pIRQ chip).  One example is devices behind a VMD PCI bridge.  In that
scenario the VMD bridge configures MSI(-X) using the normal IRQ chip (the pIRQ
one in the Xen case), and devices behind the bridge configure the MSI entries
using indexes into the VMD bridge MSI table.  The VMD bridge then demultiplexes
such interrupts and delivers to the destination device(s).  Having
pci_msi_ignore_mask set in that scenario prevents (un)masking of MSI entries
for devices behind the VMD bridge.

Move the signaling of no entry masking into the MSI domain flags, as that
allows setting it on a per-domain basis.  Set it for the Xen MSI domain that
uses the pIRQ chip, while leaving it unset for the rest of the cases.

Remove pci_msi_ignore_mask at once, since it was only used by Xen code, and
with Xen dropping usage the variable is unneeded.

This fixes using devices behind a VMD bridge on Xen PV hardware domains.

Signed-off-by: Roger Pau Monné <roger.pau@citrix.com>
---
 arch/x86/pci/xen.c    |  8 ++------
 drivers/pci/msi/msi.c | 36 ++++++++++++++++++++----------------
 include/linux/msi.h   |  3 ++-
 kernel/irq/msi.c      |  2 +-
 4 files changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index 0f2fe524f60d..b8755cde2419 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -436,7 +436,8 @@ static struct msi_domain_ops xen_pci_msi_domain_ops = {
 };
 
 static struct msi_domain_info xen_pci_msi_domain_info = {
-	.flags			= MSI_FLAG_PCI_MSIX | MSI_FLAG_FREE_MSI_DESCS | MSI_FLAG_DEV_SYSFS,
+	.flags			= MSI_FLAG_PCI_MSIX | MSI_FLAG_FREE_MSI_DESCS |
+				  MSI_FLAG_DEV_SYSFS | MSI_FLAG_NO_MASK,
 	.ops			= &xen_pci_msi_domain_ops,
 };
 
@@ -484,11 +485,6 @@ static __init void xen_setup_pci_msi(void)
 	 * in allocating the native domain and never use it.
 	 */
 	x86_init.irqs.create_pci_msi_domain = xen_create_pci_msi_domain;
-	/*
-	 * With XEN PIRQ/Eventchannels in use PCI/MSI[-X] masking is solely
-	 * controlled by the hypervisor.
-	 */
-	pci_msi_ignore_mask = 1;
 }
 
 #else /* CONFIG_PCI_MSI */
diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
index 3a45879d85db..cb42298f6a97 100644
--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -15,7 +15,6 @@
 #include "msi.h"
 
 int pci_msi_enable = 1;
-int pci_msi_ignore_mask;
 
 /**
  * pci_msi_supported - check whether MSI may be enabled on a device
@@ -285,6 +284,8 @@ static void pci_msi_set_enable(struct pci_dev *dev, int enable)
 static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 			      struct irq_affinity_desc *masks)
 {
+	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
+	const struct msi_domain_info *info = d->host_data;
 	struct msi_desc desc;
 	u16 control;
 
@@ -295,8 +296,7 @@ static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 	/* Lies, damned lies, and MSIs */
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |= PCI_MSI_FLAGS_MASKBIT;
-	/* Respect XEN's mask disabling */
-	if (pci_msi_ignore_mask)
+	if (info->flags & MSI_FLAG_NO_MASK)
 		control &= ~PCI_MSI_FLAGS_MASKBIT;
 
 	desc.nvec_used			= nvec;
@@ -600,12 +600,15 @@ static void __iomem *msix_map_region(struct pci_dev *dev,
  */
 void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 {
+	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
+	const struct msi_domain_info *info = d->host_data;
+
 	desc->nvec_used				= 1;
 	desc->pci.msi_attrib.is_msix		= 1;
 	desc->pci.msi_attrib.is_64		= 1;
 	desc->pci.msi_attrib.default_irq	= dev->irq;
 	desc->pci.mask_base			= dev->msix_base;
-	desc->pci.msi_attrib.can_mask		= !pci_msi_ignore_mask &&
+	desc->pci.msi_attrib.can_mask		= !(info->flags & MSI_FLAG_NO_MASK) &&
 						  !desc->pci.msi_attrib.is_virtual;
 
 	if (desc->pci.msi_attrib.can_mask) {
@@ -655,9 +658,6 @@ static void msix_mask_all(void __iomem *base, int tsize)
 	u32 ctrl = PCI_MSIX_ENTRY_CTRL_MASKBIT;
 	int i;
 
-	if (pci_msi_ignore_mask)
-		return;
-
 	for (i = 0; i < tsize; i++, base += PCI_MSIX_ENTRY_SIZE)
 		writel(ctrl, base + PCI_MSIX_ENTRY_VECTOR_CTRL);
 }
@@ -710,6 +710,8 @@ static int msix_setup_interrupts(struct pci_dev *dev, struct msix_entry *entries
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
+	const struct irq_domain *d = dev_get_msi_domain(&dev->dev);
+	const struct msi_domain_info *info = d->host_data;
 	int ret, tsize;
 	u16 control;
 
@@ -740,15 +742,17 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
 
-	/*
-	 * Ensure that all table entries are masked to prevent
-	 * stale entries from firing in a crash kernel.
-	 *
-	 * Done late to deal with a broken Marvell NVME device
-	 * which takes the MSI-X mask bits into account even
-	 * when MSI-X is disabled, which prevents MSI delivery.
-	 */
-	msix_mask_all(dev->msix_base, tsize);
+	if (!(info->flags & MSI_FLAG_NO_MASK)) {
+		/*
+		 * Ensure that all table entries are masked to prevent
+		 * stale entries from firing in a crash kernel.
+		 *
+		 * Done late to deal with a broken Marvell NVME device
+		 * which takes the MSI-X mask bits into account even
+		 * when MSI-X is disabled, which prevents MSI delivery.
+		 */
+		msix_mask_all(dev->msix_base, tsize);
+	}
 	pci_msix_clear_and_set_ctrl(dev, PCI_MSIX_FLAGS_MASKALL, 0);
 
 	pcibios_free_irq(dev);
diff --git a/include/linux/msi.h b/include/linux/msi.h
index b10093c4d00e..59a421fc42bf 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -73,7 +73,6 @@ struct msi_msg {
 	};
 };
 
-extern int pci_msi_ignore_mask;
 /* Helper functions */
 struct msi_desc;
 struct pci_dev;
@@ -556,6 +555,8 @@ enum {
 	MSI_FLAG_PCI_MSIX_ALLOC_DYN	= (1 << 20),
 	/* PCI MSIs cannot be steered separately to CPU cores */
 	MSI_FLAG_NO_AFFINITY		= (1 << 21),
+	/* Inhibit usage of entry masking */
+	MSI_FLAG_NO_MASK		= (1 << 22),
 };
 
 /**
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 396a067a8a56..7682c36cbccc 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -1143,7 +1143,7 @@ static bool msi_check_reservation_mode(struct irq_domain *domain,
 	if (!(info->flags & MSI_FLAG_MUST_REACTIVATE))
 		return false;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI) && pci_msi_ignore_mask)
+	if (info->flags & MSI_FLAG_NO_MASK)
 		return false;
 
 	/*
-- 
2.46.0


