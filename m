Return-Path: <linux-pci+bounces-40965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9EF9C5123C
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 09:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8929C3A6308
	for <lists+linux-pci@lfdr.de>; Wed, 12 Nov 2025 08:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D7AA2F7ACD;
	Wed, 12 Nov 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nnqY7nbC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4889A2F7ABA;
	Wed, 12 Nov 2025 08:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762936572; cv=none; b=peQzO31WIQ/ULqrgt01VbWC20rh3I4l8Lcak946TFnkCQn+eqYtfCG3M7cG8cFwNKNOPt1ohOOKZvieQBgu13XF1ngNGDzwlXgVPEwqoM/4d/FEL8SLqpit8l1XP8JgcEe3qish+CbqhC3SI05bO9tl4Q5XTGYUiv0KD/9wnObo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762936572; c=relaxed/simple;
	bh=fWtxxuQo/pcCl3z56fIUSvnvcb5WQwnMx9dhO06VUw0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TedtxzMZdIilO0yIL9E3fknT94qKuqm1XXRrEVUNvUuDss1Ke/rnYz/Oa0RjJXsuc3y9Cm9IDKa+RDv8RUGbbv+Gw7BJCKnIImmddkPjR2LnfR5W8coLiDiyhcfijaM9pKa8LllAIjtz0d2uDgTtLC/Fx2QyyhHE2mzUwkIz1/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nnqY7nbC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26358C116B1;
	Wed, 12 Nov 2025 08:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762936572;
	bh=fWtxxuQo/pcCl3z56fIUSvnvcb5WQwnMx9dhO06VUw0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nnqY7nbCbUmaOh+u9j3N/fhjowP7Af290Yh4h7g/iJasPzzW9wnJuuAn9w1M/z+Bd
	 sYxDOViilw63B5geo3xE/HzVDkvfOri9XNmUY075vAqEinUKm1KkowCwyoI0GU4f63
	 ZTyD04h6EYdhMHONmuEyl7wlQDmDAf/FhkSZd4aV4WDLdcpMCX633ibmPGrGQpZhnM
	 EYtMww30pLG73tWC0Ch8hUtHIgZsyaYnhsgcKEXCiJ2uHGhfNKaHDJfPjIrjYMaAa4
	 zGhgVT2J1KkOQylmtrQaEp59caFa5dbFva2kyOQroE0HzpaabwBkJQmTLqAMQ1vAf+
	 q428iGjHOdOkw==
Date: Wed, 12 Nov 2025 09:36:03 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Rob Herring <robh@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
	Kever Yang <kever.yang@rock-chips.com>,
	Simon Xue <xxm@rock-chips.com>, Damien Le Moal <dlemoal@kernel.org>,
	Dragan Simic <dsimic@manjaro.org>, FUKAUMI Naoki <naoki@radxa.com>,
	Diederik de Haas <diederik@cknow-tech.com>,
	Richard Zhu <hongxing.zhu@nxp.com>, Frank Li <Frank.li@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Conor Dooley <conor@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Hans Zhang <hans.zhang@cixtech.com>, linux-tegra@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, kernel@pengutronix.de,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 3/4] PCI: dw-rockchip: Configure L1sub support
Message-ID: <aRRG8wv13HxOCqgA@ryzen>
References: <20251111221621.2208606-1-helgaas@kernel.org>
 <20251111221621.2208606-4-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251111221621.2208606-4-helgaas@kernel.org>

On Tue, Nov 11, 2025 at 04:16:10PM -0600, Bjorn Helgaas wrote:
> From: Shawn Lin <shawn.lin@rock-chips.com>
> 
> L1 PM Substates for RC mode require support in the dw-rockchip driver
> including proper handling of the CLKREQ# sideband signal. It is mostly
> handled by hardware, but software still needs to set the clkreq fields
> in the PCIE_CLIENT_POWER_CON register to match the hardware implementation.
> 
> For more details, see section '18.6.6.4 L1 Substate' in the RK3658 TRM 1.1
> Part 2, or section '11.6.6.4 L1 Substate' in the RK3588 TRM 1.0 Part2.
> 
> Meanwhile, for the EP mode, we haven't prepared enough to actually support
> L1 PM Substates yet. So disable it now until proper support is added later.

