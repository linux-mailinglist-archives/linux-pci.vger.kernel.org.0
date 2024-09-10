Return-Path: <linux-pci+bounces-13019-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 959D9974640
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2024 01:07:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BAE821C24407
	for <lists+linux-pci@lfdr.de>; Tue, 10 Sep 2024 23:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A7E1ABEC6;
	Tue, 10 Sep 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o2GAGHI/"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5E41A4F1E;
	Tue, 10 Sep 2024 23:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726009622; cv=none; b=BUuiq7eUVh+gaBRWo0RdCs2+Yl/rhaTiwAIkgaehVok1Db01jnfMJx22Q6hXy9ZQCCMKctjoelC2KdmPnubbCN9QyElsIE60cOZnZc3rhDxq1ZF0L5eXVirFDCeG3uFmR0+kuk1DMcF1mHlGkV7PxyameFR/wzqDNv/Rii4sZzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726009622; c=relaxed/simple;
	bh=aXNVJJUu723r1qciRRGghYzcmNf7xP8P9iDxmmz+3OI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=OIcudCqsEq2JKYUNg/lC5dMdL1LbfFC6QrUFxVZviHeLEp4fAkusJhrODdwjuAYo4nz3815pLtVXsACWBBI3jVph+MTnZ0UxVOBYgvWKqUR/1lCrIbAReG+f72ys1L+2eMmUsnXWZgiWXdZIs4beozc1yW5Krn4N2/aNOqm7Zao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o2GAGHI/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB6AC4CEC3;
	Tue, 10 Sep 2024 23:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726009622;
	bh=aXNVJJUu723r1qciRRGghYzcmNf7xP8P9iDxmmz+3OI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=o2GAGHI/MVnWvX8smNfwyH+7o0QNTgbUT+/HV75jeFnjhQyAn+0+slFdBpCD0JTNE
	 zMVbwuQWvAGPzNWcPCnLA32/8syNUOorulamtDnV8zhYxA4EqHoFSgICKUeM4zCycE
	 WPJUNmowQEr49maHfkzTii7hDERN1R6LlqAz+nUcoELZqwoXIRb1dyvYyB54Sa3zVX
	 RWwFKfC27zPAy8lCjFfnwcv7shjYCW8tlrg5iygPkiXM7UWXbRzYB2e233Wg6ySkWp
	 rJ+6POmrg+JUsYT6K7FjDj+KjidBXeADbAjx2y1PExMJWyqFSOqWTL8FBWGwH7SDLa
	 yumPa8iVd4DNg==
Date: Tue, 10 Sep 2024 18:07:00 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Rob Herring <robh@kernel.org>, jim2101024@gmail.com,
	bcm-kernel-feedback-list@broadcom.com, linux-pci@vger.kernel.org,
	linux-rpi-kernel@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH] PCI: brcmstb: Sort enums, pcie_offsets[], pcie_cfg_data,
 .compatible strings
Message-ID: <20240910230700.GA608615@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240902205456.227409-1-helgaas@kernel.org>

On Mon, Sep 02, 2024 at 03:54:56PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Sort enum pcie_soc_base values.
> 
> Rename pcie_offsets_bmips_7425[] to pcie_offsets_bcm7425[] to match BCM7425
> pcie_soc_base enum, bcm7425_cfg, and "brcm,bcm7425-pcie" .compatible
> string.
> 
> Rename pcie_offset_bcm7278[] to pcie_offsets_bcm7278[] to match other
> "pcie_offsets" names.
> 
> Rename pcie_offset_bcm7712[] to pcie_offsets_bcm7712[] to match other
> "pcie_offsets" names.
> 
> Sort pcie_offsets_*[] by SoC name, move them all together, indent values
> for easy reading.
> 
> Sort pcie_cfg_data structs by SoC name.
> 
> Sort .compatible strings by SoC name.
> 
> No functional change intended.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

