Return-Path: <linux-pci+bounces-39012-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 942F1BFC1B9
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 15:23:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7E09B565E93
	for <lists+linux-pci@lfdr.de>; Wed, 22 Oct 2025 13:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A775A5733E;
	Wed, 22 Oct 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jBSD+gK5"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C4E2A1BF
	for <linux-pci@vger.kernel.org>; Wed, 22 Oct 2025 13:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761138283; cv=none; b=IcR99//ZpBL3xyWD1NZZjFfZg6HMcsBH+vMchA8RHcxckBIMx4kAeWLPJgv7orIhgSQYHBahqxscgMXk18IJTG2k9zBfkoOG1BEpehwVTDdI8x3pme1MGyf7AtvGcnn5nTCr0aL6ffqfdz6Lc6/QyckdvSJQ7g7f56vsm1r9gCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761138283; c=relaxed/simple;
	bh=AlzmNwDNyRZ5BgzXqsEocAhRTH9twQHHInCQ4YLAaCc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pFgW+RR8B/f12+T3nh2yiApjAVoiP+WcHoF6Mu92GesVXZnMWcXre3erQqnweXsYSKvtzUtD9OYJVLz17dSkh6hsoW69mx7L5fX5rgylj5otSYqq8UmOkbY9aBvEdpoVdQKzKiWhwTP5l0kdFbMkGCipWP4pWr85bPfXX/RCNXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jBSD+gK5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CC7EC4CEE7;
	Wed, 22 Oct 2025 13:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761138283;
	bh=AlzmNwDNyRZ5BgzXqsEocAhRTH9twQHHInCQ4YLAaCc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jBSD+gK5HmNHrybcLZf7nBoHQdkeggSRTeHC6nUj79nXCOeJEdZlPO0ntf7ghnjl6
	 /B2jyoa+vhGEsKnN8sqp5ihTp+YIhkfJTjrDqaAx5C0CGelZVUdu6uos4+dqD4ts8e
	 RGosm+jbbFp6ZZhr4GR0rwI3jf+MqtlLrQ87eIMZm7TNxpopsFeijfNZvtV2tBRUNs
	 KAA3DNvEhbCMCUvwq3wDY7ut4prVjDMCgnPs4o00mkexR5WdFHAX49FI1F6M+1zHTS
	 9DDPCdN9SF/Hb2EugtrTQHu/rCfLU0IN0ohjA5RFqcMzP5XOpZfkIfQw3xO6eKy9rd
	 lG8qZa+Y19QDQ==
Date: Wed, 22 Oct 2025 18:34:33 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Shawn Lin <shawn.lin@rock-chips.com>
Cc: Heiko Stuebner <heiko@sntech.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	linux-rockchip@lists.infradead.org, Niklas Cassel <cassel@kernel.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/2] PCI: dw-rockchip: Add L1sub support
Message-ID: <lvixfsccgsodm4hfwxejofjnms5l7xhcskn7fgfdxryfs3ez7z@fh6uajlce6x6>
References: <1761132954-177344-1-git-send-email-shawn.lin@rock-chips.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1761132954-177344-1-git-send-email-shawn.lin@rock-chips.com>

On Wed, Oct 22, 2025 at 07:35:53PM +0800, Shawn Lin wrote:
> The driver should set app_clk_req_n(clkreq ready) of PCIE_CLIENT_POWER reg
> to support L1sub. Otherwise, unset app_clk_req_n and pull down CLKREQ#.
> 

You can definitely improve the commit message on explaining why L1 PM Substates
need to be disabled when the DT property is not present etc... Please refer the
patch from Niklas.

> Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
> 
> ---
> 
> Changes in v2:
> - drop of_pci_clkreq_presnt API
> - drop dependency of Niklas's patch
> 
>  drivers/pci/controller/dwc/pcie-dw-rockchip.c | 36 +++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-dw-rockchip.c b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> index 3e2752c..18cd626 100644
> --- a/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> +++ b/drivers/pci/controller/dwc/pcie-dw-rockchip.c
> @@ -62,6 +62,12 @@
>  /* Interrupt Mask Register Related to Miscellaneous Operation */
>  #define PCIE_CLIENT_INTR_MASK_MISC	0x24
>  
> +/* Power Management Control Register */
> +#define PCIE_CLIENT_POWER		0x2c
> +#define  PCIE_CLKREQ_READY		0x10001
> +#define  PCIE_CLKREQ_NOT_READY		0x10000
> +#define  PCIE_CLKREQ_PULL_DOWN		0x30001000

Can you use bitfields instead of magic values?

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
> @@ -200,6 +207,31 @@ static bool rockchip_pcie_link_up(struct dw_pcie *pci)
>  	return FIELD_GET(PCIE_LINKUP_MASK, val) == PCIE_LINKUP;
>  }
>  
> +static void rockchip_pcie_enable_l1sub(struct dw_pcie *pci)

rockchip_pcie_configure_l1sub()? since this function is not just enabling L1ss.

> +{
> +	struct rockchip_pcie *rockchip = to_rockchip_pcie(pci);
> +	u32 cap, l1subcap;
> +
> +	/* Enable L1 substates if CLKREQ# is properly connected */
> +	if (rockchip->supports_clkreq) {
> +		/* Ready to have reference clock removed */

This comment is misleading (maybe wrong). The presence of this property implies
that the link could enter L1 PM Substates. REFCLK removal only happens when the
link is in L1ss.

So drop the comment.

> +		rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_READY, PCIE_CLIENT_POWER);
> +		return;
> +	}
> +
> +	/* Otherwise, pull down CLKREQ# and disable L1 substates */

"L1 PM Substates"

> +	rockchip_pcie_writel_apb(rockchip, PCIE_CLKREQ_PULL_DOWN | PCIE_CLKREQ_NOT_READY,
> +				 PCIE_CLIENT_POWER);
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
> @@ -264,6 +296,7 @@ static int rockchip_pcie_host_init(struct dw_pcie_rp *pp)
>  	irq_set_chained_handler_and_data(irq, rockchip_pcie_intx_handler,
>  					 rockchip);
>  
> +	rockchip_pcie_enable_l1sub(pci);
>  	rockchip_pcie_enable_l0s(pci);
>  
>  	return 0;
> @@ -301,6 +334,7 @@ static void rockchip_pcie_ep_init(struct dw_pcie_ep *ep)
>  	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
>  	enum pci_barno bar;
>  
> +	rockchip_pcie_enable_l1sub(pci);

I don't think you can decide the CLKREQ# routing on the EP side. The
'supports-clkreq' property is meant only for the RC afaik.

>  	rockchip_pcie_enable_l0s(pci);
>  	rockchip_pcie_ep_hide_broken_ats_cap_rk3588(ep);
>  
> @@ -412,6 +446,8 @@ static int rockchip_pcie_resource_get(struct platform_device *pdev,
>  		return dev_err_probe(&pdev->dev, PTR_ERR(rockchip->rst),
>  				     "failed to get reset lines\n");
>  
> +	rockchip->supports_clkreq = of_property_read_bool(pdev->dev.of_node, "supports-clkreq");

Bjorn still likes to preserve 80 column width for most of the cases.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

