Return-Path: <linux-pci+bounces-5843-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FB8789B29B
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 17:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0E821F22249
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 15:01:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E6368485;
	Sun,  7 Apr 2024 15:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e1aIMOHD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0146539AC7
	for <linux-pci@vger.kernel.org>; Sun,  7 Apr 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712502059; cv=none; b=cFQnKFl3lEIuTU4adoMXHZ5BUAXdy6XnqFtcAojKiQJNmnPX/mV5KsSe2zMtS+GyUNdQGnz2+jNGU1PSvDiHB4lKK2rFwKGPD/JXGQc3Sk0ZKVws2gslQbPZhRX2w1CM/8K93PBddig2IChdLCTcTsBYtZy3dUGQUaZsB6hnVQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712502059; c=relaxed/simple;
	bh=bURv5oTWANCH9z9cXPSJn5dd7BobQTawT2S3pufseLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVPqOE+8pzGd7RWiKyMYYQ/q+JThPAtxyPgU/s0QWV/XaBqSQO/B2HFQWaSKlmhJECRKfE8nQErmLGgkAeb/z5C9pAwzksR2Ly/fDuoY0Ps7s6vhMApb8SmjYS9p8EaKgb7e2thsL3hRlbUwWJIP4u7NPL3f3Vo6NuU7iiFBmmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e1aIMOHD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1e419d203bdso1720815ad.1
        for <linux-pci@vger.kernel.org>; Sun, 07 Apr 2024 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712502056; x=1713106856; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rg5p2LyDzLnfC2w8OQRGZeAgjaf7e8DN0+jmDo2guKc=;
        b=e1aIMOHD9maELAKbu7zj0oPJLTPbZwOcnITBSv86Zdt//FwqG8sfny75OLAhlPOg62
         8BDGuy3oLaxgw0dqERGbXGg3Et2D0JDTpOAob7Xbi+A0b1OGANlBC1kTE0E4jUaTOzVG
         QjzqcpkVYVl/wF6F4gZW4H40wjT8KVZaS+bJ0gcUnY5AXb+uH7XtXKDCo9kdaH5O4aZW
         Nj9wRvsTLT+thTG++RF69s80OBFAPNS6yuZWklTMPLeeAjinZ3eQK++ilj8Vsd49BjhK
         ZniQGyZukTVidN/rU6yUlcM1BX3WsO4q8jyOe+aIG2CfIbfSHtghkbc/40eQa3sRjPxo
         8qcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712502056; x=1713106856;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rg5p2LyDzLnfC2w8OQRGZeAgjaf7e8DN0+jmDo2guKc=;
        b=JVakpTBbHB4ybyGw2VeEKiwZ7VKQRXYluF1pyHE53jP/LoMYhU4Zsarx88YU9aUU/O
         +QxkMiHG12DYG+tlbYmQgjR6XMUldihMSouqSmC6MlrO5Yt7M9KVsJxSDYcIOZmgu5My
         d9QZ3YdWc7rc9DD+5mGFvbAggBvW5YeZMfXSfO19/iFwc7xRiIBycSFDqkzV2w8kPMhk
         YW5eUrCCLAHpIpipCo4AOAAv4TaVMC3+sks8mXb5B3nvA8TLUBx64h/gmGkHLhzy8Aws
         xVojwXcG3TW9MPzSkhHabhJfM8VPVdRZKVyZscKHHsC5VdTwREc3F8DgpSoS/m4Q90tD
         4CfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZuVVCoqPAN2/hjqedephmB79QgScoCbnYkQjXCRkY4ucQkjAGKtSi9lo3qpP4b+h6Pc93IbBvLk33I1l2ZYLgi+SLiP4U8/Rh
X-Gm-Message-State: AOJu0YxiLc7/bYx63K8F1mtdEgtq/8iutFyR4eOupMm6yDBY8JX7cjFc
	/ZHBBiN4jKQunSAOssDxPJjpY4PIbn9kBgA/B9upyKZ8D++vN6/zgRYQ0qjbgAR/nipaM/0R2Vs
	=
X-Google-Smtp-Source: AGHT+IG5a4Q0fNCaOXflnu0RC6Kp/xKoadxVcTH6j2sWeqtXMM88WShKb8CSsaKhrj1rMZ9BcVhqzQ==
X-Received: by 2002:a17:903:192:b0:1e3:f012:5681 with SMTP id z18-20020a170903019200b001e3f0125681mr2004707plg.23.1712502055935;
        Sun, 07 Apr 2024 08:00:55 -0700 (PDT)
Received: from thinkpad ([120.56.192.184])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902f68500b001e2881c8de5sm5020429plg.82.2024.04.07.08.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Apr 2024 08:00:55 -0700 (PDT)
Date: Sun, 7 Apr 2024 20:30:48 +0530
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
Subject: Re: [PATCH v9 6/6] PCI: qcom: Add OPP support to scale performance
 state of power domain
