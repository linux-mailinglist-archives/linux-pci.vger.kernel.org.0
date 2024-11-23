Return-Path: <linux-pci+bounces-17231-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728D89D6849
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 10:06:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE506161241
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 09:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6CB17C9F1;
	Sat, 23 Nov 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FNAJ981c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA44E172BB9
	for <linux-pci@vger.kernel.org>; Sat, 23 Nov 2024 09:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732352761; cv=none; b=ISzvrwHkn7AQO12mNn/RLcrDbHE43KA9kQdha5u9qn8FTdnIhSkfJRel9UszcsuY8vstZFPokPcn1l/n4HI5ahxzX6Pe0v/q+Ug10DpPrp7xHKZoEiaiPUBqujwMXAUosCXAtKWAFIm/yiJpEqCpmdKPXuGgbwHI49cshNCNjeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732352761; c=relaxed/simple;
	bh=Dca5lQQZBUuYnZig9XxYqsF1j66VHHMxoeFJ12Du3jU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ebe/auDl8feXAw3VF1F5GchBmP/CB3oadwPGTDGBqRkNzLBU16cTNcf3ymYMsvyMoXNGj9AORAgFSlAAt3WMPTsYtSlFMWHu42cjwIVCWAG1dwVgdFUPTtLV0Q01NGuCfuUctJcKNciIp39YSPO4dWbZoFbdSjGreKC+PLVjDyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FNAJ981c; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7246c8c9b1cso2397504b3a.3
        for <linux-pci@vger.kernel.org>; Sat, 23 Nov 2024 01:05:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732352759; x=1732957559; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=xZiVNGou0sUPR+VUZtEVpUsLh0jpbMmext51WC1uOek=;
        b=FNAJ981cPe5tnAAV6pv/2mxEsw61y+jFgByg064fT1NZqYLclaehCqF9Kr75HiJde4
         dGG8EnDHyGqG69nFZgRosgL9Li85G54mzyKogPY5BEFxDF9dZnFI3q8+N6O7IUbL/r0e
         /zAgMdhcAWgHEFzLX+nmoMlR8hCi9689OCW9a1w2ysjZJHjO2clBl0OZz8lbEqDiwhGx
         dJjVojiBs0Cdl2zgtFA5rR6y3BqQHX0KefVPkXJKMrOAnxqjjTZt9EZoY3Vilo6UcQ+D
         ql75GSbn9GLjDE1FxsbUktTzM4WtO9boCSopO1l9deRAC6H9FqJEHNUjP3WYcuawZZn6
         rr2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732352759; x=1732957559;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xZiVNGou0sUPR+VUZtEVpUsLh0jpbMmext51WC1uOek=;
        b=u8hEKutQNdgS3iG8UtBbwwU8+W+6/MvsklwiQcJ7qGvzf3vjz1F7513Jwf3A7F4UKP
         8n2OGQkGkiy0DY+KXIM4jGyJ9+26evrjHjx6mcL3z8ZXSLpzrf/22KCrHXTC3kEOdoNd
         rYLlLHC79EQzlit/6sRq8JNGnZWxn8Il+NFrJkfVNh7peqn7dGvUFn8t0xrZObFQTK/m
         4Suts7Vyjuemgd0XzzoNS3v39W6mGa1uXtwWDxooXYfkG4d63o2lpmGlRAwHbtEEe3LZ
         DBERqxvkKw8zcsMWt0qzZRkkokSH5bcYfssw86kj1sZfi5zzjresZei6dMJlsCwE5dOi
         60zQ==
X-Forwarded-Encrypted: i=1; AJvYcCWO0PgebTGzETkAPGIg//hcLzQIiELe2zHZlqAqu7aQwfGTt6812nIzN024ARJzX7NUxw33NDfCOOw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLicn7HqOir6lXCuc78kqViPok11/gGX3K0ybEQbqgG1W9nC6K
	UMnW5zA/2tEe2no20lUpph6KOxlGs7mj3xxBYlCaa9/zZWyESiKjx8qh9GgrnQ==
