Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A49AA8856B
	for <lists+linux-pci@lfdr.de>; Sat, 10 Aug 2019 00:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfHIWBT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Aug 2019 18:01:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726157AbfHIWBT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 9 Aug 2019 18:01:19 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71C4F2089E;
        Fri,  9 Aug 2019 22:01:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1565388078;
        bh=g7gv0QYYb35ljO9lYoG4pHHDfLadVPRJuFZjOE++jYE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDwR44NcwyUy5qLqieDYFPX65nZosdcUdIEypACHYZl3lvY+6CqyW8/ZTS+hxjjw1
         E8O/T6Ojc44aE3AVNS7dfP0CWS3biO5peNqqWKRGpMVlGeA2EQusMMcwtQUC+dyO0B
         1/dVBQvcvXjlxTrNCeHqj8blERBfcsn25zhgBo1o=
Date:   Fri, 9 Aug 2019 17:01:16 -0500
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
Subject: Re: [PATCH 4/5] PCI / PM: Check for error when reading Power State
Message-ID: <20190809220116.GA221706@google.com>
References: <20190805205214.194981-1-helgaas@kernel.org>
 <20190805205214.194981-5-helgaas@kernel.org>
 <CAJZ5v0jFPU38zDugumJB0iq5d-LctcMCdygTrFU4=gYP3UJ+oA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jFPU38zDugumJB0iq5d-LctcMCdygTrFU4=gYP3UJ+oA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Aug 05, 2019 at 11:09:19PM +0200, Rafael J. Wysocki wrote:
> On Mon, Aug 5, 2019 at 10:52 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > The Power Management Status Register is in config space, and reads while
> > the device is in D3cold typically return ~0 data (PCI_ERROR_RESPONSE).  If
> > we just look at the PCI_PM_CTRL_STATE_MASK bits, that is 0x3, which looks
> > like D3hot, not D3cold.
> >
> > Check the entire register for PCI_ERROR_RESPONSE so we can distinguish
> > D3cold from D3hot.
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> > ---
> >  drivers/pci/pci.c   |  6 +++---
> >  include/linux/pci.h | 13 +++++++++++++
> >  2 files changed, 16 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > index af6a97d7012b..d8686e3cd5eb 100644
> > --- a/drivers/pci/pci.c
> > +++ b/drivers/pci/pci.c
> > @@ -894,7 +894,7 @@ static int pci_raw_set_power_state(struct pci_dev *dev, pci_power_t state)
> >                 udelay(PCI_PM_D2_DELAY);
> >
> >         pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > -       dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> > +       dev->current_state = pci_power_state(pmcsr);
> 
> But pci_raw_set_power_state() should not even be called for devices in
> D3_cold, so this at best is redundant.

I tried to verify that we don't call pci_raw_set_power_state() for
devices in D3cold, but it wasn't obvious to me.  Is there an easy way
to verify that?  I'd rather have code that doesn't rely on deep
knowledge about other areas.

Even if the device was in, say D0, what if it is hot-removed just
before we read PCI_PM_CTRL?  We'll set dev->current_state to D3hot,
when I think D3cold would better correspond to the state of the
device.  Maybe that's harmless, but I don't know how to verify that.

> >         if (dev->current_state != state && printk_ratelimit())
> >                 pci_info(dev, "Refused to change power state, currently in D%d\n",
> >                          dev->current_state);
> > @@ -942,7 +942,7 @@ void pci_update_current_state(struct pci_dev *dev, pci_power_t state)
> >                 u16 pmcsr;
> >
> >                 pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > -               dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> > +               dev->current_state = pci_power_state(pmcsr);
> 
> The if () branch above should cover the D3cold case, shouldn't it?

You mean the "if (platform_pci_get_power_state(dev) == PCI_D3cold)"
test?

platform_pci_get_power_state() returns PCI_UNKNOWN in some cases.
When that happens, might we not read PCI_PM_CTRL of a device in
D3cold?  I think this also has the same hotplug question as above.

> >         } else {
> >                 dev->current_state = state;
> >         }
> > @@ -1677,7 +1677,7 @@ static int pci_enable_device_flags(struct pci_dev *dev, unsigned long flags)
> >         if (dev->pm_cap) {
> >                 u16 pmcsr;
> >                 pci_read_config_word(dev, dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> > -               dev->current_state = (pmcsr & PCI_PM_CTRL_STATE_MASK);
> > +               dev->current_state = pci_power_state(pmcsr);
> 
> So this appears to be only case in which pci_power_state(pmcsr) is
> useful at all.
> 
> It might be better to use the code from it directly here IMO.

If we're decoding CSR values, I think it's better to notice error
responses when we can than it is to try to figure out whether the
error response is theoretically impossible or the incorrectly decoded
value (e.g., D3hot instead of D3cold) is harmless.

> >         }
> >
> >         if (atomic_inc_return(&dev->enable_cnt) > 1)
> > diff --git a/include/linux/pci.h b/include/linux/pci.h
> > index d64fd3788061..fdfe990e9661 100644
> > --- a/include/linux/pci.h
> > +++ b/include/linux/pci.h
> > @@ -152,6 +152,19 @@ static inline const char *pci_power_name(pci_power_t state)
> >         return pci_power_names[1 + (__force int) state];
> >  }
> >
> > +/*
> > + * Convert a Power Management Status Register value to a pci_power_t.
> > + * Note that if we read the register while the device is in D3cold, we
> > + * typically get PCI_ERROR_RESPONSE, which looks like D3hot (0x3) if we
> > + * only look at the PCI_PM_CTRL_STATE_MASK bits.
> > + */
> > +static inline pci_power_t pci_power_state(u16 pmcsr)
> > +{
> > +       if (pmcsr == (u16) PCI_ERROR_RESPONSE)
> > +               return PCI_D3cold;
> > +       return pmcsr & PCI_PM_CTRL_STATE_MASK;
> > +}
> > +
> >  #define PCI_PM_D2_DELAY                200
> >  #define PCI_PM_D3_WAIT         10
> >  #define PCI_PM_D3COLD_WAIT     100
> > --
> > 2.22.0.770.g0f2c4a37fd-goog
> >
