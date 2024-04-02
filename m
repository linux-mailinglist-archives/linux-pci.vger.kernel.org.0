Return-Path: <linux-pci+bounces-5507-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B63B1894858
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 02:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B252851CD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Apr 2024 00:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E05C8BF1;
	Tue,  2 Apr 2024 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r8U+TmfV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C049E552;
	Tue,  2 Apr 2024 00:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016864; cv=none; b=uVD6ZIcvthJHanl4oYjAcuXJ5O4F0yqHFbsRGdqANLBnUJVbfHYgvhbVFq8PtPvEtnak/1lB+j7p/T+zRgxDtMAQ11dZW5fXc2TbobDcSDUF5+Ff1TTGIljRsjkYUOBVd12zQ4v2l7ilHs1KCQLbX3f/vA0Dt86yn1kThlTHhCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016864; c=relaxed/simple;
	bh=Y1r6F3EJQCsWu05mdM0m/RL9mp3ue/Gjw8EoC602RYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jrVdWwSyg0NIEBdhzJuSAMade2qdU9pyT0DXlmPAnwJAyVvk6bgbl3wX1gNiprRQHjXfHhjYt4xlZsDRKW7vwNNOFfATz++dpIfDuax644KyGDUj/LhXV7eZ7meknKiG+Xe/msW6dTZwOoAcheTzCilDF6f2LrErOMR4kFQz9gQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r8U+TmfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C150BC433C7;
	Tue,  2 Apr 2024 00:14:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712016863;
	bh=Y1r6F3EJQCsWu05mdM0m/RL9mp3ue/Gjw8EoC602RYY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=r8U+TmfVVZ/2zSi5oYgBiPp1Nb+hWR6CaYSOEjZAKrgo5xp3sg7dK5CwDIdAXk9u4
	 NgiDVNcciDxnNp3IfwVGznTuLSIVWMZjXcXwnbwe4XbOdvjf9DZ9vVzMyteNWp7xY7
	 LL/wzbXs10Tdh0YIV+LpwBP/frBE7VQ47GA0mXwtV1MAwGnwF8E6dVEzviazcWoR7y
	 1U01lgT81ggO+D38aFlgrDbklWzcwvLnnE2G4nRE0qmWtHjAEfnbRB+n6/WNrfYLfA
	 SLvIJ4VeWHIWJ2X+70t4dCEmTbZftXAMpqUWp4u4RScbiqsOhpeXHIMWA0Bk3n7Lnw
	 lDwkj3SGzuY2w==
Message-ID: <45b2db99-2d03-469b-aa37-bc6c63cef141@kernel.org>
Date: Tue, 2 Apr 2024 09:14:20 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/10] PCI: endpoint: Decouple EPC and PCIe bus
 specific events
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Jingoo Han <jingoohan1@gmail.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev,
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
References: <20240401-pci-epf-rework-v2-0-970dbe90b99d@linaro.org>
 <20240401-pci-epf-rework-v2-2-970dbe90b99d@linaro.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20240401-pci-epf-rework-v2-2-970dbe90b99d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/2/24 00:50, Manivannan Sadhasivam wrote:
> Currently, 'struct pci_epc_event_ops' has a bunch of events that are sent
> from the EPC driver to EPF driver. But those events are a mix of EPC
> specific events like core_init and PCIe bus specific events like LINK_UP,
> LINK_DOWN, BME etc...
> 
> Let's decouple them to respective structs (pci_epc_event_ops,
> pci_epc_bus_event_ops) to make the separation clear.

I fail to see the benefits here. The event operation names are quite clear and,
in my opinion, it is clear if an event op applies to the controller or to the
bus/link. If anything, "core_init" could a little more clear, so renaming that
"ep_controller_init" or something like that (clearly spelling out what is being
initialized) seems enough to me. Similarly, the "bme" op name is very criptic.
Renaming that to "bus_master_enable" would go a long way clarifying the code.
For link events, "link_up", "link_down" are clear. So I think there is no need
to split the event op struct like this. Renaming the ops is better.

Note that I am not opposed to this patch, but I think it is just code churn
that does not really bring any fundamental improvement. Regardless, renaming
"core_init" and "bme" ops is I think desired.

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
> index 2c54d80107cf..280863c0eeb9 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -896,8 +896,11 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
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
> @@ -919,7 +922,8 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
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
> index 977fb79c1567..973db0b1bde2 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -798,8 +798,11 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
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
>  
> @@ -916,7 +919,8 @@ static int pci_epf_test_probe(struct pci_epf *epf,
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
> index 47d27ec7439d..f202ae07ffa9 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -692,8 +692,8 @@ void pci_epc_linkup(struct pci_epc *epc)
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
> @@ -718,8 +718,8 @@ void pci_epc_linkdown(struct pci_epc *epc)
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
> @@ -744,8 +744,8 @@ void pci_epc_init_notify(struct pci_epc *epc)
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
> @@ -767,8 +767,8 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
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
> @@ -792,8 +792,8 @@ void pci_epc_bme_notify(struct pci_epc *epc)
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
> index adee6a1b35db..77399fecaeb5 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -69,14 +69,21 @@ struct pci_epf_ops {
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
> @@ -150,7 +157,8 @@ struct pci_epf_bar {
>   * @is_vf: true - virtual function, false - physical function
>   * @vfunction_num_map: bitmap to manage virtual function number
>   * @pci_vepf: list of virtual endpoint functions associated with this function
> - * @event_ops: Callbacks for capturing the EPC events
> + * @epc_event_ops: Callbacks for capturing the EPC events
> + * @bus_event_ops: Callbacks for capturing the PCIe bus events
>   */
>  struct pci_epf {
>  	struct device		dev;
> @@ -180,7 +188,8 @@ struct pci_epf {
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

-- 
Damien Le Moal
Western Digital Research


