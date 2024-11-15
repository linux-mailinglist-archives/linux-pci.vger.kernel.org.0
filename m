Return-Path: <linux-pci+bounces-16845-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AC1B9CDB05
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5177528279C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 09:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A466F18990C;
	Fri, 15 Nov 2024 09:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SU3VXE4x"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1586D1898EA
	for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 09:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731661362; cv=none; b=VWNvdvIsyw5hnktxAxYjx1rb0lR9o2Fqs945gNvkbaXJh3tCbEQGu6lDts1btPRwVI+aq+QEULdOLfISlNRzpwbKO8Fdmvuf1fzuDuDFNDB85fv7Dyh/5a2yorwuLKkOHGyRVbNPoEDJBMc6jsTm2gTWyGQc/SKhgZu75BTA82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731661362; c=relaxed/simple;
	bh=/BeW2Q00SEiC/O3glMygna+Ml+VPkGExtfs3XHTVfhw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BcNbYuA0BJUi3DdOPToe8phIPy5IQh6UhyhGC9l2u8/WelFlDV0a8lHGuUfMg/nGiyuccesEqLwcXWAqrzSuMwrsew/1B2kQVx5qPRmlVWiOOuxAPXrlpGcM8piZIDf2zm+hM9D8F1UZlh/SQvTuAhBrbMlp2bOjr7gC8JrQsH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SU3VXE4x; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-20c714cd9c8so16768075ad.0
        for <linux-pci@vger.kernel.org>; Fri, 15 Nov 2024 01:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1731661360; x=1732266160; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JzLXt5Z4Yoq+cL5FZ5kUr3QUZKj6AqTjZlPMJ0a+Ueo=;
        b=SU3VXE4x1KIWxGDgVgwIgY4CqF3SssbJuN/ScOdDn6LUxFddWwGEfWCKFdpGKnQP+6
         BAzku4cEunomKdSMnQe6y/t059RfcKIYpAbfcPZxE/8xI7K6sm5q1HYdyQpUitnBiBvb
         IATB0kWaRDoBnV9aArfqm99ELXmlX/k0o90ZZCxJY4YIM3dDSNvbrX6MmT3G/DYeXyi/
         vMDuUgE+WWlwd6mcAqf9tpZUwkiVAjbowliLgBKoSQqODP+POkQ8LPtDGWqdrcFTiDNH
         lDNSNhokLkJkwn1YU+2M99lyI4kWGCrsVPJtlVlR0SaVJpbHQAoI9q8TKk7RjeivNV4+
         dpuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731661360; x=1732266160;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JzLXt5Z4Yoq+cL5FZ5kUr3QUZKj6AqTjZlPMJ0a+Ueo=;
        b=TXndwbW5Ni5bKt2o87S2yzF1/dML3Z3Ox6dcRf7VQa5cuzfpArUtovciPJhMfEZ7A4
         cIyTAIbkchmYQ0M0UkuRYr1Em2uy56HshvS7e8arER4b21TOBKiYxsV4OI8O2LBDICUj
         BcrjyXzcNHx8eV2Q1d12C+Lvg0Ay2FahdzSARbvXhDZKorWdKi+F2AmjllW2Ow5GYG6q
         69ceVYkVp+cn+wP6Nu1i3Q3q7obvI3NddP/anlNZN+e3ow7x+q1wHss6zJmnxVkTpIlU
         924g8Ul/BvtmzEL+OhF3RB/qcc0t2cClKEaa8JRNOrxtrd4zQf3zbSkacwVRhfiaTIAH
         /iIA==
X-Forwarded-Encrypted: i=1; AJvYcCVcCTOt/zkJA2l0dty+TsvRkAC7Q+XUTCPJBxIz+3IgFYDO/k5//+Ha/nWW/2/Zc5OS242fl3rlNJM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCVc50wQGjnkrl1VXYLghExR3X6Q/tN80RJ5a3wHMM/4qSk0ss
	cyJxIQQUEKxLkS8oPzSIOZlfTRqvrJ22hgQ5hmZoIqudLrQ9F38P+t6fII1bDQ==
