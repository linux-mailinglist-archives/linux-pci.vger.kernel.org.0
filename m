Return-Path: <linux-pci+bounces-39037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 282B5BFD019
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 18:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2EFD23AE13E
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 16:03:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0212926F2B9;
	Wed, 22 Oct 2025 16:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1p9+rVP"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C78C226C384
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761148999; cv=none; b=porfNcrSKsUDQW61kGkq3pMqcRRhSyC0Mb8L4MlrmnGPZTEvLHUIGJyQep4pVz+1faQns8VBnYYlj/Owo8+3SL5iJGhGXpsxeXJsPccNysluZKGcZH6n9BG4HcgSOHJIbQ0Gtaq2QdMtNtHHxfvSns1QyJ+eNNxoqraj/HSwGEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761148999; c=relaxed/simple;
	bh=Zj2hHQ0ohfNbVKby56bYckABr1jnzLcd09PkIpBORnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tjnHlhFeO4jj9/384B0Pm/iaTwjuQmV1XI0KOTnMNDxdEqHPF67mC4lN/mJXt2k2m6wh3PMY/1Bb6O6tdT/xUJ063zyClRSPbKoUazyXwBWI/GSHiHPK65PRWDedSgh1I8mID+q01IyNeeklVKxTkNZ6lPyakRH3NfcYaodev6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D1p9+rVP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD19AC4CEE7;
	Wed, 22 Oct 2025 16:03:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761148999;
	bh=Zj2hHQ0ohfNbVKby56bYckABr1jnzLcd09PkIpBORnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D1p9+rVPngvQclintw+lcPANK7Gb1RWT7PuR+SGJ1yjEJSxDMPzxUtVlEseCBws2r
	 DiRduFYd6oA5NCrgVG/tmDR37QAw0Chbyc3lVxBrx9wCFouPha6pnXrHqC7hx82Q+f
	 v6y+3nrR1HU4Db2+Kgq6AOzb3mL0cHTvjNiUVODLafRGs/F8Ifas1G22Kpe5vma9Zt
	 4O5sWTNzt0J/LxicUyprx/rQAW7lLkTCBeAFf3qk3rPKNGJKtDaM0BcN4OCa7Czeer
	 t700Wm3YC7csAqqwuduDVvlun3J4Lp7EV14lMf8BUoesyAqrxohA7FuaF0SJ6eIbI8
	 GD2YWIBnf4hsA==
Date: Wed, 22 Oct 2025 21:33:09 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dw-rockchip: Add L1sub support
Message-ID: <6aazm6t2j5qhdg5njlvzivnmtdomfewy54ap37efv7tbgn3rkq@kjiwmtrciyvq>
References: <1761132954-177344-1-git-send-email-shawn.lin@rock-chips.com>
 <lvixfsccgsodm4hfwxejofjnms5l7xhcskn7fgfdxryfs3ez7z@fh6uajlce6x6>
 <988940fe-7cc3-4b24-b02d-f6e1d28145b7@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <988940fe-7cc3-4b24-b02d-f6e1d28145b7@rock-chips.com>