Message-ID: <20240407150048.GE2679@thinkpad>
References: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
 <20240407-opp_support-v9-6-496184dc45d7@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240407-opp_support-v9-6-496184dc45d7@quicinc.com>

On Sun, Apr 07, 2024 at 10:07:39AM +0530, Krishna chaitanya chundru wrote:
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
> Different link configurations may share the same aggregate bandwidth,
> e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same bandwidth
> and share the same OPP entry.
> 

This info should be part of the dts change.

> As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
> is supported.
> 
> Before PCIe link is initialized vote for highest OPP in the OPP table,
> so that we are voting for maximum voltage corner for the link to come up
> in maximum supported speed.
> 
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  drivers/pci/controller/dwc/pcie-qcom.c | 72 +++++++++++++++++++++++++++-------
>  1 file changed, 58 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> index b4893214b2d3..4ad5ef3bf8fc 100644
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
> @@ -1442,15 +1443,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
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
> @@ -1462,10 +1461,26 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
>  	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
>  	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
>  
> -	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> -	if (ret) {
> -		dev_err(pci->dev, "failed to set interconnect bandwidth for PCIe-MEM: %d\n",
> -			ret);
> +	if (pcie->icc_mem) {
> +		ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
> +		if (ret) {
> +			dev_err(pci->dev, "failed to set interconnect bandwidth for PCIe-MEM: %d\n",

s/failed/Failed

> +				ret);
> +		}
> +	} else {
> +		mbps = pcie_link_speed_to_mbps(pcie_link_speed[speed]);
> +		if (mbps < 0)
> +			return;
> +
> +		freq = mbps * 1000;
> +		opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);

As per the API documentation, dev_pm_opp_put() should be called for both success
and failure case.

> +		if (!IS_ERR(opp)) {

So what is the action if OPP is not found for the freq?

> +			ret = dev_pm_opp_set_opp(pci->dev, opp);
> +			if (ret)
> +				dev_err(pci->dev, "Failed to set opp: freq %ld ret %d\n",

'Failed to set OPP for freq (%ld): %d'

> +					dev_pm_opp_get_freq(opp), ret);
> +			dev_pm_opp_put(opp);
> +		}
>  	}
>  }
>  
> @@ -1509,8 +1524,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
>  static int qcom_pcie_probe(struct platform_device *pdev)
>  {
>  	const struct qcom_pcie_cfg *pcie_cfg;
> +	unsigned long max_freq = INT_MAX;
>  	struct device *dev = &pdev->dev;
>  	struct qcom_pcie *pcie;
> +	struct dev_pm_opp *opp;
>  	struct dw_pcie_rp *pp;
>  	struct resource *res;
>  	struct dw_pcie *pci;
> @@ -1577,9 +1594,33 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
> +	 * Use highest OPP here if the OPP table is present. At the end of

I believe I asked you to add the information justifying why the highest OPP
should be used.

> +	 * the probe(), OPP will be updated using qcom_pcie_icc_opp_update().
> +	 */
> +	if (!ret) {
> +		opp = dev_pm_opp_find_freq_floor(dev, &max_freq);

Same comment as dev_pm_opp_find_freq_exact(). 

> +		if (!IS_ERR(opp)) {
> +			ret = dev_pm_opp_set_opp(dev, opp);
> +			if (ret)
> +				dev_err_probe(pci->dev, ret,
> +					      "Failed to set OPP: freq %ld\n",

Same comment as above.

> +					      dev_pm_opp_get_freq(opp));
> +			dev_pm_opp_put(opp);

So you want to continue even in the case of failure?

- Mani

> +		}
> +	} else {
> +		/* Skip ICC init if OPP is supported as it is handled by OPP */
> +		ret = qcom_pcie_icc_init(pcie);
> +		if (ret)
> +			goto err_pm_runtime_put;
> +	}
>  
>  	ret = pcie->cfg->ops->get_resources(pcie);
>  	if (ret)
> @@ -1599,7 +1640,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
>  		goto err_phy_exit;
>  	}
>  
> -	qcom_pcie_icc_update(pcie);
> +	qcom_pcie_icc_opp_update(pcie);
>  
>  	if (pcie->mhi)
>  		qcom_pcie_init_debugfs(pcie);
> @@ -1658,6 +1699,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
>  	if (ret)
>  		dev_err(dev, "failed to disable icc path of CPU-PCIe: %d\n", ret);
>  
> +	if (!pcie->icc_mem)
> +		dev_pm_opp_set_opp(pcie->pci->dev, NULL);
> +
>  	return ret;
>  }
>  
> @@ -1680,7 +1724,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
>  		pcie->suspended = false;
>  	}
>  
> -	qcom_pcie_icc_update(pcie);
> +	qcom_pcie_icc_opp_update(pcie);
>  
>  	return 0;
>  }
> 
> -- 
> 2.42.0
> 

-- 
மணிவண்ணன் சதாசிவம்

