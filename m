Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A65D8C48E
	for <lists+linux-pci@lfdr.de>; Wed, 14 Aug 2019 00:59:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfHMW7a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 18:59:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:43006 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbfHMW7a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 18:59:30 -0400
Received: from 79.184.255.155.ipv4.supernova.orange.pl (79.184.255.155) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.275)
 id 8199637f5f8090f3; Wed, 14 Aug 2019 00:59:26 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Keith Busch <keith.busch@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/5] PCI / PM: Check for error when reading Power State
Date:   Wed, 14 Aug 2019 00:59:26 +0200
Message-ID: <27964051.NtteWoIlyA@kreacher>
In-Reply-To: <20190809220116.GA221706@google.com>
References: <20190805205214.194981-1-helgaas@kernel.org> <CAJZ5v0jFPU38zDugumJB0iq5d-LctcMCdygTrFU4=gYP3UJ+oA@mail.gmail.com> <20190809220116.GA221706@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Saturday, August 10, 2019 12:01:16 AM CEST Bjorn Helgaas wrote:
> On Mon, Aug 05, 2019 at 11:09:19PM +0200, Rafael J. Wysocki wrote:
> > On Mon, Aug 5, 2019 at 10:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > >
> > > From: Bjorn Helgaas <bhelgaas@google.com>
> > >
> > > The Power Management Status Register is in config space, and reads while
> > > the device is in D3cold typically return ~0 data (PCI_ERROR_RESPONSE).  If
> > > we just look at the PCI_PM_CTRL_STATE_MASK bits, that is 0x3, which looks
> > > like D3hot, not D3cold.
> > >
> > > Check the entire register for PCI_ERROR_RESPONSE so we can distinguish
> > > D3cold from D3hot.
> > >
> > > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > > ---
> > >  drivers/pci/pci.c   |  6 +++---
> > >  include/linux/pci.h | 13 +++++++++++++
> > >  2 files changed, 16 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index af6a97d7012b..d8686e3cd5eb 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -894,7 +894,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> > >                 udelay(PCI_PM_D2_DELAY);
> > >
> > >         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > -       dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> > > +       dev->current_state = pci_power_state(pmcsr);
> > 
> > But pci_raw_set_power_state() should not even be called for devices in
> > D3_cold, so this at best is redundant.
> 
> I tried to verify that we don't call pci_raw_set_power_state() for
> devices in D3cold, but it wasn't obvious to me.  Is there an easy way
> to verify that?  I'd rather have code that doesn't rely on deep
> knowledge about other areas.

It is called in two places, pci_power_up() and pci_set_power_state().

pci_power_up() is called on resume when the whole hierarchy is
turned on and pci_set_power_state() explicitly powers up the
device if in D3cold (with the help of the platform).

And the "device not accessible at all" case should be covered by patch [2/5]
in this series.

> Even if the device was in, say D0, what if it is hot-removed just
> before we read PCI_PM_CTRL?

I guess you mean surprise-hot-removed?

Then it may as well be hot-removed after setting current_state.

> We'll set dev->current_state to D3hot,
> when I think D3cold would better correspond to the state of the
> device.  Maybe that's harmless, but I don't know how to verify that.

Well, D3cold may just be equally misleading, because the device may
very well not be present at all any more.

> > >         if (dev->current_state != state && printk_ratelimit())
> > >                 pci_info(dev, "Refused to change power state, currently in D%d\n",
> > >                          dev->current_state);
> > > @@ -942,7 +942,7 @@ void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
> > >                 u16 pmcsr;
> > >
> > >                 pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > -               dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> > > +               dev->current_state = pci_power_state(pmcsr);
> > 
> > The if () branch above should cover the D3cold case, shouldn't it?
> 
> You mean the "if (platform_pci_get_power_state(dev) == PCI_D3cold)"
> test?

Not exactly.

I mean "if (platform_pci_get_power_state(dev) == PCI_D3cold ||
!pci_device_is_present(dev))".

> platform_pci_get_power_state() returns PCI_UNKNOWN in some cases.
> When that happens, might we not read PCI_PM_CTRL of a device in
> D3cold?  I think this also has the same hotplug question as above.

Surprise hot-removal can take place at any time, in particular after setting
current_state, so adding extra checks here doesn't prevent the value of
it from becoming stale at least sometimes anyway.

> > >         } else {
> > >                 dev->current_state = state;
> > >         }
> > > @@ -1677,7 +1677,7 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
> > >         if (dev->pm_cap) {
> > >                 u16 pmcsr;
> > >                 pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > > -               dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> > > +               dev->current_state = pci_power_state(pmcsr);
> > 
> > So this appears to be only case in which pci_power_state(pmcsr) is
> > useful at all.
> > 
> > It might be better to use the code from it directly here IMO.
> 
> If we're decoding CSR values, I think it's better to notice error
> responses when we can than it is to try to figure out whether the
> error response is theoretically impossible or the incorrectly decoded
> value (e.g., D3hot instead of D3cold) is harmless.

IMO this means more complex code and extra overhead for a very
little practical value, however.



