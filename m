Return-Path: <linux-pci+bounces-3586-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C1C857B8F
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 12:25:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB2FD1F25E9D
	for <lists+linux-pci@lfdr.de>; Fri, 16 Feb 2024 11:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9976B57313;
	Fri, 16 Feb 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f9Hr8kSp"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 657F51BF50;
	Fri, 16 Feb 2024 11:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082744; cv=none; b=L35oJjaMbTx5Qa3KAQlvdI3WUoUTg9Zc1dkJ7GIUGeYnGxiBRCag5OJIwsArRvyLZSCWG4X8QM8jrUyRbLpQkOEKAW1mUO4j/RD+4Nz1YUhH/C72F+vZaY0zukny5yb0q7D6DRj56487gGn0000MvMqX0+frZVPabQlb9O5PZ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082744; c=relaxed/simple;
	bh=irTs/3hjqvC4IGIEj4U/Sb544ZHhGyYlJaKX6Qhdn+M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryurle55UEUQHhTK3sN8Dx9yjPv/36AiSgHLC/V/BexmX5nsLWYVKfrDvnznTTJiWWGs39kcjEQhYwnbPnN29fmNoRYYTMBG4k1hF2DXiWq+KXiJ/wOCLrEExNMRTnRMdkCvmYeevtlYtpU7kgO3upbX7GFjX1V18e5lopTmKY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f9Hr8kSp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD0AC433C7;
	Fri, 16 Feb 2024 11:25:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708082743;
	bh=irTs/3hjqvC4IGIEj4U/Sb544ZHhGyYlJaKX6Qhdn+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f9Hr8kSpQ3k1fF39QRvvME6Mk2/doRfaMNhgqWXiMfU9/dYZViGnmhMlYTTEi/S3D
	 p/NhBnh86rSKu5V11Ip5AEbIESUFOIj0NyTXjbHojGGCt940e8sC7jAMfJGWA0aQBy
	 LlRoSTch0Bh6lCeBocKAqycKpcnVX+NTVr7JstIwF1Fc5t7KhAQpkcMVry3Ieax+u6
	 HNYcf8/PV5dHGuGii7+hF0UNNwSA78XFZuQ81z/wY1JMJlkqeF8lDyMEv2ATmvAbd9
	 fq5CEnqBhPLLlXOrdMUhTZMe9d3dRuNpPsMi0iIJQgn+fWItYZxeUWIz236g2QEj08
	 S9BMhiNUAT4bg==
Date: Fri, 16 Feb 2024 16:55:31 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Minghuan Lian <minghuan.Lian@nxp.com>,
	Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>,
	Srikanth Thokala <srikanth.thokala@intel.com>,
	Marek Vasut <marek.vasut+renesas@gmail.com>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jon Mason <jdmason@kudzu.us>, Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Damien Le Moal <dlemoal@kernel.org>, Frank Li <Frank.Li@nxp.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, linux-renesas-soc@vger.kernel.org,
	linux-tegra@vger.kernel.org, ntb@lists.linux.dev
Subject: Re: [PATCH 1/2] PCI: endpoint: Clean up hardware description for BARs
Message-ID: <20240216112531.GD2559@thinkpad>
References: <20240210012634.600301-1-cassel@kernel.org>
 <20240210012634.600301-2-cassel@kernel.org>
 <20240216111908.GC2559@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240216111908.GC2559@thinkpad>

