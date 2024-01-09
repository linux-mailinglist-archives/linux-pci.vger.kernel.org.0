Return-Path: <linux-pci+bounces-1952-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B5828EC7
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 22:12:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 190B628855C
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jan 2024 21:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 737E23D998;
	Tue,  9 Jan 2024 21:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fGEs0gv9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE473DB80;
	Tue,  9 Jan 2024 21:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79DC5C433F1;
	Tue,  9 Jan 2024 21:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704834761;
	bh=/1JVvDw9mHJfxdMUncKAv49a/9s2ZRSG6BYC39Uwf+M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fGEs0gv9cE2gdPAjk5hapaD5iivC8oZR5fDb3nKQaq/ZgMMUUjdVZni1o4LYPOx+p
	 GNtKmhoVJ+WjyvT9FgLl+wZueRTMsnkaWL0XaYVoBvY9GyCmwKW0y6vSEvAiXsir6i
	 lRhGi2Cb7eAsYvt9pXOpKXNsPGAvQl4CgZI4oqhm1W5iRDBcHs/KgskqIOolvMuH9L
	 tWydErzFRS21lQDPO6dy2ydcuI/YJYO9SMg2VRai9N+FzstnP0Lpg/oXSotQUIIUZ0
	 u2OeLxGjDBIHl07LNaI/IcV22T+EP7vN7Zz3MWUs4E+v79CqiCwDUqDg8X9acOgAd/
	 wX7PLjBLBUVOQ==
Date: Tue, 9 Jan 2024 15:12:39 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
	lpieralisi@kernel.org, robh@kernel.org, kw@linux.com,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
	quic_bjorande@quicinc.com, fancer.lancer@gmail.com,
	vidyas@nvidia.com
Subject: Re: [PATCH v7 1/2] PCI: designware-ep: Fix DBI access before core
 init
Message-ID: <20240109211239.GA2016581@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120084014.108274-2-manivannan.sadhasivam@linaro.org>

It doesn't look to me like the issues raised by Niklas have really
been resolved:

  https://lore.kernel.org/r/ZWYmX8Y%2F7Q9WMxES@x1-carbon/
  https://lore.kernel.org/r/ZZ2JXMhdOI1Upabx@x1-carbon

so I'm doubtful that we should apply this as-is.  The spurious
/sys/class/dma/ stuff and debugfs warnings sound like things that will
annoy users.

Apart from that, this patch has been floating around a long time, but
I still think this solution is hard to maintain for the same reasons I
mentioned here:
https://lore.kernel.org/linux-pci/20220919224014.GA1030798@bhelgaas/

On Mon, Nov 20, 2023 at 02:10:13PM +0530, Manivannan Sadhasivam wrote:
> The drivers for platforms requiring reference clock from the PCIe host for
> initializing their PCIe EP core, make use of the 'core_init_notifier'
> feature exposed by the DWC common code. On these platforms, access to the
> hw registers like DBI before completing the core initialization will result
> in a whole system hang. But the current DWC EP driver tries to access DBI
> registers during dw_pcie_ep_init() without waiting for core initialization
> and it results in system hang on platforms making use of
> 'core_init_notifier' such as Tegra194 and Qcom SM8450.

I see that only qcom_pcie_epc_features and tegra_pcie_epc_features
*set* "core_init_notifier", but all platforms use it because it's only
tested in dw_pcie_ep_init() (and a test case), which is generic to all
DWC drivers.

"core_init_notifier" is not a notifier.  From reading the code, it
only means "if this is set, skip the rest of dw_pcie_ep_init()".

Based on the code, I assume it implies that drivers that set
core_init_notifier must do some additional initialization or
something, but that initialization isn't connected here.

There should be some symbol, maybe a member of pci_epc_features, that
both *does* this initialization and *tells us* that the driver needs
this initialization.

Right now, I think it's something like:

  1) this driver sets core_init_notifier
  2) that must mean that it also calls dw_pcie_ep_init_notify() somewhere
  3) we must avoid DBI access until it does

There's nothing that directly connects those three things.

> To workaround this issue, users of the above mentioned platforms have to
> maintain the dependency with the PCIe host by booting the PCIe EP after
> host boot. But this won't provide a good user experience, since PCIe EP is
> _one_ of the features of those platforms and it doesn't make sense to
> delay the whole platform booting due to the PCIe dependency.

IIUC, "have to maintain the dependency" refers to the situation
*before* this patch, right?  This patch improves the user experience
by removing the need for users to enforce this "boot host before EP"
ordering?

> So to fix this issue, let's move all the DBI access during
> dw_pcie_ep_init() in the DWC EP driver to the dw_pcie_ep_init_complete()
> API that gets called only after core initialization on these platforms.
> This makes sure that the DBI register accesses are skipped during
> dw_pcie_ep_init() and accessed later once the core initialization happens.

This patch doesn't "skip" them in dw_pcie_ep_init(); it *moves* them
completely to dw_pcie_ep_late_init() and calls that from the end of
dw_pcie_ep_init().

> For the rest of the platforms, DBI access happens as usual.

I don't really understand what "as usual" means here.  I guess it just
means "if the driver doesn't set 'core_init_notifier', nothing
changes"?  I would at least make it specific to make it clear that
"rest of the platforms" means "those that don't set
core_init_notifier".

