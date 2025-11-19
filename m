Return-Path: <linux-pci+bounces-41596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CA40C6DDED
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 11:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 063F523F50
	for <lists+linux-pci@lfdr.de>; Wed, 19 Nov 2025 10:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2F9B34845F;
	Wed, 19 Nov 2025 10:02:28 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [83.223.78.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A824F346FDA
	for <linux-pci@vger.kernel.org>; Wed, 19 Nov 2025 10:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.223.78.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763546548; cv=none; b=liYZTGI8qokIF1xQpyczQev2+rp8bz4JWG3dLEdrAnysEULNcYJNjC8ACDTfDKlr0WnZ2lnFVsYBL83swntw5zIf+PFgF3wX8s1KrPGDLXOtcfATJBVCbv4FTelUL83lezWI6VyhmaoSQd1KusctIVD7BAs6tM+685qX9t1eyPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763546548; c=relaxed/simple;
	bh=sGn1kJxiZgegLJyKtfMNC8btLrY2MArLH4GprNVMrV4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U4AvE+Lz38JqD/ut6DtDDJwFBr7y90CEAQ4c+USBcjSpOgNxcnpwVuChx3g1YIYn7icVt+duTF1NSQoSOayByPFYSXEcC2j3vrHlbor1MGxT+meU++xCjmPwZUytBMzsYsyL4xOUu4tc2XFtF4LloCE23qAif5p9cxLw0pXdBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de; spf=none smtp.mailfrom=h08.hostsharing.net; arc=none smtp.client-ip=83.223.78.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=wunner.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=h08.hostsharing.net
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384
	 client-signature ECDSA (secp384r1) client-digest SHA384)
	(Client CN "*.hostsharing.net", Issuer "GlobalSign GCC R6 AlphaSSL CA 2025" (verified OK))
	by bmailout2.hostsharing.net (Postfix) with ESMTPS id B4DB920083D4;
	Wed, 19 Nov 2025 11:02:23 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
	id A7718D5EC; Wed, 19 Nov 2025 11:02:23 +0100 (CET)
Date: Wed, 19 Nov 2025 11:02:23 +0100
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
Message-ID: <aR2VrxHGAxwpWQxF@wunner.de>
References: <aRd7y8blTOn1XYFE@wunner.de>
 <20251114233927.GA2340588@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251114233927.GA2340588@bhelgaas>

On Fri, Nov 14, 2025 at 05:39:27PM -0600, Bjorn Helgaas wrote:
> On Fri, Nov 14, 2025 at 07:58:19PM +0100, Lukas Wunner wrote:
> > On Thu, Nov 13, 2025 at 10:15:56AM -0600, Bjorn Helgaas wrote:
> > > It seems like there are two things going on here, and I'm not sure
> > > they're completely compatible:
> > > 
> > >   1) Driver calls pci_save_state() to take over device power
> > >      management and prevent the PCI core from doing it.
> > > 
> > >   2) Driver calls pci_save_state() to capture the device state it
> > >      wants to restore when recovering from an error.
> > > 
> > > Shouldn't a driver be able to do 2) without also getting 1)?
> > 
> > In general, it can:
> > 
> > A number of drivers already call pci_save_state() on probe to capture
> > the state for subsequent error recovery.  If the driver has modified
> > config space in its probe hook, then calling pci_save_state() continues
> > to make sense.  If the driver has *not* modified config space, then the
> > call becomes obsolete once this patch is accepted.
> 
> So I guess "state_saved == true" means "driver does its own power
> management and PCI core shouldn't do it", and drivers that want 2) but
> not 1) just need to set state_saved = false after they call
> pci_save_state()?
> 
> That makes sense in sort of a weird way that makes my head hurt every
> time I try to understand it.

I agree it defies common sense.  So I've just submitted a series
which adds the missing "state_saved = false" in the legacy suspend
and !pm codepaths:

https://lore.kernel.org/r/094f2aad64418710daf0940112abe5a0afdc6bce.1763483367.git.lukas@wunner.de/

After this patch, the flag is always cleared before commencing the
suspend sequence and hence there is no longer a need for drivers to
clear state_saved after they call pci_save_state().  They can just
call pci_save_state() if they've modified Config Space in their
probe hook and be done with it.

> After error recovery, those drivers will see the state the driver
> identified when it called pci_save_state().  But after resume, they
> will see the state the PCI core saved at suspend time.  Right?

Correct.  The expectation is generally that they're identical.

E.g. I've just double-checked that we're enabling wakeup *after*
pci_save_state() in pci_pm_suspend_noirq().  So when the saved
state is restored on resume and later re-used for error recovery,
we're restoring the device with wakeup disabled, which is the
right thing to do because the device is in D0 after error recovery
issues a reset.

(pci_pm_suspend_noirq() first calls pci_save_state() and then calls
pci_prepare_to_sleep(), which enables wakeup.)

Thanks,

Lukas

