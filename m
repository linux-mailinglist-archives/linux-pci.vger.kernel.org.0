Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEBD437278
	for <lists+linux-pci@lfdr.de>; Fri, 22 Oct 2021 09:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231758AbhJVHDG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 22 Oct 2021 03:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhJVHDF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 22 Oct 2021 03:03:05 -0400
X-Greylist: delayed 462 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 22 Oct 2021 00:00:48 PDT
Received: from bmailout2.hostsharing.net (bmailout2.hostsharing.net [IPv6:2a01:37:3000::53df:4ef0:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F973C061764;
        Fri, 22 Oct 2021 00:00:48 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout2.hostsharing.net (Postfix) with ESMTPS id 9F2392800C91C;
        Fri, 22 Oct 2021 08:53:01 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 925C3189034; Fri, 22 Oct 2021 08:53:01 +0200 (CEST)
Date:   Fri, 22 Oct 2021 08:53:01 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Check PCIe upstream port for PME support
Message-ID: <20211022065301.GA17656@wunner.de>
References: <20210812153944.813949-1-kai.heng.feng@canonical.com>
 <CAAd53p7sPoH-MD9VMh1u+mf_E7Mc2xVfkHbhN4PCdxQM+v274g@mail.gmail.com>
 <6289c754-3580-4102-8ff2-666c3cad8da2@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6289c754-3580-4102-8ff2-666c3cad8da2@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 21, 2021 at 09:13:29PM +0200, Rafael J. Wysocki wrote:
> On 10/21/2021 8:56 AM, Kai-Heng Feng wrote:
> > On Thu, Aug 12, 2021 at 11:39 PM Kai-Heng Feng <kai.heng.feng@canonical.com> wrote:
> > > Some platforms cannot detect ethernet hotplug once its upstream port is
> > > runtime suspended because PME isn't granted by BIOS _OSC. The issue can
> > > be workarounded by "pcie_ports=native".
> > > 
> > > The vendor confirmed that the PME in _OSC is disabled intentionally for
> > > system stability issues on the other OS, so we should also honor the PME
> > > setting here.
> > > 
> > > So before marking PME support status for the device, check
> > > PCI_EXP_RTCTL_PMEIE bit to ensure PME interrupt is either enabled by
> > > firmware or OS.
> 
> So you basically want to check whether or not the PME interrupts are
> configured on the port?

This platform doesn't grant PME handling to OSPM, but the platform
doesn't handle PME itself either (recognizable by the fact that it
didn't set the PME Interrupt Enable bit in the Root Control Register).

The rationale of the patch is to recognize this situation and rely
on PME polling instead.

That is achieved by assuming no PME support for the device, despite
the device claiming that PME is supported.

(This information should probably be included in the commit message.)


> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index aacf575c15cf..4344dc302edd 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -2294,6 +2294,32 @@ void pci_pme_wakeup_bus(struct pci_bus *bus)
> > >                  pci_walk_bus(bus, pci_pme_wakeup, (void *)true);
> > >   }
> > > 
> > > +#ifdef CONFIG_PCIE_PME
> > > +static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
> > > +{
> > > +       struct pci_dev *bridge = pci_upstream_bridge(dev);
> > > +       u16 val;
> > > +       int ret;
> > > +
> > > +       if (!bridge)
> > > +               return true;
> > > +
> > > +       if (pci_pcie_type(bridge) != PCI_EXP_TYPE_ROOT_PORT &&
> > > +           pci_pcie_type(bridge) != PCI_EXP_TYPE_RC_EC)
> > > +               return true;
> > > +
> > > +       ret = pcie_capability_read_word(bridge, PCI_EXP_RTCTL, &val);
> > > +       if (ret)
> > > +               return false;
> > > +
> > > +       return val & PCI_EXP_RTCTL_PMEIE;
> > > +}
> > > +#else
> > > +static bool pci_pcie_port_pme_enabled(struct pci_dev *dev)
> > > +{
> > > +       return true;
> > > +}
> > > +#endif
> > > 
> > >   /**
> > >    * pci_pme_capable - check the capability of PCI device to generate PME#
> > > @@ -3095,7 +3121,7 @@ void pci_pm_init(struct pci_dev *dev)
> > >          }
> > > 
> > >          pmc &= PCI_PM_CAP_PME_MASK;
> > > -       if (pmc) {
> > > +       if (pmc && pci_pcie_port_pme_enabled(dev)) {
> > >                  pci_info(dev, "PME# supported from%s%s%s%s%s\n",
> > >                           (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
> > >                           (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",
> > > --
> > > 2.32.0
