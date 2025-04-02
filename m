Return-Path: <linux-pci+bounces-25116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFD4A788AE
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:12:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E30013AE4B9
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF56D23370F;
	Wed,  2 Apr 2025 07:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tn8lGSVL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22828233705
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 07:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577831; cv=none; b=hpV8Nr+OP5JSaPSQJHn9cZ+LlcRO7I9+eSlzZMj8wTWgPCkxL8/M3kFwSW9Z1cf52iVyNIp9suB25KcKUz2uLWPzA3OtWLY/9A/HZsouga9Ro/I9oZeguKdu+lQbsjxwrM/r3ltGZ17QWm4M/2cU/EKb5qvmZjWenpfSK/kN0dM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577831; c=relaxed/simple;
	bh=7ZFduh289kmIv14Cb97BOB2D+kLl6uOqn1YtVHrX7Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e3G2E2mc/cjzf9Ysb6qPQ6WbHIKBOGjKJnVEzZI611fJ28QZwlwMpRQHPKVYa6ci+0vJzw9QEwmc1gosOZ7KQoMDRi/BpAFRuU+ae4afVq7iPlG00JOtH4mc9wTLbSSYE+NKHjAWzI2+GsUxL0Krg/hy2NQsx5MmgwzKn8ZmXrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tn8lGSVL; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-227914acd20so8308095ad.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 00:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743577829; x=1744182629; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zjR4lEGGyx3HdyMesa5h6gRayUig9bsMGHv5vZfbr1E=;
        b=tn8lGSVL4WYbU3w3ReJGEyvTyydMot802P0TAJn9vNj0cuYFB833AwYC+c9hzrg94r
         JWraFj6jqe8mJDL9vxFWDcinGfBnLujxmuckPLeIpROAEz/QmrgXD0//+S/+XGuaCv3E
         vxpJIfYY030MB5MEhjmp+kUpKl1WOsYyAgjk1iIDj6pQBfZSzxaFHP0CTG35NUXCefe3
         DJk8iW8h870ag1f/VtWahxyAj1i2H684OuGlVTdy8YWWEYMZpsYy7Ons91HP9+z8vjgF
         3pUIJFaZpLisWnFj036n08axuVwCnxRWyfhTeUPCiFd9eTirYHT3d6FZdbVfkLEVkULW
         2yJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743577829; x=1744182629;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zjR4lEGGyx3HdyMesa5h6gRayUig9bsMGHv5vZfbr1E=;
        b=ZbDPC5zvdNBfNqr7gwunOHZzS7KnoD6w6YXQnCgp48zhJyGaW3ZEKKdXRY4GggNmi5
         GEyxurmrP9WoVaogg3UO4lbIGwtPImPTXt4ksC42tIT/w629Z2rkXxyHVGdiM4RYkR6N
         p3g2aqC3BlRLPWczGHk1KgNIZ94/7mSu3TKkhiWUZD1lRNHnaBms8A91MjeuijvZMNnG
         vT/4M2wKaGCYyjWxtZLhr/JpfKctbo9JeC/HTJtzy4BhD/GcNf+OrrECvxx/ZxeY+SRD
         SRZ8bjTB1nI1xaxxheUO8AGO8tSmuVEdPmDPhR2HZT1N1uf07LgMlbCzc7u+snN/cb+2
         2gOA==
X-Forwarded-Encrypted: i=1; AJvYcCV9f54qO9vGYcxw4V52lGvmKR+/QldA43suevWr05tXlRXt3zak3uEYB3OLXBvyUY2H1o5CI0EvupI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4hg3oUt5WVBU3EzJHiMg6NtSaJ/aTjYUYQCFWmcjPiaTeisbb
	4SyPK5KRJrE50FJr1Uy+N7suuRjXvCXMM7k7CbsbAw+c698zcYW/G104lzA5ew==
X-Gm-Gg: ASbGncvGQ9f1et3Kfq3nuYoVz8dVBKFXcGW7mk+uGYRIwUUxDvMDGNk3pbeqAl67ujX
	OTDPDOfE37u6hRibWR7mebCwx8ul5F53q59U5IErzsU3romrriSA3CbpYcsLe/0b9hO2Lz8NcTC
	a+oTkV2OF2oHElgFbBKkiezlH9jeoAeOcEsGS+FTsXzG6ckD3U0p+xLIrj8h8kikPBkQllf1yUw
	8rDZ3VpdUVl1G9xaVWZeOaCUOlF9kIgMhgmjjIrgXl9oa2L6bprqjzRJUrJap5chscNsYI/+NtD
	Pc7qMLl4b2FEcodZgPJKDGulCoujY2SwsY1P5CL4TzLFdHKbq+zoR7U/
X-Google-Smtp-Source: AGHT+IF2PkfJ6gvdatC+Ohrdk2DCIs4bJ4gvM262TiahqchaDp4ihwwIJoGbKxCJkUgJQO2cM8XLTw==
X-Received: by 2002:a05:6a00:130d:b0:737:cd8:2484 with SMTP id d2e1a72fcca58-739cac57712mr1314725b3a.6.1743577829272;
        Wed, 02 Apr 2025 00:10:29 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-739710cbd88sm10117652b3a.157.2025.04.02.00.10.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:10:28 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:40:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 5/6] PCI: imx6: Add PLL clock lock check for i.MX95
 PCIe
Message-ID: <y3ys5ojt3cryklqibg4shznkjqije7bturs5ljkjyzbri5dhgu@jeo2mmyv7sci>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-6-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328030213.1650990-6-hongxing.zhu@nxp.com>

On Fri, Mar 28, 2025 at 11:02:12AM +0800, Richard Zhu wrote:
> Add PLL clock lock check for i.MX95 PCIe.
> 

What are the implications of not waiting for PLL lock? I guess clock
instability.

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 28 +++++++++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 35194b543551..40eeb02ffb5d 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -45,6 +45,9 @@
>  #define IMX95_PCIE_PHY_GEN_CTRL			0x0
>  #define IMX95_PCIE_REF_USE_PAD			BIT(17)
>  
> +#define IMX95_PCIE_PHY_MPLLA_CTRL		0x10
> +#define IMX95_PCIE_PHY_MPLL_STATE		BIT(30)
> +
>  #define IMX95_PCIE_SS_RW_REG_0			0xf0
>  #define IMX95_PCIE_REF_CLKEN			BIT(23)
>  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> @@ -479,6 +482,23 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
>  		dev_err(dev, "PCIe PLL lock timeout\n");
>  }
>  
> +static int imx95_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
> +{
> +	u32 val;
> +	struct device *dev = imx_pcie->pci->dev;
> +
> +	if (regmap_read_poll_timeout(imx_pcie->iomuxc_gpr,
> +				     IMX95_PCIE_PHY_MPLLA_CTRL, val,
> +				     val & IMX95_PCIE_PHY_MPLL_STATE,
> +				     PHY_PLL_LOCK_WAIT_USLEEP_MAX,
> +				     PHY_PLL_LOCK_WAIT_TIMEOUT)) {
> +		dev_err(dev, "PCIe PLL lock timeout\n");
> +		return -ENODEV;

-ETIMEDOUT

- Mani

-- 
மணிவண்ணன் சதாசிவம்

