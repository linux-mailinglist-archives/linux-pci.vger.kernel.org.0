Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EFAB5FFC2D
	for <lists+linux-pci@lfdr.de>; Sun, 16 Oct 2022 00:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbiJOWA1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Oct 2022 18:00:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJOWA0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 Oct 2022 18:00:26 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0652ED44;
        Sat, 15 Oct 2022 15:00:24 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id fy4so17431504ejc.5;
        Sat, 15 Oct 2022 15:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PQJYXHbTSUtNdbFyMXASJ14+jd3pL38gXIUjRlOeZqI=;
        b=b2Dpx2XkjzSw4Lq7hvzIhLnXuaamFJOp2fYeWFH2YGy9AYM9cXOD/rtyyaw6ZKopce
         HffEHPM3NBJ4G1gK78gGJf7UCA5dX0zixwfliSuqftfHbp5gr614g89XFdDnj1UHYAzi
         ozCBpKVDx63WcGCPbWb0om7vcht9On+AOjs/7Iagb8MbpCcRFvXxWrCf3GfBSpiyuV4R
         VJY3kcaCjSmPN5EzLxD5ckrFBsjEjSFMDrt80PwnVtPZj1E9y7WSNzfAMIx+3xs1GVJK
         LQoesR76+a0vpPse6q0FoUST+/8ZSRcBbHL4MPjuRBC5/ZCg+HSnrmXCE4eRydl1lXJG
         3mdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PQJYXHbTSUtNdbFyMXASJ14+jd3pL38gXIUjRlOeZqI=;
        b=6drgWhCfglj+yVQmK6sQId0aCxFjPF8vNR0uOibqxkQIxo0jOPscIqnaSCCAZ6XSY4
         BXz2jSd5a7ayGmH+mgSdnbNw9+fj5k49a62gItBYkhPvqRQFBIdeflpxkruPuZpbVQFp
         CacfsDpwS6o2MAy9A3fm/2O/hKRqFc3HMwgpQhW9e0B+uUTp0ge74PVdrFyehCMw33qq
         Pr/6nylAECgaLVnb/jDcMqK+X0p84HCw80M9PcOv3rTNnKsbIGVhTEOAcjLcP4nvgSuk
         9PwZ765ovXdkdL153mDjIOLlFqJmMZjQbv1BX7MAr3riJPVkibDIe7wFXzFvqZzdGVix
         6vCg==
X-Gm-Message-State: ACrzQf13H5FZYLzUxx41DPceLKEl5ErgtZlrpbxb1fiIturznsYZxhF9
        2XzzLtLHs2pSToEOM9n5K346DGNroNk4J9E4tQg=
X-Google-Smtp-Source: AMsMyM7fTiML2BfNqz+mU+BamVf1KMemDD6QnQ8xN57qsQGcWJn2Keowu67D9zZ5bTAXjxvfe1c0M442qjADUh/P0nI=
X-Received: by 2002:a17:907:b01:b0:78d:ce3d:905d with SMTP id
 h1-20020a1709070b0100b0078dce3d905dmr3290464ejl.45.1665871222709; Sat, 15 Oct
 2022 15:00:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221013175712.7539-1-vidyas@nvidia.com> <20221013175712.7539-2-vidyas@nvidia.com>
In-Reply-To: <20221013175712.7539-2-vidyas@nvidia.com>
From:   Han Jingoo <jingoohan1@gmail.com>
Date:   Sat, 15 Oct 2022 15:00:11 -0700
Message-ID: <CAPOBaE5Oee9qKgyKgoT0qNr+L41BZm1cfjZ1xMQ5gs2r40ZWCA@mail.gmail.com>
Subject: Re: [PATCH V5 1/3] PCI: designware-ep: Fix DBI access before core init
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     gustavo.pimentel@synopsys.com, lpieralisi@kernel.org,
        robh@kernel.org, kw@linux.com, bhelgaas@google.com,
        Sergey.Semin@baikalelectronics.ru, dmitry.baryshkov@linaro.org,
        linmq006@gmail.com, ffclaire1224@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, mani@kernel.org,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 Vidya Sagar <vidyas@nvidia.com> wrote:
