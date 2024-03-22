Return-Path: <linux-pci+bounces-5006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E074C887064
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 17:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 988C4284778
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 16:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE13F5917D;
	Fri, 22 Mar 2024 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fTyOcE6g"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA49959141;
	Fri, 22 Mar 2024 16:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123736; cv=none; b=aGuYt6SlKqwv4J4zGxoXPWVdl9+bhsdJWg2yA5WFdOaIaZnRZJFdjcvFM9DRgRSUaUOh+zulSjFNQrkss0HSqbXsBlrFIwMuF/xPukEbv7J8De1C6qULrLWfOiu/bGloy4biODUsf7opEBrCn8yGU+VfCoTn//0mRb9lj0oaAyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123736; c=relaxed/simple;
	bh=NJSaAPZZAkhKyCqNhnwgX+0l4XkKuAlLXi79oYjiF9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DDzplVr8U+v1+3ocEYxoa/C0RFeP1NmOEPmk2etoVQ9wWPR1W6Pg2cslpzXdAlP+dRIy4XLsAFKOVXjhM8p88zWbP56meHPsMID4bTwR+KrxFUUQkIvZ99riPs5gCGDi3CVBRExFQQXdrs4MJChiHJsX7JHKOg+YQ2Lf2Z7KvWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fTyOcE6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F13C433C7;
	Fri, 22 Mar 2024 16:08:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123736;
	bh=NJSaAPZZAkhKyCqNhnwgX+0l4XkKuAlLXi79oYjiF9s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fTyOcE6ge2SqZ3spKyMzoifTLhx/SG9ODWSnXEsev1oe2A6WmsFWuEUpClZ9M4aC7
	 2wBpDLzFtlOMQh7o6cUD3B2Cbn8k/y22YLzU0DVsPpZWyeMIl6ieYmtuWxggfoOV+X
	 /a4+V/QwjN2sGS3ZdhyJUk03StQMln+IQrhc7NZXW6ir7SBdOup9C4mz8xIclH2ftp
	 /yJFI9pfbnE3cFQK2eQ953CMIqjkfy6VkL9jHuueH7NSOmnIrFd+9VzZ6+k5QukCg7
	 B7B3Gz8riUcqKDuZ27DbXJghTYonvWzaavsfHfaEU2x7b7/tsgB2ZmSTiwX9cS2XzF
	 Ivza23Of7irqg==
Date: Fri, 22 Mar 2024 17:08:48 +0100
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
Subject: Re: [PATCH 03/11] PCI: endpoint: Rename core_init() callback in
 'struct pci_epc_event_ops' to init()
Message-ID: <Zf2tEM1ueugQyJfK@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-3-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-3-6134e6c1d491@linaro.org>

On Thu, Mar 14, 2024 at 08:53:42PM +0530, Manivannan Sadhasivam wrote:
> core_init() callback is used to notify the EPC initialization event to the
> EPF drivers. The 'core' prefix was used indicate that the controller IP
> core has completed initialization. But it serves no purpose as the EPF
> driver will only care about the EPC initialization as a whole and there is
> no real benefit to distinguish the IP core part.
> 
> So let's rename the core_init() callback in 'struct pci_epc_event_ops' to
> just init() to make it more clear.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-mhi.c  |  4 ++--
>  drivers/pci/endpoint/functions/pci-epf-test.c |  4 ++--
>  drivers/pci/endpoint/pci-epc-core.c           | 16 ++++++++--------
>  include/linux/pci-epf.h                       |  4 ++--
>  4 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> index e5d67aec7574..da894a9a447e 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
> @@ -700,7 +700,7 @@ static void pci_epf_mhi_dma_deinit(struct pci_epf_mhi *epf_mhi)
>  	epf_mhi->dma_chan_rx = NULL;
>  }
>  
> -static int pci_epf_mhi_core_init(struct pci_epf *epf)
> +static int pci_epf_mhi_epc_init(struct pci_epf *epf)
>  {
>  	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
>  	const struct pci_epf_mhi_ep_info *info = epf_mhi->info;
> @@ -881,7 +881,7 @@ static void pci_epf_mhi_unbind(struct pci_epf *epf)
>  }
>  
>  static const struct pci_epc_event_ops pci_epf_mhi_epc_event_ops = {
> -	.core_init = pci_epf_mhi_core_init,
> +	.init = pci_epf_mhi_epc_init,
>  };
>  
>  static const struct pci_epc_bus_event_ops pci_epf_mhi_bus_event_ops = {
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 751dab5799d5..1dae0fce8fc4 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -746,7 +746,7 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  	return 0;
>  }
>  
> -static int pci_epf_test_core_init(struct pci_epf *epf)
> +static int pci_epf_test_epc_init(struct pci_epf *epf)

