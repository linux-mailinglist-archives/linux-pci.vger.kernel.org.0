Return-Path: <linux-pci+bounces-2393-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 737A1832FED
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 21:42:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0280B1F22193
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 20:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B12D756465;
	Fri, 19 Jan 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jk2abE0w"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D71557888
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 20:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705696933; cv=none; b=VOk5zYjngdREPcCzB8jRqogEDQ4dBQW3rwPrnvIAVtEPmiFYoKz6k5bIl4clT3zbC/zhEr+PZJX4drGoXQ8/Uk2gCf97qUfz66VhpJr8o7pdnpw6LvJ3aJW9kZYwYkbROc/0CUZI6WxajgbqA2tgmHrCSGofxJr9ZCmLw1WYFvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705696933; c=relaxed/simple;
	bh=0hmvWl4/Lfc+c6DluNpz+wwK7X8QsRfBw6720YCsBqs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=l5YLu0WFIim33E+rK3mdXKt2dRJMNYcfq7TuPx7jlfHRgzEpdeWqM3zRLbUq985RJn9Nor+W8LJkkkcL9MlXWws2vlH/IDHFFRhGFBT9R5/eFBsd9sL+HKniUOet7Fs42WkUI2a4G7UsjaKWpXIRiFJzb0MjIn3UayjT02XEhug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jk2abE0w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9E64C433C7;
	Fri, 19 Jan 2024 20:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705696933;
	bh=0hmvWl4/Lfc+c6DluNpz+wwK7X8QsRfBw6720YCsBqs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Jk2abE0wJIKV2jQplFf7NepuVudB5p+L/57e5SaI3vtYB/KOhxgCd9tWGU+xw0vlS
	 85KbdfNGSRKIV5d5Lh1CHfYmh2dwffzP3TJgIu+r9VaDmVvc5J9Ad9oSzo3n0G/Xgh
	 joABJ2yoKH4fX5Im77VOFZkXY4uP0IxHVALMovENl+HNQD0G0zGmgoqUx6i999FPHx
	 S6p0ld+w+KW3krp0ddR7V9kc6UGXOXEFWXriwpV7KVk2Km9TS5iA4UhBBzvD3yUX3j
	 v0H0WOsJ/DNlA9TfxYO0FCiU6RBXZnqkQPhMJOfn51ECUeOtPUwo7kVsGFiex2euyt
	 VAARyU3IMOkyg==
Date: Fri, 19 Jan 2024 14:42:11 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	Fabio Estevam <festevam@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240119204211.GA185359@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112093006.2832105-1-ajayagarwal@google.com>

[+cc Bjorn A, Fabio, Xiaolei, who reported the v4 issue]

On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> In dw_pcie_host_init() regardless of whether the link has been
> started or not, the code waits for the link to come up. Even in
> cases where start_link() is not defined the code ends up spinning
> in a loop for 1 second. Since in some systems dw_pcie_host_init()
> gets called during probe, this one second loop for each pcie
> interface instance ends up extending the boot time.

s/start_link()/.start_link()/ to hint that this is a function pointer,
not a function name in its own right (also below).
s/1/one/ to be consistent.
s/pcie/PCIe/ to follow spec usage.

> Wait for the link up in only if the start_link() is defined.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
> v4 was applied, but then reverted. The reason being v4 added a
> regression on some products which expect the link to not come up as a
> part of the probe. Since v4 returned error from dw_pcie_wait_for_link
> check, the probe function of these products started to fail.

I know this part doesn't get included in the commit log, but I think
it would be nice to include the relevant commits here:

  da56a1bfbab5 ("PCI: dwc: Wait for link up only if link is started")
  c5097b9869a1 ("Revert "PCI: dwc: Wait for link up only if link is started"")

because the latter includes details about the actual failure, so we
can review this with that platform in mind.

> Changelog since v4:
>  - Do not return error from dw_pcie_wait_for_link check
> 
>  .../pci/controller/dwc/pcie-designware-host.c | 12 +++++++----
>  drivers/pci/controller/dwc/pcie-designware.c  | 20 ++++++++++++-------
>  drivers/pci/controller/dwc/pcie-designware.h  |  1 +
>  3 files changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 7991f0e179b2..e53132663d1d 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -487,14 +487,18 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
>  	if (ret)
>  		goto err_remove_edma;
>  
> -	if (!dw_pcie_link_up(pci)) {
> +	if (dw_pcie_link_up(pci)) {
> +		dw_pcie_print_link_status(pci);
> +	} else {
>  		ret = dw_pcie_start_link(pci);
>  		if (ret)
>  			goto err_remove_edma;
> -	}
>  
> -	/* Ignore errors, the link may come up later */
> -	dw_pcie_wait_for_link(pci);
> +		if (pci->ops && pci->ops->start_link) {
> +			/* Ignore errors, the link may come up later */
> +			dw_pcie_wait_for_link(pci);
> +		}
> +	}
>  
>  	bridge->sysdata = pp;
>  
> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
> index 250cf7f40b85..c067d2e960cf 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.c
> +++ b/drivers/pci/controller/dwc/pcie-designware.c
> @@ -645,9 +645,20 @@ void dw_pcie_disable_atu(struct dw_pcie *pci, u32 dir, int index)
>  	dw_pcie_writel_atu(pci, dir, index, PCIE_ATU_REGION_CTRL2, 0);
>  }
>  
> -int dw_pcie_wait_for_link(struct dw_pcie *pci)
> +void dw_pcie_print_link_status(struct dw_pcie *pci)
>  {
>  	u32 offset, val;
> +
> +	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> +	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> +
> +	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> +		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> +		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> +}
> +
> +int dw_pcie_wait_for_link(struct dw_pcie *pci)
> +{
>  	int retries;
>  
>  	/* Check if the link is up or not */
> @@ -663,12 +674,7 @@ int dw_pcie_wait_for_link(struct dw_pcie *pci)
>  		return -ETIMEDOUT;
>  	}
>  
> -	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> -	val = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
> -
> -	dev_info(pci->dev, "PCIe Gen.%u x%u link up\n",
> -		 FIELD_GET(PCI_EXP_LNKSTA_CLS, val),
> -		 FIELD_GET(PCI_EXP_LNKSTA_NLW, val));
> +	dw_pcie_print_link_status(pci);
>  
>  	return 0;
>  }

This part (pcie-designware.c and pcie-designware.h changes) could
arguably be in a separate patch so they're not a distraction from the 
important functional change.

> diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
> index 55ff76e3d384..164214a7219a 100644
> --- a/drivers/pci/controller/dwc/pcie-designware.h
> +++ b/drivers/pci/controller/dwc/pcie-designware.h
> @@ -447,6 +447,7 @@ void dw_pcie_setup(struct dw_pcie *pci);
>  void dw_pcie_iatu_detect(struct dw_pcie *pci);
>  int dw_pcie_edma_detect(struct dw_pcie *pci);
>  void dw_pcie_edma_remove(struct dw_pcie *pci);
> +void dw_pcie_print_link_status(struct dw_pcie *pci);
>  
>  int dw_pcie_suspend_noirq(struct dw_pcie *pci);
>  int dw_pcie_resume_noirq(struct dw_pcie *pci);
> -- 
> 2.43.0.381.gb435a96ce8-goog
> 

