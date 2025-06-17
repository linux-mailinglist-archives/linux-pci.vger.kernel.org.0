Return-Path: <linux-pci+bounces-29983-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CF42ADDE7C
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 00:05:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 426263AA00C
	for <lists+linux-pci@lfdr.de>; Tue, 17 Jun 2025 22:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0D26253350;
	Tue, 17 Jun 2025 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tz42bycT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9620FAB6
	for <linux-pci@vger.kernel.org>; Tue, 17 Jun 2025 22:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750197925; cv=none; b=ipYodbQHqqcCu6BQ31k4bCO+eTIjYTGWo+3ViZ/upxBGZS59ppKw87sniFgkYr9yjl2XF89XCgRGHqczjcI2jzkMSbmtBRQNUGJLDK2tWeqmii2CxXLRmmNQ5eD0Prqe+YD3RKafe3lzARhPGrTt3PIpCO49LFXuRiGJAEPh7ug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750197925; c=relaxed/simple;
	bh=QIFxvBnCg8PCPYSi3v2GFIu+Hyf6Y4rvlEki6zdPCNk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=ckm6UqGpZZSROouN6pfZrzlukCvCW0VPK6UCg4WMp+WgLmyvSWFO6LXaYPITH5y1WEzOY0VquAmeqUvlJwLhLoA25JVjTNTMCy4qTeqd/eGLoTaonn1CR5CQhbTRGBjqfCix8baQmOf/65+LrUhTibDUFYgV1itNPJVVk/ox+bI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tz42bycT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE98C4CEE3;
	Tue, 17 Jun 2025 22:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750197925;
	bh=QIFxvBnCg8PCPYSi3v2GFIu+Hyf6Y4rvlEki6zdPCNk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=Tz42bycTE9uBK78yGj7A7SwCEIwA6LWcFlKJWGI+vfbCjQJkahp5z2aALe/4EZfER
	 bLcMWfTId/XcJNKrPy9o/uX3z+nIFrL2IFDAgYlfyrundlIDvlf3wv5qL6XgBIdvH6
	 3VxI1iNCpnzmWvoEoMVi0MG7TXcISthodgcUNpCgUfV65tgb5dYC1B9XgHT5xppWal
	 ZED4YVZnz5ODoKVVyDbXGLrfktTyZJKdtRlzNxnlw+enPVSGAvcu67hZYce9z/plHF
	 Cxy2zXx3Ef775rP77Rkt+aWoFLhurH+gGduycHoNWAzWfzWHM+Og2lCrPXDI/3aaYL
	 5ndTNAw9nxepQ==
Date: Tue, 17 Jun 2025 17:05:23 -0500
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
Message-ID: <20250617220523.GA1157905@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250617220114.GA1156610@bhelgaas>

