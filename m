Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05F8E583543
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jul 2022 00:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237470AbiG0WRY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Jul 2022 18:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234845AbiG0WRK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Jul 2022 18:17:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C79C6555F;
        Wed, 27 Jul 2022 15:14:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 821E6B82282;
        Wed, 27 Jul 2022 22:14:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6F6FC433C1;
        Wed, 27 Jul 2022 22:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658960057;
        bh=FuvYzHx+Ie83hYrbziPgMKpuydXyKT/QHYmUmUBTg+I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Q7dlR5wgcXfi2XXM6e90rGWnxp5N3pJOSA+/igr3zz6JV6hYQrVbr9ESNwJ/H4bNP
         xSHRSocvrCbzi4VCwWe9j0MjuuwfjVEHkoO4xGCQ7d/DYp26QGNy5qc/QFc0Lo63pS
         eTFV8duQWviVYXrXFs8rSht4QSOI0DStmsz/WFHCqBm+2fEsrwoxW2fWrvqSo7p0pr
         6BPyU/xn/6lgl2VsovxCWrLMLB94zqqI/Y+n0KJ4wNp/7u80Dq3WuTKlrEZVQ3iS23
         dZ5ndA0BW2oqe/zXjvGHFG555rOQM0PoW/AaM0iDgDEjk148OzRljWzx8jHkL0DM0k
         XnEW0FBFoh7Rg==
Date:   Wed, 27 Jul 2022 17:14:15 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Vidya Sagar <vidyas@nvidia.com>
Cc:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, kthota@nvidia.com,
        mmaddireddy@nvidia.com, sagar.tv@gmail.com
Subject: Re: [PATCH V1] PCI: designware-ep: Fix DBI access before core init
Message-ID: <20220727221415.GA250151@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220622040133.31058-1-vidyas@nvidia.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 22, 2022 at 09:31:33AM +0530, Vidya Sagar wrote:
> Platforms that cannot support their core initialization without the
> reference clock from the host, implement the feature 'core_init_notifier'
> to indicate the DesignWare sub-system about when their core is getting
> initialized. Any accesses to the core (Ex:- DBI) would result in system
> hang in such systems (Ex:- tegra194). This patch moves any access to the
> core to dw_pcie_ep_init_complete() API which is effectively called only
> after the core initialization.

I assume this is still broken.  I want to fix it.  I assume this patch
fixes it and there are no known problems with it.  I assume this can
be fixed so it works on all platforms, whether they use
core_init_notifier or not.

I'd like the commit log to be specific about where the hang occurs so
it's easy for a non-DesignWare expert (me!) to see the problem.  E.g.,
on tegra194, X depends on Y, but Y is initialized after X.  Say
specifically what functions X and Y are.

> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 88 +++++++++++--------
>  1 file changed, 49 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index 0eda8236c125..9feec720175f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -639,9 +639,14 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>  int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_pcie_ep_func *ep_func;
> +	struct device *dev = pci->dev;
> +	struct pci_epc *epc = ep->epc;
>  	unsigned int offset;
>  	unsigned int nbars;
>  	u8 hdr_type;
> +	u8 func_no;
> +	void *addr;
>  	u32 reg;
>  	int i;
>  
> @@ -654,6 +659,42 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  		return -EIO;
>  	}
>  
> +	dw_pcie_iatu_detect(pci);
> +
> +	ep->ib_window_map = devm_kcalloc(dev,
> +					 BITS_TO_LONGS(pci->num_ib_windows),
> +					 sizeof(long),
> +					 GFP_KERNEL);
> +	if (!ep->ib_window_map)
> +		return -ENOMEM;
> +
> +	ep->ob_window_map = devm_kcalloc(dev,
> +					 BITS_TO_LONGS(pci->num_ob_windows),
> +					 sizeof(long),
> +					 GFP_KERNEL);
> +	if (!ep->ob_window_map)
> +		return -ENOMEM;
> +
> +	addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> +			    GFP_KERNEL);
> +	if (!addr)
> +		return -ENOMEM;
> +	ep->outbound_addr = addr;
> +
> +	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> +		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> +		if (!ep_func)
> +			return -ENOMEM;
> +
> +		ep_func->func_no = func_no;
> +		ep_func->msi_cap = dw_pcie_ep_find_capability(ep, func_no,
> +							      PCI_CAP_ID_MSI);
> +		ep_func->msix_cap = dw_pcie_ep_find_capability(ep, func_no,
> +							       PCI_CAP_ID_MSIX);
> +
> +		list_add_tail(&ep_func->list, &ep->func_list);
> +	}
> +
>  	offset = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_REBAR);
>  
>  	dw_pcie_dbi_ro_wr_en(pci);
> @@ -677,8 +718,6 @@ EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	int ret;
> -	void *addr;
> -	u8 func_no;
>  	struct resource *res;
>  	struct pci_epc *epc;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -686,7 +725,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *np = dev->of_node;
>  	const struct pci_epc_features *epc_features;
> -	struct dw_pcie_ep_func *ep_func;
>  
>  	INIT_LIST_HEAD(&ep->func_list);
>  
> @@ -708,8 +746,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		}
>  	}
>  
> -	dw_pcie_iatu_detect(pci);
> -
>  	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "addr_space");
>  	if (!res)
>  		return -EINVAL;
> @@ -717,26 +753,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	ep->phys_base = res->start;
>  	ep->addr_size = resource_size(res);
>  
> -	ep->ib_window_map = devm_kcalloc(dev,
> -					 BITS_TO_LONGS(pci->num_ib_windows),
> -					 sizeof(long),
> -					 GFP_KERNEL);
> -	if (!ep->ib_window_map)
> -		return -ENOMEM;
> -
> -	ep->ob_window_map = devm_kcalloc(dev,
> -					 BITS_TO_LONGS(pci->num_ob_windows),
> -					 sizeof(long),
> -					 GFP_KERNEL);
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
> @@ -753,20 +769,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> @@ -790,6 +792,14 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  			return 0;
>  	}
>  
> +	/*
> +	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
> +	 * step as platforms that implement 'core_init_notifier' feature may
> +	 * not have the hardware ready (i.e. core initialized) for access
> +	 * (Ex: tegra194). Any hardware access on such platforms result
> +	 * in system hard hang.
> +	 */
> +
>  	return dw_pcie_ep_init_complete(ep);
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_init);
> -- 
> 2.17.1
> 
