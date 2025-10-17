Return-Path: <linux-pci+bounces-38499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E68B9BEAE4B
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 18:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CE2655684F9
	for <lists+linux-pci@lfdr.de>; Fri, 17 Oct 2025 16:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A69002DF6F7;
	Fri, 17 Oct 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q1Y+SVCH"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D8182DF3FD;
	Fri, 17 Oct 2025 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760719560; cv=none; b=TvrCl2xZJcRDI9QifQ8RImm03dn0Yk1CLOUzdfjYHlsBM2MTRcv2PY+K6lV1GZyKTsr5rPDEv0/noXEHkdeS00zAfkiorHCLXJpom/tZkBrRHaItoXWqJuco6KEHnb5cph9sKb3ZQgsRNbfAT5E2L7JreFTBZsGb4GgLat3BqIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760719560; c=relaxed/simple;
	bh=h08opjvAv8/xQo7w63XSdz3MO0fB63xMecJbpuPxEA8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=oCVMC55fmBzYOaGek/W0/CI6StuCNLyx7xHiLZ1TYknnrQsddnX7Oi+3VaGl8rkMjFM91crQTf/iZIMaAy8wjHEpEcx0MaFxmZI6DAeVZJigupEa3tlO/RUkwwavDqcCJU6IvTYbj7lvI5mriA1TyYEnNFWzpCW193j0o3Ht1i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q1Y+SVCH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E8BC4CEE7;
	Fri, 17 Oct 2025 16:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760719560;
	bh=h08opjvAv8/xQo7w63XSdz3MO0fB63xMecJbpuPxEA8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=q1Y+SVCHTzDrmoW2qRAb6zFIadjOKdsDbR8JKZ2gD3h8bYtt3wiqJKMhrjREHnDbW
	 5mA42qA94tol3Ub4cYxKNUjwi2nVNZld535l/Y4+Q1ekr/r780LFdm5LRNk9Bn185N
	 peLLCqcRx1Tl7ewnpgeOevUX3uygIIHa3mxslR+docEKkatTZaz12dhCc1jK9Y8b8D
	 KMAsLQ5/F2laMwfOgUcEpeeIfCZqSvRKW5CaaGKdJD7GH3mKrwXe1iT8/nIN4NSil4
	 fiyC76ZMOqbXLBgdTuHSxNEFbZ3mvyUXH4q6sKyIOSmz9/tuP7KLrx8veMx05oS2Kh
	 OCHBzteTI9+mw==
Date: Fri, 17 Oct 2025 11:45:58 -0500
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
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH v3] PCI: dw-rockchip: Prevent advertising L1 Substates
 support
Message-ID: <20251017164558.GA1034609@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017163252.598812-2-cassel@kernel.org>

On Fri, Oct 17, 2025 at 06:32:53PM +0200, Niklas Cassel wrote:
> The L1 substates support requires additional steps to work, namely:
> -Proper handling of the CLKREQ# sideband signal. (It is mostly handled by
>  hardware, but software still needs to set the clkreq fields in the
>  PCIE_CLIENT_POWER_CON register to match the hardware implementation.)
> -Program the frequency of the aux clock into the
>  DSP_PCIE_PL_AUX_CLK_FREQ_OFF register. (During L1 substates the core_clk
>  is turned off and the aux_clk is used instead.)
> 
> These steps are currently missing from the driver.
> 
> For more details, see section '18.6.6.4 L1 Substate' in the RK3658 TRM 1.1
> Part 2, or section '11.6.6.4 L1 Substate' in the RK3588 TRM 1.0 Part2.
> 
> While this has always been a problem when using e.g.
> CONFIG_PCIEASPM_POWER_SUPERSAVE=y, or when modifying
> /sys/bus/pci/devices/.../link/l1_2_aspm, the lacking driver support for L1
> substates became more apparent after commit f3ac2ff14834 ("PCI/ASPM:
> Enable all ClockPM and ASPM states for devicetree platforms"), which
> enabled ASPM also for CONFIG_PCIEASPM_DEFAULT=y.
> 
> When using e.g. an NVMe drive connected to the PCIe controller, the
> problem will be seen as:
> nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0x10
> nvme nvme0: Does your device have a faulty power saving mode enabled?
> nvme nvme0: Try "nvme_core.default_ps_max_latency_us=0 pcie_aspm=off pcie_port_pm=off" and report a bug
> 
> Thus, prevent advertising L1 Substates support until proper driver support
> is added.

I think Mani is planning a change so we don't try to enable L1
Substates by default, which should avoid the regression even without a
patch like this.

That will still leave the existing CONFIG_PCIEASPM_POWER_SUPERSAVE=y
and sysfs l1_1_aspm problems.

And we'll need to figure out a way to allow L1.x to be enabled based
on 'supports-clkreq' and possibly other info.  That would likely be
v6.19 material since it's new functionality.

> Cc: stable@vger.kernel.org
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Acked-by: Shawn Lin <shawn.lin@rock-chips.com>
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v2:
> -Improve commit message (Bjorn)
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 21 +++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3e2752c7dd09..84f882abbca5 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -200,6 +200,25 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>  	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>  }
>  
> +/*
> + * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for the steps
> + * needed to support L1 substates. Currently, not a single rockchip platform
> + * performs these steps, so disable L1 substates until there is proper support.
> + */
> +static void rockchip_pcie_disable_l1sub(struct dw_pcie *pci)
> +{
> +	u32 cap, l1subcap;
> +
> +	cap = dw_pcie_find_ext_capability(pci, PCI_EXT_CAP_ID_L1SS);
> +	if (cap) {
> +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);
> +		l1subcap &= ~(PCI_L1SS_CAP_L1_PM_SS | PCI_L1SS_CAP_ASPM_L1_1 |
> +			      PCI_L1SS_CAP_ASPM_L1_2 | PCI_L1SS_CAP_PCIPM_L1_1 |
> +			      PCI_L1SS_CAP_PCIPM_L1_2);
> +		dw_pcie_writel_dbi(pci, cap + PCI_L1SS_CAP, l1subcap);
> +	}
> +}
> +
>  static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>  {
>  	u32 cap, lnkcap;
> @@ -264,6 +283,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);
>  
> +	rockchip_pcie_disable_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
>  
>  	return 0;
> @@ -301,6 +321,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
>  
> +	rockchip_pcie_disable_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
>  	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>  
> -- 
> 2.51.0
> 

