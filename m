Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55C0D1A2FA2
	for <lists+linux-pci@lfdr.de>; Thu,  9 Apr 2020 08:54:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725783AbgDIGyR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Apr 2020 02:54:17 -0400
Received: from mga01.intel.com ([192.55.52.88]:18061 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725283AbgDIGyQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Apr 2020 02:54:16 -0400
IronPort-SDR: z2Kj980aeLYwx9866m+2ZWtbw/40EgglqLjL85snLPDbmF41csr1vfC3qPkYAdNNa6M1kQlO8e
 XYHu/7ZWLr7A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2020 23:54:16 -0700
IronPort-SDR: ruTkEYvvUwgEztQQYdfBHxHyZuiI0YH8q50eBJjeNddnPGx4k0X+aWSh48PkQQhcA+b0Kr3o6O
 pcYqBbG4orsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,361,1580803200"; 
   d="scan'208";a="362075766"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 08 Apr 2020 23:54:12 -0700
Received: by lahna (sSMTP sendmail emulation); Thu, 09 Apr 2020 09:54:11 +0300
Date:   Thu, 9 Apr 2020 09:54:11 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>, Lukas Wunner <lukas@wunner.de>,
        Keith Busch <keith.busch@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Mario.Limonciello@dell.com,
        Anthony Wong <anthony.wong@canonical.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sakari Ailus <sakari.ailus@iki.fi>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: Re: [PATCH v2 10/10] PCI / ACPI: Whitelist D3 for more PCIe hotplug
 ports
Message-ID: <20200409065411.GH2567@lahna.fi.intel.com>
References: <20200408060409.GJ2567@lahna.fi.intel.com>
 <20200408201208.GA87230@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408201208.GA87230@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Apr 08, 2020 at 03:12:08PM -0500, Bjorn Helgaas wrote:
> On Wed, Apr 08, 2020 at 09:04:09AM +0300, Mika Westerberg wrote:
> > On Tue, Apr 07, 2020 at 06:54:23PM -0500, Bjorn Helgaas wrote:
> > > On Thu, Sep 13, 2018 at 05:33:22PM +0300, Mika Westerberg wrote:
> > > > In order to have better power management for Thunderbolt PCIe chains,
> > > > Windows enables power management for native PCIe hotplug ports if there
> > > > is following ACPI _DSD attached to the root port:
> > > > 
> > > >   Name (_DSD, Package () {
> > > >       ToUUID ("6211e2c0-58a3-4af3-90e1-927a4e0c55a4"),
> > > >       Package () {
> > > >           Package () {"HotPlugSupportInD3", 1}
> > > >       }
> > > >   })
> > > > 
> > > > This is also documented in:
> > > > 
> > > >   https://docs.microsoft.com/en-us/windows-hardware/drivers/pci/dsd-for-pcie-root-ports#identifying-pcie-root-ports-supporting-hot-plug-in-d3
> > > 
> > > This doc basically says that if the platform supplies this _DSD, the
> > > root port is "capable of handling hot plug events while in D3 state".
> > > 
> > > What does that mean?  That statement is not really actionable.  I
> > > *assume* it's telling us about some specific hardware or firmware
> > > functionality, like maybe we'll get a notification for hotplug events
> > > when the device is in D3?  D3hot?  D3cold?  What is the notification?
> > > Is it immediate or when the device comes back to D0?  How do we
> > > control and field the notification?
> > 
> > I think it simply gives the OS a hint that it can put PCIe hotplug
> > capable port into D3 and expect it to wake up when device is detected.
> 
> I'd really like more specific details than this.  PCI power management
> is explicitly controlled by software, so I don't know what it means
> for a bridge to "wake up when device is detected."

Note these are for PCIe which is not the same as the paraller PCI.

What I mean here is that there is some sort of wake depending whether
the link is in L1 or L2/L3 and then resulting the link to go to L0 and
PME message being send over to the root complex.

> Normally Linux would get some kind of notification like a PME, then
> execute an ACPI method and/or write PCI_PM_CTRL to put the device back
> in D0.

Right.

> Are we talking about D3hot or D3cold?

My interpretation is that both (D3 implies both D3hot and D3cold) but I
did not write that spec.

Systems where this is used typically go down to D3cold with the PCIe
topology (links are in L2).

> The PCI PM capability already has a way to advertise that it can
> generate PME from D3cold.  How is this different from that?

Well you always need some platform (ACPI) help in order to even to
D3cold. This applies to waking up as well. The PCIe device may advertise
that it supports this but I don't think it can be sure that the system
it is connected to has this plumbing.

For PCIe hotplug ports there have been issues that have prevented doing
power management for those. The _DSD is there to provide a hint to the
OS saying that yeah, this port actually is expected to work even if it
goes into D3 (cold/hot).

> Is this _DSD something that *could* be advertised via PCI config
> space, i.e., is it completely determined by the Root Port?  Or is it
> something that requires ACPI support, so it cannot be done directly by
> the hardware device?

You always need help from platform (ACPI) to get into D3cold.

> These are all things we need to know in order to make power management
> reliable.
> 
> > > > Do the same in Linux by introducing new firmware PM callback (->bridge_d3())
> > > > and then implement it for ACPI based systems so that the above property is
> > > > checked.
> > > > 
> > > > There is one catch, though. The initial pci_dev->bridge_d3 is set before
> > > > the root port has ACPI companion bound (the device is not added to the
> > > > PCI bus either) so we need to look up the ACPI companion manually in
> > > > that case in acpi_pci_bridge_d3().
> > > > 
> > > > Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> > > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > > ---
> > > >  drivers/acpi/property.c |  3 +++
> > > >  drivers/pci/pci-acpi.c  | 41 +++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/pci/pci.c       |  9 +++++++++
> > > >  drivers/pci/pci.h       |  3 +++
> > > >  4 files changed, 56 insertions(+)
> > > > 
> > > > diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
> > > > index 90ba9371bae6..8c7c4583b52d 100644
> > > > --- a/drivers/acpi/property.c
> > > > +++ b/drivers/acpi/property.c
> > > > @@ -28,6 +28,9 @@ static const guid_t prp_guids[] = {
> > > >  	/* ACPI _DSD device properties GUID: daffd814-6eba-4d8c-8a91-bc9bbf4aa301 */
> > > >  	GUID_INIT(0xdaffd814, 0x6eba, 0x4d8c,
> > > >  		  0x8a, 0x91, 0xbc, 0x9b, 0xbf, 0x4a, 0xa3, 0x01),
> > > > +	/* Hotplug in D3 GUID: 6211e2c0-58a3-4af3-90e1-927a4e0c55a4 */
> > > > +	GUID_INIT(0x6211e2c0, 0x58a3, 0x4af3,
> > > > +		  0x90, 0xe1, 0x92, 0x7a, 0x4e, 0x0c, 0x55, 0xa4),
> > > >  };
> > > >  
> > > >  static const guid_t ads_guid =
> > > > diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> > > > index f8436d1c4d45..c8d0549580f4 100644
> > > > --- a/drivers/pci/pci-acpi.c
> > > > +++ b/drivers/pci/pci-acpi.c
> > > > @@ -519,6 +519,46 @@ static pci_power_t acpi_pci_choose_state(struct pci_dev *pdev)
> > > >  	return PCI_POWER_ERROR;
> > > >  }
> > > >  
> > > > +static struct acpi_device *acpi_pci_find_companion(struct device *dev);
> > > > +
> > > > +static bool acpi_pci_bridge_d3(struct pci_dev *dev)
> > > > +{
> > > > +	const struct fwnode_handle *fwnode;
> > > > +	struct acpi_device *adev;
> > > > +	struct pci_dev *root;
> > > > +	u8 val;
> > > > +
> > > > +	if (!dev->is_hotplug_bridge)
> > > > +		return false;
> > > > +
> > > > +	/*
> > > > +	 * Look for a special _DSD property for the root port and if it
> > > > +	 * is set we know the hierarchy behind it supports D3 just fine.
> > > > +	 */
> > > > +	root = pci_find_pcie_root_port(dev);
> > > > +	if (!root)
> > > > +		return false;
> > > > +
> > > > +	adev = ACPI_COMPANION(&root->dev);
> > > > +	if (root == dev) {
> > > > +		/*
> > > > +		 * It is possible that the ACPI companion is not yet bound
> > > > +		 * for the root port so look it up manually here.
> > > > +		 */
> > > > +		if (!adev && !pci_dev_is_added(root))
> > > > +			adev = acpi_pci_find_companion(&root->dev);
> > > > +	}
> > > > +
> > > > +	if (!adev)
> > > > +		return false;
> > > > +
> > > > +	fwnode = acpi_fwnode_handle(adev);
> > > > +	if (fwnode_property_read_u8(fwnode, "HotPlugSupportInD3", &val))
> > > > +		return false;
> > > > +
> > > > +	return val == 1;
> > > > +}
> > > > +
> > > >  static bool acpi_pci_power_manageable(struct pci_dev *dev)
> > > >  {
> > > >  	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
> > > > @@ -635,6 +675,7 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
> > > >  }
> > > >  
> > > >  static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
> > > > +	.bridge_d3 = acpi_pci_bridge_d3,
> > > >  	.is_manageable = acpi_pci_power_manageable,
> > > >  	.set_state = acpi_pci_set_power_state,
> > > >  	.get_state = acpi_pci_get_power_state,
> > > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > > index 1af6f1887986..b1b3052f15dc 100644
> > > > --- a/drivers/pci/pci.c
> > > > +++ b/drivers/pci/pci.c
> > > > @@ -791,6 +791,11 @@ static inline bool platform_pci_need_resume(struct pci_dev *dev)
> > > >  	return pci_platform_pm ? pci_platform_pm->need_resume(dev) : false;
> > > >  }
> > > >  
> > > > +static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
> > > > +{
> > > > +	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
> > > 
> > > This patch added a .bridge_d3() implementation for ACPI but not for
> > > MID.  What prevents us from calling platform_pci_bridge_d3() on a MID
> > > platform and trying to call through a NULL pointer?
> > > 
> > > Shouldn't we do something like the patch attached below?
> > 
> > IIRC MID devices in general don't have PCIe ports (so we never enable PM
> > for them). Is this a real problem that crashes peoples kernels on MID
> > systems? Then yes I think the patch makes sense to have.
> > 
> > I also remember testing some other stuff on one MID system (Edison)
> > quite recently and did not see any issues.
> 
> I have not seen reports of crashes, but I do think this is a real
> problem.  The problem is that the code as-is relies on assumptions
> ("MID does not have PCI and never will") that are implicit and
> impossible to verify, which is a maintenance problem.

