Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97AA52D820B
	for <lists+linux-pci@lfdr.de>; Fri, 11 Dec 2020 23:28:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406846AbgLKW2D (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Dec 2020 17:28:03 -0500
Received: from mail.kernel.org ([198.145.29.99]:52984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406908AbgLKW1q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Dec 2020 17:27:46 -0500
Date:   Fri, 11 Dec 2020 16:27:04 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607725625;
        bh=Ft9XdeawhEOwP8fMCkcg3uxb+l91j2J02JXfLqBD/KU=;
        h=From:To:Cc:Subject:In-Reply-To:From;
        b=tNZ8fnrFeS6xRBtx8t2tipIt8DWwvDyP69hcehTwe99e7b7NeAk9IgvOnbfOelaDQ
         lJXeudcRdrkczzNJUI4mkA9tDvuAaeFuLrrFrYgIH5Ye7OohRWyb796sciPKgahNH+
         8fKlNdwdx3K9cBO5WMw/4Uelp643xHCzPfPAuuELh9jjCmOM720+Mc8cIVKI1ZctRv
         dp3uQUHgPisuZDy7JOOqmxFdxe4ArNp3OzfRdKGToeV/fZWc4+BpH2hTvAoGcZGRQt
         ThNq8RKk/aH1mpmnOMYAE5nscbWt8BP8SMaKsm/qdAm2PZDO8LWDyPd8FBfeNAJO/0
         QjZDp96Y6dS1Q==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     linux-pci@vger.kernel.org, mika.westerberg@linux.intel.com,
        rafael.j.wysocki@intel.com, peter@lekensteyn.nl,
        linuxarm@huawei.com
Subject: Re: [PATCH v2] PCI: Make sure the bus bridge powered on when
 scanning bus
Message-ID: <20201211222704.GA111886@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1601029386-4928-1-git-send-email-yangyicong@hisilicon.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Sep 25, 2020 at 06:23:06PM +0800, Yicong Yang wrote:
> When the bus bridge is runtime suspended, we'll fail to rescan
> the devices through sysfs as we cannot access the configuration
> space correctly when the bridge is in D3hot.
> It can be reproduced like:
> 
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
> $ echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan
> 
> 0000:80:00.0 is root port and is runtime suspended and we cannot
> get 0000:81:00.1 after rescan.
> 
> Make bridge powered on when scanning the child bus, by adding
> pm_runtime_get_sync()/pm_runtime_put() in pci_scan_child_bus_extend().
> 
> A similar issue is met and solved by
> commit d963f6512e15 ("PCI: Power on bridges before scanning new devices")
> which rescan the devices through /sys/bus/pci/devices/0000:80:00.0/rescan.
> The callstack is like:
> 
> dev_rescan_restore()
>   pci_rescan_bus()
>     pci_scan_bridge_extend()
>       pci_scan_child_bus_extend() /* will wake up the bridge with this patch */
> 
> With this patch the issue is also resolved, so let's remove the calls of
> pm_runtime_*() in pci_scan_bridge_extend().

I'm sorry, I feel like an idiot, but I totally lost whatever
understanding I had of this patch.  Here's what I *think* I
understand:

PCI devices always respond to config transactions unless they're in D3cold,
but a bridge only forwards config transactions when it is in D0.  When a
bridge is runtime suspended, we can access config space of the bridge
itself, but not of anything on its secondary side.  If a bridge is in a
low-power state, we must bring it back to D0 before enumerating devices
below it.

Prior to d963f6512e15 ("PCI: Power on bridges before scanning new
devices"), this rescan could fail if 00:01.0 were suspended:

  # echo 1 > /sys/bus/pci/devices/0000:00:01.0/0000:01:00.0/remove
  # echo 1 > /sys/bus/pci/devices/0000:00:01.0/rescan

d963f6512e15 fixed this with the following addition (call tree at the time):

  dev_rescan_store(dev 00:01.0)
    pci_rescan_bus(bus 00)
      pci_scan_child_bus(bus 00)
        for (devfn = 0; devfn < 0x100; devfn += 8)
          pci_scan_slot(bus 00, dev 00.0, 01.0, etc)
        list_for_each_entry(dev, &bus->devices)
          pci_scan_bridge(bus 00, dev 01.0)
 +          pm_runtime_get_sync(dev 00:01.0)  # enables config below 00:01.0
            pci_scan_child_bus(bus 01)
              for (devfn = 0; devfn < 0x100; devfn += 8)
                pci_scan_slot(bus 01, dev 00.0, 01.0, etc)
                  # config read of 01:00.0 fails unless 00:01.0 is in D0


Now, for *this* patch, I think you're saying that this rescan can
still fail:

  # echo 1 > /sys/bus/pci/devices/0000:80:00.0/0000:81:00.1/remove
  # echo 1 > /sys/bus/pci/devices/0000:80:00.0/pci_bus/0000:81/rescan

IIUC, it uses this path:

  bus_rescan_store(bus 81)                  # 81 is not a root bus
    pci_rescan_bus_bridge_resize(80:00.0)   # (bus 81)->self
      bus = 80:00.0->subordinate
      pci_scan_child_bus(bus 81)
        pci_scan_child_bus_extend
          for (devfn = 0; devfn < 256; devfn += 8)
            pci_scan_slot(bus 81, dev 00.0)
              # config read of 81:00.0 fails unless 80:00.0 is in D0


Am I making any sense?

> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
> Change since v1:
> - use an intermediate variable *bridge as suggested
> - remove the pm_runtime_*() calls in pci_scan_bridge_extend()
> 
>  drivers/pci/probe.c | 21 ++++++++++++---------
>  1 file changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 03d3712..747a8bc 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -1211,12 +1211,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  	u8 fixed_sec, fixed_sub;
>  	int next_busnr;
> 
> -	/*
> -	 * Make sure the bridge is powered on to be able to access config
> -	 * space of devices below it.
> -	 */
> -	pm_runtime_get_sync(&dev->dev);
> -
>  	pci_read_config_dword(dev, PCI_PRIMARY_BUS, &buses);
>  	primary = buses & 0xFF;
>  	secondary = (buses >> 8) & 0xFF;
> @@ -1418,8 +1412,6 @@ static int pci_scan_bridge_extend(struct pci_bus *bus, struct pci_dev *dev,
>  out:
>  	pci_write_config_word(dev, PCI_BRIDGE_CONTROL, bctl);
> 
> -	pm_runtime_put(&dev->dev);
> -
>  	return max;
>  }
> 
> @@ -2796,11 +2788,19 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  	unsigned int used_buses, normal_bridges = 0, hotplug_bridges = 0;
>  	unsigned int start = bus->busn_res.start;
>  	unsigned int devfn, fn, cmax, max = start;
> -	struct pci_dev *dev;
> +	struct pci_dev *dev, *bridge = bus->self;
>  	int nr_devs;
> 
>  	dev_dbg(&bus->dev, "scanning bus\n");
> 
> +	/*
> +	 * Make sure the bus bridge is powered on, otherwise we may not be
> +	 * able to scan the devices as we may fail to access the configuration
> +	 * space of subordinates.
> +	 */
> +	if (bridge)
> +		pm_runtime_get_sync(&bridge->dev);
> +
>  	/* Go find them, Rover! */
>  	for (devfn = 0; devfn < 256; devfn += 8) {
>  		nr_devs = pci_scan_slot(bus, devfn);
> @@ -2913,6 +2913,9 @@ static unsigned int pci_scan_child_bus_extend(struct pci_bus *bus,
>  		}
>  	}
> 
> +	if (bridge)
> +		pm_runtime_put(&bridge->dev);
> +
>  	/*
>  	 * We've scanned the bus and so we know all about what's on
>  	 * the other side of any bridges that may be on this bus plus
> --
> 2.8.1
> 
