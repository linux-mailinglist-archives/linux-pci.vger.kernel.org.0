Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1CA63FA07C
	for <lists+linux-pci@lfdr.de>; Fri, 27 Aug 2021 22:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbhH0UUX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 27 Aug 2021 16:20:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:35228 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229591AbhH0UUW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 27 Aug 2021 16:20:22 -0400
Received: from zn.tnic (p200300ec2f1117002bace1eb09205059.dip0.t-ipconnect.de [IPv6:2003:ec:2f11:1700:2bac:e1eb:920:5059])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 6167E1EC0537;
        Fri, 27 Aug 2021 22:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1630095567;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=8aXcMzbdacH3FMLx51gs5poye2a2e6/NSjRioCCSOi0=;
        b=eDIOLsQD2VAyU8EDgvKUEgt2BAJIn7cUUHNpFYHiyQIRFvLpi9sMvHZoP+TvXh9mzZWz/a
        PQUTAh1Bo0YOD2+lorWeiGMw9XnLs6PW/dNfy3EbGhU9NEtN5LiwDADAihyFTwcf4vHmfs
        hcbK1xo9UbGs9czeoUCMUni1jJygtsw=
Date:   Fri, 27 Aug 2021 22:20:09 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Clemens Ladisch <clemens@ladisch.de>, linux-hwmon@vger.kernel.org,
        Gabriel Craciunescu <nix.or.die@googlemail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Wei Huang <wei.huang2@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Jean Delvare <jdelvare@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Yazen Ghannam <yazen.ghannam@amd.com>,
        David Bartley <andareed@gmail.com>,
        "open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" 
        <linux-kernel@vger.kernel.org>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] hwmon: (k10temp): Add support for yellow carp
Message-ID: <YSlI+Us347E6LQx2@zn.tnic>
References: <20210827201527.24454-1-mario.limonciello@amd.com>
 <20210827201527.24454-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210827201527.24454-3-mario.limonciello@amd.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Aug 27, 2021 at 03:15:26PM -0500, Mario Limonciello wrote:
> Yellow carp matches same behavior as green sardine and other Zen3
> products, but have different CCD offsets.
> 
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
> ---
>  arch/x86/kernel/amd_nb.c | 5 +++++
>  drivers/hwmon/k10temp.c  | 5 +++++
>  include/linux/pci_ids.h  | 1 +
>  3 files changed, 11 insertions(+)
> 
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 23dda362dc0f..c92c9c774c0e 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -25,6 +25,8 @@
>  #define PCI_DEVICE_ID_AMD_17H_M60H_DF_F4 0x144c
>  #define PCI_DEVICE_ID_AMD_17H_M70H_DF_F4 0x1444
>  #define PCI_DEVICE_ID_AMD_19H_DF_F4	0x1654
> +#define PCI_DEVICE_ID_AMD_19H_M40H_ROOT	0x14b5
> +#define PCI_DEVICE_ID_AMD_19H_M40H_DF_F4 0x167d
>  #define PCI_DEVICE_ID_AMD_19H_M50H_DF_F4 0x166e
>  
>  /* Protect the PCI config register pairs used for SMN and DF indirect access. */
> @@ -37,6 +39,7 @@ static const struct pci_device_id amd_root_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M10H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M30H_ROOT) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_ROOT) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_ROOT) },
>  	{}
>  };
>  
> @@ -58,6 +61,7 @@ static const struct pci_device_id amd_nb_misc_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F3) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F3) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F3) },
>  	{}
>  };
> @@ -74,6 +78,7 @@ static const struct pci_device_id amd_nb_link_ids[] = {
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M60H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_17H_M70H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_DF_F4) },
> +	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M40H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_19H_M50H_DF_F4) },
>  	{ PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_CNB17H_F4) },
>  	{}

The x86 bits:

Acked-by: Borislav Petkov <bp@suse.de>

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
