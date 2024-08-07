Return-Path: <linux-pci+bounces-11406-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C29A949DF3
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 04:54:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B8BA1C21257
	for <lists+linux-pci@lfdr.de>; Wed,  7 Aug 2024 02:54:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333411E495;
	Wed,  7 Aug 2024 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RtwXg5AH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014A848E
	for <linux-pci@vger.kernel.org>; Wed,  7 Aug 2024 02:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722999274; cv=none; b=p/L2VHm8CIPZGVJMXpRQgjGNWxBMZgMZsMipeC9aq94LhQUeA3nq6c+7638/FpVoklNXNkl9G+fCjQ3mco+uAE0AN76Rqc6RxtSaR3sUcvsPnbWeyyghP8HNp1XM/IYEowiLU1HLUfkHGbj8CtuiF5NufJHbfCNOjKNKjd1XoeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722999274; c=relaxed/simple;
	bh=UEYdL6BiqNkjuEsoZrCtybf+BkwaYQKzgsqMHJRTOJM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a+p5rtgjsw2dSI+BNyFZcq88n3RlluiPBg5KB2z6NhVt2bfLMwaVFgHZcHdu+69haMZo4riaU5SxsCGzCuDQEsGz1rBLdvRQnVEonG9C9bV8b8Bcw+ihgXCEx90kVoESkPt5VWrAt2o0G8sUr2P+l1dAmtbHDr3bg9tMTIRZkVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RtwXg5AH; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-7a1843b4cdbso1038193a12.2
        for <linux-pci@vger.kernel.org>; Tue, 06 Aug 2024 19:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1722999272; x=1723604072; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PzP6P7jRClmLKoX/zmWy4IvF4yzdI1M2oWohKmGOdlU=;
        b=RtwXg5AH5bO5c6OKs526yTgz95apYkoDX1LNan/gNYjrGCxI2F7Z4kAiPORUNkpsrz
         Uy2bEEuc+q8zMBKWjf+koEqw1GLjX4kT8bhXnLFiaRTUQ+VMXLBo3tt9tuPk/UvjBofr
         c4bp8HIeyDwZbMTV2K3ePwdUNexVaX/VSoCZdT2WhiqnKafr4ryMk18tFUQDGkMSfe6W
         6jX371INTCughS7m1OG0tR3eBdN+uE6u5G1CnplPW3ndVbxPjNYdP/LOVbPQTLdNU8RQ
         61RLMsJW+hvMKSKStDMheVGrsMGHmmthx4cmouwT+XbjbXEY9NxH1rNs7Nc3aq71+rzX
         QTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722999272; x=1723604072;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PzP6P7jRClmLKoX/zmWy4IvF4yzdI1M2oWohKmGOdlU=;
        b=m3uFANcFxG/qmhVf5sIArVqzOnTelznsWkCMMmoW2S7jirycVwUV+Vo6aIT/zP7cnI
         RFd5qWSeP0r40L7/YjE/0Zxeh35ApvjYs7eLPM4CuxyCtPGRd06SG6829tSoMu4sjHdY
         1mrtSJkA4N59GBjYXJvaV4JSxVjVe5NbGF6yFS4/DkefIANS7UwCNXbTCRhPpBrQG8jQ
         msXr+75byzL8vs3T6coCB+PX/N0vo7ejyhAb9bIT87QagCUotYvBz9pCAJ15MuIRj55Y
         097KyuXojCaIlM7xvmNZpYVmxnpIumx9Smc4jfNcTnechwbMLq/i2C90QqsBrEOtOUOo
         s/3g==
X-Gm-Message-State: AOJu0YwMP5Tovh11e909ldf7r6cTkCdDJJLON+lNAPOrb84zW19a+8Im
	5GxIcxgg2GdNxRszNxTLFR94/M07/oABl5Z5f/T2Cxb+C6dZ1viqScbZdExFZA==
X-Google-Smtp-Source: AGHT+IGDGjPoQZeMECEmhH67AI5SImkYnGCx2Jb6OA/XvWaCIb6UIZpaUoEU2T8qCZV1fYjeSaqAPA==
X-Received: by 2002:a05:6a20:d80d:b0:1c4:c305:121b with SMTP id adf61e73a8af0-1c6995aa85fmr18467603637.29.1722999271499;
        Tue, 06 Aug 2024 19:54:31 -0700 (PDT)
