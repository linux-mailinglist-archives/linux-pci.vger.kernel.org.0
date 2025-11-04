Return-Path: <linux-pci+bounces-40299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74FEEC332FC
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 23:21:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3450718C59D9
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 22:19:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 512971A8F84;
	Tue,  4 Nov 2025 22:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gwgMheG/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CF330CDB3;
	Tue,  4 Nov 2025 22:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762294646; cv=none; b=Xds2aB9uaaGAT+gq74QaKWrYqDUz97LiBGYtjZN3bAEzxrQSqLJxCzDCXOREYisenr4cWOihJ/kOliCDPrVhjwv5kOIja5gGJ46oroafypuuYPK8YWLrEXy2fksDxVbbocpqAIzg5S5fFcEuJPakrj2w4w2CLimpg6IH2NHGevA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762294646; c=relaxed/simple;
	bh=GPnXKcnSWDO6n2Vnl3gr4/8tfcpo5ILwTjAVUvTUtEg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=FZQuzTukE7rvZ2ykC0qzaxuZ4CA9O2gtC50TxA/FGFFmGDZi7Dkl9xlmA7Fag68TMDq2mWOXJHu/oJuluPlAZfyCSdhALlWIfY2++B34JKyGxO3OylQDQk2leV0nvkSSNTWUDsYmBmkbjbubBqKHgCgS6WTlz1VC1qbEZ5bcvPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gwgMheG/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95707C4CEF7;
	Tue,  4 Nov 2025 22:17:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762294645;
	bh=GPnXKcnSWDO6n2Vnl3gr4/8tfcpo5ILwTjAVUvTUtEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=gwgMheG/Lqh9MW9jqrIe6oalohogZJoSuM/jTZ+BNjDgyBNu6WnB4Ar+UjoLS9L47
	 XxesL+NxPDSS+3+XW6a4hNunMJYu6PjYv37oovpvdY0by3dheB+8hy7w8VBO85bteS
	 yqHXt9j95V70w409wLIUDlTD/cyS+k0BVYfJ6N1FYpp405k9soSebrH5Gvb+39iP93
	 kSJbbMC657OBONgwKaq4MwdhZW31dczdiY7tHvf2R4MkCUAhqpUCJZ0DmryQRl924r
	 uT8/YRvEtBgo37maJtTCeTh7h4nSZwtp62glfFjYXQxKYiZlaHiQSA3RMJJCejTPwk
	 hl5rS2II+oyWg==
Date: Tue, 4 Nov 2025 16:17:24 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>, stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Prevent advertising L1 Substates
 support
Message-ID: <20251104221724.GA1875081@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0e32766b-b951-4ab4-ae3d-c802cf649edf@rock-chips.com>

On Tue, Nov 04, 2025 at 08:58:02AM +0800, Shawn Lin wrote:
> 在 2025/11/04 星期二 5:32, Bjorn Helgaas 写道:
> > On Tue, Oct 28, 2025 at 02:02:18PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Oct 17, 2025 at 06:32:53PM +0200, Niklas Cassel wrote:
> > > > The L1 substates support requires additional steps to work, namely:
> > > > -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
> > > >   hardware, but software still needs to set the clkreq fields in the
> > > >   PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
> > > > -Program the frequency of the aux clock into the
> > > >   DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
> > > >   is turned off and the aux_clk is used instead.)
> > > ...
> > 
> > > > +static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
> > > > +{
> > > > +	u32 cap, l1subcap;
> > > > +
> > > > +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> > > > +	if (cap) {
> > > > +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> > > > +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> > > > +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> > > > +			      PCI_L1SS_CAP_PCIPM_L1_2);
> > > > +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> > > > +	}
> > > > +}
> > > 
> > > I like this.  But why should we do it just for dw-rockchip?  Is there
> > > something special about dw-rockchip that makes this a problem?  Maybe
> > > we should consider doing this in the dwc, cadence, mobiveil, and plda
> > > cores instead of trying to do it for every driver individually?
> > > 
> > > Advertising L1SS support via PCI_EXT_CAP_ID_L1SS means users can
> > > enable L1SS via CONFIG_PCIEASPM_POWER_SUPERSAVE=y or sysfs, and that
> > > seems likely to cause problems unless CLKREQ# is supported.
> > 
> > Any thoughts on this?  There's nothing rockchip-specific in this
> > patch.  What I'm proposing is something like this:
> 
> I like your idea, though. But could it be another form of regression
> that we may breaks the platform which have already support L1SS
> properly? It's even harder to detect because a functional break is easier to
> notice than increased power consumption. 

True, but I think it's unlikely because the PCI core never enabled
L1SS (except for CONFIG_PCIEASPM_POWER_SUPERSAVE=y or sysfs, which I
doubt anybody really uses).

Devicetree platforms that use L1SS should have explicit code to enable
it, like qcom does, so we should be able to find them and make sure
they do what's needed to prevent the regression.

> Or maybe we could
> just export dw_pcie_clear_l1ss_advert() in dwc for host drivers to
> call it?

I don't like the idea of host drivers having to opt in for this
because that requires changes to all of them, not just changes to
drivers that have done the work to actually support L1SS.

> >      PCI: dwc: Prevent advertising L1 PM Substates
> >      L1 PM Substates require the CLKREF# signal and driver-specific support.  If
> >      CLKREF# is not supported or the driver support is lacking, enabling L1.1 or
> >      L1.2 may cause errors when accessing devices, e.g.,
> >        nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> >      If both ends of a link advertise support for L1 PM Substates, and the
> >      kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users enable L1.x
> >      via sysfs, Linux tries to enable them.
> >      To prevent errors when L1.x may not work, disable advertising the L1 PM
> >      Substates.  Drivers can enable advertising them if they know CLKREF# is
> >      present and the Root Port is configured correctly.
> >      Based on Niklas's patch from
> >      https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 20c9333bcb1c..83b5330c9e45 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -950,6 +950,27 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >   	return 0;
> >   }
> > +static void dw_pcie_clear_l1ss_advert(struct dw_pcie_rp *pp)
> > +{
> > +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > +	u16 l1ss;
> > +	u32 l1ss_cap;
> > +
> > +	l1ss = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> > +	if (!l1ss)
> > +		return;
> > +
> > +	/*
> > +	 * By default, don't advertise L1 PM Substates because they require
> > +	 * CLKREF# and other driver-specific support.
> > +	 */
> > +	l1ss_cap = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> > +	l1ss_cap &= ~(PCI_L1SS_CAP_PCIPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_1 |
> > +		      PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2 |
> > +		      PCI_L1SS_CAP_L1_PM_SS);
> > +	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, l1ss_cap);
> > +}
> > +
> >   static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
> >   {
> >   	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -1060,6 +1081,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >   		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> >   	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
> > +	dw_pcie_clear_l1ss_advert(pp);
> >   	dw_pcie_config_presets(pp);
> >   	/*
> >   	 * If the platform provides its own child bus config accesses, it means
> > 
> 