On Tue, Jun 17, 2025 at 05:01:16PM -0500, Bjorn Helgaas wrote:
> On Fri, Jun 13, 2025 at 12:19:09PM +0200, Niklas Cassel wrote:
> > From: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > 
> > RK3588 TRM, section "11.6.1.3.3 Hot Reset and Link-Down Reset" states that:
> > """
> > If you want to delay link re-establishment (after reset) so that you can
> > reprogram some registers through DBI, you must set app_ltssm_enable =0
> > immediately after core_rst_n as shown in above. This can be achieved by
> > enable the app_dly2_en, and end-up the delay by assert app_dly2_done.
> > """
> 
> Ugh.  Is """ some sort of markup?  There's a nice English convention
> of indenting block quotes a couple spaces with no quote marks at all
> that would work nicely here.
> 
> > I.e. setting app_dly2_en will automatically deassert app_ltssm_enable on
> > a hot reset, and setting app_dly2_done will re-assert app_ltssm_enable,
> > re-enabling link training.
> > 
> > When receiving a hot reset/link-down IRQ when running in EP mode, we will
> > call dw_pcie_ep_linkdown(), which will call the .link_down() callback in
> > the currently bound endpoint function (EPF) drivers.
> > 
> > The callback in an EPF driver can theoretically take a long time to
> > complete, so make sure that the link is not re-established until after
> > dw_pcie_ep_linkdown() (which calls the .link_down() callback(s)
> > synchronously).
> 
> I don't know why we care *how long* EPF callbacks might take.  
> 
> From the TRM quote, it sounds like the important thing is that you
> don't want the link to train before dw_pcie_ep_linkdown() calls
> dw_pcie_ep_init_non_sticky_registers(), which looks like it programs
> registers through DBI.
> 
> Maybe you also want to allow the EFP ->link_down() callbacks to also
> program things via DBI before link training?  But I don't think the
> amount of time they take is relevant.  If you need to do *anything*
> via DBI before the link trains, you have to prevent training until
> you're finished with DBI.

Oh, and this sets PCIE_LTSSM_ENABLE_ENHANCE | PCIE_LTSSM_APP_DLY2_EN
once at probe-time, but what about after a link-down/link-up cycle?

Don't we need to set PCIE_LTSSM_ENABLE_ENHANCE |
PCIE_LTSSM_APP_DLY2_EN again when the link comes up so we don't have
the same race when the link goes down again?

> > Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
> > Co-developed-by: Niklas Cassel <cassel@kernel.org>
> > Signed-off-by: Niklas Cassel <cassel@kernel.org>
> > ---
> > Changes since v1:
> > -Rebased on v6.16-rc1
> > 
> >  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > index 93171a392879..cd1e9352b21f 100644
> > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > @@ -58,6 +58,8 @@
> >  
> >  /* Hot Reset Control Register */
> >  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
> > +#define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
> > +#define  PCIE_LTSSM_APP_DLY2_DONE	BIT(3)
> >  #define  PCIE_LTSSM_ENABLE_ENHANCE	BIT(4)
> >  
> >  /* LTSSM Status Register */
> > @@ -474,7 +476,7 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> >  	struct rockchip_pcie *rockchip = arg;
> >  	struct dw_pcie *pci = &rockchip->pci;
> >  	struct device *dev = pci->dev;
> > -	u32 reg;
> > +	u32 reg, val;
> >  
> >  	reg = rockchip_pcie_readl_apb(rockchip, PCIE_CLIENT_INTR_STATUS_MISC);
> >  	rockchip_pcie_writel_apb(rockchip, reg, PCIE_CLIENT_INTR_STATUS_MISC);
> > @@ -485,6 +487,10 @@ static irqreturn_t rockchip_pcie_ep_sys_irq_thread(int irq, void *arg)
> >  	if (reg & PCIE_LINK_REQ_RST_NOT_INT) {
> >  		dev_dbg(dev, "hot reset or link-down reset\n");
> >  		dw_pcie_ep_linkdown(&pci->ep);
> > +		/* Stop delaying link training. */
> > +		val = HIWORD_UPDATE_BIT(PCIE_LTSSM_APP_DLY2_DONE);
> > +		rockchip_pcie_writel_apb(rockchip, val,
> > +					 PCIE_CLIENT_HOT_RESET_CTRL);
> >  	}
> >  
> >  	if (reg & PCIE_RDLH_LINK_UP_CHGED) {
> > @@ -566,8 +572,11 @@ static int rockchip_pcie_configure_ep(struct platform_device *pdev,
> >  		return ret;
> >  	}
> >  
> > -	/* LTSSM enable control mode */
> > -	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE);
> > +	/*
> > +	 * LTSSM enable control mode, and automatically delay link training on
> > +	 * hot reset/link-down reset.
> > +	 */
> > +	val = HIWORD_UPDATE_BIT(PCIE_LTSSM_ENABLE_ENHANCE | PCIE_LTSSM_APP_DLY2_EN);
> >  	rockchip_pcie_writel_apb(rockchip, val, PCIE_CLIENT_HOT_RESET_CTRL);
> >  
> >  	rockchip_pcie_writel_apb(rockchip, PCIE_CLIENT_EP_MODE,
> > -- 
> > 2.49.0
> > 

