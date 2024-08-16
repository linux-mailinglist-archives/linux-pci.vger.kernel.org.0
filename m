Return-Path: <linux-pci+bounces-11734-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A09995413C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 07:38:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92DFF2833BC
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 05:38:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E35979B99;
	Fri, 16 Aug 2024 05:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="APT3IreW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE943770F1
	for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 05:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723786683; cv=none; b=bE/uSUnDjbbOMlO5w5wGsquVGKmtPW4x21adNz+2VxYBOU70s1GcF04BKQ2XuYc2vGRnnarf6W8UtgcKe9LYkFhUOaZA/emPdf719kxS8S3/Hiiq2PyMug7laajIPzIoumMGbjGAJaarqopvo8EoEl+4DEtE6RVudfBqgNX3JVY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723786683; c=relaxed/simple;
	bh=UgTBPgKfAzIf8f96qHCArmk1pvypK4P/mS4CEvRVAMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RWQdqExZqZj+q/Jv1DScoeGLbyLdpinmnVuMstz/fXzJu5pZVVLRmKYGkPfyV+v014SRVS0OQg5ZkMUz8qNcMYUmJRDiYTc9/4GFSMGvxXoKA+gYy02vRCDK/01a6y8evQE/TvDeyvvxF3BzkOPFNqf50C62f1WzUUl6rHLTDww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=APT3IreW; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70d162eef54so1241967b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 22:38:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723786681; x=1724391481; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7prgwpKi60S0wtUNCPg0YfxubP3Ut6CQZnpYvPh+ks=;
        b=APT3IreWCwtODVF0LbtZYj4eCNTQEcTkbnGhiLSTYfmuA7SkTyeYvVNpzqM9/vaVYJ
         1/jkDa0jRAMubecLYh0QcLe02zTs9jbm66VOzw7BY9kxN8ufgvVWwStZ7jqb//y69qcu
         iCKbNz2LsBVbDTMScdV+zwsZRZuCi8H+4mDg0sPOYcMxF0tpXoLgBFH/wAYtiPyDD9Yd
         Qb9e7ErKuKs2GE0QzGRb2cI3v804BeZ+RIS9pgYNO04akgomCEsFRvsze2wAd4bEI/MB
         QIDpDf2AXq6/psPGTED20jdRL8hnO9cGZBrAaZI03QqUaYsmX9rh1ItfzxSCMikEWA1e
         U8ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723786681; x=1724391481;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7prgwpKi60S0wtUNCPg0YfxubP3Ut6CQZnpYvPh+ks=;
        b=JDD+sZYcJL5zb3qGezB8XgbxuFKWlUbxsVY6jyAL5PG/UYg7NUESCzwn0kGejRg5ES
         8nNnclWX1lvphhFFgLSZfH6Hx9waS1dXuX3zjWS2afnxX6dvzdsFOlVaikxOa2uucrH9
         EbPs3P9YK2exPYHH9Z6OzD4MmdwCPDhGgBHElap1J4htkYzwJPqtBibOouNi2tpOw7Cj
         tuO5KeDpZfBaYDT/xiIkeToKcgz7Tz+cKtIiMVpXt5h36mLgkhjW3ZduGcyeTSjoUSJo
         WCHOyLjmYMxqDTZ1GScIzJSDl//WhWDx0SQj0qvieKP192DKHFWTEdNBjxzkRnIGReiv
         4kNg==
X-Forwarded-Encrypted: i=1; AJvYcCWwS2uqE43lWvgQxvR921NZIlibkk5UEf2M5NavSG/GQgLhZnLXwN6rgn2h09X8QAw0912XNeblkEVzAZQmFDXlNH8uJyP+mf1M
X-Gm-Message-State: AOJu0YxffQama/FWa+D7eBLCu0THY9nnbjQmVd/ci1dVWzrh2gkP6wpI
	B9Rp+tpxFFLKUf02j8YeSN4qJL8to20ZSHeOYqdRq7V7SeoJcVhKfDvRaHnUrw==
