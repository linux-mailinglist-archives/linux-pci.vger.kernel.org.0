Return-Path: <linux-pci+bounces-45205-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1AD3B5C9
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 19:28:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 68FCA3077781
	for <lists+linux-pci@lfdr.de>; Mon, 19 Jan 2026 18:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920FE32ED25;
	Mon, 19 Jan 2026 18:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="XlLS9tAV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7CA274B5C
	for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 18:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768847132; cv=none; b=PV1wx0OZ6WuuOK4UXAh6TilHNB5b20NHzfD3+0ZEq4P2cJdIYvTa880kjoP4dx5O1Yr0esQySTT3to9ReXCiDKq94EBSl+TX3wKY96L05EnbUCvF9843z5IpY4Pwkr36q7KMapC/oD+4EKMCld+fihCHYa47s8QVHHmuMfReHFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768847132; c=relaxed/simple;
	bh=uBim635sgAsXaWwm9wR8s0uY9gq6NFFriBbX9FXTOoE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ota0e32WF9ZMejulEkE1lJLjHs8KJabh/4gHsnR6g/4ltN28dDojPx7BbfX1qLGOyaz5AEHLNu1rb73kY1akAKjJpcyFITWRJ8dJ9RAwGGi+d4/bE4v6z7scj11ns5vBHf4b6+w2EbTKrG/E4XnZWuq4uzcM+V4EjFtSVilrgSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=XlLS9tAV; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-655afbca977so5635813a12.2
        for <linux-pci@vger.kernel.org>; Mon, 19 Jan 2026 10:25:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1768847129; x=1769451929; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3buk5f0PCfkVbeaZaIKnS06d0AxhIc+SklRhgOIH5N0=;
        b=XlLS9tAVwbuRnRq4rr9OuFCBTNQHAK5QcHQTFB1rAv0k5iv/dD4ixIwKVGl4zrNcrj
         0jUiHpVIM3RFGXVJ75m1PsgA+H30DoxEXD30hK/CX8OHRgtyfgkJfIrWFM8Pfrwy+hy3
         aXFBYcMIgYcjvPsD2QG80jtZ7obeQRpUpGvk/Cm7oGweogzk2yWLqDv44+HsTnzIk72b
         BZ4zaRStAiJDPvhWeUcYokireNUcwuJfEb6CbiKXuBHC5WHN/f6tGQgwC1SHB3cE09um
         B+Gpc8HOSEr2HgRuoo5Gv57v6F4emTMVdFgGAUOAod137h+IwnT9h4/Prh8/SklLCyvr
         PPrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768847129; x=1769451929;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3buk5f0PCfkVbeaZaIKnS06d0AxhIc+SklRhgOIH5N0=;
        b=rZlU0xwNDB/TB+prTxSB6frM04c4l+vI06HeGmJUMiLh0/h0eOio8Wc0dBxCATsKnv
         2Kq6seGfC3tbEvrUntPtW27/hID5uIu0MrzfDfOn/nBI0neD0oISjsMPVXXrwMOR8kXt
         tleYQFHaKIFPM+R+upEdZurbbfRnBtocHwvV7yJZIspze7896jaQqpJkoNjJhpp2c1fV
         MPxS4v3ctG66lhEfGhdv9hGCzDjge+ZHp6I7bXe0ozObQ5kfLJ9fmyo93X6U+MPy6Hh+
         nJm7MLLmyTgyKLa7w1LaHDwv1rv0+TJq5ISyE+HKqHsbblqrctJNkrf3vtkmuMKOSKVW
         v/gA==
X-Forwarded-Encrypted: i=1; AJvYcCXjHoLIbVf710hdmSA24IHDYcmGNgAS0AoM/paglGyNjLFvvKKmVCj7fm2JTchgYcGFADD0CDik/JI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQx8+rSfLbFiMzvZzlYuaMuMd0hQcyutkodNZZwRA31M8ur9dd
	xmpIUUGIuMRKm8Bx0c3D41dQWbtIJjXjh+M3J4ZKnQeXyY0y6NxgClwNsxTXAk6VBcY=
