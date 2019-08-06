Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 886E2832CB
	for <lists+linux-pci@lfdr.de>; Tue,  6 Aug 2019 15:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbfHFNgl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Aug 2019 09:36:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:47700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726092AbfHFNgl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 6 Aug 2019 09:36:41 -0400
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 63992206A2;
        Tue,  6 Aug 2019 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565098599;
        bh=Z+FnyuvhyHFY98v/41stQdrl5WFV8d/8/KwkxLTuC0s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1jO/BjLahJpbTqPAHOWZ3Gtqul5YAAcpR/h+ZcBUq0gsXqu0vO9fysubuai58qPHW
         NOTI4prJ+iWQWCkM/HD4dPJ8pnXabGg0d3REehztoV7uo6f2kpY0l5NUzMCZldZYX3
         qOhDdanOEeA5kqx7ewR+43T4mvwyCxyMgFBBtGXs=
Date:   Tue, 6 Aug 2019 08:36:38 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/5] PCI / PM: Check for error when reading PME status
Message-ID: <20190806133638.GQ151852@google.com>
References: <20190805205214.194981-1-helgaas@kernel.org>
 <20190805205214.194981-4-helgaas@kernel.org>
 <CAJZ5v0i5oVuZMxFmYiLnYPk=BsFGGiYntez3m1V5xeWgTgA4hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i5oVuZMxFmYiLnYPk=BsFGGiYntez3m1V5xeWgTgA4hg@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 05, 2019 at 11:02:51PM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 5, 2019 at 10:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > pci_check_pme_status() reads the Power Management capability to determine
> > whether a device has generated a PME.  The capability is in config space,
> > which is accessible in D0, D1, D2, and D3hot, but not in D3cold.
> >
> > If we call pci_check_pme_status() on a device that's in D3cold, config
> > reads fail and return ~0 data, which we erroneously interpreted as "the
> > device has generated a PME".
> >
> > 000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
> > avoided many of these problems by avoiding pci_check_pme_status() if we
> > think the device is in D3cold.  However, it is not a complete fix because
> > the device may go to D3cold after we check its power state but before
> > pci_check_pme_status() reads the Power Management Status Register.
> >
> > Return false ("device has not generated a PME") if we get an error response
> > reading the Power Management Status Register.
> >
> > Fixes: 000dd5316e1c ("PCI: Do not poll for PME if the device is in D3cold")
> > Fixes: 71a83bd727cc ("PCI/PM: add runtime PM support to PCIe port")
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pci.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index 984171d40858..af6a97d7012b 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -2008,6 +2008,9 @@ bool pci_check_pme_status(struct pci_dev *dev)
> >
> >         pmcsr_pos = dev->pm_cap + PCI_PM_CTRL;
> >         pci_read_config_word(dev, pmcsr_pos, &pmcsr);
> > +       if (pmcsr == (u16) PCI_ERROR_RESPONSE)
> > +               return false;
> 
> No, sorry.
> 
> We tried that and it didn't work.
> 
> pcie_pme_handle_request() depends on this returning "true" for all
> bits set, as from its perspective "device is not accessible" may very
> well mean "device may have signaled PME".

Right, it's obviously wrong in the case of devices that advertise
D3cold in PME_Support, i.e., devices that can generate PME even with
main power off.  Also, we may want to try to wake up devices if the
config read fails for a reason other than the device being in D3cold.

What I don't like about the current code is that it checks
PCI_PM_CTRL_PME_STATUS in data that may be completely bogus.  Do you
think it would be better to do something like this:

  pci_read_config_word(dev, pmcsr_pos, &pmcsr);
  if (pmcsr == (u16) PCI_ERROR_RESPONSE) {
    if (pci_pme_capable(dev, PCI_PM_CAP_PME_D3cold))
      return true;
    return false;
  }

or maybe this:

  pci_read_config_word(dev, pmcsr_pos, &pmcsr);
  if (pmcsr == (u16) PCI_ERROR_RESPONSE)
    return true;

We should get PCI_ERROR_RESPONSE pretty reliably from devices in
D3cold, so the first possibility would cover that case.

But since pci_check_pme_status() basically returns a hint ("true"
means a device *may* have generated a PME), and even if the hint is
wrong, the worst that happens is an unnecessary wakeup, maybe the
second possibility is safer.

What do you think?

> >         if (!(pmcsr & PCI_PM_CTRL_PME_STATUS))
> >                 return false;
