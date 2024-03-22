Return-Path: <linux-pci+bounces-5007-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 719AD887067
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 17:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 273472843F8
	for <lists+linux-pci@lfdr.de>; Fri, 22 Mar 2024 16:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20CAA57312;
	Fri, 22 Mar 2024 16:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fa2YsZns"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BC659B43;
	Fri, 22 Mar 2024 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123750; cv=none; b=h8fZsUv7xquatgRpTBF3agAPEl8J0Cn40e1+IEQYesRrNuvgeGMoN6wnfHS4oTqqHNGorVDadi0snryXRPSOMy/L35zlcYrXm5abUR9lcIOry9HbZ8i0CEFCSpU3OphlQmcdoS5o+q5HO/Fa1+JWA+u0H0PMzkqYUMPNyPqcDh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123750; c=relaxed/simple;
	bh=F/sqXNXuusfoq5nFRK9dwEPOFu1E0B/ZZnfUgH0lVkw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kha5ISIzY+IbnSmNEWf4EgwdUKDM0zlnBjU/xB+pj841MUzq4Sf08Ceu0nRndExqsFMNLNF6IZ4s5wjyWo0VJc1ukQfx/8Pgml9Uj9RWPQ+CWb2uZC+b70nRzXv7G2KvqOmA5pbqdr8FORYGqEfOYkULHqSKh2EZHsJtqDg7oNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fa2YsZns; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322B1C433A6;
	Fri, 22 Mar 2024 16:09:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711123749;
	bh=F/sqXNXuusfoq5nFRK9dwEPOFu1E0B/ZZnfUgH0lVkw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fa2YsZnsQGWbd6LtSs6H5aNN6QH0eiSf5N2umA5sLvBVzoec42e9efUOyM3pmJnvR
	 ssAgWezniuSPisV1K1HOUN3AvZOXO2dnolNNQkZ1zaOSM6eif9E0LhQIp2C4eaXhb1
	 igZl1eWSpvJu/RRYas0uzHQrpdDAlTC7nv1siruOlVOcW/G/z2aG72m+uzXHieQLqs
	 hfw7qPfKXkUbD+ZcPGyDqpjDwZm4YhHC5jJ8XY8IDjxIZLDK5gh1ac+FwiGHBY2RIH
	 ijXweKZh5c08Vtrn1/lrOZrbmtcpRSEPDzlkn7jDpXPL76OG6SbdGZiqoO/n292aRW
	 Br36xScrOoeDg==
Date: Fri, 22 Mar 2024 17:09:03 +0100
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
Subject: Re: [PATCH 04/11] PCI: epf-test: Refactor pci_epf_test_unbind()
 function
Message-ID: <Zf2tH67WRvOGK7-O@ryzen>
References: <20240314-pci-epf-rework-v1-0-6134e6c1d491@linaro.org>
 <20240314-pci-epf-rework-v1-4-6134e6c1d491@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314-pci-epf-rework-v1-4-6134e6c1d491@linaro.org>

On Thu, Mar 14, 2024 at 08:53:43PM +0530, Manivannan Sadhasivam wrote:
> Move the pci_epc_clear_bar() and pci_epf_free_space() code to respective
> helper functions. This allows reusing the helpers in future commits.
> 
> This also requires moving the pci_epf_test_unbind() definition below
> pci_epf_test_bind() to avoid forward declaration of the above helpers.
> 
> No functional change.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>  drivers/pci/endpoint/functions/pci-epf-test.c | 63 ++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
> index 1dae0fce8fc4..2fac36553633 100644
> --- a/drivers/pci/endpoint/functions/pci-epf-test.c
> +++ b/drivers/pci/endpoint/functions/pci-epf-test.c
> @@ -686,27 +686,6 @@ static void pci_epf_test_cmd_handler(struct work_struct *work)
>  			   msecs_to_jiffies(1));
>  }
>  
> -static void pci_epf_test_unbind(struct pci_epf *epf)
> -{
> -	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> -	struct pci_epc *epc = epf->epc;
> -	struct pci_epf_bar *epf_bar;
> -	int bar;
> -
> -	cancel_delayed_work(&epf_test->cmd_handler);
> -	pci_epf_test_clean_dma_chan(epf_test);
> -	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> -		epf_bar = &epf->bar[bar];
> -
> -		if (epf_test->reg[bar]) {
> -			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
> -					  epf_bar);
> -			pci_epf_free_space(epf, epf_test->reg[bar], bar,
> -					   PRIMARY_INTERFACE);
> -		}
> -	}
> -}
> -
>  static int pci_epf_test_set_bar(struct pci_epf *epf)
>  {
>  	int bar, add;
> @@ -746,6 +725,22 @@ static int pci_epf_test_set_bar(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static void pci_epf_test_clear_bar(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	struct pci_epc *epc = epf->epc;
> +	struct pci_epf_bar *epf_bar;
> +	int bar;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> +		epf_bar = &epf->bar[bar];
> +
> +		if (epf_test->reg[bar])
> +			pci_epc_clear_bar(epc, epf->func_no, epf->vfunc_no,
> +					  epf_bar);
> +	}
> +}
> +
>  static int pci_epf_test_epc_init(struct pci_epf *epf)
>  {
>  	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> @@ -885,6 +880,22 @@ static int pci_epf_test_alloc_space(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static void pci_epf_test_free_space(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +	struct pci_epf_bar *epf_bar;
> +	int bar;
> +
> +	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
> +		epf_bar = &epf->bar[bar];
> +
> +		if (epf_test->reg[bar]) {
> +			pci_epf_free_space(epf, epf_test->reg[bar], bar,
> +					   PRIMARY_INTERFACE);
> +		}

Nit: No need for braces here. (Just like you don't have braces in
pci_epf_test_clear_bar()).

Like you said in the other thread, this commit clashes with changes done
in my series.

However, except for the small nit, the commit looks good:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


> +	}
> +}
> +
>  static void pci_epf_configure_bar(struct pci_epf *epf,
>  				  const struct pci_epc_features *epc_features)
>  {
> @@ -940,6 +951,16 @@ static int pci_epf_test_bind(struct pci_epf *epf)
>  	return 0;
>  }
>  
> +static void pci_epf_test_unbind(struct pci_epf *epf)
> +{
> +	struct pci_epf_test *epf_test = epf_get_drvdata(epf);
> +
> +	cancel_delayed_work(&epf_test->cmd_handler);
> +	pci_epf_test_clean_dma_chan(epf_test);
> +	pci_epf_test_clear_bar(epf);
> +	pci_epf_test_free_space(epf);
> +}
> +
>  static const struct pci_epf_device_id pci_epf_test_ids[] = {
>  	{
>  		.name = "pci_epf_test",
> 
> -- 
> 2.25.1
> 