>
> Platforms that cannot support their core initialization without the
> reference clock from the host, implement the feature 'core_init_notifier'
> to indicate the DesignWare sub-system about when their core is getting
> initialized. Any accesses to the core (Ex:- DBI) would the core being
> ready result in system hang in such systems (Ex:- tegra194).
> This patch moves any access to the core to dw_pcie_ep_init_complete() API
> which is effectively called only after the core initialization.
> It also introduces .ep_init_late() ops hook to be used for any post init
> work that platform drivers may have to do.
>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> ---
> V5:
> * Changed dw_pcie_ep_init_complete() to dw_pcie_ep_init_late()
> * Skipped memory allocation if done already. This is to avoid freeing and then
>   allocating again during PERST# toggles from the host.
>
> V4:
> * Addressed review comments from Bjorn and Manivannan
> * Moved dw_pcie_ep_init_complete() inside dw_pcie_ep_init_notify()
> * Added .ep_init_late() ops to perform late init tasks
>
>  .../pci/controller/dwc/pcie-designware-ep.c   | 125 +++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h  |  10 +-
>  2 files changed, 80 insertions(+), 55 deletions(-)

Acked-by: Jingoo Han <jingoohan1@gmail.com>

The function name 'dw_pcie_ep_init_late' looks clear to me. Also,
commit messages
and comments are understandable. So, I am ok with the patches, but I also think
that we need to wait for Manivannan's Tested-by on qcom platforms.

Best regards,
Jingoo Han

