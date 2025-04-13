Return-Path: <linux-pci+bounces-25730-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D89E5A8725F
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 17:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 87AAD3B1F79
	for <lists+linux-pci@lfdr.de>; Sun, 13 Apr 2025 15:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0711A9B3D;
	Sun, 13 Apr 2025 15:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ynvxjdVb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 889F51BE871
	for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 15:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744558215; cv=none; b=YQcsWUw78xFRiEU/KvVRdq/Rn+Pvc7AVtW/hoBbqMc7WHC1N6YZHQjR1wss3X2cU+zET817uL0ba4fSbPa4wbJyvjhJG+7uxMsuVcnjdYVHpZ45rsDotNVpnU1KdHhoxfTLD3JxuiAMVCsJGWSyAGCZGXy+7CUoy/U6lAtYkCDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744558215; c=relaxed/simple;
	bh=O26QBjaeH/GBehwhCpe0jia62s2T5H1sKW+zOlJypxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eB5whIU9I0OgwnCp/cGcSF5tZXSZCkxIgIhbVXfCncT18bbBLLKyxXqvmLUqWAiaebz96t2O822Q4ov1L6tdf1+XmNAkEO/vNTkI0TPmzuUxwUVAiPjGF8tgB5hz30nPGWuzOdw7JdIMudTE+YuFwE8e194QNz0gc3O0SLKJsZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ynvxjdVb; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-736c1cf75e4so2450161b3a.2
        for <linux-pci@vger.kernel.org>; Sun, 13 Apr 2025 08:30:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1744558213; x=1745163013; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6YhpCUvtZQDpUlxDrFB7Y09wNEJFGtbdxnkmsZK4E90=;
        b=ynvxjdVbh5MiGblmAX+b5DJRB1ynwVswH4sE4mGfhJvnxYlx5xk1f1A3zmLplD7dgr
         buT7ztebvmK7Y2DoBRxyOaRfrrOXGghZACFSc0CmxsG7l2Pxkj8YeJYi5NwxnyYaQXaT
         BogT1alXGouVpaXUUOENJTRtTDy2d6LjUqEBG+GlIdMr8ZJLvKXQC/rXrJOUoSEMh3fp
         BETh6zyz8/eIiIxAx/UdBsVMTLJezct7Yt362XVQw7IWTIEhB4Rf5Lxkw096B6Q5xAWL
         eIZofxqIh43QpUu4QA1EfxG22rY1kE0yf5YgmZLZbPl1TNl1xXJhRpUt51wxCOFfN1ON
         DxjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744558213; x=1745163013;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6YhpCUvtZQDpUlxDrFB7Y09wNEJFGtbdxnkmsZK4E90=;
        b=cUesBBKO3ziBSqCWMmZiUtrR5GDkNg6kVeWnj7w3m+pIAy5+usXHSMcciGWri/nwfN
         7rJgkFUjlPDxPxA4crHLzcQD2+WYdRuFqsOnQAkE3zYqwzGtyqUSxUuBMnICqrnT304d
         aRYdS+RyFPJ2lBXekHFjkEUGjDLn0UjEX25uFen7tBbnp3iYC1a0uHSq/YRJLxYgoce5
         eEj8WHzXDT3IfxSDulasd5FmvPgnhz57ZR88MOSf1twBioZp3Der+X3DGvMMIxZejVMH
         G9QeV5RxbWCmonKljLg3BjvdrfXol0xdkYNeiVO+OQtfKM8GOn0NovSntvbaHbwsYjr1
         Un0A==
X-Forwarded-Encrypted: i=1; AJvYcCUDJoAZdW2+6dj0w5pBNr7kH0NiujM3yJn91gUcZFVcWL3fH4fzsFdsabWAHxrUAd8GcA0m5gYD5lw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf+WzvqOUD2vHQxjFc1UgZOwAMppwSa3Ip3Nn7eDypQA1zWJTi
	Gk/cQr5GAWbD+RUtgZv1gI6uTO27DvhFPKPSpvI+TG2vZNYuEomvptAj+NrcMw==