On Wed, Oct 22, 2025 at 10:27:39PM +0800, Shawn Lin wrote:
> 
> 在 2025/10/22 星期三 21:04, Manivannan Sadhasivam 写道:
> > On Wed, Oct 22, 2025 at 07:35:53PM +0800, Shawn Lin wrote:
> > > The driver should set app_clk_req_n(clkreq ready) of PCIE_CLIENT_POWER reg
> > > to support L1sub. Otherwise, unset app_clk_req_n and pull down CLKREQ#.
> > > 
> > 
> > You can definitely improve the commit message on explaining why L1 PM Substates
> > need to be disabled when the DT property is not present etc... Please refer the
> > patch from Niklas.
> 
> Will do.
> 
> > 
> > > Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> > > 
> > > ---
> > > 
> > > Changes in v2:
> > > - drop of_pci_clkreq_presnt API
> > > - drop dependency of Niklas's patch
> > > 
> > >   drivers/pci/controller/dwc/pcie-dw-rockchip.c | 36 +++++++++++++++++++++++++++
> > >   1 file changed, 36 insertions(+)
> > > 
> > > diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > index 3e2752c..18cd626 100644
> > > --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> > > @@ -62,6 +62,12 @@
> > >   /* Interrupt Mask Register Related to Miscellaneous Operation */
> > >   #define PCIE_CLIENT_INTR_MASK_MISC	0x24
> > > +/* Power Management Control Register */
> > > +#define PCIE_CLIENT_POWER		0x2c
> > > +#define  PCIE_CLKREQ_READY		0x10001
> > > +#define  PCIE_CLKREQ_NOT_READY		0x10000
> > > +#define  PCIE_CLKREQ_PULL_DOWN		0x30001000
> > 
> > Can you use bitfields instead of magic values?
> 
> Of course, will fix.
> 
> > 
> > > +
> > >   /* Hot Reset Control Register */
> > >   #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
> > >   #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
> > > @@ -85,6 +91,7 @@ struct rockchip_pcie {
> > >   	struct regulator *vpcie3v3;
> > >   	struct irq_domain *irq_domain;
> > >   	const struct rockchip_pcie_of_data *data;
> > > +	bool supports_clkreq;
> > >   };
> > >   struct rockchip_pcie_of_data {
> > > @@ -200,6 +207,31 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
> > >   	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
> > >   }
> > > +static void rockchip_pcie_enable_l1sub(struct dw_pcie *pci)
> > 
> > rockchip_pcie_configure_l1sub()? since this function is not just enabling L1ss.
> > 
> > > +{
> > > +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> > > +	u32 cap, l1subcap;
> > > +
> > > +	/* Enable L1 substates if CLKREQ# is properly connected */
> > > +	if (rockchip->supports_clkreq) {
> > > +		/* Ready to have reference clock removed */
> > 
> > This comment is misleading (maybe wrong). The presence of this property implies
> > that the link could enter L1 PM Substates. REFCLK removal only happens when the
> > link is in L1ss.
> > 
> > So drop the comment.
> 
> Will drop.
> 
> > 
> > > +		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, PCIE_CLIENT_POWER);
> > > +		return;
> > > +	}
> > > +
> > > +	/* Otherwise, pull down CLKREQ# and disable L1 substates */
> > 
> > "L1 PM Substates"
> > 
> > > +	rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
> > > +				 PCIE_CLIENT_POWER);
> > > +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> > > +	if (cap) {
> > > +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> > > +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> > > +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> > > +			      PCI_L1SS_CAP_PCIPM_L1_2);
> > > +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> > > +	}
> > > +}
> > > +
> > >   static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
> > >   {
> > >   	u32 cap, lnkcap;
> > > @@ -264,6 +296,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
> > >   	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
> > >   					 rockchip);
> > > +	rockchip_pcie_enable_l1sub(pci);
> > >   	rockchip_pcie_enable_l0s(pci);
> > >   	return 0;
> > > @@ -301,6 +334,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
> > >   	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
> > >   	enum pci_barno bar;
> > > +	rockchip_pcie_enable_l1sub(pci);
> > 
> > I don't think you can decide the CLKREQ# routing on the EP side. The
> > 'supports-clkreq' property is meant only for the RC afaik.
> 
> You are right, we cannot decide the CLKREQ# routing on the EP side. But
> what I have in mind is we at least need to set pinmux to CLKREQ function
> because on Rockchip platforms, the CLKREQ# of EP mode could also be used
> as GPIO or other funcions if guys never need L1ss to be supported.
> 

You don't need to configure pinmux in the driver manually. If the platform
desginer knows that CLKREQ# is not used in the endpoint, then the corresponding
pinmux state can be set to non-CLKREQ# function in DT.

I was assuming that CLKREQ# assert/deassert is handled by the endpoint
controller hw without endpoint software intervention.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