On Fri, Feb 16, 2024 at 04:49:08PM +0530, Manivannan Sadhasivam wrote:
> On Sat, Feb 10, 2024 at 02:26:25AM +0100, Niklas Cassel wrote:
> > The hardware description for BARs is scattered in many different variables
> > in pci_epc_features. Some of these things are mutually exclusive, so it
> > can create confusion over which variable that has precedence over another.
> > 
> > Improve the situation by creating a struct pci_epc_bar_desc, and a new
> > enum pci_epc_bar_type, and convert the endpoint controller drivers to use
> > this more well defined format.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> >  drivers/pci/controller/dwc/pci-imx6.c         |  3 +-
> >  drivers/pci/controller/dwc/pci-keystone.c     | 12 +++----
> >  .../pci/controller/dwc/pci-layerscape-ep.c    |  5 ++-
> >  drivers/pci/controller/dwc/pcie-keembay.c     |  8 +++--
> >  drivers/pci/controller/dwc/pcie-rcar-gen4.c   |  4 ++-
> >  drivers/pci/controller/dwc/pcie-tegra194.c    | 10 ++++--
> >  drivers/pci/controller/dwc/pcie-uniphier-ep.c | 15 ++++++--
> >  drivers/pci/controller/pcie-rcar-ep.c         | 14 +++++---
> >  drivers/pci/endpoint/functions/pci-epf-ntb.c  |  4 +--
> >  drivers/pci/endpoint/functions/pci-epf-test.c |  8 ++---
> >  drivers/pci/endpoint/functions/pci-epf-vntb.c |  2 +-
> >  drivers/pci/endpoint/pci-epc-core.c           | 32 +++++++++--------
> >  drivers/pci/endpoint/pci-epf-core.c           | 15 ++++----
> >  include/linux/pci-epc.h                       | 34 +++++++++++++++----
> >  14 files changed, 108 insertions(+), 58 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> > index dc2c036ab28c..47a9a96484ed 100644
> > --- a/drivers/pci/controller/dwc/pci-imx6.c
> > +++ b/drivers/pci/controller/dwc/pci-imx6.c
> > @@ -1081,7 +1081,8 @@ static const struct pci_epc_features imx8m_pcie_epc_features = {
> >  	.linkup_notifier = false,
> >  	.msi_capable = true,
> >  	.msix_capable = false,
> > -	.reserved_bar = 1 << BAR_1 | 1 << BAR_3,
> > +	.bar[BAR_1] = { .type = BAR_RESERVED, },
> > +	.bar[BAR_3] = { .type = BAR_RESERVED, },
> >  	.align = SZ_64K,
> >  };
> >  
> > diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
> > index c0c62533a3f1..b2b93b4fa82d 100644
> > --- a/drivers/pci/controller/dwc/pci-keystone.c
> > +++ b/drivers/pci/controller/dwc/pci-keystone.c
> > @@ -924,12 +924,12 @@ static const struct pci_epc_features ks_pcie_am654_epc_features = {
> >  	.linkup_notifier = false,
> >  	.msi_capable = true,
> >  	.msix_capable = true,
> > -	.reserved_bar = 1 << BAR_0 | 1 << BAR_1,
> > -	.bar_fixed_64bit = 1 << BAR_0,
> > -	.bar_fixed_size[2] = SZ_1M,
> > -	.bar_fixed_size[3] = SZ_64K,
> > -	.bar_fixed_size[4] = 256,
> > -	.bar_fixed_size[5] = SZ_1M,
> > +	.bar[BAR_0] = { .type = BAR_RESERVED, .only_64bit = true, },
> > +	.bar[BAR_1] = { .type = BAR_RESERVED, },
> > +	.bar[BAR_2] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> > +	.bar[BAR_3] = { .type = BAR_FIXED, .fixed_size = SZ_64K, },
> > +	.bar[BAR_4] = { .type = BAR_FIXED, .fixed_size = 256, },
> > +	.bar[BAR_5] = { .type = BAR_FIXED, .fixed_size = SZ_1M, },
> >  	.align = SZ_1M,
> >  };
> >  
> > diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > index 2e398494e7c0..1f6ee1460ec2 100644
> > --- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > +++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
> > @@ -250,7 +250,10 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
> >  	pci->dev = dev;
> >  	pci->ops = pcie->drvdata->dw_pcie_ops;
> >  
> > -	ls_epc->bar_fixed_64bit = (1 << BAR_2) | (1 << BAR_4);
> > +	ls_epc->bar[BAR_2].only_64bit = true;
> > +	ls_epc->bar[BAR_3].type = BAR_RESERVED;
> 
> BAR_3 and BAR_4 were not reserved previously.
> 

Okay, looking at patch 2 makes it clear why you have marked it as such. But it
should've been mentioned in the commit message.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

