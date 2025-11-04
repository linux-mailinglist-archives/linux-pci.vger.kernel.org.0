Return-Path: <linux-pci+bounces-40204-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1116EC31162
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 13:54:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DA5814E6D0C
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB352D23BF;
	Tue,  4 Nov 2025 12:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VIA/GT6L"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AB820C461;
	Tue,  4 Nov 2025 12:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762260811; cv=none; b=ECAt8GsZzPhh+21/vT3KKvlK9Q11dhecvYESKsAk3Y/ACsi42zrU5IYRF8qCv53tpYjHK3JrbWdaYVKvbQIrPREen5l0EOsqwMQqC+yM9/O2ZG6KKVuNodXTX72g6mhXPL3iGGlgS00M5cPGQU2a4eO2uA0mVVUIX42kj6jvou0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762260811; c=relaxed/simple;
	bh=kBePapwwI6HFP1Ie8oXMdV7JbHo8eVO/XYn+bJLYsGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bj32rwf2cva2ZKu1m6/2oNODbHhqG6FcbZme5zXu2fVcKjY+Ky1ikaXClBYBfmd7EKBjNsB+f6HLFtWR6SIuGwa1lBoQzF7jzdA6GFuvmhajQpolWMCphVoGezw2m/JD0h0Gp7j5XdcN7TPPZnvz47xIAuRHPoj0QUhgKLdFINc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VIA/GT6L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F2BCC4CEF7;
	Tue,  4 Nov 2025 12:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762260810;
	bh=kBePapwwI6HFP1Ie8oXMdV7JbHo8eVO/XYn+bJLYsGQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VIA/GT6LcnpY1SQ6WzNn5tWDCswWcoo+0OjfE3aZ6aeRCCSQtgSQunc6Sz7/PrZlo
	 rC2BRHSAwdd4jSR3HqZEIDR2Nwcb4hSwBtnreLnuRyuzKLliNIyzE2KAnDrVnmSl1E
	 +nkJfJjlpHabGBCx6LuvjhQ0eaD7RhCus8bX9mIJ72a0ryeYCVU1FgdONOdUCAqZIY
	 MxR1zDUPtDaQVbmBQIe2J0VcJIEt2WizRNMWJCVAAZ1Viuvzth3CP3f/8bvCT+FTu+
	 qP3OUo2hxAf/8OTryFgQQNo+J0IiAo6H3z3UxMMJRBLZQbFgnI5RPYnDL8xWd/k6Fi
	 Cy/8GVaE/aAAQ==
Date: Tue, 4 Nov 2025 13:53:24 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
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
Message-ID: <aQn3RGrJi1lb0EO1@ryzen>
References: <20251028190218.GA1525614@bhelgaas>
 <20251103213206.GA1818418@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251103213206.GA1818418@bhelgaas>

Hello Bjorn,

On Mon, Nov 03, 2025 at 03:32:06PM -0600, Bjorn Helgaas wrote:
> On Tue, Oct 28, 2025 at 02:02:18PM -0500, Bjorn Helgaas wrote:
> > On Fri, Oct 17, 2025 at 06:32:53PM +0200, Niklas Cassel wrote:
> > > The L1 substates support requires additional steps to work, namely:
> > > -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
> > >  hardware, but software still needs to set the clkreq fields in the
> > >  PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
> > > -Program the frequency of the aux clock into the
> > >  DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
> > >  is turned off and the aux_clk is used instead.)
> > ...
> 
> > > +static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
> > > +{
> > > +	u32 cap, l1subcap;
> > > +
> > > +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> > > +	if (cap) {
> > > +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> > > +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> > > +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> > > +			      PCI_L1SS_CAP_PCIPM_L1_2);
> > > +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> > > +	}
> > > +}
> > 
> > I like this.  But why should we do it just for dw-rockchip?  Is there
> > something special about dw-rockchip that makes this a problem?  Maybe
> > we should consider doing this in the dwc, cadence, mobiveil, and plda
> > cores instead of trying to do it for every driver individually?
> > 
> > Advertising L1SS support via PCI_EXT_CAP_ID_L1SS means users can
> > enable L1SS via CONFIG_PCIEASPM_POWER_SUPERSAVE=y or sysfs, and that
> > seems likely to cause problems unless CLKREQ# is supported.
> 
> Any thoughts on this?  There's nothing rockchip-specific in this
> patch.  What I'm proposing is something like this:
> 
>     PCI: dwc: Prevent advertising L1 PM Substates
>     
>     L1 PM Substates require the CLKREF# signal and driver-specific support.  If
>     CLKREF# is not supported or the driver support is lacking, enabling L1.1 or
>     L1.2 may cause errors when accessing devices, e.g.,
>     
>       nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
>     
>     If both ends of a link advertise support for L1 PM Substates, and the
>     kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users enable L1.x
>     via sysfs, Linux tries to enable them.
>     
>     To prevent errors when L1.x may not work, disable advertising the L1 PM
>     Substates.  Drivers can enable advertising them if they know CLKREF# is
>     present and the Root Port is configured correctly.
>     
>     Based on Niklas's patch from
>     https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org
> 
> diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
> index 20c9333bcb1c..83b5330c9e45 100644
> --- a/drivers/pci/controller/dwc/pcie-designware-host.c
> +++ b/drivers/pci/controller/dwc/pcie-designware-host.c
> @@ -950,6 +950,27 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> +static void dw_pcie_clear_l1ss_advert(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	u16 l1ss;
> +	u32 l1ss_cap;
> +
> +	l1ss = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (!l1ss)
> +		return;
> +
> +	/*
> +	 * By default, don't advertise L1 PM Substates because they require
> +	 * CLKREF# and other driver-specific support.
> +	 */
> +	l1ss_cap = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
> +	l1ss_cap &= ~(PCI_L1SS_CAP_PCIPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_1 |
> +		      PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2 |
> +		      PCI_L1SS_CAP_L1_PM_SS);
> +	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, l1ss_cap);
> +}
> +
>  static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
>  {
>  	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> @@ -1060,6 +1081,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
>  		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
>  	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
>  
> +	dw_pcie_clear_l1ss_advert(pp);
>  	dw_pcie_config_presets(pp);
>  	/*
>  	 * If the platform provides its own child bus config accesses, it means

My patch disables L1 substates when running the controller in both root
complex mode and endpoint mode.

Your patch above only disables L1 substates when running the the controller
in root complex mode.

I think this code has to be in pcie-designware.c and then e.g.
dw_pcie_setup_rc() (pcie-designware-host.c) and
dw_pcie_ep_init_registers() (pcie-designware-ep.c) can both use it.


And like Shawn mentions. Disabling it by default for all DWC based
platforms could introduce regressions where L1 substates already is working
fine.

Sure, the only driver that checks for the DT property 'supports-clkreq' is
drivers/pci/controller/dwc/pcie-tegra194.c. However Mani claimed that the
qcom driver also has support for L1 substates already, even though it does
not check the 'supports-clkreq' DT property.


Kind regards,
Niklas

