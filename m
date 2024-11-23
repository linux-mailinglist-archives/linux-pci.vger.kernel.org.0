Return-Path: <linux-pci+bounces-17234-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D2A69D684E
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 10:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E23711610D7
	for <lists+linux-pci@lfdr.de>; Sat, 23 Nov 2024 09:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 636A2132111;
	Sat, 23 Nov 2024 09:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zeIfEInD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A66257D
	for <linux-pci@vger.kernel.org>; Sat, 23 Nov 2024 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732353075; cv=none; b=DhtxaBn2Wol9hVyzcu4yJrq/xGw5AQ3aF8ybLoFhmfmoidw+01uLO7E9WAc5YWv0mWXgW7R+8StUPtYLyYy7lw65ktk6KjpO8Oi0VuhNphHi80LXmBNqZPKgAhG034Bp63RyGNC7Gn6kY6IJEJsBtolEjny3sq2tkZp6WwR8PLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732353075; c=relaxed/simple;
	bh=yVWC+NTwGEIK2g8k/Fx61C9vuvFQGIEubVnwE8WWha0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n1YvJ49ehI11NK2mQB0TOjoRKmdvsokvyDHX6Quin0d4JnXp01RHzfXuDjIePWr/GaWKmX5hv0MnciCBkfnFHNB2uGEAnY4RWPoUH1gPgxrCjDXo3dv9LCMJfkd/RSjTBuaAuEWqPL7DpmwgGlBSwLwdaRC5ZuBshgEbm3Dj8eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zeIfEInD; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f43259d220so2258550a12.3
        for <linux-pci@vger.kernel.org>; Sat, 23 Nov 2024 01:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1732353073; x=1732957873; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hth4LIFfFqiX8BxvmFXuMrsAdL3uE4QFJCpdQRVIJ/k=;
        b=zeIfEInDCLrFgAVTEUgfp84DbqR6xpNCmFxTYXx5QFnsYUUFENcSeIQnsJq0FAo+Gg
         MVpEe4WrRcgjQwFWjRCuF9S9CzHzjDl/9+Pf9md62kb8TOwrE4Cm4ot0Wrpn1bt+kwpy
         qtjJK6tZ1Dgy2BONC7252sZmxU2U03KnI7JA/+riYb+waHC0KyWyGmwNTLp30h4C8GKO
         WAK5lrr45zStuCAYq7VcC+DRG1D9D/qjdXi0JaQVDjqwhzf0M6MCCpPBbhcQLaTIA+yn
         Jr6IH1rFSffcByfCa8vhDW/mskSjE9LyXDbtYWcvpOniVjlw2ibIxUE58tHbAs0EXZRr
         3G/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732353073; x=1732957873;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hth4LIFfFqiX8BxvmFXuMrsAdL3uE4QFJCpdQRVIJ/k=;
        b=MDbCB+Hs8SkcZnX26dAckUv/Z0KVQbuFAR2CUUn4zSRFLE4pg5lopfQcmMKr3rLaoc
         c4/raMeSAUoNWz8nfCg8lstvx+b5W6W5kufhoOgKVj4DTd7ikwx5FwHBqzp21nV26W2k
         V/itkP09wxzCoCmgum90txCktDVumQ1SQc/jgmiN7bpIyMswQqZvFh5K15Y9CrbvYbO+
         Bn71TG4yvCzOhPkjA13/IbycJmLuIt+BwF5imlkkQf8522ZV7S+GgekcCG19QIw2lwsT
         hfmHrS1KLEiMHZzUeaaPqnNk/6A9S1LH7BrYN08e0DLDewq2WXUZqmrStlSv1cYcX9OH
         M0IQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbvEnOKiMg9ofUI61WvDo7xNtAiHXNGKC5ipSVpZQItM9+kzcORmHBnBmbygecaitYISFen/YFjTU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9XPy6v+/zn9wRS5XjvA1x7JGc9FH/es5W3DsUoGcmjjFxSDF/
	oQAxvhfjqSXutqlIcNBEVxArAiCMhcpaeZSqRPH3nmuD884R4wcE9XIQbtb+8A==
