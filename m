Return-Path: <linux-pci+bounces-25115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 48B3CA7889A
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 09:10:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E21FA7A399D
	for <lists+linux-pci@lfdr.de>; Wed,  2 Apr 2025 07:09:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06A922356CF;
	Wed,  2 Apr 2025 07:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lDV2F7Kv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EE12356B2
	for <linux-pci@vger.kernel.org>; Wed,  2 Apr 2025 07:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743577725; cv=none; b=YTRESZNgwTL3kfM896f61DVl2tNoB9IVnFI+QwOZbr+wcz1jyM219qZNU1YGuEnvVwPpVQhi+LpRQKJJKTboyeLpOqsv6v8RnlY1rJg1MVlpzF1CkAck3DiDkFYxCAndoMEH+zrmjFN18meqjZ5RV02zCkI89f9VADnQ5FsqO7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743577725; c=relaxed/simple;
	bh=iwptS4Fiz/t1wRBCwp0WrKM5yTxXoSw3nTT35Pn5ibU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e7YyYMEnjsmLnZgxi7LeEYvBSTGML/eCFceNc0ckbObI0EJ/UAiLkp4qXIFYnIvw+cG765kbSzfdmGhuZZWXt3xCyuFQ3sDkJVl/t1ZRCiaPndJxfp9b6EdvzG2F1jMixANQNi5EnSexmcUQ+mzle6XBK0AY9gydTp+z5CUpzRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lDV2F7Kv; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227b828de00so111641615ad.1
        for <linux-pci@vger.kernel.org>; Wed, 02 Apr 2025 00:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1743577722; x=1744182522; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=sBLznZWhA5X82bZqkVVLBxnwT0YwdGpBuJ1F1bT4V+o=;
        b=lDV2F7KvOjPTIAPkSRw3NlL+bnl7U+8AQ9E13SxhTTpdKm1KpislvuPwyodPKNib56
         Y1VZ94wmte80fIOzwO3I16QeKZnk0B442GDTViFm9ulMJl9KlXzS09yMyFk51z7t03Ct
         6MgC18denusbKkiRLV/hhVCQD1jqukTBOmTf3dz0ZUWBm4TUjEBWJQsRjzGEKUSkU/lZ
         TqruB3ReVOcr4aVhLaYyCNjFuTTt7vUydTEBj0yTimJkuYkB3Cw0BUle7Pb0AFrUgUVR
         dSXhAoF51d8YEUfY1Mz+2VGQvp8oqSgq1fqqZQoaACUfhDO7twg5YYa8B0WamWO8bg4i
         /k/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743577722; x=1744182522;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sBLznZWhA5X82bZqkVVLBxnwT0YwdGpBuJ1F1bT4V+o=;
        b=Td3l7MtuBQjNMzVZzAB7c8qdpNCbXfYkJuMe8mx6bdD4kcBN7sKIFlaxq0y6aZ/0hY
         xBhYg94hqDbaBgpjq/Q4l522dZsJ+iCa2SU0TzLlr8fxt+aP9vPxwaydqMpwqXMBFubq
         muhrJgFuux5Tp8IlggyGVIt1x4CCHMilq0ChYBWiZ1ZSJU4kRd/DpaAX3MgOrEXU7wEB
         rMa36O7dK8Vm7erFe/Jr2cAJr7IO5qeK0H0Goa0AR49LzO+skkyFQFbr7JcS+YwMja9U
         PNaLiybOLNM2XtA4GuSIsORo+IpAZH6yNr84ghz6RUxABEotErcFsUkImXFLclnff+0T
         syEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU10LPW+IZljPOcedwGbJaLDIQBGceV5yAG2P22D7T80mW0OiRo4nNkaCxU2gbVy4PHbsPXjeiP98k=@vger.kernel.org
X-Gm-Message-State: AOJu0YzuEsA1FAQiFj50WWJKatJ64D5ojycYd2yUAtgOyaKEEHMtwFnT
	003uuj7zQAxBZRXVgunvTwvK7FZk2a9NyUh6DxUTz3inmGqvKfxu3iN8YgfbRg==
X-Gm-Gg: ASbGncudYlJIf2kmwW+AloaSYucvh20oUjL6pwC1vRJ+M4Mu12Cpt3ATnWqxjUC64IF
	e2mxtuCrWFd5SbRd+QLQZCQRoHCbzQMiFKDpzEj+y61Nb3gKb5kQIF4ft6O6GR9yKcSLsoON+8u
	TKNcnuQgZr3nU0R6Axx1yeXVzy4TwPpjOZqca3/ui+dXL3TOi87SJqFttKwEv94JK93aGqFvz02
	3QpLc8PPTvM00v67uEVAzbgs8mwERjGjIvnLsRybxSlRVl8VVkU2DOR5FTpD0N41Ib8s4FidtDv
	Gxf6Ne6cplhnJ35Ck/uHPdO+RGc0nQzUsgVxsmJuBGBXJONdurjR1NTc
X-Google-Smtp-Source: AGHT+IESAdavvdZhZEPYi8YmhJREn3GzNckInuKrjE2kz7qwPxEfQH3XTifLJZjh/3yYARxtAKubSg==
X-Received: by 2002:a05:6a00:398f:b0:736:ab48:5b0 with SMTP id d2e1a72fcca58-739c78430demr1761550b3a.2.1743577722481;
        Wed, 02 Apr 2025 00:08:42 -0700 (PDT)
