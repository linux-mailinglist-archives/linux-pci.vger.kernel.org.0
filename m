Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB7C494855
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jan 2022 08:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359023AbiATHfc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jan 2022 02:35:32 -0500
Received: from mga09.intel.com ([134.134.136.24]:63310 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238012AbiATHfc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Jan 2022 02:35:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642664132; x=1674200132;
  h=mime-version:content-transfer-encoding:in-reply-to:
   references:subject:to:from:cc:message-id:date;
  bh=dmZcvNAqzeN/yeDa/mmZFwzZZino+XkNkWDuITyi1Wo=;
  b=YMdXiKzY+MGgWZvY3fDNJXe7J3f3ugmCZm3MsMh/JUkPJ4KvMoml0SPY
   HgU2LwhTsgrlIEh570qBndIywOjuh+2Ih6bP28wzOxFkwEwvD+s/klKoJ
   cyaHjIhy+GvjgryFED8AidL9w7eNQ20NGCuBug2+HalXErO1kB0DMSIbn
   2p+fzNvrefV+daryx5RgdPl5rzsP/mcyi2Cr7d/QO5Es5zLoFHk9eWR8s
   VLHsP2lj+oMIuRpEW+8BOWv+RDviZn1xaqciRYI+gt9hXAMOZ2vodOceQ
   yMwPYytu6rzTxtYbTKGcc7eUap1l3fSPgTGKBnRmDCZ5w28LxeorcNUmF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10232"; a="245085230"
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="245085230"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 23:35:31 -0800
X-IronPort-AV: E=Sophos;i="5.88,301,1635231600"; 
   d="scan'208";a="626197288"
Received: from cmathias-mobl1.ger.corp.intel.com (HELO localhost) ([10.249.254.27])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2022 23:35:27 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220120011008.6tmvfnvr2zqedhkj@ldmartin-desk2>
References: <CAKMK7uEjj-Od3B=RtQDV_7ibDOsY6WxKGiJXt0MYq3C6kaVPcQ@mail.gmail.com> <20201119191932.GA121237@bjorn-Precision-5520> <CAJmaN=kU4Rf62rZt-eDWW5M2CPHmxA4ZzX+AXJx6vjVhoGn13w@mail.gmail.com> <20220120011008.6tmvfnvr2zqedhkj@ldmartin-desk2>
Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
To:     Jesse Barnes <jsbarnes@google.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Matthew D Roper <matthew.d.roper@intel.com>,
        hariom.pandey@intel.com, Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <164266412489.4417.7304113188282977117@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Thu, 20 Jan 2022 09:35:24 +0200
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Tvrtko

Quoting Lucas De Marchi (2022-01-20 03:10:08)
> Resurrecting this thread after the other discussion on stolen memory
> for Intel integrated GPU when there are Intel discrete GPU present:
> https://lore.kernel.org/linux-pci/20220118200145.GA887728@bhelgaas/
>=20
> see below.
>=20
> On Thu, Nov 19, 2020 at 02:01:50PM -0800, Jesse Barnes wrote:
> >On Thu, Nov 19, 2020 at 11:19 AM Bjorn Helgaas <helgaas@kernel.org> wrot=
e:
> >>
> >> [+cc Jesse]
> >>
> >> On Thu, Nov 19, 2020 at 10:37:10AM +0100, Daniel Vetter wrote:
> >> > On Thu, Nov 19, 2020 at 12:14 AM Bjorn Helgaas <helgaas@kernel.org> =
wrote:
> >> > > On Wed, Nov 18, 2020 at 10:57:26PM +0100, Daniel Vetter wrote:
> >> > > > On Wed, Nov 18, 2020 at 5:02 PM Bjorn Helgaas <helgaas@kernel.or=
g> wrote:
> >> > > > > On Fri, Nov 06, 2020 at 10:39:16AM +0100, Daniel Vetter wrote:
> >> > > > > > On Thu, Nov 5, 2020 at 3:17 PM Bjorn Helgaas <helgaas@kernel=
.org> wrote:
> >> > > > > > > On Thu, Nov 05, 2020 at 11:46:06AM +0200, Joonas Lahtinen =
wrote:
> >> > > > > > > > Quoting Bjorn Helgaas (2020-11-04 19:35:56)
> >> > > > > > > > > [+cc Jani, Joonas, Rodrigo, David, Daniel]
> >> > > > > > > > >
> >> > > > > > > > > On Wed, Nov 04, 2020 at 05:35:06PM +0530, Tejas Upadhy=
ay wrote:
> >> > > > > > > > > > JSL re-uses the same stolen memory as ICL and EHL.
> >> > > > > > > > > >
> >> > > > > > > > > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> >> > > > > > > > > > Cc: Matt Roper <matthew.d.roper@intel.com>
> >> > > > > > > > > > Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrak=
umar.upadhyay@intel.com>
> >> > > > > > > > >
> >> > > > > > > > > I don't plan to do anything with this since previous s=
imilar patches
> >> > > > > > > > > have gone through some other tree, so this is just kib=
itzing.
> >> > > > > > > > >
> >> > > > > > > > > But the fact that we have this long list of Intel devi=
ces [1] that
> >> > > > > > > > > constantly needs updates [2] is a hint that something =
is wrong.
> >> > > > > > > >
> >> > > > > > > > We add an entry for every new integrated graphics platfo=
rm. Once the
> >> > > > > > > > platform is added, there have not been changes lately.
> >> > > > > > > >
> >> > > > > > > > > IIUC the general idea is that we need to discover Inte=
l gfx memory by
> >> > > > > > > > > looking at device-dependent config space and add it to=
 the E820 map.
> >> > > > > > > > > Apparently the quirks discover this via PCI config reg=
isters like
> >> > > > > > > > > I830_ESMRAMC, I845_ESMRAMC, etc, and tell the driver a=
bout it via the
> >> > > > > > > > > global "intel_graphics_stolen_res"?
> >> > > > > > > >
> >> > > > > > > > We discover what is called the graphics data stolen memo=
ry. It is regular
> >> > > > > > > > system memory range that is not CPU accessible. It is ac=
cessible by the
> >> > > > > > > > integrated graphics only.
> >> > > > > > > >
> >> > > > > > > > See: https://git.kernel.org/pub/scm/linux/kernel/git/tor=
valds/linux.git/commit/arch/x86/kernel/early-quirks.c?h=3Dv5.10-rc2&id=3D81=
4c5f1f52a4beb3710317022acd6ad34fc0b6b9
> >> > > > > > > >
> >> > > > > > > > > That's not the way this should work.  There should som=
e generic, non
> >> > > > > > > > > device-dependent PCI or ACPI method to discover the me=
mory used, or at
> >> > > > > > > > > least some way to do it in the driver instead of early=
 arch code.
> >> > > > > > > >
> >> > > > > > > > It's used by the early BIOS/UEFI code to set up initial =
framebuffer.
> >> > > > > > > > Even if i915 driver is never loaded, the memory ranges s=
till need to
> >> > > > > > > > be fixed. They source of the problem is that the OEM BIO=
S which are
> >> > > > > > > > not under our control get the programming wrong.
> >> > > > > > > >
> >> > > > > > > > We used to detect the memory region size again at i915 i=
nitialization
> >> > > > > > > > but wanted to eliminate the code duplication and resulti=
ng subtle bugs
> >> > > > > > > > that caused. Conclusion back then was that storing the s=
truct resource
> >> > > > > > > > in memory is the best trade-off.
> >> > > > > > > >
> >> > > > > > > > > How is this *supposed* to work?  Is there something we=
 can do in E820
> >> > > > > > > > > or other resource management that would make this easi=
er?
> >> > > > > > > >
> >> > > > > > > > The code was added around Haswell (HSW) device generatio=
n to mitigate
> >> > > > > > > > bugs in BIOS. It is traditionally hard to get all OEMs t=
o fix their
> >> > > > > > > > BIOS when things work for Windows. It's only later years=
 when some
> >> > > > > > > > laptop models are intended to be sold with Linux.
> >> > > > > > > >
> >> > > > > > > > The alternative would be to get all the OEM to fix their=
 BIOS for Linux,
> >> > > > > > > > but that is not very realistic given past experiences. S=
o it seems
> >> > > > > > > > a better choice to to add new line per platform generati=
on to make
> >> > > > > > > > sure the users can boot to Linux.
> >> > > > > > >
> >> > > > > > > How does Windows do this?  Do they have to add similar cod=
e for each
> >> > > > > > > new platform?
> >> > > > > >
> >> > > > > > Windows is chicken and doesn't move any mmio bar around on i=
ts own.
> >> > > > > > Except if the bios explicitly told it somehow (e.g. for the =
64bit bar
> >> > > > > > stuff amd recently announced for windows, that linux support=
s since
> >> > > > > > years by moving the bar). So except if you want to preemptiv=
ely
> >> > > > > > disable the pci code that does this anytime there's an intel=
 gpu, this
> >> > > > > > is what we have to do.
> >> > > > >
> >> > > > > I think Windows *does* move BARs (they use the more generic
> >> > > > > terminology of "rebalancing PNP resources") in some cases [3,4=
].  Of
> >> > > > > course, I'm pretty sure Windows will only assign PCI resources=
 inside
> >> > > > > the windows advertised in the host bridge _CRS.
> >> > > > >
> >> > > > > Linux *used* to ignore that host bridge _CRS and could set BAR=
s to
> >> > > > > addresses that appeared available but were in fact used by the
> >> > > > > platform somehow.  But Linux has been paying attention to host=
 bridge
> >> > > > > _CRS for a long time now, so it should also only assign resour=
ces
> >> > > > > inside those windows.
> >> > > >
> >> > > > If this behaviour is newer than the addition of these quirks the=
n yeah
> >> > > > they're probably not needed anymore, and we can move all this ba=
ck
> >> > > > into the driver. Do you have the commit when pci core started
> >> > > > observing _CRS on the host bridge?
> >> > >
> >> > > I think the most relevant commit is this:
> >> > >
> >> > >   2010-02-23 7bc5e3f2be32 ("x86/PCI: use host bridge _CRS info by =
default on 2008 and newer machines")
> >> > >
> >> > > but the earliest quirk I found is over three years later:
> >> > >
> >> > >   2013-07-26 814c5f1f52a4 ("x86: add early quirk for reserving Int=
el graphics stolen memory v5")
> >> > >
> >> > > So there must be something else going on.  814c5f1f52a4 mentions a
> >> > > couple bug reports.  The dmesg from 66726 [5] shows that we *are*
> >> > > observing the host bridge _CRS, but Linux just used the BIOS
> >> > > configuration without changing anything:
> >> > >
> >> > >   BIOS-e820: [mem 0x000000007f49_f000-0x000000007f5f_ffff] usable
> >> > >   BIOS-e820: [mem 0x00000000fec0_0000-0x00000000fec0_0fff] reserved
> >> > >   PCI: Using host bridge windows from ACPI; if necessary, use "pci=
=3Dnocrs" and report a bug
> >> > >   ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
> >> > >   pci_bus 0000:00: root bus resource [mem 0x7f70_0000-0xffff_ffff]
> >> > >   pci 0000:00:1c.0: PCI bridge to [bus 01]
> >> > >   pci 0000:00:1c.0:   bridge window [io  0x1000-0x1fff]
> >> > >   pci 0000:00:1c.0:   bridge window [mem 0xfe90_0000-0xfe9f_ffff]
> >> > >   pci 0000:00:1c.0:   bridge window [mem 0x7f70_0000-0x7f8f_ffff 6=
4bit pref]
> >> > >   pci 0000:01:00.0: [1814:3090] type 00 class 0x028000
> >> > >   pci 0000:01:00.0: reg 10: [mem 0xfe90_0000-0xfe90_ffff]
> >> > >   [drm:i915_stolen_to_physical] *ERROR* conflict detected with sto=
len region: [0x7f80_0000 - 0x8000_0000]
> >> > >
> >> > > So the BIOS programmed the 00:1c.0 bridge prefetchable window to
> >> > > [mem 0x7f70_0000-0x7f8f_ffff], and i915 thinks that's a conflict.
> >> > >
> >> > > On this system, there are no PCI BARs in that range.  01:00.0 looks
> >> > > like a Ralink RT3090 Wireless 802.11n device that only has a
> >> > > non-prefetchable BAR at [mem 0xfe90_0000-0xfe90_ffff].
> >> > >
> >> > > I don't know the details of the conflict.  IIUC, Joonas said the
> >> > > stolen memory is accessible only by the integrated graphics, not by
> >> > > the CPU.  The bridge window is CPU accessible, of course, and the
> >> > > [mem 0x7f70_0000-0x7f8f_ffff] range contains the addresses the CPU
> >> > > uses for programmed I/O to BARs below the bridge.
> >> > >
> >> > > The graphics accesses sound like they would be DMA in the *bus*
> >> > > address space, which is frequently, but not always, identical to t=
he
> >> > > CPU address space.
> >> >
> >> > So apparently on some platforms the conflict is harmless because the
> >> > BIOS puts BARs and stuff over it from boot-up, and things work:
> >> > 0b6d24c01932 ("drm/i915: Don't complain about stolen conflicts on
> >> > gen3") But we also had conflict reports on other machines.
> >>
> >> The bug reports mentioned in 814c5f1f52a4 ("x86: add early quirk for
> >> reserving Intel graphics stolen memory v5") and 0b6d24c01932
> >> ("drm/i915: Don't complain about stolen conflicts on gen3") seem to be
> >> basically complaints about the *message*, not anything that's actually
> >> broken.
> >>
> >> Jesse's comment [6]:
> >>
> >>   Given the decode priority on our GMCHs, it's fine if the regions
> >>   overlap.  However it doesn't look like there's a nice way to detect
> >>   it.  In this case, part of the range occupied by the stolen space is
> >>   simply "reserved" per the E820, but the rest of it is under the bus
> >>   0 range (which kind of makes sense too).
> >>
> >> sounds relevant but I don't know enough to interpret it.  I added
> >> Jesse in case he wants to comment.
> >>
> >> > GPU does all its access with CPU address space (after the iommu, whi=
ch
> >> > is entirely integrated). So I'm not sure whether we've seen something
> >> > go boom or whether reserving that resource was just precaution in
> >> > eaba1b8f3379 ("drm/i915: Verify that our stolen memory doesn't
> >> > conflict"), it's all a bit way back in history.
> >> >
> >> > So really not sure what to do here or what the risks are.
> >>
> >> I'm not either.  Seems like we're not really converging on anything
> >> useful we can do at this point.  The only thing I can think of would
> >> be to collect data about actual failures (not just warning messages).
> >> That might lead to something we could improve in the future.
> >
> >I don't have any brilliant ideas here unfortunately.  Maybe it's worth
> >talking to some of the Windows folks internally to see how these
> >ranges are handled these days and matching it?  Historically this has
> >been an area fraught with danger because getting things wrong can lead
> >to corruption of various kinds or boot hangs.
>=20
> We could try something else, but if there are bios bugs for old systems
> preventing us to do this entirely in i915, I'm not sure that would
> solve it.
>=20
> What if we phase out the quirks for new platforms? Idea would be to
> revive eaba1b8f3379 ("drm/i915: Verify that our stolen memory doesn't con=
flict")
> adapted to the current code. Then we can move some o the latest
> platforms and watch out for regressions. At least we would stop
> additions to this early-quirk.c

I'm not really a big fan of doing that unless we follow with the
hardware and Windows folks to double-check that the problem really
shouldn't occur anymore in the BIOS.

Considering the trade-off here: we eliminate a few line additions and
risk making user systems non-bootable. I don't think doing that blindly
is very friendly to our users.

Regards, Joonas

>=20
> Another idea: wouldn't DECLARE_PCI_FIXUP_EARLY work? AFAICS this is
> early enough to reserve the memory.
>=20
> Also We could add only those systems where we reproduce bugs
> rather than preemptively adding them to the table - it would at least
> allow to catch those bugs in bioses rather than hiding them.
>=20
>=20
> Lucas De Marchi
>=20
> >
> >Jesse
