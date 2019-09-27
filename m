Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 10652C0DC7
	for <lists+linux-pci@lfdr.de>; Sat, 28 Sep 2019 00:02:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726029AbfI0WCX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Sep 2019 18:02:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42166 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbfI0WCX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Sep 2019 18:02:23 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7B54F2082F;
        Fri, 27 Sep 2019 22:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1569621742;
        bh=aXkA2YN6ZX/O9MkMcrGg6ev2Ipttt3mnunswdwwdhaE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZlQt1J+fCZp1YqjryqP9nsdKfM+U9vzet/8kQc2SW4u9SNkG6uNyjFH84zR83xi3Y
         MMUq1xctLr56OCZfiWhClWaPdUGhJArEOyrPG5EYZxpJK54gH0V1YJMLMq6Su49QFB
         fTAPZ1TWd63zabrmaXrSp0YCzJdhKrXbGq7eyK14=
Date:   Fri, 27 Sep 2019 17:02:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux@yadro.com, Sam Bobroff <sbobroff@linux.ibm.com>,
        Rajat Jain <rajatja@google.com>,
        Lukas Wunner <lukas@wunner.de>,
        Oliver O'Halloran <oohall@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>
Subject: Re: [PATCH v5 03/23] PCI: hotplug: Add a flag for the movable BARs
 feature
Message-ID: <20190927220219.GA57201@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190816165101.911-4-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 16, 2019 at 07:50:41PM +0300, Sergey Miroshnichenko wrote:
> When hot-adding a device, the bridge may have windows not big enough (or
> fragmented too much) for newly requested BARs to fit in. And expanding
> these bridge windows may be impossible because blocked by "neighboring"
> BARs and bridge windows.
> 
> Still, it may be possible to allocate a memory region for new BARs with the
> following procedure:
> 
> 1) notify all the drivers which support movable BARs to pause and release
>    the BARs; the rest of the drivers are guaranteed that their devices will
>    not get BARs moved;
> 
> 2) release all the bridge windows except of root bridges;
> 
> 3) try to recalculate new bridge windows that will fit all the BAR types:
>    - fixed;
>    - immovable;
>    - movable;
>    - newly requested by hot-added devices;
> 
> 4) if the previous step fails, disable BARs for one of the hot-added
>    devices and retry from step 3;
> 
> 5) notify the drivers, so they remap BARs and resume.

You don't do the actual recalculation in *this* patch, but since you
mention the procedure here, are we confident that we never make things
worse?

It's possible that a hot-add will trigger this attempt to move things
around, and it's possible that we won't find space for the new device
even if we move things around.  But are we certain that every device
that worked *before* the hot-add will still work *afterwards*?

Much of the assignment was probably done by the BIOS using different
algorithms than Linux has, so I think there's some chance that the
BIOS did a better job and if we lose that BIOS assignment, we might
not be able to recreate it.

> This makes the prior reservation of memory by BIOS/bootloader/firmware not
> required anymore for the PCI hotplug.
> 
> Drivers indicate their support of movable BARs by implementing the new
> .rescan_prepare() and .rescan_done() hooks in the struct pci_driver. All
> device's activity must be paused during a rescan, and iounmap()+ioremap()
> must be applied to every used BAR.
> 
> The platform also may need to prepare to BAR movement, so new hooks added:
> pcibios_rescan_prepare(pci_dev) and pcibios_rescan_prepare(pci_dev).
> 
> This patch is a preparation for future patches with actual implementation,
> and for now it just does the following:
>  - declares the feature;
>  - defines pci_movable_bars_enabled(), pci_dev_movable_bars_supported(dev);
>  - invokes the .rescan_prepare() and .rescan_done() driver notifiers;
>  - declares and invokes the pcibios_rescan_prepare()/_done() hooks;
>  - adds the PCI_IMMOVABLE_BARS flag.
> 
> The feature is disabled by default (via PCI_IMMOVABLE_BARS) until the final
> patch of the series. It can be overridden per-arch using this flag or by
> the following command line option:
> 
>     pcie_movable_bars={ off | force }
> 
> CC: Sam Bobroff <sbobroff@linux.ibm.com>
> CC: Rajat Jain <rajatja@google.com>
> CC: Lukas Wunner <lukas@wunner.de>
> CC: Oliver O'Halloran <oohall@gmail.com>
> CC: David Laight <David.Laight@ACULAB.COM>
> Signed-off-by: Sergey Miroshnichenko <s.miroshnichenko@yadro.com>
> ---
>  .../admin-guide/kernel-parameters.txt         |  7 ++
>  drivers/pci/pci-driver.c                      |  2 +
>  drivers/pci/pci.c                             | 24 ++++++
>  drivers/pci/pci.h                             |  2 +
>  drivers/pci/probe.c                           | 86 ++++++++++++++++++-
>  include/linux/pci.h                           |  7 ++
>  6 files changed, 126 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 47d981a86e2f..e2274ee87a35 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -3526,6 +3526,13 @@
>  		nomsi	Do not use MSI for native PCIe PME signaling (this makes
>  			all PCIe root ports use INTx for all services).
>  
> +	pcie_movable_bars=[PCIE]

