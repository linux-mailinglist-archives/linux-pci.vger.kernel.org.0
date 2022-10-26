Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7937960DA7A
	for <lists+linux-pci@lfdr.de>; Wed, 26 Oct 2022 07:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiJZFKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Oct 2022 01:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232014AbiJZFKk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Oct 2022 01:10:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 342327B7B3;
        Tue, 25 Oct 2022 22:10:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 54F1EB82029;
        Wed, 26 Oct 2022 05:10:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7568C433D7;
        Wed, 26 Oct 2022 05:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666761035;
        bh=HBGZMyGLcq3VPftNJb+5imASOZTf4iQT/uEHrSDYACY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kCWHH0kK76nAaCr6Sos1lIxYkBgcdVc7ahhWqhRX3YXHl77tgjOYGKW8MJEBVGb4R
         fAOyCLz5XO11NNRA4SfTv4CDmJGw67gp7zk3b1wMOuUCKRbsfFVbG+gcZi4NyuW/Ff
         UjAAxUkZPIpVxl8DytwJqupG71soEU4IABUzInFRJLQiTe5tJnl5sD/Zx0iWB8yYV7
         1uZOFG06u0vw3b4FW/oKfp2U1iKJqqh4wa43bHnzExEzLLyjcZw4GNMaTy1Ld7w7Jj
         4FOX+ig6M76IxRPdEsTwLgvegT7ViHueztVDVTL/1XsShZpzDA+w9cIi3gayjFDRSa
         Gzem83vgw0DFw==
Date:   Wed, 26 Oct 2022 10:40:19 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, dmitry.baryshkov@linaro.org,
        linmq006@gmail.com, ffclaire1224@gmail.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V5 1/3] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20221026051019.GA5179@thinkpad>
References: <20221013175712.7539-1-vidyas@nvidia.com>
 <20221013175712.7539-2-vidyas@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221013175712.7539-2-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Oct 13, 2022 at 11:27:10PM +0530, Vidya Sagar wrote:
> Platforms that cannot support their core initialization without the
> reference clock from the host, implement the feature 'core_init_notifier'
> to indicate the DesignWare sub-system about when their core is getting
> initialized. Any accesses to the core (Ex:- DBI) would the core being
> ready result in system hang in such systems (Ex:- tegra194).
> This patch moves any access to the core to dw_pcie_ep_init_complete() API

dw_pcie_ep_init_complete() got renamed to dw_pcie_ep_init_late()

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
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 83ddb190292e..f300ea2f7bf7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c

[...]

> +int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
> +{
> +	struct pci_epc *epc = ep->epc;
> +	int ret;
> +
> +	ret = dw_pcie_ep_init_late(ep);
> +	if (ret)
> +		return ret;
> +
> +	if (ep->ops->ep_init_late)
> +		ep->ops->ep_init_late(ep);

I think you introduced this callback for the sake of Qcom driver I believe.
But it is not really required. I'll share more comments in patch 2/3.

Thanks,
Mani

> +
> +	pci_epc_init_notify(epc);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
>  
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	int ret;
> -	void *addr;
> -	u8 func_no;
>  	struct resource *res;
>  	struct pci_epc *epc;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -690,7 +747,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *np = dev->of_node;
>  	const struct pci_epc_features *epc_features;
> -	struct dw_pcie_ep_func *ep_func;
>  
>  	INIT_LIST_HEAD(&ep->func_list);
>  
> @@ -719,26 +775,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->phys_base = res->start;
>  	ep->addr_size = resource_size(res);
>  
> -	dw_pcie_version_detect(pci);
> -
> -	dw_pcie_iatu_detect(pci);
> -
> -	ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
> -					       GFP_KERNEL);
> -	if (!ep->ib_window_map)
> -		return -ENOMEM;
> -
> -	ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
> -					       GFP_KERNEL);
> -	if (!ep->ob_window_map)
> -		return -ENOMEM;
> -
> -	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> -			    GFP_KERNEL);
> -	if (!addr)
> -		return -ENOMEM;
> -	ep->outbound_addr = addr;
> -
>  	if (pci->link_gen < 1)
>  		pci->link_gen = of_pci_get_max_link_speed(np);
>  
> @@ -755,20 +791,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	if (ret < 0)
>  		epc->max_functions = 1;
>  
> -	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> -		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> -		if (!ep_func)
> -			return -ENOMEM;
> -
> -		ep_func->func_no = func_no;
> -		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> -							      PCI_CAP_ID_MSI);
> -		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> -							       PCI_CAP_ID_MSIX);
> -
> -		list_add_tail(&ep_func->list, &ep->func_list);
> -	}
> -
>  	if (ep->ops->ep_init)
>  		ep->ops->ep_init(ep);
>  
> @@ -793,7 +815,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  			return 0;
>  	}
>  
> -	ret = dw_pcie_ep_init_complete(ep);
> +	/*
> +	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
> +	 * step as platforms that implement 'core_init_notifier' feature may
> +	 * not have the hardware ready (i.e. core initialized) for access
> +	 * (Ex: tegra194). Any hardware access on such platforms result
> +	 * in system hard hang.
> +	 */
> +	ret = dw_pcie_ep_init_late(ep);
>  	if (ret)
>  		goto err_free_epc_mem;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 45fcdfc8c035..7252513956b7 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -253,6 +253,7 @@ struct dw_pcie_rp {
>  
>  struct dw_pcie_ep_ops {
>  	void	(*ep_init)(struct dw_pcie_ep *ep);
> +	void	(*ep_init_late)(struct dw_pcie_ep *ep);
>  	int	(*raise_irq)(struct dw_pcie_ep *ep, u8 func_no,
>  			     enum pci_epc_irq_type type, u16 interrupt_num);
>  	const struct pci_epc_features* (*get_features)(struct dw_pcie_ep *ep);
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
>  	return 0;
>  }
>  
> -static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> +static inline int dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
>  {
>  	return 0;
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

-- 
மணிவண்ணன் சதாசிவம்
