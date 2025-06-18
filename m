Return-Path: <linux-pci+bounces-30134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0E78ADF759
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 22:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 419711893911
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 20:00:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C7E219E8D;
	Wed, 18 Jun 2025 20:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cpmemycc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A091E49F
	for <linux-pci@vger.kernel.org>; Wed, 18 Jun 2025 20:00:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750276801; cv=none; b=hV9AgITdAq5X0oDuLdfLomqbn0XqttcvCbfTzLZ0e2/E5ZbK2llFDdgEsm7+GosN542kQ0A4OFGAMfblgPBHTs8W+W2AEjBPtIybSetkFcd3C3NGF7hR621LgThiYlaor0joysT8gA6EWx9Z5FsRDnjWCsjtVBibUgOoRjfVWDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750276801; c=relaxed/simple;
	bh=17kMqqV2ycHKCOyxqMMkvfJ7prHu4LE53MHR0Y7F7Uw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=So2cpXt+XRSxm1tGAr/j48+6I+AD+lhhQxJXMRBSOKb7BO6C85lHAw5Jg88q7/kf1ImTNIKjzXRs0oD0AurS6xDMbe/yIzCyZN1GdxmBDw71/iFFdTGXKFyTHSnzCp7YFhrfIASHaHuKk9wpZCxQSe0qO9rkSiD+X4of31U7vbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cpmemycc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B085C4CEE7;
	Wed, 18 Jun 2025 20:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750276801;
	bh=17kMqqV2ycHKCOyxqMMkvfJ7prHu4LE53MHR0Y7F7Uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=cpmemyccfMpxv0hWcdB2djaeGPM/TqbQafJZRDyKYb/ueoOwIV3W1m/f1wEV+S6uo
	 RVkgNhJwz/qh2A1d4DP/b730nJLm/Mqy38Tr9TocHpmMzfafi6jgna2b64bpHyJBDF
	 kxHFkNmX3bz5fMkmz45MQqAVryAxyAiVz62y4zyK0xVEeQazJ4uGNakz/JXsY4SV1p
	 pO3Wh3gzpKHx74UIRIeRhebLxEwlEZ+D5JogB9kyOUPwOUoQqPinfsT709FiL1tkbI
	 /v+8WTEhow/fZyFgk6sOgU/6WF/ZWuAwplK+kaJvm0ygwvFSzhcqnyRApmzpV2LJ+Q
	 f0RqJv61u6NkA==
Date: Wed, 18 Jun 2025 14:59:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v2] PCI: dw-rockchip: Delay link training after hot reset
 in EP mode
Message-ID: <20250618195959.GA1207191@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFLHYfs1iDgwMdcp@ryzen>

On Wed, Jun 18, 2025 at 04:04:17PM +0200, Niklas Cassel wrote:
> On Tue, Jun 17, 2025 at 05:01:14PM -0500, Bjorn Helgaas wrote:
> > On Fri, Jun 13, 2025 at 12:19:09PM +0200, Niklas Cassel wrote:
> > > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > > 
> > > RK3588 TRM, section "11.6.1.3.3 Hot Reset and Link-Down Reset" states that:
> > > """
> > > If you want to delay link re-establishment (after reset) so that you can
> > > reprogram some registers through DBI, you must set app_ltssm_enable =0
> > > immediately after core_rst_n as shown in above. This can be achieved by
> > > enable the app_dly2_en, and end-up the delay by assert app_dly2_done.
> > > """
> > >
> > > I.e. setting app_dly2_en will automatically deassert app_ltssm_enable on
> > > a hot reset, and setting app_dly2_done will re-assert app_ltssm_enable,
> > > re-enabling link training.
> > > 
> > > When receiving a hot reset/link-down IRQ when running in EP mode, we will
> > > call dw_pcie_ep_linkdown(), which will call the .link_down() callback in
> > > the currently bound endpoint function (EPF) drivers.
> > > 
> > > The callback in an EPF driver can theoretically take a long time to
> > > complete, so make sure that the link is not re-established until after
> > > dw_pcie_ep_linkdown() (which calls the .link_down() callback(s)
> > > synchronously).
> > 
> > I don't know why we care *how long* EPF callbacks might take.
> 
> Well, because currently, we do NOT delay link training, and everything
> works as expected.
> 
> Most likely we are just lucky, because dw_pcie_ep_linkdown() calls
> dw_pcie_ep_init_non_sticky_registers(), which is quite a short function.