X-Gm-Gg: AY/fxX6ivZo4wzQ3a+m+g4pMwSdOXXhjqWQfnYDeVJEHUqP1nR1lnJxsaTdxVk3tGPK
	1bKhCZ799imjsQ2oU5X7YeHaYluGfm2zFY2sSj+DoXJTfWs4X95ZxIquxh5k95yrPm////ouoTg
	/38aHZlYVLi0KwJyUwUbadkvfTzP3GPiYfNCztK8Sgfm8ZOc3Af6K1AeUL4RDD9jlWeJqnMzyKS
	q4TdIrM/Efa2WFJSBzBAiFDAWlLDnGVvzaA1lwt7/ubT3Mo/gJbimJBkE135KIE9IWSI6K6fW32
	XZIy1XSZAO+LQYhdHrSOqnMSzU9GyQuO3ddCA9Zg4Bm/33HgMHSNk89EIEqJSpUtgLXbQQXP7Ri
	mcVp8irqDXzxSIhcGUFU1r/H/P+O+Xt3aXEoDy+D27q8RZEvtom8/4nzTrLwgs4M8nsNv2635AV
	RduBd9PExLx8ey7WOJYg==
X-Received: by 2002:a17:907:3cc4:b0:b87:2b1a:3c55 with SMTP id a640c23a62f3a-b8792fc438cmr1162264366b.39.1768847128685;
        Mon, 19 Jan 2026 10:25:28 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.31])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9763sm1109285566b.35.2026.01.19.10.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jan 2026 10:25:28 -0800 (PST)
Message-ID: <6bbd18e4-9adf-472a-8452-5e535cb06a1b@tuxon.dev>
Date: Mon, 19 Jan 2026 20:25:26 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/16] PCI: rzg3s-host: Add support for RZ/G3E PCIe
 controller
To: John Madieu <john.madieu.xa@bp.renesas.com>,
 claudiu.beznea.uj@bp.renesas.com, lpieralisi@kernel.org,
 kwilczynski@kernel.org, mani@kernel.org, geert+renesas@glider.be,
 krzk+dt@kernel.org
Cc: robh@kernel.org, bhelgaas@google.com, conor+dt@kernel.org,
 magnus.damm@gmail.com, biju.das.jz@bp.renesas.com,
 linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-clk@vger.kernel.org, john.madieu@gmail.com
References: <20260114153337.46765-1-john.madieu.xa@bp.renesas.com>
 <20260114153337.46765-13-john.madieu.xa@bp.renesas.com>
Content-Language: en-US
From: Claudiu Beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20260114153337.46765-13-john.madieu.xa@bp.renesas.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi, John,