> Co-developed-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Vidya Sagar <vidyas@nvidia.com>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  .../pci/controller/dwc/pcie-designware-ep.c   | 139 ++++++++++++------
>  1 file changed, 91 insertions(+), 48 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> index f6207989fc6a..b1c79cd8e25f 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> @@ -662,14 +662,19 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
>  	return 0;
>  }
>  
> -int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> +static int dw_pcie_ep_late_init(struct dw_pcie_ep *ep)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> +	struct dw_pcie_ep_func *ep_func;
> +	struct device *dev = pci->dev;
> +	struct pci_epc *epc = ep->epc;
>  	unsigned int offset, ptm_cap_base;
>  	unsigned int nbars;
>  	u8 hdr_type;
> +	u8 func_no;
> +	int i, ret;
> +	void *addr;
>  	u32 reg;
> -	int i;
>  
>  	hdr_type = dw_pcie_readb_dbi(pci, PCI_HEADER_TYPE) &
>  		   PCI_HEADER_TYPE_MASK;
> @@ -680,6 +685,55 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  		return -EIO;
>  	}
>  
> +	dw_pcie_version_detect(pci);
> +
> +	dw_pcie_iatu_detect(pci);
> +
> +	ret = dw_pcie_edma_detect(pci);
> +	if (ret)
> +		return ret;
> +
> +	if (!ep->ib_window_map) {
> +		ep->ib_window_map = devm_bitmap_zalloc(dev, pci->num_ib_windows,
> +						       GFP_KERNEL);
> +		if (!ep->ib_window_map)
> +			goto err_remove_edma;
> +	}
> +
> +	if (!ep->ob_window_map) {
> +		ep->ob_window_map = devm_bitmap_zalloc(dev, pci->num_ob_windows,
> +						       GFP_KERNEL);
> +		if (!ep->ob_window_map)
> +			goto err_remove_edma;
> +	}
> +
> +	if (!ep->outbound_addr) {
> +		addr = devm_kcalloc(dev, pci->num_ob_windows, sizeof(phys_addr_t),
> +				    GFP_KERNEL);
> +		if (!addr)
> +			goto err_remove_edma;
> +		ep->outbound_addr = addr;
> +	}
> +
> +	for (func_no = 0; func_no < epc->max_functions; func_no++) {
> +
> +		ep_func = dw_pcie_ep_get_func_from_ep(ep, func_no);
> +		if (ep_func)
> +			continue;
> +
> +		ep_func = devm_kzalloc(dev, sizeof(*ep_func), GFP_KERNEL);
> +		if (!ep_func)
> +			goto err_remove_edma;
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
>  	ptm_cap_base = dw_pcie_ep_find_ext_capability(pci, PCI_EXT_CAP_ID_PTM);
>  
> @@ -714,14 +768,38 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
>  	dw_pcie_dbi_ro_wr_dis(pci);
>  
>  	return 0;
> +
> +err_remove_edma:
> +	dw_pcie_edma_remove(pci);
> +
> +	return ret;
> +}
> +
> +int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
> +{
> +	struct pci_epc *epc = ep->epc;
> +	int ret;
> +
> +	ret = dw_pcie_ep_late_init(ep);
> +	if (ret)
> +		goto err_cleanup;
> +
> +	return 0;
> +
> +err_cleanup:
> +	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
> +			      epc->mem->window.page_size);
> +	pci_epc_mem_exit(epc);
> +	if (ep->ops->deinit)
> +		ep->ops->deinit(ep);
> +
> +	return ret;
>  }
>  EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
>  
>  int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  {
>  	int ret;
> -	void *addr;
> -	u8 func_no;
>  	struct resource *res;
>  	struct pci_epc *epc;
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> @@ -729,7 +807,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *np = dev->of_node;
>  	const struct pci_epc_features *epc_features;
> -	struct dw_pcie_ep_func *ep_func;
>  
>  	INIT_LIST_HEAD(&ep->func_list);
>  
> @@ -747,26 +824,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  	if (ep->ops->pre_init)
>  		ep->ops->pre_init(ep);
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
>  	epc = devm_pci_epc_create(dev, &epc_ops);
>  	if (IS_ERR(epc)) {
>  		dev_err(dev, "Failed to create epc device\n");
> @@ -780,20 +837,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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
> @@ -812,25 +855,25 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
>  		goto err_exit_epc_mem;
>  	}
>  
> -	ret = dw_pcie_edma_detect(pci);
> -	if (ret)
> -		goto err_free_epc_mem;
> -
>  	if (ep->ops->get_features) {
>  		epc_features = ep->ops->get_features(ep);
>  		if (epc_features->core_init_notifier)
>  			return 0;
>  	}
>  
> -	ret = dw_pcie_ep_init_complete(ep);
> +	/*
> +	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
> +	 * step as platforms that implement 'core_init_notifier' feature may
> +	 * not have the hardware ready (i.e. core initialized) for access
> +	 * (Ex: tegra194). Any hardware access on such platforms result
> +	 * in system hang.

What specifically does "before this step" refer to?  I think the
intent is that it's something to do with "core_init_notifier", but
there's no *direct* connection because there's no test of
core_init_notifier except here and the test case.

> +	ret = dw_pcie_ep_late_init(ep);
>  	if (ret)
> -		goto err_remove_edma;
> +		goto err_free_epc_mem;
>  
>  	return 0;
>  
> -err_remove_edma:
> -	dw_pcie_edma_remove(pci);
> -
>  err_free_epc_mem:
>  	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
>  			      epc->mem->window.page_size);
> -- 
> 2.25.1
> 

