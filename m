Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08C02ED389
	for <lists+linux-pci@lfdr.de>; Thu,  7 Jan 2021 16:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbhAGP3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Jan 2021 10:29:39 -0500
Received: from mail.kernel.org ([198.145.29.99]:33104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726503AbhAGP3i (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Jan 2021 10:29:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A01AB23426;
        Thu,  7 Jan 2021 15:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610033337;
        bh=FlnTD0YBDmMGVagGzH/S6ZOJ2bQI2qorsMBi3mqHwTw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tkdzd7t3sIprdNf2Mc/YH0Rqy6F9m5vOCm7ebE3QpDhkdm2wY/FsqIrDoRCh6dezT
         xG80zGrl8Nm+STFyVx+P/Xx77PfKlbLpQ3J3hcHnh7zxRsf9QZ9zBK8M+JSu5+BaM2
         dG8tX1sDQEFUwSGY3AhUJ/sz+OvUHoX8u2inZSvBo6KUyYyI0qDlWRCzCKEQJjSNA/
         rPbtu5tG62HO7Gg3cbocpj3PNWsnl0RdMV1ElDlIHHKkizixk2TH5Z9a4HUJzcdxr9
         vRLwpqTgWo7w9kvJZwQcD4O0oso/6ig9IA7OsUTNOeDhO7CqBHkgAZwTOKoEHO7pZ8
         wjQuIxOcMLzSg==
Received: by mail-ej1-f43.google.com with SMTP id ce23so10198218ejb.8;
        Thu, 07 Jan 2021 07:28:57 -0800 (PST)
X-Gm-Message-State: AOAM531DuxAIvx9IVs/naHeX6CF54k205Aecx8TF2MGuKFY/34F3F3SD
        IQuMePz1tck8AElV87hMMm4jSVZzCeKjIgoGXA==
X-Google-Smtp-Source: ABdhPJw33hPLvaeK9d3WoQDRtg3jF/7OXep4UsA0SgFuLiywt3w2fj0hzuMtbFMjH5zEj9lUQFI6dUJ8Yd6JECMAB+c=
X-Received: by 2002:a17:906:1197:: with SMTP id n23mr6787245eja.359.1610033336210;
 Thu, 07 Jan 2021 07:28:56 -0800 (PST)
MIME-Version: 1.0
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
In-Reply-To: <20210105045735.1709825-1-jeremy.linton@arm.com>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 7 Jan 2021 08:28:43 -0700
X-Gmail-Original-Message-ID: <CAL_JsqL2ZXrTg9VFwGK4CawvyBbnHehF9W=cgVEJPzCRoM5G9g@mail.gmail.com>
Message-ID: <CAL_JsqL2ZXrTg9VFwGK4CawvyBbnHehF9W=cgVEJPzCRoM5G9g@mail.gmail.com>
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        PCI <linux-pci@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jan 4, 2021 at 9:57 PM Jeremy Linton <jeremy.linton@arm.com> wrote:
>
> Given that most arm64 platform's PCI implementations needs quirks
> to deal with problematic config accesses, this is a good place to
> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
> standard SMC conduit designed to provide a simple PCI config
> accessor. This specification enhances the existing ACPI/PCI
> abstraction and expects power, config, etc functionality is handled
> by the platform. It also is very explicit that the resulting config
> space registers must behave as is specified by the pci specification.

If we put it in a document, they must behave.

> Lets hook the normal ACPI/PCI config path, and when we detect
> missing MADT data, attempt to probe the SMC conduit. If the conduit
> exists and responds for the requested segment number (provided by the
> ACPI namespace) attach a custom pci_ecam_ops which redirects
> all config read/write requests to the firmware.
>
> This patch is based on the Arm PCI Config space access document @
> https://developer.arm.com/documentation/den0115/latest

From the spec:
"On some platforms, the SoC may only support 32-bit PCI configuration
space writes. On such platforms, calls to this function with access
size of 1 or 2 bytes may require the implementation of this function
to perform a PCI configuration read, following by the write. This
could result in inadvertently corrupting adjacent RW1C fields. It is
the implementation responsibility to be aware of these situations and
guard against them if possible."

First, this contradicts the above statement about being compliant with
the PCI spec. Second, Linux is left to just guess whether this is the
case or not? I guess it would be pointless for firmware to advertise
this because it could just lie.

I would like to know how to 'guard against them' so I can implement
that in the kernel accessors.

> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/kernel/pci.c   | 87 +++++++++++++++++++++++++++++++++++++++
>  include/linux/arm-smccc.h | 26 ++++++++++++
>  2 files changed, 113 insertions(+)
>
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2d7c60..56d3773aaa25 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/acpi.h>
> +#include <linux/arm-smccc.h>
>  #include <linux/init.h>
>  #include <linux/io.h>
>  #include <linux/kernel.h>
> @@ -107,6 +108,90 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>         return status;
>  }
>
> +static int smccc_pcie_check_conduit(u16 seg)

check what? Based on how you use this, perhaps _has_conduit() instead.

> +{
> +       struct arm_smccc_res res;
> +
> +       if (arm_smccc_1_1_get_conduit() == SMCCC_CONDUIT_NONE)
> +               return -EOPNOTSUPP;
> +
> +       arm_smccc_smc(SMCCC_PCI_VERSION, 0, 0, 0, 0, 0, 0, 0, &res);
> +       if ((int)res.a0 < 0)
> +               return -EOPNOTSUPP;
> +
> +       arm_smccc_smc(SMCCC_PCI_SEG_INFO, seg, 0, 0, 0, 0, 0, 0, &res);
> +       if ((int)res.a0 < 0)
> +               return -EOPNOTSUPP;

Don't you need to check that read and write functions are supported?

> +
> +       pr_info("PCI: SMC conduit attached to segment %d\n", seg);
> +
> +       return 0;
> +}
> +
> +static int smccc_pcie_config_read(struct pci_bus *bus, unsigned int devfn,
> +                                 int where, int size, u32 *val)
> +{
> +       struct arm_smccc_res res;
> +
> +       devfn |= bus->number << 8;
> +       devfn |= bus->domain_nr << 16;
> +
> +       arm_smccc_smc(SMCCC_PCI_READ, devfn, where, size, 0, 0, 0, 0, &res);
> +       if (res.a0) {
> +               *val = ~0;
> +               return -PCIBIOS_BAD_REGISTER_NUMBER;
> +       }
> +
> +       *val = res.a1;
> +       return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static int smccc_pcie_config_write(struct pci_bus *bus, unsigned int devfn,
> +                                  int where, int size, u32 val)
> +{
> +       struct arm_smccc_res res;
> +
> +       devfn |= bus->number << 8;
> +       devfn |= bus->domain_nr << 16;
> +
> +       arm_smccc_smc(SMCCC_PCI_WRITE, devfn, where, size, val, 0, 0, 0, &res);
> +       if (res.a0)
> +               return -PCIBIOS_BAD_REGISTER_NUMBER;
> +
> +       return PCIBIOS_SUCCESSFUL;
> +}
> +
> +static const struct pci_ecam_ops smccc_pcie_ecam_ops = {
> +       .bus_shift      = 8,

Drop. You don't use this and it's not ECAM. Though I'm wondering why
the smc interface is not just ECAM shifts instead of making up our
own. I would have made segment its own register rather than reg
offset.

> +       .pci_ops        = {
> +               .read           = smccc_pcie_config_read,
> +               .write          = smccc_pcie_config_write,
> +       }
> +};
> +
> +static struct pci_config_window *
> +pci_acpi_setup_smccc_mapping(struct acpi_pci_root *root)
> +{
> +       struct device *dev = &root->device->dev;
> +       struct resource *bus_res = &root->secondary;
> +       struct pci_config_window *cfg;
> +
> +       cfg = kzalloc(sizeof(*cfg), GFP_KERNEL);
> +       if (!cfg)
> +               return ERR_PTR(-ENOMEM);
> +
> +       cfg->parent = dev;
> +       cfg->ops = &smccc_pcie_ecam_ops;
> +       cfg->busr.start = bus_res->start;
> +       cfg->busr.end = bus_res->end;
> +       cfg->busr.flags = IORESOURCE_BUS;
> +
> +       cfg->res.name = "PCI SMCCC";
> +       if (cfg->ops->init)
> +               cfg->ops->init(cfg);
> +       return cfg;
> +}
> +
>  /*
>   * Lookup the bus range for the domain in MCFG, and set up config space
>   * mapping.
> @@ -125,6 +210,8 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
>
>         ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
>         if (ret) {
> +               if (!smccc_pcie_check_conduit(seg))
> +                       return pci_acpi_setup_smccc_mapping(root);
>                 dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
>                 return NULL;
>         }
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index f860645f6512..327f52533c71 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -89,6 +89,32 @@
>
>  #define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED   1
>
> +/* PCI ECAM conduit */
> +#define SMCCC_PCI_VERSION                                              \
> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                         \
> +                          ARM_SMCCC_SMC_32,                            \
> +                          ARM_SMCCC_OWNER_STANDARD, 0x0130)
> +
> +#define SMCCC_PCI_FEATURES                                             \
> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                         \
> +                          ARM_SMCCC_SMC_32,                            \
> +                          ARM_SMCCC_OWNER_STANDARD, 0x0131)
> +
> +#define SMCCC_PCI_READ                                                 \
> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                         \
> +                          ARM_SMCCC_SMC_32,                            \
> +                          ARM_SMCCC_OWNER_STANDARD, 0x0132)
> +
> +#define SMCCC_PCI_WRITE                                                        \
> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                         \
> +                          ARM_SMCCC_SMC_32,                            \
> +                          ARM_SMCCC_OWNER_STANDARD, 0x0133)
> +
> +#define SMCCC_PCI_SEG_INFO                                             \
> +       ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                         \
> +                          ARM_SMCCC_SMC_32,                            \
> +                          ARM_SMCCC_OWNER_STANDARD, 0x0134)
> +
>  /* Paravirtualised time calls (defined by ARM DEN0057A) */
>  #define ARM_SMCCC_HV_PV_TIME_FEATURES                          \
>         ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                 \
> --
> 2.26.2
>
