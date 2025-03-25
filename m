Return-Path: <linux-pci+bounces-24633-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 72B82A6EC5B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 10:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C6FCA168A6B
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 09:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BF11D619F;
	Tue, 25 Mar 2025 09:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QOMdMxBg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SOSpKoaX"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF72318BC3B;
	Tue, 25 Mar 2025 09:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742894448; cv=none; b=lk8jpNdpy8XDVwBrSHz5lDOiPajSV5woF0lzYhRsh2oj9Buxue2U3tkIFqB2LbLl2wo64qbmbwVakz2qG/RXYW1+Mj743Cq1g4WiPTjJFW2Kus1awnAv9V7+SaXRyQ5+R9Lfl4Oe7Jweo7eafTAtXDRrj1DGjB3ZJJMApSx5rIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742894448; c=relaxed/simple;
	bh=Wc/WwdmsV2jSZurpTLkWJ0NEo7y8VgCnDaW+pxVc8J4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AM3Qd7JbhH+xIWGbTlxFF9oKHkS2hB+k0zB/3RqR7ro5PS0Xmy8X22T12v9DOnOMeGzXAEzHdwO4dyvyhKbMfWkhJR4jz46+HR8caq0cuaJdZZVhxDO9SQw7l0t9btzor51H0+gLijDA0ssS67vsVYwXbf30emU59sxgmYqINvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QOMdMxBg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SOSpKoaX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742894444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QvtzpcrlTMKTUsjszgMNWd7fXMOiNd5xLGAalHbQxs=;
	b=QOMdMxBg1H6zgb4zHcPB1haB9iffsGBim2vaQ+wyuLnndP3GSVmNhSBK1BDHNzMC0bw+KH
	bu5oPJgsY+8KP7kuf2E1GEoXz7F177RB1NwKP9oNcMrvbgtNXu8ec86guIvUjV9Pwxfn8T
	MsvOpI/FScQCmlAc6V4eAMrDcMIat+JT875w2Qwv0Di/KbD70St7t6p1Tmas025hQwmYMk
	KP/rx2VRvJulCVkBFlKX+K9ZC577BUecmANqid1qZl8HzahbLxSxiXQXZlS0+Rt0WD7p0D
	mdiyvkFo+Nsqn3UWBaX+PgrlrQKIklwQE1hRo60h9BkEADvDHTV/93Gz+5z3Vg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742894444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6QvtzpcrlTMKTUsjszgMNWd7fXMOiNd5xLGAalHbQxs=;
	b=SOSpKoaX7xhFOLAifQ1TBb5ORu4whJgBUD7Q62S3Xx2HgifaxTW+BNkbmo2amiYsibbnEW
	lxyc9UwshXqbQWAQ==
To: Roger Pau =?utf-8?Q?Monn=C3=A9?= <roger.pau@citrix.com>, Daniel Gomez
 <da.gomez@kernel.org>
Cc: =?utf-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>, Bjorn Helgaas
 <helgaas@kernel.org>,
 linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org,
 linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>
Subject: Re: [PATCH v3 3/3] PCI/MSI: Convert pci_msi_ignore_mask to per MSI
 domain flag
In-Reply-To: <87y0wtzg0z.ffs@tglx>
References: <20250320210741.GA1099701@bhelgaas>
 <846c80f8-b80f-49fd-8a50-3fe8a473b8ec@suse.com>
 <qn7fzggcj6qe6r6gdbwcz23pzdz2jx64aldccmsuheabhmjgrt@tawf5nfwuvw7>
 <Z-GbuiIYEdqVRsHj@macbook.local>
 <kp372led6jcryd4ubpyglc4h7b3erramgzsjl2slahxdk7w575@jganskuwkfvb>
 <Z-Gv6TG9dwKI-fvz@macbook.local> <87y0wtzg0z.ffs@tglx>
Date: Tue, 25 Mar 2025 10:20:43 +0100
Message-ID: <87v7rxzct0.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 25 2025 at 09:11, Thomas Gleixner wrote:

