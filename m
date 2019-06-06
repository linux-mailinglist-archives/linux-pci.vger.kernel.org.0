Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 200E836F9B
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2019 11:13:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbfFFJN6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jun 2019 05:13:58 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:54132 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727551AbfFFJN5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 6 Jun 2019 05:13:57 -0400
Received: by mail-it1-f196.google.com with SMTP id m187so2047908ite.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Jun 2019 02:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VT2noAdE4Dd/0JtGeEPEhO0YPMQ5D4GEDk/xscedmiE=;
        b=UTtGTUpTXZ8eBIEf4gKK1bZ/8fCZDBNDsaH4d8pGmtyQ0TXf8bIl3VsPEnxVHxSvUK
         AKc5YLcEa4Y6EMV1PvwKdiRl2yzG08IISbw2GdKhgq0fi8FgF3P4dedg7XqPDhO6hUQ/
         51aAmvj7ueKdWEhYV2CdUxhZNmeD/ttk/vrs6dX1Nrczy3JhG+3c7uawwnvexSB/3P1t
         L4QdNa3VWDJLO+z9UrUsSlfAxzmuK5TiRN3Cq+bhkb92/1pk+IjXaq/SQlcRC2pM0QmF
         bLJYoGi3YoaY5pK6YdKzzHQ5ILnbRR9hkswXtRIOJ27YGzQfxL0jz7BnVmqiMNoeh1re
         NFCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VT2noAdE4Dd/0JtGeEPEhO0YPMQ5D4GEDk/xscedmiE=;
        b=Ju71VU3r0TQyohsS05cefjdM4NaCVaBlUNptu16G3ETBfjunL6Vi6EHP5lzdIqmRtl
         FDaodW23hOQom72Fq78fmmw2IhNeyrSzO7P+PHtOpvzPwy+IouYSBHsQECNc9R3/cATw
         3if3egw+qCTLGmOECTmeIiqrlZoTOM7HTvyUVFmpOcFYayTanFDXc8Cta+nqM5Nf/Uqg
         FtwRhsLieBCAXxzFGrDeZoc2beWdUamJSqAhcxgXVTbj/BJSdP2Hssv1mmZniF3snZoz
         TUGM6mLNyqK8SwiUWc6ZjoTo0hkLxn/J9tz15epGo+Z5z4DHpJ7x9trvLnnOosBReiLj
         ptdQ==
X-Gm-Message-State: APjAAAVEwYyGwttDmQbMYwvGLz21WMSycooWaWje9g8VBBXprV4V99VO
        NH9omhwH8NmZr9z5rgvfVwrFk0Sq+EUtyjZ24qpfIg==
X-Google-Smtp-Source: APXvYqyCpGPCw2blWOGm1uM3ralbUHEpsLi1UzYSgf/YLXM/XkyAhmAYcyHLXPWgk1dLytRVGKnbEkPDrJ+a7+1S/aI=
X-Received: by 2002:a05:660c:44a:: with SMTP id d10mr9230969itl.153.1559812436942;
 Thu, 06 Jun 2019 02:13:56 -0700 (PDT)
MIME-Version: 1.0
References: <56715377f941f1953be43b488c2203ec090079a1.camel@kernel.crashing.org>
 <20190604014945.GE189360@google.com> <960c94eb151ba1d066090774621cf6ca6566d135.camel@kernel.crashing.org>
 <20190604124959.GF189360@google.com> <e520a4269224ac54798314798a80c080832e68b1.camel@kernel.crashing.org>
 <d53fc77e1e754ddbd9af555ed5b344c5fa523154.camel@kernel.crashing.org>