On 1/14/26 17:33, John Madieu wrote:
> Add support for the PCIe controller found in RZ/G3E SoCs to the existing
> RZ/G3S PCIe host driver. The RZ/G3E PCIe controller is similar to the
> RZ/G3S's, with the following key differences:
> 
>   - Supports PCIe Gen3 (8.0 GT/s) link speeds alongside Gen2 (5.0 GT/s)
>   - Uses a different reset control mechanism via AXI registers instead
>     of the Linux reset framework
>   - Requires specific SYSC configuration for link state control and
>     Root Complex mode selection
> 
> Signed-off-by: John Madieu <john.madieu.xa@bp.renesas.com>
> ---
>   drivers/pci/controller/pcie-rzg3s-host.c | 231 ++++++++++++++++++++---
>   1 file changed, 209 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rzg3s-host.c b/drivers/pci/controller/pcie-rzg3s-host.c
> index b0a5c08d2527..b046360e92da 100644
> --- a/drivers/pci/controller/pcie-rzg3s-host.c
> +++ b/drivers/pci/controller/pcie-rzg3s-host.c
> @@ -111,6 +111,16 @@
>   #define RZG3S_PCI_PERM_CFG_HWINIT_EN		BIT(2)
>   #define RZG3S_PCI_PERM_PIPE_PHY_REG_EN		BIT(1)
>   
> +/* RZ/G3E specific registers */
> +#define RZG3E_PCI_RESET				0x310
> +#define RZG3E_PCI_RESET_RST_OUT_B		BIT(6)
> +#define RZG3E_PCI_RESET_RST_PS_B		BIT(5)
> +#define RZG3E_PCI_RESET_RST_LOAD_B		BIT(4)
> +#define RZG3E_PCI_RESET_RST_CFG_B		BIT(3)
> +#define RZG3E_PCI_RESET_RST_RSM_B		BIT(2)
> +#define RZG3E_PCI_RESET_RST_GP_B		BIT(1)
> +#define RZG3E_PCI_RESET_RST_B			BIT(0)
> +
>   #define RZG3S_PCI_MSIRE(id)			(0x600 + (id) * 0x10)
>   #define RZG3S_PCI_MSIRE_ENA			BIT(0)
>   
> @@ -183,9 +193,13 @@ struct rzg3s_sysc_function {
>   /**
>    * struct rzg3s_sysc_info - RZ/G3S System Controller function info
>    * @rst_rsm_b: Reset RSM_B function descriptor
> + * @l1_allow: L1 power state management function descriptor
> + * @mode: Mode configuration function descriptor
>    */
>   struct rzg3s_sysc_info {
>   	struct rzg3s_sysc_function rst_rsm_b;
> +	struct rzg3s_sysc_function l1_allow;
> +	struct rzg3s_sysc_function mode;
>   };
>   
>   /**
> @@ -1201,6 +1215,10 @@ static int rzg3s_pcie_resets_prepare_and_get(struct rzg3s_pcie_host *host)
>   	if (ret)
>   		return ret;
>   
> +	/* Mandatory for RZ/G3E, harmless for RZ/G3S */
> +	reset_control_bulk_assert(data->num_power_resets,
> +				  host->power_resets);
> +

This is similar to what the IP needs for clock when the mode is changed (RC or 
EP). Could it be handled in a similar way the clocks were handled (make sure it 
is asserted on the reset driver probe)?

>   	return devm_reset_control_bulk_get_optional_exclusive(host->dev,
>   							      data->num_cfg_resets,
>   							      host->cfg_resets);
> @@ -1266,6 +1284,7 @@ static int rzg3s_pcie_host_init_port(struct rzg3s_pcie_host *host)
>   
>   static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
>   {
> +	const struct rzg3s_sysc_info *sysc_info = host->sysc->info;
>   	u32 val;
>   	int ret;
>   
> @@ -1282,6 +1301,16 @@ static int rzg3s_pcie_host_init(struct rzg3s_pcie_host *host)
>   	if (ret)
>   		return ret;
>   
> +	/* Enable ASPM L1 transition for SoCs that use it */
> +	if (sysc_info->l1_allow.mask) {
> +		ret = regmap_update_bits(host->sysc->regmap,
> +					 sysc_info->l1_allow.offset,
> +					 sysc_info->l1_allow.mask,
> +					 field_prep(sysc_info->l1_allow.mask, 1));
> +		if (ret)

Should the code jump to cfg_deinit label to de-assert some of the resets 
asserted though cfg_pre_init() ?

> +			return ret;
> +	}
> +
>   	/* Initialize the interrupts */
>   	rzg3s_pcie_irq_init(host);
>   
> @@ -1625,12 +1654,27 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   		goto port_refclk_put;
>   	}
>   
> -	ret = regmap_update_bits(sysc->regmap,
> -				 sysc->info->rst_rsm_b.offset,
> -				 sysc->info->rst_rsm_b.mask,
> -				 field_prep(sysc->info->rst_rsm_b.mask, 1));
> -	if (ret)
> -		goto port_refclk_put;
> +	/*
> +	 * Put controller in RC (Root Complex) mode for SoCs that
> +	 * support it. These can operate in either EP or RC mode.
> +	 */
> +	if (sysc->info->mode.mask) {
> +		ret = regmap_write(sysc->regmap,
> +				   sysc->info->mode.offset,

This can go on the previous line to save one line of code.

> +				   sysc->info->mode.mask);
> +		if (ret)
> +			goto port_refclk_put;
> +	}
> +
> +	/* De-assert SYSC RST_RSM_B only if used by the SoC */

This comment wasn't here previously. I don't think it is not needed, FMPOV.

> +	if (sysc->info->rst_rsm_b.mask) {
> +		ret = regmap_update_bits(sysc->regmap,
> +					 sysc->info->rst_rsm_b.offset,
> +					 sysc->info->rst_rsm_b.mask,
> +					 field_prep(sysc->info->rst_rsm_b.mask, 1));
> +		if (ret)
> +			goto port_refclk_put;
> +	}
>   
>   	ret = rzg3s_pcie_resets_prepare_and_get(host);
>   	if (ret)
> @@ -1684,9 +1728,11 @@ static int rzg3s_pcie_probe(struct platform_device *pdev)
>   	 * SYSC RST_RSM_B signal need to be asserted before turning off the
>   	 * power to the PHY.
>   	 */
> -	regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
> -			   sysc->info->rst_rsm_b.mask,
> -			   field_prep(sysc->info->rst_rsm_b.mask, 0));
> +	if (sysc->info->rst_rsm_b.mask)