> On Mon, Mar 24 2025 at 20:18, Roger Pau Monn=C3=A9 wrote:
>> On Mon, Mar 24, 2025 at 07:58:14PM +0100, Daniel Gomez wrote:
>>> The issue is that info appears to be uninitialized. So, this worked for=
 me:
>>
>> Indeed, irq_domain->host_data is NULL, there's no msi_domain_info.  As
>> this is x86, I was expecting x86 ot always use
>> x86_init_dev_msi_info(), but that doesn't seem to be the case.  I
>> would like to better understand this.
>
> Indeed. On x86 this should not happen at all. On architectures, which do
> not use (hierarchical) interrupt domains, it will return NULL.
>
> So I really want to understand why this happens on x86 before such a
> "fix" is deployed.

So after staring at it some more it's clear. Without XEN, the domain
returned is the MSI parent domain, which is the vector domain in that
setup. That does not have a domain info set. But on legacy architectures
there is not even a domain.

It's really wonderful that we have a gazillion ways to manage the
backends of PCI/MSI....

So none of the suggested pointer checks will cover it correctly. Though
there is already a function which allows to query MSI domain flags
independent of the underlying insanity. Sorry for not catching it in
review.

Untested patch below.

Thanks,

        tglx
---
 drivers/pci/msi/msi.c |   18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

--- a/drivers/pci/msi/msi.c
+++ b/drivers/pci/msi/msi.c
@@ -285,8 +285,6 @@ static void pci_msi_set_enable(struct pc
 static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
 			      struct irq_affinity_desc *masks)
 {
-	const struct irq_domain *d =3D dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info =3D d->host_data;
 	struct msi_desc desc;
 	u16 control;
=20
@@ -297,7 +295,7 @@ static int msi_setup_msi_desc(struct pci
 	/* Lies, damned lies, and MSIs */
 	if (dev->dev_flags & PCI_DEV_FLAGS_HAS_MSI_MASKING)
 		control |=3D PCI_MSI_FLAGS_MASKBIT;
-	if (info->flags & MSI_FLAG_NO_MASK)
+	if (pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY))
 		control &=3D ~PCI_MSI_FLAGS_MASKBIT;
=20
 	desc.nvec_used			=3D nvec;
@@ -605,20 +603,18 @@ static void __iomem *msix_map_region(str
  */
 void msix_prepare_msi_desc(struct pci_dev *dev, struct msi_desc *desc)
 {
-	const struct irq_domain *d =3D dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info =3D d->host_data;
-
 	desc->nvec_used				=3D 1;
 	desc->pci.msi_attrib.is_msix		=3D 1;
 	desc->pci.msi_attrib.is_64		=3D 1;
 	desc->pci.msi_attrib.default_irq	=3D dev->irq;
 	desc->pci.mask_base			=3D dev->msix_base;
-	desc->pci.msi_attrib.can_mask		=3D !(info->flags & MSI_FLAG_NO_MASK) &&
-						  !desc->pci.msi_attrib.is_virtual;
=20
-	if (desc->pci.msi_attrib.can_mask) {
+
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY) &&
+	    !desc->pci.msi_attrib.is_virtual) {
 		void __iomem *addr =3D pci_msix_desc_addr(desc);
=20
+		desc->pci.msi_attrib.can_mask =3D true;
 		desc->pci.msix_ctrl =3D readl(addr + PCI_MSIX_ENTRY_VECTOR_CTRL);
 	}
 }
@@ -715,8 +711,6 @@ static int msix_setup_interrupts(struct
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *en=
tries,
 				int nvec, struct irq_affinity *affd)
 {
-	const struct irq_domain *d =3D dev_get_msi_domain(&dev->dev);
-	const struct msi_domain_info *info =3D d->host_data;
 	int ret, tsize;
 	u16 control;
=20
@@ -747,7 +741,7 @@ static int msix_capability_init(struct p
 	/* Disable INTX */
 	pci_intx_for_msi(dev, 0);
=20
-	if (!(info->flags & MSI_FLAG_NO_MASK)) {
+	if (!pci_msi_domain_supports(dev, MSI_FLAG_NO_MASK, DENY_LEGACY)) {
 		/*
 		 * Ensure that all table entries are masked to prevent
 		 * stale entries from firing in a crash kernel.

