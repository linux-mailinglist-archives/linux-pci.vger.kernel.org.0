Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6F128C579
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 03:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbfHNBPM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 21:15:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726143AbfHNBPM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Aug 2019 21:15:12 -0400
Received: from localhost (unknown [104.133.9.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9599B20665;
        Wed, 14 Aug 2019 01:15:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565745310;
        bh=/GY0TnqgyELeCuiABDNwTxGoeDVqSGuRpgIOB7HBDA8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RzPIual5AZMEi+R4YQPDg0g4ZwZ1BlFJZXpmMV+lhrks4dMM7U01pNDDD+P6Sfz95
         tGpd3ZGjHf38hR+XKKsDyOj72B6kuIVPZttJKhAsWPSgxPecZtMdnbXbVVtcKFLCwV
         YAcyXTmSrioad+Qq4ndhewUIbEAR0JaqqEcQVDFM=
Date:   Tue, 13 Aug 2019 20:15:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] PCI / PM: Check for error when reading PME status
Message-ID: <20190814011509.GB206171@google.com>
References: <20190805205214.194981-1-helgaas@kernel.org>
 <CAJZ5v0i5oVuZMxFmYiLnYPk=BsFGGiYntez3m1V5xeWgTgA4hg@mail.gmail.com>
 <20190806133638.GQ151852@google.com>
 <2341382.rHjnX2mYrU@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2341382.rHjnX2mYrU@kreacher>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Aug 14, 2019 at 01:26:56AM +0200, Rafael J. Wysocki wrote:
> On Tuesday, August 6, 2019 3:36:38 PM CEST Bjorn Helgaas wrote:
> > On Mon, Aug 05, 2019 at 11:02:51PM +0200, Rafael J. Wysocki wrote:
> > > On Mon, Aug 5, 2019 at 10:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > >
> > > > pci_check_pme_status() reads the Power Management capability to determine
> > > > whether a device has generated a PME.  The capability is in config space,
> > > > which is accessible in D0, D1, D2, and D3hot, but not in D3cold.
> > > >
> > > > If we call pci_check_pme_status() on a device that's in D3cold, config
> > > > reads fail and return ~0 data, which we erroneously interpreted as "the
> > > > device has generated a PME".
> > > >
> > > > 000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
> > > > avoided many of these problems by avoiding pci_check_pme_status() if we
> > > > think the device is in D3cold.  However, it is not a complete fix because
> > > > the device may go to D3cold after we check its power state but before
> > > > pci_check_pme_status() reads the Power Management Status Register.
> > > >
> > > > Return false ("device has not generated a PME") if we get an error response
> > > > reading the Power Management Status Register.
> > > >
> > > > Fixes: 000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
> > > > Fixes: 71a83bd727cc ("PCI/PM: add runtime PM support to PCIe port")
> > > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > > ---
> > > >  drivers/pci/pci.c | 3 +++
> > > >  1 file changed, 3 insertions(+)
> > > >
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 984171d40858..af6a97d7012b 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -2008,6 +2008,9 @@ bool pci_check_pme_status(struct pci_dev *dev)
> > > >
> > > >         pmcsr_pos = dev->pm_cap + PCI_PM_CTRL;
> > > >         pci_read_config_word(dev, pmcsr_pos, &pmcsr);
> > > > +       if (pmcsr == (u16) PCI_ERROR_RESPONSE)
> > > > +               return false;
> > > 
> > > No, sorry.
> > > 
> > > We tried that and it didn't work.
> > > 
> > > pcie_pme_handle_request() depends on this returning "true" for all
> > > bits set, as from its perspective "device is not accessible" may very
> > > well mean "device may have signaled PME".
> > 
> > Right, it's obviously wrong in the case of devices that advertise
> > D3cold in PME_Support, i.e., devices that can generate PME even with
> > main power off.  Also, we may want to try to wake up devices if the
> > config read fails for a reason other than the device being in D3cold.
> > 
> > What I don't like about the current code is that it checks
> > PCI_PM_CTRL_PME_STATUS in data that may be completely bogus.
> 
> Whether or not the other bits in the register make sense doesn't
> matter here.  Only the PME_STATUS bit matters.

Of course.  It just relies on the implicit assumption that the bit in
the error response matches the PME_STATUS state that we want, which is
a little bit ugly.

> > Do you think it would be better to do something like this:
> > 
> >   pci_read_config_word(dev, pmcsr_pos, &pmcsr);
> >   if (pmcsr == (u16) PCI_ERROR_RESPONSE) {
> >     if (pci_pme_capable(dev, PCI_PM_CAP_PME_D3cold))
> >       return true;
> >     return false;
> >   }
> > 
> > or maybe this:
> > 
> >   pci_read_config_word(dev, pmcsr_pos, &pmcsr);
> >   if (pmcsr == (u16) PCI_ERROR_RESPONSE)
> >     return true;
> 
> In this case it still would be prudent to check PME_ENABLE before
> returning true and so there is no practical difference between
> ERROR_RESPONSE and the valid data with PME_STATUS set.
> 
> Except that in the ERROR_RESPONSE case we may as well avoid the
> PMCSR write which is not going to make a difference.
> 
> > We should get PCI_ERROR_RESPONSE pretty reliably from devices in
> > D3cold, so the first possibility would cover that case.
> >
> > But since pci_check_pme_status() basically returns a hint ("true"
> > means a device *may* have generated a PME), and even if the hint is
> > wrong, the worst that happens is an unnecessary wakeup, maybe the
> > second possibility is safer.
> > 
> > What do you think?
> 
> So if you really want to avoid the PMCSR write in the ERROR_RESPONSE case,
> something like this can be done IMO:
> 
>  			return false;
>  
>  	/* Clear PME status. */
> -	pmcsr |= PCI_PM_CTRL_PME_STATUS;
>  	if (pmcsr & PCI_PM_CTRL_PME_ENABLE) {
> +		if (pmcsr == (u16) PCI_ERROR_RESPONSE)
> +			return true;
> +
>  		/* Disable PME to avoid interrupt flood. */
>  		pmcsr &= ~PCI_PM_CTRL_PME_ENABLE;
>  		ret = true;

Agreed, that's the conclusion I came to as well.  I wouldn't do this
just to avoid the config write, since as you mentioned that will get
dropped anyway.  The reason I would consider this is as an example of
how drivers might think about validating data they read from devices.

Bjorn
