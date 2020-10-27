Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7BB29A903
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 11:07:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437642AbgJ0KGN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 06:06:13 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:1930 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437637AbgJ0KGN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 06:06:13 -0400
Received: from hqmail.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, AES256-SHA)
        id <B5f97f11b0002>; Tue, 27 Oct 2020 03:06:19 -0700
Received: from [10.40.203.191] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Tue, 27 Oct
 2020 10:06:01 +0000
Subject: Re: [PATCH] PCI: dwc: Support multiple ATU memory regions
To:     Rob Herring <robh@kernel.org>, <linux-pci@vger.kernel.org>
CC:     Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
References: <20201026181652.418729-1-robh@kernel.org>
From:   Vidya Sagar <vidyas@nvidia.com>
Message-ID: <a6410006-07a4-b9bd-ae04-a1db19e6ef9b@nvidia.com>
Date:   Tue, 27 Oct 2020 15:35:56 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
In-Reply-To: <20201026181652.418729-1-robh@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 HQMAIL107.nvidia.com (172.20.187.13)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1603793179; bh=BYmc9SuVlwvevP7tGENc47z3yGiej1ioWCv5taZtDeI=;
        h=Subject:To:CC:References:From:Message-ID:Date:User-Agent:
         MIME-Version:In-Reply-To:Content-Type:Content-Language:
         Content-Transfer-Encoding:X-Originating-IP:X-ClientProxiedBy;
        b=f6LArQHb0MVr4sV+JjcS2iagwv/lPZUyfVdOp5MG0ubuChzV9bCf3oF03t3k/LTgi
         kyt7REPvGMWK0KVarftxU68nY9YU4mz/gIuaJYjBFckplDzVcCO7NKy+CQEzyMibTr
         CTNEbWTSUY+BSBean/Yw01rxsn9aVB3Xoch2TpkmYftqZ64Wa3Z2cC7LLA/KqR41f8
         c3NxUQohIgXEWkIORg1NYy8m3puL45FRo+YXGXK7d36xxyKAx0r08kQ1CNRfErl6GK
         Hmt4VTti0hcK2w5xplvWMhNbCOq9bcZRGMUKSsGEgSu0Yr2kW5aqu+84RVF+otnnpj
         FnhDx7noj0I4w==
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 10/26/2020 11:46 PM, Rob Herring wrote:
> External email: Use caution opening links or attachments
> 
> 
> The current ATU setup only supports a single memory resource which
> isn't sufficient if there are also prefetchable memory regions. In order
> to support multiple memory regions, we need to move away from fixed ATU
> slots and rework the assignment. As there's always an ATU entry for
> config space, let's assign index 0 to config space. Then we assign
> memory resources to index 1 and up. Finally, if we have an I/O region
> and slots remaining, we assign the I/O region last. If there aren't
> remaining slots, we keep the same config and I/O space sharing.
> 
> Cc: Vidya Sagar <vidyas@nvidia.com>
> Cc: Jingoo Han <jingoohan1@gmail.com>
> Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> For 5.11. This is based on the regression fix for 5.10 I sent[1].
> 
> Rob
> 
> [1] https://lore.kernel.org/linux-pci/20201026154852.221483-1-robh@kernel.org/
> 
>   .../pci/controller/dwc/pcie-designware-host.c | 54 +++++++++++--------
>   drivers/pci/controller/dwc/pcie-designware.h  |  6 +--
>   2 files changed, 34 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 44c2a6572199..a6ffab9b537e 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -464,9 +464,7 @@ static void __iomem *dw_pcie_other_conf_map_bus(struct pci_bus *bus,
>                  type = PCIE_ATU_TYPE_CFG1;
> 
> 
> -       dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> -                                 type, pp->cfg0_base,
> -                                 busdev, pp->cfg0_size);
> +       dw_pcie_prog_outbound_atu(pci, 0, type, pp->cfg0_base, busdev, pp->cfg0_size);
> 
>          return pp->va_cfg0_base + where;
>   }
> @@ -480,9 +478,8 @@ static int dw_pcie_rd_other_conf(struct pci_bus *bus, unsigned int devfn,
> 
>          ret = pci_generic_config_read(bus, devfn, where, size, val);
> 
> -       if (!ret && pci->num_viewport <= 2)
> -               dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> -                                         PCIE_ATU_TYPE_IO, pp->io_base,
> +       if (!ret && pci->io_cfg_atu_shared)
> +               dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
>                                            pp->io_bus_addr, pp->io_size);
> 
>          return ret;
> @@ -497,9 +494,8 @@ static int dw_pcie_wr_other_conf(struct pci_bus *bus, unsigned int devfn,
> 
>          ret = pci_generic_config_write(bus, devfn, where, size, val);
> 
> -       if (!ret && pci->num_viewport <= 2)
> -               dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX1,
> -                                         PCIE_ATU_TYPE_IO, pp->io_base,
> +       if (!ret && pci->io_cfg_atu_shared)
> +               dw_pcie_prog_outbound_atu(pci, 0, PCIE_ATU_TYPE_IO, pp->io_base,
>                                            pp->io_bus_addr, pp->io_size);
> 
>          return ret;
> @@ -586,21 +582,35 @@ void dw_pcie_setup_rc(struct pcie_port *pp)
>           * ATU, so we should not program the ATU here.
>           */
>          if (pp->bridge->child_ops == &dw_child_pcie_ops) {
> -               struct resource_entry *tmp, *entry = NULL;
> +               int atu_idx = 0;
> +               struct resource_entry *entry;
> 
>                  /* Get last memory resource entry */
> -               resource_list_for_each_entry(tmp, &pp->bridge->windows)
> -                       if (resource_type(tmp->res) == IORESOURCE_MEM)
> -                               entry = tmp;
> -
> -               dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX0,
> -                                         PCIE_ATU_TYPE_MEM, entry->res->start,
> -                                         entry->res->start - entry->offset,
> -                                         resource_size(entry->res));
> -               if (pci->num_viewport > 2)
> -                       dw_pcie_prog_outbound_atu(pci, PCIE_ATU_REGION_INDEX2,
> -                                                 PCIE_ATU_TYPE_IO, pp->io_base,
> -                                                 pp->io_bus_addr, pp->io_size);
> +               resource_list_for_each_entry(entry, &pp->bridge->windows) {
> +                       if (resource_type(entry->res) != IORESOURCE_MEM)
> +                               continue;
> +
> +                       if (pci->num_viewport <= ++atu_idx)
> +                               break;
> +
> +                       dw_pcie_prog_outbound_atu(pci, atu_idx,
> +                                                 PCIE_ATU_TYPE_MEM, entry->res->start,
> +                                                 entry->res->start - entry->offset,
> +                                                 resource_size(entry->res));
> +               }
> +
> +               if (pp->io_size) {
> +                       if (pci->num_viewport > ++atu_idx)
> +                               dw_pcie_prog_outbound_atu(pci, atu_idx,
> +                                                         PCIE_ATU_TYPE_IO, pp->io_base,
> +                                                         pp->io_bus_addr, pp->io_size);
> +                       else
> +                               pci->io_cfg_atu_shared = true;
> +               }
> +
> +               if (pci->num_viewport <= atu_idx)
> +                       dev_warn(pci->dev, "Resources exceed number of ATU entries (%d)",
> +                                pci->num_viewport);
>          }
> 
>          dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 9d2f511f13fa..ed19c34dd0fe 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -80,9 +80,6 @@
>   #define PCIE_ATU_VIEWPORT              0x900
>   #define PCIE_ATU_REGION_INBOUND                BIT(31)
>   #define PCIE_ATU_REGION_OUTBOUND       0
> -#define PCIE_ATU_REGION_INDEX2         0x2
> -#define PCIE_ATU_REGION_INDEX1         0x1
> -#define PCIE_ATU_REGION_INDEX0         0x0
>   #define PCIE_ATU_CR1                   0x904
>   #define PCIE_ATU_TYPE_MEM              0x0
>   #define PCIE_ATU_TYPE_IO               0x2
> @@ -266,7 +263,6 @@ struct dw_pcie {
>          /* Used when iatu_unroll_enabled is true */
>          void __iomem            *atu_base;
>          u32                     num_viewport;
> -       u8                      iatu_unroll_enabled;
>          struct pcie_port        pp;
>          struct dw_pcie_ep       ep;
>          const struct dw_pcie_ops *ops;
> @@ -274,6 +270,8 @@ struct dw_pcie {
>          int                     num_lanes;
>          int                     link_gen;
>          u8                      n_fts[2];
> +       bool                    iatu_unroll_enabled: 1;
> +       bool                    io_cfg_atu_shared: 1;
>   };
> 
>   #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
> --
> 2.25.1
> 

Reviewed and Verified it on Tegra194 and functionality is fine.
Reviewed-by: Vidya Sagar <vidyas@nvidia.com>
Tested-by: Vidya Sagar <vidyas@nvidia.com>

