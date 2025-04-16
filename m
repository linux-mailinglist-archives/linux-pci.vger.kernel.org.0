Return-Path: <linux-pci+bounces-26004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F39A90752
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 17:06:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E0C53AB57C
	for <lists+linux-pci@lfdr.de>; Wed, 16 Apr 2025 15:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6641DF265;
	Wed, 16 Apr 2025 15:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VZ1Cx9XN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C964235962;
	Wed, 16 Apr 2025 15:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744815961; cv=none; b=OcQcKGIU5ZXdFOmCSdePp+NWkhe8SfbTNntWRh8/zdTk91v1QVy1pK5CDmJ01Nk+MrHbgJCcFDYIcf+eTX8HwVgTOIUT6oBsHDC2E5AybiAXqhrMmkHMqH1lnXYk6LJktV0xMs5s/JCgGOkkE/JT+n14b5Ic8MGxw6uy4gMJChk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744815961; c=relaxed/simple;
	bh=4QLPWAeS+oLilr7f/kVhUYbo1QdPI3Nwr94aQGhdZkY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u2+oAaWEbQpHoY4xmXCX6ZsjK7eYXyrFEQhqBtDCfkODVsverwLfslgh5U34k5w2j64+JL+iL5sbaEAb9GRXiVuDgPFS/mOkrYBLnTE6gHas8sX3b4Mt0qQzrlqXwpDqFVS5/SFyizxjSrb3OruZF+OLIjFEiWZbyJjypf6D/SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VZ1Cx9XN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473B3C4AF0B;
	Wed, 16 Apr 2025 15:06:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744815960;
	bh=4QLPWAeS+oLilr7f/kVhUYbo1QdPI3Nwr94aQGhdZkY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=VZ1Cx9XNRlzlhehtzKI/Ai3lHkYW6Qtjn64fo6dXw5PoMWkZSA1Moa3Xm0jj0Uw+1
	 RAmiRBC84pDUi/YvXckwC0s8Roq/9IVbJVoVtp8U4QtiSnvrSOVa8f1iHcIlJSXCT4
	 cscGODuNYB2tO3ZlqQRNPfwSyzrBNpGw32Itu0/TPKVRY5DjZp1sj3PG9NljoD0qSq
	 RIhS7nfv/DKHl9fZ/CphB1EQXRmzBr5I05eqwobK+SDRXLBpK/5tH7kFffdjFCunr/
	 c6xrrWgocDES6zWXIUlqBmEPPK27xeQ2zbaJB59nfDp88xPhIvDzAKwW4KKR6E3/94
	 vfFFTbIV9FncA==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-2c2bb447e5eso3744513fac.0;
        Wed, 16 Apr 2025 08:06:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVQcHV4uHSBvs8W9GaEiK5SA+mfKglm/EHvhW+X1u5U+yvMWjLyA988/zzsbx3fQ24RNo4itbYIKUi1WbRh@vger.kernel.org, AJvYcCVm/Bw/rFxV6WQDnNFpxtHhS8Q0kePu7NuKIUpfe0SqZ41YryshU4GPuzWHWnaDgA15DdqX6xFtcO1F@vger.kernel.org, AJvYcCXbn/eCoPAFV+HWHDblDaMTq12IRMsEqdlIQkOI6dSdVQBWFKl57MBdh6dXRvcig8JiLlUQyKDfGzWN@vger.kernel.org
X-Gm-Message-State: AOJu0YzbT1+3Lh1qcK/3MGMXnZti+Q6ECDux1UV6HfNKuLgXwdT+uGsI
	IbDNO+T8Qh81aT5yKgiDvqxqruE8d3o61aMSp1f8u4vbhCuXKWmYUm54oJwEaC3T9xsRJQMD7DR
	14cgmPssHV2eZV/qJcM/12gl374Q=
