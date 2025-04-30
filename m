Return-Path: <linux-pci+bounces-27027-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0520BAA4405
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 09:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4819814F6
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 07:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB363987D;
	Wed, 30 Apr 2025 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e4y4TkSM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 132361D6AA
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 07:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745998265; cv=none; b=AbsK8rqo9WWCoIkb2RtJh9lbybVNQaMWUkRseT3YZO7dQfqQw+cQqQGjnmaxgFEkI9Pd0HXYCFBHyxMLwqExHfG1YnXtRM/6sjcUkX4D0WoIajw7ynG7Iki+JbEwPQPHNo9SUDHcax25/MEHhSWT9R/dYK+EttlJU/4bvSr3XAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745998265; c=relaxed/simple;
	bh=ZuEmSp0MRVBRAbKGkutGgPEteX/zBtxBUlAI/j/I9mc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D98bGeQXfytsKRcRd3nRbx3bAOvwOkeyHBdlcQQ3VT5o72Y8Mu0zOexGvAksrhioG0+/f4e+fkiQm720GO/cpJn3Ch8g71SLs4icOxxa948r7x1Kj+aBCLYXgvq8/riyu+07Mh4OGSosqgBJgPYMCugv0/PXE7mLBiuZmMKTQBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e4y4TkSM; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-225df540edcso7115925ad.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 00:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1745998263; x=1746603063; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=f9BcveS9bJ2hUNKExpwZbpno31qDfmJMMPHesU3EtOA=;
        b=e4y4TkSM9LXnr4tCNXWqsZtKYGGBV57Rf5wg4QxLZCwPK3kf1ob882iMHyHPKlQWr0
         KGKK/1uSF4LhkmxbaOg9hZlfn8t9fNkW4gRxyd+GJjCbBVTKTwI9YcBBKewiqYPE3XAR
         dOF00lNr+qoxmqFbOs3agz+dmbV4o8k/XklS2n/jRS+b0jr4vs8aj41Eoma9VKElNXSI
         Ykp6yArWHZn+uToc4Y6+r2MXNZHHsfv7M27/rDWl6DTA56kJvyLLMF9kzjlkkVGa/gLZ
         eJ4Xt3w7exQxCY7Ry6ZDyvIYrCbI/pdrelYsIctETwegA3WnQOQTIJzb6zrUkFKKLcfI
         /MmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745998263; x=1746603063;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f9BcveS9bJ2hUNKExpwZbpno31qDfmJMMPHesU3EtOA=;
        b=PzjqknBzMSveyoV/FJfP+2gwCTuiwu9hWr8k0ahg5GfojUAYf2Z8RtzEFFQq0LjjUb
         oI1eZsfQt+kgbrjFWOt00Bm+cV8g5YD2nmH+4IdiznEgF2VbVdrsqCGFGtIx3c7pPVHF
         hv42ywr0CtjhSSFt60OAlFK3HAjaWYIlZh8ZEGQD027EbsM0kkTZzwPr64X8EZSQXEd7
         362I0Q9epu2Ht/pPZZJINckE9jWQl3hP9AS3mnB/JelcvVfN3J2Nr2BwpUnEXXxq0698
         /g77jSacKuPx5XoSWjWxERZX/FOgfZDBCG8gDIUqp4lkPoPhbGwFwlodHWP0E9CwitxY
         GDUA==
X-Forwarded-Encrypted: i=1; AJvYcCVdOYicnCTtMUC/iriiyjQ7LaclMyhJKlw64W7TTcnRwTQNQScLbfJwyhV5prB1+hTLQ6jQ/rZjguQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVZW6YcfvahxVZnjbvmaKMNE7+CNS/IOObfEM3emyh40LgUz6W
	wpyd53Y1b/QHUq0Gh2k0sijZP3wwSgwYna51XGDLnkFF/WvNDqiGfcMhKkco8A==
X-Gm-Gg: ASbGnctfLpxp9+rOLPuIhwpxAcDnt8fzh0tDd1egC069i6ruegZhPURW/fSRSwiiEgh
	zGU9QpeIYV8GH+DSXbpoa+zNL0toRZywkdUo0bfell9WoKCnKAjqFUQJ035vsh+uwlGuw5Rrxdq
	y0mOSPbvF83IBqOShg4yQJOde9sN/5JrvBqT99yHynn+bWxyZKrAQmoQyKvTasNd3w3fyKTZqKr
	7FLWZllHCECsHMvWBamC21rtuu+Ylr0yCR5nDt9szLWoJGN/cymJJ2Pun6CmPhVKuTb8XZ61bOJ
	+pnYSGy9fDZ6Ti4A2fD0M2wnNnlySYCmjxlyHyQLY6OzRhE+M5lMEyblzAEUahU=
