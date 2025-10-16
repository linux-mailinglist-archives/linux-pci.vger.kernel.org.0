Return-Path: <linux-pci+bounces-38382-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F1D8BE4D67
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 19:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 56A824EE3C6
	for <lists+linux-pci@lfdr.de>; Thu, 16 Oct 2025 17:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25745262A6;
	Thu, 16 Oct 2025 17:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sRVlh2pB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F14DD334693;
	Thu, 16 Oct 2025 17:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760635507; cv=none; b=ahuKmtUX32E2f78x2C1KnJ5Lvbh3XhY7JHquNnZSPqhn8sL3oRZE9ze3ax1pVKRj73M7fB3PNz4tXv3CLjDLZbVia37Db76OuLjBSqZtlLUM29xaXgFh2yREwFPn8qpBtLP1HXgwngmGMpUhbXB2tbJnH1hbs6cf6kSK/4QUaNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760635507; c=relaxed/simple;
	bh=G6gflAdnfqtYv6X1AmICnxsRIfUHX7Y5Khj5yu5Kdxw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=qr9/fNj1CbRoztbpNKvfhNL3SrwfU6qG7d1GAB/GroFTpG2BBabgOzTeiP4I3Y5oaeFjemGUbGt6swwfbpS0iAGnBtuGKdb9GDYQ67fTn6hwaskCL4/lBRFPLxB5Dq6krsBvaRYZCvb2wASY+SQDKmsSM60vBw6QVrCBVJfCJmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sRVlh2pB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 476A6C4CEF1;
	Thu, 16 Oct 2025 17:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760635505;
	bh=G6gflAdnfqtYv6X1AmICnxsRIfUHX7Y5Khj5yu5Kdxw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=sRVlh2pBX6NDS7gsIFGctuMKVFo1D8iL3lbXMjQsOI+YOy3NDjQ336qjLZU2lnots
	 5ChxGMnP2fCioMwCnckgGwJON0FpEb3zyydV8p/12tby1gpPCyoTDF300s+1Kt0zkD
	 i6YrNagHIkaOGiocng95zHqHCjbifWOm5y2Oqw2dwNZN4HHg4pZixWzbnNKLy/Xmvu
	 rgdgD73wtKtC44yS139PRpjjZDiqPxaXcsWkyDMvqpn6JJQN15horDXhVE9RxOSLVm
	 NjAem8fcbx4eKcDKQgddivvB2Q4v9Z9yGt+iKq7Jb8XnA2WJB1cr+qGgKFzWwTKYhU
	 pNrZDAAI8/+wg==
Date: Thu, 16 Oct 2025 12:25:04 -0500
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
Subject: Re: [PATCH v2] PCI: dw-rockchip: Disable L1 substates
Message-ID: <20251016172504.GA991252@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251016090422.451982-2-cassel@kernel.org>

On Thu, Oct 16, 2025 at 11:04:22AM +0200, Niklas Cassel wrote:
> The L1 substates support requires additional steps to work, see e.g.
> section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0.
> 
> These steps are currently missing from the driver.

Can we outline here specifically what is missing?

> While this has always been a problem when using e.g.
> CONFIG_PCIEASPM_POWER_SUPERSAVE=y, the problem became more apparent after
> commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> devicetree platforms"), which enabled ASPM also for
> CONFIG_PCIEASPM_DEFAULT=y.

Should also be able to trigger this problem regardless of
CONFIG_PCIEASPM_* by using /sys/bus/pci/devices/.../link/l1_2_aspm.

> Disable L1 substates until proper support is added.

I would word this more like "prevent advertising L1 Substates support"
since we're not actually *disabling* anything here.

If the RK3588 TRM is publicly available, a URL here would be helpful.

> Cc: stable@vger.kernel.org
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
> Changes since v1:
> -Remove superfluous dw_pcie_readl_dbi()
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

I suspect this problem is specifically related to L1.2 and CLKREQ#,
and L1.1 might work fine.  If so, can we update this so we still
advertise L1.1 support?

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

