Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 811592CD1B4
	for <lists+linux-pci@lfdr.de>; Thu,  3 Dec 2020 09:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730027AbgLCIsU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 3 Dec 2020 03:48:20 -0500
Received: from mga06.intel.com ([134.134.136.31]:57331 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726505AbgLCIsT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 3 Dec 2020 03:48:19 -0500
IronPort-SDR: IW9zkCtcxDEBHAxrkIO/lR/0RJYMmExRo6shtMYTHH1lbqlHDixwot+SDQhU53vMXDW05/cXBG
 sftRBMKAMawg==
X-IronPort-AV: E=McAfee;i="6000,8403,9823"; a="234762465"
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="234762465"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:46:37 -0800
IronPort-SDR: zd0POp4FXllmWoZ8NJwGVdjIpTZvobexciV35L8w793rwMYiRSy2JLwcwp+yA1XrANoNVr8Deo
 JZ6ytvEWYiqg==
X-IronPort-AV: E=Sophos;i="5.78,389,1599548400"; 
   d="scan'208";a="481882573"
Received: from pjkierna-mobl.amr.corp.intel.com (HELO localhost) ([10.252.22.179])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2020 00:46:32 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201202202253.GA1467966@bjorn-Precision-5520>
References: <20201202202253.GA1467966@bjorn-Precision-5520>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
To:     "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     Jesse Barnes <jsbarnes@google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        "De Marchi, Lucas" <lucas.demarchi@intel.com>,
        "Roper, Matthew D" <matthew.d.roper@intel.com>,
        "Pandey, Hariom" <hariom.pandey@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        "Vivi, Rodrigo" <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <160698518967.3553.11319067086667823352@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Thu, 03 Dec 2020 10:46:29 +0200
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Bjorn Helgaas (2020-12-02 22:22:53)
> On Wed, Dec 02, 2020 at 05:21:58AM +0000, Surendrakumar Upadhyay, TejaskumarX wrote:
> > Yes it fails all the tests which are allocating from this stolen
> > memory bunch. For example IGT tests like "
> > igt@kms_frontbuffer_tracking@-[fbc|fbcpsr].* |
> > igt@kms_fbcon_fbt@fbc.* " are failing as they totally depend to work
> > on stolen memory.

That's just because we have de-duped the stolen memory detection code.
If it's not detected at the early quirks, it's not detected by the
driver at all.

So if the patch is not merged to early quirks, we'd have to refactor the
code to add alternative detection path to i915. Before that is done, the
failures are expected.

> I'm sure that means something to graphics developers, but I have no
> idea!  Do you have URLs for the test case source, outputs, dmesg log,
> lspci info, bug reports, etc?

The thing is, the bug reports for stuff like this would only start to
flow after Jasperlake systems are shipping widely and the less common
OEMs start integrating it to into strangely behaving BIOSes. Or that
is the assumption.

If it's fine to merge this through i915 for now with an Acked-by, like
the previous patches, that'd be great. We can start a discussion on if
the new platforms are affected anymore. But I'd rather not drop it
before we have that understanding, as the previous problems have
included boot time memory corruption.

Would that work?

Regards, Joonas

> > > -----Original Message-----
> > > From: Bjorn Helgaas <helgaas@kernel.org>
> > > Sent: 30 November 2020 22:21
> > > To: Surendrakumar Upadhyay, TejaskumarX
> > > <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > > Cc: Jesse Barnes <jsbarnes@google.com>; Daniel Vetter <daniel@ffwll.ch>;
> > > Joonas Lahtinen <joonas.lahtinen@linux.intel.com>; Linux PCI <linux-
> > > pci@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > kernel@vger.kernel.org>; X86 ML <x86@kernel.org>; Borislav Petkov
> > > <bp@alien8.de>; De Marchi, Lucas <lucas.demarchi@intel.com>; Roper,
> > > Matthew D <matthew.d.roper@intel.com>; Pandey, Hariom
> > > <hariom.pandey@intel.com>; Jani Nikula <jani.nikula@linux.intel.com>; Vivi,
> > > Rodrigo <rodrigo.vivi@intel.com>; David Airlie <airlied@linux.ie>
> > > Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
> > > 
> > > On Mon, Nov 30, 2020 at 10:44:14AM +0000, Surendrakumar Upadhyay,
> > > TejaskumarX wrote:
> > > > Hi All,
> > > >
> > > > Are we merging this patch in?
> > > 
> > > Does it fix something?  If something is broken without this patch, can we
> > > collect information about exactly what is broken and how it fails?
> > > 
> > > But I don't object if somebody else wants to apply this.
> > > 
> > > > > -----Original Message-----
> > > > > From: Jesse Barnes <jsbarnes@google.com>
> > > > > Sent: 20 November 2020 03:32
> > > > > To: Bjorn Helgaas <helgaas@kernel.org>
> > > > > Cc: Daniel Vetter <daniel@ffwll.ch>; Joonas Lahtinen
> > > > > <joonas.lahtinen@linux.intel.com>; Surendrakumar Upadhyay,
> > > > > TejaskumarX <tejaskumarx.surendrakumar.upadhyay@intel.com>; Linux
> > > > > PCI <linux- pci@vger.kernel.org>; Linux Kernel Mailing List <linux-
> > > > > kernel@vger.kernel.org>; X86 ML <x86@kernel.org>; Borislav Petkov
> > > > > <bp@alien8.de>; De Marchi, Lucas <lucas.demarchi@intel.com>; Roper,
> > > > > Matthew D <matthew.d.roper@intel.com>; Pandey, Hariom
> > > > > <hariom.pandey@intel.com>; Jani Nikula
> > > > > <jani.nikula@linux.intel.com>; Vivi, Rodrigo
> > > > > <rodrigo.vivi@intel.com>; David Airlie <airlied@linux.ie>
> > > > > Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
> > > > >
> > > > > On Thu, Nov 19, 2020 at 11:19 AM Bjorn Helgaas <helgaas@kernel.org>
> > > > > wrote:
> > > > > >
> > > > > > [+cc Jesse]
> > > > > >
> > > > > > On Thu, Nov 19, 2020 at 10:37:10AM +0100, Daniel Vetter wrote:
> > > > > > > On Thu, Nov 19, 2020 at 12:14 AM Bjorn Helgaas
> > > > > > > <helgaas@kernel.org>
> > > > > wrote:
> > > > > > > > On Wed, Nov 18, 2020 at 10:57:26PM +0100, Daniel Vetter wrote:
> > > > > > > > > On Wed, Nov 18, 2020 at 5:02 PM Bjorn Helgaas
> > > > > <helgaas@kernel.org> wrote:
> > > > > > > > > > On Fri, Nov 06, 2020 at 10:39:16AM +0100, Daniel Vetter wrote:
> > > > > > > > > > > On Thu, Nov 5, 2020 at 3:17 PM Bjorn Helgaas
> > > > > <helgaas@kernel.org> wrote:
> > > > > > > > > > > > On Thu, Nov 05, 2020 at 11:46:06AM +0200, Joonas
> > > > > > > > > > > > Lahtinen
> > > > > wrote:
> > > > > > > > > > > > > Quoting Bjorn Helgaas (2020-11-04 19:35:56)
> > > > > > > > > > > > > > [+cc Jani, Joonas, Rodrigo, David, Daniel]
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > On Wed, Nov 04, 2020 at 05:35:06PM +0530, Tejas
> > > > > > > > > > > > > > Upadhyay
> > > > > wrote:
> > > > > > > > > > > > > > > JSL re-uses the same stolen memory as ICL and EHL.
> > > > > > > > > > > > > > >
> > > > > > > > > > > > > > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > > > > > > > > > > > > > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > > > > > > > > > > > > > Signed-off-by: Tejas Upadhyay
> > > > > > > > > > > > > > > <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > I don't plan to do anything with this since
> > > > > > > > > > > > > > previous similar patches have gone through some
> > > > > > > > > > > > > > other tree, so this is
> > > > > just kibitzing.
> > > > > > > > > > > > > >
> > > > > > > > > > > > > > But the fact that we have this long list of Intel
> > > > > > > > > > > > > > devices [1] that constantly needs updates [2] is a
> > > > > > > > > > > > > > hint that
> > > > > something is wrong.
> > > > > > > > > > > > >
> > > > > > > > > > > > > We add an entry for every new integrated graphics
> > > > > > > > > > > > > platform. Once the platform is added, there have not
> > > > > > > > > > > > > been
> > > > > changes lately.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > IIUC the general idea is that we need to discover
> > > > > > > > > > > > > > Intel gfx memory by looking at device-dependent
> > > > > > > > > > > > > > config
> > > > > space and add it to the E820 map.
> > > > > > > > > > > > > > Apparently the quirks discover this via PCI config
> > > > > > > > > > > > > > registers like I830_ESMRAMC, I845_ESMRAMC, etc,
> > > > > > > > > > > > > > and tell the driver about it via the global
> > > > > "intel_graphics_stolen_res"?
> > > > > > > > > > > > >
> > > > > > > > > > > > > We discover what is called the graphics data stolen
> > > > > > > > > > > > > memory. It is regular system memory range that is
> > > > > > > > > > > > > not CPU accessible. It is accessible by the integrated
> > > graphics only.
> > > > > > > > > > > > >
> > > > > > > > > > > > > See:
> > > > > > > > > > > > > https://git.kernel.org/pub/scm/linux/kernel/git/torv
> > > > > > > > > > > > > alds
> > > > > > > > > > > > > /linux.git/commit/arch/x86/kernel/early-quirks.c?h=v
> > > > > > > > > > > > > 5.10
> > > > > > > > > > > > > -rc2&id=814c5f1f52a4beb3710317022acd6ad34fc0b6b9
> > > > > > > > > > > > >
> > > > > > > > > > > > > > That's not the way this should work.  There should
> > > > > > > > > > > > > > some generic, non device-dependent PCI or ACPI
> > > > > > > > > > > > > > method to discover the memory used, or at least
> > > > > > > > > > > > > > some way to do it in
> > > > > the driver instead of early arch code.
> > > > > > > > > > > > >
> > > > > > > > > > > > > It's used by the early BIOS/UEFI code to set up
> > > > > > > > > > > > > initial
> > > > > framebuffer.
> > > > > > > > > > > > > Even if i915 driver is never loaded, the memory
> > > > > > > > > > > > > ranges still need to be fixed. They source of the
> > > > > > > > > > > > > problem is that the OEM BIOS which are not under our
> > > > > > > > > > > > > control get the
> > > > > programming wrong.
> > > > > > > > > > > > >
> > > > > > > > > > > > > We used to detect the memory region size again at
> > > > > > > > > > > > > i915 initialization but wanted to eliminate the code
> > > > > > > > > > > > > duplication and resulting subtle bugs that caused.
> > > > > > > > > > > > > Conclusion back then was that storing the struct
> > > > > > > > > > > > > resource in
> > > > > memory is the best trade-off.
> > > > > > > > > > > > >
> > > > > > > > > > > > > > How is this *supposed* to work?  Is there
> > > > > > > > > > > > > > something we can do in E820 or other resource
> > > > > > > > > > > > > > management that would
> > > > > make this easier?
> > > > > > > > > > > > >
> > > > > > > > > > > > > The code was added around Haswell (HSW) device
> > > > > > > > > > > > > generation to mitigate bugs in BIOS. It is
> > > > > > > > > > > > > traditionally hard to get all OEMs to fix their BIOS
> > > > > > > > > > > > > when things work for Windows. It's only later years
> > > > > > > > > > > > > when some laptop models
> > > > > are intended to be sold with Linux.
> > > > > > > > > > > > >
> > > > > > > > > > > > > The alternative would be to get all the OEM to fix
> > > > > > > > > > > > > their BIOS for Linux, but that is not very realistic
> > > > > > > > > > > > > given past experiences. So it seems a better choice
> > > > > > > > > > > > > to to add new line per platform generation to make
> > > > > > > > > > > > > sure the users can
> > > > > boot to Linux.
> > > > > > > > > > > >
> > > > > > > > > > > > How does Windows do this?  Do they have to add similar
> > > > > > > > > > > > code for each new platform?
> > > > > > > > > > >
> > > > > > > > > > > Windows is chicken and doesn't move any mmio bar around
> > > > > > > > > > > on its
> > > > > own.
> > > > > > > > > > > Except if the bios explicitly told it somehow (e.g. for
> > > > > > > > > > > the 64bit bar stuff amd recently announced for windows,
> > > > > > > > > > > that linux supports since years by moving the bar). So
> > > > > > > > > > > except if you want to preemptively disable the pci code
> > > > > > > > > > > that does this anytime there's an intel gpu, this is what we
> > > have to do.
> > > > > > > > > >
> > > > > > > > > > I think Windows *does* move BARs (they use the more
> > > > > > > > > > generic terminology of "rebalancing PNP resources") in
> > > > > > > > > > some cases [3,4].  Of course, I'm pretty sure Windows will
> > > > > > > > > > only assign PCI resources inside the windows advertised in
> > > > > > > > > > the host bridge
> > > > > _CRS.
> > > > > > > > > >
> > > > > > > > > > Linux *used* to ignore that host bridge _CRS and could set
> > > > > > > > > > BARs to addresses that appeared available but were in fact
> > > > > > > > > > used by the platform somehow.  But Linux has been paying
> > > > > > > > > > attention to host bridge _CRS for a long time now, so it
> > > > > > > > > > should also only assign resources inside those windows.
> > > > > > > > >
> > > > > > > > > If this behaviour is newer than the addition of these quirks
> > > > > > > > > then yeah they're probably not needed anymore, and we can
> > > > > > > > > move all this back into the driver. Do you have the commit
> > > > > > > > > when pci core started observing _CRS on the host bridge?
> > > > > > > >
> > > > > > > > I think the most relevant commit is this:
> > > > > > > >
> > > > > > > >   2010-02-23 7bc5e3f2be32 ("x86/PCI: use host bridge _CRS info
> > > > > > > > by default on 2008 and newer machines")
> > > > > > > >
> > > > > > > > but the earliest quirk I found is over three years later:
> > > > > > > >
> > > > > > > >   2013-07-26 814c5f1f52a4 ("x86: add early quirk for reserving
> > > > > > > > Intel graphics stolen memory v5")
> > > > > > > >
> > > > > > > > So there must be something else going on.  814c5f1f52a4
> > > > > > > > mentions a couple bug reports.  The dmesg from 66726 [5] shows
> > > > > > > > that we *are* observing the host bridge _CRS, but Linux just
> > > > > > > > used the BIOS configuration without changing anything:
> > > > > > > >
> > > > > > > >   BIOS-e820: [mem 0x000000007f49_f000-0x000000007f5f_ffff]
> > > usable
> > > > > > > >   BIOS-e820: [mem 0x00000000fec0_0000-0x00000000fec0_0fff]
> > > > > reserved
> > > > > > > >   PCI: Using host bridge windows from ACPI; if necessary, use
> > > > > "pci=nocrs" and report a bug
> > > > > > > >   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> > > > > > > >   pci_bus 0000:00: root bus resource [mem 0x7f70_0000-0xffff_ffff]
> > > > > > > >   pci 0000:00:1c.0: PCI bridge to [bus 01]
> > > > > > > >   pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> > > > > > > >   pci 0000:00:1c.0:   bridge window [mem 0xfe90_0000-0xfe9f_ffff]
> > > > > > > >   pci 0000:00:1c.0:   bridge window [mem 0x7f70_0000-0x7f8f_ffff
> > > 64bit
> > > > > pref]
> > > > > > > >   pci 0000:01:00.0: [1814:3090] type 00 class 0x028000
> > > > > > > >   pci 0000:01:00.0: reg 10: [mem 0xfe90_0000-0xfe90_ffff]
> > > > > > > >   [drm:i915_stolen_to_physical] *ERROR* conflict detected with
> > > > > > > > stolen region: [0x7f80_0000 - 0x8000_0000]
> > > > > > > >
> > > > > > > > So the BIOS programmed the 00:1c.0 bridge prefetchable window
> > > > > > > > to [mem 0x7f70_0000-0x7f8f_ffff], and i915 thinks that's a conflict.
> > > > > > > >
> > > > > > > > On this system, there are no PCI BARs in that range.  01:00.0
> > > > > > > > looks like a Ralink RT3090 Wireless 802.11n device that only
> > > > > > > > has a non-prefetchable BAR at [mem 0xfe90_0000-0xfe90_ffff].
> > > > > > > >
> > > > > > > > I don't know the details of the conflict.  IIUC, Joonas said
> > > > > > > > the stolen memory is accessible only by the integrated
> > > > > > > > graphics, not by the CPU.  The bridge window is CPU
> > > > > > > > accessible, of course, and the [mem 0x7f70_0000-0x7f8f_ffff]
> > > > > > > > range contains the addresses the CPU uses for programmed I/O to
> > > BARs below the bridge.
> > > > > > > >
> > > > > > > > The graphics accesses sound like they would be DMA in the
> > > > > > > > *bus* address space, which is frequently, but not always,
> > > > > > > > identical to the CPU address space.
> > > > > > >
> > > > > > > So apparently on some platforms the conflict is harmless because
> > > > > > > the BIOS puts BARs and stuff over it from boot-up, and things work:
> > > > > > > 0b6d24c01932 ("drm/i915: Don't complain about stolen conflicts
> > > > > > > on
> > > > > > > gen3") But we also had conflict reports on other machines.
> > > > > >
> > > > > > The bug reports mentioned in 814c5f1f52a4 ("x86: add early quirk
> > > > > > for reserving Intel graphics stolen memory v5") and 0b6d24c01932
> > > > > > ("drm/i915: Don't complain about stolen conflicts on gen3") seem
> > > > > > to be basically complaints about the *message*, not anything
> > > > > > that's actually broken.
> > > > > >
> > > > > > Jesse's comment [6]:
> > > > > >
> > > > > >   Given the decode priority on our GMCHs, it's fine if the regions
> > > > > >   overlap.  However it doesn't look like there's a nice way to detect
> > > > > >   it.  In this case, part of the range occupied by the stolen space is
> > > > > >   simply "reserved" per the E820, but the rest of it is under the bus
> > > > > >   0 range (which kind of makes sense too).
> > > > > >
> > > > > > sounds relevant but I don't know enough to interpret it.  I added
> > > > > > Jesse in case he wants to comment.
> > > > > >
> > > > > > > GPU does all its access with CPU address space (after the iommu,
> > > > > > > which is entirely integrated). So I'm not sure whether we've
> > > > > > > seen something go boom or whether reserving that resource was
> > > > > > > just precaution in
> > > > > > > eaba1b8f3379 ("drm/i915: Verify that our stolen memory doesn't
> > > > > > > conflict"), it's all a bit way back in history.
> > > > > > >
> > > > > > > So really not sure what to do here or what the risks are.
> > > > > >
> > > > > > I'm not either.  Seems like we're not really converging on
> > > > > > anything useful we can do at this point.  The only thing I can
> > > > > > think of would be to collect data about actual failures (not just warning
> > > messages).
> > > > > > That might lead to something we could improve in the future.
> > > > >
> > > > > I don't have any brilliant ideas here unfortunately.  Maybe it's
> > > > > worth talking to some of the Windows folks internally to see how
> > > > > these ranges are handled these days and matching it?  Historically
> > > > > this has been an area fraught with danger because getting things
> > > > > wrong can lead to corruption of various kinds or boot hangs.
> > > > >
> > > > > Jesse
