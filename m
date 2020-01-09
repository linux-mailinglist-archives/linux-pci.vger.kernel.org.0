Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F15E4135F69
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 18:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388208AbgAIReJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 12:34:09 -0500
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:16366 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbgAIReI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Jan 2020 12:34:08 -0500
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e1763fd0000>; Thu, 09 Jan 2020 09:33:49 -0800
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Thu, 09 Jan 2020 09:34:07 -0800
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Thu, 09 Jan 2020 09:34:07 -0800
Received: from [10.25.75.92] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Thu, 9 Jan
 2020 17:34:04 +0000
Subject: Re: [PATCH] PCI: dwc: Separate CFG0 and CFG1 into different ATU
 regions
To:     Shawn Guo <shawn.guo@linaro.org>, <linux-pci@vger.kernel.org>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Zaihai Yu <yuzaihai@hisilicon.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20200109060657.1953-1-shawn.guo@linaro.org>
X-Nvconfidentiality: public
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <beda8923-a3b7-47eb-7cf1-19a3bacf1e34@nvidia.com>
Date:   Thu, 9 Jan 2020 23:04:01 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200109060657.1953-1-shawn.guo@linaro.org>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL105.nvidia.com (172.20.187.12) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1578591229; bh=uriZZMyALR26nxxqF8+cD6jor2aUVa9IyXhlZgJ98NE=;
        h=X-PGP-Universal:Subject:To:CC:References:X-Nvconfidentiality:From:
         Message-ID:Date:User-Agent:MIME-Version:In-Reply-To:
         X-Originating-IP:X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=cVTp46CKHePEECP52K2dPG9yMTm9OXppI3J07343O+fj4RxXSMefTks2DatSqehXl
         Deul4a0U9r8CNitF6x/+vSKvKSHiE9nbSUcC/ZhykeyjTlI8VDkSR1qeSTwlhcaxgy
         a5kU+PYtBp52MU9+XlHVvFcyOAZUzZAEJic8OE/DKbEcGpbyZawWTaTNKH/0cCa78N
         nTZDzbT+R5m6ThU8M3llmcByWj0S2HIoICpxVt7TFkcukvJCqcNQWFZd+s23VQ1vs2
         v4aAvsnrCz1lq6EDLLdYfBChFFB+Kp0EMdQFHGiNB3U4gm21UaBNULQYo7RPGG4F13
         HpxsKJwBLKbiA==
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 1/9/2020 11:36 AM, Shawn Guo wrote:
> External email: Use caution opening links or attachments
> 
> 
> Some platform has 4 (or more) viewports.  In that case, CFG0 and CFG1
> can be separated into different ATU regions.
Is there any specific benefit with this scheme?

- Vidya Sagar
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-host.c    | 16 +++++++++++++++-
>  drivers/pci/controller/dwc/pcie-designware.h     |  1 +
>  2 files changed, 16 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 0f36a926059a..504d2a192bba 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -532,6 +532,7 @@ static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>         u64 cpu_addr;
>         void __iomem *va_cfg_base;
>         struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +       int index = PCIE_ATU_REGION_INDEX1;
> 
>         busdev = PCIE_ATU_BUS(bus->number) | PCIE_ATU_DEV(PCI_SLOT(devfn)) |
>                  PCIE_ATU_FUNC(PCI_FUNC(devfn));
> @@ -548,7 +549,20 @@ static int dw_pcie_access_other_conf(struct pcie_port *pp, struct pci_bus *bus,
>                 va_cfg_base = pp->va_cfg1_base;
>         }
> 
> -       dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> +       if (pci->num_viewport >= 4) {
> +               /*
> +                * If there are 4 (or more) viewports, we can separate
> +                * CFG0 and CFG1 into different ATU regions:
> +                *  - region0: MEM
> +                *  - region1: CFG0
> +                *  - region2: IO
> +                *  - region3: CFG1
> +                */
> +               if (type == PCIE_ATU_TYPE_CFG1)
> +                       index = PCIE_ATU_REGION_INDEX3;
> +       }
> +
> +       dw_pcie_prog_outbound_atu(pci, index,
>                                   type, cpu_addr,
>                                   busdev, cfg_size);
>         if (write)
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 5a18e94e52c8..86225804f1e7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -63,6 +63,7 @@
>  #define PCIE_ATU_VIEWPORT              0x900
>  #define PCIE_ATU_REGION_INBOUND                BIT(31)
>  #define PCIE_ATU_REGION_OUTBOUND       0
> +#define PCIE_ATU_REGION_INDEX3         0x3
>  #define PCIE_ATU_REGION_INDEX2         0x2
>  #define PCIE_ATU_REGION_INDEX1         0x1
>  #define PCIE_ATU_REGION_INDEX0         0x0
> --
> 2.17.1
> 