This driver is using (almost everywhere) { } on code blocks spanning multiple 
lines even though they represent a single function call like in this case. For 
consistency, I would use the same principle.

> +		regmap_update_bits(sysc->regmap,
> +				   sysc->info->rst_rsm_b.offset,
> +				   sysc->info->rst_rsm_b.mask,
> +				   field_prep(sysc->info->rst_rsm_b.mask, 0));
>   port_refclk_put:
>   	clk_put(host->port.refclk);
>   
> @@ -1721,11 +1767,15 @@ static int rzg3s_pcie_suspend_noirq(struct device *dev)
>   	if (ret)
>   		goto cfg_reinit;
>   
> -	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
> -				 sysc->info->rst_rsm_b.mask,
> -				 field_prep(sysc->info->rst_rsm_b.mask, 0));
> -	if (ret)
> -		goto power_resets_restore;
> +	/* Assert SYSC RST_RSM_B if supported */

Comment was not there previously. Could you please drop it?

> +	if (sysc->info->rst_rsm_b.mask) {
> +		ret = regmap_update_bits(sysc->regmap,
> +					 sysc->info->rst_rsm_b.offset,
> +					 sysc->info->rst_rsm_b.mask,
> +					 field_prep(sysc->info->rst_rsm_b.mask, 0));
> +		if (ret)
> +			goto power_resets_restore;
> +	}
>   
>   	return 0;
>   
> @@ -1748,11 +1798,23 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
>   	struct rzg3s_sysc *sysc = host->sysc;
>   	int ret;
>   
> -	ret = regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
> -				 sysc->info->rst_rsm_b.mask,
> -				 field_prep(sysc->info->rst_rsm_b.mask, 1));
> -	if (ret)
> -		return ret;
> +	/* De-assert SYSC RST_RSM_B if supported */
> +	if (sysc->info->rst_rsm_b.mask) {
> +		ret = regmap_update_bits(sysc->regmap,
> +					 sysc->info->rst_rsm_b.offset,
> +					 sysc->info->rst_rsm_b.mask,
> +					 field_prep(sysc->info->rst_rsm_b.mask, 1));
> +		if (ret)
> +			return ret;
> +	}
> +
> +	if (sysc->info->mode.mask) {
> +		ret = regmap_write(sysc->regmap,
> +				   sysc->info->mode.offset,
> +				   sysc->info->mode.mask);
> +		if (ret)
> +			return ret;
> +	}