Considering that patch 1/4 is disabling L1ss for EP mode, I think we can
remove this last sentence.


> 
> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> [bhelgaas: set pci->l1ss_support so DWC core preserves L1SS Capability bits;
> drop corresponding code here]
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Link: https://patch.msgid.link/1761187883-150120-1-git-send-email-shawn.lin@rock-chips.com
> ---
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 38 +++++++++++++++++++
>  1 file changed, 38 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3e2752c7dd09..62a095752833 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -62,6 +62,12 @@
>  /* Interrupt Mask Register Related to Miscellaneous Operation */
>  #define PCIE_CLIENT_INTR_MASK_MISC	0x24
>  
> +/* Power Management Control Register */
> +#define PCIE_CLIENT_POWER_CON		0x2c
> +#define  PCIE_CLKREQ_READY		FIELD_PREP_WM16(BIT(0), 1)
> +#define  PCIE_CLKREQ_NOT_READY		FIELD_PREP_WM16(BIT(0), 0)
> +#define  PCIE_CLKREQ_PULL_DOWN		FIELD_PREP_WM16(GENMASK(13, 12), 1)
> +
>  /* Hot Reset Control Register */
>  #define PCIE_CLIENT_HOT_RESET_CTRL	0x180
>  #define  PCIE_LTSSM_APP_DLY2_EN		BIT(1)
> @@ -85,6 +91,7 @@ struct rockchip_pcie {
>  	struct regulator *vpcie3v3;
>  	struct irq_domain *irq_domain;
>  	const struct rockchip_pcie_of_data *data;
> +	bool supports_clkreq;
>  };
>  
>  struct rockchip_pcie_of_data {
> @@ -200,6 +207,32 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>  	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>  }
>  
> +/*
> + * See e.g. section '11.6.6.4 L1 Substate' in the RK3588 TRM V1.0 for the steps
> + * needed to support L1 substates. Currently, just enable L1 substates for RC
> + * mode if CLKREQ# is properly connected and supports-clkreq is present in DT.
> + * For EP mode, there are more things should be done to actually save power in
> + * L1 substates, so disable L1 substates until there is proper support.
> + */
> +static void rockchip_pcie_configure_l1sub(struct dw_pcie *pci)
> +{
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +
> +	/* Enable L1 substates if CLKREQ# is properly connected */
> +	if (rockchip->supports_clkreq &&
> +	    rockchip->data->mode == DW_PCIE_RC_TYPE ) {

Superfluous space before '('

Considering that DWC core clears L1ss cap, and according to Shawn, there
is more code needed to support L1ss in EP mode, perhaps simply drop the
function call from rockchip_pcie_ep_init(), then we can drop
'rockchip->data->mode == DW_PCIE_RC_TYPE' from the above if statement.


> +		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY,
> +					 PCIE_CLIENT_POWER_CON);
> +		pci->l1ss_support = true;
> +		return;
> +	}
> +
> +	/* Otherwise, pull down CLKREQ# */
> +	rockchip_pcie_writel_apb(rockchip,
> +				 PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
> +				 PCIE_CLIENT_POWER_CON);
> +}
> +
>  static void rockchip_pcie_enable_l0s(struct dw_pcie *pci)
>  {
>  	u32 cap, lnkcap;
> @@ -264,6 +297,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);
>  
> +	rockchip_pcie_configure_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
>  
>  	return 0;
> @@ -301,6 +335,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
>  
> +	rockchip_pcie_configure_l1sub(pci);

Considering that DWC core clears L1ss cap, and according to Shawn, there
is more code needed to support L1ss in EP mode, perhaps simply drop this
function call?


>  	rockchip_pcie_enable_l0s(pci);
>  	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>  
> @@ -412,6 +447,9 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>  		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
>  				     "failed to get reset lines\n");
>  
> +	rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node,
> +							  "supports-clkreq");
> +
>  	return 0;
>  }
>  
> -- 
> 2.43.0
> 