X-Google-Smtp-Source: AGHT+IFXI7MTkQJxS69T0xax7TkqcxX9aupE9aLJy7FvUtuBtBBjJ6k9gco+git0688Nn1Hm9gAHQqOz0hh0fZDFLYw=
X-Received: by 2002:a05:6871:5582:b0:2d4:dc79:b9a with SMTP id
 586e51a60fabf-2d4dc794327mr1164388fac.6.1744815959465; Wed, 16 Apr 2025
 08:05:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com>
In-Reply-To: <20250416101318.7313-1-ilpo.jarvinen@linux.intel.com>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Wed, 16 Apr 2025 17:05:45 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0jg574mdE+P1Kji+xjFzbXC2HnY7O6_z5BqwL4w5kNsSg@mail.gmail.com>
X-Gm-Features: ATxdqUEuwFVK_1qwCboAMbwJd_Jwq-T0TYJG2YpFQsfzzawr-BLQOlq5wIYe5yM
Message-ID: <CAJZ5v0jg574mdE+P1Kji+xjFzbXC2HnY7O6_z5BqwL4w5kNsSg@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86: Use resource_set_{range,size}() helpers
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Bjorn Helgaas <bhelgaas@google.com>, Andy Shevchenko <andy@kernel.org>, 
	linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 16, 2025 at 12:13=E2=80=AFPM Ilpo J=C3=A4rvinen
<ilpo.jarvinen@linux.intel.com> wrote:
>
> Convert open coded resource size calculations to use
> resource_set_{range,size}() helpers.
>
> While at it, use SZ_* for size parameter which makes the intent of code
> more obvious.
>
> Signed-off-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>

