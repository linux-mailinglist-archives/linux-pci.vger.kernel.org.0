Return-Path: <linux-pci+bounces-14488-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 806B299D523
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 19:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 455462849B6
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 17:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3929A1BF7E8;
	Mon, 14 Oct 2024 17:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rBUiFGjg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D20F28FC;
	Mon, 14 Oct 2024 17:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728925268; cv=none; b=spYqNIkcDl0hgDOHll8aCo7gWSAOsWs3Mh+ON0sMyeppJeWlcMEVZGlf8GhKlUWfQB3+0XHn0xKAO1PrbwI/+oJzGE4JjSpC1FtX5OycCCpiZlNHZnJAnIZmYO1X1itjZRYvbg6Q6bSOv0J1YkIVZqq7N8AX0O4IOO6hPp3RVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728925268; c=relaxed/simple;
	bh=4rnWVVjevojtwtVqn08a/Sa8U6/ufbhEi7OxH5i21O0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=druAZBxreu1Tlw+h3kG26rMbwcxpxSH//lSheDX9eSEw5UccNdokAdHTiNwdQcuF7JbBVy7qu90fiJVCEhIcDSo1hfO2MyEC7U7yDF6urPDxVGdvfyPIKEoAF1shqoD5L2jffjqNNZbXskDIJhZdT+lZzYfPhmy2jNCxdEfQfvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rBUiFGjg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C3B8C4CEC3;
	Mon, 14 Oct 2024 17:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728925267;
	bh=4rnWVVjevojtwtVqn08a/Sa8U6/ufbhEi7OxH5i21O0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=rBUiFGjg5D3+povRP3suF9DdpRvhPtxB89Bmo5NXAVClA8kByICp2ptl31P2Oy1iy
	 yPcJ7XkJyeoEXr29RMUJx2JI9SWzExh1F+TwIKvrO0Sbdp9p5tKxDhU10w8uSqK2cr
	 47EXglj4CjeFnIykIYQWN9xEx5tefZGvWpKNCcDc+RgUq43AGcRRW4y8bmue/Tr4Gp
	 yJcFAhEW0kiTLPVyMCNkShtzohD+KpKoKXZgVUFAx3Ni3ESp6DkFTD3YRmVE7EMjrK
	 SAXaz8aAPgW2i4oZJNZpVEvwNRp2KK25pi1SCa3Pi1E/c/PXIXCBormoQ/NiXxuebs
	 qutIerxNCMNxA==
Date: Mon, 14 Oct 2024 12:01:05 -0500
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
	Jonathan Bell <jonathan@raspberrypi.com>
Subject: Re: [PATCH v3 06/11] PCI: brcmstb: Avoid turn off of bridge reset
Message-ID: <20241014170105.GA611115@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241014130710.413-7-svarbanov@suse.de>

On Mon, Oct 14, 2024 at 04:07:05PM +0300, Stanimir Varbanov wrote:
> On PCIe turn off avoid shutdown of bridge reset,
> by introducing a quirk flag.

Can you include something here about *why* we need this change?  I
think the RESCAL comment below would be a good start.

I think this should be squashed with the next commit that adds the use
of CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN.  Otherwise this commit doesn't
have an obvious reason.

> Signed-off-by: Stanimir Varbanov <svarbanov@suse.de>
> ---
> v2 -> v3:
>  - Added more descriptive comment on CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN quirk.
> 
>  drivers/pci/controller/pcie-brcmstb.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index b76c16287f37..757a1646d53c 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -234,10 +234,20 @@ struct inbound_win {
>  	u64 cpu_addr;
>  };
>  
> +/*
> + * The RESCAL block is tied to PCIe controller #1, regardless of the number of
> + * controllers, and turning off PCIe controller #1 prevents access to the RESCAL
> + * register blocks, therefore not other controller can access this register
> + * space, and depending upon the bus fabric we may get a timeout (UBUS/GISB),
> + * or a hang (AXI).

s/not other/no other/

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
> @@ -290,6 +300,7 @@ struct brcm_pcie {
>  	struct subdev_regulators *sr;
>  	bool			ep_wakeup_capable;
>  	bool			has_phy;
> +	u32			quirks;
>  	u8			num_inbound_wins;
>  };
>  
> @@ -1539,8 +1550,9 @@ static int brcm_pcie_turn_off(struct brcm_pcie *pcie)
>  	u32p_replace_bits(&tmp, 1, PCIE_MISC_HARD_PCIE_HARD_DEBUG_SERDES_IDDQ_MASK);
>  	writel(tmp, base + HARD_DEBUG(pcie));
>  
> -	/* Shutdown PCIe bridge */
> -	ret = pcie->bridge_sw_init_set(pcie, 1);
> +	if (!(pcie->quirks & CFG_QUIRK_AVOID_BRIDGE_SHUTDOWN))
> +		/* Shutdown PCIe bridge */
> +		ret = pcie->bridge_sw_init_set(pcie, 1);
>  
>  	return ret;
>  }
> @@ -1854,6 +1866,7 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	pcie->perst_set = data->perst_set;
>  	pcie->bridge_sw_init_set = data->bridge_sw_init_set;
>  	pcie->has_phy = data->has_phy;
> +	pcie->quirks = data->quirks;
>  	pcie->num_inbound_wins = data->num_inbound_wins;
>  
>  	pcie->base = devm_platform_ioremap_resource(pdev, 0);
> -- 
> 2.43.0
> 

