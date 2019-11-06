Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F153CF160A
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 13:28:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbfKFM2c (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 07:28:32 -0500
Received: from cloudserver094114.home.pl ([79.96.170.134]:61985 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727391AbfKFM2c (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 6 Nov 2019 07:28:32 -0500
Received: from 79.184.254.83.ipv4.supernova.orange.pl (79.184.254.83) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 1cbb818cf7d190ce; Wed, 6 Nov 2019 13:28:28 +0100
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Len Brown <lenb@kernel.org>,
        Valerio Passini <passini.valerio@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] ACPI / hotplug / PCI: Allocate resources directly under the non-hotplug bridge
Date:   Wed, 06 Nov 2019 13:28:27 +0100
Message-ID: <4228135.D2MuoWt6n7@kreacher>
In-Reply-To: <20191030150545.19885-1-mika.westerberg@linux.intel.com>
References: <20191030150545.19885-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wednesday, October 30, 2019 4:05:45 PM CET Mika Westerberg wrote:
> Valerio and others reported that commit 84c8b58ed3ad ("ACPI / hotplug /
> PCI: Don't scan bridges managed by native hotplug") prevents some recent
> LG and HP laptops from booting with endless loop of:
> 
>   [   26.237796] ACPI Error: No handler or method for GPE 08, disabling event (20190215/evgpe-835)
>   [   26.238699] ACPI Error: No handler or method for GPE 09, disabling event (20190215/evgpe-835)
>   [   26.239306] ACPI Error: No handler or method for GPE 0A, disabling event (20190215/evgpe-835)
>   ...
> 
> What seems to happen is that during boot, after the initial PCI
> enumeration when EC is enabled the platform triggers ACPI Notify() to
> one of the root ports. The root port itself looks like this:
> 
>   [    0.723757] pci 0000:00:1b.0: PCI bridge to [bus 02-3a]
>   [    0.723765] pci 0000:00:1b.0:   bridge window [mem 0xc4000000-0xda0fffff]
>   [    0.723773] pci 0000:00:1b.0:   bridge window [mem 0x80000000-0xa1ffffff 64bit pref]
> 
> The BIOS has configured the root port so that it does not have I/O
> bridge window.
> 
> Now when the ACPI Notify() is triggered ACPI hotplug handler calls
> acpiphp_native_scan_bridge() for each non-hotplug bridge (as this system
> is using native PCIe hotplug) and pci_assign_unassigned_bridge_resources()
> to allocate resources.
> 
> The device connected to the root port is a PCIe switch (Thunderbolt
> controller) with two hotplug downstream ports. Because of the hotplug
> ports __pci_bus_size_bridges() tries to add "additional I/O" of 256
> bytes to each (DEFAULT_HOTPLUG_IO_SIZE). This gets further aligned to 4k
> as that's the minimum I/O window size so each hotplug port gets 4k I/O
> window and the same happens for the root port (which is also hotplug
> port). This means 3 * 4k = 12k I/O window.
> 
> Because of this pci_assign_unassigned_bridge_resources() ends up opening
> a I/O bridge window for the root port at first available I/O address
> which seems to be in range 0x1000 - 0x3fff. Normally this range is used
> for ACPI stuff such as GPE bits (below is part of /proc/ioports):
> 
>     1800-1803 : ACPI PM1a_EVT_BLK
>     1804-1805 : ACPI PM1a_CNT_BLK
>     1808-180b : ACPI PM_TMR
>     1810-1815 : ACPI CPU throttle
>     1850-1850 : ACPI PM2_CNT_BLK
>     1854-1857 : pnp 00:05
>     1860-187f : ACPI GPE0_BLK
> 
> However, when the ACPI Notify() happened this range was not yet reserved
> for ACPI/PNP (that happens later) so PCI gets it. It then starts writing
> to this range and accidentally stomps over GPE bits among other things
> causing the endless stream of messages about missing GPE handler.
> 
> This problem does not happen if "pci=hpiosize=0" is passed in the kernel
> command line. The reason is that then the kernel does not try to
> allocate the additional 256 bytes for each hotplug port.
> 
> Fix this by allocating resources directly below the non-hotplug bridges
> where a new device may appear as a result of ACPI Notify(). This avoids
> the hotplug bridges and prevents opening the additional I/O window.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=203617
> Fixes: 84c8b58ed3ad ("ACPI / hotplug / PCI: Don't scan bridges managed by native hotplug")
> Cc: stable@vger.kernel.org
> Reported-by: Valerio Passini <passini.valerio@gmail.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>

That should work:

Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Bjorn, if you want me to take this, please let me know.

> ---
> I was able to reproduce this without access to the affected system by
> forcing ACPI core to send Notify() to the TBT root port like this:
> 
> void acpi_notify_rp(void)
> {
> 	struct acpi_device *adev;
> 	acpi_handle handle;
> 
> 	if (ACPI_FAILURE(acpi_get_handle(NULL, "\\_SB.PCI0.RP17", &handle)))
> 		return;
> 
> 	if (acpi_bus_get_device(handle, &adev))
> 		return;
> 
> 	dev_info(&adev->dev, "queueing hotplug\n");
> 	acpiphp_hotplug_notify(adev, ACPI_NOTIFY_BUS_CHECK);
> }
> 
> and calling it from acpi_init() directly after acpi_ec_init().
> 
>  drivers/pci/hotplug/acpiphp_glue.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index e4c46637f32f..b3869951c0eb 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -449,8 +449,15 @@ static void acpiphp_native_scan_bridge(struct pci_dev *bridge)
>  
>  	/* Scan non-hotplug bridges that need to be reconfigured */
>  	for_each_pci_bridge(dev, bus) {
> -		if (!hotplug_is_native(dev))
> -			max = pci_scan_bridge(bus, dev, max, 1);
> +		if (hotplug_is_native(dev))
> +			continue;
> +
> +		max = pci_scan_bridge(bus, dev, max, 1);
> +		if (dev->subordinate) {
> +			pcibios_resource_survey_bus(dev->subordinate);
> +			pci_bus_size_bridges(dev->subordinate);
> +			pci_bus_assign_resources(dev->subordinate);
> +		}
>  	}
>  }
>  
> @@ -480,7 +487,6 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>  			if (PCI_SLOT(dev->devfn) == slot->device)
>  				acpiphp_native_scan_bridge(dev);
>  		}
> -		pci_assign_unassigned_bridge_resources(bus->self);
>  	} else {
>  		LIST_HEAD(add_list);
>  		int max, pass;
> 




