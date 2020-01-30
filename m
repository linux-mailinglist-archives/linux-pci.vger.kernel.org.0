Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44FEC14E622
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 00:37:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgA3Xhe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jan 2020 18:37:34 -0500
Received: from mail.kernel.org ([198.145.29.99]:48022 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726633AbgA3Xhe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Jan 2020 18:37:34 -0500
Received: from localhost (mobile-166-175-186-165.mycingular.net [166.175.186.165])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2ABFB20663;
        Thu, 30 Jan 2020 23:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1580427452;
        bh=3ECr1KOjOAx9m6j/WESO2OFWxUjz/MfUkxzuZjCQjCU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=wuoO8UzI7K9e1Of6dQ+0MxyzZgKcHTIWPMGiAWrBnFdpIMswvZMt/z88r6HLuprdb
         0pvQ4nojUQLtGcWb7tBtvmlSLcZ65yFIqCGiRHu1pYDohJeDHl8hkuyepib0Mx7lSN
         h8X8JWsXEPlkqpPSbd35DunbZ21kkiD1FncZUhEM=
Date:   Thu, 30 Jan 2020 17:37:30 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
Cc:     linux-pci@vger.kernel.org, Stefan Roese <sr@denx.de>,
        linux@yadro.com
Subject: Re: [PATCH v7 00/26] PCI: Allow BAR movement during boot and hotplug
Message-ID: <20200130233730.GA141912@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200129152937.311162-1-s.miroshnichenko@yadro.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jan 29, 2020 at 06:29:11PM +0300, Sergei Miroshnichenko wrote:
> Currently PCI hotplug works on top of resources which are usually reserved
> not by the kernel, but by BIOS, bootloader, firmware, etc. These resources
> are gaps in the address space where BARs of new devices may fit, and extra
> bus number per port, so bridges can be hot-added. This series aim the BARs
> problem: it shows the kernel how to redistribute them on the run, so the
> hotplug becomes predictable and cross-platform. A follow-up patchset will
> propose a solution for bus numbers.
> 
> To arrange a space for BARs of new hotplugged devices, the kernel now pause
> the drivers of working PCI devices and reshuffle the assigned BARs by the
> same procedure as during the system boot. When a driver is un-paused by the
> kernel, it should ioremap() the new addresses of its BARs.
> 
> Drivers indicate their support of the feature by implementing the new hooks
> .rescan_prepare() and .rescan_done() in the struct pci_driver. If a driver
> doesn't yet support the feature, BARs of its devices will be considered as
> immovable and handled in the same way as resources with the PCI_FIXED flag:
> they are guaranteed to remain untouched.
> 
> Tested on a number x86_64 machines with "pci=pcie_bus_peer2peer" command
> line argument to specify a policy for Maximum Payload Size PCIe setting.

What is the significance of "pci=pcie_bus_peer2peer"?  On the face of
it, that doesn't sound related to BAR assignment.

> Also tested on a POWER8 PowerNV+OPAL+PHB3 ppc64le machine, but with extra
> patches which are to be sent upstream after the PCIPOCALYPSE patchset is
> merged.

"PCIPOCALYPSE" is meaningless to me.  Not sure if it's relevant for me
or not, but if you mention it, it'd be nice to have some more context.

> First two patches of this series are bugfixes, not related directly to the
> movable BARs feature.
> 
> Patches 03-14/26 implement the essentials of the feature.
> 
> Patch 15/26 enables the feature by default.
> 
> Patches 16-26/26 are performance improvements for hotplug.
> 
> This patchset is a part of our work on adding support for hotplugging
> chains of chassis full of other bridges, NVME drives, SAS HBAs, GPUs, etc.
> without special requirements such as Hot-Plug Controller, reservation of
> bus numbers or memory regions by firmware, etc.

Thanks for reposting these.  This series was next on my list to look
at, so I'm glad for an updated version.

> Changes since v6:
>  - Added a fix for hotplug on AMD Epyc + Supermicro H11SSL-i by ignoring
>    PCIBIOS_MIN_MEM;
>  - Fixed a workaround which marks VGA BARs as immovables;
>  - Fixed misleading "can't claim BAR ... no compatible bridge window" error
>    messages;
>  - Refactored the code, reduced the amount of patches;
>  - Exclude PowerPC-specific arch patches, they will be sent separately;
>  - Disabled for PowerNV by default - waiting for the PCIPOCALYPSE patchset.
>  - Fixed reports from the kbuild test robot.
> 
> Changes since v5:
>  - Simplified the disable flag, now it is "pci=no_movable_buses";
>  - More deliberate marking the BARs as immovable;
>  - Mark as immovable BARs which are used by unbound drivers;
>  - Ignoring BAR assignment by non-kernel program components, so the kernel
>    is able now to distribute BARs in optimal and predictable way;
>  - Move here PowerNV-specific patches from the older "powerpc/powernv/pci:
>    Make hotplug self-sufficient, independent of FW and DT" series;
>  - Fix EEH cache rebuilding and PE allocation for PowerNV during rescan.
> 
> Changes since v4:
>  - Feature is enabled by default (turned on by one of the latest patches);
>  - Add pci_dev_movable_bars_supported(dev) instead of marking the immovable
>    BARs with the IORESOURCE_PCI_FIXED flag;
>  - Set up PCIe bridges during rescan via sysfs, so MPS settings are now
>    configured not only during system boot or pcihp events;
>  - Allow movement of switch's BARs if claimed by portdrv;
>  - Update EEH address caches after rescan for powerpc;
>  - Don't disable completely hot-added devices which can't have BARs being
>    fit - just disable their BARs, so they are still visible in lspci etc;
>  - Clearer names: fixed_range_hard -> immovable_range, fixed_range_soft ->
>    realloc_range;
>  - Drop the patch for pci_restore_config_space() - fixed by properly using
>    the runtime PM.
> 
> Changes since v3:
>  - Rebased to the upstream, so the patches apply cleanly again.
> 
> Changes since v2:
>  - Fixed double-assignment of bridge windows;
>  - Fixed assignment of fixed prefetched resources;
>  - Fixed releasing of fixed resources;
>  - Fixed a debug message;
>  - Removed auto-enabling the movable BARs for x86 - let's rely on the
>    "pcie_movable_bars=force" option for now;
>  - Reordered the patches - bugfixes first.
> 
> Changes since v1:
>  - Add a "pcie_movable_bars={ off | force }" command line argument;
>  - Handle the IORESOURCE_PCI_FIXED flag properly;
>  - Don't move BARs of devices which don't support the feature;
>  - Guarantee that new hotplugged devices will not steal memory from working
>    devices by ignoring the failing new devices with the new PCI_DEV_IGNORE
>    flag;
>  - Add rescan_prepare()+rescan_done() to the struct pci_driver instead of
>    using the reset_prepare()+reset_done() from struct pci_error_handlers;
>  - Add a bugfix of a race condition;
>  - Fixed hotplug in a non-pre-enabled (by BIOS/firmware) bridge;
>  - Fix the compatibility of the feature with pm_runtime and D3-state;
>  - Hotplug events from pciehp also can move BARs;
>  - Add support of the feature to the NVME driver.
> 
> Sergei Miroshnichenko (26):
>   PCI: Fix race condition in pci_enable/disable_device()
>   PCI: Enable bridge's I/O and MEM access for hotplugged devices
>   PCI: hotplug: Initial support of the movable BARs feature
>   PCI: Add version of release_child_resources() aware of immovable BARs
>   PCI: hotplug: Fix reassigning the released BARs
>   PCI: hotplug: Recalculate every bridge window during rescan
>   PCI: hotplug: Don't allow hot-added devices to steal resources
>   PCI: hotplug: Try to reassign movable BARs only once
>   PCI: hotplug: Calculate immovable parts of bridge windows
>   PCI: Include fixed and immovable BARs into the bus size calculating
>   PCI: hotplug: movable BARs: Compute limits for relocated bridge
>     windows
>   PCI: Make sure bridge windows include their fixed BARs
>   PCI: hotplug: Add support of immovable BARs to pci_assign_resource()
>   PCI: hotplug: Sort immovable BARs before assignment
>   PCI: hotplug: Enable the movable BARs feature by default
>   PCI: Ignore PCIBIOS_MIN_MEM
>   PCI: hotplug: Ignore the MEM BAR offsets from BIOS/bootloader
>   PCI: Treat VGA BARs as immovable
>   PCI: hotplug: Configure MPS for hot-added bridges during bus rescan
>   PNP: Don't reserve BARs for PCI when enabled movable BARs
>   PCI: hotplug: Don't disable the released bridge windows immediately
>   PCI: pciehp: Trigger a domain rescan on hp events when enabled movable
>     BARs
>   PCI: Don't claim immovable BARs
>   PCI: hotplug: Don't reserve bus space when enabled movable BARs
>   nvme-pci: Handle movable BARs
>   PCI/portdrv: Declare support of movable BARs
> 
>  .../admin-guide/kernel-parameters.txt         |   1 +

Probably needs some text in Documentation/PCI/pci.rst as well about
what drivers need to do to support this.  We haven't been very good
about documenting all the hooks in struct pci_driver, but this would
be a good chance to start.

>  arch/powerpc/platforms/powernv/pci.c          |   2 +
>  arch/powerpc/platforms/pseries/setup.c        |   2 +
>  drivers/nvme/host/pci.c                       |  21 +-
>  drivers/pci/bus.c                             |   2 +-
>  drivers/pci/hotplug/pciehp_pci.c              |   5 +
>  drivers/pci/pci.c                             |  38 +-
>  drivers/pci/pci.h                             |  31 ++
>  drivers/pci/pcie/portdrv_pci.c                |  11 +
>  drivers/pci/probe.c                           | 331 +++++++++++++++++-
>  drivers/pci/setup-bus.c                       | 311 ++++++++++++++--
>  drivers/pci/setup-res.c                       |  47 ++-
>  drivers/pnp/system.c                          |   6 +
>  include/linux/pci.h                           |  20 ++
>  14 files changed, 790 insertions(+), 38 deletions(-)
> 
> 
> base-commit: b3a6082223369203d7e7db7e81253ac761377644
> -- 
> 2.24.1
> 