X-Gm-Gg: ASbGncsX4VpF2XX728yZQVd1p31BlC7BS0PRzZxJkvGkmCAb0m9xVwlbepudckjJDv5
	moXvft2yDIQG9rC/iZcScnayY2RoKdmmmzuvooihdxKSjiwSYH2TNw6dVCKronhtuOG88SBw87d
	JinCv8xH7AWEfcZYxZAVCYk+Jc0WvqGQ0Nd0TxaDu8DHz6C/RptMS86jSxb6OCReqURMaxRAo2D
	/sh9sB7n8814VeLJ14JCaa0vG/QIx5/bvolFv/BkN1PUHDCSDCVlYTURksPScexMNYfFkgatmJx
	ZJ/klsHmIvqPurn9qdLFIvfAcvqlChrlfQzeE3HDlKj16a1637la
X-Google-Smtp-Source: AGHT+IE0jyYBaLWROxwZRfj9Ap/rRwqRq+YqVPUJFP4QfIr9YmzNv06dYU+2Uj5cgUZODs640X4qrw==
X-Received: by 2002:a05:6a00:240b:b0:736:a694:1a0c with SMTP id d2e1a72fcca58-73bd12bef8dmr12879327b3a.21.1744558212599;
        Sun, 13 Apr 2025 08:30:12 -0700 (PDT)
Received: from thinkpad ([120.60.137.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd219bf3dsm5245218b3a.16.2025.04.13.08.30.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Apr 2025 08:30:12 -0700 (PDT)
Date: Sun, 13 Apr 2025 21:00:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 4/7] PCI: imx6: Workaround i.MX95 PCIe may not exit
 L23 ready
Message-ID: <xajelvlhvoxyt53qdx7dmi4wgp5yvc2hpk5bqbftwklp4ecrhj@gtv3mhb2pyvi>
References: <20250408025930.1863551-1-hongxing.zhu@nxp.com>
 <20250408025930.1863551-5-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250408025930.1863551-5-hongxing.zhu@nxp.com>

On Tue, Apr 08, 2025 at 10:59:27AM +0800, Richard Zhu wrote:
> ERR051624: The Controller Without Vaux Cannot Exit L23 Ready Through Beacon
> or PERST# De-assertion
> 
> When the auxiliary power is not available, the controller cannot exit from
> L23 Ready with beacon or PERST# de-assertion when main power is not
> removed.
> 
> Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
> 

Please do not post next version without concluding the review comments. It just
wastes reviewers time and is not a good practice.

You haven't resolved my comments on v3. So I'm not going to review this one.

- Mani

> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
> Reviewed-by: Frank Li <Frank.Li@nxp.com>
> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 7c60b712480a..016b86add959 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -48,6 +48,8 @@
>  #define IMX95_PCIE_SS_RW_REG_0			0xf0
>  #define IMX95_PCIE_REF_CLKEN			BIT(23)
>  #define IMX95_PCIE_PHY_CR_PARA_SEL		BIT(9)
> +#define IMX95_PCIE_SS_RW_REG_1			0xf4
> +#define IMX95_PCIE_SYS_AUX_PWR_DET		BIT(31)
>  
>  #define IMX95_PE0_GEN_CTRL_1			0x1050
>  #define IMX95_PCIE_DEVICE_TYPE			GENMASK(3, 0)
> @@ -227,6 +229,19 @@ static unsigned int imx_pcie_grp_offset(const struct imx_pcie *imx_pcie)
>  
>  static int imx95_pcie_init_phy(struct imx_pcie *imx_pcie)
>  {
> +	/*
> +	 * ERR051624: The Controller Without Vaux Cannot Exit L23 Ready
> +	 * Through Beacon or PERST# De-assertion
> +	 *
> +	 * When the auxiliary power is not available, the controller
> +	 * cannot exit from L23 Ready with beacon or PERST# de-assertion
> +	 * when main power is not removed.
> +	 *
> +	 * Workaround: Set SS_RW_REG_1[SYS_AUX_PWR_DET] to 1.
> +	 */
> +	regmap_set_bits(imx_pcie->iomuxc_gpr, IMX95_PCIE_SS_RW_REG_1,
> +			IMX95_PCIE_SYS_AUX_PWR_DET);
> +
>  	regmap_update_bits(imx_pcie->iomuxc_gpr,
>  			IMX95_PCIE_SS_RW_REG_0,
>  			IMX95_PCIE_PHY_CR_PARA_SEL,
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