I'm just making the point that IIUC there's a race between link
training and any DBI accesses done by
dw_pcie_ep_init_non_sticky_registers() and potentially EPF callbacks,
and the time those paths take is immaterial.

If this is indeed a race and this patch is the fix, I think it's
misleading to describe it as "this path might take a long time and
lose the race."  We have to assume arbitrary delays can be added to
either path, so we can never rely on a path being "fast enough" to
avoid the race.

Is the following basically what we're doing?

  Set PCIE_LTSSM_APP_DLY2_EN so the controller never automatically
  trains the link after a link-down interrupt.  That way any DBI
  updates done in the dw_pcie_ep_linkdown() path will happen while the
  link is still down.  Then allow link training by setting
  PCIE_LTSSM_APP_DLY2_DONE.

We don't set PCIE_LTSSM_APP_DLY2_DONE anywhere in the initial probe
path.  Obviously the link must train in that case, so I guess
PCIE_LTSSM_APP_DLY2_EN only applies to the case of link state
transition from link-up to link-down?

> During a hot reset, the BARs get resized to 1 GB (yes, that is the
> default/reset value on rk3588), so the fact that the host sees a smaller
> BAR size means that dw_pcie_ep_init_non_sticky_registers() must have had
> time to run before link training completed.
> 
> But we do not want to rely on luck for these DBI writes to finish before
> link training is complete, hence this patch.
> 
> The .link_down() callback in drivers/pci/endpoint/functions/pci-epf-test.c
> simply does a cancel_delayed_work_sync().
> 
> I could imagine an EPF driver doing some more time consuming work in the
> callback, like allocating memory (which could trigger direct reclaim), and
> then calling pci_epc_set_bar() which will eventually result in some DBI
> writes. That most likely would not work without this patch.
> 
> > From the TRM quote, it sounds like the important thing is that you
> > don't want the link to train before dw_pcie_ep_linkdown() calls
> > dw_pcie_ep_init_non_sticky_registers(), which looks like it programs
> > registers through DBI.
> > 
> > Maybe you also want to allow the EFP ->link_down() callbacks to also
> > program things via DBI before link training?  But I don't think the
> > amount of time they take is relevant.  If you need to do *anything*
> > via DBI before the link trains, you have to prevent training until
> > you're finished with DBI.
> > 
> > > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > > Co-developed-by: Niklas Cassel <cassel@kernel.org>
> > > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > > ---
> > > Changes since v1:
> > > -Rebased on v6.16-rc1
> > > 
> > >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 ++++++++++++---
> > >  1 file changed, 12 insertions(+), 3 deletions(-)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > index 93171a392879..cd1e9352b21f 100644
> > > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > @@ -58,6 +58,8 @@
> > >  
> > >  /* Hot Reset Control Register */
> > >  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
> > > +#define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
> > > +#define  PCIE_LTSSM_APP_DLY2_DONE	BIT(3)
> > >  #define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
> > >  
> > >  /* LTSSM Status Register */
> > > @@ -474,7 +476,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> > >  	struct rockchip_pcie *rockchip = arg;
> > >  	struct dw_pcie *pci = &rockchip->pci;
> > >  	struct device *dev = pci->dev;
> > > -	u32 reg;
> > > +	u32 reg, val;
> > >  
> > >  	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
> > >  	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
> > > @@ -485,6 +487,10 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> > >  	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
> > >  		dev_dbg(dev, "hot reset or link-down reset\n");
> > >  		dw_pcie_ep_linkdown(&pci->ep);
> > > +		/* Stop delaying link training. */
> > > +		val = HIWORD_UPDATE_BIT(PCIE_LTSSM_APP_DLY2_DONE);
> > > +		rockchip_pcie_writel_apb(rockchip, val,
> > > +					 PCIE_CLIENT_HOT_RESET_CTRL);
> > >  	}
> > >  
> > >  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> > > @@ -566,8 +572,11 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
> > >  		return ret;
> > >  	}
> > >  
> > > -	/* LTSSM enable control mode */
> > > -	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> > > +	/*
> > > +	 * LTSSM enable control mode, and automatically delay link training on
> > > +	 * hot reset/link-down reset.
> > > +	 */
> > > +	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE | PCIE_LTSSM_APP_DLY2_EN);
> > >  	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> > >  
> > >  	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_EP_MODE,
> > > -- 
> > > 2.49.0
> > > 

