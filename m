Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B21612A809F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 15:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730814AbgKEORn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Nov 2020 09:17:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40288 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730775AbgKEORm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 09:17:42 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3B5052073A;
        Thu,  5 Nov 2020 14:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604585861;
        bh=UDvcaHDeHELwnGnyrjkWW1mbaEvMXe4JugAAo2sR0F4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=w2vObp5xH0DLOpaXZEb6+NvsINwM8w+Uar/SS+zqNrA1Q0cFtX5/ffgvGj4oLlwC8
         r4lPR3vo69dRFY4CWXBMhPl5O6u5jY941QqwixESmMv51wWQBqUlw3qoB3+Ei0xNfV
         pgpep30eoY+eeYPyICUOg9QD5lXLlx9K3szrZio0=
Date:   Thu, 5 Nov 2020 08:17:39 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, lucas.demarchi@intel.com,
        matthew.d.roper@intel.com, hariom.pandey@intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
Message-ID: <20201105141739.GA493962@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160456956585.5393.4540325192433934522@jlahtine-mobl.ger.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Nov 05, 2020 at 11:46:06AM +0200, Joonas Lahtinen wrote:
> Quoting Bjorn Helgaas (2020-11-04 19:35:56)
> > [+cc Jani, Joonas, Rodrigo, David, Daniel]
> > 
> > On Wed, Nov 04, 2020 at 05:35:06PM +0530, Tejas Upadhyay wrote:
> > > JSL re-uses the same stolen memory as ICL and EHL.
> > > 
> > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > 
> > I don't plan to do anything with this since previous similar patches
> > have gone through some other tree, so this is just kibitzing.
> > 
> > But the fact that we have this long list of Intel devices [1] that
> > constantly needs updates [2] is a hint that something is wrong.
> 
> We add an entry for every new integrated graphics platform. Once the
> platform is added, there have not been changes lately.
> 
> > IIUC the general idea is that we need to discover Intel gfx memory by
> > looking at device-dependent config space and add it to the E820 map.
> > Apparently the quirks discover this via PCI config registers like
> > I830_ESMRAMC, I845_ESMRAMC, etc, and tell the driver about it via the
> > global "intel_graphics_stolen_res"?
> 
> We discover what is called the graphics data stolen memory. It is regular
> system memory range that is not CPU accessible. It is accessible by the
> integrated graphics only.
> 
> See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/kernel/early-quirks.c?h=v5.10-rc2&id=814c5f1f52a4beb3710317022acd6ad34fc0b6b9
> 
> > That's not the way this should work.  There should some generic, non
> > device-dependent PCI or ACPI method to discover the memory used, or at
> > least some way to do it in the driver instead of early arch code.
> 
> It's used by the early BIOS/UEFI code to set up initial framebuffer.
> Even if i915 driver is never loaded, the memory ranges still need to
> be fixed. They source of the problem is that the OEM BIOS which are
> not under our control get the programming wrong.
> 
> We used to detect the memory region size again at i915 initialization
> but wanted to eliminate the code duplication and resulting subtle bugs
> that caused. Conclusion back then was that storing the struct resource
> in memory is the best trade-off.
> 
> > How is this *supposed* to work?  Is there something we can do in E820
> > or other resource management that would make this easier?
> 
> The code was added around Haswell (HSW) device generation to mitigate
> bugs in BIOS. It is traditionally hard to get all OEMs to fix their
> BIOS when things work for Windows. It's only later years when some
> laptop models are intended to be sold with Linux.
> 
> The alternative would be to get all the OEM to fix their BIOS for Linux,
> but that is not very realistic given past experiences. So it seems
> a better choice to to add new line per platform generation to make
> sure the users can boot to Linux.

How does Windows do this?  Do they have to add similar code for each
new platform?

> > > ---
> > >  arch/x86/kernel/early-quirks.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > > 
> > > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > > index a4b5af03dcc1..534cc3f78c6b 100644
> > > --- a/arch/x86/kernel/early-quirks.c
> > > +++ b/arch/x86/kernel/early-quirks.c
> > > @@ -549,6 +549,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
> > >       INTEL_CNL_IDS(&gen9_early_ops),
> > >       INTEL_ICL_11_IDS(&gen11_early_ops),
> > >       INTEL_EHL_IDS(&gen11_early_ops),
> > > +     INTEL_JSL_IDS(&gen11_early_ops),
> > >       INTEL_TGL_12_IDS(&gen11_early_ops),
> > >       INTEL_RKL_IDS(&gen11_early_ops),
> > >  };
> > 
> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/early-quirks.c?h=v5.10-rc2#n518
> > 
> > [2]
> >   May 2020 efbee021ad02 ("x86/gpu: add RKL stolen memory support")
> >   Jul 2019 6b2436aeb945 ("x86/gpu: add TGL stolen memory support")
> >   Mar 2019 d53fef0be4a5 ("x86/gpu: add ElkhartLake to gen11 early quirks")
> >   May 2018 db0c8d8b031d ("x86/gpu: reserve ICL's graphics stolen memory")
> >   Dec 2017 33aa69ed8aac ("x86/gpu: add CFL to early quirks")
> >   Jul 2017 2e1e9d48939e ("x86/gpu: CNL uses the same GMS values as SKL")
> >   Jan 2017 bc384c77e3bb ("x86/gpu: GLK uses the same GMS values as SKL")
> >   Oct 2015 00ce5c8a66fb ("drm/i915/kbl: Kabylake uses the same GMS values as Skylake")
> >   Mar 2015 31d4dcf705c3 ("drm/i915/bxt: Broxton uses the same GMS values as Skylake")
> >   ...