Well, there won't be any new MID devices and the only one we support
partially is Edison and it does not have a single PCIe port that could
even be power managed.

> > > > +}
> > > > +
> > > >  /**
> > > >   * pci_raw_set_power_state - Use PCI PM registers to set the power state of
> > > >   *                           given PCI device
> > > > @@ -2514,6 +2519,10 @@ bool pci_bridge_d3_possible(struct pci_dev *bridge)
> > > >  		if (bridge->is_thunderbolt)
> > > >  			return true;
> > > >  
> > > > +		/* Platform might know better if the bridge supports D3 */
> > > > +		if (platform_pci_bridge_d3(bridge))
> > > > +			return true;
> > > 
> > > *All* devices trivially support D3.  Obviously we're trying to learn
> > > something else here.  What is it?
> > 
> > D3 has been problematic with hotplug bridges which is the reason we have
> > not put them in D3 until recently (and still don't do that for ACPI
> > hotplug bridges).
> > 
> > BTW, this patch was merged over a year ago so I'm not sure why you comment
> > it now. Or you want me to add incremental changes to it?
> 
> I was reviewing [1], which updates pci_find_pcie_root_port(), which is
> used by acpi_pci_bridge_d3().  I noticed a potential NULL pointer
> dereference, which was a distraction.
> 
> Unless you object, I'll merge something like the patch below to
> prevent that distraction for others.

