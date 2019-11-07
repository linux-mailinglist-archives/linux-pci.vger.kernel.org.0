Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7DFF2A11
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 10:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733112AbfKGJDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 04:03:39 -0500
Received: from mga04.intel.com ([192.55.52.120]:43039 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727715AbfKGJDi (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 04:03:38 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 01:03:37 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,277,1569308400"; 
   d="scan'208";a="212978735"
Received: from lahna.fi.intel.com (HELO lahna) ([10.237.72.163])
  by fmsmga001.fm.intel.com with SMTP; 07 Nov 2019 01:03:34 -0800
Received: by lahna (sSMTP sendmail emulation); Thu, 07 Nov 2019 11:03:33 +0200
Date:   Thu, 7 Nov 2019 11:03:33 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Len Brown <lenb@kernel.org>,
        Valerio Passini <passini.valerio@gmail.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ACPI / hotplug / PCI: Allocate resources directly under
 the non-hotplug bridge
Message-ID: <20191107090333.GG2552@lahna.fi.intel.com>
References: <20191030150545.19885-1-mika.westerberg@linux.intel.com>
 <20191106232405.GA242013@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191106232405.GA242013@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Nov 06, 2019 at 05:24:05PM -0600, Bjorn Helgaas wrote:
> [+cc Ben]
> 
> On Wed, Oct 30, 2019 at 06:05:45PM +0300, Mika Westerberg wrote:
> > Valerio and others reported that commit 84c8b58ed3ad ("ACPI / hotplug /
> > PCI: Don't scan bridges managed by native hotplug") prevents some recent
> > LG and HP laptops from booting with endless loop of:
> > 
> >   [   26.237796] ACPI Error: No handler or method for GPE 08, disabling event (20190215/evgpe-835)
> >   [   26.238699] ACPI Error: No handler or method for GPE 09, disabling event (20190215/evgpe-835)
> >   [   26.239306] ACPI Error: No handler or method for GPE 0A, disabling event (20190215/evgpe-835)
> >   ...
> > 
> > What seems to happen is that during boot, after the initial PCI
> > enumeration when EC is enabled the platform triggers ACPI Notify() to
> > one of the root ports. The root port itself looks like this:
> > 
> >   [    0.723757] pci 0000:00:1b.0: PCI bridge to [bus 02-3a]
> >   [    0.723765] pci 0000:00:1b.0:   bridge window [mem 0xc4000000-0xda0fffff]
> >   [    0.723773] pci 0000:00:1b.0:   bridge window [mem 0x80000000-0xa1ffffff 64bit pref]
> >
> > The BIOS has configured the root port so that it does not have I/O
> > bridge window.
> > 
> > Now when the ACPI Notify() is triggered ACPI hotplug handler calls
> > acpiphp_native_scan_bridge() for each non-hotplug bridge (as this system
> > is using native PCIe hotplug) and pci_assign_unassigned_bridge_resources()
> > to allocate resources.
> > 
> > The device connected to the root port is a PCIe switch (Thunderbolt
> > controller) with two hotplug downstream ports. Because of the hotplug
> > ports __pci_bus_size_bridges() tries to add "additional I/O" of 256
> > bytes to each (DEFAULT_HOTPLUG_IO_SIZE). This gets further aligned to 4k
> > as that's the minimum I/O window size so each hotplug port gets 4k I/O
> > window and the same happens for the root port (which is also hotplug
> > port). This means 3 * 4k = 12k I/O window.
> > 
> > Because of this pci_assign_unassigned_bridge_resources() ends up opening
> > a I/O bridge window for the root port at first available I/O address
> > which seems to be in range 0x1000 - 0x3fff. Normally this range is used
> > for ACPI stuff such as GPE bits (below is part of /proc/ioports):
> > 
> >     1800-1803 : ACPI PM1a_EVT_BLK
> >     1804-1805 : ACPI PM1a_CNT_BLK
> >     1808-180b : ACPI PM_TMR
> >     1810-1815 : ACPI CPU throttle
> >     1850-1850 : ACPI PM2_CNT_BLK
> >     1854-1857 : pnp 00:05
> >     1860-187f : ACPI GPE0_BLK
> 
> Nice debugging work!
> 
> > However, when the ACPI Notify() happened this range was not yet reserved
> > for ACPI/PNP (that happens later) so PCI gets it. 
> 
> I think this is really the underlying problem.  IMO those ACPI/PNP
> resources ought to be reserved before we start assigning resources to
> PCI devices.  That would be a huge problem to fix, though.

I agree, changing the order would probably open another can of worms.

> > It then starts writing
> > to this range and accidentally stomps over GPE bits among other things
> > causing the endless stream of messages about missing GPE handler.
> >
> > This problem does not happen if "pci=hpiosize=0" is passed in the kernel
> > command line. The reason is that then the kernel does not try to
> > allocate the additional 256 bytes for each hotplug port.
> > 
> > Fix this by allocating resources directly below the non-hotplug bridges
> > where a new device may appear as a result of ACPI Notify(). This avoids
> > the hotplug bridges and prevents opening the additional I/O window.
> 
> Looking at [1], here's the topology I see:
> 
>   00:1b.0: Root Port to [bus 02-3a]                   # pciehp
>   02:00.0: Switch Upstream Port to [bus 03-3a]        # thunderbolt
>   03:00.0: Switch Downstream Port to [bus 04]         # thunderbolt
>   03:01.0: Switch Downstream Port to [bus 05-39]      # thunderbolt, pciehp
>   03:02.0: Switch Downstream Port to [bus 3a]         # thunderbolt
>   04:00.0: reg 0x10: [mem 0xda000000-0xda03ffff]
>   04:00.0: reg 0x14: [mem 0xda040000-0xda040fff]
>   3a:00.0: reg 0x10: [mem 0xd9f00000-0xd9f0ffff]
> 
> In this topology, I guess the non-hotplug bridges would be 03:00.0
> and 03:02.0?  And we skip 03:01.0 because hotplug_is_native() is true
> for that?

Yes.

> What would happen if a device below one of the non-hotplug bridges,
> e.g., 3a:00.0, had an I/O BAR?  Would this patch still work?

I think it would still work because now we call pci_bus_size_bridges()
only for non-hotplug bridge which do not have I/O window open so
pbus_size_io() fails to find the "free" I/O resource on that bus and the
kernel then fails to assign that I/O resource for the device.

This is based on reading the code - I cannot verify this on real
hardware, though.
