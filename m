Return-Path: <linux-pci+bounces-6344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F62D8A7CE4
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 09:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA702B2113C
	for <lists+linux-pci@lfdr.de>; Wed, 17 Apr 2024 07:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 682D66A347;
	Wed, 17 Apr 2024 07:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rTIfmRVv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17C76A357
	for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 07:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713338057; cv=none; b=uwUGo5A0ao6G5TSpknfS3e12/gsuXLjBq7vlIwW7qsx8tuWpmzuLpwjmWhnjyLoQQBOD6CjP1xOFNLjLO2ZMOjINAyuufY+uDcpHy+vrmglbHQH5rTNa4sWmdesNqNxjRIzYZYbTUtQL2cJjK1MAsjji6H1YsCYfHeiwmwvC0Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713338057; c=relaxed/simple;
	bh=Wg9bp/1KONUVlzT3UD7ChlmkEWpfB86YN/zEsuRAT8I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MVJ1ravXNzxGW0ar/5Ulh4/eJRiXGDviYkFDZcZXVb9aGtc4Ut6ZCbafR3gOYkrbApsh/P5cwBbj/I8G2M+GsGRCa1yoTFqthbxWdYxsMtpDEM1xpRoG5IKM3pZiPVTUVOkePeoJNoSFJZT5zKPFZfQ6CnGS9UsYSNIxNTvCIis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rTIfmRVv; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6eb86aeeb2cso1496845a34.3
        for <linux-pci@vger.kernel.org>; Wed, 17 Apr 2024 00:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713338055; x=1713942855; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rds/vSPkCgLztEVJcMBchz0yVanaqr2q9MoqHxNAgzI=;
        b=rTIfmRVvzw7GHb80iifWSxFmg8JI2hSbMRbCejEm1be2oBphm1D/H+hLGi5Giardbh
         PlVKu4XnCvTrJ/OYV1r4w179767uIzYG+2hUkum6PaO4MZXWt0elVHc5cBPHWpPEfIlN
         PVfW3N0KMZp/+VTi2Uhw/jzQ3HhGnuM7Yi6aMUnHqYa5KCiSK/kGFAx/Ebk+9G9ZSsOT
         ptKhmtZRvkpb4qCbNnK6pmToGBvvk+aZUr/fNvgOJhOcIHirNHYS7kAhirJmNvb3h95M
         6BSNVaOT2DqfatW7rvJnvOBkZ7OofT+oi46l7zcO6fuZcJ7Vni1C3/t+yOQhFeGvi8fn
         MkZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713338055; x=1713942855;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rds/vSPkCgLztEVJcMBchz0yVanaqr2q9MoqHxNAgzI=;
        b=g2MJ6Fh/a5vxnVWnk48OSSY37Y5roUXHU6fBmjsMpVym9FlII9fPcEoC0qoEQQ3nO7
         dsv8InS6MzGIzTYiEw6AEQRpD0cNqT2VoWvJQvEjevkUCAK8PMXDgTNSp+gAD7cXbKOS
         ojeQzP3q+b1riVK5zUoYgfXExBWcAwJ0K9oyz/wtcFFuNYuHeliiHLEcXuUxQLgaqF9R
         2y5Gae7ljoLlCBWaml3JAAD5pP8O6io7ez/Yt4k2bT1xBAglAhb1jPQO3dSqTUdiFbvq
         knEHYCirzjPlACsuSDdx5pcFhyjsKyokc1K/l0PmXvso1glvB8IPEi2fPaoKUKaIK5yY
         WB0g==
X-Forwarded-Encrypted: i=1; AJvYcCXzf7p8sXeOHeIQdNZ6C2yEmp8WsDyeWg937kFGrT21WrNUzFzAZ8XmOKft6e3MF+IEr0JMxz/QsTC/EDMPzmqfNa+4mgj0NmHF
X-Gm-Message-State: AOJu0YzsBBR/QWFHJePCVLhlHMXAUxhrpyt7sMEKruXr1hj1h/+IQXCq
	ycVJMaTxxCKWSvsFGP5YFlsJUJpdfYrkyu87hSvHe1lGU3UZ05CRyefYPtQkWg==
X-Google-Smtp-Source: AGHT+IHaHrm2pb+wT7KKfQkSKKuzy7HKCVhCIyuFy2rzef2uOrb0UaXT1cyILAlN1opmVB/oaR6cAg==
X-Received: by 2002:a05:6870:70a1:b0:22f:70da:1f26 with SMTP id v33-20020a05687070a100b0022f70da1f26mr19032069oae.27.1713338054787;
        Wed, 17 Apr 2024 00:14:14 -0700 (PDT)
Received: from thinkpad ([120.60.54.9])
        by smtp.gmail.com with ESMTPSA id z3-20020aa78883000000b006e5571be110sm9998837pfe.214.2024.04.17.00.14.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Apr 2024 00:14:14 -0700 (PDT)
Date: Wed, 17 Apr 2024 12:44:06 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Alexandru Gagniuc <mr.nuke.me@gmail.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
	linux-clk@vger.kernel.org
Subject: Re: [PATCH v3 4/7] PCI: qcom: Add support for IPQ9574
Message-ID: <20240417071406.GC3894@thinkpad>
References: <20240415182052.374494-1-mr.nuke.me@gmail.com>
 <20240415182052.374494-5-mr.nuke.me@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240415182052.374494-5-mr.nuke.me@gmail.com>

On Mon, Apr 15, 2024 at 01:20:49PM -0500, Alexandru Gagniuc wrote:
> Add support for the PCIe on IPQ9574. The main difference from ipq6018
> is that the "iface" clock is not necessarry. Add a special case in
> qcom_pcie_get_resources_2_9_0() to handle this.
> 

Could you add more information about the PCIe controller used in this SoC? Like
controller version, supported data rate, PCIe generation etc...

- Mani

> Signed-off-by: Alexandru Gagniuc <mr.nuke.me@gmail.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 14772edcf0d3..10560d6d6336 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -1101,15 +1101,19 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
>  	struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
>  	struct dw_pcie *pci = pcie->pci;
>  	struct device *dev = pci->dev;
> -	int ret;
> +	int ret, num_clks = ARRAY_SIZE(res->clks) - 1;
>  
> -	res->clks[0].id = "iface";
> +	res->clks[0].id = "rchng";
>  	res->clks[1].id = "axi_m";
>  	res->clks[2].id = "axi_s";
>  	res->clks[3].id = "axi_bridge";
> -	res->clks[4].id = "rchng";
>  
> -	ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> +	if (!of_device_is_compatible(dev->of_node, "qcom,pcie-ipq9574")) {
> +		res->clks[4].id = "iface";
> +		num_clks++;
> +	}
> +
> +	ret = devm_clk_bulk_get(dev, num_clks, res->clks);
>  	if (ret < 0)
>  		return ret;
>  
> @@ -1664,6 +1668,7 @@ static const struct of_device_id qcom_pcie_match[] = {
>  	{ .compatible = "qcom,pcie-ipq8064-v2", .data = &cfg_2_1_0 },
>  	{ .compatible = "qcom,pcie-ipq8074", .data = &cfg_2_3_3 },
>  	{ .compatible = "qcom,pcie-ipq8074-gen3", .data = &cfg_2_9_0 },
> +	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
>  	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
>  	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
>  	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
> -- 
> 2.40.1
> 

-- 
மணிவண்ணன் சதாசிவம்

