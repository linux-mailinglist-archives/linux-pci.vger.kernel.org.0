Return-Path: <linux-pci+bounces-28326-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421FDAC2570
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 16:51:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3272B17D733
	for <lists+linux-pci@lfdr.de>; Fri, 23 May 2025 14:51:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537F7295DBF;
	Fri, 23 May 2025 14:51:26 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79C1202F9A
	for <linux-pci@vger.kernel.org>; Fri, 23 May 2025 14:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748011886; cv=none; b=LeZaxtgPPg9t9ue9eSmIEomLQzbfdz/qA4Qm2HRzKJX6NbSTPp6mpbHTTs//3msvE0tT/PfNBQWzNnGKgA4KkZMuN0tbyi0YPSysZgCxnkvfbxoGUk7Ef57uQ1a80LLGI4v5veXbKf4HjrtJHs+T43YKdsSFXWVUphQ1Sre61OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748011886; c=relaxed/simple;
	bh=HpDqXAifIWpgG4RrtD+7J1Z7DSa77QLR4hW8UjGd6rg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VmR/W6ysbC0GnvEYyB3mygb6r6Z2qwsncGQonJVuouhIILo03VVi4xfyDLcTWWCdsLe0pkLHc5mjeRtoZ60np1TV7G92XC7PGWKvHwUjIN5DUJhAPYmRNCYRBo7rxxiyOA1mjflSgI0H8G4TOYf+uzBbAUBCGeZDLIgysi6ZzIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256
	 client-signature RSA-PSS (4096 bits) client-digest SHA256)
	(Client CN "*.hostsharing.net", Issuer "RapidSSL TLS RSA CA G1" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id E4EB62C05241;
	Fri, 23 May 2025 16:51:14 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id C5D9E24814F; Fri, 23 May 2025 16:51:14 +0200 (CEST)
Date: Fri, 23 May 2025 16:51:14 +0200
From: Lukas Wunner <lukas@wunner.de>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Niklas Cassel <cassel@kernel.org>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	Bjorn Helgaas <helgaas@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: reset_slot() callback not respecting MPS config
Message-ID: <aDCLYl3y-4ktQrjH@wunner.de>
References: <aC9OrPAfpzB_A4K2@ryzen>
 <aDAInK0F0Qh7QTiw@wunner.de>
 <hqdp64mksr6whmncm5dhrjima32v5oyng4ov6hdklcamqtm4ib@prsatdutb5oj>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <hqdp64mksr6whmncm5dhrjima32v5oyng4ov6hdklcamqtm4ib@prsatdutb5oj>

On Fri, May 23, 2025 at 12:09:06PM +0530, Manivannan Sadhasivam wrote:
> On Fri, May 23, 2025 at 07:33:16AM +0200, Lukas Wunner wrote:
> > On Thu, May 22, 2025 at 06:19:56PM +0200, Niklas Cassel wrote:
> > > As you know the reset_slot() callback patches were merged recently.
> > > 
> > > Wilfred and I (mostly Wilfred), have been debugging DMA issues after the
> > > reset_slot() callback has been invoked. The issue is reproduced when MPS
> > > configuration is set to performance, but might be applicable for other
> > > MPS configurations as well. The problem appears to be that reset_slot()
> > > feature does not respect/restore the MPS configuration.
> > 
> > The Device Control register (and thus the MPS setting) is saved via:
> > 
> >   pci_save_state()
> >     pci_save_pcie_state()
> > 
> > So either you're missing a call to pci_restore_state() after reset,
> > or you're missing a call to pci_save_state() after changing MPS,
> > or MPS is somehow overwritten after pci_restore_state().
> 
> I think the issue is that the PCI bridge is getting reset while trying
> to reset the PCI device. And in the reset path, we only save the config
> space of the *device*, not the bridge.
> 
> As seen from the lspci output shared by Niklas, the content of the PCI
> bridge seem to be diverged. Since the reset_slot() callback resets the
> whole Root Complex (if there is a single Root port), then the config
> space of the Root port/bridge needs to be saved and restored as well.
> 
> I believe pcibios_reset_secondary_bus() is not supposed to change the
> config space of the root port. As per the definition of the "Secondary
> Bus Reset" field in the Bridge Control Register, r3.0, sec 7.5.3.6:
> 
> "Port configuration registers must not be changed, except as required
> to update Port status."
> 
> So pci_reset_secondary_bus() is not changing the config space,
> but reset_slot() does. Are we plugging reset_slot() at the wrong place?

On ACPI-based platforms (x86 etc), I'm not aware that it's possible
to reset the Root Complex.  If it is, I don't think we've exposed
that feature and hence we don't really have a better place to hook
into.

There's the pci_reset_fn_methods[] array and conceivably, an entry
could be added there to reset the Root Port on capable platforms.
However that array is meant to reset a single PCI function,
whereas the ->reset_slot() also resets the entire hierarchy below
the Root Port (IIUC).  So that's not really what the array is
meant to be used for.

You wanted to use ->reset_slot() for aer_root_reset().  It performs
a Secondary Bus Reset via:

  pci_bus_error_reset()
    pci_bus_reset()
      pci_bridge_secondary_bus_reset()

or:

  pci_bus_error_reset()
    pci_slot_reset()
      pci_reset_hotplug_slot()
        hotplug->ops->reset_slot()
	  pciehp_reset_slot()      # or other hotplug driver
	    pci_bridge_secondary_bus_reset()

...and that's the reason I suggested to plumb ->reset_slot()
into pcibios_reset_secondary_bus().  I don't think we have
a better place.

If all host bridge drivers reset the Root Complex as part of
->reset_slot(), then it should be fine to just call
pci_save_state(dev) before and pci_restore_state(dev) after
invoking host->reset_slot() in pcibios_reset_secondary_bus().

If however this behavior is specific only to certain host
bridge drivers, then you want to call pci_save_state() and
pci_restore_state() directly in their ->reset_slot()
implementations.

I note that if you have a deeper hierarchy with PCIe switches
below the host bridge, you'll reset the Root Complex even if
the error was reported further down in the hierarchy by some
Switch Downstream Port.  I think in that case you may not
want to reset the Root Complex, but only perform a Secondary
Bus Reset at that Downstream Port.  In other words,
I'm wondering if pcibios_reset_secondary_bus() should invoke
host->reset_slot() only if dev is a Root Port / is sitting
on the root bus.

I'm also wondering if ->reset_slot() should be renamed to
something like ->reset_root_complex() or ->reset_root_port()
or somesuch to more aptly describe what it does.
I guess the name ->reset_slot() came about because these
Root Complexes typically consist of a single Root Port with
a single slot.

Thanks,

Lukas