This isn't a PCIe-specific feature, it's just a function of whether
drivers are smart enough, so we shouldn't tie it specifically to PCIe.
We could eventually do this for conventional PCI as well.

> +			Override the movable BARs support detection:
> +		off
> +			Disable even if supported by the platform
> +		force
> +			Enable even if not explicitly declared as supported

What's the need for "force"?  If it's possible, I think we should
enable this functionality all the time and just have a disable switch
in case we trip over cases where it doesn't work, e.g., something
like:

  pci=no_movable_bars

>  	pcmv=		[HW,PCMCIA] BadgePAD 4
>  
>  	pd_ignore_unused
> diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
> index a8124e47bf6e..d11909e79263 100644
> --- a/drivers/pci/pci-driver.c
> +++ b/drivers/pci/pci-driver.c
> @@ -1688,6 +1688,8 @@ static int __init pci_driver_init(void)
>  {
>  	int ret;
>  
> +	pci_add_flags(PCI_IMMOVABLE_BARS);
> +
>  	ret = bus_register(&pci_bus_type);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
> index 61d951766087..3a504f58ac60 100644
> --- a/drivers/pci/pci.c
> +++ b/drivers/pci/pci.c
> @@ -139,6 +139,30 @@ static int __init pcie_port_pm_setup(char *str)
>  }
>  __setup("pcie_port_pm=", pcie_port_pm_setup);
>  
> +static bool pcie_movable_bars_off;
> +static bool pcie_movable_bars_force;
> +static int __init pcie_movable_bars_setup(char *str)
> +{
> +	if (!strcmp(str, "off"))
> +		pcie_movable_bars_off = true;
> +	else if (!strcmp(str, "force"))
> +		pcie_movable_bars_force = true;
> +	return 1;
> +}
> +__setup("pcie_movable_bars=", pcie_movable_bars_setup);
> +
> +bool pci_movable_bars_enabled(void)
> +{
> +	if (pcie_movable_bars_off)
> +		return false;
> +
> +	if (pcie_movable_bars_force)
> +		return true;
> +
> +	return !pci_has_flag(PCI_IMMOVABLE_BARS);
> +}
> +EXPORT_SYMBOL(pci_movable_bars_enabled);

I don't think this needs to be exported, since the only references I
see are from the PCI core.

>  /* Time to wait after a reset for device to become responsive */
>  #define PCIE_RESET_READY_POLL_MS 60000
>  
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index d22d1b807701..be7acc477c64 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -257,6 +257,8 @@ bool pci_bus_clip_resource(struct pci_dev *dev, int idx);
>  void pci_reassigndev_resource_alignment(struct pci_dev *dev);
>  void pci_disable_bridge_window(struct pci_dev *dev);
>  
> +bool pci_dev_movable_bars_supported(struct pci_dev *dev);
> +
>  /* PCIe link information */
>  #define PCIE_SPEED2STR(speed) \
>  	((speed) == PCIE_SPEED_16_0GT ? "16 GT/s" : \
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 2e58ece820e8..60e3b48d2251 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -3406,6 +3406,74 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
>  	return max;
>  }
>  
> +bool pci_dev_movable_bars_supported(struct pci_dev *dev)

