Return-Path: <linux-pci+bounces-8445-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 336AC900169
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 13:01:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BFF482844FC
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jun 2024 11:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62A41862BF;
	Fri,  7 Jun 2024 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWX2WR2H"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B13D187326;
	Fri,  7 Jun 2024 11:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717758073; cv=none; b=R3LN6NXaHjpAP2FMGUxEOmP86YjjkxT1r9do54rrDgI6d6kKRo0IWemQcW6EaMYYKkCWDVlsngb1YGyuvwaIeGN1yEUom9YP7nhrP8QcM6jOvcX9zyFCGwAMGOPXeJa6vu5oOLiz/1hFBYNbImAEklw2W4paxhVoRirfyTUnf/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717758073; c=relaxed/simple;
	bh=mtUu/Do/GLFHawm+/M8nMC7SPdHfBpSjez+ss4kMKsU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HeEgIvLlfC6sCGPeYFBqQ0SCM1cLqO9QuOrlEVYhvhV02BCvIA/s9/ZpPbvlr3PJeI9mNQTSa+iljPD+xBtPekOryeAqOPoUoCBJxB71LREOmeBfy3+iKTBlrJN1gUdBpyhr4K4MRl5WyDcjzhQW28sqLNT16vBiV9AAA3JR88w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWX2WR2H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28329C32781;
	Fri,  7 Jun 2024 11:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717758073;
	bh=mtUu/Do/GLFHawm+/M8nMC7SPdHfBpSjez+ss4kMKsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RWX2WR2HyLq3+UnPfPsnprPOtIaGzcPc1bsnV3duitv/Bf6mCReB5QJQvbQadEPEc
	 iKETSHuQKnY+eo2jADupxpJMgxzbTWoXNji08JTXAIy9E7r8Is/yuqxpYZPJjxy3z3
	 Rbk0zriDNPXJudyRc7WhjrjSUanOnDvVfn8GFQeA5LxnGgkcCKpGy59iE2rM9PO7lS
	 yJrN5hb4wgV3KPzMkKCkWsD/nyx2WxfsgGGTX8AEDqp2kfZw722eLixAzwxwEOh3QF
	 f33GQedooaDeqwMRceIHZLlxhbwXDo5r1wYWn9l9DBKVR+Jyv+BTgKyi7Dv1Qh9f3P
	 nYOzC0lEjv4GQ==
Date: Fri, 7 Jun 2024 13:01:06 +0200
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
Message-ID: <ZmLocvA9HwomzrED@ryzen.lan>
References: <20240529-rockchip-pcie-ep-v1-v4-0-3dc00fe21a78@kernel.org>
 <20240529-rockchip-pcie-ep-v1-v4-10-3dc00fe21a78@kernel.org>
 <20240605081753.GK5085@thinkpad>
 <ZmC1PihX_URtZkiA@ryzen.lan>
 <20240606063128.GC4441@thinkpad>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240606063128.GC4441@thinkpad>

On Thu, Jun 06, 2024 at 12:01:28PM +0530, Manivannan Sadhasivam wrote:
> On Wed, Jun 05, 2024 at 08:58:06PM +0200, Niklas Cassel wrote:
> > On Wed, Jun 05, 2024 at 01:47:53PM +0530, Manivannan Sadhasivam wrote:
> > > On Wed, May 29, 2024 at 10:29:04AM +0200, Niklas Cassel wrote:
> > > > The PCIe controller in rk3568 and rk3588 can operate in endpoint mode.
> > > > This endpoint mode support heavily leverages the existing code in
> > > > pcie-designware-ep.c.
> > > > 
> > > > Add support for endpoint mode to the existing pcie-dw-rockchip glue
> > > > driver.
> > > > 
> > > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > 
> > > Couple of comments below. With those addressed,
> > > 
> > > Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> > > 
> > > > ---
> > > >  drivers/pci/controller/dwc/Kconfig            |  17 ++-
> > > >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 210 ++++++++++++++++++++++++++
> > > >  2 files changed, 224 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
> > > > index 8afacc90c63b..9fae0d977271 100644
> > > > --- a/drivers/pci/controller/dwc/Kconfig
> > > > +++ b/drivers/pci/controller/dwc/Kconfig
> > > > @@ -311,16 +311,27 @@ config PCIE_RCAR_GEN4_EP
> > > >  	  SoCs. To compile this driver as a module, choose M here: the module
> > > >  	  will be called pcie-rcar-gen4.ko. This uses the DesignWare core.
> > > >  
> > > > +config PCIE_ROCKCHIP_DW
> > > > +	bool
> > > 
> > > Where is this symbol used?
> > 
> > It is supposed to be used by
> > drivers/pci/controller/dwc/Makefile
> > 
> > such that the driver is compiled if either _EP or _HOST is selected, just
> > like how it is done for other drivers that support both in the same driver.
> > Looks like I missed to update Makefile...
> > Good catch, thank you!
> > 
> > 
> > > > +static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> > > > +{
> > > > +	struct rockchip_pcie *rockchip = arg;
> > > > +	struct dw_pcie *pci = &rockchip->pci;
> > > > +	struct device *dev = pci->dev;
> > > > +	u32 reg, val;
> > > > +
> > > > +	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
> > > > +
> > > > +	dev_dbg(dev, "PCIE_CLIENT_INTR_STATUS_MISC: %#x\n", reg);
> > > > +	dev_dbg(dev, "LTSSM_STATUS: %#x\n", rockchip_pcie_get_ltssm(rockchip));
> > > > +
> > > > +	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
> > > > +		dev_dbg(dev, "hot reset or link-down reset\n");
> > > > +		dw_pcie_ep_linkdown(&pci->ep);
> > > > +	}
> > > > +
> > > > +	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> > > > +		val = rockchip_pcie_get_ltssm(rockchip);
> > > > +		if ((val & PCIE_LINKUP) == PCIE_LINKUP) {
> > > > +			dev_dbg(dev, "link up\n");
> > > > +			dw_pcie_ep_linkup(&pci->ep);
> > > > +		}
> > > > +	}
> > > > +
> > > > +	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
> > > 
> > > It is recommended to clear the IRQs at the start of the handler (after status
> > > read).
> > 
> > Can you quote a reference in the databook to back this recommendation?
> > 
> 
> It is just a general recommendation.
> 
> > Otherwise I would lean towards keeping it like it is, since this is how
> > it looks in the downstream driver (that *should* be well proven), and it
> > also matches how it's done in dra7xx.
> > 
> > (And since you ack only the events you read, you can not accidentally
> > clear another type of event.)
> > 
> 
> I haven't read the TRM, but if the IRQ line is level triggered, then if you do
> not clear the IRQs immediately, you will miss some events. So I always suggest
> to clear the IRQs at the start of the handler for all the platforms.

They are level triggered.
In this specific case, what could happen is that we fail to trigger an IRQ
if we get two succeeding hot/link-down resets, or two succeding link ups.

In neither case is this a serious case (compared to e.g. a host driver
missing a MSI irq), but I have incorporated your suggestion for v5,
thank you!


Kind regards,
Niklas