In-Reply-To: <d53fc77e1e754ddbd9af555ed5b344c5fa523154.camel@kernel.crashing.org>
From:   Ard Biesheuvel <ard.biesheuvel@linaro.org>
Date:   Thu, 6 Jun 2019 11:13:44 +0200
Message-ID: <CAKv+Gu_3Nb5mPZgRfx+wQSz+eWM+FSbw_14fHm+u=v2EbuYoGQ@mail.gmail.com>
Subject: Re: [PATCH/RESEND] arm64: acpi/pci: invoke _DSM whether to preserve
 firmware PCI setup
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, Sinan Kaya <okaya@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-pci <linux-pci@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        "Zilberman, Zeev" <zeev@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 6 Jun 2019 at 11:00, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
>
> On arm64 ACPI systems, we unconditionally reconfigure the entire PCI
> hierarchy at boot. This is a departure from what is customary on ACPI
> systems, and may break assumptions in some places (e.g., EFIFB), that
> the kernel will leave BARs of enabled PCI devices where they are.
>
> Given that PCI already specifies a device specific ACPI method (_DSM)
> for PCI root bridge nodes that tells us whether the firmware thinks
> the configuration should be left alone, let's sidestep the entire
> policy debate about whether the PCI configuration should be preserved
> or not, and put it under the control of the firmware instead.
>
> [BenH: Added pci_assign_unassigned_root_bus_resources()]
>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>
> So I would like this variant rather than mucking around with
> IORESOURCE_PCI_FIXED at this stage to fix the problem with our platforms.
>
> See my other email, IORESOURCE_PCI_FIXED doesn't really work terribly well
> when using pci_bus_size_bridges and pci_bus_assign_resources, and the
> resulting patches are ugly and add more mess.
>
> Long run, I propose to start working on consolidating all those various
> resource survey mechanisms around what x86 does, unless people strongly
> object... (with the addition of the probe only and force reassign quirks
> so platforms can still chose that).
>
> Note: I haven't tested the effect of pci_assign_unassigned_root_bus_resources
> as our platforms don't leave anything unassigned. I'm not entirely sure how
> well pci_bus_claim_resources() will deal with a partially assigned setup...
>
> We do want to support partial assignment by BIOS though, it's a trend to
> reduce boot time, people seem to want BIOSes to only assign what's critical
> for booting.
>
> Bjorn: I haven't made the claim path the default in absence of _DSM #5 yet.
> I suggest we do that as a separate patch in case it breaks somebody, thus
> making bisection more meaningful. It will also make this one more palatable
> to distros since it won't change the behaviour on systems without _DSM #5,
> and we verified nobody has it except Seattle which returns 1.
>

FYI Seattle is broken in any case since it returns Package(1) rather
than just an int.

The problem with this patch is that currently, the PCI fw spec permits
_DSM #5 everywhere *except* on the host bridge device object itself,
and this is in the process of being changed.

I will leave it up to the maintainers to decide whether we can take
this patch in anticipation of that, even though it doesn't deal with
_DSM #5 on nodes anywhere else in the PCIe tree.

>  arch/arm64/kernel/pci.c  | 23 +++++++++++++++++++++--
>  include/linux/pci-acpi.h |  7 ++++---
>  2 files changed, 25 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index bb85e2f4603f..6358e1cb4f9f 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -168,6 +168,7 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>         struct acpi_pci_generic_root_info *ri;
>         struct pci_bus *bus, *child;
>         struct acpi_pci_root_ops *root_ops;
> +       union acpi_object *obj;
>
>         ri = kzalloc(sizeof(*ri), GFP_KERNEL);
>         if (!ri)
> @@ -193,8 +194,26 @@ struct pci_bus *pci_acpi_scan_root(struct acpi_pci_root *root)
>         if (!bus)
>                 return NULL;
>
> -       pci_bus_size_bridges(bus);
> -       pci_bus_assign_resources(bus);
> +       /*
> +        * Invoke the PCI device specific method (_DSM) #5 'Ignore PCI Boot
> +        * Configuration', which tells us whether the firmware wants us to
> +        * preserve the configuration of the PCI resource tree for this root
> +        * bridge.
> +        */
> +       obj = acpi_evaluate_dsm(ACPI_HANDLE(bus->bridge), &pci_acpi_dsm_guid, 1,
> +                               IGNORE_PCI_BOOT_CONFIG_DSM, NULL);
> +       if (obj && obj->type == ACPI_TYPE_INTEGER && obj->integer.value == 0) {
> +               /* preserve existing resource assignment */
> +               pci_bus_claim_resources(bus);
> +
> +               /* Assign anything that might have been left out */
> +               pci_assign_unassigned_root_bus_resources(bus);
> +       } else {
> +               /* reconfigure the resource tree from scratch */
> +               pci_bus_size_bridges(bus);
> +               pci_bus_assign_resources(bus);
> +       }
> +       ACPI_FREE(obj);
>
>         list_for_each_entry(child, &bus->children, node)
>                 pcie_bus_configure_settings(child);
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 8082b612f561..62b7fdcc661c 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -107,9 +107,10 @@ static inline void acpiphp_check_host_bridge(struct acpi_device *adev) { }
>  #endif
>
>  extern const guid_t pci_acpi_dsm_guid;
> -#define DEVICE_LABEL_DSM       0x07
> -#define RESET_DELAY_DSM                0x08
> -#define FUNCTION_DELAY_DSM     0x09
> +#define IGNORE_PCI_BOOT_CONFIG_DSM     0x05
> +#define DEVICE_LABEL_DSM               0x07
> +#define RESET_DELAY_DSM                        0x08
> +#define FUNCTION_DELAY_DSM             0x09
>
>  #else  /* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>
>
