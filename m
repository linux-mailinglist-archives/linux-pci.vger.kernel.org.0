Return-Path: <linux-pci+bounces-4655-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A058761E6
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 11:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD47B1F21F59
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 10:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5715E53E1A;
	Fri,  8 Mar 2024 10:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eMTB0dxI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1CFD29E;
	Fri,  8 Mar 2024 10:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709893383; cv=none; b=kYvwi/y7jK5bj19NKzXvzV3OCcP2DeVyJIrpfZ892TalY5b9VxJ8j+sq6OVAff2Eqc2GW4K7yFoDEfbn09ZNcGqYCZLAkUB9LUVn89spwSOWY/VJr9OLi0FWdI4COO1SbcGfU8cUWT27+VeOkFcNahA6pQvvzoKMzV6WZGexams=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709893383; c=relaxed/simple;
	bh=lHycvlNl7OVIrzQI78hPFaTIMft0lPdksi6rDoX3W/g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u17qCdi7+wZwI/MJGL12KcM9hrN2Annuc14QnmgXOWaDYIt4uWlB0T3wVvabU3TvgHbP9VVb4R5g6hzfQU8aFqRb4rP2a8fjXEYssnRYaTmj8BaDtUUEPMWnJK8yYDTs12atDKzwty7BAlR7er6SV4pMK461FekqNbAnECLRWA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eMTB0dxI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E1BFC433C7;
	Fri,  8 Mar 2024 10:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709893382;
	bh=lHycvlNl7OVIrzQI78hPFaTIMft0lPdksi6rDoX3W/g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=eMTB0dxIOS+2itv74DP87TT3a7S3lfZoD0+2Ls0iMrgdCcuIV4TZHR8C/py3lEoLM
	 rGXHcOX82vv7YXrL1/xhf67lvGXpZQbd+56lYq8J4pfE1vSC4Z9QmS9P8uZkL4AnaS
	 UE+ngGFia7kmUXjyWDby8Q4Cd9pZqA2t88xVQTlABBPsGJEFng7d1B4ndq/wO4Spkp
	 nhGLBhuH+r3uinoM2tful9m8gThPphuZ2QPQ8mte4TEAThEeCy4ovpQm1GN6JR0HEX
	 mCHXeItsOiBq9vlmwyPHb0GtJgonfjHk4SSF350AxdKeECKF73Js76nM3nPgm2jTIn
	 10tpVfabCXnxQ==
Date: Fri, 8 Mar 2024 11:22:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@axis.com
Subject: Re: [PATCH v9 06/10] PCI: dwc: ep: Call dw_pcie_ep_init_registers()
 API directly from all glue drivers
Message-ID: <Zerm_LukciAYCZxD@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-6-29d433d99cda@linaro.org>
 <ZeolaEIRYmKZjnvT@ryzen>
 <20240308053624.GB3789@thinkpad>
 <ZerUx9Vw_W997LZk@ryzen>
 <20240308094947.GH3789@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308094947.GH3789@thinkpad>

On Fri, Mar 08, 2024 at 03:19:47PM +0530, Manivannan Sadhasivam wrote:
> > > > > @@ -467,6 +467,13 @@ static int dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
> > > > >  		return ret;
> > > > >  	}
> > > > >  
> > > > > +	ret = dw_pcie_ep_init_registers(ep);
> > > > > +	if (ret) {
> > > > 
> > > > Here you are using if (ret) to error check the return from
> > > > dw_pcie_ep_init_registers().
> > > > 
> > > > 
> > > > > index c0c62533a3f1..8392894ed286 100644
> > > > > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > > > > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > > > > @@ -1286,6 +1286,13 @@ static int ks_pcie_probe(struct platform_device *pdev)
> > > > >  		ret = dw_pcie_ep_init(&pci->ep);
> > > > >  		if (ret < 0)
> > > > >  			goto err_get_sync;
> > > > > +
> > > > > +		ret = dw_pcie_ep_init_registers(&pci->ep);
> > > > > +		if (ret < 0) {
> > > > 
> > > > Here you are using if (ret < 0) to error check the return from
> > > > dw_pcie_ep_init_registers(). Please be consistent.
> > > > 
> > > 
> > > I maintained the consistency w.r.t individual drivers. Please check them
> > > individually.
> > > 
> > > If I maintain consistency w.r.t this patch, then the style will change within
> > > the drivers.
> > 
> > Personally, I disagree with that.
> > 
> > All glue drivers should use the same way of checking dw_pcie_ep_init(),
> > depending on the kdoc of dw_pcie_ep_init().
> > 
> > If the kdoc for dw_pcie_ep_init() says returns 0 on success,
> > then I think that it is strictly more correct to do:
> > 
> > ret = dw_pcie_ep_init()
> > if (ret) {
> > 	<error handling>
> > }
> > 
> > And if a glue driver doesn't look like that, then I think we should change
> > them. (Same reasoning for dw_pcie_ep_init_registers().)
> > 
> > 
> > If you read code that looks like:
> > ret = dw_pcie_ep_init()
> > if (ret < 0) {
> > 	<error handling>
> > }
> > 
> > then you assume that is is a function with a kdoc that says it can return 0
> > or a positive value on success, e.g. a function that returns an index in an
> > array.
> > 
> 
> But if you read the same function from the individual drivers, it could present
> a different opinion because the samantics is different than others.

Is there any glue driver where a positive result from dw_pcie_ep_init() is
considered valid?


> 
> I'm not opposed to keeping the API semantics consistent, but we have to take
> account of the drivers style as well.

kdoc > "driver style"
IMO, but you are the maintainer, I just offered my 50 cents :)


Kind regards,
Niklas