This name suggests that movable BARs is a property of the device, but
it's mostly a property of the *driver*.  Most uses are in conjuction
with checking IORESOURCE_PCI_FIXED for some resource, so I think this
might read more naturally and simplify the callers slightly:

  bool pci_dev_movable(struct pci_dev *dev)
  {
    if (dev->driver && dev->driver->rescan_prepare)
      return true;

    if ((dev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
      return false;

    if (!dev->driver)
      return true;

    return false;
  }

  bool pci_dev_bar_movable(struct pci_dev *dev, struct resource *res)
  {
    if (res->flags & IORESOURCE_PCI_FIXED)
      return false;

    return pci_dev_movable(dev);
  }

I'm not sure why the PCI_CLASS_DISPLAY_VGA special case is there; can
you add a comment about why that's needed?  Obviously we can't move
the 0xa0000 legacy frame buffer because I think devices are allowed to
claim that region even if no BAR describes it.  But I would think
*other* BARs of VGA devices could be movable.

> +{
> +	if (!dev)
> +		return false;
> +
> +	if (dev->driver && dev->driver->rescan_prepare)
> +		return true;
> +
> +	if ((dev->class >> 8) == PCI_CLASS_DISPLAY_VGA)
> +		return false;
> +
> +	return !dev->driver;
> +}
> +
> +void __weak pcibios_rescan_prepare(struct pci_dev *dev)
> +{
> +}
> +
> +void __weak pcibios_rescan_done(struct pci_dev *dev)
> +{
> +}

Can you add the pcibios_rescan_prepare() and pcibios_rescan_done()
stubs at the point where they're needed, i.e., where you add the
powerpc implementations?  We can't see the need for them at this point
in the series.

> +static void pci_bus_rescan_prepare(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +
> +	if (bus->self)
> +		pci_config_pm_runtime_get(bus->self);
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		struct pci_bus *child = dev->subordinate;
> +
> +		if (child)
> +			pci_bus_rescan_prepare(child);
> +
> +		if (dev->driver &&
> +		    dev->driver->rescan_prepare) {
> +			dev->driver->rescan_prepare(dev);
> +			pcibios_rescan_prepare(dev);
> +		} else if (pci_dev_movable_bars_supported(dev)) {

The connection between these two conditions is pretty complicated to
figure out.  Can you explain why you need both?

> +			pcibios_rescan_prepare(dev);
> +		}
> +	}
> +}
> +
> +static void pci_bus_rescan_done(struct pci_bus *bus)
> +{
> +	struct pci_dev *dev;
> +
> +	list_for_each_entry(dev, &bus->devices, bus_list) {
> +		struct pci_bus *child = dev->subordinate;
> +
> +		if (dev->driver &&
> +		    dev->driver->rescan_done) {
> +			pcibios_rescan_done(dev);
> +			dev->driver->rescan_done(dev);
> +		} else if (pci_dev_movable_bars_supported(dev)) {
> +			pcibios_rescan_done(dev);
> +		}
> +
> +		if (child)
> +			pci_bus_rescan_done(child);
> +	}
> +
> +	if (bus->self)
> +		pci_config_pm_runtime_put(bus->self);
> +}
> +
>  /**
>   * pci_rescan_bus - Scan a PCI bus for devices
>   * @bus: PCI bus to scan
> @@ -3418,9 +3486,23 @@ unsigned int pci_rescan_bus_bridge_resize(struct pci_dev *bridge)
>  unsigned int pci_rescan_bus(struct pci_bus *bus)
>  {
>  	unsigned int max;
> +	struct pci_bus *root = bus;
> +
> +	while (!pci_is_root_bus(root))
> +		root = root->parent;
> +
> +	if (pci_movable_bars_enabled()) {
> +		pci_bus_rescan_prepare(root);
> +
> +		max = pci_scan_child_bus(root);
> +		pci_assign_unassigned_root_bus_resources(root);
> +
> +		pci_bus_rescan_done(root);
> +	} else {
> +		max = pci_scan_child_bus(bus);
> +		pci_assign_unassigned_bus_resources(bus);
> +	}
>  
> -	max = pci_scan_child_bus(bus);
> -	pci_assign_unassigned_bus_resources(bus);
>  	pci_bus_add_devices(bus);
>  
>  	return max;
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index d3a72159722d..e5b5eff05744 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -838,6 +838,8 @@ struct pci_driver {
>  	int  (*resume)(struct pci_dev *dev);	/* Device woken up */
>  	void (*shutdown)(struct pci_dev *dev);
>  	int  (*sriov_configure)(struct pci_dev *dev, int num_vfs); /* On PF */
> +	void (*rescan_prepare)(struct pci_dev *dev);
> +	void (*rescan_done)(struct pci_dev *dev);
>  	const struct pci_error_handlers *err_handler;
>  	const struct attribute_group **groups;
>  	struct device_driver	driver;
> @@ -924,6 +926,7 @@ enum {
>  	PCI_ENABLE_PROC_DOMAINS	= 0x00000010,	/* Enable domains in /proc */
>  	PCI_COMPAT_DOMAIN_0	= 0x00000020,	/* ... except domain 0 */
>  	PCI_SCAN_ALL_PCIE_DEVS	= 0x00000040,	/* Scan all, not just dev 0 */
> +	PCI_IMMOVABLE_BARS	= 0x00000080,	/* Disable runtime BAR reassign */

There are no uses of PCI_IMMOVABLE_BARS left at the end of the series,
so I'd rather not add it if we can avoid it.

>  };
>  
>  /* These external functions are only available when PCI support is enabled */
> @@ -1266,6 +1269,9 @@ unsigned int pci_rescan_bus(struct pci_bus *bus);
>  void pci_lock_rescan_remove(void);
>  void pci_unlock_rescan_remove(void);
>  
> +void pcibios_rescan_prepare(struct pci_dev *dev);
> +void pcibios_rescan_done(struct pci_dev *dev);
> +
>  /* Vital Product Data routines */
>  ssize_t pci_read_vpd(struct pci_dev *dev, loff_t pos, size_t count, void *buf);
>  ssize_t pci_write_vpd(struct pci_dev *dev, loff_t pos, size_t count, const void *buf);
> @@ -1402,6 +1408,7 @@ unsigned char pci_bus_max_busnr(struct pci_bus *bus);
>  void pci_setup_bridge(struct pci_bus *bus);
>  resource_size_t pcibios_window_alignment(struct pci_bus *bus,
>  					 unsigned long type);
> +bool pci_movable_bars_enabled(void);

I would really like it if this were simply

  extern bool pci_no_movable_bars;

in drivers/pci/pci.h.  It would default to false since it's
uninitialized, and "pci=no_movable_bars" would set it to true.

We have similar "=off" and "=force" parameters for ASPM and other
things, and it makes the code really hard to analyze.

>  #define PCI_VGA_STATE_CHANGE_BRIDGE (1 << 0)
>  #define PCI_VGA_STATE_CHANGE_DECODES (1 << 1)
> -- 
> 2.21.0
> 
