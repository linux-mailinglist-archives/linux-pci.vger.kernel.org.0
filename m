Return-Path: <linux-pci+bounces-21298-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC527A32E19
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 19:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642953A8FBC
	for <lists+linux-pci@lfdr.de>; Wed, 12 Feb 2025 18:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27C6C25B66C;
	Wed, 12 Feb 2025 18:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSvHG7uQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F6420E02B;
	Wed, 12 Feb 2025 18:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383362; cv=none; b=C8Y38TRPZ1jG1fqyHcG8KS4zedWkAk1eIZv2tIQLg33elL6PG7r28X1n3/kWH6vIdfYyfBdVEc5e6dtqE/GuomFrcamnn6KCUqc9LYupMKNipElVTFAE3hzwdHo1o8geJAoP68sbAnFeleG+ZyRarUhGEPAiRKCfz2E1mgjtVh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383362; c=relaxed/simple;
	bh=VOtPgaQkN4DFZIjc+OZtl+y5YAXVhsm1DiEW2xACoKg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NXf/5JmOK4Bd/j1qpqlYqvTLSvwlP0WhPubGp6jRpbcoZ6uPxVSM3r+3gz43hnmOOcx3P4L/WpioF7XK6XTzVyfUgzqjq7rX0Ov9QQIyKkaEc0YHbCZZyEu8AZH6SNy9IkA+OZQZhQLSqHNb/ejfRepRc+HNtFql8rk8q3DlHJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSvHG7uQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33E05C4CEDF;
	Wed, 12 Feb 2025 18:02:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739383361;
	bh=VOtPgaQkN4DFZIjc+OZtl+y5YAXVhsm1DiEW2xACoKg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=iSvHG7uQkcy9TafoAztHzQVnJFYPtMwC3ie4fsCRV1ce3ifnDZJSB8ic67KP5VgtW
	 jVIWoypaeqLqt7TpZuZ8ZqL9UWQYWnSZdI6nhYxUvNDH3tZpDMPqEhXb6m8Vm5XMwz
	 0YZZTCgm2o52+IFhiPxsMSmC0IUhHVp4O8Ph4Jfm0QSZUqDneSFhvAL6uuDzJmF5sC
	 4ffS3rBHdW/tCz3SLKZJIXLRmlggZ6/voQutOashton1BDTwfBlokVpZBtwoAr4Hzo
	 nMLxnau6646AEFmyvdOAoyCegJm7pRWUU/MLWILL2nMsLuMCIQ8nPh4oHU/qBRsadt
	 4PZKKdFySr+IQ==
Date: Wed, 12 Feb 2025 12:02:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Stanimir Varbanov <svarbanov@suse.de>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rpi-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Thomas Gleixner <tglx@linutronix.de>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Jim Quinlan <jim2101024@gmail.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>, kw@linux.com,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Andrea della Porta <andrea.porta@suse.com>,
	Phil Elwell <phil@raspberrypi.com>,
	Jonathan Bell <jonathan@raspberrypi.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH v5 -next 06/11] PCI: brcmstb: Add bcm2712 support
Message-ID: <20250212180237.GA85622@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250120130119.671119-7-svarbanov@suse.de>

On Mon, Jan 20, 2025 at 03:01:14PM +0200, Stanimir Varbanov wrote:
> Add bare minimum amount of changes in order to support PCIe RC hardware
> IP found on RPi5. The PCIe controller on bcm2712 is based on bcm7712 and
> as such it inherits register offsets, perst, bridge_reset ops and inbound
> windows count.

Add blank line between paragraphs.  We can fix when merging if you
don't repost for other reasons.

> Although, the implementation for bcm2712 needs a workaround related to the
> control of the bridge_reset where turning off of the root port must not
> shutdown the bridge_reset and this must be avoided. To implement this
> workaround a quirks field is introduced in pcie_cfg_data struct.
> 
> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---
> v4 -> v5:
>  - No changes.
> 
>  drivers/pci/controller/pcie-brcmstb.c | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index 59190d8be0fb..50607df34a66 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -234,10 +234,20 @@ struct inbound_win {
>  	u64 cpu_addr;
>  };
>  
> +/*
> + * The RESCAL block is tied to PCIe controller #1, regardless of the number of
> + * controllers, and turning off PCIe controller #1 prevents access to the RESCAL
> + * register blocks, therefore no other controller can access this register
> + * space, and depending upon the bus fabric we may get a timeout (UBUS/GISB),
> + * or a hang (AXI).
> + */
> +#define CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN		BIT(0)
> +
>  struct pcie_cfg_data {
>  	const int *offsets;
>  	const enum pcie_soc_base soc_base;
>  	const bool has_phy;
> +	const u32 quirks;
>  	u8 num_inbound_wins;
>  	int (*perst_set)(struct brcm_pcie *pcie, u32 val);
>  	int (*bridge_sw_init_set)(struct brcm_pcie *pcie, u32 val);
> @@ -1488,8 +1498,9 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>  	writel(tmp, base + HARD_DEBUG(pcie));
>  
> -	/* Shutdown PCIe bridge */
> -	ret = pcie->bridge_sw_init_set(pcie, 1);
> +	if (!(pcie->cfg->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
> +		/* Shutdown PCIe bridge */
> +		ret = pcie->cfg->bridge_sw_init_set(pcie, 1);
>  
>  	return ret;
>  }
> @@ -1699,6 +1710,15 @@ static const struct pcie_cfg_data bcm2711_cfg = {
>  	.num_inbound_wins = 3,
>  };
>  
> +static const struct pcie_cfg_data bcm2712_cfg = {
> +	.offsets	= pcie_offsets_bcm7712,
> +	.soc_base	= BCM7712,
> +	.perst_set	= brcm_pcie_perst_set_7278,
> +	.bridge_sw_init_set = brcm_pcie_bridge_sw_init_set_generic,
> +	.quirks		= CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN,
> +	.num_inbound_wins = 10,
> +};
> +
>  static const struct pcie_cfg_data bcm4908_cfg = {
>  	.offsets	= pcie_offsets,
>  	.soc_base	= BCM4908,
> @@ -1750,6 +1770,7 @@ static const struct pcie_cfg_data bcm7712_cfg = {
>  
>  static const struct of_device_id brcm_pcie_match[] = {
>  	{ .compatible = "brcm,bcm2711-pcie", .data = &bcm2711_cfg },
> +	{ .compatible = "brcm,bcm2712-pcie", .data = &bcm2712_cfg },
>  	{ .compatible = "brcm,bcm4908-pcie", .data = &bcm4908_cfg },
>  	{ .compatible = "brcm,bcm7211-pcie", .data = &generic_cfg },
>  	{ .compatible = "brcm,bcm7216-pcie", .data = &bcm7216_cfg },
> -- 
> 2.47.0
> 