Could you please keep the same order as in probe:
1/ set mode
2/ set rst_rsm_b

?

>   
>   	ret = rzg3s_pcie_power_resets_deassert(host);
>   	if (ret)
> @@ -1779,12 +1841,133 @@ static int rzg3s_pcie_resume_noirq(struct device *dev)
>   	reset_control_bulk_assert(data->num_power_resets,
>   				  host->power_resets);
>   assert_rst_rsm_b:
> -	regmap_update_bits(sysc->regmap, sysc->info->rst_rsm_b.offset,
> -			   sysc->info->rst_rsm_b.mask,
> -			   field_prep(sysc->info->rst_rsm_b.mask, 0));
> +	if (sysc->info->rst_rsm_b.mask)

Multi line statement here as well, I would use { } around this block based on 
the rationale provided above.

> +		regmap_update_bits(sysc->regmap,
> +				   sysc->info->rst_rsm_b.offset,
> +				   sysc->info->rst_rsm_b.mask,
> +				   field_prep(sysc->info->rst_rsm_b.mask, 0));
>   	return ret;
>   }
>   
> +/* RZ/G3E SoC-specific implementations */
> +static void rzg3e_pcie_config_pre_init(struct rzg3s_pcie_host *host)
> +{
> +	/*
> +	 * De-assert LOAD_B and CFG_B during configuration phase.
> +	 * These are part of the RZ/G3E reset register, not reset framework.
> +	 * Other reset bits remain asserted until cfg_post_init.
> +	 */
> +	rzg3s_pcie_update_bits(host->axi, RZG3E_PCI_RESET,
> +			       RZG3E_PCI_RESET_RST_LOAD_B | RZG3E_PCI_RESET_RST_CFG_B,
> +			       RZG3E_PCI_RESET_RST_LOAD_B | RZG3E_PCI_RESET_RST_CFG_B);
> +}
> +
> +static void rzg3e_cfg_deinit(struct rzg3s_pcie_host *host)
> +{
> +	writel_relaxed(0, host->axi + RZG3E_PCI_RESET);
> +}
> +
> +static int rzg3e_cfg_post_init(struct rzg3s_pcie_host *host)
> +{
> +	/* De-assert PS_B, GP_B, RST_B */
> +	rzg3s_pcie_update_bits(host->axi, RZG3E_PCI_RESET,
> +			       RZG3E_PCI_RESET_RST_PS_B | RZG3E_PCI_RESET_RST_GP_B |
> +			       RZG3E_PCI_RESET_RST_B,
> +			       RZG3E_PCI_RESET_RST_PS_B | RZG3E_PCI_RESET_RST_GP_B |
> +			       RZG3E_PCI_RESET_RST_B);
> +
> +	/* Hardware requires >= 500us delay before final reset deassert */

Could you please cite the RZ/G3E HW manual chapter and revision, requiring this?

> +	fsleep(500);
> +
> +	/* De-assert OUT_B and RSM_B to complete reset sequence */
> +	rzg3s_pcie_update_bits(host->axi, RZG3E_PCI_RESET,
> +			       RZG3E_PCI_RESET_RST_OUT_B | RZG3E_PCI_RESET_RST_RSM_B,
> +			       RZG3E_PCI_RESET_RST_OUT_B | RZG3E_PCI_RESET_RST_RSM_B);
> +
> +	return 0;
> +}

Could you please move these config related function close to the other config 
specific functions?

> +
> +static int rzg3e_pcie_set_inbound_windows(struct rzg3s_pcie_host *host,
> +					  struct resource_entry *entry,
> +					  int *index)

As mentioned in a previous patch, this works for RZ/G3E as well and I see no 
differences in HW manual b/w RZ/G3S and RZ/G3E, unless I'm missing something. 
Please use a single function for inbound setup if there is no restriction.

