Return-Path: <linux-pci+bounces-8356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 926198FD622
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 20:58:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C981C21AD3
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2024 18:58:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBAA013A890;
	Wed,  5 Jun 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o/WvTLK9"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413B2F2B;
	Wed,  5 Jun 2024 18:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717613893; cv=none; b=fBVHnIio3aXgvc44uuATLiTfaTmyhxxWw0xEmm3IR5GMkOAnN59m/clsCBpuDqHmkM9VF5I6mnGgMx0XSU6H2k01Js7mpiOJfCrPgY57cWOcMG5xuFxC+BQrY9SPx39hxufXYexHVyB6W6mhYFnsrKnG1MDkdVg5GSPyhZkqrVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717613893; c=relaxed/simple;
	bh=edwYIQhi5xJlid5p6CUQtIooEcXgYOFH67Ql7fSl3LU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ekGU19FHzBBVTBHzLtOGo4f9slDBsDOH2GSY0U702P3iHNXw0b+mzj10xvqMNKsZ5dQe+RbRF9ymdSo+nZTTyNlx345y/sow4rYvVKQ7G0Fijwe9aW5Nz1ICk56zi3PFa2OAspGIJHTkURrKIOAoYI2k+T6vdCcjOl2LolBlDE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o/WvTLK9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CA5BC32786;
	Wed,  5 Jun 2024 18:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717613893;
	bh=edwYIQhi5xJlid5p6CUQtIooEcXgYOFH67Ql7fSl3LU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=o/WvTLK9S3cDugTGwh4kH5BuHLNJQ2sMV0RUiVIC5JBQOyX5Lzv/l7h7hgAbJ7OaU
	 VYL1myoqW9NVfTpjZ7GRGpsTRDcwNB01jZIE1sNwlwdhFvGxaMUDFYfB/d8iiEOZ0e
	 4bwkjLKdawwnXKK8tgiCfXtTrtX2RcFRMTYFboGo/RGGVIxCMl2AgD09slNXSm/9ew
	 gNFibCi7KS4DN7c5CTq7v5bS64/frimmJj8rGwGqFBt/qlDDEsOpjIRCmjiTQFM52a
	 200omJjc33t+0KfmNwHVHs61Y+6gFtAS3JuOSqT0zIF4odJEr0Xs2Mh23MYWMLJiFO
	 eoTcOHbrrbB0g==
Date: Wed, 5 Jun 2024 20:58:06 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jingoo Han <jingoohan1@gmail.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, Damien Le Moal <dlemoal@kernel.org>,
	Jon Lin <jon.lin@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, linux-pci@vger.kernel.org,
	devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v4 10/13] PCI: dw-rockchip: Add endpoint mode support
Message-ID: <ZmC1PihX_URtZkiA@ryzen.lan>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-10-3dc00fe21a78@kernel.org>
 <20240605081753.GK5085@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240605081753.GK5085@thinkpad>

On Wed, Jun 05, 2024 at 01:47:53PM +0530, Manivannan Sadhasivam wrote:
> On Wed, May 29, 2024 at 10:29:04AM +0200, Niklas Cassel wrote:
> > The PCIe controller in rk3568 and rk3588 can operate in endpoint mode.
> > This endpoint mode support heavily leverages the existing code in
> > pcie-designware-ep.c.
> > 
> > Add support for endpoint mode to the existing pcie-dw-rockchip glue
> > driver.
> > 
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> 
> Couple of comments below. With those addressed,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> 
> > ---
> >  drivers/pci/controller/dwc/Kconfig            |  17 ++-
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 210 ++++++++++++++++++++++++++
> >  2 files changed, 224 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > index 8afacc90c63b..9fae0d977271 100644
> > --- a/drivers/pci/controller/dwc/Kconfig
> > +++ b/drivers/pci/controller/dwc/Kconfig
> > @@ -311,16 +311,27 @@ config PCIE_RCAR_GEN4_EP
> >  	  SoCs. To compile this driver as a module, choose M here: the module
> >  	  will be called pcie-rcar-gen4.ko. This uses the DesignWare core.
> >  
> > +config PCIE_ROCKCHIP_DW
> > +	bool
> 
> Where is this symbol used?

It is supposed to be used by
drivers/pci/controller/dwc/Makefile

such that the driver is compiled if either _EP or _HOST is selected, just
like how it is done for other drivers that support both in the same driver.
Looks like I missed to update Makefile...
Good catch, thank you!


> > +static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> > +{
> > +	struct rockchip_pcie *rockchip = arg;
> > +	struct dw_pcie *pci = &rockchip->pci;
> > +	struct device *dev = pci->dev;
> > +	u32 reg, val;
> > +
> > +	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
> > +
> > +	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
> > +	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
> > +
> > +	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
> > +		dev_dbg(dev, "hot reset or link-down reset\n");
> > +		dw_pcie_ep_linkdown(&pci->ep);
> > +	}
> > +
> > +	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> > +		val = rockchip_pcie_get_ltssm(rockchip);
> > +		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
> > +			dev_dbg(dev, "link up\n");
> > +			dw_pcie_ep_linkup(&pci->ep);
> > +		}
> > +	}
> > +
> > +	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
> 
> It is recommended to clear the IRQs at the start of the handler (after status
> read).

Can you quote a reference in the databook to back this recommendation?

Otherwise I would lean towards keeping it like it is, since this is how
it looks in the downstream driver (that *should* be well proven), and it
also matches how it's done in dra7xx.

(And since you ack only the events you read, you can not accidentally
clear another type of event.)


Kind regards,
Niklas

