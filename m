Return-Path: <linux-pci+bounces-5009-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35568887084
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 17:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 59F2A1C22934
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 16:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8425D479;
	Fri, 22 Mar 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJAm7J5V"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1A59172;
	Fri, 22 Mar 2024 16:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123823; cv=none; b=ZlEyQUmZcwA0EkRdF1k50WfCK2uJ4ljklSstiZzmGGkYjB3CdVX1EiBQLd43NwbQU+ty6qNqVJAl8bWT9sCZcl1X4cBF8Kh6NZDwhtsuPiVpoLiPnjp/kUIi3I5v1dsqgaWoa8TUf6MuKA69XAGwom8pkzGjnjrpLX0TO2p4PXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123823; c=relaxed/simple;
	bh=HLPSF2CYw+2KCiiXv6RgASB61m42ZaPizZdDcizknVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UfVLOSATtfeXeOmHpUg8zoKdrx64oZASmE4lFpUR4ge+DrO2C35gKi2I3DTNuj+jHpvTAaTPgBnBAWhyrHYNWF7vIkuTpV7uouThfDjAkrAQS6LBU0M5tmB5bqq3Rvb6yBJPf376c7vd67Bf15oy0O/FxqT4ESFD6hQ4iFQjoJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJAm7J5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFF8C43399;
	Fri, 22 Mar 2024 16:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123823;
	bh=HLPSF2CYw+2KCiiXv6RgASB61m42ZaPizZdDcizknVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QJAm7J5VXbOfMIzchtPni0yAiWf3034aearnbNdn2/V0/MUEJSHcVb+Gobw6ErhTY
	 1t9sy4R4cQVBwVBf05qn/KEq3SoF5nPUke5n5pXzbs2oswSgm7mnVkjvX4roBqyvD7
	 enMdnfcuI5zPck3ROAEEVi9GfdYaxQ6siaPtdb5uh3Xp0b/IvWq/SRcJZf6nBxdzF0
	 wD1uJOKIgrrv8lbWprYRAwcO0R8DZnrYHYqBjvfZWvaCZ/B02hQfYsCt/Kj7tRMFSs
	 42L7lSae/T79Dk+XjQcbmFDdH2HWODecUIs5/xzocHQdattWMo4dt12O/1UAJVFLXn
	 D9d3irWVcBy3g==
Date: Fri, 22 Mar 2024 17:10:17 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: Re: [PATCH 06/11] PCI: endpoint: Introduce EPC 'deinit' event and
 notify the EPF drivers
Message-ID: <Zf2taTZH7rEmsXKe@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-6-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-6-6134e6c1d491@linaro.org>

