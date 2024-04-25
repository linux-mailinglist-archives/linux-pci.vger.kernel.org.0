Return-Path: <linux-pci+bounces-6666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CF08B2253
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 15:14:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E56C28A1E3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Apr 2024 13:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E05149C56;
	Thu, 25 Apr 2024 13:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cqBUrwHx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A4561494D5
	for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 13:14:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714050870; cv=none; b=lUIX6ibqH581iIfzwbwOdmn+xpGH9lgM1++TwPbhEjZMAEkgHixfPue7qJxlQCxJExtSm7JoWs1TSMo4NsVqV1OyQTD9dDhuRa0Y+n6EN/uxZpOmX+FSa7CCBFwHO1DZxvEJktEnYWPHBgjj8SmbZiL1C3NjRAYSLwQRtEVmpZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714050870; c=relaxed/simple;
	bh=wCML22m6hmMo/QLa3LknC8Q4UzH9iPk8kINFFPX1TE8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PQHvXfXG9wl9+MG3aw7KXgnFhSqG8x4+xL20koUfFnuKqtrs+hxKQOlTabVF18ixwO4Dqb5Mr3tmDyQzPYh4e+T3uKtrzWV2uV/px9ejipAKKvQcFaGCE6cvYLSdiyvo8dVeO3vG7b8Q0Hr83VAG+jhH/mZuAn0W6SJnDyN/uH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cqBUrwHx; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6ed32341906so973219b3a.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Apr 2024 06:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714050867; x=1714655667; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=P22rjP0GKc3HrQKjLYySYUXJroxGYvV8P+eniFj8yPc=;
        b=cqBUrwHx/EHaKGR+YiZogTGG2Lexu5p5kmEKe6ei3Hp44+Km9lMWaqQMXNdF/mVK8E
         SAWlxBhkyTiYpkwjpDqyKL8FoaQTHYlFwezr6b3OI72m+p/jc37XL0qDa82rHmLUBiiO
         g0xzW5V6U8FgDXUx5p6Ljm9zH//lshLeFbJmDoMVIFzCUWJ/Z8jk4gBADtNmsxT3FrQd
         15VVW635mQMuwy+H0Hqv8hOPgEzI0/Fia0suctASYVgHyRqLoptlzclIouZ0kWLUnr1c
         GHft+s9NcmZ01MD10HYeF1e/y1iEy6zpUp8la/N1nzMJ1HRs3LJ417ikcvPSXGwUuVta
         NYIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714050867; x=1714655667;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P22rjP0GKc3HrQKjLYySYUXJroxGYvV8P+eniFj8yPc=;
        b=f0GDnosKzeUE6kLXQMDglKXwHR48oYzEy3x2sgCHWtxH5m4tEgZzmUXUEbpiHLEXng
         SobzOD5MrGd0Cuw9R9wN5gUHzy9PqY+GgpSybEB+hMd9YYedOAXfr8GZoRY61vla91pP
         sCZ0Ykr8QOT7bI8c2O+cF6dZb5RTiwyqujc3K4M0qlgmrPNRBHEUrQv/PFBiuaLDq8si
         LZYjTm8pKGY1iGx7p28jVDayLLmbjNtWQJJmoDOz3+QBGQ0A+zZOuw/vISCjFAMKn2w/
         and/i7H7GD5zz6pWRUQLa+7G0ooL0xp0sVS+SUolhAL3iuwA11sGBPZGFKaZpM/dFYq7
         JSIg==
X-Forwarded-Encrypted: i=1; AJvYcCULSn2BCWhXSyarRVjAlbN11ZeGwkTjqAfNhqBeJTis4AmQRFXqeLy5K5yTnueYGv/SKMvmptwqijUGyK9wekoebB1oU9IZjm9g
X-Gm-Message-State: AOJu0Yy3HBDwvO9RPYBanCgHp52LuBnjupEfqc8smHPOkFqPitVh0qHk
	/b+b8AY6YyXOIzztT6hFwtQWLFEG/uaKDYnDNWzbMACRKzfI0pi+KN5FgjkhMw==
X-Google-Smtp-Source: AGHT+IFC9amtzxFpBPZ2igiN1PKnlRPHmCdtwEry+/lmfA55mat1BjxouI7AcbfAetYJB0CBHeVcEA==
X-Received: by 2002:a05:6a21:2d85:b0:1a9:c757:a22d with SMTP id ty5-20020a056a212d8500b001a9c757a22dmr6395235pzb.14.1714050867296;
        Thu, 25 Apr 2024 06:14:27 -0700 (PDT)
Received: from thinkpad ([120.60.75.221])
        by smtp.gmail.com with ESMTPSA id 17-20020a056a00073100b006eadc87233dsm13100532pfm.165.2024.04.25.06.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 06:14:26 -0700 (PDT)
Date: Thu, 25 Apr 2024 18:44:15 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Bjorn Helgaas <bhelgaas@google.com>, johan+linaro@kernel.org,
	bmasney@redhat.com, djakov@kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
	vireshk@kernel.org, quic_vbadigan@quicinc.com,
	quic_skananth@quicinc.com, quic_nitegupt@quicinc.com,
	quic_parass@quicinc.com, krzysztof.kozlowski@linaro.org
