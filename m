Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8F92B9D49
	for <lists+linux-pci@lfdr.de>; Thu, 19 Nov 2020 23:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726677AbgKSWCD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Nov 2020 17:02:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgKSWCC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Nov 2020 17:02:02 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD82C0613D4
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2020 14:02:02 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id j14so6887639ots.1
        for <linux-pci@vger.kernel.org>; Thu, 19 Nov 2020 14:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NYuu+Nbmo6sMsUvJEboAUabfZdwKjJZgisoP6m912L4=;
        b=lPFE6Hy75hDfPD/2PI1gP0ZeMkqhjWDW741FcaSQTIanGB/+KHgk/dEFpmW88yFYUM
         yrJwrS6vJhLzSovddYaYTRHi77+8pjErs1EID9BV6e+HRGj7BHl6iFLTcS4v9YOfVQ1k
         jXAYKcjD3x40p4PKuvC6nJxWUFipZNihLi6ako3ffR5dtj5ESsIUrcnLInsGDOvVV6pM
         /2Ky1TVMTuuMIzKbD5uqrbT1eWL1NvusqQALz34TniXiT4bRwoY55wXiYBZlzFob6qoG
         JCKdW2xYPIqAIxulOdU+k1ZRNjT66BrUwR0ixOgemmWpESrumJ1+stniljdzTiCYJuyW
         vvlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NYuu+Nbmo6sMsUvJEboAUabfZdwKjJZgisoP6m912L4=;
        b=sNOMJAYu9Buc4qw/WiraZR0VIljayJEbQoKmMOKZQF3027DQrw4DfKOw9287OkVPxw
         nWZL6oz4nj3KObkxcWfwDI95A+9Pt8G9MaiiGF//JtFlhxmDXdTUAGTYQsYMJBgn06tP
         fDoG0fYOx9fOkKfuHqbVQTd7jKrAnYLtyPyF8OWcLeg9U64ZTc+vswr+MbgcqOn99KMS
         /UNtLGPaFv6kFPfqsnSOoThLfIn9en2IsHKqxCc4MYb64chZhVoweYzviZ9MesIW2HSw
         3XkixZFQlJg8P1LCOWWtFws6wOA6NxzAPz3DNsfIojY3u6z5pr5zDm1xf8HMmgAOVlJC
         wxtg==
X-Gm-Message-State: AOAM530bOv8zVGb7vcijv/E+m0S8YbeSmkPUGHQMTKnDaRZX5LVzGrpI
        jH87KQp3j/C+cQ/iP/LU2Wh4OtYL5QcbiqGPdZ9kXkyuWMOc4g==
X-Google-Smtp-Source: ABdhPJzchB9PwG4mR70wTWVmRQnHByOXsSFlPN7bFA4m0chSh4Evh6Z1rSk7mcRkwWKPoKK5+HYnIiy+4FjHkNzUeP8=
X-Received: by 2002:a05:6830:2093:: with SMTP id y19mr11666184otq.219.1605823321584;
 Thu, 19 Nov 2020 14:02:01 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uEjj-Od3B=RtQDV_7ibDOsY6WxKGiJXt0MYq3C6kaVPcQ@mail.gmail.com>
 <20201119191932.GA121237@bjorn-Precision-5520>
In-Reply-To: <20201119191932.GA121237@bjorn-Precision-5520>
From:   Jesse Barnes <jsbarnes@google.com>
Date:   Thu, 19 Nov 2020 14:01:50 -0800
Message-ID: <CAJmaN=kU4Rf62rZt-eDWW5M2CPHmxA4ZzX+AXJx6vjVhoGn13w@mail.gmail.com>
Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Daniel Vetter <daniel@ffwll.ch>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        Matthew D Roper <matthew.d.roper@intel.com>,
        hariom.pandey@intel.com, Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 19, 2020 at 11:19 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> [+cc Jesse]
