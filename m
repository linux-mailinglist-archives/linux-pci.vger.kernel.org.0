Return-Path: <linux-pci+bounces-5005-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDF0887060
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 17:08:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BB9C1F21CFF
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 16:08:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0528D57876;
	Fri, 22 Mar 2024 16:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bFMJ/d/w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C398257864;
	Fri, 22 Mar 2024 16:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123722; cv=none; b=EX2/osSOjAvOQtfPg4sJvyZRy8TGbeuMMA+nOvcpIKZByoFaav5OHTPUBynCnjV8Tfd2WYTSnH1wFpw0zLoK96RTP06KdJo+siHji48Bp2Ymcy41NEyCfwf1baLqEHPCym5nB9SSGnE0kBa3yqIAxeRTSaZYGBfqhdHUFQa3wA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123722; c=relaxed/simple;
	bh=7D2pa9H32Qz3Iw3M80neq+ylTPwXqX7gi3MzqJGAx+s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kP0LtCrrCX8Te94jPXkzYV/Iw51opToSr0WQTOHsvxrNRkTXRGoMdhnRS4E/S9YPoe5RgnTSQNKG0IC2ZNV83X4oo8Q031grYt0tpd82GHuXXdDg3A+4mTWTPOuBUwUFWloIM0tYMzHWa8ZM67b44Ut6BKdW7B6yGBcDXzpbp1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bFMJ/d/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AF4BC433F1;
	Fri, 22 Mar 2024 16:08:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123722;
	bh=7D2pa9H32Qz3Iw3M80neq+ylTPwXqX7gi3MzqJGAx+s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bFMJ/d/wuE6oJ4YfF4HfeRPVIdbe2WALHszRprwyPmQXqeEKngDAOsYFAws/E1PYl
	 0hn3HSlmf4TP+LS4LGlaSpza5XZQ8RLA2eDJGbfnk8dXhMzpc+OLcpY4FYBCeaolAF
	 EI74pjtVQZ0+hGI/Gjrz0lEuhskVCC1WRCu+tc2HxaaIE60Z14hb0gz6X7+/u4vRhR
	 b0vUQA4yFMhKUZZGV/InFl9VzKjdGnoStofhubggLhoi5Y+WwItABqhiuzCuSKFQRb
	 T1XhCz3vBOHFY77/Xndyti4PwVmSLIbipoZmdgltII5qcbJCl4cMX3YK9j4Tr0uIUV
	 LzLo5FUE+rGWA==
Date: Fri, 22 Mar 2024 17:08:36 +0100
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
Subject: Re: [PATCH 02/11] PCI: endpoint: Decouple EPC and PCIe bus specific
 events
Message-ID: <Zf2tBNctPpIrHeWA@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-2-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-2-6134e6c1d491@linaro.org>

On Thu, Mar 14, 2024 at 08:53:41PM +0530, Manivannan Sadhasivam wrote:
> Currently, 'struct pci_epc_event_ops' has a bunch of events that are sent
> from the EPC driver to EPF driver. But those events are a mix of EPC
> specific events like core_init and PCIe bus specific events like LINK_UP,
> LINK_DOWN, BME etc...
> 
> Let's decouple them to respective structs (pci_epc_event_ops,
> pci_epc_bus_event_ops) to make the separation clear.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  8 ++++++--
>  drivers/pci/endpoint/functions/pci-epf-test.c |  8 ++++++--
>  drivers/pci/endpoint/pci-epc-core.c           | 20 ++++++++++----------
>  include/linux/pci-epf.h                       | 23 ++++++++++++++++-------
>  4 files changed, 38 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index 1c3e4ea76bd2..e5d67aec7574 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -880,8 +880,11 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
>  	pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no, epf_bar);
>  }
>  
> -static const struct pci_epc_event_ops pci_epf_mhi_event_ops = {
> +static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
>  	.core_init = pci_epf_mhi_core_init,
> +};
> +
> +static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
>  	.link_up = pci_epf_mhi_link_up,
>  	.link_down = pci_epf_mhi_link_down,
>  	.bme = pci_epf_mhi_bme,
> @@ -903,7 +906,8 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
>  	epf_mhi->info = info;
>  	epf_mhi->epf = epf;
>  
> -	epf->event_ops = &pci_epf_mhi_event_ops;
> +	epf->epc_event_ops = &pci_epf_mhi_epc_event_ops;
> +	epf->bus_event_ops = &pci_epf_mhi_bus_event_ops;
>  
>  	mutex_init(&epf_mhi->lock);
>  
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index fc0282b0d626..751dab5799d5 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -813,8 +813,11 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
>  	return 0;
>  }
>  
> -static const struct pci_epc_event_ops pci_epf_test_event_ops = {
> +static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
>  	.core_init = pci_epf_test_core_init,
> +};
> +
> +static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
>  	.link_up = pci_epf_test_link_up,
>  };

I'm not a big fan of every EPF driver now needing two different
static const struct pci_*_event_ops.

Is really:
static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
	.core_init = pci_epf_test_core_init,
};

static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
	.link_up = pci_epf_test_link_up,
};


Better than:
static const struct pci_epc_event_ops pci_epf_test_event_ops = {
	.core_init = pci_epf_test_core_init,
	.link_up = pci_epf_test_link_up,
}

The callbacks should have sufficiently distinct names that it is obvious
what it is happening?

Link up is that the EPC driver tells me that it is link up.
Init is that the EPF function should initialize the BARs etc.