For the change in acpi/boot.c

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
>  arch/x86/kernel/acpi/boot.c    | 4 ++--
>  arch/x86/kernel/amd_nb.c       | 3 +--
>  arch/x86/kernel/apic/apic.c    | 3 +--
>  arch/x86/kernel/apic/io_apic.c | 3 +--
>  arch/x86/kernel/probe_roms.c   | 3 +--
>  arch/x86/pci/fixup.c           | 4 ++--
>  arch/x86/pci/intel_mid_pci.c   | 2 +-
>  7 files changed, 9 insertions(+), 13 deletions(-)
>
> diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
> index dae6a73be40e..4490cbc01030 100644
> --- a/arch/x86/kernel/acpi/boot.c
> +++ b/arch/x86/kernel/acpi/boot.c
> @@ -21,6 +21,7 @@
>  #include <linux/pci.h>
>  #include <linux/efi-bgrt.h>
>  #include <linux/serial_core.h>
> +#include <linux/sizes.h>
>  #include <linux/pgtable.h>
>
>  #include <asm/e820/api.h>
> @@ -940,8 +941,7 @@ static int __init acpi_parse_hpet(struct acpi_table_h=
eader *table)
>         snprintf((char *)hpet_res->name, HPET_RESOURCE_NAME_SIZE, "HPET %=
u",
>                  hpet_tbl->sequence);
>
> -       hpet_res->start =3D hpet_address;
> -       hpet_res->end =3D hpet_address + (1 * 1024) - 1;
> +       resource_set_range(hpet_res, hpet_address, SZ_1K);
>
>         return 0;
>  }
> diff --git a/arch/x86/kernel/amd_nb.c b/arch/x86/kernel/amd_nb.c
> index 6d12a9b69432..cba336dcb40d 100644
> --- a/arch/x86/kernel/amd_nb.c
> +++ b/arch/x86/kernel/amd_nb.c
> @@ -164,8 +164,7 @@ struct resource *amd_get_mmconfig_range(struct resour=
ce *res)
>                          FAM10H_MMIO_CONF_BUSRANGE_MASK;
>
>         res->flags =3D IORESOURCE_MEM;
> -       res->start =3D base;
> -       res->end =3D base + (1ULL<<(segn_busn_bits + 20)) - 1;
> +       resource_set_range(res, base, 1ULL << (segn_busn_bits + 20));
>         return res;
>  }
>
> diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
> index 62584a347931..efd3304ecbb3 100644
> --- a/arch/x86/kernel/apic/apic.c
> +++ b/arch/x86/kernel/apic/apic.c
> @@ -2640,8 +2640,7 @@ static int __init lapic_insert_resource(void)
>                 return -1;
>
>         /* Put local APIC into the resource map. */
> -       lapic_resource.start =3D apic_mmio_base;
> -       lapic_resource.end =3D lapic_resource.start + PAGE_SIZE - 1;
> +       resource_set_range(&lapic_resource, apic_mmio_base, PAGE_SIZE);
>         insert_resource(&iomem_resource, &lapic_resource);
>
>         return 0;
> diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_api=
c.c
> index eebc360ed1bb..3069885d6421 100644
> --- a/arch/x86/kernel/apic/io_apic.c
> +++ b/arch/x86/kernel/apic/io_apic.c
> @@ -2571,8 +2571,7 @@ void __init io_apic_init_mappings(void)
>                                 __fix_to_virt(idx) + (ioapic_phys & ~PAGE=
_MASK), ioapic_phys);
>                 idx++;
>
> -               ioapic_res->start =3D ioapic_phys;
> -               ioapic_res->end =3D ioapic_phys + IO_APIC_SLOT_SIZE - 1;
> +               resource_set_range(ioapic_res, ioapic_phys, IO_APIC_SLOT_=
SIZE);
>                 ioapic_res++;
>         }
>  }
> diff --git a/arch/x86/kernel/probe_roms.c b/arch/x86/kernel/probe_roms.c
> index cc2c34ba7228..44da85e50c44 100644
> --- a/arch/x86/kernel/probe_roms.c
> +++ b/arch/x86/kernel/probe_roms.c
> @@ -260,8 +260,7 @@ void __init probe_roms(void)
>                 if (!length || start + length > upper || !romchecksum(rom=
, length))
>                         continue;
>
> -               adapter_rom_resources[i].start =3D start;
> -               adapter_rom_resources[i].end =3D start + length - 1;
> +               resource_set_range(&adapter_rom_resources[i], start, leng=
th);
>                 request_resource(&iomem_resource, &adapter_rom_resources[=
i]);
>
>                 start =3D adapter_rom_resources[i++].end & ~2047UL;
> diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
> index efefeb82ab61..94e98e3bf041 100644
> --- a/arch/x86/pci/fixup.c
> +++ b/arch/x86/pci/fixup.c
> @@ -7,6 +7,7 @@
>  #include <linux/delay.h>
>  #include <linux/dmi.h>
>  #include <linux/pci.h>
> +#include <linux/sizes.h>
>  #include <linux/suspend.h>
>  #include <linux/vgaarb.h>
>  #include <asm/amd_node.h>
> @@ -347,8 +348,7 @@ static void pci_fixup_video(struct pci_dev *pdev)
>                         if (res->parent)
>                                 release_resource(res);
>
> -                       res->start =3D 0xC0000;
> -                       res->end =3D res->start + 0x20000 - 1;
> +                       resource_set_range(res, 0xC0000, SZ_128K);
>                         res->flags =3D IORESOURCE_MEM | IORESOURCE_ROM_SH=
ADOW |
>                                      IORESOURCE_PCI_FIXED;
>                         dev_info(&pdev->dev, "Video device with shadowed =
ROM at %pR\n",
> diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
> index b433b1753016..5e047e802d5d 100644
> --- a/arch/x86/pci/intel_mid_pci.c
> +++ b/arch/x86/pci/intel_mid_pci.c
> @@ -399,7 +399,7 @@ static void pci_fixed_bar_fixup(struct pci_dev *dev)
>
>         for (i =3D 0; i < PCI_STD_NUM_BARS; i++) {
>                 pci_read_config_dword(dev, offset + 8 + (i * 4), &size);
> -               dev->resource[i].end =3D dev->resource[i].start + size - =
1;
> +               resource_set_size(&dev->resource[i], size);
>                 dev->resource[i].flags |=3D IORESOURCE_PCI_FIXED;
>         }
>  }
> --
> 2.39.5
>

