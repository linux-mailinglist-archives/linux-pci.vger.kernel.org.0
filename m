Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BDAF72F356C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 17:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406337AbhALQR1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 11:17:27 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:10269 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406365AbhALQR0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 11:17:26 -0500
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5ffdcb6d0000>; Tue, 12 Jan 2021 08:16:45 -0800
Received: from [10.25.99.9] (172.20.145.6) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 12 Jan
 2021 16:16:37 +0000
Subject: Re: [PATCH] arm64: PCI: Enable SMC conduit
To:     Jeremy Linton <jeremy.linton@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-pci@vger.kernel.org>
CC:     <lorenzo.pieralisi@arm.com>, <bhelgaas@google.com>,
        <catalin.marinas@arm.com>, <will@kernel.org>, <robh@kernel.org>,
        <sudeep.holla@arm.com>, <mark.rutland@arm.com>,
        <linux-kernel@vger.kernel.org>
References: <20210105045735.1709825-1-jeremy.linton@arm.com>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <9ecfbc2e-5f33-dd3c-0c3b-ee7c463b3e68@nvidia.com>
Date:   Tue, 12 Jan 2021 21:46:31 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20210105045735.1709825-1-jeremy.linton@arm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.20.145.6]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1610468205; bh=kRFoaCh47KYUHJrVFRcq6QgKg/k6UvmAR92PmWC7Yhs=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=XzmxaAUVGCKN4uY99VaL3gOobMK/DbZq25E4IWym3ULRdXHQ7HZagZi5Rt7ndMwpd
         TyLgVxRHG/o4WxbWpPlFwqH1nlVD9E3Bcc+1wGNZelrmpl6vs5asdM/+JwPbMjWZ69
         4FGpq2iImljn5J9cmPoYJQZ6jVJ5nC4hnaynniMQ072FWJO/hY6GmQuI3FwY5Oh8qA
         Z9v1OIyQ3MkjTEsA1Znm+HeHFYhtfbcM0zBXIk2/rB/yO87UYM8nuyEN3YeDEP+JkX
         rJIR0b5yg1+l52UfLD4cjNY7QMVNCxtmXgZWv9vtAJfpeVDrXm7BHe6vCtNfxkBcEA
         zncnbMIRjyvBQ==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/5/2021 10:27 AM, Jeremy Linton wrote:
> External email: Use caution opening links or attachments
> 
> 
> Given that most arm64 platform's PCI implementations needs quirks
> to deal with problematic config accesses, this is a good place to
> apply a firmware abstraction. The ARM PCI SMMCCC spec details a
> standard SMC conduit designed to provide a simple PCI config
> accessor. This specification enhances the existing ACPI/PCI
> abstraction and expects power, config, etc functionality is handled
> by the platform. It also is very explicit that the resulting config
> space registers must behave as is specified by the pci specification.
> 
> Lets hook the normal ACPI/PCI config path, and when we detect
> missing MADT data, attempt to probe the SMC conduit. If the conduit
> exists and responds for the requested segment number (provided by the
> ACPI namespace) attach a custom pci_ecam_ops which redirects
> all config read/write requests to the firmware.
> 
> This patch is based on the Arm PCI Config space access document @
> https://developer.arm.com/documentation/den0115/latest
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>   arch/arm64/kernel/pci.c   | 87 +++++++++++++++++++++++++++++++++++++++
>   include/linux/arm-smccc.h | 26 ++++++++++++
>   2 files changed, 113 insertions(+)
> 
> diff --git a/arch/arm64/kernel/pci.c b/arch/arm64/kernel/pci.c
> index 1006ed2d7c60..56d3773aaa25 100644
> --- a/arch/arm64/kernel/pci.c
> +++ b/arch/arm64/kernel/pci.c
> @@ -7,6 +7,7 @@
>    */
> 
>   #include <linux/acpi.h>
> +#include <linux/arm-smccc.h>
>   #include <linux/init.h>
>   #include <linux/io.h>
>   #include <linux/kernel.h>
> @@ -107,6 +108,90 @@ static int pci_acpi_root_prepare_resources(struct acpi_pci_root_info *ci)
>          return status;
>   }
> 
> +static int smccc_pcie_check_conduit(u16 seg)
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
> +
> +       pr_info("PCI: SMC conduit attached to segment %d\n", seg);
Shouldn't this print be moved towards the end of 
pci_acpi_setup_smccc_mapping() API?

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
Since there is no init implemented, what is the purpose of having this?

> +               cfg->ops->init(cfg);
> +       return cfg;
> +}
> +
>   /*
>    * Lookup the bus range for the domain in MCFG, and set up config space
>    * mapping.
> @@ -125,6 +210,8 @@ pci_acpi_setup_ecam_mapping(struct acpi_pci_root *root)
> 
>          ret = pci_mcfg_lookup(root, &cfgres, &ecam_ops);
>          if (ret) {
> +               if (!smccc_pcie_check_conduit(seg))
> +                       return pci_acpi_setup_smccc_mapping(root);
>                  dev_err(dev, "%04x:%pR ECAM region not found\n", seg, bus_res);
>                  return NULL;
>          }
> diff --git a/include/linux/arm-smccc.h b/include/linux/arm-smccc.h
> index f860645f6512..327f52533c71 100644
> --- a/include/linux/arm-smccc.h
> +++ b/include/linux/arm-smccc.h
> @@ -89,6 +89,32 @@
> 
>   #define SMCCC_ARCH_WORKAROUND_RET_UNAFFECTED   1
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
>   /* Paravirtualised time calls (defined by ARM DEN0057A) */
>   #define ARM_SMCCC_HV_PV_TIME_FEATURES                          \
>          ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,                 \
> --
> 2.26.2
> 
