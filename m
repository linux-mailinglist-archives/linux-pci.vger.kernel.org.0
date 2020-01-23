Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 91B31147398
	for <lists+linux-pci@lfdr.de>; Thu, 23 Jan 2020 23:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbgAWWKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Jan 2020 17:10:21 -0500
Received: from mail-ot1-f67.google.com ([209.85.210.67]:46999 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726191AbgAWWKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 23 Jan 2020 17:10:21 -0500
Received: by mail-ot1-f67.google.com with SMTP id g64so500556otb.13;
        Thu, 23 Jan 2020 14:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yDW4eNC3KeswQXJexI/cQft97nYabOSfO7WM788bKA8=;
        b=q7q8Q8LUbSkBX1SG1WGnzySEyKzVEXUDRXEx7uEifLNI6q79ck0A7a3LfrMaC7ihgv
         ktNcnDax1bUAiz3R6W64zjiP95N+ckzInJIx5kvcm6xswMljg4mCvBRnccNRFPdFixm+
         by8abOx/fhlUiuIbGv5jX/Z1oDVJDsBE7mJdOGCmqac1Z3ZaaGgBo8UsdHqQZ/5hKSA0
         qF1E1RlJDMpvYz7ngjPDQCaAGb3reZn8Z11sDofUo6j4WSnrg7UgjRsUA5eFODuWmJ7e
         7v+l8vmRGfabKaEc6xDzMBSFdl5oL1nX2lq2Vfm6gAdUHUqm6EQXOBbtIEKReE9CDHcq
         vkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yDW4eNC3KeswQXJexI/cQft97nYabOSfO7WM788bKA8=;
        b=dMFjHzwrBlaS4dsilx7RIFhOLukVfW2XGVlHfLvQ2V8qAYiznOTfA/irCk16ZV/0sC
         WBZR08ASWuFQ6CYDqM7pStHRFYSlHDtEnOLZoUdgUbvJ3FymGZQ/nYPrhUfJa44N9kVG
         tkvUTY1GM9euL6+AMySzy0O1E4IQiv0mk2ZKDckRcIWwqb6syhQAgfYIgYLXGdMkLMTM
         TB5u13Tb1TuU4Nq3gqtEA2qADhiJUmnJUxDeenNWfmmZllMXhzLzsRe2ea4E18+w9TYD
         r1qJyrC2MNWqFuBueo1olUyemun8tRVcbA7uos+ivS6aBd5A+vlSbTmkzsCmwSilrtvm
         dOIg==
X-Gm-Message-State: APjAAAW/i8pcUNNoogg5z+9VRNNYmoBaZOBMkWOR/h0ENvuNqYWhvxJx
        C8/eSBm2t0ZGQoOom9aatvNJ12iJxyZjZk6Mz4c=
X-Google-Smtp-Source: APXvYqxg42q49vwZ4t7IPhYmNvVO+1rqtdUl3/lztVPtz9PUfHBTIjFIruan+M0VjwZ6kFLGNuHl3VlQNofuPunXQdg=
X-Received: by 2002:a05:6830:1615:: with SMTP id g21mr438063otr.49.1579817420199;
 Thu, 23 Jan 2020 14:10:20 -0800 (PST)
MIME-Version: 1.0
References: <20191211124608.887-1-kishon@ti.com> <20191211124608.887-5-kishon@ti.com>
In-Reply-To: <20191211124608.887-5-kishon@ti.com>
From:   Ramon Fried <rfried.dev@gmail.com>
Date:   Fri, 24 Jan 2020 00:10:09 +0200
Message-ID: <CAGi-RUJCkEuqukEawjh_TqmWTYeYP7Qimaz3OTgpWnTZr9bZPA@mail.gmail.com>
Subject: Re: [PATCH 4/4] PCI: cadence: Add MSI-X support to Endpoint driver
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Jingoo Han <jingoohan1@gmail.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Dec 11, 2019 at 2:47 PM Kishon Vijay Abraham I <kishon@ti.com> wrote:
>
> From: Alan Douglas <adouglas@cadence.com>
>
> Implement ->set_msix() and ->get_msix() callback functions in order
> to configure MSIX capability in the PCIe endpoint controller.
>
> Add cdns_pcie_ep_send_msix_irq() to send MSIX interrupts to Host.
> cdns_pcie_ep_send_msix_irq() gets the MSIX table address (virtual
> address) from "struct cdns_pcie_epf" that gets initialized in
> ->set_bar() call back function.
>
> [kishon@ti.com: Re-implement MSIX support in accordance with the
>  re-designed core MSI-X interfaces]
> Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
> Signed-off-by: Alan Douglas <adouglas@cadence.com>
> ---
>  .../pci/controller/cadence/pcie-cadence-ep.c  | 112 +++++++++++++++++-
>  drivers/pci/controller/cadence/pcie-cadence.h |  10 ++
>  2 files changed, 121 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/pci/controller/cadence/pcie-cadence-ep.c b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> index 088394b6be04..c3081e8e52a4 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence-ep.c
> +++ b/drivers/pci/controller/cadence/pcie-cadence-ep.c
> @@ -52,6 +52,7 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
>                                 struct pci_epf_bar *epf_bar)
>  {
>         struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +       struct cdns_pcie_epf *epf = &ep->epf[fn];
>         struct cdns_pcie *pcie = &ep->pcie;
>         dma_addr_t bar_phys = epf_bar->phys_addr;
>         enum pci_barno bar = epf_bar->barno;
> @@ -112,6 +113,8 @@ static int cdns_pcie_ep_set_bar(struct pci_epc *epc, u8 fn,
>                 CDNS_PCIE_LM_EP_FUNC_BAR_CFG_BAR_CTRL(b, ctrl));
>         cdns_pcie_writel(pcie, reg, cfg);
>
> +       epf->epf_bar[bar] = epf_bar;
> +
>         return 0;
>  }
>
> @@ -119,6 +122,7 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
>                                    struct pci_epf_bar *epf_bar)
>  {
>         struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +       struct cdns_pcie_epf *epf = &ep->epf[fn];
>         struct cdns_pcie *pcie = &ep->pcie;
>         enum pci_barno bar = epf_bar->barno;
>         u32 reg, cfg, b, ctrl;
> @@ -140,6 +144,8 @@ static void cdns_pcie_ep_clear_bar(struct pci_epc *epc, u8 fn,
>
>         cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR0(fn, bar), 0);
>         cdns_pcie_writel(pcie, CDNS_PCIE_AT_IB_EP_FUNC_BAR_ADDR1(fn, bar), 0);
> +
> +       epf->epf_bar[bar] = NULL;
>  }
>
>  static int cdns_pcie_ep_map_addr(struct pci_epc *epc, u8 fn, phys_addr_t addr,
> @@ -225,6 +231,50 @@ static int cdns_pcie_ep_get_msi(struct pci_epc *epc, u8 fn)
>         return mme;
>  }
>
> +static int cdns_pcie_ep_get_msix(struct pci_epc *epc, u8 func_no)
> +{
> +       struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +       struct cdns_pcie *pcie = &ep->pcie;
> +       u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> +       u32 val, reg;
> +
> +       reg = cap + PCI_MSIX_FLAGS;
> +       val = cdns_pcie_ep_fn_readw(pcie, func_no, reg);
> +       if (!(val & PCI_MSIX_FLAGS_ENABLE))
> +               return -EINVAL;
> +
> +       val &= PCI_MSIX_FLAGS_QSIZE;
> +
> +       return val;
> +}
> +
> +static int cdns_pcie_ep_set_msix(struct pci_epc *epc, u8 fn, u16 interrupts,
> +                                enum pci_barno bir, u32 offset)
> +{
> +       struct cdns_pcie_ep *ep = epc_get_drvdata(epc);
> +       struct cdns_pcie *pcie = &ep->pcie;
> +       u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> +       u32 val, reg;
> +
> +       reg = cap + PCI_MSIX_FLAGS;
> +       val = cdns_pcie_ep_fn_readw(pcie, fn, reg);
> +       val &= ~PCI_MSIX_FLAGS_QSIZE;
> +       val |= interrupts;
> +       cdns_pcie_ep_fn_writew(pcie, fn, reg, val);
> +
> +       /* Set MSIX BAR and offset */
> +       reg = cap + PCI_MSIX_TABLE;
> +       val = offset | bir;
> +       cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
> +
> +       /* Set PBA BAR and offset.  BAR must match MSIX BAR */
> +       reg = cap + PCI_MSIX_PBA;
> +       val = (offset + (interrupts * PCI_MSIX_ENTRY_SIZE)) | bir;
> +       cdns_pcie_ep_fn_writel(pcie, fn, reg, val);
> +
> +       return 0;
> +}
> +
>  static void cdns_pcie_ep_assert_intx(struct cdns_pcie_ep *ep, u8 fn,
>                                      u8 intx, bool is_asserted)
>  {
> @@ -331,6 +381,56 @@ static int cdns_pcie_ep_send_msi_irq(struct cdns_pcie_ep *ep, u8 fn,
>         return 0;
>  }
>
> +static int cdns_pcie_ep_send_msix_irq(struct cdns_pcie_ep *ep, u8 fn,
> +                                     u16 interrupt_num)
> +{
> +       u32 cap = CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET;
> +       u32 tbl_offset, msg_data, reg, vec_ctrl;
> +       struct cdns_pcie *pcie = &ep->pcie;
> +       struct pci_epf_msix_tbl *msix_tbl;
> +       struct pci_epf_bar *epf_bar;
> +       struct cdns_pcie_epf *epf;
> +       u64 pci_addr_mask = 0xff;
> +       u64 msg_addr;
> +       u16 flags;
> +       u8 bir;
> +
> +       /* Check whether the MSI-X feature has been enabled by the PCI host. */
> +       flags = cdns_pcie_ep_fn_readw(pcie, fn, cap + PCI_MSIX_FLAGS);
> +       if (!(flags & PCI_MSIX_FLAGS_ENABLE))
> +               return -EINVAL;
> +
> +       reg = cap + PCI_MSIX_TABLE;
> +       tbl_offset = cdns_pcie_ep_fn_readl(pcie, fn, reg);
> +       bir = tbl_offset & PCI_MSIX_TABLE_BIR;
> +       tbl_offset &= PCI_MSIX_TABLE_OFFSET;
> +
> +       epf = &ep->epf[fn];
> +       epf_bar = epf->epf_bar[bir];
> +       msix_tbl = epf_bar->addr;
> +       msix_tbl = (struct pci_epf_msix_tbl *)((char *)msix_tbl + tbl_offset);
> +
> +       msg_addr = msix_tbl[(interrupt_num - 1)].msg_addr;
> +       msg_data = msix_tbl[(interrupt_num - 1)].msg_data;
> +       vec_ctrl = msix_tbl[(interrupt_num - 1)].vector_ctrl;
> +
> +       /* Set the outbound region if needed. */
> +       if (unlikely(ep->irq_pci_addr != (msg_addr & ~pci_addr_mask) ||
I'm not sure about this _unlikely_, because unlike MSI, msg_addr will
be different for every vector.
It's interesting if safe to assume that host will allocate all message
address in linear fashion,
in that case maybe it's wiser to map all the the area at once and just
offset into it.

Thanks,
Ramon.

> +                    ep->irq_pci_fn != fn)) {
> +               /* First region was reserved for IRQ writes. */
> +               cdns_pcie_set_outbound_region(pcie, fn, 0,
> +                                             false,
> +                                             ep->irq_phys_addr,
> +                                             msg_addr & ~pci_addr_mask,
> +                                             pci_addr_mask + 1);
> +               ep->irq_pci_addr = (msg_addr & ~pci_addr_mask);
> +               ep->irq_pci_fn = fn;
> +       }
> +       writel(msg_data, ep->irq_cpu_addr + (msg_addr & pci_addr_mask));
> +
> +       return 0;
> +}
> +
>  static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
>                                   enum pci_epc_irq_type type,
>                                   u16 interrupt_num)
> @@ -344,6 +444,9 @@ static int cdns_pcie_ep_raise_irq(struct pci_epc *epc, u8 fn,
>         case PCI_EPC_IRQ_MSI:
>                 return cdns_pcie_ep_send_msi_irq(ep, fn, interrupt_num);
>
> +       case PCI_EPC_IRQ_MSIX:
> +               return cdns_pcie_ep_send_msix_irq(ep, fn, interrupt_num);
> +
>         default:
>                 break;
>         }
> @@ -381,7 +484,7 @@ static int cdns_pcie_ep_start(struct pci_epc *epc)
>  static const struct pci_epc_features cdns_pcie_epc_features = {
>         .linkup_notifier = false,
>         .msi_capable = true,
> -       .msix_capable = false,
> +       .msix_capable = true,
>  };
>
>  static const struct pci_epc_features*
> @@ -398,6 +501,8 @@ static const struct pci_epc_ops cdns_pcie_epc_ops = {
>         .unmap_addr     = cdns_pcie_ep_unmap_addr,
>         .set_msi        = cdns_pcie_ep_set_msi,
>         .get_msi        = cdns_pcie_ep_get_msi,
> +       .set_msix       = cdns_pcie_ep_set_msix,
> +       .get_msix       = cdns_pcie_ep_get_msix,
>         .raise_irq      = cdns_pcie_ep_raise_irq,
>         .start          = cdns_pcie_ep_start,
>         .get_features   = cdns_pcie_ep_get_features,
> @@ -457,6 +562,11 @@ int cdns_pcie_ep_setup(struct cdns_pcie_ep *ep)
>         if (of_property_read_u8(np, "max-functions", &epc->max_functions) < 0)
>                 epc->max_functions = 1;
>
> +       ep->epf = devm_kcalloc(dev, epc->max_functions, sizeof(*ep->epf),
> +                              GFP_KERNEL);
> +       if (!ep->epf)
> +               return -ENOMEM;
> +
>         ret = pci_epc_mem_init(epc, pcie->mem_res->start,
>                                resource_size(pcie->mem_res));
>         if (ret < 0) {
> diff --git a/drivers/pci/controller/cadence/pcie-cadence.h b/drivers/pci/controller/cadence/pcie-cadence.h
> index ffa8b9f78ff8..207d6ba03f70 100644
> --- a/drivers/pci/controller/cadence/pcie-cadence.h
> +++ b/drivers/pci/controller/cadence/pcie-cadence.h
> @@ -99,6 +99,7 @@
>  #define CDNS_PCIE_EP_FUNC_BASE(fn)     (((fn) << 12) & GENMASK(19, 12))
>
>  #define CDNS_PCIE_EP_FUNC_MSI_CAP_OFFSET       0x90
> +#define CDNS_PCIE_EP_FUNC_MSIX_CAP_OFFSET      0xb0
>
>  /*
>   * Root Port Registers (PCI configuration space for the root port function)
> @@ -281,6 +282,14 @@ struct cdns_pcie_rc {
>         u16                     device_id;
>  };
>
> +/**
> + * struct cdns_pcie_epf - Structure to hold info about endpoint function
> + * @epf_bar: reference to the pci_epf_bar for the six Base Address Registers
> + */
> +struct cdns_pcie_epf {
> +       struct pci_epf_bar *epf_bar[PCI_STD_NUM_BARS];
> +};
> +
>  /**
>   * struct cdns_pcie_ep - private data for this PCIe endpoint controller driver
>   * @pcie: Cadence PCIe controller
> @@ -308,6 +317,7 @@ struct cdns_pcie_ep {
>         u64                     irq_pci_addr;
>         u8                      irq_pci_fn;
>         u8                      irq_pending;
> +       struct cdns_pcie_epf    *epf;
>  };
>
>
> --
> 2.17.1
>
