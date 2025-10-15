Return-Path: <linux-pci+bounces-38212-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A34E9BDE7D3
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 14:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 97ACA4EEDDF
	for <lists+linux-pci@lfdr.de>; Wed, 15 Oct 2025 12:35:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B90EB450FE;
	Wed, 15 Oct 2025 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h8mWfXGZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4BAEEDE;
	Wed, 15 Oct 2025 12:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760531745; cv=none; b=ch8yCNwZ0ytLjbCVRv0duQKXBUE1337QkCSHH+xK0oxEa1OLjO3dbwlcufJhDCKQxg2OUnRebET7cI22XLJRlR8OaPNrF68BPHv9zSSh8jikRFRG8muALFDTsjwyavMHozMSLrq3WG5Yt4eV4/+3XTspy3FFfrVNBOmq6tEpCOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760531745; c=relaxed/simple;
	bh=JBha8IM0AxTjIHZho/VaVOPs4WZJhD7HiSM3gEnMxw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t6wz5uyEQFi2vh+WdlM9JtywtE+zVpiM9s+iJ4BmlOfqri1D5K3i/f51MED8+G+ng+LCXuDEsI7alMY8gnu2ylaToPEpGmAc4mxMkryEUTXgR4RH1Ik7jD5blAFXifHkNprKkr1ec8RL6fRNPLQRnNgeldz+nqxPuTwff7ShHls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h8mWfXGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96BA7C4CEF8;
	Wed, 15 Oct 2025 12:35:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760531744;
	bh=JBha8IM0AxTjIHZho/VaVOPs4WZJhD7HiSM3gEnMxw8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h8mWfXGZW8dgoUk6CSJzFlBT5ekUzQeHNObU3HJQURWD+RFCS/NdsPZne7YpA0nsK
	 oac66oDiHi4y+Rthue2fGbNXz2OZQTOpTv8N68Zch+tPSZRrKJOJnYvcmjD/SDG6c6
	 /e0Ukex6rio4LT1HbHX2/3fYq6FL6e3HdyhaG6Z7bpeiHp5lzAOeylb3CVSyeqpoZX
	 x4XYBqvveuXh7T/HAFdCQipp0Ecfygr/uBh8sJjfTow1qC4EOufnZBUK/UYierVa6w
	 JxHGAQSytV+eZ1QaE0mE1lDUe266jJUjvRKHHhVyZyD4lzxH3ZYIiEFVlwkyLB8eXw
	 9K5WFHt58p0+g==
Date: Wed, 15 Oct 2025 14:35:38 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, Simon Xue <xxm@rock-chips.com>,
	Kever Yang <kever.yang@rock-chips.com>,
	Shawn Lin <shawn.lin@rock-chips.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Dragan Simic <dsimic@manjaro.org>,
	FUKAUMI Naoki <naoki@radxa.com>, stable@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH] PCI: dw-rockchip: Disable L1 substates
Message-ID: <aO-VGnz67TMzqdiX@ryzen>
References: <20251015123142.392274-2-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251015123142.392274-2-cassel@kernel.org>

On Wed, Oct 15, 2025 at 02:31:43PM +0200, Niklas Cassel wrote:
> The L1 substates support requires additional steps to work, see e.g.
> section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0.
> 
> These steps are currently missing from the driver.
> 
> While this has always been a problem when using e.g.
> CONFIG_PCIEASPM_POWER_SUPERSAVE=y, the problem became more apparent after
> commit f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for
> devicetree platforms"), which enabled ASPM also for
> CONFIG_PCIEASPM_DEFAULT=y.
> 
> Disable L1 substates until proper support is added.
> 
> Cc: stable@vger.kernel.org
> Fixes: 0e898eb8df4e ("PCI: rockchip-dwc: Add Rockchip RK356X host controller driver")
> Fixes: f3ac2ff14834 ("PCI/ASPM: Enable all ClockPM and ASPM states for devicetree platforms")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 22 +++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3e2752c7dd09..28e0fffe2542 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -200,6 +200,26 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
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
> +		l1subcap = dw_pcie_readl_dbi(pci, cap + PCI_L1SS_CAP);

Sorry, this extra dw_pcie_readl_dbi() was left over from debugging.
Tell me if I should respin or if you can fix up when applying.

I've verified that the patch works using an NVMe drive on v6.18-rc1,
which is working after this patch, but was not working before this patch.


Kind regards,
Niklas