Received: from thinkpad ([120.60.72.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7106ec400e4sm7589256b3a.62.2024.08.06.19.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Aug 2024 19:54:31 -0700 (PDT)
Date: Wed, 7 Aug 2024 08:24:23 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Jim Quinlan <james.quinlan@broadcom.com>
Cc: linux-pci@vger.kernel.org, Nicolas Saenz Julienne <nsaenz@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Cyril Brulebois <kibi@debian.org>,
	Stanimir Varbanov <svarbanov@suse.de>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	bcm-kernel-feedback-list@broadcom.com, jim2101024@gmail.com,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-rpi-kernel@lists.infradead.org>,
	"moderated list:BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE" <linux-arm-kernel@lists.infradead.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 03/12] PCI: brcmstb: Use common error handling code in
 brcm_pcie_probe()
Message-ID: <20240807025423.GF3412@thinkpad>
References: <20240731222831.14895-1-james.quinlan@broadcom.com>
 <20240731222831.14895-4-james.quinlan@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240731222831.14895-4-james.quinlan@broadcom.com>

On Wed, Jul 31, 2024 at 06:28:17PM -0400, Jim Quinlan wrote:
> o Move the clk_prepare_enable() below the resource allocations.
> o Move the clk_prepare_enable() out of __brcm_pcie_remove() but
>   add it to the end of brcm_pcie_remove().
> o Add a jump target (clk_disable_unprepare) so that a bit of exception
>   handling can be better reused at the end of this function implementation.
> o Use dev_err_probe() where it makes sense.
> 

Thanks for using the imperative tone. It would be nice to have the patch
description as a single paragraph in a continuous manner instead of bullet
points.

- Mani

> Signed-off-by: Jim Quinlan <james.quinlan@broadcom.com>
> ---
>  drivers/pci/controller/pcie-brcmstb.c | 34 ++++++++++++---------------
>  1 file changed, 15 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-brcmstb.c b/drivers/pci/controller/pcie-brcmstb.c
> index c08683febdd4..7595e7009192 100644
> --- a/drivers/pci/controller/pcie-brcmstb.c
> +++ b/drivers/pci/controller/pcie-brcmstb.c
> @@ -1473,7 +1473,6 @@ static void __brcm_pcie_remove(struct brcm_pcie *pcie)
>  		dev_err(pcie->dev, "Could not stop phy\n");
>  	if (reset_control_rearm(pcie->rescal))
>  		dev_err(pcie->dev, "Could not rearm rescal reset\n");
> -	clk_disable_unprepare(pcie->clk);
>  }
>  
>  static void brcm_pcie_remove(struct platform_device *pdev)
> @@ -1484,6 +1483,7 @@ static void brcm_pcie_remove(struct platform_device *pdev)
>  	pci_stop_root_bus(bridge->bus);
>  	pci_remove_root_bus(bridge->bus);
>  	__brcm_pcie_remove(pcie);
> +	clk_disable_unprepare(pcie->clk);
>  }
>  
>  static const int pcie_offsets[] = {
> @@ -1613,31 +1613,26 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  	pcie->ssc = of_property_read_bool(np, "brcm,enable-ssc");
>  
> -	ret = clk_prepare_enable(pcie->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "could not enable clock\n");
> -		return ret;
> -	}
>  	pcie->rescal = devm_reset_control_get_optional_shared(&pdev->dev, "rescal");
> -	if (IS_ERR(pcie->rescal)) {
> -		clk_disable_unprepare(pcie->clk);
> +	if (IS_ERR(pcie->rescal))
>  		return PTR_ERR(pcie->rescal);
> -	}
> +
>  	pcie->perst_reset = devm_reset_control_get_optional_exclusive(&pdev->dev, "perst");
> -	if (IS_ERR(pcie->perst_reset)) {
> -		clk_disable_unprepare(pcie->clk);
> +	if (IS_ERR(pcie->perst_reset))
>  		return PTR_ERR(pcie->perst_reset);
> -	}
>  
> -	ret = reset_control_reset(pcie->rescal);
> +	ret = clk_prepare_enable(pcie->clk);
>  	if (ret)
> -		dev_err(&pdev->dev, "failed to deassert 'rescal'\n");
> +		return dev_err_probe(&pdev->dev, ret, "could not enable clock\n");
> +
> +	ret = reset_control_reset(pcie->rescal);
> +	if (dev_err_probe(&pdev->dev, ret, "failed to deassert 'rescal'\n"))
> +		goto clk_disable_unprepare;
>  
>  	ret = brcm_phy_start(pcie);
>  	if (ret) {
>  		reset_control_rearm(pcie->rescal);
> -		clk_disable_unprepare(pcie->clk);
> -		return ret;
> +		goto clk_disable_unprepare;
>  	}
>  
>  	ret = brcm_pcie_setup(pcie);
> @@ -1654,10 +1649,8 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  	msi_np = of_parse_phandle(pcie->np, "msi-parent", 0);
>  	if (pci_msi_enabled() && msi_np == pcie->np) {
>  		ret = brcm_pcie_enable_msi(pcie);
> -		if (ret) {
> -			dev_err(pcie->dev, "probe of internal MSI failed");
> +		if (dev_err_probe(pcie->dev, ret, "probe of internal MSI failed"))
>  			goto fail;
> -		}
>  	}
>  
>  	bridge->ops = pcie->type == BCM7425 ? &brcm7425_pcie_ops : &brcm_pcie_ops;
> @@ -1678,6 +1671,9 @@ static int brcm_pcie_probe(struct platform_device *pdev)
>  
>  fail:
>  	__brcm_pcie_remove(pcie);
> +clk_disable_unprepare:
> +	clk_disable_unprepare(pcie->clk);
> +
>  	return ret;
>  }
>  
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

