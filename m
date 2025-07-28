Return-Path: <linux-pci+bounces-33082-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F13B14123
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 19:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63CC8189F3CE
	for <lists+linux-pci@lfdr.de>; Mon, 28 Jul 2025 17:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28490274B24;
	Mon, 28 Jul 2025 17:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ucgBpZWk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JyiCo8iG"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542EC1EDA2C;
	Mon, 28 Jul 2025 17:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753723388; cv=none; b=aMpTtTe7TClO5HWW+MhaMZTGm18K1M3V+rFEIKjaQpnRjsU3EmaesVvTVBrbZ/IAsApsDH2QkEJGkkLtBtubVcThDVwPyx6DouCbghXIjAvF/Ge6Sv3YNxrs672jXwxTCGXa4WaZgNg8XI5WP9i8yQ5alSC3sa/iueOCijwjwwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753723388; c=relaxed/simple;
	bh=YD+YID1VDesHXGUkJdbX8qA5nh35vkjM1OptoY5oJ/s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L9JRPHhC0dkGrgQFQfMPnk/MgxYqSK2qquT6uOS4jfqb1WPSz6SNqurJO1dJlgiIkqmMN93FIWV3A2UooQcXALkUkb/IzWJT6TO3tq2SW2a/nANL/40WdMvMbuyDj1hTp14XzCWFB64cO2EiAKI/QMehgYfHatkatAJn+/HbLfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ucgBpZWk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JyiCo8iG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753723384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jfjsVMj8e2ETr+zcziPiqvFC7IbRwRQfxk5W2jTYgf8=;
	b=ucgBpZWkwt/agwAjz0329IISVcJLSRKP3Jxo2e7DYuYP1hjzuCsy4YRDtSz0ByQLMyyYqu
	3tqY6UHxfEM/vmFufInt+SjTTpTgBj4O0VjT/f0Lm8fwY4S/79eK/zmUnR6L9KJwnbTV/r
	7cOJ98PjzzTGXWntm9ybfBeYi8Ct2koErmSk1pGttGjH+Y6Vs6eR8ePqrk8oaGq/wzyAJh
	Aq/rnDafMaszc9t6YCqNhSL1+Xyi5cvRK3xqqdf0rNCCIpoAOONZJbC4HMVYrTB08pqHd1
	RNFvOm6qmO6LzpcXZ5BpsbZlv/CciITqXIoSV7nmzj4ltAO1Ytcd+Ht9tw4bsQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753723384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jfjsVMj8e2ETr+zcziPiqvFC7IbRwRQfxk5W2jTYgf8=;
	b=JyiCo8iGdEHN3AGtJdF1j/gW2cosdHJYvfowG25nlEHE7VVjL5dSogBNGZq0iYKLGZ+nPf
	3egVCdDyX3p5tZBg==
To: Chris Li <chrisl@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Len Brown
 <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, David Matlack <dmatlack@google.com>, Pasha
 Tatashin <tatashin@google.com>, Jason Miu <jasonmiu@google.com>, Vipin
 Sharma <vipinsh@google.com>, Saeed Mahameed <saeedm@nvidia.com>, Adithya
 Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>,
 William Tu <witu@nvidia.com>, Mike Rapoport <rppt@kernel.org>, Chris Li
 <chrisl@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky
 <leon@kernel.org>
Subject: Re: [PATCH RFC 20/25] PCI/LUO: Avoid write to liveupdate devices at
 boot
In-Reply-To: <20250728-luo-pci-v1-20-955b078dd653@kernel.org>
References: <20250728-luo-pci-v1-0-955b078dd653@kernel.org>
 <20250728-luo-pci-v1-20-955b078dd653@kernel.org>
Date: Mon, 28 Jul 2025 19:23:03 +0200
Message-ID: <87zfconsaw.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Jul 28 2025 at 01:24, Chris Li wrote:
> The liveupdate devices are already initialized by the kernel before the
> kexec. During the kexec the device is still running. Avoid write to the
> liveupdate devices during the new kernel boot up.

This change log is way too meager for this kind of change.

 1) You want to explain in detail how this works.

    "initialized by the kernel before the kexec" is as vague as it gets.

 2) Avoid write ....

    Again this lacks any information how this is supposed to work correctly.

>  drivers/pci/ats.c            |  7 ++--
>  drivers/pci/iov.c            | 58 ++++++++++++++++++------------
>  drivers/pci/msi/msi.c        | 32 ++++++++++++-----
>  drivers/pci/msi/pcidev_msi.c |  4 +--
>  drivers/pci/pci-acpi.c       |  3 ++
>  drivers/pci/pci.c            | 85 +++++++++++++++++++++++++++++---------------
>  drivers/pci/pci.h            |  9 ++++-
>  drivers/pci/pcie/aspm.c      |  7 ++--
>  drivers/pci/pcie/pme.c       | 11 ++++--
>  drivers/pci/probe.c          | 43 +++++++++++++++-------
>  drivers/pci/setup-bus.c      | 10 +++++-

Then you sprinkle this stuff into files, which have completely different
purposes, without any explanation for the particular instances why they
are supposed to be correct and how this works.

I'm just looking at the MSI parts, as I have no expertise with the rest.

