Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47F562A92E8
	for <lists+linux-pci@lfdr.de>; Fri,  6 Nov 2020 10:39:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgKFJj3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Nov 2020 04:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725868AbgKFJj2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 6 Nov 2020 04:39:28 -0500
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1558EC0613CF
        for <linux-pci@vger.kernel.org>; Fri,  6 Nov 2020 01:39:28 -0800 (PST)
Received: by mail-ot1-x344.google.com with SMTP id i18so723751ots.0
        for <linux-pci@vger.kernel.org>; Fri, 06 Nov 2020 01:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hS2BcTK5z4a4yf5TkDGwLlw45N7VqY69EtqF7XSPepE=;
        b=aMl4UYdBmBBIKNsYJIV0jBhnWVT+pm9PcFP3BxPdZOwCL0rBh51smgskvqWj7aK/vd
         LYOxAaErD3aHyl/kFgQY/A/P071Y+eKaJWsBQl8ko04IeMqpGuOemz35JwMvIqXPz2l3
         G0gFebo/yJp9cBkKo4VZWoGtOKdqYpsVxupdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hS2BcTK5z4a4yf5TkDGwLlw45N7VqY69EtqF7XSPepE=;
        b=LPUIw6HcktWbhkeGuSR2JxwjFpmueKr5gqYLy7ScqQDIVeifZJE2zaMTam0ocyxRHM
         9DGPMTFn1D3z0hYqoouzNoS5qDbAoIuEXVKhPooXYWhhAnNwwEWXjI2zJI94H3bE3TUa
         abS4Dooz/3gDZYrBYAv1ZGgjFBo6HemqN4k+MVN+T1BeZQ6NzjqkB/ldjG2B3uq5ahyv
         62CK1xx7b13j5dwU8CHYZx2ihGGaM1pKMWWVk0c5kUEaBrh83jxMBv37NF5N5uScuiSB
         4BtYziMr3xrji2/V3W1rllsiQcSecm2XGAd0fcz0MAQjmOLXMzA35h1++9NpmG50bOGn
         zjxg==
X-Gm-Message-State: AOAM5335V9Fybj+rNA2szuzH/JFMyhpImN9vbjZX7SzsJWhas9uL+dAK
        6x7D1tj+GMvuX1f068bZZyTRzdcSAGuhikO59zxe9Q==
X-Google-Smtp-Source: ABdhPJyOY2iais1PWyvYc8pE7etVO2yrqRvoAo9G5pG2lhAYCULriboO0tT8mJ7u1xjL+bzZW3VFJOvPjKrxE/4xZOo=
X-Received: by 2002:a05:6830:1647:: with SMTP id h7mr599057otr.281.1604655567484;
 Fri, 06 Nov 2020 01:39:27 -0800 (PST)
MIME-Version: 1.0
References: <160456956585.5393.4540325192433934522@jlahtine-mobl.ger.corp.intel.com>
 <20201105141739.GA493962@bjorn-Precision-5520>
In-Reply-To: <20201105141739.GA493962@bjorn-Precision-5520>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Fri, 6 Nov 2020 10:39:16 +0100
Message-ID: <CAKMK7uFj+5p4XPUnd2Mc3R4i2Umja5-iGgDg+jVzRBhCW-6qbQ@mail.gmail.com>
Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
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