X-Google-Smtp-Source: AGHT+IFULWviVp2cPDtwKAzOpa5+1vMIGu4a/EkkBQIRTeHiqzksixG0eY81MV7KEKUeTVXyMLwl7w==
X-Received: by 2002:a05:6a00:194e:b0:70b:2a:15cd with SMTP id d2e1a72fcca58-713c4bac60cmr1915613b3a.0.1723786681112;
        Thu, 15 Aug 2024 22:38:01 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7127af3d13fsm1885217b3a.218.2024.08.15.22.37.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 22:38:00 -0700 (PDT)
Date: Fri, 16 Aug 2024 11:07:57 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI: qcom-ep: Do not enable resources during probe()
Message-ID: <20240816053757.GF2331@thinkpad>
References: <20240727090604.24646-1-manivannan.sadhasivam@linaro.org>
 <20240815181557.GA53448@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240815181557.GA53448@bhelgaas>

On Thu, Aug 15, 2024 at 01:15:57PM -0500, Bjorn Helgaas wrote:
> On Sat, Jul 27, 2024 at 02:36:04PM +0530, Manivannan Sadhasivam wrote:
> > Starting from commit 869bc5253406 ("PCI: dwc: ep: Fix DBI access failure
> > for drivers requiring refclk from host"), all the hardware register access
> > (like DBI) were moved to dw_pcie_ep_init_registers() which gets called only
> > in qcom_pcie_perst_deassert() i.e., only after the endpoint received refclk
> > from host.
> > 
> > So there is no need to enable the endpoint resources (like clk, regulators,
> > PHY) during probe(). Hence, remove the call to qcom_pcie_enable_resources()
> > helper from probe(). This was added earlier because dw_pcie_ep_init() was
> > doing DBI access, which is not done now.
> > 
> > While at it, let's also call dw_pcie_ep_deinit() in err path to deinit the
> > EP controller in the case of failure.
> 
> Is this v6.11 material?  If so, we need a little more justification
> than "no need to enable".
> 

That's why I asked to merge the comment from Dmitry:

"...moreover his makes PCIe EP fail on some of the platforms as powering on PHY
requires refclk from the RC side, which is not enabled at the probe time."

And Krzysztof did that:
https://git.kernel.org/pub/scm/linux/kernel/git/pci/pci.git/commit/?h=controller/qcom&id=cd0b3e13ec309dcbe1efb66b1969fc72088b791d

- Mani

> > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > ---
> >  drivers/pci/controller/dwc/pcie-qcom-ep.c | 14 ++++----------
> >  1 file changed, 4 insertions(+), 10 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > index 236229f66c80..2319ff2ae9f6 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
> > @@ -846,21 +846,15 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
> >  	if (ret)
> >  		return ret;
> >  
> > -	ret = qcom_pcie_enable_resources(pcie_ep);
> > -	if (ret) {
> > -		dev_err(dev, "Failed to enable resources: %d\n", ret);
> > -		return ret;
> > -	}
> > -
> >  	ret = dw_pcie_ep_init(&pcie_ep->pci.ep);
> >  	if (ret) {
> >  		dev_err(dev, "Failed to initialize endpoint: %d\n", ret);
> > -		goto err_disable_resources;
> > +		return ret;
> >  	}
> >  
> >  	ret = qcom_pcie_ep_enable_irq_resources(pdev, pcie_ep);
> >  	if (ret)
> > -		goto err_disable_resources;
> > +		goto err_ep_deinit;
> >  
> >  	name = devm_kasprintf(dev, GFP_KERNEL, "%pOFP", dev->of_node);
> >  	if (!name) {
> > @@ -877,8 +871,8 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
> >  	disable_irq(pcie_ep->global_irq);
> >  	disable_irq(pcie_ep->perst_irq);
> >  
> > -err_disable_resources:
> > -	qcom_pcie_disable_resources(pcie_ep);
> > +err_ep_deinit:
> > +	dw_pcie_ep_deinit(&pcie_ep->pci.ep);
> >  
> >  	return ret;
> >  }
> > -- 
> > 2.25.1
> > 

-- 
மணிவண்ணன் சதாசிவம்

