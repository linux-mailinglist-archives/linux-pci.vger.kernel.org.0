Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BE73E4840
	for <lists+linux-pci@lfdr.de>; Mon,  9 Aug 2021 17:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234133AbhHIPA3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 9 Aug 2021 11:00:29 -0400
Received: from bmailout3.hostsharing.net ([176.9.242.62]:57939 "EHLO
        bmailout3.hostsharing.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234721AbhHIPA1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 9 Aug 2021 11:00:27 -0400
Received: from h08.hostsharing.net (h08.hostsharing.net [83.223.95.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout3.hostsharing.net (Postfix) with ESMTPS id 56139100D9417;
        Mon,  9 Aug 2021 17:00:05 +0200 (CEST)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id 27B0327FF26; Mon,  9 Aug 2021 17:00:05 +0200 (CEST)
Date:   Mon, 9 Aug 2021 17:00:05 +0200
From:   Lukas Wunner <lukas@wunner.de>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Sean V Kelley <sean.v.kelley@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Keith Busch <kbusch@kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI/portdrv: Disallow runtime suspend when waekup is
 required but PME service isn't supported
Message-ID: <20210809150005.GA6916@wunner.de>
References: <20210713075726.1232938-1-kai.heng.feng@canonical.com>
 <20210809042414.107430-1-kai.heng.feng@canonical.com>
 <20210809094731.GA16595@wunner.de>
 <CAAd53p7cR3EzUjEU04cDhJDY5F=5k+eRHMVNKQ=jEfbZvUQq3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAd53p7cR3EzUjEU04cDhJDY5F=5k+eRHMVNKQ=jEfbZvUQq3Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[cc += Rafael]

On Mon, Aug 09, 2021 at 06:40:41PM +0800, Kai-Heng Feng wrote:
> On Mon, Aug 9, 2021 at 5:47 PM Lukas Wunner <lukas@wunner.de> wrote:
> > On Mon, Aug 09, 2021 at 12:24:12PM +0800, Kai-Heng Feng wrote:
> > > Some platforms cannot detect ethernet hotplug once its upstream port is
> > > runtime suspended because PME isn't enabled in _OSC.
> >
> > If PME is not handled natively, why does the NIC runtime suspend?
> > Shouldn't this be fixed in the NIC driver by keeping the device
> > runtime active if PME cannot be used?
> 
> That means we need to fix every user of pci_dev_run_wake(), or fix the
> issue in pci_dev_run_wake() helper itself.

If PME is not granted to the OS, the only consequence is that the PME
port service is not instantiated at the root port.  But PME is still
enabled for downstream devices.  Maybe that's a mistake?  I think the
ACPI spec is a little unclear what to do if PME control is *not* granted.
It only specifies what to do if PME control is *granted*:

   "If the OS successfully receives control of this feature, it must
    handle power management events as described in the PCI Express Base
    Specification."

   "If firmware allows the OS control of this feature, then in the context
    of the _OSC method it must ensure that all PMEs are routed to root port
    interrupts as described in the PCI Express Base Specification.
    Additionally, after control is transferred to the OS, firmware must not
    update the PME Status field in the Root Status register or the PME
    Interrupt Enable field in the Root Control register. If control of this
    feature was requested and denied or was not requested, firmware returns
    this bit set to 0."

Perhaps something like the below is appropriate, I'm not sure.

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 091b4a4..7e64185 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -3099,7 +3099,7 @@ void pci_pm_init(struct pci_dev *dev)
 	}
 
 	pmc &= PCI_PM_CAP_PME_MASK;
-	if (pmc) {
+	if (pmc && pci_find_host_bridge(dev->bus)->native_pme) {
 		pci_info(dev, "PME# supported from%s%s%s%s%s\n",
 			 (pmc & PCI_PM_CAP_PME_D0) ? " D0" : "",
 			 (pmc & PCI_PM_CAP_PME_D1) ? " D1" : "",


> > > --- a/drivers/pci/pcie/portdrv_pci.c
> > > +++ b/drivers/pci/pcie/portdrv_pci.c
> > > @@ -59,14 +59,30 @@ static int pcie_port_runtime_suspend(struct device *dev)
> > >       return pcie_port_device_runtime_suspend(dev);
> > >  }
> > >
> > > +static int pcie_port_wakeup_check(struct device *dev, void *data)
> > > +{
> > > +     struct pci_dev *pdev = to_pci_dev(dev);
> > > +
> > > +     if (!pdev)
> > > +             return 0;
> > > +
> > > +     return pdev->wakeup_prepared;
> > > +}
> > > +
> > >  static int pcie_port_runtime_idle(struct device *dev)
> > >  {
> > > +     struct pci_dev *pdev = to_pci_dev(dev);
> > > +
> > > +     if (!pcie_port_find_device(pdev, PCIE_PORT_SERVICE_PME) &&
> > > +         device_for_each_child(dev, NULL, pcie_port_wakeup_check))
> > > +             return -EBUSY;
> > > +
> > >       /*
> > >        * Assume the PCI core has set bridge_d3 whenever it thinks the port
> > >        * should be good to go to D3.  Everything else, including moving
> > >        * the port to D3, is handled by the PCI core.
> > >        */
> > > -     return to_pci_dev(dev)->bridge_d3 ? 0 : -EBUSY;
> > > +     return pdev->bridge_d3 ? 0 : -EBUSY;
> >
> > If an additional check is necessary for this issue, it should be
> > integrated into pci_dev_check_d3cold() instead of pcie_port_runtime_idle().
> 
> I think PME IRQ and D3cold are different things here.
> The root port of the affected NIC doesn't support D3cold because
> there's no power resource.

If a bridge is runtime suspended to D3, the hierarchy below it is
inaccessible, which is basically the same as if it's put in D3cold,
hence the name pci_dev_check_d3cold().  That function allows a device
to block an upstream bridge from runtime suspending because the device
is not allowed to go to D3cold.  The function specifically checks whether
a device is PME-capable from D3cold.  The NIC claims it's capable but
the PME event has no effect because PME control wasn't granted to the
OS and firmware neglected to set PME Interrupt Enable in the Root Control
register.  We could check for this case and block runtime PM of bridges
based on the rationale that PME polling is needed to detect wakeup.

Thanks,

Lukas
