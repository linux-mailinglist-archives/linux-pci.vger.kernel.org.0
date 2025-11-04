Return-Path: <linux-pci+bounces-40300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87270C33374
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 23:26:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59B4018C45AC
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 22:25:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369F330C620;
	Tue,  4 Nov 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UQZp25Vy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B47E31355D;
	Tue,  4 Nov 2025 22:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762295101; cv=none; b=T1376bIMdNpNbaN07Fk4fl2OvEFHIObPgkiZSj/+bt77mq/ivMcKiXhgkWjQLsEuz8fSlorkvfQG9Y9e5lTb15B0YrsJSeWv5gnLw7cDCcIaJ/c7dbzdf99+Furt11APvLM+Ux5/aiHUUUCVqcAeLidlr26qcci93Yjr355keTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762295101; c=relaxed/simple;
	bh=MpBA+UULRGogBYd/iiElinHqnh5k6olSM7ACsR1ylwE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WxGg9VnOGzdTQ92pXLnurL/kUxy9unP65trwJAxSEhMUDdT4JLnUpuiySr808+odzrwEQ4HcL9xeDUJueUFm6NQEsRLI/Fojj/HLEtnEgtG4C437N74daUhEc/aYsqW62//aLkIi3cCnR41xCmtCvEEUjESQ8J8sVK8phR+rdBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UQZp25Vy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0966C4CEF8;
	Tue,  4 Nov 2025 22:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762295100;
	bh=MpBA+UULRGogBYd/iiElinHqnh5k6olSM7ACsR1ylwE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=UQZp25VyWCMTDQ9j29IMpi6TqHDlYY3SFYSR78Ndgg7TwFhh6wrOrGCArjzifof27
	 4byTJicLROTO8eC9xOZqgzl0Nnf6WNkmeNt+glnOzXRG1cxhRBSHSmm55Wty7Ul4WE
	 0EaArA6UfCUxVbJIpJeuKfNNq4kbGpjiqBJ0BPQNw5pOv7LUDsn8lOneeaC49g268D
	 ObGHpqFsot3UajEJRhEC0YNEiwbu+Yeh21RQZCu8yI3vyT8iWHdio6btqFQ0UVlMy6
	 I4HJ2Yn/rjd13mMm9kBv561u6QIp1sNTnNxcO6ExT3crGwFTtCdxSl3vqsMWMbP6zj
	 rtpWqYbH4dEcg==
Date: Tue, 4 Nov 2025 16:24:59 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Niklas Cassel <cassel@kernel.org>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>, stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Daire McNamara <daire.mcnamara@microchip.com>,
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
	Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dw-rockchip: Prevent advertising L1 Substates
 support
Message-ID: <20251104222459.GA1875296@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aQn3RGrJi1lb0EO1@ryzen>

On Tue, Nov 04, 2025 at 01:53:24PM +0100, Niklas Cassel wrote:
> On Mon, Nov 03, 2025 at 03:32:06PM -0600, Bjorn Helgaas wrote:
> > On Tue, Oct 28, 2025 at 02:02:18PM -0500, Bjorn Helgaas wrote:
> > > On Fri, Oct 17, 2025 at 06:32:53PM +0200, Niklas Cassel wrote:
> > > > The L1 substates support requires additional steps to work, namely:
> > > > -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
> > > >  hardware, but software still needs to set the clkreq fields in the
> > > >  PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
> > > > -Program the frequency of the aux clock into the
> > > >  DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
> > > >  is turned off and the aux_clk is used instead.)
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
> > 
> >     PCI: dwc: Prevent advertising L1 PM Substates
> >     
> >     L1 PM Substates require the CLKREF# signal and driver-specific support.  If
> >     CLKREF# is not supported or the driver support is lacking, enabling L1.1 or
> >     L1.2 may cause errors when accessing devices, e.g.,
> >     
> >       nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> >     
> >     If both ends of a link advertise support for L1 PM Substates, and the
> >     kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users enable L1.x
> >     via sysfs, Linux tries to enable them.
> >     
> >     To prevent errors when L1.x may not work, disable advertising the L1 PM
> >     Substates.  Drivers can enable advertising them if they know CLKREF# is
> >     present and the Root Port is configured correctly.
> >     
> >     Based on Niklas's patch from
> >     https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> > index 20c9333bcb1c..83b5330c9e45 100644
> > --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> > +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> > @@ -950,6 +950,27 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
> >  	return 0;
> >  }
> >  
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
> >  static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
> >  {
> >  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> > @@ -1060,6 +1081,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
> >  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
> >  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
> >  
> > +	dw_pcie_clear_l1ss_advert(pp);
> >  	dw_pcie_config_presets(pp);
> >  	/*
> >  	 * If the platform provides its own child bus config accesses, it means
> 
> My patch disables L1 substates when running the controller in both
> root complex mode and endpoint mode.
> 
> Your patch above only disables L1 substates when running the the
> controller in root complex mode.
> 
> I think this code has to be in pcie-designware.c and then e.g.
> dw_pcie_setup_rc() (pcie-designware-host.c) and
> dw_pcie_ep_init_registers() (pcie-designware-ep.c) can both use it.

I'm not opposed to doing it for endpoints as well if the endpoint mode
driver needs to configure L1SS things before it can work.

I don't think an endpoint should be enabling L1SS on the host, so
enabling L1SS probably has to be done by the host, and the host driver
knows the topology and whether CLKREQ# is supported (e.g., via DT) and
whether the RP is configured for it.

> And like Shawn mentions. Disabling it by default for all DWC based
> platforms could introduce regressions where L1 substates already is
> working fine.
> 
> Sure, the only driver that checks for the DT property
> 'supports-clkreq' is drivers/pci/controller/dwc/pcie-tegra194.c.
> However Mani claimed that the qcom driver also has support for L1
> substates already, even though it does not check the
> 'supports-clkreq' DT property.

Yes, we would need to ensure tegra, qcom, and any others that use L1SS
don't regress.  That's why I said "something like this" and didn't
include a signed-off-by.  I wanted to have exactly this conversation.

Bjorn