On Thu, Nov 5, 2020 at 3:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Nov 05, 2020 at 11:46:06AM +0200, Joonas Lahtinen wrote:
> > Quoting Bjorn Helgaas (2020-11-04 19:35:56)
> > > [+cc Jani, Joonas, Rodrigo, David, Daniel]
> > >
> > > On Wed, Nov 04, 2020 at 05:35:06PM +0530, Tejas Upadhyay wrote:
> > > > JSL re-uses the same stolen memory as ICL and EHL.
> > > >
> > > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > > Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > >
> > > I don't plan to do anything with this since previous similar patches
> > > have gone through some other tree, so this is just kibitzing.
> > >
> > > But the fact that we have this long list of Intel devices [1] that
> > > constantly needs updates [2] is a hint that something is wrong.
> >
> > We add an entry for every new integrated graphics platform. Once the
> > platform is added, there have not been changes lately.
> >
> > > IIUC the general idea is that we need to discover Intel gfx memory by
> > > looking at device-dependent config space and add it to the E820 map.
> > > Apparently the quirks discover this via PCI config registers like
> > > I830_ESMRAMC, I845_ESMRAMC, etc, and tell the driver about it via the
> > > global "intel_graphics_stolen_res"?
> >
> > We discover what is called the graphics data stolen memory. It is regular
> > system memory range that is not CPU accessible. It is accessible by the
> > integrated graphics only.
> >
> > See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/kernel/early-quirks.c?h=v5.10-rc2&id=814c5f1f52a4beb3710317022acd6ad34fc0b6b9
> >
> > > That's not the way this should work.  There should some generic, non
> > > device-dependent PCI or ACPI method to discover the memory used, or at
> > > least some way to do it in the driver instead of early arch code.
> >
> > It's used by the early BIOS/UEFI code to set up initial framebuffer.
> > Even if i915 driver is never loaded, the memory ranges still need to
> > be fixed. They source of the problem is that the OEM BIOS which are
> > not under our control get the programming wrong.
> >
> > We used to detect the memory region size again at i915 initialization
> > but wanted to eliminate the code duplication and resulting subtle bugs
> > that caused. Conclusion back then was that storing the struct resource
> > in memory is the best trade-off.
> >
> > > How is this *supposed* to work?  Is there something we can do in E820
> > > or other resource management that would make this easier?
> >
> > The code was added around Haswell (HSW) device generation to mitigate
> > bugs in BIOS. It is traditionally hard to get all OEMs to fix their
> > BIOS when things work for Windows. It's only later years when some
> > laptop models are intended to be sold with Linux.
> >
> > The alternative would be to get all the OEM to fix their BIOS for Linux,
> > but that is not very realistic given past experiences. So it seems
> > a better choice to to add new line per platform generation to make
> > sure the users can boot to Linux.
>
> How does Windows do this?  Do they have to add similar code for each
> new platform?

Windows is chicken and doesn't move any mmio bar around on its own.
Except if the bios explicitly told it somehow (e.g. for the 64bit bar
stuff amd recently announced for windows, that linux supports since
years by moving the bar). So except if you want to preemptively
disable the pci code that does this anytime there's an intel gpu, this
is what we have to do.

And given that this 64bit mmio bar support in windows still requires
an explicit bios upgrade for the explicit opt in I don't think this
will change anytime soon.

We have a similar ugly problem with kvm, since you can't use these
ranges freely (they're very special in hw), and the kvm maintainers
are equally annoyed that they have to keep supporting RRMR to block
that range, just because of intel integrated graphics. Apparently
windows is again totally fine with this.
-Daniel


>
> > > > ---
> > > >  arch/x86/kernel/early-quirks.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > >
> > > > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > > > index a4b5af03dcc1..534cc3f78c6b 100644
> > > > --- a/arch/x86/kernel/early-quirks.c
> > > > +++ b/arch/x86/kernel/early-quirks.c
> > > > @@ -549,6 +549,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
> > > >       INTEL_CNL_IDS(&gen9_early_ops),
> > > >       INTEL_ICL_11_IDS(&gen11_early_ops),
> > > >       INTEL_EHL_IDS(&gen11_early_ops),
> > > > +     INTEL_JSL_IDS(&gen11_early_ops),
> > > >       INTEL_TGL_12_IDS(&gen11_early_ops),
> > > >       INTEL_RKL_IDS(&gen11_early_ops),
> > > >  };
> > >
> > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/early-quirks.c?h=v5.10-rc2#n518
> > >
> > > [2]
> > >   May 2020 efbee021ad02 ("x86/gpu: add RKL stolen memory support")
> > >   Jul 2019 6b2436aeb945 ("x86/gpu: add TGL stolen memory support")
> > >   Mar 2019 d53fef0be4a5 ("x86/gpu: add ElkhartLake to gen11 early quirks")
> > >   May 2018 db0c8d8b031d ("x86/gpu: reserve ICL's graphics stolen memory")
> > >   Dec 2017 33aa69ed8aac ("x86/gpu: add CFL to early quirks")
> > >   Jul 2017 2e1e9d48939e ("x86/gpu: CNL uses the same GMS values as SKL")
> > >   Jan 2017 bc384c77e3bb ("x86/gpu: GLK uses the same GMS values as SKL")
> > >   Oct 2015 00ce5c8a66fb ("drm/i915/kbl: Kabylake uses the same GMS values as Skylake")
> > >   Mar 2015 31d4dcf705c3 ("drm/i915/bxt: Broxton uses the same GMS values as Skylake")
> > >   ...



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
