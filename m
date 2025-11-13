Return-Path: <linux-pci+bounces-41120-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB60C58C29
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 17:35:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0B4CF4FF99E
	for <lists+linux-pci@lfdr.de>; Thu, 13 Nov 2025 16:26:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69368357A32;
	Thu, 13 Nov 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rjXZ2o9I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F935581D
	for <linux-pci@vger.kernel.org>; Thu, 13 Nov 2025 16:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763050558; cv=none; b=HyfDZKyQhtji9ShdNdc088RjDMDNocVpy3sOFKceZE8ml1AYcPOW/pMMQ2uh7+kIYiNNic83XqzyhgTZuiKr7LRpfDmT0gE+hQhd9wzEUNqaBwet+ULlCgriVLZbXFkbBOy40MqI9FrnUWYQe5tk2tFTaBKo7DXMnQt9ye4xzMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763050558; c=relaxed/simple;
	bh=XQNhWvUyDWNeDKKlzU5pWy2MIeMgWmx5TtodAq+3XE8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=EzWBEYqahvkC6wSOs8rxkOG+8pGB3HpKYf01pbnUwTXCNLKcjfYvUYy/o0LmTRVAG2be47nakBSLM/m5wMn2NJ3Vipv2WwqsdH+SU/gqvd87X3HHLHqFESVD9n3eNrn5R44Liky1tyXLcQ4iCZATnmosVzwJkaqIQxFAdLgCG24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rjXZ2o9I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9490C113D0;
	Thu, 13 Nov 2025 16:15:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763050557;
	bh=XQNhWvUyDWNeDKKlzU5pWy2MIeMgWmx5TtodAq+3XE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rjXZ2o9IKx4AsQ5j7L/NQ+XjWy8FGrp8+HIh7v9L7qPzStpj+kz666dxyOpa1lVrO
	 hCKDHk3RfKMVP9NANGYf7NcwOqti0eDlnF6Vi3rP1uUhKbA5xeTD5jd1QnOMTxlMnR
	 VrylEEV3CYX02sjVuVU17hKntKr3eRXUEcCmvlieCn9egknccaB0ApqDw1XbVT90+1
	 XB+8rrRvXwHshkb20ytJEARMSZSezhTmJo/Je1JuwPY63kkU99s4/l3pJr+jAT8OeR
	 2ztMkRjkzLUzBsYGM62CHZdoZMA+03A3u3gQ50MhUDxNA4xTX/s6KtVigUdTu3q9K0
	 K7k357CvcEBEw==
Date: Thu, 13 Nov 2025 10:15:56 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Lukas Wunner <lukas@wunner.de>
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
Message-ID: <20251113161556.GA2284238@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aRWnAd-PZuHMqBwd@wunner.de>

On Thu, Nov 13, 2025 at 10:38:09AM +0100, Lukas Wunner wrote:
> On Wed, Nov 12, 2025 at 04:38:31PM -0600, Bjorn Helgaas wrote:
> > On Sun, Oct 12, 2025 at 03:25:01PM +0200, Lukas Wunner wrote:
> > > Despite these workarounds, recoverability at all times is not guaranteed:
> > > E.g. when a PCIe port goes through a runtime suspend and resume cycle,
> > > the "saved_state" flag is cleared by:
> > > 
> > >   pci_pm_runtime_resume()
> > >     pci_pm_default_resume_early()
> > >       pci_restore_state()
> > > 
> > > ... and hence on a subsequent AER event, the port's Config Space cannot be
> > > restored.  
> > 
> > I guess this restore would be done by a driver's
> > pci_error_handlers.slot_reset() or .reset_done() calling
> > pci_restore_state()?
> 
> Yes.  Restoration of config space after an error-recovery-induced reset
> is currently always the job of the device driver.
> 
> E.g. in the case of portdrv, it happens in pcie_portdrv_slot_reset().
> 
> We could revisit this design decision and change the behavior to have
> pcie_do_recovery() call pci_restore_state(), thus reducing boilerplate
> in the drivers.  But that would be a separate effort, orthogonal to the
> present patch.

Agreed.

> > > +++ b/drivers/pci/bus.c
> > > @@ -358,6 +358,13 @@ void pci_bus_add_device(struct pci_dev *dev)
> > >  	pci_bridge_d3_update(dev);
> > >  
> > >  	/*
> > > +	 * Save config space for error recoverability.  Clear state_saved
> > > +	 * to detect whether drivers invoked pci_save_state() on suspend.
> > 
> > Can we expand this a little to explain how this is detected and what
> > drivers *should* be doing?
> 
> That is documented in Documentation/power/pci.rst, "3.1.2. suspend()":
> 
>    "This callback is expected to quiesce the device and prepare it to be
>     put into a low-power state by the PCI subsystem.  It is not required
>     (in fact it even is not recommended) that a PCI driver's suspend()
>     callback save the standard configuration registers of the device [...]
> 
>     However, in some rare case it is convenient to carry out these
>     operations in a PCI driver.  Then, pci_save_state() [...] should be
>     used to save the device's standard configuration registers [...].
>     Moreover, if the driver calls pci_save_state(), the PCI subsystem will
>     not execute either pci_prepare_to_sleep(), or pci_set_power_state()
>     for its device, so the driver is then responsible for handling the
>     device as appropriate."

Yes.  I should have proposed some text for the comment, e.g.,

  Save config space for error recoverability.  Clear state_saved.  If
  driver calls pci_save_state() again, state_saved will be set and
  we'll know that on suspend, the PCI core shouldn't call
  pci_save_state() or change the device power state.

> > I think the reason is that the PCI core
> > can invoke pci_save_state() on suspend if the driver did not.
> 
> Right.  By calling pci_save_state(), a driver signals to the PCI core
> that it assumes responsibility for putting the device into a low power
> state.  If a driver wants to keep a device in D0, it could call
> pci_save_state() and thus prevent the PCI core from putting it e.g.
> into D3.

It seems like there are two things going on here, and I'm not sure
they're completely compatible:

  1) Driver calls pci_save_state() to take over device power
     management and prevent the PCI core from doing it.

  2) Driver calls pci_save_state() to capture the device state it
     wants to restore when recovering from an error.

Shouldn't a driver be able to do 2) without also getting 1)?

> > I assume:
> > 
> >   - PCI core always calls pci_save_state() and clears state_saved when
> >     device is enumerated (below)
> > 
> >   - When it has configured the device to the state it wants restore,
> >     the driver may call pci_save_state() again, which will set
> >     state_saved
> > 
> >   - If driver has not called pci_save_state(), i.e., state_saved is
> >     still clear, we want the PCI core to call pci_save_state() during
> >     suspend
> 
> Right.
> 
> > This sounds sensible to me.  It would be nice if there were a few more
> > words about pci_save_state() and pci_restore_state() in
> > Documentation/.
> > 
> > pci_save_state() isn't mentioned at all in Documentation/PCI
> 
> Right, it's documented in the Documentation/power directory. :)

Yes, in the pci.rst I mentioned, but it mostly uses the "saves the
device's standard configuration registers" wording.

I'm just wishing for a more concrete mention of "pci_save_state()",
since that's where the critical "state_saved" flag is updated.

And I'm not sure Documentation/ includes anything about the idea of
a driver using pci_save_state() to capture the state it wants to
restore after an error.  I guess that's obvious now that I write it
down, but I'm sure learning a lot from this conversation :)

Bjorn

