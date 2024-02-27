Return-Path: <linux-pci+bounces-4148-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CA15D869F45
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 19:42:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF0D6B226D3
	for <lists+linux-pci@lfdr.de>; Tue, 27 Feb 2024 18:42:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 363E44F21D;
	Tue, 27 Feb 2024 18:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OD4KwaAW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3924D112
	for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 18:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709059355; cv=none; b=YiKICVD3V1I9M6V1Y5Beudqvm152AQIGBty+dZk1irk0O8mTQFqY9uUzrwloIW71fy3atUedjnQp7NpNVOfLkzXccotyMg3e3rb071RAYke8YTneKJ1OOXSRIsMHBF4P8Yd1y3kEh2Hh/scdfyofxGdI9OO0H7uTyD4SizMe7C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709059355; c=relaxed/simple;
	bh=TeDNuU90ly9acziamBX1PT4TgShziEBCnefgqu8SzNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IuoIoth4rZCiF3ILrgbIQ3+EPYZ83JVPuaRAhu80Jko3gEoevewV1/mMVCb9xEwWFHDU11mlb48Y3NpAS0rtkGm63sY5ZCpUv8eHnRSbd6A6PdZu6lqvegiYAZS81kljMn6BpUOf3auAu1xF6uXwDHcWfZN0Ofme16JFK+5k9CM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OD4KwaAW; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29954bb87b4so3262753a91.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Feb 2024 10:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709059352; x=1709664152; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+6rCPg+j8C1jvS9yOkEQeWpFYDNNuRJYfgnyrNY8KDs=;
        b=OD4KwaAW5YRbf3nRwotlMQFuGPEEQqHOJ7Grl8+wj/23FYaYlioTcxFCEPN63qpWKD
         hcYHUCyBIGz+FtHeflthN/eGvK1w69FWDyuHH/KTYHjvrUdSKiUwNz0ZotyZ5POM2g4v
         yDZM1uFw1HbGFn088iaXuQyCN5hxuOaglTMjSrJ2IZwxiEDaZ1w7eAfSr8otQ4UJ0UIm
         Ef1sK7HMi64X4tr86rsDgPzHi49PF4Z1ZGCsAeYOKvF2qjg+Jl5qQRjoKTKbNNLYHj9C
         41mq4i8R/qHdas64GsuSAmwzz/M/qED9491WlJtJW26KtBhCRSbuTKIiaDnE7IQkbIXV
         c8iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709059352; x=1709664152;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+6rCPg+j8C1jvS9yOkEQeWpFYDNNuRJYfgnyrNY8KDs=;
        b=HEwCXp8VtZfA7BrFP+qXAcP9jeZjmSAA6iU4DHEEjYbsTTFgQxFK44Eu6qsKzqrFxx
         DSRRlsShUwpftW4WzZKawf8jkErpBq4E7OuEmPnZ5tqd2O5VqRII+2Y5rQUlC48aR8nO
         hk3jD2EPGjwGnpYShgcO42vfFhznxzuIeMhbR+i8yMeFQbdsa+tkuZBAPGepkEolrqNd
         IoXGuicoNspZ3GkASIevPOexebx+B9uvM3U51J97QfKZi4hRbJGvIQn2TyfsnaNC8+R1
         cZIjrPSDPqdenjpF1iP5An7c9sl5eZs0c78iWkP+82k72IDvL9YT59UkD3DpLsOLDcLU
         jU3g==
X-Forwarded-Encrypted: i=1; AJvYcCVfO2FVCN04XJL+k+MZyNQX3qvJ78nIAESNh4qjcR4/gJphggRrLnpJR6D9et14v3rh++Wlq+3AMr1p9zmfOYsPnbpLu1FqA17a
X-Gm-Message-State: AOJu0YzuQQt1Pekn65/g4SqNnSZ7KJD5rJkfwu1lNm87WMEq42lr3bYd
	tXfHkWP5oDdoBRivktKonA01sq5dRpKrEkkfKF4AgtDptzhljGPe4coyoOde0w==
X-Google-Smtp-Source: AGHT+IHGnijMDtvZJeDBn9BB121pNvr/sMLOiP6/y+CYwXPpfHEAryi1aO3yqqkJry/L7BDxwUlTZw==
X-Received: by 2002:a17:90a:4285:b0:299:6a7f:cc09 with SMTP id p5-20020a17090a428500b002996a7fcc09mr7865801pjg.33.1709059351862;
        Tue, 27 Feb 2024 10:42:31 -0800 (PST)
