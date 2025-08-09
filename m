Return-Path: <linux-pci+bounces-33667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92DEBB1F506
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 16:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A83B4563517
	for <lists+linux-pci@lfdr.de>; Sat,  9 Aug 2025 14:49:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7A36242D89;
	Sat,  9 Aug 2025 14:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FUwnYD6r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P8TkN1b8"
X-Original-To: linux-pci@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBE08277800;
	Sat,  9 Aug 2025 14:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754750981; cv=none; b=SEXFjqgAyCFXLRKUykI9zYBSVmTgnEOamzCArmIOT96Kto6By9p7/s16TqRfOoiVZWAMuTraYKOlzOy5S7GBFHylqR72bQwzYOdheGqtYCPyo9pjtIxwKvBRgRgg0KCcKKkkeB1htFRL6/EirCEIgEqXfPO54e7Y0mK3jHQb2fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754750981; c=relaxed/simple;
	bh=TtOwJT5nuwHH5WlHRA9lm2C8VHkY2rOXzKeawNZvPDM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XuHp+EQIev2hUmDo4EffsRK3J08dJJUS9dxC5iRFlIZZpXdHt2Zr7LPhMYQ/2rsrKUMiS7+BRU02wQtWYrUudCqayDF9mYFE5cioMBor/GpHJNy7q8r4+1XL/xDQorZqDWoKEA73HgJwcAsZY3VCCrGdB8lg/mT+MQLcaN4eZ0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FUwnYD6r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P8TkN1b8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 9 Aug 2025 16:49:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1754750972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9/SCsrsZbryoDL2fTGngfjXiS+0Qzb6EX+QYe9kV8Ng=;
	b=FUwnYD6rm625dYFWDPYPdbsTfo3jdHsmxKdG1n+KyloVxWN6vv2eIwj5igmqZXbKxrhG21
	Y8ivUpHxTPpJf7kSuZ+1eqSmXfp9+SiQzAcubAbZD0DyNOX+IV422EY+CewRq6STRHMkX2
	iQqy9z2LPa/tljNQ97uqP99MQ6wD+SXzj0sfJ/NSfgbBmS1eXkjU0j8GQX13B8DFSVAqkI
	HB1geKXcDkoxzJhr4wyZbK75YoPzNz415/gCbJDI38PEamiEY98sugOSzoSe3opCpUowrQ
	kHtBXJ5aTQHxFuG36CY9ci/tAFPNh5KVw58Uy3JIb5JXgcwEi2q5Kvao9tjwlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1754750972;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9/SCsrsZbryoDL2fTGngfjXiS+0Qzb6EX+QYe9kV8Ng=;
	b=P8TkN1b8CTZXvYbrb+oykxs9jubL/fwdv/IK+nzONYhtNNzmV35ykn/gOy3QB73i3wzHrx
	6GI5cbIiAIwY+XCw==
From: Nam Cao <namcao@linutronix.de>
To: Ammar Faizi <ammarfaizi2@gnuweeb.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, Lukas Wunner <lukas@wunner.de>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux PCI Mailing List <linux-pci@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Rob Herring <robh@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof Wilczynski <kwilczynski@kernel.org>,
	Armando Budianto <sprite@gnuweeb.org>,
	Alviro Iskandar Setiawan <alviro.iskandar@gnuweeb.org>,
	gwml@vger.gnuweeb.org, namcaov@gmail.com
Subject: Re: [GIT PULL v2] PCI changes for v6.17
Message-ID: <20250809144927.eUbR3MXg@linutronix.de>
References: <aJQi3RN6WX6ZiQ5i@wunner.de>
 <aJQxdBxcx6pdz8VO@linux.gnuweeb.org>
 <20250807050350.FyWHwsig@linutronix.de>
 <aJQ19UvTviTNbNk4@linux.gnuweeb.org>
 <aJXYhfc/6DfcqfqF@linux.gnuweeb.org>
 <aJXdMPW4uQm6Tmyx@linux.gnuweeb.org>
 <87ectlr8l4.fsf@yellow.woof>
 <aJZ/rum9bZqZInr+@biznet-home.integral.gnuweeb.org>
 <20250809043409.wLu40x1p@linutronix.de>
 <aJdNB8zITrkZ3n6r@linux.gnuweeb.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJdNB8zITrkZ3n6r@linux.gnuweeb.org>

On Sat, Aug 09, 2025 at 08:28:39PM +0700, Ammar Faizi wrote:
> On Sat, Aug 09, 2025 at 06:34:29AM +0200, Nam Cao wrote:
> > On Sat, Aug 09, 2025 at 07:52:30AM +0900, Ammar Faizi wrote:
> > > I can do that. Send me a git diff. I'll test it and back with the dmesg
> > > output.
> > 
> > That would be very helpful, thanks!
> > 
> > Please bear with me, this may take a few iterations.
> > 
> > Let's first try the below.
> 
> I just got home from a family outing. A bit slow response.
> 
> Here's the result:
> 
>   https://gist.github.com/ammarfaizi2/ef5f98123ed3868f8d64ed41662edd63#file-dmesg_pci_debug_001-txt-L853

Thanks! Here's the problem:

    [    1.037223] pcieport 10000:e0:1d.0: __pci_enable_msix_range:840 err=hwsize

The PCIe port driver enables interrupt, trying MSI-X first. However, the
device does not support MSI-X, so it tries MSI instead, which triggers
the WARN_ON() in VMD driver.

What's strange is that, the VMD doc says:

    "Intel VMD only supports MSIx Interrupts from child devices and
    therefore the BIOS must enable PCIe Hot Plug and MSIx interrups"

Is it lying to us?

Can you	please try:

    Revert d5c647b08ee0 ("PCI: vmd: Fix wrong kfree() in vmd_msi_free()")
    Revert d7d8ab87e3e7 ("PCI: vmd: Switch to msi_create_parent_irq_domain()")

So that the driver is back to the original state before I touched it.

And apply the diff below. This will tell us if my commit breaks the driver
somehow, or VMD has been allowing MSI all this time.


diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index d9b893bf4e45..e99d8cefb78d 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -255,9 +255,15 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 			msi_alloc_info_t *arg)
 {
 	struct msi_desc *desc = arg->desc;
+	struct pci_dev *pci_dev = msi_desc_to_pci_dev(desc);
 	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
 	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
 
+	if (!pci_msix_vec_count(pci_dev))
+		pr_err("But VMD only supports MSIx Interrupts from child devices!\n");
+	else
+		pr_err("MSI-X, looking good...\n");
+	dump_stack();
 	if (!vmdirq)
 		return -ENOMEM;
 