No objections :)

However, in order to make this more maintainable, what if we check in
the platform_pci_bridge_d3() itself whether the pointer is NULL and
return false? That would work for any future platforms and avoid adding
the dummy implementation each time.

> [1] https://lore.kernel.org/r/1586262717-23566-1-git-send-email-yangyicong@hisilicon.com
> 
> > > >  		/*
> > > >  		 * Hotplug ports handled natively by the OS were not validated
> > > >  		 * by vendors for runtime D3 at least until 2018 because there
> > > > diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> > > > index 6e0d1528d471..66fd5c1bf71b 100644
> > > > --- a/drivers/pci/pci.h
> > > > +++ b/drivers/pci/pci.h
> > > > @@ -39,6 +39,8 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
> > > >  /**
> > > >   * struct pci_platform_pm_ops - Firmware PM callbacks
> > > >   *
> > > > + * @bridge_d3: Does the bridge allow entering into D3
> > > > + *
> > > >   * @is_manageable: returns 'true' if given device is power manageable by the
> > > >   *		   platform firmware
> > > >   *
> > > > @@ -60,6 +62,7 @@ int pci_bridge_secondary_bus_reset(struct pci_dev *dev);
> > > >   * these callbacks are mandatory.
> > > >   */
> > > >  struct pci_platform_pm_ops {
> > > > +	bool (*bridge_d3)(struct pci_dev *dev);
> > > >  	bool (*is_manageable)(struct pci_dev *dev);
> > > >  	int (*set_state)(struct pci_dev *dev, pci_power_t state);
> > > >  	pci_power_t (*get_state)(struct pci_dev *dev);
> > > > -- 
> > > 
> > > 
> > > diff --git a/drivers/pci/pci-mid.c b/drivers/pci/pci-mid.c
> > > index aafd58da3a89..0bacd45b30d6 100644
> > > --- a/drivers/pci/pci-mid.c
> > > +++ b/drivers/pci/pci-mid.c
> > > @@ -16,6 +16,11 @@
> > >  
> > >  #include "pci.h"
> > >  
> > > +static bool mid_pci_bridge_d3(struct pci_dev *dev)
> > > +{
> > > +	return false;
> > > +}
> > > +
> > >  static bool mid_pci_power_manageable(struct pci_dev *dev)
> > >  {
> > >  	return true;
> > > @@ -47,6 +52,7 @@ static bool mid_pci_need_resume(struct pci_dev *dev)
> > >  }
> > >  
> > >  static const struct pci_platform_pm_ops mid_pci_platform_pm = {
> > > +	.bridge_d3	= mid_pci_bridge_d3,
> > >  	.is_manageable	= mid_pci_power_manageable,
> > >  	.set_state	= mid_pci_set_power_state,
> > >  	.get_state	= mid_pci_get_power_state,
> > > diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> > > index 595fcf59843f..fa837e88ea07 100644
> > > --- a/drivers/pci/pci.c
> > > +++ b/drivers/pci/pci.c
> > > @@ -820,8 +820,9 @@ static const struct pci_platform_pm_ops *pci_platform_pm;
> > >  
> > >  int pci_set_platform_pm(const struct pci_platform_pm_ops *ops)
> > >  {
> > > -	if (!ops->is_manageable || !ops->set_state  || !ops->get_state ||
> > > -	    !ops->choose_state  || !ops->set_wakeup || !ops->need_resume)
> > > +	if (!ops->bridge_d3 || !ops->is_manageable || !ops->set_state  ||
> > > +	    !ops->get_state || !ops->choose_state  || !ops->set_wakeup ||
> > > +	    !ops->need_resume)
> > >  		return -EINVAL;
> > >  	pci_platform_pm = ops;
> > >  	return 0;