Subject: Re: [PATCH v11 6/6] PCI: qcom: Add OPP support to scale performance
Message-ID: <20240425131415.GC3449@thinkpad>
References: <20240423-opp_support-v11-0-15fdd40b0f95@quicinc.com>
 <20240423-opp_support-v11-6-15fdd40b0f95@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423-opp_support-v11-6-15fdd40b0f95@quicinc.com>

On Tue, Apr 23, 2024 at 02:37:00PM +0530, Krishna chaitanya chundru wrote:
> QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
> maintains hardware state of a regulator by performing max aggregation of
> the requests made by all of the clients.
> 
> PCIe controller can operate on different RPMh performance state of power
> domain based on the speed of the link. And this performance state varies
> from target to target, like some controllers support GEN3 in NOM (Nominal)
> voltage corner, while some other supports GEN3 in low SVS (static voltage
> scaling).
> 
> The SoC can be more power efficient if we scale the performance state
> based on the aggregate PCIe link bandwidth.
> 
> Add Operating Performance Points (OPP) support to vote for RPMh state based
> on the aggregate link bandwidth.
> 
> OPP can handle ICC bw voting also, so move ICC bw voting through OPP
> framework if OPP entries are present.
> 
> As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
> is supported.
> 
> Before PCIe link is initialized vote for highest OPP in the OPP table,
> so that we are voting for maximum voltage corner for the link to come up
> in maximum supported speed.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>

Couple of nitpicks below. With that addressed,

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++------
>  1 file changed, 67 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index 465d63b4be1c..66bda30305a8 100644
> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> @@ -22,6 +22,7 @@
>  #include <linux/of.h>
>  #include <linux/of_gpio.h>
>  #include <linux/pci.h>
> +#include <linux/pm_opp.h>
>  #include <linux/pm_runtime.h>
>  #include <linux/platform_device.h>
>  #include <linux/phy/pcie.h>
> @@ -1443,15 +1444,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
>  	return 0;
>  }
>  
> -static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
> +static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
>  {
>  	struct dw_pcie *pci = pcie->pci;
> -	u32 offset, status;
> +	u32 offset, status, freq;
> +	struct dev_pm_opp *opp;
>  	int speed, width;
> -	int ret;
> -
> -	if (!pcie->icc_mem)
> -		return;
> +	int ret, mbps;
>  
>  	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
>  	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
> @@ -1463,10 +1462,26 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>  	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>  
> -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> -	if (ret) {
> -		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
> -			ret);
> +	if (pcie->icc_mem) {
> +		ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> +		if (ret) {
> +			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
> +				ret);
> +		}
> +	} else {
> +		mbps = pcie_link_speed_to_mbps(pcie_link_speed[speed]);

Don't use opaque variable names. Here it should be 'freq_mbps'.

> +		if (mbps < 0)
> +			return;
> +
> +		freq = mbps * 1000;

And this should be 'freq_kbps'.

> +		opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);
> +		if (!IS_ERR(opp)) {
> +			ret = dev_pm_opp_set_opp(pci->dev, opp);
> +			if (ret)
> +				dev_err(pci->dev, "Failed to set opp for freq (%ld): %d\n",

s/opp/OPP

> +					dev_pm_opp_get_freq(opp), ret);

Frequency is already available here, no? Hint: freq_kbps * width

> +		}
> +		dev_pm_opp_put(opp);
>  	}
>  }
>  
> @@ -1510,7 +1525,9 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg;
> +	unsigned long max_freq = INT_MAX;
>  	struct device *dev = &pdev->dev;
> +	struct dev_pm_opp *opp;
>  	struct qcom_pcie *pcie;
>  	struct dw_pcie_rp *pp;
>  	struct resource *res;
> @@ -1578,9 +1595,42 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_pm_runtime_put;
>  	}
>  
> -	ret = qcom_pcie_icc_init(pcie);
> -	if (ret)
> +	/* OPP table is optional */
> +	ret = devm_pm_opp_of_add_table(dev);
> +	if (ret && ret != -ENODEV) {
> +		dev_err_probe(dev, ret, "Failed to add OPP table\n");
>  		goto err_pm_runtime_put;
> +	}
> +
> +	/*
> +	 * Before PCIe link is initialized vote for highest OPP in the OPP table,
> +	 * so that we are voting for maximum voltage corner for the link to come up
> +	 * in maximum supported speed. At the end of the probe(), OPP will be
> +	 * updated using qcom_pcie_icc_opp_update().
> +	 */
> +	if (!ret) {
> +		opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
> +		if (IS_ERR(opp)) {
> +			dev_err_probe(pci->dev, PTR_ERR(opp),
> +				      "Unable to find max freq OPP\n");
> +			goto err_pm_runtime_put;
> +		} else {
> +			ret = dev_pm_opp_set_opp(dev, opp);
> +		}
> +
> +		dev_pm_opp_put(opp);
> +		if (ret) {
> +			dev_err_probe(pci->dev, ret,
> +				      "Failed to set OPP for freq (%ld): %d\n",

With dev_err_probe(), errno will be printed by default.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

