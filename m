Return-Path: <linux-pci+bounces-2335-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 588FC83254D
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 08:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 840B21C23034
	for <lists+linux-pci@lfdr.de>; Fri, 19 Jan 2024 07:52:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D71D51D;
	Fri, 19 Jan 2024 07:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tTTLL7up"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289B78F6E
	for <linux-pci@vger.kernel.org>; Fri, 19 Jan 2024 07:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705650753; cv=none; b=GJYqV+l6a3fFuWCawKV36CBK82yk1PmV4idKyHQy36Sb9at/9fTZDisTX2cPOLosEa8kBAV6v0jASi85LELo98A6e0+3wMqQszSPwrFIAYFGZO1Gwx91NJ45qhQ3IJKWlznvk57J76p7DVJNdwDcFn9WG4jstqMZdg0Bk+W04xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705650753; c=relaxed/simple;
	bh=QKEYPvDj5WCgpvuxK4nhJoRfzZWYMDcHc3O3/NvUcAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BeluOypfjqZgrgbYsnfreZdXb3jbPpXuLuKwwdE2RRRl1D/iWOVtwqCrUb1MNFX9olcy4p/KWGNQ1jFGGNmz+VvnXKb+K3cBsfaRBHeuKJypfeA0MkPEuTZlpUw6IdKS85fLNvL4ERWDk4ju39xXpADmpjbSpHug8FKMFXKZimg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tTTLL7up; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-681397137afso3644216d6.1
        for <linux-pci@vger.kernel.org>; Thu, 18 Jan 2024 23:52:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705650750; x=1706255550; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vXUup3fov4M3X87Y6Qu9e47yLAJsXEcn/YTAHzAUmi8=;
        b=tTTLL7upsbTXg0nULl3d4lg8k3SmQ0EgxxQu3vfj4rO1xWisueRQ0lQeUtsJR9WAkZ
         9su8tKv3JBx9vUGkaN154874Ubv54AkOMT8V33Bz+K/478Ea3Ds2xKIgbo3Q9AXsf2qL
         h2NFDvq+4WRXB6FKbC1PuTvhOjrVMfmLulfAFlj/yUFaafYMxpiBjElh/FvqSZnbPpOu
         H8LhmGeEsCA8dn2DysN9q+CFAxuUQaUumkvgYlSX/z2Wd7auyrgTlJWPSBVYDpLgv2Re
         cVaJSLXNciRnceoCFrdRZAj7D8/wLy75xO3cVmwvdvWmWsy9Aj0q+hHt17VF4cis+a/1
         bqSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705650750; x=1706255550;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXUup3fov4M3X87Y6Qu9e47yLAJsXEcn/YTAHzAUmi8=;
        b=P7xxgkEYsW4rGVxaER9g050fBX9r9eFc0qZAhtOC/v6udK9vZ0Skn+flHBNv4/3P8o
         zkVz4otbzobc9g3N/irLq25FpzWI80YkjcKf9mr2TKxWy0zvB8ir+XDDK4abdNjew19u
         lXd0CcUkEIvp/9E40sMvQKuoiz/drd58+DMbm/Uk+au786o61LHimeGXF99ymZNZrovj
         5W2vFlZGeuwG8EUHQo9YivcpmkXp4K5kZYdp/miJ1oPe74GsLlVqeBbQplHCV1xLhIOx
         GZPVV8Ie5ilAPMNia4lMT5HEDRgcnWCUP5NFm3zYWIHag35o22+oX9YS6GDN6zScAOQS
         TeUg==
X-Gm-Message-State: AOJu0Yy9jvUML84DZshiAJn11w2VkmHueB48JPgh7n+7qCB+ExGrbpan
	1cOHIEiQ6Vr7lvp9+/TIJknmyDgBfeFht5UVjcIhGf2acb6VtdPVxsp3UB+TCA==
X-Google-Smtp-Source: AGHT+IFQVxWRXJC/5fcvWLWd1jmU9dto2Gu2j0aye+1Rq0luEhkFO64tPzm1FWNE8y8cXn5+rLaltw==
X-Received: by 2002:ad4:5949:0:b0:684:4bbe:87bf with SMTP id eo9-20020ad45949000000b006844bbe87bfmr42887qvb.24.1705650750008;
        Thu, 18 Jan 2024 23:52:30 -0800 (PST)
Received: from thinkpad ([117.248.2.56])
        by smtp.gmail.com with ESMTPSA id ld27-20020a056214419b00b006818be28820sm1233513qvb.24.2024.01.18.23.52.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 23:52:29 -0800 (PST)
Date: Fri, 19 Jan 2024 13:22:19 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Ajay Agarwal <ajayagarwal@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Johan Hovold <johan+linaro@kernel.org>,
	Jon Hunter <jonathanh@nvidia.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Manu Gautam <manugautam@google.com>, Doug Zobel <zobel@google.com>,
	William McVicker <willmcvicker@google.com>,
	Serge Semin <fancer.lancer@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v5] PCI: dwc: Wait for link up only if link is started
Message-ID: <20240119075219.GC2866@thinkpad>
References: <20240112093006.2832105-1-ajayagarwal@google.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240112093006.2832105-1-ajayagarwal@google.com>

On Fri, Jan 12, 2024 at 03:00:06PM +0530, Ajay Agarwal wrote:
> In dw_pcie_host_init() regardless of whether the link has been
> started or not, the code waits for the link to come up. Even in
> cases where start_link() is not defined the code ends up spinning
> in a loop for 1 second. Since in some systems dw_pcie_host_init()
> gets called during probe, this one second loop for each pcie
> interface instance ends up extending the boot time.
> 

Which platform you are working on? Is that upstreamed? You should mention the
specific platform where you are observing the issue.

Right now, intel-gw and designware-plat are the only drivers not defining that
callback. First one definitely needs a fixup and I do not know how the latter
works.

- Mani

> Wait for the link up in only if the start_link() is defined.
> 
> Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
> ---
> v4 was applied, but then reverted. The reason being v4 added a
> regression on some products which expect the link to not come up as a
> part of the probe. Since v4 returned error from dw_pcie_wait_for_link
> check, the probe function of these products started to fail.
> 
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

-- 
மணிவண்ணன் சதாசிவம்