X-Google-Smtp-Source: AGHT+IGvuUKCFE89zlztyMs58PdQPaZwbdcUg7B/Z8lPi6W5exJgXq8dwQDiTzUF/X2QftM+XSATqQ==
X-Received: by 2002:a17:903:946:b0:220:e91f:4408 with SMTP id d9443c01a7336-22df481a867mr25135935ad.22.1745998263295;
        Wed, 30 Apr 2025 00:31:03 -0700 (PDT)
Received: from thinkpad ([120.56.197.193])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22db4d76fa2sm115884365ad.19.2025.04.30.00.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 00:31:02 -0700 (PDT)
Date: Wed, 30 Apr 2025 13:00:56 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Christian Bruel <christian.bruel@foss.st.com>
Cc: lpieralisi@kernel.org, kw@linux.com, robh@kernel.org, 
	bhelgaas@google.com, krzk+dt@kernel.org, conor+dt@kernel.org, 
	mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com, p.zabel@pengutronix.de, 
	thippeswamy.havalige@amd.com, shradha.t@samsung.com, quic_schintav@quicinc.com, 
	cassel@kernel.org, johan+linaro@kernel.org, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/9] PCI: stm32: Add PCIe host support for STM32MP25
Message-ID: <gzw3rcuwuu7yswljzde2zszqlzkfsilozdfv2ebrcxjpvngpkk@hvzqb5wbjalb>
References: <20250423090119.4003700-1-christian.bruel@foss.st.com>
 <20250423090119.4003700-3-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250423090119.4003700-3-christian.bruel@foss.st.com>

On Wed, Apr 23, 2025 at 11:01:12AM +0200, Christian Bruel wrote:
> Add driver for the STM32MP25 SoC PCIe Gen1 2.5 GT/s and Gen2 5GT/s
> controller based on the DesignWare PCIe core.
> 
> Supports MSI via GICv2m, Single Virtual Channel, Single Function
> 
> Supports WAKE# GPIO.
> 

Mostly looks good. Just a couple of comments below.

> Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
> ---
>  drivers/pci/controller/dwc/Kconfig      |  12 +
>  drivers/pci/controller/dwc/Makefile     |   1 +
>  drivers/pci/controller/dwc/pcie-stm32.c | 368 ++++++++++++++++++++++++
>  drivers/pci/controller/dwc/pcie-stm32.h |  15 +
>  4 files changed, 396 insertions(+)
>  create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
>  create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h
> 

[...]

> +static int stm32_pcie_probe(struct platform_device *pdev)
> +{
> +	struct stm32_pcie *stm32_pcie;
> +	struct device *dev = &pdev->dev;
> +	int ret;
> +
> +	stm32_pcie = devm_kzalloc(dev, sizeof(*stm32_pcie), GFP_KERNEL);
> +	if (!stm32_pcie)
> +		return -ENOMEM;
> +
> +	stm32_pcie->pci.dev = dev;
> +	stm32_pcie->pci.ops = &dw_pcie_ops;
> +	stm32_pcie->pci.pp.ops = &stm32_pcie_host_ops;
> +
> +	stm32_pcie->regmap = syscon_regmap_lookup_by_compatible("st,stm32mp25-syscfg");
> +	if (IS_ERR(stm32_pcie->regmap))
> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->regmap),
> +				     "No syscfg specified\n");
> +
> +	stm32_pcie->clk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(stm32_pcie->clk))
> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->clk),
> +				     "Failed to get PCIe clock source\n");
> +
> +	stm32_pcie->rst = devm_reset_control_get_exclusive(dev, NULL);
> +	if (IS_ERR(stm32_pcie->rst))
> +		return dev_err_probe(dev, PTR_ERR(stm32_pcie->rst),
> +				     "Failed to get PCIe reset\n");
> +
> +	ret = stm32_pcie_parse_port(stm32_pcie);
> +	if (ret)
> +		return ret;
> +
> +	platform_set_drvdata(pdev, stm32_pcie);
> +
> +	ret = pm_runtime_set_active(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to activate runtime PM %d\n", ret);

Please use dev_err_probe() here and below.

> +		return ret;
> +	}
> +
> +	ret = devm_pm_runtime_enable(dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to enable runtime PM %d\n", ret);
> +		return ret;
> +	}
> +
> +	pm_runtime_get_noresume(dev);
> +

I know that a lot of the controller drivers do this for no obvious reason. But
in this case, I believe you want to enable power domain or genpd before
registering the host bridge. Is that right? And the fact that you are not
decrementing the runtime usage count means, you want to keep it ON all the time?
Beware that your system suspend/resume calls would never get executed. 

Also in any case, you need to call this before devm_pm_runtime_enable().
Otherwise, PM core will suspend the parent and enable it during
pm_runtime_get_noresume(), which is redundant.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

