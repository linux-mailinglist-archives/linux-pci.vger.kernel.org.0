Return-Path: <linux-pci+bounces-6733-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA1E8B456D
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 11:55:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 407E91F22178
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 09:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D04244C8D;
	Sat, 27 Apr 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pIswm4Uk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5D847F63
	for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714211696; cv=none; b=WB0AbL0cBP9ZWndL4wFcmxu9OlqPJuSmAgJwDpxePfR6zGbQZfc+2UVC/2vg+RA7nxMqo8Z+zQeXR+iQGX1hwuClM3K9R+8V8JejpD7cuNPXoacjmqK96RwC8lQ4ynIX9qZqm3wdTXDUcA6f+j0xUTLnDyuph66AidqWVNYdJlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714211696; c=relaxed/simple;
	bh=oAKyMTR8eWOSyqxbhlem5MYmleLa9lzfZXEEcetSXnM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hTdZEeicowhSkC7TcuMdb1VyqCtlU1MoMwwEhm87dzvs/r1YY7ZUlQCQ1FJ4nFrSIeVykThFxdPVf1i+EUE/uTkEJbRP3sNrzF0bH/0OVN7rjGnrKL4e8ttTAWQhEKJ4y1mmS2HrLFE+Pb630G3A/T2P5UZ/Q4SAjdHS1+jGRec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pIswm4Uk; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2a55a3d0b8eso2135728a91.1
        for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 02:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714211694; x=1714816494; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=q7IJCY5rJWmDi7bRkGY/6TU0zJug2sXYMpCIYdgYukw=;
        b=pIswm4Ukc6rmKVLWUGvJWHyPs98gMXeR90kSH0jvI5c08Cm1KVM2zhW3UxAdp4iCfQ
         +b2FnaURVHbMz31+axCsULCCL0jcxNCNw+87uDhRg7RVpt7jxXOL+Y2WFLFeTA4c1qA3
         OwYglePrkiu1zWLjygNp0qizeTbZK+L4gDJ2MABbywyFhS0HYuf8rsAVUZJcoweFmndF
         9lEvYkdEakkXuxAkoGM4Z2O0l7i1kKaIUKGPyKQoOaKnbW2a9ZUkBFbvb8QZk+ZS7FlI
         o08W688Sq/htJqz19qOOPCBTFPqtz57PGOo4ni2b/w0xI1xqGFJ9Gbi4M0k2O8vfkZpq
         9zjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714211694; x=1714816494;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q7IJCY5rJWmDi7bRkGY/6TU0zJug2sXYMpCIYdgYukw=;
        b=GSvb8IGawdM3/Funjj9ga2LFsIxt0Wl+u9UqZUoEIm/L7uHllMV0qyfR0h7oABwXeJ
         +FcN0ZkK/cZm5kl8REVa+PZ79YqMceqSuQY3Segue79Bqh7OxzalBLJqVaz2I/rvjlnw
         /ScckPl3Q7vd+vTtlMdwE7cyKLwzfkHdj2kk6H7zHo+hjnkPjuMKOAl7Hhtm2l/R+Oad
         NKGQySDnIB4Ck6mos2NhwfuIQY24M5DokBIambKb1k9hyJOx3nmedCwK766lqIzyC7vR
         Gdy6PMI4YA5H0A76WZaIhW0wT1Sqj4cr7n3uqHccti3B5wLENNBWvbE9EQRI/6k1Kx7v
         jlgA==
X-Forwarded-Encrypted: i=1; AJvYcCWjVG2Ct0mKr86a3loa584LERKL36/9ThCK3IRfDb6wT3nj480n1K68CE7Jp59h6EFzP3LQ32l7/gESIL97nhk/mbOi66aa2Sj0
X-Gm-Message-State: AOJu0YzYx/rhpfvgO7BmBTgrUul44mee/84tfYbAZAcxFEPYC/asdb5B
	4HKnarWOi81swpaCUh4GYs3SrWgS7M7alhmOyE1L6iBeqA5Y1l7YK1OOgA9TiQ==
X-Google-Smtp-Source: AGHT+IHbaVLmro9zr9PHmAJzQU4EgUaA+TXAd31urwcQTwZNnANEbssC6ijmrdtMi2g14n+SXgcytg==
X-Received: by 2002:a17:90b:246:b0:2aa:cadb:d290 with SMTP id fz6-20020a17090b024600b002aacadbd290mr7383922pjb.13.1714211694536;
        Sat, 27 Apr 2024 02:54:54 -0700 (PDT)
Received: from thinkpad ([117.213.97.210])
        by smtp.gmail.com with ESMTPSA id y10-20020a17090ad70a00b002a63e966fd7sm15753781pju.47.2024.04.27.02.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 02:54:54 -0700 (PDT)
Date: Sat, 27 Apr 2024 15:24:44 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Frank Li <Frank.Li@nxp.com>
Cc: Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 06/11] PCI: imx: Simplify switch-case logic by involve
 set_ref_clk callback
Message-ID: <20240427095444.GK1981@thinkpad>
References: <20240402-pci2_upstream-v3-0-803414bdb430@nxp.com>
 <20240402-pci2_upstream-v3-6-803414bdb430@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240402-pci2_upstream-v3-6-803414bdb430@nxp.com>

On Tue, Apr 02, 2024 at 10:33:42AM -0400, Frank Li wrote:

PCI: imx6: Introduce SoC specific callbacks for controlling REFCLK