>
> On Thu, Nov 19, 2020 at 10:37:10AM +0100, Daniel Vetter wrote:
> > On Thu, Nov 19, 2020 at 12:14 AM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Wed, Nov 18, 2020 at 10:57:26PM +0100, Daniel Vetter wrote:
> > > > On Wed, Nov 18, 2020 at 5:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > On Fri, Nov 06, 2020 at 10:39:16AM +0100, Daniel Vetter wrote:
> > > > > > On Thu, Nov 5, 2020 at 3:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > > > > > On Thu, Nov 05, 2020 at 11:46:06AM +0200, Joonas Lahtinen wrote:
> > > > > > > > Quoting Bjorn Helgaas (2020-11-04 19:35:56)
> > > > > > > > > [+cc Jani, Joonas, Rodrigo, David, Daniel]
> > > > > > > > >
> > > > > > > > > On Wed, Nov 04, 2020 at 05:35:06PM +0530, Tejas Upadhyay wrote:
> > > > > > > > > > JSL re-uses the same stolen memory as ICL and EHL.
> > > > > > > > > >
> > > > > > > > > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > > > > > > > > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > > > > > > > > Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > > > > > > > >
> > > > > > > > > I don't plan to do anything with this since previous similar patches
> > > > > > > > > have gone through some other tree, so this is just kibitzing.
> > > > > > > > >
> > > > > > > > > But the fact that we have this long list of Intel devices [1] that
> > > > > > > > > constantly needs updates [2] is a hint that something is wrong.
> > > > > > > >
> > > > > > > > We add an entry for every new integrated graphics platform. Once the
> > > > > > > > platform is added, there have not been changes lately.
> > > > > > > >
> > > > > > > > > IIUC the general idea is that we need to discover Intel gfx memory by
> > > > > > > > > looking at device-dependent config space and add it to the E820 map.
> > > > > > > > > Apparently the quirks discover this via PCI config registers like
> > > > > > > > > I830_ESMRAMC, I845_ESMRAMC, etc, and tell the driver about it via the
> > > > > > > > > global "intel_graphics_stolen_res"?
> > > > > > > >
> > > > > > > > We discover what is called the graphics data stolen memory. It is regular
> > > > > > > > system memory range that is not CPU accessible. It is accessible by the
> > > > > > > > integrated graphics only.
> > > > > > > >
> > > > > > > > See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/kernel/early-quirks.c?h=v5.10-rc2&id=814c5f1f52a4beb3710317022acd6ad34fc0b6b9
> > > > > > > >
> > > > > > > > > That's not the way this should work.  There should some generic, non
> > > > > > > > > device-dependent PCI or ACPI method to discover the memory used, or at
> > > > > > > > > least some way to do it in the driver instead of early arch code.
> > > > > > > >
> > > > > > > > It's used by the early BIOS/UEFI code to set up initial framebuffer.
> > > > > > > > Even if i915 driver is never loaded, the memory ranges still need to
> > > > > > > > be fixed. They source of the problem is that the OEM BIOS which are
> > > > > > > > not under our control get the programming wrong.
> > > > > > > >
> > > > > > > > We used to detect the memory region size again at i915 initialization
> > > > > > > > but wanted to eliminate the code duplication and resulting subtle bugs
> > > > > > > > that caused. Conclusion back then was that storing the struct resource
> > > > > > > > in memory is the best trade-off.
> > > > > > > >
> > > > > > > > > How is this *supposed* to work?  Is there something we can do in E820
> > > > > > > > > or other resource management that would make this easier?
> > > > > > > >
> > > > > > > > The code was added around Haswell (HSW) device generation to mitigate
> > > > > > > > bugs in BIOS. It is traditionally hard to get all OEMs to fix their
> > > > > > > > BIOS when things work for Windows. It's only later years when some
> > > > > > > > laptop models are intended to be sold with Linux.
> > > > > > > >
> > > > > > > > The alternative would be to get all the OEM to fix their BIOS for Linux,
> > > > > > > > but that is not very realistic given past experiences. So it seems
> > > > > > > > a better choice to to add new line per platform generation to make
> > > > > > > > sure the users can boot to Linux.
> > > > > > >
> > > > > > > How does Windows do this?  Do they have to add similar code for each
> > > > > > > new platform?
> > > > > >
> > > > > > Windows is chicken and doesn't move any mmio bar around on its own.
> > > > > > Except if the bios explicitly told it somehow (e.g. for the 64bit bar
> > > > > > stuff amd recently announced for windows, that linux supports since
> > > > > > years by moving the bar). So except if you want to preemptively
> > > > > > disable the pci code that does this anytime there's an intel gpu, this
> > > > > > is what we have to do.
> > > > >
> > > > > I think Windows *does* move BARs (they use the more generic
> > > > > terminology of "rebalancing PNP resources") in some cases [3,4].  Of
> > > > > course, I'm pretty sure Windows will only assign PCI resources inside
> > > > > the windows advertised in the host bridge _CRS.
> > > > >
> > > > > Linux *used* to ignore that host bridge _CRS and could set BARs to
> > > > > addresses that appeared available but were in fact used by the
> > > > > platform somehow.  But Linux has been paying attention to host bridge
> > > > > _CRS for a long time now, so it should also only assign resources
> > > > > inside those windows.
> > > >
> > > > If this behaviour is newer than the addition of these quirks then yeah
> > > > they're probably not needed anymore, and we can move all this back
> > > > into the driver. Do you have the commit when pci core started
> > > > observing _CRS on the host bridge?
> > >
> > > I think the most relevant commit is this:
> > >
> > >   2010-02-23 7bc5e3f2be32 ("x86/PCI: use host bridge _CRS info by default on 2008 and newer machines")
> > >
> > > but the earliest quirk I found is over three years later:
> > >
> > >   2013-07-26 814c5f1f52a4 ("x86: add early quirk for reserving Intel graphics stolen memory v5")
> > >
> > > So there must be something else going on.  814c5f1f52a4 mentions a
> > > couple bug reports.  The dmesg from 66726 [5] shows that we *are*
> > > observing the host bridge _CRS, but Linux just used the BIOS
> > > configuration without changing anything:
> > >
> > >   BIOS-e820: [mem 0x000000007f49_f000-0x000000007f5f_ffff] usable
> > >   BIOS-e820: [mem 0x00000000fec0_0000-0x00000000fec0_0fff] reserved
> > >   PCI: Using host bridge windows from ACPI; if necessary, use "pci=nocrs" and report a bug
> > >   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> > >   pci_bus 0000:00: root bus resource [mem 0x7f70_0000-0xffff_ffff]
> > >   pci 0000:00:1c.0: PCI bridge to [bus 01]
> > >   pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> > >   pci 0000:00:1c.0:   bridge window [mem 0xfe90_0000-0xfe9f_ffff]
> > >   pci 0000:00:1c.0:   bridge window [mem 0x7f70_0000-0x7f8f_ffff 64bit pref]
> > >   pci 0000:01:00.0: [1814:3090] type 00 class 0x028000
> > >   pci 0000:01:00.0: reg 10: [mem 0xfe90_0000-0xfe90_ffff]
> > >   [drm:i915_stolen_to_physical] *ERROR* conflict detected with stolen region: [0x7f80_0000 - 0x8000_0000]
> > >
> > > So the BIOS programmed the 00:1c.0 bridge prefetchable window to
> > > [mem 0x7f70_0000-0x7f8f_ffff], and i915 thinks that's a conflict.
> > >
> > > On this system, there are no PCI BARs in that range.  01:00.0 looks
> > > like a Ralink RT3090 Wireless 802.11n device that only has a
> > > non-prefetchable BAR at [mem 0xfe90_0000-0xfe90_ffff].
> > >
> > > I don't know the details of the conflict.  IIUC, Joonas said the
> > > stolen memory is accessible only by the integrated graphics, not by
> > > the CPU.  The bridge window is CPU accessible, of course, and the
> > > [mem 0x7f70_0000-0x7f8f_ffff] range contains the addresses the CPU
> > > uses for programmed I/O to BARs below the bridge.
> > >
> > > The graphics accesses sound like they would be DMA in the *bus*
> > > address space, which is frequently, but not always, identical to the
> > > CPU address space.
> >
> > So apparently on some platforms the conflict is harmless because the
> > BIOS puts BARs and stuff over it from boot-up, and things work:
> > 0b6d24c01932 ("drm/i915: Don't complain about stolen conflicts on
> > gen3") But we also had conflict reports on other machines.
>
> The bug reports mentioned in 814c5f1f52a4 ("x86: add early quirk for
> reserving Intel graphics stolen memory v5") and 0b6d24c01932
> ("drm/i915: Don't complain about stolen conflicts on gen3") seem to be
> basically complaints about the *message*, not anything that's actually
> broken.
>
> Jesse's comment [6]:
>
>   Given the decode priority on our GMCHs, it's fine if the regions
>   overlap.  However it doesn't look like there's a nice way to detect
>   it.  In this case, part of the range occupied by the stolen space is
>   simply "reserved" per the E820, but the rest of it is under the bus
>   0 range (which kind of makes sense too).
>
> sounds relevant but I don't know enough to interpret it.  I added
> Jesse in case he wants to comment.
>
> > GPU does all its access with CPU address space (after the iommu, which
> > is entirely integrated). So I'm not sure whether we've seen something
> > go boom or whether reserving that resource was just precaution in
> > eaba1b8f3379 ("drm/i915: Verify that our stolen memory doesn't
> > conflict"), it's all a bit way back in history.
> >
> > So really not sure what to do here or what the risks are.
>
> I'm not either.  Seems like we're not really converging on anything
> useful we can do at this point.  The only thing I can think of would
> be to collect data about actual failures (not just warning messages).
> That might lead to something we could improve in the future.

I don't have any brilliant ideas here unfortunately.  Maybe it's worth
talking to some of the Windows folks internally to see how these
ranges are handled these days and matching it?  Historically this has
been an area fraught with danger because getting things wrong can lead
to corruption of various kinds or boot hangs.

Jesse
