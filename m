Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1EC2B870A
	for <lists+linux-pci@lfdr.de>; Wed, 18 Nov 2020 22:58:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726433AbgKRV5m (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Nov 2020 16:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725710AbgKRV5k (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Nov 2020 16:57:40 -0500
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B64C0613D6
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 13:57:38 -0800 (PST)
Received: by mail-oi1-x244.google.com with SMTP id c80so3996589oib.2
        for <linux-pci@vger.kernel.org>; Wed, 18 Nov 2020 13:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GXYWVa35MXkGoujDVrhSb9wJFjzw08YcnWue3rcfjq8=;
        b=hS9sFogtNqnE7hnRk4CHPYw8EWrOKH8Q4xVn7XRGwVtE04v23zCoGonDce35glfCR8
         LKMOtcfBqBxL6fZJKZQjuSvdCxSB/+O1XIPSNBw5Whs9fmdLEw0mwU4W+qAyPp2Di/53
         IIP3yTYQHzHf9rNH8EdX73tQOM8xzy6YoIfI8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GXYWVa35MXkGoujDVrhSb9wJFjzw08YcnWue3rcfjq8=;
        b=IsQGjVV8GT7tN/BMytNfswL1CNmFG+El7L/1KK4+Wf5WDRmqNjFBEKa69/bRH+pbXX
         D+bdyt6idss5QFp07j3wbVNsUHrPPSvrJqnttqGLTyQAd4PBWGYPMC/bpw92y6k68Znf
         Tss5D7T9RPVt3dNw5fP3H8FYk/mcuMqj5W90pv9iYgCT+Yxkdib40f9H5g2Y9YMP8DeH
         gL9gGcJvCReBbuwYtENCgV3UPj/S7qx1e2auGBgIu9Hci2vQONNizcnbIE6WkLS6T9oE
         JVk88AfRq45vTr1GI/elKuT2CjTjrkHqmW9MdtxpAjdvc1MbFVEMYigqUk3wCgbTbzOX
         QKAQ==
X-Gm-Message-State: AOAM53301uz1s6lAGguMyskT2hQ4+1/SII+4wJ60ZM4usTuycULzGHMQ
        cw3bZQUH6dx/d4bZgoyqXLolG0dJW3FfAPBSKJdYrQ==
X-Google-Smtp-Source: ABdhPJxTjwNLCy88v9cc19MR4gAqBWbzzdWm9P44HeMIaO+nB0WDmH36kh4uweeVFUDOUQuKL+rszi704oMLQU7dUvk=
X-Received: by 2002:aca:7506:: with SMTP id q6mr895116oic.128.1605736657792;
 Wed, 18 Nov 2020 13:57:37 -0800 (PST)
MIME-Version: 1.0
References: <CAKMK7uFj+5p4XPUnd2Mc3R4i2Umja5-iGgDg+jVzRBhCW-6qbQ@mail.gmail.com>
 <20201118160222.GA58120@bjorn-Precision-5520>
In-Reply-To: <20201118160222.GA58120@bjorn-Precision-5520>
From:   Daniel Vetter <daniel@ffwll.ch>
Date:   Wed, 18 Nov 2020 22:57:26 +0100
Message-ID: <CAKMK7uGuvuGf-b_rsMtwRXJzjQ9zAw1CXYVKxBLFAXQW0Hc7+A@mail.gmail.com>
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

On Wed, Nov 18, 2020 at 5:02 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Fri, Nov 06, 2020 at 10:39:16AM +0100, Daniel Vetter wrote:
> > On Thu, Nov 5, 2020 at 3:17 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> > > On Thu, Nov 05, 2020 at 11:46:06AM +0200, Joonas Lahtinen wrote:
> > > > Quoting Bjorn Helgaas (2020-11-04 19:35:56)
> > > > > [+cc Jani, Joonas, Rodrigo, David, Daniel]
> > > > >
> > > > > On Wed, Nov 04, 2020 at 05:35:06PM +0530, Tejas Upadhyay wrote:
> > > > > > JSL re-uses the same stolen memory as ICL and EHL.
> > > > > >
> > > > > > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > > > > > Cc: Matt Roper <matthew.d.roper@intel.com>
> > > > > > Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> > > > >
> > > > > I don't plan to do anything with this since previous similar patches
> > > > > have gone through some other tree, so this is just kibitzing.
> > > > >
> > > > > But the fact that we have this long list of Intel devices [1] that
> > > > > constantly needs updates [2] is a hint that something is wrong.
> > > >
> > > > We add an entry for every new integrated graphics platform. Once the
> > > > platform is added, there have not been changes lately.
> > > >
> > > > > IIUC the general idea is that we need to discover Intel gfx memory by
> > > > > looking at device-dependent config space and add it to the E820 map.
> > > > > Apparently the quirks discover this via PCI config registers like
> > > > > I830_ESMRAMC, I845_ESMRAMC, etc, and tell the driver about it via the
> > > > > global "intel_graphics_stolen_res"?
> > > >
> > > > We discover what is called the graphics data stolen memory. It is regular
> > > > system memory range that is not CPU accessible. It is accessible by the
> > > > integrated graphics only.
> > > >
> > > > See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/kernel/early-quirks.c?h=v5.10-rc2&id=814c5f1f52a4beb3710317022acd6ad34fc0b6b9
> > > >
> > > > > That's not the way this should work.  There should some generic, non
> > > > > device-dependent PCI or ACPI method to discover the memory used, or at
> > > > > least some way to do it in the driver instead of early arch code.
> > > >
> > > > It's used by the early BIOS/UEFI code to set up initial framebuffer.
> > > > Even if i915 driver is never loaded, the memory ranges still need to
> > > > be fixed. They source of the problem is that the OEM BIOS which are
> > > > not under our control get the programming wrong.
> > > >
> > > > We used to detect the memory region size again at i915 initialization
> > > > but wanted to eliminate the code duplication and resulting subtle bugs
> > > > that caused. Conclusion back then was that storing the struct resource
> > > > in memory is the best trade-off.
> > > >
> > > > > How is this *supposed* to work?  Is there something we can do in E820
> > > > > or other resource management that would make this easier?
> > > >
> > > > The code was added around Haswell (HSW) device generation to mitigate
> > > > bugs in BIOS. It is traditionally hard to get all OEMs to fix their
> > > > BIOS when things work for Windows. It's only later years when some
> > > > laptop models are intended to be sold with Linux.
> > > >
> > > > The alternative would be to get all the OEM to fix their BIOS for Linux,
> > > > but that is not very realistic given past experiences. So it seems
> > > > a better choice to to add new line per platform generation to make
> > > > sure the users can boot to Linux.
> > >
> > > How does Windows do this?  Do they have to add similar code for each
> > > new platform?
> >
> > Windows is chicken and doesn't move any mmio bar around on its own.
> > Except if the bios explicitly told it somehow (e.g. for the 64bit bar
> > stuff amd recently announced for windows, that linux supports since
> > years by moving the bar). So except if you want to preemptively
> > disable the pci code that does this anytime there's an intel gpu, this
> > is what we have to do.
>
> I think Windows *does* move BARs (they use the more generic
> terminology of "rebalancing PNP resources") in some cases [3,4].  Of
> course, I'm pretty sure Windows will only assign PCI resources inside
> the windows advertised in the host bridge _CRS.
>
> Linux *used* to ignore that host bridge _CRS and could set BARs to
> addresses that appeared available but were in fact used by the
> platform somehow.  But Linux has been paying attention to host bridge
> _CRS for a long time now, so it should also only assign resources
> inside those windows.

If this behaviour is newer than the addition of these quirks then yeah
they're probably not needed anymore, and we can move all this back
into the driver. Do you have the commit when pci core started
observing _CRS on the host bridge?
-Daniel

>
> So I'm missing what the real problem is.  Joonas mentioned BIOS bugs
> above, but I don't know what that means.
>
> Here's what I can figure out so far, tell me if I'm in the weeds:
>
>   - The intel_graphics_stolen() early quirk:
>       1) Initializes global struct resource intel_graphics_stolen_res
>       2) Adds the region to E820 map as E820_TYPE_RESERVED
>
>   - i915_driver_hw_probe() uses intel_graphics_stolen_res, but this
>     happens after the PCI core is initialized, so early quirks
>     wouldn't be required for this use.
>
>   - So I guess the E820 map update is what requires the early quirk?
>     But I don't know exactly what depends on this update.
>
> I haven't found the connection to the early BIOS/UEFI code and the
> initial framebuffer yet.
>
> > And given that this 64bit mmio bar support in windows still requires
> > an explicit bios upgrade for the explicit opt in I don't think this
> > will change anytime soon.
> >
> > We have a similar ugly problem with kvm, since you can't use these
> > ranges freely (they're very special in hw), and the kvm maintainers
> > are equally annoyed that they have to keep supporting RRMR to block
> > that range, just because of intel integrated graphics. Apparently
> > windows is again totally fine with this.
> > -Daniel
> >
> >
> > >
> > > > > > ---
> > > > > >  arch/x86/kernel/early-quirks.c | 1 +
> > > > > >  1 file changed, 1 insertion(+)
> > > > > >
> > > > > > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > > > > > index a4b5af03dcc1..534cc3f78c6b 100644
> > > > > > --- a/arch/x86/kernel/early-quirks.c
> > > > > > +++ b/arch/x86/kernel/early-quirks.c
> > > > > > @@ -549,6 +549,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
> > > > > >       INTEL_CNL_IDS(&gen9_early_ops),
> > > > > >       INTEL_ICL_11_IDS(&gen11_early_ops),
> > > > > >       INTEL_EHL_IDS(&gen11_early_ops),
> > > > > > +     INTEL_JSL_IDS(&gen11_early_ops),
> > > > > >       INTEL_TGL_12_IDS(&gen11_early_ops),
> > > > > >       INTEL_RKL_IDS(&gen11_early_ops),
> > > > > >  };
> > > > >
> > > > > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/early-quirks.c?h=v5.10-rc2#n518
> > > > >
> > > > > [2]
> > > > >   May 2020 efbee021ad02 ("x86/gpu: add RKL stolen memory support")
> > > > >   Jul 2019 6b2436aeb945 ("x86/gpu: add TGL stolen memory support")
> > > > >   Mar 2019 d53fef0be4a5 ("x86/gpu: add ElkhartLake to gen11 early quirks")
> > > > >   May 2018 db0c8d8b031d ("x86/gpu: reserve ICL's graphics stolen memory")
> > > > >   Dec 2017 33aa69ed8aac ("x86/gpu: add CFL to early quirks")
> > > > >   Jul 2017 2e1e9d48939e ("x86/gpu: CNL uses the same GMS values as SKL")
> > > > >   Jan 2017 bc384c77e3bb ("x86/gpu: GLK uses the same GMS values as SKL")
> > > > >   Oct 2015 00ce5c8a66fb ("drm/i915/kbl: Kabylake uses the same GMS values as Skylake")
> > > > >   Mar 2015 31d4dcf705c3 ("drm/i915/bxt: Broxton uses the same GMS values as Skylake")
> > > > >   ...
>
> [3] https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/stopping-a-device-to-rebalance-resources
> [4] http://download.microsoft.com/download/5/b/9/5b97017b-e28a-4bae-ba48-174cf47d23cd/cpa070_wh06.ppt ("PCI Express In Depth For Windows Vista and Beyond")



-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
