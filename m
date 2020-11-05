Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D0D2A7AF0
	for <lists+linux-pci@lfdr.de>; Thu,  5 Nov 2020 10:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727379AbgKEJqN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Thu, 5 Nov 2020 04:46:13 -0500
Received: from mga02.intel.com ([134.134.136.20]:50768 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726894AbgKEJqN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Nov 2020 04:46:13 -0500
IronPort-SDR: agtKEWIljey1dafuWpBBzmdWntsCFCfnri9FfTl6HuW9wmKbaJI8SwkdgDMnxN/1268OlOOGb0
 GD+Ro8Cqf/QQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9795"; a="156346990"
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="156346990"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 01:46:12 -0800
IronPort-SDR: LP3YMUn310MILM2LDvZspBhNB/KJhExXuqSqz7IzDYrmcMu5Tsm9WiaGjAgcW1KhIl73EultN2
 Wiug49oZe46A==
X-IronPort-AV: E=Sophos;i="5.77,453,1596524400"; 
   d="scan'208";a="471582971"
Received: from mwaskox-mobl.ger.corp.intel.com (HELO localhost) ([10.252.10.106])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2020 01:46:09 -0800
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20201104173556.GA359362@bjorn-Precision-5520>
References: <20201104173556.GA359362@bjorn-Precision-5520>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
From:   Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, lucas.demarchi@intel.com,
        matthew.d.roper@intel.com, hariom.pandey@intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Message-ID: <160456956585.5393.4540325192433934522@jlahtine-mobl.ger.corp.intel.com>
User-Agent: alot/0.8.1
Date:   Thu, 05 Nov 2020 11:46:06 +0200
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Quoting Bjorn Helgaas (2020-11-04 19:35:56)
> [+cc Jani, Joonas, Rodrigo, David, Daniel]
> 
> On Wed, Nov 04, 2020 at 05:35:06PM +0530, Tejas Upadhyay wrote:
> > JSL re-uses the same stolen memory as ICL and EHL.
> > 
> > Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> > Cc: Matt Roper <matthew.d.roper@intel.com>
> > Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
> 
> I don't plan to do anything with this since previous similar patches
> have gone through some other tree, so this is just kibitzing.
> 
> But the fact that we have this long list of Intel devices [1] that
> constantly needs updates [2] is a hint that something is wrong.

We add an entry for every new integrated graphics platform. Once the
platform is added, there have not been changes lately.

> IIUC the general idea is that we need to discover Intel gfx memory by
> looking at device-dependent config space and add it to the E820 map.
> Apparently the quirks discover this via PCI config registers like
> I830_ESMRAMC, I845_ESMRAMC, etc, and tell the driver about it via the
> global "intel_graphics_stolen_res"?

We discover what is called the graphics data stolen memory. It is regular
system memory range that is not CPU accessible. It is accessible by the
integrated graphics only.

See: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/x86/kernel/early-quirks.c?h=v5.10-rc2&id=814c5f1f52a4beb3710317022acd6ad34fc0b6b9

> That's not the way this should work.  There should some generic, non
> device-dependent PCI or ACPI method to discover the memory used, or at
> least some way to do it in the driver instead of early arch code.

It's used by the early BIOS/UEFI code to set up initial framebuffer.
Even if i915 driver is never loaded, the memory ranges still need to
be fixed. They source of the problem is that the OEM BIOS which are
not under our control get the programming wrong.

We used to detect the memory region size again at i915 initialization
but wanted to eliminate the code duplication and resulting subtle bugs
that caused. Conclusion back then was that storing the struct resource
in memory is the best trade-off.

> How is this *supposed* to work?  Is there something we can do in E820
> or other resource management that would make this easier?

The code was added around Haswell (HSW) device generation to mitigate
bugs in BIOS. It is traditionally hard to get all OEMs to fix their
BIOS when things work for Windows. It's only later years when some
laptop models are intended to be sold with Linux.

The alternative would be to get all the OEM to fix their BIOS for Linux,
but that is not very realistic given past experiences. So it seems
a better choice to to add new line per platform generation to make
sure the users can boot to Linux.

Regards, Joonas

> > ---
> >  arch/x86/kernel/early-quirks.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> > index a4b5af03dcc1..534cc3f78c6b 100644
> > --- a/arch/x86/kernel/early-quirks.c
> > +++ b/arch/x86/kernel/early-quirks.c
> > @@ -549,6 +549,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
> >       INTEL_CNL_IDS(&gen9_early_ops),
> >       INTEL_ICL_11_IDS(&gen11_early_ops),
> >       INTEL_EHL_IDS(&gen11_early_ops),
> > +     INTEL_JSL_IDS(&gen11_early_ops),
> >       INTEL_TGL_12_IDS(&gen11_early_ops),
> >       INTEL_RKL_IDS(&gen11_early_ops),
> >  };
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/early-quirks.c?h=v5.10-rc2#n518
> 
> [2]
>   May 2020 efbee021ad02 ("x86/gpu: add RKL stolen memory support")
>   Jul 2019 6b2436aeb945 ("x86/gpu: add TGL stolen memory support")
>   Mar 2019 d53fef0be4a5 ("x86/gpu: add ElkhartLake to gen11 early quirks")
>   May 2018 db0c8d8b031d ("x86/gpu: reserve ICL's graphics stolen memory")
>   Dec 2017 33aa69ed8aac ("x86/gpu: add CFL to early quirks")
>   Jul 2017 2e1e9d48939e ("x86/gpu: CNL uses the same GMS values as SKL")
>   Jan 2017 bc384c77e3bb ("x86/gpu: GLK uses the same GMS values as SKL")
>   Oct 2015 00ce5c8a66fb ("drm/i915/kbl: Kabylake uses the same GMS values as Skylake")
>   Mar 2015 31d4dcf705c3 ("drm/i915/bxt: Broxton uses the same GMS values as Skylake")
>   ...