Received: from thinkpad ([120.56.205.103])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73970def428sm10236829b3a.32.2025.04.02.00.08.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Apr 2025 00:08:42 -0700 (PDT)
Date: Wed, 2 Apr 2025 12:38:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Richard Zhu <hongxing.zhu@nxp.com>
Cc: frank.li@nxp.com, l.stach@pengutronix.de, lpieralisi@kernel.org, 
	kw@linux.com, robh@kernel.org, bhelgaas@google.com, shawnguo@kernel.org, 
	s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, imx@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/6] PCI: imx6: Let i.MX95 PCIe compliance with 8GT/s
 Receiver Impedance ECN
Message-ID: <u2doi5nksovsxf75ahwdr3c3uixjk555mbwouvtblf5rruoicv@uvsdytcwoish>
References: <20250328030213.1650990-1-hongxing.zhu@nxp.com>
 <20250328030213.1650990-5-hongxing.zhu@nxp.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250328030213.1650990-5-hongxing.zhu@nxp.com>

On Fri, Mar 28, 2025 at 11:02:11AM +0800, Richard Zhu wrote:
> ERR051586: Compliance with 8GT/s Receiver Impedance ECN.
> 
> The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] is 1 which
> makes receiver non-compliant with the ZRX-DC parameter for 2.5 GT/s when
> operating at 8 GT/s or higher. It causes unnecessary timeout in L1.
> 
> Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL] to 0.
> 
> Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> ---
>  drivers/pci/controller/dwc/pci-imx6.c | 31 +++++++++++++++++++++++++++
>  1 file changed, 31 insertions(+)
> 
> diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
> index 82402e52eff2..35194b543551 100644
> --- a/drivers/pci/controller/dwc/pci-imx6.c
> +++ b/drivers/pci/controller/dwc/pci-imx6.c
> @@ -110,6 +110,7 @@ enum imx_pcie_variants {
>   */
>  #define IMX_PCIE_FLAG_BROKEN_SUSPEND		BIT(9)
>  #define IMX_PCIE_FLAG_HAS_LUT			BIT(10)
> +#define IMX_PCIE_FLAG_8GT_ECN_ERR051586		BIT(11)
>  
>  #define imx_check_flag(pci, val)	(pci->drvdata->flags & val)
>  
> @@ -1263,6 +1264,32 @@ static void imx_pcie_host_exit(struct dw_pcie_rp *pp)
>  		regulator_disable(imx_pcie->vpcie);
>  }
>  
> +static void imx_pcie_host_post_init(struct dw_pcie_rp *pp)
> +{
> +	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
> +	struct imx_pcie *imx_pcie = to_imx_pcie(pci);
> +	u32 val;
> +
> +	if (imx_pcie->drvdata->flags & IMX_PCIE_FLAG_8GT_ECN_ERR051586) {
> +		/*
> +		 * ERR051586: Compliance with 8GT/s Receiver Impedance ECN
> +		 *
> +		 * The default value of GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
> +		 * is 1 which makes receiver non-compliant with the ZRX-DC
> +		 * parameter for 2.5 GT/s when operating at 8 GT/s or higher.
> +		 * It causes unnecessary timeout in L1.
> +		 *
> +		 * Workaround: Program GEN3_RELATED_OFF[GEN3_ZRXDC_NONCOMPL]
> +		 * to 0.
> +		 */
> +		dw_pcie_dbi_ro_wr_en(pci);
> +		val = dw_pcie_readl_dbi(pci, GEN3_RELATED_OFF);
> +		val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
> +		dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
> +		dw_pcie_dbi_ro_wr_dis(pci);
> +	}
> +}
> +
>  static u64 imx_pcie_cpu_addr_fixup(struct dw_pcie *pcie, u64 cpu_addr)
>  {
>  	struct imx_pcie *imx_pcie = to_imx_pcie(pcie);
> @@ -1304,6 +1331,7 @@ static const struct dw_pcie_host_ops imx_pcie_host_ops = {
>  static const struct dw_pcie_host_ops imx_pcie_host_dw_pme_ops = {
>  	.init = imx_pcie_host_init,
>  	.deinit = imx_pcie_host_exit,
> +	.post_init = imx_pcie_host_post_init,
>  };
>  
>  static const struct dw_pcie_ops dw_pcie_ops = {
> @@ -1403,6 +1431,7 @@ static int imx_add_pcie_ep(struct imx_pcie *imx_pcie,
>  	struct device *dev = pci->dev;
>  
>  	imx_pcie_host_init(pp);
> +	imx_pcie_host_post_init(pp);
>  	ep = &pci->ep;
>  	ep->ops = &pcie_ep_ops;
>  
> @@ -1812,6 +1841,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  		.variant = IMX95,
>  		.flags = IMX_PCIE_FLAG_HAS_SERDES |
>  			 IMX_PCIE_FLAG_HAS_LUT |
> +			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
>  			 IMX_PCIE_FLAG_SUPPORTS_SUSPEND,
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> @@ -1865,6 +1895,7 @@ static const struct imx_pcie_drvdata drvdata[] = {
>  	[IMX95_EP] = {
>  		.variant = IMX95_EP,
>  		.flags = IMX_PCIE_FLAG_HAS_SERDES |
> +			 IMX_PCIE_FLAG_8GT_ECN_ERR051586 |
>  			 IMX_PCIE_FLAG_SUPPORT_64BIT,
>  		.ltssm_off = IMX95_PE0_GEN_CTRL_3,
>  		.ltssm_mask = IMX95_PCIE_LTSSM_EN,
> -- 
> 2.37.1
> 

-- 
மணிவண்ணன் சதாசிவம்

