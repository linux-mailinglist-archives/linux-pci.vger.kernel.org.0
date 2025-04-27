Return-Path: <linux-pci+bounces-26860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BAEFCA9E2AB
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 13:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D55C4189F321
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 348FA244689;
	Sun, 27 Apr 2025 11:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CF7jWAeL"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9523523FC41
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 11:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745752816; cv=none; b=KtJa++r8UWuvdZAje6MTHBFKNcWAlN+I47E9eyZ9Js1ZFllu5/n61a4PK3ojUXUiWIRx4994naJRV1usV5+WNz9SgJtjUk/w/Bi0WP6nZ+GrpVs/PlwIGkJjL/LB80sq93hHoelGZN9w9f6xELIV0KoSib4k6zWLibJzTpdtNJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745752816; c=relaxed/simple;
	bh=l+r6gW/k4AiLNiqCdXWLcYbQjOS4aPFNelQN+qJ9t9E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P6OrLpaGamQmBDifkfVu6N2J6HDzMoOk35peiBWfLw+/gTRTPiUXC5J963qrZ0peOTNSvVxywhHfiOlRdDBP3VBcOt+9bVYvLJTbMA1+FIqMU7w3+q/967I2aGgcjAdOb3tiOHG1I6HjTXZHbN+sW060mMQiKPlJaEGYfIdzK6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CF7jWAeL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-739b3fe7ce8so3482277b3a.0
        for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 04:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745752814; x=1746357614; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U8PIzBYTDnuUJNOzFhZUf8k7SMLmkkalf0cCtjYXloU=;
        b=CF7jWAeLWUh32TNDoevWzHxzVVh+lNUIB8fAYFsWN/Jx2rBQ41vT7WItxvaVhEkNZJ
         pqqbd8jLK90FASYgCmT0ZqyGJ4OGBYdOLap0YT/rrqf7LvJlxq4B6KD0pBWk6WkTGxge
         9r+QCSSH3LaotXG9QpLTTezerqJQbQMI4sQHyd9rZ1LHd+1XYzGlhIX1TiFnQiI/oL/c
         EnlNmGOVYDWkXCNcZ+U7tmp/bhQ55Sk7CJX44WW2m2wCGli3ozQI1xpZ+NGNbiH5LCtJ
         ZtcPchEBo+bs/83qHteyoXWMWltU89bPKKKu4g+Jl7zL3G2jHRFhxBWn5IdFhHsz5HeI
         gzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745752814; x=1746357614;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U8PIzBYTDnuUJNOzFhZUf8k7SMLmkkalf0cCtjYXloU=;
        b=wBVVpCZ6pJNoly2wql//Er5Iogb71xOENEwbKQEqKuWbdpHu8BtidAsvJAgsYcKMnR
         Zwl9vBSNVlxyd35gmInyXpyEyU4iTnDU2RLwjImvTejhEc23rbeDqSqDExmrxEMrT1LK
         6qgIjR5ImXmt/PF6c1Jju3dQrYoRyEQH8wykb9ArWgWe9HOHbcpmfsxvbFQibDRh49dK
         dC5q68T0NgH+fHENSAtd7UCDlmNLVzrgpo7TVQBSufhnvxnMktdfM3fIYSSake5EATXc
         tCFmH2+jVDpvcL5k8lS55ZxlXxqcY9Bc+oDhyS7/Rf6vb5sFHU3kqA6gT9r1m9iKDQKw
         V9Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVHAJ79yTR4lvHmn2vmnMB9PvPMNVvY37zETeQhJREQSCPPsdGaWBiHrYmU62QLX61bvc1Jxjlx8sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgacjOFGEWdtna2CAJR9s2L10wZ1YXSI1mBdI1Ubr7e7Qrkbib
	+hGf69Vb3ZRdMtQ4NhZQNdoumDjafU48MJJO+uuFNAdXMZ3MpnXu3zVtr+CeQg==
X-Gm-Gg: ASbGncschZ1Oqi2NJr6oDM2jJTQxfnnXnE654Z9Xwyy2Sj4kPLuxbqKR7Y6hmeaCv3P
	6UTuAahOb2PowNrhnAB1rbzaWMD/iKCcPm3jABNXaUvbVxFWeQ/0nYHv3TnNKOW1cWGdiYBWZZY
	BBO/2wPm88XA2La2oywpucrBSI7tFAMj4B0uMFfO9cHmZ8qt2Q/rx3IWGuqvndcbd80pxhlHZUu
	v0dnoBWu6/vCInvsK6HpSZa4PvN/B9DM/kp4bKra2NhNSwB3f8atQFuexUaoIfoiVPQtqZSC/jA
	5n7gdc4qCdX+gSrY3B+876pRMLcdQx9L9d5suxnOpL6tOOA/OV2Z
X-Google-Smtp-Source: AGHT+IFv79IfZh1GxCFHYniWlVSDWEu/6IbqRbKPw+om4ozt3ytyq0VaNeh7LhP4FfVYP6Dn5aHP7g==
X-Received: by 2002:a05:6a00:2da6:b0:73c:3060:d53 with SMTP id d2e1a72fcca58-73fd8b6bc26mr10692158b3a.18.1745752813817;
        Sun, 27 Apr 2025 04:20:13 -0700 (PDT)
Received: from thinkpad ([120.60.143.241])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a6a17csm6054959b3a.111.2025.04.27.04.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Apr 2025 04:20:13 -0700 (PDT)
Date: Sun, 27 Apr 2025 16:50:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v6 6/7] PCI: imx6: Add PLL clock lock check for
 i.MX95 PCIe
Message-ID: <fnaivdfzjrzcivpegdozhp5i4cjqehze5smp23xiwktce7x4a2@2ryfqsuyvfec>
References: <20250416081314.3929794-1-hongxing.zhu@nxp.com>
 <20250416081314.3929794-7-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250416081314.3929794-7-hongxing.zhu@nxp.com>

On Wed, Apr 16, 2025 at 04:13:13PM +0800, Richard Zhu wrote:
> Add PLL clock lock check for i.MX95 PCIe.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

One comment below. But I'll fix it up while applying.

> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 29 +++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 7dcc9d88740d..4cff66794990 100644
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
> @@ -132,6 +135,7 @@ struct imx_pcie_drvdata {
>  	int (*init_phy)(struct imx_pcie *pcie);
>  	int (*enable_ref_clk)(struct imx_pcie *pcie, bool enable);
>  	int (*core_reset)(struct imx_pcie *pcie, bool assert);
> +	int (*wait_pll_lock)(struct imx_pcie *pcie);
>  	const struct dw_pcie_host_ops *ops;
>  };
>  
> @@ -479,6 +483,23 @@ static void imx7d_pcie_wait_for_phy_pll_lock(struct imx_pcie *imx_pcie)
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
> +		return -ETIMEDOUT;
> +	}
> +
> +	return 0;
> +}
> +
>  static int imx_setup_phy_mpll(struct imx_pcie *imx_pcie)
>  {
>  	unsigned long phy_rate = 0;
> @@ -1225,6 +1246,12 @@ static int imx_pcie_host_init(struct dw_pcie_rp *pp)
>  		goto err_phy_off;
>  	}
>  
> +	if (imx_pcie->drvdata->wait_pll_lock) {
> +		ret = imx_pcie->drvdata->wait_pll_lock(imx_pcie);
> +		if (ret < 0)
> +			goto err_phy_off;

You should also assert core reset in the error path.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

