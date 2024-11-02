Return-Path: <linux-pci+bounces-15851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9023E9BA1AC
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 18:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD6E91C2198D
	for <lists+linux-pci@lfdr.de>; Sat,  2 Nov 2024 17:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C841A3BDA;
	Sat,  2 Nov 2024 17:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YTceKAUx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C522FC52
	for <linux-pci@vger.kernel.org>; Sat,  2 Nov 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730568292; cv=none; b=GjbYJrj8SqVaPVxJ2HVfpPO29xsAT4OJJpWjtc7gpY2BJ3zkmeZaNxOeTW8qhWwxQ68Zf6kc61HGtfxT4NfY5kOl5UUpz8FkV6sRdjLN4P77SPNiSj9C3n2VP4ZnPd7Nz2+klsoFIpIi1U+735Af9jMfRud6Gh4SqamEO0FxybM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730568292; c=relaxed/simple;
	bh=ir7DNnGNxnfQNOyGrZQ9MiqehB3fyB/W+1isvUsND54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hGbEp+hpCwL2RForn5luoh79L32Q41lpvB8cw/yIVWlIIk5y+7mHNJMiMtavIAFXbnV8Fe7Kk6qYFLLGGWMBf5UH14ZYqpv+Vu4ehsXfgBR5cz4+bqQn/XNU7jkSdc00OM+vw1IRKbAMK4x+c4k6OGdnlB/8cnBW6aYQ1ggKX7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YTceKAUx; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71e8235f0b6so2591124b3a.3
        for <linux-pci@vger.kernel.org>; Sat, 02 Nov 2024 10:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1730568290; x=1731173090; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=VX3YOh1jhDj1AiTiXMyf+CQYHVDjjL3hhDOyBFnTXKs=;
        b=YTceKAUx49NBcnyIttmCAomtUDLNHwemZ/KbNcm+6wVci9nXIpDHcNNQDp8FDvw5/z
         pTLGg+3QUWcfaPZ86zE3nTsxBgJN3YrCoRdmOq1CuFnC16Z1cV/ImTr9NeIwgKhq9J9n
         DYqL7IjfLMy/pa7IsA24o3IXI1C3d5X3aD4BCpKpUcxxNJuLk4yS1O4mx/kSCHb0/632
         LXpCVi76t9Uy+wKAmua1ERQvTaPXlUx3zL6Zk65wfitH9GALbSFMhO382UHhpSivxlKC
         fnbxmqsU6FTVur5lEUOFNRk/5RsFTnf64KCH6X/7JOMJi6tbuuEyTpU3YUOOZ2k9gTsw
         AmJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730568290; x=1731173090;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VX3YOh1jhDj1AiTiXMyf+CQYHVDjjL3hhDOyBFnTXKs=;
        b=ZBdvmgsPHYGQjf6aqSiMZqoW4ZFmUFKcnvxPASN0xvEUzS6/7jO47Acp4KWTxvFIhE
         dPpiTPiuiC29VuWg8wsVD6hggPyDAX0ArsEL/WySWzKzquJIl/+wTDbVP0AuhvfsSVcQ
         Rwsdp/O3tFIwar4LCiYqZHNmTtmg0BcY07XpCS+khxo4FGQ/ku4PY7R1nkrO+bFXkIAx
         RVpwqj51LzmBOs6HKwfSUCWlrh4eK7FnOq3eDEO1xNbHQzRebPhm5HpcH3p/FlYQ0Ta6
         v56Prpm1PYpuIR/pW4GvXE0UrLHha/oUVAqsfPVqPn3RJrUNP2ydw6LqME9BEi7jQznN
         OA3g==
X-Gm-Message-State: AOJu0YxCVYPJwEdxrQIXBjgJ6+T1pjeMX2a8QAeU/hl02lQmciiN0ChT
	pSkPCFaTRJrCPdIkP0D6KuXr9ST3SJ1rig61WPsU4ca2jnt8tPP1wV75UAoFcg==
X-Google-Smtp-Source: AGHT+IGA3j5kLgj3Ycd5t1j/xeCFdUUpBT/WCxH5pGi54rtX4/oqeQvKBabE6xsNBLnzECZuDrv/1Q==
X-Received: by 2002:a05:6a21:e591:b0:1d9:789:b9bd with SMTP id adf61e73a8af0-1db91ec4045mr15056246637.43.1730568290439;
        Sat, 02 Nov 2024 10:24:50 -0700 (PDT)