> Instead of using the switch case statement to enable/disable the reference
> clock handled by this driver itself, let's introduce a new callback
> set_ref_clk() and define it for platforms that require it. This simplifies
> the code.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pcie-imx.c | 119 ++++++++++++++++------------------
>  1 file changed, 55 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-imx.c b/drivers/pci/controller/dwc/pcie-imx.c
> index e93070d60df52..77dae5c3f7057 100644
> --- a/drivers/pci/controller/dwc/pcie-imx.c
> +++ b/drivers/pci/controller/dwc/pcie-imx.c
> @@ -103,6 +103,7 @@ struct imx_pcie_drvdata {
>  	const u32 mode_mask[IMX_PCIE_MAX_INSTANCES];
>  	const struct pci_epc_features *epc_features;
>  	int (*init_phy)(struct imx_pcie *pcie);
> +	int (*set_ref_clk)(struct imx_pcie *pcie, bool enable);
>  };
>  
>  struct imx_pcie {
> @@ -585,77 +586,54 @@ static int imx_pcie_attach_pd(struct device *dev)
>  	return 0;
>  }
>  
> -static int imx_pcie_enable_ref_clk(struct imx_pcie *imx_pcie)
> +static int imx6sx_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	unsigned int offset;
> -	int ret = 0;
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX6SX_GPR12_PCIE_TEST_POWERDOWN,
> +			   enable ? 0 : IMX6SX_GPR12_PCIE_TEST_POWERDOWN);
>  
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX6SX:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
> -		break;
> -	case IMX6QP:
> -	case IMX6Q:
> +	return 0;
> +}
> +
> +static int imx6q_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +{
> +	if (enable) {
>  		/* power up core phy and enable ref clock */
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_TEST_PD, 0 << 18);
> +		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1, IMX6Q_GPR1_PCIE_TEST_PD, 0);
>  		/*
> -		 * the async reset input need ref clock to sync internally,
> -		 * when the ref clock comes after reset, internal synced
> -		 * reset time is too short, cannot meet the requirement.
> -		 * add one ~10us delay here.
> +		 * the async reset input need ref clock to sync internally, when the ref clock comes
> +		 * after reset, internal synced reset time is too short, cannot meet the
> +		 * requirement.add one ~10us delay here.

Please wrap the comments to 80 column width.

>  		 */
>  		usleep_range(10, 100);
>  		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 1 << 16);
> -		break;
> -	case IMX7D:
> -	case IMX95:
> -	case IMX95_EP:
> -		break;
> -	case IMX8MM:
> -	case IMX8MM_EP:
> -	case IMX8MQ:
> -	case IMX8MQ_EP:
> -	case IMX8MP:
> -	case IMX8MP_EP:
> -		offset = imx_pcie_grp_offset(imx_pcie);
> -		/*
> -		 * Set the over ride low and enabled
> -		 * make sure that REF_CLK is turned on.
> -		 */
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> -				   0);
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, offset,
> -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> -				   IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN);
> -		break;
> +				   IMX6Q_GPR1_PCIE_REF_CLK_EN, IMX6Q_GPR1_PCIE_REF_CLK_EN);
> +	} else {
> +		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
> +		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> +				   IMX6Q_GPR1_PCIE_TEST_PD, IMX6Q_GPR1_PCIE_TEST_PD);
>  	}
>  
> -	return ret;
> +	return 0;
>  }
>  
> -static void imx_pcie_disable_ref_clk(struct imx_pcie *imx_pcie)
> +static int imx8mm_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
>  {
> -	switch (imx_pcie->drvdata->variant) {
> -	case IMX6QP:
> -	case IMX6Q:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR1,
> -				IMX6Q_GPR1_PCIE_TEST_PD,
> -				IMX6Q_GPR1_PCIE_TEST_PD);
> -		break;
> -	case IMX7D:
> -		regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> -				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> -		break;
> -	default:
> -		break;
> -	}
> +	int offset = imx_pcie_grp_offset(imx_pcie);
> +
> +	/* Set the over ride low and enabled make sure that REF_CLK is turned on.*/
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE,
> +			   enable ? 0 : IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE);
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, offset, IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN,
> +			   enable ? IMX8MQ_GPR_PCIE_CLK_REQ_OVERRIDE_EN :  0);

Extra space after :

> +	return 0;
> +}
> +
> +static int imx7d_pcie_set_ref_clk(struct imx_pcie *imx_pcie, bool enable)
> +{
> +	regmap_update_bits(imx_pcie->iomuxc_gpr, IOMUXC_GPR12, IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
> +			    enable ? 0 : IMX7D_GPR12_PCIE_PHY_REFCLK_SEL);
> +	return 0;
>  }
>  
>  static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
> @@ -668,10 +646,12 @@ static int imx_pcie_clk_enable(struct imx_pcie *imx_pcie)
>  	if (ret)
>  		return ret;
>  
> -	ret = imx_pcie_enable_ref_clk(imx_pcie);
> -	if (ret) {
> -		dev_err(dev, "unable to enable pcie ref clock\n");
> -		goto err_ref_clk;
> +	if (imx_pcie->drvdata->set_ref_clk) {
> +		ret = imx_pcie->drvdata->set_ref_clk(imx_pcie, true);
> +		if (ret) {
> +			dev_err(dev, "unable to enable pcie ref clock\n");

'Failed to enable PCIe REFCLK'

- Mani

-- 
மணிவண்ணன் சதாசிவம்

