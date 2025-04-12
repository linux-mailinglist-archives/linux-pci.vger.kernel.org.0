Return-Path: <linux-pci+bounces-25710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF8BA86A9A
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 05:36:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 701071B8667E
	for <lists+linux-pci@lfdr.de>; Sat, 12 Apr 2025 03:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1559C43AA4;
	Sat, 12 Apr 2025 03:36:37 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [83.223.95.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE9BE28FF;
	Sat, 12 Apr 2025 03:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.95.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744428997; cv=none; b=lcPaTbXkffumrDNzMPrwwIKYkCYqRnR/CU0HhebzvejRIxinRCELxJaP+fMbNLZYyHgxh2jiCtpHjgMJJ6XrvXugCw47V2MlmvRPgIDpTPHFkrUdZ42pXdReG1kYNM+j4YgszLgTnHuYyCUYlohfp6UAfL+jf8CmbACUd10oCko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744428997; c=relaxed/simple;
	bh=2SYRdqrN9XHQA50CH2L1MU0Mczru0UjJCmWSUDuOAQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCaMwk8Pr6EDiRJZxP9/ojHo/XyGP5FQz2tNyJZvP9pxs34XJ84zUwLH4WF0HxiMu4fTqxqtvaxY9xBisMHi0d6UCm9qo1x8QBtP0BmX/zZCS0KzSozmR2lznrem3wNDpPBA52KPA+0SYXrzSvtNvFlqVPLwKZFw4Ac/hGrDtPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.95.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout1.hostsharing.net (Postfix) with ESMTPS id 1CFCA2C4C0D2;
	Sat, 12 Apr 2025 05:35:53 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id D42BB70299; Sat, 12 Apr 2025 05:36:24 +0200 (CEST)
Date: Sat, 12 Apr 2025 05:36:24 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, Keith Busch <kbusch@kernel.org>,
	Yicong Yang <yangyicong@hisilicon.com>, linux-pci@vger.kernel.org,
	Stuart Hayes <stuart.w.hayes@gmail.com>,
	Mika Westerberg <mika.westerberg@linux.intel.com>,
	Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
	Joel Mathew Thomas <proxy0@tutamail.com>,
	Russ Weight <russ.weight@linux.dev>,
	Matthew Gerlach <matthew.gerlach@altera.com>,
	Yilun Xu <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
	Moshe Shemesh <moshe@nvidia.com>, Shay Drory <shayd@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 2/2] PCI: pciehp: Ignore Link Down/Up caused by Secondary
 Bus Reset
Message-ID: <Z_nfuGrVh_CO7vbe@wunner.de>
References: <cover.1744298239.git.lukas@wunner.de>
 <d04deaf49d634a2edf42bf3c06ed81b4ca54d17b.1744298239.git.lukas@wunner.de>
 <3e12d065-77b1-49f0-9ee7-32b49c3ab9ef@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e12d065-77b1-49f0-9ee7-32b49c3ab9ef@linux.intel.com>

On Fri, Apr 11, 2025 at 03:28:15PM -0700, Sathyanarayanan Kuppuswamy wrote:
> On 4/10/25 8:27 AM, Lukas Wunner wrote:
> > Introduce two helpers to annotate code sections which cause spurious link
> > changes:  pci_hp_ignore_link_change() and pci_hp_unignore_link_change()
> > Use those helpers in lieu of masking interrupts in the Slot Control
> > register.
> > 
> > Introduce a helper to check whether such a code section is executing
> > concurrently and if so, await it:  pci_hp_spurious_link_change()
> > Invoke the helper in the hotplug IRQ thread pciehp_ist().  Re-use the
> > IRQ thread's existing code which ignores DPC-induced link changes unless
> > the link is unexpectedly down after reset recovery or the device was
> > replaced during the bus reset.
> 
> Since most of the changes in this patch is related to adding framework to
> ignore spurious hotplug event, why not split it in to a separate patch?

The idea is to ease backporting.  The issue fixes VFIO passthrough on
v6.13-rc1 and newer, so the patch will have to be backported at least
to v6.13, v6.14, v6.15.


> Is this fix tested in any platform?

Yes, Joel Mathew Thomas successfully tested it:

https://bugzilla.kernel.org/show_bug.cgi?id=219765

That's an Asus TUF FA507NU dual-GPU laptop (AMD CPU + Nvidia discrete GPU).
The Nvidia GPU is passed through to a VM.


> > --- a/drivers/pci/pci.h
> > +++ b/drivers/pci/pci.h
> > @@ -227,6 +227,7 @@ static inline bool pcie_downstream_port(const struct pci_dev *dev)
> >   /* Functions for PCI Hotplug drivers to use */
> >   int pci_hp_add_bridge(struct pci_dev *dev);
> > +bool pci_hp_spurious_link_change(struct pci_dev *pdev);
> 
> Do you expect this function used outside hotplug code? If not why not leave
> the declaration in pciehp.h?

Any hotplug driver may call this.  In particular, there are two other drivers
implementing the ->reset_slot() callback: pnv_php.c and s390_pci_hpc.c

pnv_php.c does a similar dance as pciehp_hpc.c (before this patch):
It disables the interrupt, performs a Secondary Bus Reset, clears spurious
events and re-enables the interrupt.  I think it can be converted to use
the newly introduced API.  That should make it more robust against removal
or replacement of the device during the Secondary Bus Reset.

Also, to cope with runtime suspend to D3cold, there's an ignore_hotplug
bit in struct pci_dev.  The bit is set by drivers for discrete GPUs and
is honored by acpiphp and pciehp.  I'd like to remove the bit in favor
of the new mechanism introduced here and that means acpiphp will have to
be converted to call pci_hp_spurious_link_change().

One thing that's problematic about the current behavior is that hotplug
events are ignored wholesale for GPUs which runtime suspend to D3cold.
That works for discrete GPUs in laptops which are soldered down on the
mainboard, but doesn't work for GPUs which are plugged into an actual
hotplug port, e.g. data center GPUs.  The new API will allow detecting
and ignoring spurious events in a more surgical manner.  I envision
that __pci_set_power_state() will call pci_hp_ignore_link_change()
if the target power state is D3cold.  Also vga_switcheroo.c will have
to call that.  But none of the GPU drivers will have to call
pci_ignore_hotplug() anymore.

To summarize, there are at least two other hotplug drivers besides pciehp
which I expect will call pci_hp_spurious_link_change() in the foreseeable
future, acpiphp and pnv_php, hence the declaration is not in pciehp.h
but in drivers/pci/pci.h.


> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -1848,6 +1848,14 @@ static inline void pcie_no_aspm(void) { }
> >   static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
> >   #endif
> > +#ifdef CONFIG_HOTPLUG_PCI
> > +void pci_hp_ignore_link_change(struct pci_dev *pdev);
> > +void pci_hp_unignore_link_change(struct pci_dev *pdev);
> > +#else
> > +static inline void pci_hp_ignore_link_change(struct pci_dev *pdev) { }
> > +static inline void pci_hp_unignore_link_change(struct pci_dev *pdev) { }
> > +#endif
> > +
> 
> Generally we expose APIs when we really need it.  Since you have already
> identified some use cases where you will use it in other drivers, why not
> include one such change as an example?

Mostly because I wanted to get this fix out the door quickly before more
people come across the regression it addresses.

Converting the Mellanox Ethernet driver to use the API would require an ack
from its maintainers.  Since it's not urgent, I was planning to do that in
a subsequent cycle.  Same for the conversion of D3cold handling.

Thanks,

Lukas

