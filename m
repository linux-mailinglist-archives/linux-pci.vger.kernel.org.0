Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B3295E3EA
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jul 2019 14:29:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbfGCM3N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 3 Jul 2019 08:29:13 -0400
Received: from mga02.intel.com ([134.134.136.20]:33976 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbfGCM3N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 3 Jul 2019 08:29:13 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 03 Jul 2019 05:29:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,446,1557212400"; 
   d="scan'208";a="184735082"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.157])
  by fmsmga001.fm.intel.com with SMTP; 03 Jul 2019 05:29:10 -0700
Received: by lahna (sSMTP sendmail emulation); Wed, 03 Jul 2019 15:29:09 +0300
Date:   Wed, 3 Jul 2019 15:29:09 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org
Subject: Re: [RFC] PCI: Use minimum window alignment when calculating memory
 window size
Message-ID: <20190703122909.GS2640@lahna.fi.intel.com>
References: <20190425142202.61624-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190425142202.61624-1-mika.westerberg@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 25, 2019 at 05:22:02PM +0300, Mika Westerberg wrote:
> There is an issue in Linux PCI resource allocation that if we remove an
> existing device that was initially configured by the BIOS and then issue
> rescan, it will not fit in to the memory space allocated by the BIOS
> even if it originally it fit there just fine.
> 
> The system in question is just a regular PC with a FPGA card connected
> to PCIe slot. The initial BIOS resource allocation right after boot
> looks like:
> 
> 00:01.1 Root port
>   Memory behind bridge: d0000000-f01fffff	(514M)
>     02:00.0 PCI-Express to PCI/PCI-X Bridge
>       BAR 0: Memory at d0000000-dfffffff	(256M)
>       BAR 1: Memory at f0100000-f01fffff	(1M)
>       Memory behind bridge: e0000000-f00fffff	(257M)
>         03:0a.0 FPGA
> 	  BAR 0: Memory at f0000000-f000ffff	(64k)
> 	  BAR 2: Memory at e0000000-efffffff	(256M)
> 
> The FPGA card consists of a PCIe-to-PCI-X bridge (02:00.0) and the FPGA
> device itself (03:0a.0) right below the bridge. In order to update the
> FPGA image to the card without need for rebooting the system we remove
> the device through sysfs:
> 
>   # echo 1 > /sys/bus/pci/devices/0000:00:01.1/0000:02:00.0/remove
> 
> At this point the same image is burned to the FPGA or alternatively it
> is just reset to make sure the config space gets cleared and the kernel
> needs to do the resource allocation in the next step. Next we issue
> rescan to find and re-configure the same device:
> 
>   # echo 1 > /sys/bus/pci/devices/0000:00:01.1/rescan
> 
> But the end result is not the same and in fact the FPGA device cannot
> enable its BARs because there is no memory window from bridge 02:00.0 to
> the FPGA:
> 
> 00:01.1 Root port
>   Memory behind bridge: d0000000-f01fffff	(514M)
>     02:00.0 PCI-Express to PCI/PCI-X Bridge
>       BAR 0: Memory at d0000000-dfffffff	(256M)
>       BAR 1: Memory at e0000000-e00fffff	(1M)
> 
> Below are the messages from the rescan with the failure highlighted:
> 
> [  208.396066] pci_bus 0000:02: scanning bus
> [  208.396090] pci 0000:02:00.0: [8086:0bcd] type 01 class 0x060400
> [  208.396119] pci 0000:02:00.0: reg 0x10: [mem 0x00000000-0x0fffffff]
> [  208.396128] pci 0000:02:00.0: reg 0x14: [mem 0x00000000-0x000fffff]
> [  208.396156] pci 0000:02:00.0: enabling Extended Tags
> [  208.396236] pci 0000:02:00.0: PME# supported from D0
> [  208.396241] pci 0000:02:00.0: PME# disabled
> [  208.407979] pci 0000:02:00.0: scanning [bus 00-00] behind bridge, pass 0
> [  208.407984] pci 0000:02:00.0: bridge configuration invalid ([bus 00-00]), reconfiguring
> [  208.407994] pci 0000:02:00.0: scanning [bus 00-00] behind bridge, pass 1
> [  208.408039] pci_bus 0000:03: extended config space not accessible
> [  208.408119] pci_bus 0000:03: scanning bus
> [  208.456396] pci 0000:03:0a.0: [8086:0bce] type 00 class 0x000000
> [  208.456528] pci 0000:03:0a.0: reg 0x10: [mem 0xf0000000-0xf000ffff 64bit]
> [  208.456611] pci 0000:03:0a.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit]
> [  208.456664] pci 0000:03:0a.0: reg 0x20: [io  0xe000-0xe0ff]
> [  208.938323] pci_bus 0000:03: fixups for bus
> [  208.938324] pci 0000:02:00.0: PCI bridge to [bus 03]
> [  208.938330] pci 0000:02:00.0:   bridge window [io  0x0000-0x0fff]
> [  208.938334] pci 0000:02:00.0:   bridge window [mem 0x00000000-0x000fffff]
> [  208.938339] pci 0000:02:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> [  208.938341] pci_bus 0000:03: bus scan returning with max=03
> [  208.938343] pci_bus 0000:03: busn_res: [bus 03] end is updated to 03
> [  208.938346] pci_bus 0000:02: bus scan returning with max=03
> [  208.938555] pci 0000:02:00.0: BAR 0: assigned [mem 0xd0000000-0xdfffffff]
> [  208.938558] pci 0000:02:00.0: BAR 14: no space for [mem size 0x18000000]
>                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [  208.938559] pci 0000:02:00.0: BAR 14: failed to assign [mem size 0x18000000]
>                                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> [  208.938560] pci 0000:02:00.0: BAR 1: assigned [mem 0xe0000000-0xe00fffff]
> [  208.938564] pci 0000:02:00.0: BAR 15: assigned [mem 0xbfb00000-0xbfbfffff 64bit pref]
> [  208.938565] pci 0000:02:00.0: BAR 13: assigned [io  0xe000-0xefff]
> [  208.938566] pci 0000:03:0a.0: BAR 2: no space for [mem size 0x10000000 64bit]
> [  208.938567] pci 0000:03:0a.0: BAR 2: failed to assign [mem size 0x10000000 64bit]
> [  208.938568] pci 0000:03:0a.0: BAR 0: no space for [mem size 0x00010000 64bit]
> [  208.938569] pci 0000:03:0a.0: BAR 0: failed to assign [mem size 0x00010000 64bit]
> [  208.938569] pci 0000:03:0a.0: BAR 4: assigned [io  0xe000-0xe0ff]
> 
> It seems that Linux tries to open memory window of 0x18000000 (384M)
> from the bridge 02:00.0 towards the FPGA 03:0a.0. This of does not fit
> to the memory available for the bridge itself and thus the assignment
> fails.
> 
> The size 0x18000000 comes from the following code which tries to
> calculate size of the devices below the bridge and the required
> alignment:
> 
> drivers/pci/setup-bus.c::pbus_size_mem(...)
> {
>   // size = 0x10000000 + 0x10000 = 0x10010000 (256M + 64k)
> 
>   min_align = calculate_mem_align(aligns, max_order);
>   min_align = max(min_align, window_alignment(bus, b_res->flags));
>   // min_align = 0x8000000 (128M)
> 
>   size0 = calculate_memsize(size, min_size, 0, 0, resource_size(b_res), min_align);
>   // size0 = ALIGN(0x10010000, 0x8000000) = 0x18000000 (384M)
> 
> We align the calculated size to the next 128M which increases to 384M
> and then later in pci_assign_resource() try to assing the resource which
> fails because there is no room available in the parent bridge.
> 
> Since the minimum alignment (min_align) is kept as part of the window
> resource and taken into account later in pbus_assign_resources_sorted()
> and pci_assign_resource(), I think aligning size to min_align is not
> necessary.
> 
> For this reason make the size calculation to use minimum memory window
> alignment (1M) instead. The resulting resource allocation matches the
> initial allocation done by the BIOS.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> I'm sending this as RFC because it might be that I'm overlooking something.
> I'm also open to any other ideas that help to solve the issue better than
> what this patch does.
> 
> I have access to one of these systems so I can perform additional testing
> if needed.

Hi Bjorn,

Any comments on this?