X-Google-Smtp-Source: AGHT+IF6ewmiGHuNhETgOoZ9s9tHcZMJFEXL8UFTyjr3PsHYLNE6u0F19Zk/8GV3oZcloNjYIK264Q==
X-Received: by 2002:a17:902:c40a:b0:20c:aa41:9968 with SMTP id d9443c01a7336-211d0ed2e4dmr21401165ad.53.1731661360274;
        Fri, 15 Nov 2024 01:02:40 -0800 (PST)
Received: from thinkpad ([117.193.208.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211d0f47c04sm8089485ad.221.2024.11.15.01.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Nov 2024 01:02:39 -0800 (PST)
Date: Fri, 15 Nov 2024 14:32:31 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Ryder Lee <ryder.lee@mediatek.com>,
	Jianjun Wang <jianjun.wang@mediatek.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-pci@vger.kernel.org, linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/4] PCI: mediatek-gen3: Move reset/assert callbacks
 in .power_up()
Message-ID: <20241115090231.nwmxl6acspxqflpc@thinkpad>
References: <20241109-pcie-en7581-fixes-v2-0-0ea3a4af994f@kernel.org>
 <20241109-pcie-en7581-fixes-v2-3-0ea3a4af994f@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241109-pcie-en7581-fixes-v2-3-0ea3a4af994f@kernel.org>

On Sat, Nov 09, 2024 at 10:28:39AM +0100, Lorenzo Bianconi wrote:
> In order to make the code more readable, move phy and mac reset lines
> assert/de-assert configuration in .power_up() callback
> (mtk_pcie_en7581_power_up()/mtk_pcie_power_up()).
> 

I don't understand how moving the code (duplicting it also) makes the code more
readable. Could you please explain?

> Introduce PCIE_MTK_RESET_TIME_US macro for the time needed to
> complete PCIe reset on MediaTek controller.
> 
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 8c8c733a145634cdbfefd339f4a692f25a6e24de..1ad93d2407810ba873d9a16da96208b3cc0c3011 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -120,6 +120,9 @@
>  
>  #define MAX_NUM_PHY_RESETS		3
>  
> +/* Time in us needed to complete PCIe reset on MediaTek controller */

No need of this comment. Macro name itself is explanatory.

- Mani

> +#define PCIE_MTK_RESET_TIME_US		10
> +
>  /* Time in ms needed to complete PCIe reset on EN7581 SoC */
>  #define PCIE_EN7581_RESET_TIME_MS	100
>  
> @@ -867,6 +870,14 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	int err;
>  	u32 val;
>  
> +	/*
> +	 * The controller may have been left out of reset by the bootloader
> +	 * so make sure that we get a clean start by asserting resets here.
> +	 */
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> +				  pcie->phy_resets);
> +	reset_control_assert(pcie->mac_reset);
> +
>  	/*
>  	 * Wait for the time needed to complete the bulk assert in
>  	 * mtk_pcie_setup for EN7581 SoC.
> @@ -941,6 +952,15 @@ static int mtk_pcie_power_up(struct mtk_gen3_pcie *pcie)
>  	struct device *dev = pcie->dev;
>  	int err;
>  
> +	/*
> +	 * The controller may have been left out of reset by the bootloader
> +	 * so make sure that we get a clean start by asserting resets here.
> +	 */
> +	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets,
> +				  pcie->phy_resets);
> +	reset_control_assert(pcie->mac_reset);
> +	usleep_range(PCIE_MTK_RESET_TIME_US, 2 * PCIE_MTK_RESET_TIME_US);
> +
>  	/* PHY power on and enable pipe clock */
>  	err = reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
>  	if (err) {
> @@ -1013,14 +1033,6 @@ static int mtk_pcie_setup(struct mtk_gen3_pcie *pcie)
>  	 * counter since the bulk is shared.
>  	 */
>  	reset_control_bulk_deassert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
> -	/*
> -	 * The controller may have been left out of reset by the bootloader
> -	 * so make sure that we get a clean start by asserting resets here.
> -	 */
> -	reset_control_bulk_assert(pcie->soc->phy_resets.num_resets, pcie->phy_resets);
> -
> -	reset_control_assert(pcie->mac_reset);
> -	usleep_range(10, 20);
>  
>  	/* Don't touch the hardware registers before power up */
>  	err = pcie->soc->power_up(pcie);
> 
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

