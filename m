Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F01CA2A6BD3
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 18:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731629AbgKDRf7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 12:35:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:33304 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730535AbgKDRf6 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 4 Nov 2020 12:35:58 -0500
Received: from localhost (230.sub-72-107-127.myvzw.com [72.107.127.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C06A208C7;
        Wed,  4 Nov 2020 17:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604511357;
        bh=xBqVEiblZ/XFubgQpaF4UPLcF4GdV6RkUUCEkB9cU+Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=vevMdJI0PJyiPX7Yt4xjROXnhJrnfVhC8betd0HgLnksm8D7hNYo3JkX7M0TIhkKX
         BBkxSPOg8A9xjCihNzK8vyALokAMGgB6yuBwL+cB0vXZuAZPnRnX//98aIhWlizS6Y
         JVKjAKjF6GH7rpX6eXARNGmjL8jwn8ecLAKxZnA8=
Date:   Wed, 4 Nov 2020 11:35:56 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, bp@alien8.de, lucas.demarchi@intel.com,
        matthew.d.roper@intel.com, hariom.pandey@intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: Re: [PATCH] x86/gpu: add JSL stolen memory support
Message-ID: <20201104173556.GA359362@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201104120506.172447-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc Jani, Joonas, Rodrigo, David, Daniel]

On Wed, Nov 04, 2020 at 05:35:06PM +0530, Tejas Upadhyay wrote:
> JSL re-uses the same stolen memory as ICL and EHL.
> 
> Cc: Lucas De Marchi <lucas.demarchi@intel.com>
> Cc: Matt Roper <matthew.d.roper@intel.com>
> Signed-off-by: Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>

I don't plan to do anything with this since previous similar patches
have gone through some other tree, so this is just kibitzing.

But the fact that we have this long list of Intel devices [1] that
constantly needs updates [2] is a hint that something is wrong.

IIUC the general idea is that we need to discover Intel gfx memory by
looking at device-dependent config space and add it to the E820 map.
Apparently the quirks discover this via PCI config registers like
I830_ESMRAMC, I845_ESMRAMC, etc, and tell the driver about it via the
global "intel_graphics_stolen_res"?

That's not the way this should work.  There should some generic, non
device-dependent PCI or ACPI method to discover the memory used, or at
least some way to do it in the driver instead of early arch code.

How is this *supposed* to work?  Is there something we can do in E820
or other resource management that would make this easier?

> ---
>  arch/x86/kernel/early-quirks.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
> index a4b5af03dcc1..534cc3f78c6b 100644
> --- a/arch/x86/kernel/early-quirks.c
> +++ b/arch/x86/kernel/early-quirks.c
> @@ -549,6 +549,7 @@ static const struct pci_device_id intel_early_ids[] __initconst = {
>  	INTEL_CNL_IDS(&gen9_early_ops),
>  	INTEL_ICL_11_IDS(&gen11_early_ops),
>  	INTEL_EHL_IDS(&gen11_early_ops),
> +	INTEL_JSL_IDS(&gen11_early_ops),
>  	INTEL_TGL_12_IDS(&gen11_early_ops),
>  	INTEL_RKL_IDS(&gen11_early_ops),
>  };

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/x86/kernel/early-quirks.c?h=v5.10-rc2#n518

[2]
  May 2020 efbee021ad02 ("x86/gpu: add RKL stolen memory support")
  Jul 2019 6b2436aeb945 ("x86/gpu: add TGL stolen memory support")
  Mar 2019 d53fef0be4a5 ("x86/gpu: add ElkhartLake to gen11 early quirks")
  May 2018 db0c8d8b031d ("x86/gpu: reserve ICL's graphics stolen memory")
  Dec 2017 33aa69ed8aac ("x86/gpu: add CFL to early quirks")
  Jul 2017 2e1e9d48939e ("x86/gpu: CNL uses the same GMS values as SKL")
  Jan 2017 bc384c77e3bb ("x86/gpu: GLK uses the same GMS values as SKL")
  Oct 2015 00ce5c8a66fb ("drm/i915/kbl: Kabylake uses the same GMS values as Skylake")
  Mar 2015 31d4dcf705c3 ("drm/i915/bxt: Broxton uses the same GMS values as Skylake")
  ...