Received: from thinkpad ([220.158.156.209])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7ee452979e4sm4093637a12.9.2024.11.02.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 10:24:49 -0700 (PDT)
Date: Sat, 2 Nov 2024 22:54:42 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: linux-pci@vger.kernel.org, ryder.lee@mediatek.com,
	jianjun.wang@mediatek.com, lpieralisi@kernel.org, kw@linux.com,
	robh@kernel.org, bhelgaas@google.com, matthias.bgg@gmail.com,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, kernel@collabora.com,
	fshao@chromium.org
Subject: Re: [PATCH v3 2/2] PCI: mediatek-gen3: Add support for restricting
 link width
Message-ID: <20241102172442.5dpmca6yeb2gmpjt@thinkpad>
References: <20240918081307.51264-1-angelogioacchino.delregno@collabora.com>
 <20240918081307.51264-3-angelogioacchino.delregno@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240918081307.51264-3-angelogioacchino.delregno@collabora.com>

On Wed, Sep 18, 2024 at 10:13:07AM +0200, AngeloGioacchino Del Regno wrote:
> Add support for restricting the port's link width by specifying
> the num-lanes devicetree property in the PCIe node.
> 
> The setting is done in the GEN_SETTINGS register (in the driver
> named as PCIE_SETTING_REG), where each set bit in [11:8] activates
> a set of lanes (from bits 11 to 8 respectively, x16/x8/x4/x2).
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 8d4b045633da..8dd2e5135b01 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -32,6 +32,7 @@
>  #define PCIE_BASE_CFG_SPEED		GENMASK(15, 8)
>  
>  #define PCIE_SETTING_REG		0x80
> +#define PCIE_SETTING_LINK_WIDTH		GENMASK(11, 8)
>  #define PCIE_SETTING_GEN_SUPPORT	GENMASK(14, 12)
>  #define PCIE_PCI_IDS_1			0x9c
>  #define PCI_CLASS(class)		(class << 8)
> @@ -168,6 +169,7 @@ struct mtk_msi_set {
>   * @clks: PCIe clocks
>   * @num_clks: PCIe clocks count for this port
>   * @max_link_speed: Maximum link speed (PCIe Gen) for this port
> + * @num_lanes: Number of PCIe lanes for this port
>   * @irq: PCIe controller interrupt number
>   * @saved_irq_state: IRQ enable state saved at suspend time
>   * @irq_lock: lock protecting IRQ register access
> @@ -189,6 +191,7 @@ struct mtk_gen3_pcie {
>  	struct clk_bulk_data *clks;
>  	int num_clks;
>  	u8 max_link_speed;
> +	u8 num_lanes;
>  
>  	int irq;
>  	u32 saved_irq_state;
> @@ -401,6 +404,14 @@ static int mtk_pcie_startup_port(struct mtk_gen3_pcie *pcie)
>  			val |= FIELD_PREP(PCIE_SETTING_GEN_SUPPORT,
>  					  GENMASK(pcie->max_link_speed - 2, 0));
>  	}
> +	if (pcie->num_lanes) {
> +		val &= ~PCIE_SETTING_LINK_WIDTH;
> +
> +		/* Zero means one lane, each bit activates x2/x4/x8/x16 */
> +		if (pcie->num_lanes > 1)
> +			val |= FIELD_PREP(PCIE_SETTING_LINK_WIDTH,
> +					  GENMASK(pcie->num_lanes >> 1, 0));
> +	};
>  	writel_relaxed(val, pcie->base + PCIE_SETTING_REG);
>  
>  	/* Set Link Control 2 (LNKCTL2) speed restriction, if any */
> @@ -838,6 +849,7 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
>  	struct device *dev = pcie->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct resource *regs;
> +	u32 num_lanes;
>  
>  	regs = platform_get_resource_byname(pdev, IORESOURCE_MEM, "pcie-mac");
>  	if (!regs)
> @@ -883,6 +895,14 @@ static int mtk_pcie_parse_port(struct mtk_gen3_pcie *pcie)
>  		return pcie->num_clks;
>  	}
>  
> +	ret = of_property_read_u32(dev->of_node, "num-lanes", &num_lanes);
> +	if (ret == 0) {
> +		if (num_lanes == 0 || num_lanes > 16 || (num_lanes != 1 && num_lanes % 2))
> +			dev_warn(dev, "Invalid num-lanes, using controller defaults\n");
> +		else
> +			pcie->num_lanes = num_lanes;
> +	}
> +
>  	return 0;
>  }
>  
> -- 
> 2.46.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