X-Gm-Gg: ASbGnct9PNqlE85S0PUNWH4sA7fupYAgOq/+2hDEf6TstFlM81eaiPTFBASRpIPa3ZN
	L/be0oTR6sKKR23Mv876QFADEzJ3D4kgVguUvI2gsaGH08Blyn30SEIbTRYN1iFmKF/VTIsf6W5
	ym+kLWu0oZryT7XZrHREreVWettQwBwqZnvfXejJ9iYZVDy6Y+G5APc+sXEmK4Ltl1rCH66JrDJ
	gRnzlK2Y2jeMAKwvjO6J9Md3EO2ytRfFCh53XuVG9/6Fa8ysmc7WNpf12firtRWPg==
X-Google-Smtp-Source: AGHT+IHSwQx5I6ydm2NN+J7aExyMX6mGiatTpiQcH3JLyc+Ei93oibZfVSEA6ImzJbB21LtSvMRsqw==
X-Received: by 2002:a05:6a20:a112:b0:1dc:32a:d409 with SMTP id adf61e73a8af0-1e09e5cba7dmr7832706637.39.1732353073302;
        Sat, 23 Nov 2024 01:11:13 -0800 (PST)
Received: from thinkpad ([2409:40f2:101e:13d7:85cf:a1c4:6490:6f75])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7fbcbdb796esm2566484a12.0.2024.11.23.01.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2024 01:11:12 -0800 (PST)
Date: Sat, 23 Nov 2024 14:41:06 +0530
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
Subject: Re: [PATCH v4 6/6] PCI: mediatek-gen3: rely on msleep() in
 mtk_pcie_en7581_power_up()
Message-ID: <20241123091106.bpkzqjafvxa5yief@thinkpad>
References: <20241118-pcie-en7581-fixes-v4-0-24bb61703ad7@kernel.org>
 <20241118-pcie-en7581-fixes-v4-6-24bb61703ad7@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241118-pcie-en7581-fixes-v4-6-24bb61703ad7@kernel.org>

On Mon, Nov 18, 2024 at 09:04:58AM +0100, Lorenzo Bianconi wrote:
> Since mtk_pcie_en7581_power_up() runs in non-atomic context, rely on
> msleep() routine instead of mdelay().
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/pcie-mediatek-gen3.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek-gen3.c b/drivers/pci/controller/pcie-mediatek-gen3.c
> index f47c0f2995d94ea99bf41146657bd90b87781a7c..69f3143783686e9ebcc7ce3dff1883fa6c80d0f4 100644
> --- a/drivers/pci/controller/pcie-mediatek-gen3.c
> +++ b/drivers/pci/controller/pcie-mediatek-gen3.c
> @@ -926,7 +926,7 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	 * Wait for the time needed to complete the bulk assert in
>  	 * mtk_pcie_setup for EN7581 SoC.
>  	 */
> -	mdelay(PCIE_EN7581_RESET_TIME_MS);
> +	msleep(PCIE_EN7581_RESET_TIME_MS);
>  
>  	/*
>  	 * Unlike the other MediaTek Gen3 controllers, the Airoha EN7581
> @@ -954,7 +954,7 @@ static int mtk_pcie_en7581_power_up(struct mtk_gen3_pcie *pcie)
>  	 * Wait for the time needed to complete the bulk de-assert above.
>  	 * This time is specific for EN7581 SoC.
>  	 */
> -	mdelay(PCIE_EN7581_RESET_TIME_MS);
> +	msleep(PCIE_EN7581_RESET_TIME_MS);
>  
>  	/* MAC power on and enable transaction layer clocks */
>  	reset_control_deassert(pcie->mac_reset);
> 
> -- 
> 2.47.0
> 

-- 
மணிவண்ணன் சதாசிவம்

