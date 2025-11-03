Return-Path: <linux-pci+bounces-40147-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3C9C2E29E
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 22:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7F783A339F
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 21:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EB62D0606;
	Mon,  3 Nov 2025 21:32:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HA2Y7jLU"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B27A1F09AC;
	Mon,  3 Nov 2025 21:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762205528; cv=none; b=p/4jrAqh2beC/9F1r3KT+g9Jxds9K+RZ5kbcnNj0MjDeb08SKylL7ghpH/G/TJdHeOG5/tgwnpo+tVZt/IfAUKY+9P+Ve+qYN5odNK3q59itBOJkBfjQz/KGB5OFCHidNuF7ByafnOShxZ2V+2IYU0UkGsiv1GJcvOQSdH+lHpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762205528; c=relaxed/simple;
	bh=ssYPXPPovf2wqM/ImHK3XaebFTE3pSTxGXauyycDp1s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cIfecgEs0QfD5ItjhYr6mEmZf8Inh+0d2FAf9wVcnFqUkydU+izTzkUmateMiO12/hWOO/JX7vLM/Hw99lQxlVym5r01bi2k13QdhZBRLzMJp8TvxHNZfBvm9XWM/USGNgoq6RziKkdsm8O97ju60GHRx604U3WQZLLjlTzB32Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HA2Y7jLU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75B9BC4CEF8;
	Mon,  3 Nov 2025 21:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762205527;
	bh=ssYPXPPovf2wqM/ImHK3XaebFTE3pSTxGXauyycDp1s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=HA2Y7jLUZquaUCK75bZKPHJXEr5Sumg5l12Op+piRCuWuQSIeDZTjhXnAEWodtEgs
	 eVrCJXC8t2B09HakFD1MYgMlBYeSNuYGwKdVrLdvaeJFasZD0uQ6YJ8jjVhGWKH9a/
	 dt/ZUoChk9U0WMJIGYNgT2mpk8Uxz3uAnRa6PwtbQ1/iQrPrqAEltzz1Mb1Um2TXox
	 zkYcFvz+5T3WyGjK0zc4ZzNTd3EJYDUWG3uinkBbgnr41ZCrSQMNiB8lhNMaJhHA7x
	 AA+8yMZnsFdmDJNrRunuLuXr2/RdQyiMVVOj2cLVWvjm8c+bE6+lkBO5URJBGe+jJI
	 Qxr99z6g/N7pA==
Date: Mon, 3 Nov 2025 15:32:06 -0600
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
Message-ID: <20251103213206.GA1818418@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251028190218.GA1525614@bhelgaas>

On Tue, Oct 28, 2025 at 02:02:18PM -0500, Bjorn Helgaas wrote:
> On Fri, Oct 17, 2025 at 06:32:53PM +0200, Niklas Cassel wrote:
> > The L1 substates support requires additional steps to work, namely:
> > -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
> >  hardware, but software still needs to set the clkreq fields in the
> >  PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
> > -Program the frequency of the aux clock into the
> >  DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
> >  is turned off and the aux_clk is used instead.)
> ...

> > +static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
> > +{
> > +	u32 cap, l1subcap;
> > +
> > +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> > +	if (cap) {
> > +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> > +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> > +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> > +			      PCI_L1SS_CAP_PCIPM_L1_2);
> > +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> > +	}
> > +}
> 
> I like this.  But why should we do it just for dw-rockchip?  Is there
> something special about dw-rockchip that makes this a problem?  Maybe
> we should consider doing this in the dwc, cadence, mobiveil, and plda
> cores instead of trying to do it for every driver individually?
> 
> Advertising L1SS support via PCI_EXT_CAP_ID_L1SS means users can
> enable L1SS via CONFIG_PCIEASPM_POWER_SUPERSAVE=y or sysfs, and that
> seems likely to cause problems unless CLKREQ# is supported.

Any thoughts on this?  There's nothing rockchip-specific in this
patch.  What I'm proposing is something like this:

    PCI: dwc: Prevent advertising L1 PM Substates
    
    L1 PM Substates require the CLKREF# signal and driver-specific support.  If
    CLKREF# is not supported or the driver support is lacking, enabling L1.1 or
    L1.2 may cause errors when accessing devices, e.g.,
    
      nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
    
    If both ends of a link advertise support for L1 PM Substates, and the
    kernel is built with CONFIG_PCIEASPM_POWER_SUPERSAVE=y or users enable L1.x
    via sysfs, Linux tries to enable them.
    
    To prevent errors when L1.x may not work, disable advertising the L1 PM
    Substates.  Drivers can enable advertising them if they know CLKREF# is
    present and the Root Port is configured correctly.
    
    Based on Niklas's patch from
    https://patch.msgid.link/20251017163252.598812-2-cassel@kernel.org

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 20c9333bcb1c..83b5330c9e45 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -950,6 +950,27 @@ static int dw_pcie_iatu_setup(struct dw_pcie_rp *pp)
 	return 0;
 }
 
+static void dw_pcie_clear_l1ss_advert(struct dw_pcie_rp *pp)
+{
+	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
+	u16 l1ss;
+	u32 l1ss_cap;
+
+	l1ss = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
+	if (!l1ss)
+		return;
+
+	/*
+	 * By default, don't advertise L1 PM Substates because they require
+	 * CLKREF# and other driver-specific support.
+	 */
+	l1ss_cap = dw_pcie_readl_dbi(pci, l1ss + PCI_L1SS_CAP);
+	l1ss_cap &= ~(PCI_L1SS_CAP_PCIPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_1 |
+		      PCI_L1SS_CAP_PCIPM_L1_2 | PCI_L1SS_CAP_ASPM_L1_2 |
+		      PCI_L1SS_CAP_L1_PM_SS);
+	dw_pcie_writel_dbi(pci, l1ss + PCI_L1SS_CAP, l1ss_cap);
+}
+
 static void dw_pcie_program_presets(struct dw_pcie_rp *pp, enum pci_bus_speed speed)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -1060,6 +1081,7 @@ int dw_pcie_setup_rc(struct dw_pcie_rp *pp)
 		PCI_COMMAND_MASTER | PCI_COMMAND_SERR;
 	dw_pcie_writel_dbi(pci, PCI_COMMAND, val);
 
+	dw_pcie_clear_l1ss_advert(pp);
 	dw_pcie_config_presets(pp);
 	/*
 	 * If the platform provides its own child bus config accesses, it means

