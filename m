Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8D6F1B7B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 17:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbfKFQlw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 11:41:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:48812 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727285AbfKFQlw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 11:41:52 -0500
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E45892087E;
        Wed,  6 Nov 2019 16:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573058511;
        bh=jQwOhTG9AiSFb4Z6+UeBpDvC86RGByjQu5fty6XUdyM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=I5K1NYNzikHDXgKFNN+cMrr9y9hB54GdRboHVHwfylaYJF9f9XDbCr+U2nstKHOB/
         KZ84kFmAThwL3D1VVOo1nSjP76FTvabSM9zOM0L4bChuVPlCyp8cWRj6XPbbX7HXBG
         plMBSIiEJGCU7pzSM10uHMiGU94RNIZRtJZp+OUM=
Date:   Wed, 6 Nov 2019 10:41:48 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Vidya Sagar <vidyas@nvidia.com>, Sinan Kaya <okaya@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        jonathanh@nvidia.com, linux-tegra@vger.kernel.org,
        linux-pci@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com,
        Andrew Murray <andrew.murray@arm.com>,
        Lukas Wunner <lukas@wunner.de>
Subject: Re: [PATCH] PCI: Add CRS timeout for pci_device_is_present()
Message-ID: <20191106164148.GA62969@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11429373.7ySiFsEkgL@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Nov 05, 2019 at 11:55:45AM +0100, Rafael J. Wysocki wrote:
> On Monday, November 4, 2019 6:39:04 PM CET Bjorn Helgaas wrote:
> > [+cc Andrew, Lukas]
> > 
> > On Tue, Oct 15, 2019 at 05:44:47PM +0530, Vidya Sagar wrote:
> > > On 10/15/2019 4:40 PM, Sinan Kaya wrote:
> > > > ...
> > > > I think the PCI core should be putting the device back D0 state as one
> > > > of the first actions before enumerating. Wake up could be a combination
> > > > of ACPI and/or PCI wake up depending on where your device sits in the
> > > > topology.
> > >
> > > Yup. It is indeed doing it as part of pci_power_up() in pci.c file.
> > > But, what is confusing to me is the order of the calls.
> > > pci_power_up() has following calls in the same order.
> > > 	pci_raw_set_power_state(dev, PCI_D0);
> > > 	pci_update_current_state(dev, PCI_D0);
> > > But, pci_raw_set_power_state() is accessing config space without calling
> > > pci_device_is_present() whereas pci_update_current_state() which is called
> > > later in the flow is calling pci_device_is_present()...!
> > 
> > A device should always respond to config reads unless it is in D3cold
> > or it is initializing after a reset.  IIUC you're doing a resume, not
> > a reset, so I think your device must be coming out of D3cold.  That's
> > typically done via ACPI, and I think we are missing some kind of delay
> > before our first config access:
> > 
> >   pci_power_up
> >     platform_pci_set_power_state(PCI_D0)    # eg, ACPI
> >     pci_raw_set_power_state
> >       pci_read_config_word(PCI_PM_CTRL)     # <-- first config access
> >       pci_write_config_word(PCI_PM_CTRL)
> >       pci_read_config_word(PCI_PM_CTRL)
> >     pci_update_current_state
> >       if (... || !pci_device_is_present())
> > 
> > Mika is working on some delays for the transition out of D3cold [1].
> > He's more concerned with a secondary bus behind a bridge, so I don't
> > think his patch addresses this case, but he's certainly familiar with
> > this area.
> > 
> > Huh, I'm really confused about this, too.  I don't
> > understand how resume ever works without any delay between
> > platform_pci_power_manageable() and the config reads in
> > pci_raw_set_power_state().  I must be missing something.
> 
> There is a delay in the runtime_d3cold case, see
> __pci_start_power_transition().

I see the delay in __pci_start_power_transition(), but I don't see how
it's relevant.  It's only called by pci_set_power_state(), and while
many drivers call pci_set_power_state() from legacy .resume() methods,
the pci_pm_resume_noirq() path where Vidya is seeing problems doesn't
use it.

> But overall platform_pci_power_manageable() only checks whether or
> not the platform firmware can change the power state of the device.
> If it can, it is expected to take care of any necessary delays while
> doing that (because there may be delays required by this particular
> instance of the platform firmware, beyond what is mandated by the
> PCI spec, or there may not be any need to wait at all). ...

That sounds like a reasonable argument for why firmware should be
responsible for this delay, but I don't think that's very clear in the
ACPI spec, so I wouldn't be surprised if it got missed.

Based on Vidya's backtrace, I think the resume path with problems is
this:

  pci_pm_resume_noirq
    pci_pm_default_resume_early
      pci_power_up
        if (platform_pci_power_manageable(dev))
          platform_pci_set_power_state(dev, PCI_D0)  # <-- FW delay here?
        pci_raw_set_power_state
        pci_update_current_state
          pci_device_is_present        # <-- config read returns CRS

So I think your suggestion is that Vidya's firmware should be doing
the delay inside platform_pci_set_power_state()?

Vidya, you typically work on Tegra, so I assume this is on an arm64
system?  Does it have ACPI?  Do you have access to the firmware
developers to ask about who they expect to do the delays?

> In any case, I'm not sure how useful it is to add delays for
> everyone in the cases in which a specific system needs a delay
> because of its own PM implementation limitations.  It may be better
> to quirk such systems explicitly as long as there are not too many
> quirks in there, or we'll end up adding more and more *implicit*
> quirks in the form of general delays.

I agree, a general delay doesn't sound good.  Are you thinking
something like this?

  void pci_power_up(struct pci_dev *dev)
  {
    if (platform_pci_power_manageable(dev)) {
      platform_pci_set_power_state(dev, PCI_D0);
      if (dev->XXX)
        msleep(dev->XXX);
    }
    ...

We already have dev->d3_delay and d3cold_delay, so it's getting a bit
messy to keep them all straight.

Bjorn