I applied this on top of pci/controller/brcmstb for v6.12.  Krzysztof,
if you decide to apply anything else on this branch, feel free to drop
this patch first if it causes conflicts, and I can refresh it.

> ---
> This is based on Jim's v6 series at
> https://lore.kernel.org/r/20240815225731.40276-1-james.quinlan@broadcom.com
> as applied at
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1ae791a877e7
> 
>  drivers/pci/controller/pcie-brcmstb.c | 114 +++++++++++++-------------
>  1 file changed, 57 insertions(+), 57 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 21e692a57882..07b415fa04ea 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -220,11 +220,11 @@ enum {
>  
>  enum pcie_soc_base {
>  	GENERIC,
> -	BCM7425,
> -	BCM7435,
> +	BCM2711,
>  	BCM4908,
>  	BCM7278,
> -	BCM2711,
> +	BCM7425,
> +	BCM7435,
>  	BCM7712,
>  };
>  
> @@ -1663,26 +1663,34 @@ static void brcm_pcie_remove(struct platform_device *pdev)
>  }
>  
>  static const int pcie_offsets[] = {
> -	[RGR1_SW_INIT_1] = 0x9210,
> -	[EXT_CFG_INDEX]  = 0x9000,
> -	[EXT_CFG_DATA]   = 0x9004,
> -	[PCIE_HARD_DEBUG] = 0x4204,
> -	[PCIE_INTR2_CPU_BASE] = 0x4300,
> +	[RGR1_SW_INIT_1]	= 0x9210,
> +	[EXT_CFG_INDEX]		= 0x9000,
> +	[EXT_CFG_DATA]		= 0x9004,
> +	[PCIE_HARD_DEBUG]	= 0x4204,
> +	[PCIE_INTR2_CPU_BASE]	= 0x4300,
>  };
>  
> -static const int pcie_offsets_bmips_7425[] = {
> -	[RGR1_SW_INIT_1] = 0x8010,
> -	[EXT_CFG_INDEX]  = 0x8300,
> -	[EXT_CFG_DATA]   = 0x8304,
> -	[PCIE_HARD_DEBUG] = 0x4204,
> -	[PCIE_INTR2_CPU_BASE] = 0x4300,
> +static const int pcie_offsets_bcm7278[] = {
> +	[RGR1_SW_INIT_1]	= 0xc010,
> +	[EXT_CFG_INDEX]		= 0x9000,
> +	[EXT_CFG_DATA]		= 0x9004,
> +	[PCIE_HARD_DEBUG]	= 0x4204,
> +	[PCIE_INTR2_CPU_BASE]	= 0x4300,
>  };
>  
> -static const int pcie_offset_bcm7712[] = {
> -	[EXT_CFG_INDEX]  = 0x9000,
> -	[EXT_CFG_DATA]   = 0x9004,
> -	[PCIE_HARD_DEBUG] = 0x4304,
> -	[PCIE_INTR2_CPU_BASE] = 0x4400,
> +static const int pcie_offsets_bcm7425[] = {
> +	[RGR1_SW_INIT_1]	= 0x8010,
> +	[EXT_CFG_INDEX]		= 0x8300,
> +	[EXT_CFG_DATA]		= 0x8304,
> +	[PCIE_HARD_DEBUG]	= 0x4204,
> +	[PCIE_INTR2_CPU_BASE]	= 0x4300,
> +};
> +
> +static const int pcie_offsets_bcm7712[] = {
> +	[EXT_CFG_INDEX]		= 0x9000,
> +	[EXT_CFG_DATA]		= 0x9004,
> +	[PCIE_HARD_DEBUG]	= 0x4304,
> +	[PCIE_INTR2_CPU_BASE]	= 0x4400,
>  };
>  
>  static const struct pcie_cfg_data generic_cfg = {
> @@ -1693,8 +1701,32 @@ static const struct pcie_cfg_data generic_cfg = {
>  	.num_inbound_wins = 3,
>  };
>  
> +static const struct pcie_cfg_data bcm2711_cfg = {
> +	.offsets	= pcie_offsets,
> +	.soc_base	= BCM2711,
> +	.perst_set	= brcm_pcie_perst_set_generic,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound_wins = 3,
> +};
> +
> +static const struct pcie_cfg_data bcm4908_cfg = {
> +	.offsets	= pcie_offsets,
> +	.soc_base	= BCM4908,
> +	.perst_set	= brcm_pcie_perst_set_4908,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.num_inbound_wins = 3,
> +};
> +
> +static const struct pcie_cfg_data bcm7278_cfg = {
> +	.offsets	= pcie_offsets_bcm7278,
> +	.soc_base	= BCM7278,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
> +	.num_inbound_wins = 3,
> +};
> +
>  static const struct pcie_cfg_data bcm7425_cfg = {
> -	.offsets	= pcie_offsets_bmips_7425,
> +	.offsets	= pcie_offsets_bcm7425,
>  	.soc_base	= BCM7425,
>  	.perst_set	= brcm_pcie_perst_set_generic,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> @@ -1709,40 +1741,8 @@ static const struct pcie_cfg_data bcm7435_cfg = {
>  	.num_inbound_wins = 3,
>  };
>  
> -static const struct pcie_cfg_data bcm4908_cfg = {
> -	.offsets	= pcie_offsets,
> -	.soc_base	= BCM4908,
> -	.perst_set	= brcm_pcie_perst_set_4908,
> -	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> -	.num_inbound_wins = 3,
> -};
> -
> -static const int pcie_offset_bcm7278[] = {
> -	[RGR1_SW_INIT_1] = 0xc010,
> -	[EXT_CFG_INDEX] = 0x9000,
> -	[EXT_CFG_DATA] = 0x9004,
> -	[PCIE_HARD_DEBUG] = 0x4204,
> -	[PCIE_INTR2_CPU_BASE] = 0x4300,
> -};
> -
> -static const struct pcie_cfg_data bcm7278_cfg = {
> -	.offsets	= pcie_offset_bcm7278,
> -	.soc_base	= BCM7278,
> -	.perst_set	= brcm_pcie_perst_set_7278,
> -	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
> -	.num_inbound_wins = 3,
> -};
> -
> -static const struct pcie_cfg_data bcm2711_cfg = {
> -	.offsets	= pcie_offsets,
> -	.soc_base	= BCM2711,
> -	.perst_set	= brcm_pcie_perst_set_generic,
> -	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> -	.num_inbound_wins = 3,
> -};
> -
>  static const struct pcie_cfg_data bcm7216_cfg = {
> -	.offsets	= pcie_offset_bcm7278,
> +	.offsets	= pcie_offsets_bcm7278,
>  	.soc_base	= BCM7278,
>  	.perst_set	= brcm_pcie_perst_set_7278,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_7278,
> @@ -1751,7 +1751,7 @@ static const struct pcie_cfg_data bcm7216_cfg = {
>  };
>  
>  static const struct pcie_cfg_data bcm7712_cfg = {
> -	.offsets	= pcie_offset_bcm7712,
> +	.offsets	= pcie_offsets_bcm7712,
>  	.perst_set	= brcm_pcie_perst_set_7278,
>  	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
>  	.soc_base	= BCM7712,
> @@ -1762,11 +1762,11 @@ static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
>  	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
>  	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
> -	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
>  	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
> -	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
> -	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
> +	{ .compatible = "brcm,bcm7278-pcie", .data = &bcm7278_cfg },
>  	{ .compatible = "brcm,bcm7425-pcie", .data = &bcm7425_cfg },
> +	{ .compatible = "brcm,bcm7435-pcie", .data = &bcm7435_cfg },
> +	{ .compatible = "brcm,bcm7445-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7712-pcie", .data = &bcm7712_cfg },
>  	{},
>  };
> -- 
> 2.34.1
> 

