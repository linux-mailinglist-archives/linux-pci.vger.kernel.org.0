Return-Path: <linux-pci+bounces-4648-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 834C087609C
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 10:05:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7D201C21F39
	for <lists+linux-pci@lfdr.de>; Fri,  8 Mar 2024 09:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E297D52F79;
	Fri,  8 Mar 2024 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MWkI4xtH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DDC52F73;
	Fri,  8 Mar 2024 09:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709888722; cv=none; b=KxXBXuB7RiBc4G0zoCHZkeG56zGIfO9Zaa860Rbf7O4irCJ9nWfD2zOlkLgrXS6XvCaillEPulLAQ6VMBymNUWVNImbQFuGRD2e3o28dS8dQlRx381lMcFzJWRrpOEOezWxUtsKPC022uy+w/0iYCmN4ucLqhKOAvDDFAEJrk1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709888722; c=relaxed/simple;
	bh=bZE3lLlkuJ7PvYUKEQqczGXk3MirQvfYGrIhBNhV2+0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XUFCxXQO43SrTBEbxbYv52/D6XiRKIXvWJcNjDyvDLQey9kw3hP83L2mh1sGmxja2V4jVv/XHDtL5s91D6djtauA/XmzgJ6i9470AoHSBdKY/ANEtqkpbVuMceSPuzrUW9n92Z/emU2IkftCVOTVU7h7Fi53tqJZuh7Odu7I6TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MWkI4xtH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6806C433B1;
	Fri,  8 Mar 2024 09:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709888722;
	bh=bZE3lLlkuJ7PvYUKEQqczGXk3MirQvfYGrIhBNhV2+0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MWkI4xtHh0q/rku6OXru8Y5F0uyRm3OagmGFpmUyIc2rYcZiMSPOiATfm4KcSiUkW
	 IA/wiVN/IG7POxQlNaaz79LCo+ocHGUmXgYP6x6UEr/8a5tlpJo5msNuAtAERLfowz
	 OydyRBOmxFQHHf4+urZfZqiXS8SHOFOoGxXqRrutLHKA76PqWRFuhnOKTTspI+kuci
	 BQ28JitosqrxLAk3FoKKSH0YNWL74SOgWXdv6mXlpxLAHHLBY1yr79+O6wbAgLS4s4
	 B4A1F/m+kSB0tUh7hiHLnsNWlFj4wbjuW+NQlJBLF+NrcRpNktQGGd61YzrHsCJ5xm
	 y+8eyn0zKZ4sA==
Date: Fri, 8 Mar 2024 10:05:11 +0100
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
Message-ID: <ZerUx9Vw_W997LZk@ryzen>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
 <20240304-pci-dbi-rework-v9-6-29d433d99cda@linaro.org>
 <ZeolaEIRYmKZjnvT@ryzen>
 <20240308053624.GB3789@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308053624.GB3789@thinkpad>

On Fri, Mar 08, 2024 at 11:06:24AM +0530, Manivannan Sadhasivam wrote:
> On Thu, Mar 07, 2024 at 09:36:56PM +0100, Niklas Cassel wrote:
> > On Mon, Mar 04, 2024 at 02:52:18PM +0530, Manivannan Sadhasivam wrote:
> > > Currently, dw_pcie_ep_init_registers() API is directly called by the glue
> > > drivers requiring active refclk from host. But for the other drivers, it is
> > > getting called implicitly by dw_pcie_ep_init(). This is due to the fact
> > > that this API initializes DWC EP specific registers and that requires an
> > > active refclk (either from host or generated locally by endpoint itsef).
> > > 
> > > But, this causes a discrepancy among the glue drivers. So to avoid this
> > > confusion, let's call this API directly from all glue drivers irrespective
> > > of refclk dependency. Only difference here is that the drivers requiring
> > > refclk from host will call this API only after the refclk is received and
> > > other drivers without refclk dependency will call this API right after
> > > dw_pcie_ep_init().
> > > 
> > > With this change, the check for 'core_init_notifier' flag can now be
> > > dropped from dw_pcie_ep_init() API. This will also allow us to remove the
> > > 'core_init_notifier' flag completely in the later commits.
> > > 
> > > Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > ---
> > >  drivers/pci/controller/dwc/pci-dra7xx.c           |  7 +++++++
> > >  drivers/pci/controller/dwc/pci-imx6.c             |  8 ++++++++
> > >  drivers/pci/controller/dwc/pci-keystone.c         |  9 +++++++++
> > >  drivers/pci/controller/dwc/pci-layerscape-ep.c    |  7 +++++++
> > >  drivers/pci/controller/dwc/pcie-artpec6.c         | 13 ++++++++++++-
> > >  drivers/pci/controller/dwc/pcie-designware-ep.c   | 22 ----------------------
> > >  drivers/pci/controller/dwc/pcie-designware-plat.c |  9 +++++++++
> > >  drivers/pci/controller/dwc/pcie-keembay.c         | 16 +++++++++++++++-
> > >  drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 12 +++++++++++-
> > >  drivers/pci/controller/dwc/pcie-uniphier-ep.c     | 13 ++++++++++++-
> > >  10 files changed, 90 insertions(+), 26 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
> > > index 0e406677060d..395042b29ffc 100644
> > > --- a/drivers/pci/controller/dwc/pci-dra7xx.c
> > > +++ b/drivers/pci/controller/dwc/pci-dra7xx.c
> > > @@ -467,6 +467,13 @@ static int dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
> > >  		return ret;
> > >  	}
> > >  
> > > +	ret = dw_pcie_ep_init_registers(ep);
> > > +	if (ret) {
> > 
> > Here you are using if (ret) to error check the return from
> > dw_pcie_ep_init_registers().
> > 
> > 
> > > index c0c62533a3f1..8392894ed286 100644
> > > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > > @@ -1286,6 +1286,13 @@ static int ks_pcie_probe(struct platform_device *pdev)
> > >  		ret = dw_pcie_ep_init(&pci->ep);
> > >  		if (ret < 0)
> > >  			goto err_get_sync;
> > > +
> > > +		ret = dw_pcie_ep_init_registers(&pci->ep);
> > > +		if (ret < 0) {
> > 
> > Here you are using if (ret < 0) to error check the return from
> > dw_pcie_ep_init_registers(). Please be consistent.
> > 
> 
> I maintained the consistency w.r.t individual drivers. Please check them
> individually.
> 
> If I maintain consistency w.r.t this patch, then the style will change within
> the drivers.

Personally, I disagree with that.

All glue drivers should use the same way of checking dw_pcie_ep_init(),
depending on the kdoc of dw_pcie_ep_init().

If the kdoc for dw_pcie_ep_init() says returns 0 on success,
then I think that it is strictly more correct to do:

ret = dw_pcie_ep_init()
if (ret) {
	<error handling>
}

And if a glue driver doesn't look like that, then I think we should change
them. (Same reasoning for dw_pcie_ep_init_registers().)


If you read code that looks like:
ret = dw_pcie_ep_init()
if (ret < 0) {
	<error handling>
}

then you assume that is is a function with a kdoc that says it can return 0
or a positive value on success, e.g. a function that returns an index in an
array.


Kind regards,
Niklas