> diff --git a/drivers/pci/msi/msi.c b/drivers/pci/msi/msi.c
> index 6ede55a7c5e652c80b51b10e58f0290eb6556430..7c40fde1ba0f89ad1d72064ac9e80696faeab426 100644
> --- a/drivers/pci/msi/msi.c
> +++ b/drivers/pci/msi/msi.c
> @@ -113,7 +113,8 @@ static int pci_setup_msi_context(struct pci_dev *dev)
>  
>  void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
>  {
> -	raw_spinlock_t *lock = &to_pci_dev(desc->dev)->msi_lock;
> +	struct pci_dev *pci_dev = to_pci_dev(desc->dev);
> +	raw_spinlock_t *lock = &pci_dev->msi_lock;
>  	unsigned long flags;
>  
>  	if (!desc->pci.msi_attrib.can_mask)
> @@ -122,8 +123,9 @@ void pci_msi_update_mask(struct msi_desc *desc, u32 clear, u32 set)
>  	raw_spin_lock_irqsave(lock, flags);
>  	desc->pci.msi_mask &= ~clear;
>  	desc->pci.msi_mask |= set;
> -	pci_write_config_dword(msi_desc_to_pci_dev(desc), desc->pci.mask_pos,
> -			       desc->pci.msi_mask);
> +	if (!pci_lu_adopt(pci_dev))
> +		pci_write_config_dword(pci_dev, desc->pci.mask_pos,
> +				       desc->pci.msi_mask);

This results in inconsistent state, which is a bad idea to begin
with. How is cached software state and hardware state going to be
brought in sync at some point?

If you analyzed all places, which actually depend on hardware state and
make decisions based on it, for correctness, then you failed to provide
that analysis. If not, no comment.

>  	raw_spin_unlock_irqrestore(lock, flags);
>  }
>  
> @@ -190,6 +192,9 @@ static inline void pci_write_msg_msi(struct pci_dev *dev, struct msi_desc *desc,
>  	int pos = dev->msi_cap;
>  	u16 msgctl;
>  
> +	if (pci_lu_adopt(dev))
> +		return;
> +
>  	pci_read_config_word(dev, pos + PCI_MSI_FLAGS, &msgctl);
>  	msgctl &= ~PCI_MSI_FLAGS_QSIZE;
>  	msgctl |= FIELD_PREP(PCI_MSI_FLAGS_QSIZE, desc->pci.msi_attrib.multiple);
> @@ -214,6 +219,8 @@ static inline void pci_write_msg_msix(struct msi_desc *desc, struct msi_msg *msg
>  
>  	if (desc->pci.msi_attrib.is_virtual)
>  		return;
> +	if (pci_lu_adopt(to_pci_dev(desc->dev)))
> +		return;

So you don't allow the new kernel to write the MSI message, but the
interrupt subsystem has this new message and there are places which
utilize that cached message. How is this supposed to work?

>  	/*
>  	 * The specification mandates that the entry is masked
>  	 * when the message is modified:
> @@ -279,7 +286,8 @@ static void pci_msi_set_enable(struct pci_dev *dev, int enable)
>  	control &= ~PCI_MSI_FLAGS_ENABLE;
>  	if (enable)
>  		control |= PCI_MSI_FLAGS_ENABLE;
> -	pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);
> +	if (!pci_lu_adopt(dev))
> +		pci_write_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, control);

The placement of these conditionals is arbitrary. Some are the begin of
a function, others just block the write. Is that based on some logic or
were the places selected by shabby AI queries?

>  static int msi_setup_msi_desc(struct pci_dev *dev, int nvec,
> @@ -553,6 +561,7 @@ static void pci_msix_clear_and_set_ctrl(struct pci_dev *dev, u16 clear, u16 set)
>  {
>  	u16 ctrl;
>  
> +	BUG_ON(pci_lu_adopt(dev));

Not going to happen. BUG() is only appropriate when there is absolutely
no way to handle a situation. This is as undocumented as everything else
here.

>  	pci_read_config_word(dev, dev->msix_cap + PCI_MSIX_FLAGS, &ctrl);
>  	ctrl &= ~clear;
>  	ctrl |= set;
> @@ -720,8 +729,9 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
>  	 * registers can be accessed.  Mask all the vectors to prevent
>  	 * interrupts coming in before they're fully set up.
>  	 */
> -	pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
> -				    PCI_MSIX_FLAGS_ENABLE);
> +	if (!pci_lu_adopt(dev))
> +		pci_msix_clear_and_set_ctrl(dev, 0, PCI_MSIX_FLAGS_MASKALL |
> +					    PCI_MSIX_FLAGS_ENABLE);

And for enhanced annoyance you sprinkle this condition everywhere into
the code and then BUG() when you missed an instance. Because putting it
into the function which is invoked a gazillion of times would be too
obvious, right? That would at least be tasteful, but that's not the
primary problem of all this.

Sprinkling these conditionals all over the place is absolutely
unmaintainable, error prone and burdens everyone with this insanity and
the related hard to chase bugs.

Especially as there is no concept behind this and zero documentation how
any of this should work or even be remotely correct.

Before you start the next hackery, please sit down and write up coherent
explanations:

  What is the general concept of this?

  What is the exact state in which a device is left when the old kernel
  jumps into the new kernel?

  What is the state of the MSI[-X] or legacy PCI interrupts at this
  point?

  Can the device raise interrupts during the transition from the old to
  the new kernel?

  How is the "live" state of the device reflected and restored
  throughout the interrupt subsystem?

  How is the device driver supposed to attach to the same interrupt
  state as before?

  How are the potentially different Linux interrupt numbers mapped to
  the previous state?

Before this materializes and is agreed on, this is not going anywhere.

Thanks,

        tglx

