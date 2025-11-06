Return-Path: <linux-pci+bounces-40459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 00FAEC39555
	for <lists+linux-pci@lfdr.de>; Thu, 06 Nov 2025 08:07:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1DB164E975F
	for <lists+linux-pci@lfdr.de>; Thu,  6 Nov 2025 07:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 489392C0323;
	Thu,  6 Nov 2025 07:07:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiDW6Dy1"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9302BDC34;
	Thu,  6 Nov 2025 07:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762412821; cv=none; b=uNTJiDPPHF3O+NCGTZDvwLlY0u/0U/wtEder60an70hFD7tEY42fOTCpAEli9IbVK1tThxfCZuk876RhPacPkI9F87GgE8/YAsXVmlkBAFiMWQvvWFYcMVdZ/ifCISlQ3orX/QOHH/cnLel1+UCnwJfijua/aqaVs7C+NMKCp0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762412821; c=relaxed/simple;
	bh=bqDZ7dmuCre8a9mGu2kDTQ6hkin7PcxZjdNHk50TiWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FG0ZDuL3arI0u8RAGKk/4oF7V35n8Miw4yVIZTYg4FT4vSq9enNo+HrnUdHeehdDsSRIRGOJCLfv25Ht+kM4Rv1G+yhcBu7MSBmaYW7mf9wrY1ALLrYyFThsY/ksmS3cO5u/mAaIF/kcV9ofMILpHIdKUmur56UxDjV1lENIHlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiDW6Dy1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA158C4CEF7;
	Thu,  6 Nov 2025 07:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762412820;
	bh=bqDZ7dmuCre8a9mGu2kDTQ6hkin7PcxZjdNHk50TiWs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kiDW6Dy1rIG6NN+YGv8qsOLyDj/Z50R1sni61NB7SBu0+e9PLb9hRuawULnNetA+H
	 Gzae9u4SrXbCDwLC2qOfW/QXRTyqRZBnsXfQKeOE4w6WyykOzQ/yJF8utKHGlv5h6+
	 Had/D2JTRqvt+2gk5yxiIfVwsWgESP8SXYHdSLJdq/7YVQ3GGncikke5lrr2e5dlgx
	 TxvT7m9VtQcdS50cZFJQEOJdcbSFxNtY5scKNCkri30xwH+BS0VTreB7bQqvh3Hv5b
	 M+dOKk0JJnqhxGd55mIHk7grrBVtcg751Nea8zxyYbxDoekV/7w6BpW7kzRPSFlsP1
	 xDvK7CEmgemyg==
Date: Thu, 6 Nov 2025 12:36:41 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Heiko Stuebner <heiko@sntech.de>, Kever Yang <kever.yang@rock-chips.com>, 
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>, 
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>, 
	Diederik de Haas <diederik@cknow-tech.com>, stable@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, Daire McNamara <daire.mcnamara@microchip.com>, 
	Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>, Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, linux-pci@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
	Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH v3] PCI: dw-rockchip: Prevent advertising L1 Substates
 support
Message-ID: <oa57mn3wrigno2kzigdo2lh46z5xmesv74nzjtg4jz4ea6urrh@icti3ewoll4r>
References: <0e32766b-b951-4ab4-ae3d-c802cf649edf@rock-chips.com>
 <20251104221724.GA1875081@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251104221724.GA1875081@bhelgaas>

On Tue, Nov 04, 2025 at 04:17:24PM -0600, Bjorn Helgaas wrote:
> On Tue, Nov 04, 2025 at 08:58:02AM +0800, Shawn Lin wrote:
> > 在 2025/11/04 星期二 5:32, Bjorn Helgaas 写道:
> > > On Tue, Oct 28, 2025 at 02:02:18PM -0500, Bjorn Helgaas wrote:
> > > > On Fri, Oct 17, 2025 at 06:32:53PM +0200, Niklas Cassel wrote:
> > > > > The L1 substates support requires additional steps to work, namely:
> > > > > -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
> > > > >   hardware, but software still needs to set the clkreq fields in the
> > > > >   PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
> > > > > -Program the frequency of the aux clock into the
> > > > >   DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
> > > > >   is turned off and the aux_clk is used instead.)
> > > > ...
> > > 
> > > > > +static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
> > > > > +{
> > > > > +	u32 cap, l1subcap;
> > > > > +
> > > > > +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> > > > > +	if (cap) {
> > > > > +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> > > > > +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> > > > > +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> > > > > +			      PCI_L1SS_CAP_PCIPM_L1_2);
> > > > > +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> > > > > +	}
> > > > > +}
> > > > 
> > > > I like this.  But why should we do it just for dw-rockchip?  Is there
> > > > something special about dw-rockchip that makes this a problem?  Maybe
> > > > we should consider doing this in the dwc, cadence, mobiveil, and plda
> > > > cores instead of trying to do it for every driver individually?
> > > > 
> > > > Advertising L1SS support via PCI_EXT_CAP_ID_L1SS means users can
> > > > enable L1SS via CONFIG_PCIEASPM_POWER_SUPERSAVE=y or sysfs, and that
> > > > seems likely to cause problems unless CLKREQ# is supported.
> > > 
> > > Any thoughts on this?  There's nothing rockchip-specific in this
> > > patch.  What I'm proposing is something like this:
> > 
> > I like your idea, though. But could it be another form of regression
> > that we may breaks the platform which have already support L1SS
> > properly? It's even harder to detect because a functional break is easier to
> > notice than increased power consumption. 
> 
> True, but I think it's unlikely because the PCI core never enabled
> L1SS (except for CONFIG_PCIEASPM_POWER_SUPERSAVE=y or sysfs, which I
> doubt anybody really uses).
> 
> Devicetree platforms that use L1SS should have explicit code to enable
> it, like qcom does, so we should be able to find them and make sure
> they do what's needed to prevent the regression.
> 
> > Or maybe we could
> > just export dw_pcie_clear_l1ss_advert() in dwc for host drivers to
> > call it?
> 
> I don't like the idea of host drivers having to opt in for this
> because that requires changes to all of them, not just changes to
> drivers that have done the work to actually support L1SS.
> 

Otherwise, we may have to introduce a flag for the controller drivers to opt-out
of this disablement. Like, dw_pcie_rp::native_clkreq and bailing out early if
this flag is set.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