>
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 83ddb190292e..f300ea2f7bf7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -23,14 +23,6 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
>
> -void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> -{
> -       struct pci_epc *epc = ep->epc;
> -
> -       pci_epc_init_notify(epc);
> -}
> -EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
> -
>  struct dw_pcie_ep_func *
>  dw_pcie_ep_get_func_from_ep(struct dw_pcie_ep *ep, u8 func_no)
>  {
> @@ -640,12 +632,17 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>         return 0;
>  }
>
> -int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> +static int dw_pcie_ep_init_late(struct dw_pcie_ep *ep)
>  {
>         struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +       struct dw_pcie_ep_func *ep_func;
> +       struct device *dev = pci->dev;
> +       struct pci_epc *epc = ep->epc;
>         unsigned int offset;
>         unsigned int nbars;
>         u8 hdr_type;
> +       u8 func_no;
> +       void *addr;
>         u32 reg;
>         int i;
>
> @@ -658,6 +655,51 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>                 return -EIO;
>         }
>
> +       dw_pcie_version_detect(pci);
> +
> +       dw_pcie_iatu_detect(pci);
> +
> +       if (!ep->ib_window_map) {
> +               ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
> +                                                      GFP_KERNEL);
> +               if (!ep->ib_window_map)
> +                       return -ENOMEM;
> +       }
> +
> +       if (!ep->ob_window_map) {
> +               ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
> +                                                      GFP_KERNEL);
> +               if (!ep->ob_window_map)
> +                       return -ENOMEM;
> +       }
> +
> +       if (!ep->outbound_addr) {
> +               addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> +                                   GFP_KERNEL);
> +               if (!addr)
> +                       return -ENOMEM;
> +               ep->outbound_addr = addr;
> +       }
> +
> +       for (func_no = 0; func_no < epc->max_functions; func_no++) {
> +
> +               ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
> +               if (ep_func)
> +                       continue;
> +
> +               ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> +               if (!ep_func)
> +                       return -ENOMEM;
> +
> +               ep_func->func_no = func_no;
> +               ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> +                                                             PCI_CAP_ID_MSI);
> +               ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> +                                                              PCI_CAP_ID_MSIX);
> +
> +               list_add_tail(&ep_func->list, &ep->func_list);
> +       }
> +
>         offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>
>         dw_pcie_dbi_ro_wr_en(pci);
> @@ -676,13 +718,28 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>
>         return 0;
>  }
> -EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
> +
> +int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> +{
> +       struct pci_epc *epc = ep->epc;
> +       int ret;
> +
> +       ret = dw_pcie_ep_init_late(ep);
> +       if (ret)
> +               return ret;
> +
> +       if (ep->ops->ep_init_late)
> +               ep->ops->ep_init_late(ep);
> +
> +       pci_epc_init_notify(epc);
> +
> +       return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
>
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>         int ret;
> -       void *addr;
> -       u8 func_no;
>         struct resource *res;
>         struct pci_epc *epc;
>         struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -690,7 +747,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>         struct platform_device *pdev = to_platform_device(dev);
>         struct device_node *np = dev->of_node;
>         const struct pci_epc_features *epc_features;
> -       struct dw_pcie_ep_func *ep_func;
>
>         INIT_LIST_HEAD(&ep->func_list);
>
> @@ -719,26 +775,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>         ep->phys_base = res->start;
>         ep->addr_size = resource_size(res);
>
> -       dw_pcie_version_detect(pci);
> -
> -       dw_pcie_iatu_detect(pci);
> -
> -       ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
> -                                              GFP_KERNEL);
> -       if (!ep->ib_window_map)
> -               return -ENOMEM;
> -
> -       ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
> -                                              GFP_KERNEL);
> -       if (!ep->ob_window_map)
> -               return -ENOMEM;
> -
> -       addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> -                           GFP_KERNEL);
> -       if (!addr)
> -               return -ENOMEM;
> -       ep->outbound_addr = addr;
> -
>         if (pci->link_gen < 1)
>                 pci->link_gen = of_pci_get_max_link_speed(np);
>
> @@ -755,20 +791,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>         if (ret < 0)
>                 epc->max_functions = 1;
>
> -       for (func_no = 0; func_no < epc->max_functions; func_no++) {
> -               ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> -               if (!ep_func)
> -                       return -ENOMEM;
> -
> -               ep_func->func_no = func_no;
> -               ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> -                                                             PCI_CAP_ID_MSI);
> -               ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> -                                                              PCI_CAP_ID_MSIX);
> -
> -               list_add_tail(&ep_func->list, &ep->func_list);
> -       }
> -
>         if (ep->ops->ep_init)
>                 ep->ops->ep_init(ep);
>
> @@ -793,7 +815,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>                         return 0;
>         }
>
> -       ret = dw_pcie_ep_init_complete(ep);
> +       /*
> +        * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
> +        * step as platforms that implement 'core_init_notifier' feature may
> +        * not have the hardware ready (i.e. core initialized) for access
> +        * (Ex: tegra194). Any hardware access on such platforms result
> +        * in system hard hang.
> +        */
> +       ret = dw_pcie_ep_init_late(ep);
>         if (ret)
>                 goto err_free_epc_mem;
>
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 45fcdfc8c035..7252513956b7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -253,6 +253,7 @@ struct dw_pcie_rp {
>
>  struct dw_pcie_ep_ops {
>         void    (*ep_init)(struct dw_pcie_ep *ep);
> +       void    (*ep_init_late)(struct dw_pcie_ep *ep);
>         int     (*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>                              enum pci_epc_irq_type type, u16 interrupt_num);
>         const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
> @@ -467,8 +468,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
>  #ifdef CONFIG_PCIE_DW_EP
>  void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep);
> -int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
> -void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
> +int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
>  void dw_pcie_ep_exit(struct dw_pcie_ep *ep);
>  int dw_pcie_ep_raise_legacy_irq(struct dw_pcie_ep *ep, u8 func_no);
>  int dw_pcie_ep_raise_msi_irq(struct dw_pcie_ep *ep, u8 func_no,
> @@ -490,15 +490,11 @@ static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>         return 0;
>  }
>
> -static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> +static inline int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>  {
>         return 0;
>  }
>
> -static inline void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> -{
> -}
> -
>  static inline void dw_pcie_ep_exit(struct dw_pcie_ep *ep)
>  {
>  }
> --
> 2.17.1
>