> +{
> +	u64 pci_addr = entry->res->start - entry->offset;
> +	u64 cpu_addr = entry->res->start;
> +	u64 cpu_end = entry->res->end;
> +	int id = *index;
> +	u64 size;
> +
> +	/*
> +	 * The RZ/G3E requires power-of-2 sizes (4K * 2^N) due to mask register
> +	 * format. Split non-power-of-2 regions into multiple windows to avoid
> +	 * over-mapping.
> +	 */
> +	while (cpu_addr <= cpu_end) {
> +		u64 remaining_size = cpu_end - cpu_addr + 1;
> +		u64 align_limit;
> +
> +		if (id >= RZG3S_MAX_WINDOWS)
> +			return dev_err_probe(host->dev, -ENOSPC,
> +					     "Failed to map inbound window for resource (%s)\n",
> +					     entry->res->name);
> +
> +		/* Start with largest power-of-two that fits in remaining size */
> +		size = 1ULL << __fls(remaining_size);
> +
> +		/*
> +		 * Find alignment limit - the largest power-of-two that both
> +		 * addresses are aligned to
> +		 */
> +		align_limit = min(cpu_addr ? (1ULL << __ffs(cpu_addr)) : ~0ULL,
> +				  pci_addr ? (1ULL << __ffs(pci_addr)) : ~0ULL);
> +
> +		/* Window size cannot exceed alignment */
> +		size = min(size, align_limit);
> +
> +		/*
> +		 * According to the RZ/G3E HW manual Rev.1.15,
> +		 * (Section 6.6.4.1.3.(74) AXI Window Mask (Lower) Register):
> +		 * The area which can be set is 4K * 2^N bytes.
> +		 */
> +		size = max(size, SZ_4K);
> +
> +		/*
> +		 * HW expects size - 1 for mask register.
> +		 * For example: 4KB (0x1000) becomes mask 0xfff (12 bits set).
> +		 */
> +		rzg3s_pcie_set_inbound_window(host, cpu_addr, pci_addr,
> +					      size - 1, id);
> +
> +		cpu_addr += size;
> +		pci_addr += size;
> +		id++;
> +	}
> +	*index = id;
> +
> +	return 0;
> +}
> +
> +static const char * const rzg3e_soc_power_resets[] = { "aresetn" };
> +
> +static const struct rzg3s_pcie_soc_data rzg3e_soc_data = {

Could you please move rzg3e_soc_power_resets[] and rzg3e_soc_data after 
rzg3s_pcie_pm_ops to have all the RZ/G3E SoC specific data close to the RZ/G3S 
SoC specific data?

Thank you,
Claudiu

> +	.power_resets = rzg3e_soc_power_resets,
> +	.num_power_resets = ARRAY_SIZE(rzg3e_soc_power_resets),
> +	.cfg_post_init = rzg3e_cfg_post_init,
> +	.cfg_deinit = rzg3e_cfg_deinit,
> +	.cfg_pre_init = rzg3e_pcie_config_pre_init,
> +	.set_inbound_windows = rzg3e_pcie_set_inbound_windows,
> +	.sysc_info = {
> +		.l1_allow = {
> +			.offset = 0x1020,
> +			.mask = BIT(0),
> +		},
> +		.mode = {
> +			.offset = 0x1024,
> +			.mask = BIT(0),
> +		},
> +	},
> +};
> +
>   static const struct dev_pm_ops rzg3s_pcie_pm_ops = {
>   	NOIRQ_SYSTEM_SLEEP_PM_OPS(rzg3s_pcie_suspend_noirq,
>   				  rzg3s_pcie_resume_noirq)
> @@ -1819,6 +2002,10 @@ static const struct of_device_id rzg3s_pcie_of_match[] = {
>   		.compatible = "renesas,r9a08g045-pcie",
>   		.data = &rzg3s_soc_data,
>   	},
> +	{
> +		.compatible = "renesas,r9a09g047-pcie",
> +		.data = &rzg3e_soc_data,
> +	},
>   	{}
>   };
>   