Received: from thinkpad ([117.213.97.177])
        by smtp.gmail.com with ESMTPSA id nr14-20020a17090b240e00b00299332505d7sm3758838pjb.26.2024.02.27.10.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 10:42:31 -0800 (PST)
Date: Wed, 28 Feb 2024 00:12:18 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.li@nxp.com>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kishon Vijay Abraham I <kishon@ti.com>,
	Vidya Sagar <vidyas@nvidia.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v8 06/10] PCI: dwc: ep: Call dw_pcie_ep_init_registers()
 API directly from all glue drivers
Message-ID: <20240227184218.GT2587@thinkpad>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
 <20240224-pci-dbi-rework-v8-6-64c7fd0cfe64@linaro.org>
 <ZdzEoXwU42rFCF/W@lizhi-Precision-Tower-5810>
 <20240227122141.GN2587@thinkpad>
 <Zd4bybN0malf5uBe@lizhi-Precision-Tower-5810>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zd4bybN0malf5uBe@lizhi-Precision-Tower-5810>

On Tue, Feb 27, 2024 at 12:28:41PM -0500, Frank Li wrote:
> On Tue, Feb 27, 2024 at 05:51:41PM +0530, Manivannan Sadhasivam wrote:
> > On Mon, Feb 26, 2024 at 12:04:33PM -0500, Frank Li wrote:
> > > On Sat, Feb 24, 2024 at 12:24:12PM +0530, Manivannan Sadhasivam wrote:
> > > > Currently, dw_pcie_ep_init_registers() API is directly called by the glue
> > > > drivers requiring active refclk from host. But for the other drivers, it is
> > > > getting called implicitly by dw_pcie_ep_init(). This is due to the fact
> > > > that this API initializes DWC EP specific registers and that requires an
> > > > active refclk (either from host or generated locally by endpoint itsef).
> > > > 
> > > > But, this causes a discrepancy among the glue drivers. So to avoid this
> > > > confusion, let's call this API directly from all glue drivers irrespective
> > > > of refclk dependency. Only difference here is that the drivers requiring
> > > > refclk from host will call this API only after the refclk is received and
> > > > other drivers without refclk dependency will call this API right after
> > > > dw_pcie_ep_init().
> > > > 
> > > > This change will also allow us to remove the "core_init_notifier" flag in
> > > > the later commits.
> > > > 
> > > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > > ---
> > > >  drivers/pci/controller/dwc/pci-dra7xx.c           |  7 +++++++
> > > >  drivers/pci/controller/dwc/pci-imx6.c             |  8 ++++++++
> > > >  drivers/pci/controller/dwc/pci-keystone.c         |  9 +++++++++
> > > >  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  7 +++++++
> > > >  drivers/pci/controller/dwc/pcie-designware-ep.c   | 22 ----------------------
> > > >  drivers/pci/controller/dwc/pcie-designware-plat.c |  9 +++++++++
> > > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 12 +++++++++++-
> > > >  drivers/pci/controller/dwc/pcie-uniphier-ep.c     | 13 ++++++++++++-
> > > >  8 files changed, 63 insertions(+), 24 deletions(-)
> > 
> > [...]
> > 
> > > > diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > index ed1f2afd830a..278bdc9b2269 100644
> > > > --- a/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > +++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
> > > > @@ -729,7 +729,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  	struct device *dev = pci->dev;
> > > >  	struct platform_device *pdev = to_platform_device(dev);
> > > >  	struct device_node *np = dev->of_node;
> > > > -	const struct pci_epc_features *epc_features;
> > > >  
> > > >  	INIT_LIST_HEAD(&ep->func_list);
> > > >  
> > > > @@ -775,29 +774,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
> > > >  		goto err_exit_epc_mem;
> > > >  	}
> > > >  
> > > > -	if (ep->ops->get_features) {
> > > > -		epc_features = ep->ops->get_features(ep);
> > > > -		if (epc_features->core_init_notifier)
> > > > -			return 0;
> > > > -	}
> > > 
> > > why remove this check?
> > > 
> > 
> > There is no point in keeping this check since we are removing the call to
> > dw_pcie_ep_init_registers() below. But I should've described this change in the
> > commit message.
> 
> Sperated patch will be helpful. This clean up does not related with other
> change.
> 

Well this is not a generic cleanup that could be moved to a separate patch. Due
to the changes in this patch, the use of the flag becomes redundant. So it has
to removed here itself.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