Why have _epc_ init in the name at all?

Isn't
static int pci_epf_test_init(struct pci_epf *epf)

Enough?

From my perspective, it is the EPF that is initializing
(by configuring the BARS according to it's liking),
not the EPC initializing.


>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
>  	struct pci_epf_header *header = epf->header;
> @@ -814,7 +814,7 @@ static int pci_epf_test_link_up(struct pci_epf *epf)
>  }
>  
>  static const struct pci_epc_event_ops pci_epf_test_epc_event_ops = {
> -	.core_init = pci_epf_test_core_init,
> +	.init = pci_epf_test_epc_init,
>  };
>  
>  static const struct pci_epc_bus_event_ops pci_epf_test_bus_event_ops = {
> diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
> index f602f08a11a2..5a522b2842e2 100644
> --- a/drivers/pci/endpoint/pci-epc-core.c
> +++ b/drivers/pci/endpoint/pci-epc-core.c
> @@ -732,9 +732,9 @@ void pci_epc_linkdown(struct pci_epc *epc)
>  EXPORT_SYMBOL_GPL(pci_epc_linkdown);
>  
>  /**
> - * pci_epc_init_notify() - Notify the EPF device that EPC device's core
> - *			   initialization is completed.
> - * @epc: the EPC device whose core initialization is completed
> + * pci_epc_init_notify() - Notify the EPF device that EPC device initialization
> + *                         is completed.
> + * @epc: the EPC device whose initialization is completed
>   *
>   * Invoke to Notify the EPF device that the EPC device's initialization
>   * is completed.
> @@ -749,8 +749,8 @@ void pci_epc_init_notify(struct pci_epc *epc)
>  	mutex_lock(&epc->list_lock);
>  	list_for_each_entry(epf, &epc->pci_epf, list) {
>  		mutex_lock(&epf->lock);
> -		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
> -			epf->epc_event_ops->core_init(epf);
> +		if (epf->epc_event_ops && epf->epc_event_ops->init)
> +			epf->epc_event_ops->init(epf);
>  		mutex_unlock(&epf->lock);
>  	}
>  	epc->init_complete = true;
> @@ -761,7 +761,7 @@ EXPORT_SYMBOL_GPL(pci_epc_init_notify);
>  /**
>   * pci_epc_notify_pending_init() - Notify the pending EPC device initialization
>   *                                 complete to the EPF device
> - * @epc: the EPC device whose core initialization is pending to be notified
> + * @epc: the EPC device whose initialization is pending to be notified
>   * @epf: the EPF device to be notified
>   *
>   * Invoke to notify the pending EPC device initialization complete to the EPF
> @@ -772,8 +772,8 @@ void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
>  {
>  	if (epc->init_complete) {
>  		mutex_lock(&epf->lock);
> -		if (epf->epc_event_ops && epf->epc_event_ops->core_init)
> -			epf->epc_event_ops->core_init(epf);
> +		if (epf->epc_event_ops && epf->epc_event_ops->init)
> +			epf->epc_event_ops->init(epf);
>  		mutex_unlock(&epf->lock);
>  	}
>  }
> diff --git a/include/linux/pci-epf.h b/include/linux/pci-epf.h
> index 1271e1e00bbd..ff8304e72f8e 100644
> --- a/include/linux/pci-epf.h
> +++ b/include/linux/pci-epf.h
> @@ -69,10 +69,10 @@ struct pci_epf_ops {
>  
>  /**
>   * struct pci_epc_event_ops - Callbacks for capturing the EPC specific events
> - * @core_init: Callback for the EPC initialization event
> + * @init: Callback for the EPC initialization event
>   */
>  struct pci_epc_event_ops {
> -	int (*core_init)(struct pci_epf *epf);
> +	int (*init)(struct pci_epf *epf);
>  };
>  
>  /**
> 
> -- 
> 2.25.1
> 