On Thu, Mar 14, 2024 at 08:53:45PM +0530, Manivannan Sadhasivam wrote:
> As like the EPC 'init' event, that is used to signal the EPF drivers about
> the EPC initialization, let's introduce 'deinit' event that is used to
> signal EPC deinitialization.
> 
> The EPC deinitialization applies only when any sort of fundamental reset
> is supported by the endpoint controller as per the PCIe spec.
> 
> Reference: PCIe Base spec v5.0, sections 4.2.4.9.1 and 6.6.1.
> 
> Currently, some EPC drivers like pcie-qcom-ep and pcie-tegra194 support
> PERST# as the fundamental reset. So the 'deinit' event will be notified to
> the EPF drivers when PERST# assert happens in the above mentioned EPC
> drivers.
> 
> The EPF drivers, on receiving the event through the deinit() callback
> should reset the EPF state machine and also cleanup any configuration that
> got affected by the fundamental reset like BAR, DMA etc...
> 
> This change also warrants skipping the cleanups in unbind() if already done
> in deinit().
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/controller/dwc/pcie-qcom-ep.c     |  1 +
>  drivers/pci/controller/dwc/pcie-tegra194.c    |  1 +
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  | 19 +++++++++++++++++++
>  drivers/pci/endpoint/functions/pci-epf-test.c | 17 +++++++++++++++--
>  drivers/pci/endpoint/pci-epc-core.c           | 25 +++++++++++++++++++++++++
>  include/linux/pci-epc.h                       |  1 +
>  include/linux/pci-epf.h                       |  2 ++
>  7 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> index 50b1635e3cbb..e4b742355d57 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> @@ -501,6 +501,7 @@ static void qcom_pcie_perst_assert(struct dw_pcie *pci)
>  {
>  	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
>  
> +	pci_epc_deinit_notify(pci->ep.epc);

Why not just move pci_epc_deinit_notify() in to dw_pcie_ep_cleanup() ?
(So that we don't need to add pci_epc_deinit_notify() to all EPC drivers
with PERST?)

Regardless:
Reviewed-by: Niklas Cassel <cassel@kernel.org>

>  	dw_pcie_ep_cleanup(&pci->ep);
>  	qcom_pcie_disable_resources(pcie_ep);
>  	pcie_ep->link_status = QCOM_PCIE_EP_LINK_DISABLED;
> diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
> index e02deb31a72d..3e6e08b321fb 100644
> --- a/drivers/pci/controller/dwc/pcie-tegra194.c
> +++ b/drivers/pci/controller/dwc/pcie-tegra194.c
> @@ -1715,6 +1715,7 @@ static void pex_ep_event_pex_rst_assert(struct tegra_pcie_dw *pcie)
>  	if (ret)
>  		dev_err(pcie->dev, "Failed to go Detect state: %d\n", ret);
>  
> +	pci_epc_deinit_notify(pcie->pci.ep.epc);
>  	dw_pcie_ep_cleanup(&pcie->pci.ep);
>  
>  	reset_control_assert(pcie->core_rst);
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 4e4300efd9d7..83de96119718 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -748,6 +748,24 @@ static int pci_epf_mhi_epc_init(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static void pci_epf_mhi_epc_deinit(struct pci_epf *epf)
> +{
> +	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> +	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
> +	struct pci_epf_bar *epf_bar = &epf->bar[info->bar_num];
> +	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
> +	struct pci_epc *epc = epf->epc;
> +
> +	if (mhi_cntrl->mhi_dev) {
> +		mhi_ep_power_down(mhi_cntrl);
> +		if (info->flags & MHI_EPF_USE_DMA)
> +			pci_epf_mhi_dma_deinit(epf_mhi);
> +		mhi_ep_unregister_controller(mhi_cntrl);
> +	}
> +
> +	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
> +}
> +
>  static int pci_epf_mhi_link_up(struct pci_epf *epf)
>  {
>  	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
> @@ -882,6 +900,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
>  
>  static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
>  	.init = pci_epf_mhi_epc_init,
> +	.deinit = pci_epf_mhi_epc_deinit,
>  };
>  
>  static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 8f1e0cb08814..84cd47ebac22 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -804,6 +804,15 @@ static int pci_epf_test_epc_init(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static void pci_epf_test_epc_deinit(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +
> +	cancel_delayed_work(&epf_test->cmd_handler);
> +	pci_epf_test_clean_dma_chan(epf_test);
> +	pci_epf_test_clear_bar(epf);
> +}
> +
>  static int pci_epf_test_link_up(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> @@ -816,6 +825,7 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
>  
>  static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
>  	.init = pci_epf_test_epc_init,
> +	.deinit = pci_epf_test_epc_deinit,
>  };
>  
>  static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
> @@ -954,10 +964,13 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  static void pci_epf_test_unbind(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	struct pci_epc *epc = epf->epc;
>  
>  	cancel_delayed_work(&epf_test->cmd_handler);
> -	pci_epf_test_clean_dma_chan(epf_test);
> -	pci_epf_test_clear_bar(epf);
> +	if (epc->init_complete) {
> +		pci_epf_test_clean_dma_chan(epf_test);
> +		pci_epf_test_clear_bar(epf);
> +	}
>  	pci_epf_test_free_space(epf);
>  }
>  
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index 5a522b2842e2..26378a9a56a7 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -779,6 +779,31 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
>  }
>  EXPORT_SYMBOL_GPL(pci_epc_notify_pending_init);
>  
> +/**
> + * pci_epc_deinit_notify() - Notify the EPF device about EPC deinitialization
> + * @epc: the EPC device whose deinitialization is completed
> + *
> + * Invoke to notify the EPF device that the EPC deinitialization is completed.
> + */
> +void pci_epc_deinit_notify(struct pci_epc *epc)
> +{
> +	struct pci_epf *epf;
> +
> +	if (IS_ERR_OR_NULL(epc))
> +		return;
> +
> +	mutex_lock(&epc->list_lock);
> +	list_for_each_entry(epf, &epc->pci_epf, list) {
> +		mutex_lock(&epf->lock);
> +		if (epf->epc_event_ops && epf->epc_event_ops->deinit)
> +			epf->epc_event_ops->deinit(epf);
> +		mutex_unlock(&epf->lock);
> +	}
> +	epc->init_complete = false;
> +	mutex_unlock(&epc->list_lock);
> +}
> +EXPORT_SYMBOL_GPL(pci_epc_deinit_notify);
> +
>  /**
>   * pci_epc_bme_notify() - Notify the EPF device that the EPC device has received
>   *			  the BME event from the Root complex
> diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
> index adee6dbe4e45..976b2212e872 100644
> --- a/include/linux/pci-epc.h
> +++ b/include/linux/pci-epc.h
> @@ -199,6 +199,7 @@ void pci_epc_linkup(struct pci_epc *epc);
>  void pci_epc_linkdown(struct pci_epc *epc);
>  void pci_epc_init_notify(struct pci_epc *epc);
>  void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf);
> +void pci_epc_deinit_notify(struct pci_epc *epc);
>  void pci_epc_bme_notify(struct pci_epc *epc);
>  void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
>  			enum pci_epc_interface_type type);
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index ff8304e72f8e..52f69eaf505d 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -70,9 +70,11 @@ struct pci_epf_ops {
>  /**
>   * struct pci_epc_event_ops - Callbacks for capturing the EPC specific events
>   * @init: Callback for the EPC initialization event
> + * @deinit: Callback for the EPC deinitialization event
>   */
>  struct pci_epc_event_ops {
>  	int (*init)(struct pci_epf *epf);
> +	void (*deinit)(struct pci_epf *epf);
>  };
>  
>  /**
> 
> -- 
> 2.25.1
> 

