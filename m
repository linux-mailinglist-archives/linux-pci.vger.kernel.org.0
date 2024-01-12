Return-Path: <linux-pci+bounces-2080-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5899082BADC
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 06:28:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA40B2102D
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jan 2024 05:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 835FA5B5C3;
	Fri, 12 Jan 2024 05:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QnV3LFUU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69E875B5B1
	for <linux-pci@vger.kernel.org>; Fri, 12 Jan 2024 05:28:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3555C433C7;
	Fri, 12 Jan 2024 05:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705037303;
	bh=hbfM2oEQgq3nJPqqYc09Z3TqbkYfGWYs7hZWD59J/fk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QnV3LFUUV3e+u2EiTCdaafrWmMu9J5lhhY+ZIjiNBXLm1SVpeepZzgxFJgXHly6Hi
	 3oHaWWwyqDfCa3jPxKnacsdthgwrt7Mm4r2DvRWvLjPljTstxNL/xs9O0uLaRssi0j
	 fnL1ZsjaDQog07639QsKshuX8hH1arBWPEL1XFeFdXYBgsR3rIrPN++iqJDO2ckkmz
	 yuPOM47FLX04MqMevuKMIEvo9wOrKSsSdv12QS+gRfq3tCBz5Yd5xtpisn45fm/ad+
	 tiv/1+4AABMsNZUpuKAUrteu5MoAEwlbyj53P5gZ2ycuHM0DImrPFQp+6B8FPc/Jpa
	 5t47oSjUmLqmg==
Date: Fri, 12 Jan 2024 10:58:16 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
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
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240112052816.GB2970@thinkpad>
References: <20240111152517.1881382-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240111152517.1881382-1-ajayagarwal@google.com>

On Thu, Jan 11, 2024 at 08:55:17PM +0530, Ajay Agarwal wrote:
> In dw_pcie_host_init() regardless of whether the link has been
> started or not, the code waits for the link to come up. Even in
> cases where start_link() is not defined the code ends up spinning
> in a loop for 1 second. Since in some systems dw_pcie_host_init()
> gets called during probe, this one second loop for each pcie
> interface instance ends up extending the boot time.
> 
> Wait for the link up in only if the start_link() is defined.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>

This is clearly not v1. Either this patch has to be a RESEND or v2. And the
changelog should mention what happened to the earlier version (revert history
etc...)

Also, I provided feedback on the revert patch that you have completely ignored
[1]. If you do not agree with those, it is fine, but you should justify first.

- Mani

[1] https://lore.kernel.org/linux-pci/20230711073719.GA36617@thinkpad/

> ---
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
> 2.43.0.275.g3460e3d667-goog
> 

-- 
மணிவண்ணன் சதாசிவம்