I'm not saying that I'm totally against this, but I'm not sure that there
are so many EPC callbacks that this is needed?

How many will there be after this series?
Four? .init, .deinit, .link_up, .link_down ?

I would vote to keep all callbacks in the same struct for now,
but you are the maintainer.


>  
> @@ -959,7 +962,8 @@ static int pci_epf_test_probe(struct pci_epf *epf,
>  
>  	INIT_DELAYED_WORK(&epf_test->cmd_handler, pci_epf_test_cmd_handler);
>  
> -	epf->event_ops = &pci_epf_test_event_ops;
> +	epf->epc_event_ops = &pci_epf_test_epc_event_ops;
> +	epf->bus_event_ops = &pci_epf_test_bus_event_ops;
>  
>  	epf_set_drvdata(epf, epf_test);
>  	return 0;
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index ba2ff037dfa6..f602f08a11a2 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -697,8 +697,8 @@ void pci_epc_linkup(struct pci_epc *epc)
>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {
>  		mutex_lock(&epf->lock);
> -		if (epf->event_ops && epf->event_ops->link_up)
> -			epf->event_ops->link_up(epf);
> +		if (epf->bus_event_ops && epf->bus_event_ops->link_up)
> +			epf->bus_event_ops->link_up(epf);
>  		mutex_unlock(&epf->lock);
>  	}
>  	mutex_unlock(&epc->list_lock);
> @@ -723,8 +723,8 @@ void pci_epc_linkdown(struct pci_epc *epc)
>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {
>  		mutex_lock(&epf->lock);
> -		if (epf->event_ops && epf->event_ops->link_down)
> -			epf->event_ops->link_down(epf);
> +		if (epf->bus_event_ops && epf->bus_event_ops->link_down)
> +			epf->bus_event_ops->link_down(epf);
>  		mutex_unlock(&epf->lock);
>  	}
>  	mutex_unlock(&epc->list_lock);
> @@ -749,8 +749,8 @@ void pci_epc_init_notify(struct pci_epc *epc)
>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {
>  		mutex_lock(&epf->lock);
> -		if (epf->event_ops && epf->event_ops->core_init)
> -			epf->event_ops->core_init(epf);
> +		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
> +			epf->epc_event_ops->core_init(epf);
>  		mutex_unlock(&epf->lock);
>  	}
>  	epc->init_complete = true;
> @@ -772,8 +772,8 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
>  {
>  	if (epc->init_complete) {
>  		mutex_lock(&epf->lock);
> -		if (epf->event_ops && epf->event_ops->core_init)
> -			epf->event_ops->core_init(epf);
> +		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
> +			epf->epc_event_ops->core_init(epf);
>  		mutex_unlock(&epf->lock);
>  	}
>  }
> @@ -797,8 +797,8 @@ void pci_epc_bme_notify(struct pci_epc *epc)
>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {
>  		mutex_lock(&epf->lock);
> -		if (epf->event_ops && epf->event_ops->bme)
> -			epf->event_ops->bme(epf);
> +		if (epf->bus_event_ops && epf->bus_event_ops->bme)
> +			epf->bus_event_ops->bme(epf);
>  		mutex_unlock(&epf->lock);
>  	}
>  	mutex_unlock(&epc->list_lock);
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 77b146e0f672..1271e1e00bbd 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -68,14 +68,21 @@ struct pci_epf_ops {
>  };
>  
>  /**
> - * struct pci_epc_event_ops - Callbacks for capturing the EPC events
> - * @core_init: Callback for the EPC initialization complete event
> - * @link_up: Callback for the EPC link up event
> - * @link_down: Callback for the EPC link down event
> - * @bme: Callback for the EPC BME (Bus Master Enable) event
> + * struct pci_epc_event_ops - Callbacks for capturing the EPC specific events
> + * @core_init: Callback for the EPC initialization event
>   */
>  struct pci_epc_event_ops {
>  	int (*core_init)(struct pci_epf *epf);
> +};
> +
> +/**
> + * struct pci_epc_bus_event_ops - Callbacks for capturing the PCIe bus specific
> + *                               events
> + * @link_up: Callback for the PCIe bus link up event
> + * @link_down: Callback for the PCIe bus link down event
> + * @bme: Callback for the PCIe bus BME (Bus Master Enable) event
> + */
> +struct pci_epc_bus_event_ops {
>  	int (*link_up)(struct pci_epf *epf);
>  	int (*link_down)(struct pci_epf *epf);
>  	int (*bme)(struct pci_epf *epf);
> @@ -149,7 +156,8 @@ struct pci_epf_bar {
>   * @is_vf: true - virtual function, false - physical function
>   * @vfunction_num_map: bitmap to manage virtual function number
>   * @pci_vepf: list of virtual endpoint functions associated with this function
> - * @event_ops: Callbacks for capturing the EPC events
> + * @epc_event_ops: Callbacks for capturing the EPC events
> + * @bus_event_ops: Callbacks for capturing the PCIe bus events
>   */
>  struct pci_epf {
>  	struct device		dev;
> @@ -179,7 +187,8 @@ struct pci_epf {
>  	unsigned int		is_vf;
>  	unsigned long		vfunction_num_map;
>  	struct list_head	pci_vepf;
> -	const struct pci_epc_event_ops *event_ops;
> +	const struct pci_epc_event_ops *epc_event_ops;
> +	const struct pci_epc_bus_event_ops *bus_event_ops;
>  };
>  
>  /**
> 
> -- 
> 2.25.1
> 