X-Gm-Gg: ASbGncvUORzQupWknmXZmWbh8KY42CqweQCt7ph2RXEpo+A20lb805m87P6V6p24tcH
	4XnLoGro6neFMlgc4ySvqA+I3nnxyd0AAXGgnz31HNEKTHObemJql/IwrIX43TxFMEAgThkEPG3
	hC8NNaQ5PQtCGEs8w43W5niEl7tmQatPB9StfT+w8d9fTlEqgGMSQbn8LhcrCctbFjHZhX+sKHc
	JluMNyAqiAtDKRPPkXbtsLA4a4hZ0SmsdR/c4/oadfXIzzHcJUE9+l51+6nn5Nicw==
X-Google-Smtp-Source: AGHT+IGmEszMNhZtwje0Xvl4SgF09bMp9/3Vg2UfRxuTgmP2VK0VjGMW/4vV+mCtT1R8tU+WzR0uag==
X-Received: by 2002:a05:6a00:244e:b0:724:591e:ea20 with SMTP id d2e1a72fcca58-724df66d881mr7872246b3a.14.1732352758798;
        Sat, 23 Nov 2024 01:05:58 -0800 (PST)
Received: from thinkpad ([2409:40f2:101e:13d7:85cf:a1c4:6490:6f75])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724de532db3sm2877085b3a.93.2024.11.23.01.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 01:05:58 -0800 (PST)
Date: Sat, 23 Nov 2024 14:35:49 +0530
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
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-pci@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v4 2/6] PCI: mediatek-gen3: rely on
 clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up()
Message-ID: <20241123090549.epzrv5o2i5q2mgz7@thinkpad>
References: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org>
 <20241118-pcie-en7581-fixes-v4-2-24bb61703ad7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118-pcie-en7581-fixes-v4-2-24bb61703ad7@kernel.org>

On Mon, Nov 18, 2024 at 09:04:54AM +0100, Lorenzo Bianconi wrote:
> Replace clk_bulk_prepare() and clk_bulk_enable() with
> clk_bulk_prepare_enable() in mtk_pcie_en7581_power_up() routine.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 14 +++-----------
>  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index 4d1c797a32c236faf79428eb8a83708e9c4f21d8..3cfcb45d31508142d28d338ff213f70de9b4e608 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -948,12 +948,6 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	pm_runtime_enable(dev);
>  	pm_runtime_get_sync(dev);
>  
> -	err = clk_bulk_prepare(pcie->num_clks, pcie->clks);
> -	if (err) {
> -		dev_err(dev, "failed to prepare clock\n");
> -		goto err_clk_prepare;
> -	}
> -
>  	val = FIELD_PREP(PCIE_VAL_LN0_DOWNSTREAM, 0x47) |
>  	      FIELD_PREP(PCIE_VAL_LN1_DOWNSTREAM, 0x47) |
>  	      FIELD_PREP(PCIE_VAL_LN0_UPSTREAM, 0x41) |
> @@ -966,17 +960,15 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	      FIELD_PREP(PCIE_K_FINETUNE_MAX, 0xf);
>  	writel_relaxed(val, pcie->base + PCIE_PIPE4_PIE8_REG);
>  
> -	err = clk_bulk_enable(pcie->num_clks, pcie->clks);
> +	err = clk_bulk_prepare_enable(pcie->num_clks, pcie->clks);
>  	if (err) {
>  		dev_err(dev, "failed to prepare clock\n");
> -		goto err_clk_enable;
> +		goto err_clk_prepare_enable;
>  	}
>  
>  	return 0;
>  
> -err_clk_enable:
> -	clk_bulk_unprepare(pcie->num_clks, pcie->clks);
> -err_clk_prepare:
> +err_clk_prepare_enable:
>  	pm_runtime_put_sync(dev);
>  	pm_runtime_disable(dev);
>  	reset_control_assert(pcie->mac_reset);
> 
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

