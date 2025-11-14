Return-Path: <linux-pci+bounces-41269-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE13C5EFB2
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 20:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 6A72D34F4E6
	for <lists+linux-pci@lfdr.de>; Fri, 14 Nov 2025 18:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3DE2E8DF6;
	Fri, 14 Nov 2025 18:58:31 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout3.hostsharing.net (bmailout3.hostsharing.net [176.9.242.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEBBC2E091E
	for <linux-pci@vger.kernel.org>; Fri, 14 Nov 2025 18:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=176.9.242.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763146711; cv=none; b=SqjS670kueus7EXxnt/khza5twmemgNbAEUMviKKER3oqin6qI5iDumTKUnxR4ufzE7DPEZLC6yhJKZrPnJAwosnWEJ9ClZj29AqLOxSNIyAkVlnOCHkCia+vH16LHn12bZKIgcHCEpq4tfkEMLS4zkBVmqAdLDkqIjOHrXz4AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763146711; c=relaxed/simple;
	bh=utG2m9JWZCkRSWFqPBVezTjIwUJgxtoA+2n5TuVowE0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XY1WePmlJ2hJ8DejEgp4K4ljkr/cjO0iagwKtmP8MLw/T6zbb47gH2fKjA2NDQYTmiIMM7WfAvGeTj3xx9z/jY3Yr7pDX2cPmUAlVaZWQwK4JJHu/01yGrvVTcTLXwldx5TnjCMSt1cA04rVk92nxV2JImjP2hKmBmjh3ugDGRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=176.9.242.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout3.hostsharing.net (Postfix) with ESMTPS id 6D1B92C02B98;
	Fri, 14 Nov 2025 19:58:19 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id 45E521740C; Fri, 14 Nov 2025 19:58:19 +0100 (CET)
Date: Fri, 14 Nov 2025 19:58:19 +0100
From: Lukas Wunner <lukas@wunner.de>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
	Riana Tauro <riana.tauro@intel.com>,
	"Sean C. Dardis" <sean.c.dardis@intel.com>,
	Farhan Ali <alifm@linux.ibm.com>,
	Benjamin Block <bblock@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Alek Du <alek.du@intel.com>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver OHalloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-pci@vger.kernel.org,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>, qat-linux@intel.com,
	Dave Jiang <dave.jiang@intel.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	"James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH 1/2] PCI: Ensure error recoverability at all times
Message-ID: <aRd7y8blTOn1XYFE@wunner.de>
References: <aRWnAd-PZuHMqBwd@wunner.de>
 <20251113161556.GA2284238@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251113161556.GA2284238@bhelgaas>

On Thu, Nov 13, 2025 at 10:15:56AM -0600, Bjorn Helgaas wrote:
> It seems like there are two things going on here, and I'm not sure
> they're completely compatible:
> 
>   1) Driver calls pci_save_state() to take over device power
>      management and prevent the PCI core from doing it.
> 
>   2) Driver calls pci_save_state() to capture the device state it
>      wants to restore when recovering from an error.
> 
> Shouldn't a driver be able to do 2) without also getting 1)?

In general, it can:

A number of drivers already call pci_save_state() on probe to capture
the state for subsequent error recovery.  If the driver has modified
config space in its probe hook, then calling pci_save_state() continues
to make sense.  If the driver has *not* modified config space, then the
call becomes obsolete once this patch is accepted.

The reason I'm using the "in general" qualifier:

I've identified two corner cases where the PCI core neglects to set
state_saved = false before commencing the suspend sequence:

* If a driver has legacy PCI PM callbacks, pci_legacy_suspend() neglects
  to set state_saved = false.  Yet both pci_legacy_suspend() and
  pci_legacy_suspend_late() subsequently query the state_saved flag.

* If a device is unbound or its driver has no PM callbacks
  (driver->pm == NULL), pci_pm_freeze() neglects to set state_saved = false.
  Yet pci_pm_freeze_noirq() subsequently queries the state_saved flag.

In these corner cases, pci_legacy_suspend() and pci_pm_freeze() depend
on some other part of the PCI core to set state_saved = false.
For a freshly enumerated device, the flag is initialized to false by
kzalloc() and pci_device_add() also explicitly sets it to false for good
measure.  On resume (or thaw or restore), the flag is set to false by
pci_restore_state().  The latter is preserved as is by my patch and the
former is moved to pci_bus_add_device() to retain the current behavior.

Clearly, the two corner cases should be fixed and then setting
state_saved = false in pci_bus_add_device() becomes unnecessary.

I'd prefer doing that in a separate step though.

So drivers which use legacy PCI PM callbacks or have no PM callbacks
should currently not call pci_save_state() on probe without manually
setting state_saved = false afterwards.  If they neglect that, then
pci_legacy_suspend_late() and pci_pm_freeze_noirq() will not call
pci_save_state() on the next suspend cycle and so the state that
will be restored on resume is the one recorded on probe, not the
one that the device had on suspend.  If these two states happen
to be identical, there's no problem.

> > > > +++ b/drivers/pci/bus.c
> > > > @@ -358,6 +358,13 @@ void pci_bus_add_device(struct pci_dev *dev)
> > > >  	pci_bridge_d3_update(dev);
> > > >  
> > > >  	/*
> > > > +	 * Save config space for error recoverability.  Clear state_saved
> > > > +	 * to detect whether drivers invoked pci_save_state() on suspen
[...]
> > > Can we expand this a little to explain how this is detected and what
> > > drivers *should* be doing?
[...]
> Yes.  I should have proposed some text for the comment, e.g.,
> 
>   Save config space for error recoverability.  Clear state_saved.  If
>   driver calls pci_save_state() again, state_saved will be set and
>   we'll know that on suspend, the PCI core shouldn't call
>   pci_save_state() or change the device power state.

I'm fine with rewording the code comment like this, as well as splitting
the code comment as suggested by Rafael.  Would you prefer amending the
code comment when applying or should I respin with a reworded comment?

Again, clearing state_saved in pci_bus_add_device() is just a temporary
measure to retain the existing behavior.  It (and an accompanying code
comment) can be dropped once pci_legacy_suspend() and pci_pm_freeze()
are fixed.

> I'm just wishing for a more concrete mention of "pci_save_state()",
> since that's where the critical "state_saved" flag is updated.
> 
> And I'm not sure Documentation/ includes anything about the idea of
> a driver using pci_save_state() to capture the state it wants to
> restore after an error.  I guess that's obvious now that I write it
> down, but I'm sure learning a lot from this conversation :)

Okay, noted that the documentation could be improved.  I'd be glad
if this could be postponed to a separate step as well though.
I can only address problems one at a time. :)

Thanks,

Lukas

