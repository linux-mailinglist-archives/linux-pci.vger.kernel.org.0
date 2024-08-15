Return-Path: <linux-pci+bounces-11703-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7ABB953805
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 18:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56AC4283062
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2024 16:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32971B4C4B;
	Thu, 15 Aug 2024 16:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qwh/aNku"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A1E1B1512
	for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 16:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723738305; cv=none; b=S3bFO4sX20gdJKtZA/ACGZuM6a1uab7yo/wWriDWdym2on8vy2zpLgKHx2UqAHgAM9O9iP45+F+s0qUkL/fokTIpJrRLHJGEx0eSkiZRVSZ83TEG1FJHMNaSa8bG/cMz/7Fk6mi+gaXNcG5N2VV+ygEhdzZzfDSIylyDF/qj5nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723738305; c=relaxed/simple;
	bh=a/d5o7w1YHGxPHc0Y6eK51j4AlXYmUiU6+imhFjLJCY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PfHl+hrl5yuyVrcIg7snPSnnu5MfILLoaAiQOdX+vCnl1xTldzGzVB6GV7otoJdKagem42o/cNqMLpIfoanOA1O+msokcOi1GruTg7cYZwZM+atnzWCrRB/nEXxirD4DeUnMuzSgkiwf0jWXn7HrQ24PpDSCDLd7qAOyMW+THGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Qwh/aNku; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1fc611a0f8cso9578155ad.2
        for <linux-pci@vger.kernel.org>; Thu, 15 Aug 2024 09:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1723738304; x=1724343104; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=CmmKXkTSfv18XXqIwjwObV4hYMFSw68a2uGYhpp3xv8=;
        b=Qwh/aNkuzW4K1VUIshNqcJR/eIrQFnShciA4+nMRpn/2lSu1gG0OXjHqwvmw0w6L6P
         aYKhSragYPpYuskLAhEAI0FoaQ3e9XBlqMyHRAMdL4o9eIWpWt6GEBen7dD/2uuCWQF7
         EeuY27dgy5i0ls4fQxhmlgwCs5TFpird/mjyr6zm0w3NVFYboAupByCeNEdsbMfm/gPc
         OczRmVN2p0iz9m4Ui+QfJvBH41vK5t7/rGjUwwaY9TskH5XlUt4+F26Hp/fOEMZod3pR
         dlPnb94lf8ywO66PTkg20kQh2QjmO+o23UBUbX/zHrEo7jwxybz6HC12BgKxWKXdRlr8
         wDBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723738304; x=1724343104;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CmmKXkTSfv18XXqIwjwObV4hYMFSw68a2uGYhpp3xv8=;
        b=AyWa8tGBVQ2ftombg5mRakeh9H+9lrEgFjk8KjSLFpTTR/yesu80DXHD/dDcDQmTYo
         J/Q2U9hjRHGhkGO1FGWJ2dTvj2gXCcNGUH3i4/ny/hIbB846RFYDRjzfodTYwcxFnVLu
         RtGGqVRDa2Bl7G5j54H0IFWCwWMYn90mKufsbt4WexnnC3Hk/CFiFrJoBv5XfVQkRBtO
         GoVzRjMC7c1CtiDFiHMkU87mMoi408vdjrlrMoBKfHAHcgsdfBCkJDI69HpVYP72jWyT
         7kJPjvdhpFJbvbMG7wXNm/OXMDxLnsnpL7c/x+M87jGnfxZw1aeEZubfABNZn2xYZUBr
         6oBA==
X-Forwarded-Encrypted: i=1; AJvYcCVbC6mFJ9TVGSwpr5EWrPPkIXQSpH8jFz5Y/TKDxFlyPlb5GM5BYSSh+FMEmrpj8INXixXiV0dxdWlvvk1yySfEsqRDjCAUrYdV
X-Gm-Message-State: AOJu0Ywn2NNasLzXpmsGVpLl19TPDKNoXLTjoNjvQa7lm4OQzumQXurM
	6tvFFJ6JsZJ7Tx+MeI/nY2inK+YSsmfNBV49LqG2dHBfEnfahMLxvG9Uq1b1hg==
X-Google-Smtp-Source: AGHT+IFWxtcnnpbdF8+JXG5md4tBLoccbcE0fgAMYurHfaOl3NuWiXENoKAxePhmU3RYvALN5cfWow==
X-Received: by 2002:a17:902:f686:b0:1fd:5eab:8c76 with SMTP id d9443c01a7336-20203f27db9mr1496955ad.41.1723738303576;
        Thu, 15 Aug 2024 09:11:43 -0700 (PDT)
Received: from thinkpad ([36.255.17.34])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f1c88834sm10573375ad.255.2024.08.15.09.11.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Aug 2024 09:11:43 -0700 (PDT)
Date: Thu, 15 Aug 2024 21:41:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Anand Moon <linux.amoon@gmail.com>
Cc: Shawn Lin <shawn.lin@rock-chips.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Heiko Stuebner <heiko@sntech.de>, linux-pci@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/3] PCI: rockchip: Simplify clock handling by using
 clk_bulk*() function
Message-ID: <20240815161135.GE2562@thinkpad>
References: <20240625104039.48311-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240625104039.48311-1-linux.amoon@gmail.com>

On Tue, Jun 25, 2024 at 04:10:32PM +0530, Anand Moon wrote:
> Refactor the clock handling in the Rockchip PCIe driver,
> introducing a more robust and efficient method for enabling and
> disabling clocks using clk_bulk*() API. Using the clk_bulk APIs,
> the clock handling for the core clocks becomes much simpler.
> 

Why can't you just use devm_clk_bulk_get_all()? This gets rid of hardcoding the
clock names in driver.

- Mani

> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> ---
> v4: use dev_err_probe for error patch.
> v3: Fix typo in commit message, dropped reported by.
> v2: Fix compilation error reported by Intel test robot.
> ---
>  drivers/pci/controller/pcie-rockchip.c | 68 ++++----------------------
>  drivers/pci/controller/pcie-rockchip.h | 15 ++++--
>  2 files changed, 21 insertions(+), 62 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-rockchip.c b/drivers/pci/controller/pcie-rockchip.c
> index 0ef2e622d36e..804135511528 100644
> --- a/drivers/pci/controller/pcie-rockchip.c
> +++ b/drivers/pci/controller/pcie-rockchip.c
> @@ -30,7 +30,7 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  	struct platform_device *pdev = to_platform_device(dev);
>  	struct device_node *node = dev->of_node;
>  	struct resource *regs;
> -	int err;
> +	int err, i;
>  
>  	if (rockchip->is_rc) {
>  		regs = platform_get_resource_byname(pdev,
> @@ -127,29 +127,12 @@ int rockchip_pcie_parse_dt(struct rockchip_pcie *rockchip)
>  					     "failed to get ep GPIO\n");
>  	}
>  
> -	rockchip->aclk_pcie = devm_clk_get(dev, "aclk");
> -	if (IS_ERR(rockchip->aclk_pcie)) {
> -		dev_err(dev, "aclk clock not found\n");
> -		return PTR_ERR(rockchip->aclk_pcie);
> -	}
> -
> -	rockchip->aclk_perf_pcie = devm_clk_get(dev, "aclk-perf");
> -	if (IS_ERR(rockchip->aclk_perf_pcie)) {
> -		dev_err(dev, "aclk_perf clock not found\n");
> -		return PTR_ERR(rockchip->aclk_perf_pcie);
> -	}
> -
> -	rockchip->hclk_pcie = devm_clk_get(dev, "hclk");
> -	if (IS_ERR(rockchip->hclk_pcie)) {
> -		dev_err(dev, "hclk clock not found\n");
> -		return PTR_ERR(rockchip->hclk_pcie);
> -	}
> +	for (i = 0; i < ROCKCHIP_NUM_CLKS; i++)
> +		rockchip->clks[i].id = rockchip_pci_clks[i];
>  
> -	rockchip->clk_pcie_pm = devm_clk_get(dev, "pm");
> -	if (IS_ERR(rockchip->clk_pcie_pm)) {
> -		dev_err(dev, "pm clock not found\n");
> -		return PTR_ERR(rockchip->clk_pcie_pm);
> -	}
> +	err = devm_clk_bulk_get(dev, ROCKCHIP_NUM_CLKS, rockchip->clks);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to get clocks\n");
>  
>  	return 0;
>  }
> @@ -372,39 +355,11 @@ int rockchip_pcie_enable_clocks(struct rockchip_pcie *rockchip)
>  	struct device *dev = rockchip->dev;
>  	int err;
>  
> -	err = clk_prepare_enable(rockchip->aclk_pcie);
> -	if (err) {
> -		dev_err(dev, "unable to enable aclk_pcie clock\n");
> -		return err;
> -	}
> -
> -	err = clk_prepare_enable(rockchip->aclk_perf_pcie);
> -	if (err) {
> -		dev_err(dev, "unable to enable aclk_perf_pcie clock\n");
> -		goto err_aclk_perf_pcie;
> -	}
> -
> -	err = clk_prepare_enable(rockchip->hclk_pcie);
> -	if (err) {
> -		dev_err(dev, "unable to enable hclk_pcie clock\n");
> -		goto err_hclk_pcie;
> -	}
> -
> -	err = clk_prepare_enable(rockchip->clk_pcie_pm);
> -	if (err) {
> -		dev_err(dev, "unable to enable clk_pcie_pm clock\n");
> -		goto err_clk_pcie_pm;
> -	}
> +	err = clk_bulk_prepare_enable(ROCKCHIP_NUM_CLKS, rockchip->clks);
> +	if (err)
> +		return dev_err_probe(dev, err, "failed to enable clocks\n");
>  
>  	return 0;
> -
> -err_clk_pcie_pm:
> -	clk_disable_unprepare(rockchip->hclk_pcie);
> -err_hclk_pcie:
> -	clk_disable_unprepare(rockchip->aclk_perf_pcie);
> -err_aclk_perf_pcie:
> -	clk_disable_unprepare(rockchip->aclk_pcie);
> -	return err;
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_enable_clocks);
>  
> @@ -412,10 +367,7 @@ void rockchip_pcie_disable_clocks(void *data)
>  {
>  	struct rockchip_pcie *rockchip = data;
>  
> -	clk_disable_unprepare(rockchip->clk_pcie_pm);
> -	clk_disable_unprepare(rockchip->hclk_pcie);
> -	clk_disable_unprepare(rockchip->aclk_perf_pcie);
> -	clk_disable_unprepare(rockchip->aclk_pcie);
> +	clk_bulk_disable_unprepare(ROCKCHIP_NUM_CLKS, rockchip->clks);
>  }
>  EXPORT_SYMBOL_GPL(rockchip_pcie_disable_clocks);
>  
> diff --git a/drivers/pci/controller/pcie-rockchip.h b/drivers/pci/controller/pcie-rockchip.h
> index 6111de35f84c..72346e17e45e 100644
> --- a/drivers/pci/controller/pcie-rockchip.h
> +++ b/drivers/pci/controller/pcie-rockchip.h
> @@ -11,6 +11,7 @@
>  #ifndef _PCIE_ROCKCHIP_H
>  #define _PCIE_ROCKCHIP_H
>  
> +#include <linux/clk.h>
>  #include <linux/kernel.h>
>  #include <linux/pci.h>
>  #include <linux/pci-ecam.h>
> @@ -287,6 +288,15 @@
>  		(((c) << ((b) * 8 + 5)) & \
>  		 ROCKCHIP_PCIE_CORE_EP_FUNC_BAR_CFG_BAR_CTRL_MASK(b))
>  
> +#define ROCKCHIP_NUM_CLKS	ARRAY_SIZE(rockchip_pci_clks)
> +
> +static const char * const rockchip_pci_clks[] = {
> +	"aclk",
> +	"aclk-perf",
> +	"hclk",
> +	"pm",
> +};
> +
>  struct rockchip_pcie {
>  	void	__iomem *reg_base;		/* DT axi-base */
>  	void	__iomem *apb_base;		/* DT apb-base */
> @@ -299,10 +309,7 @@ struct rockchip_pcie {
>  	struct	reset_control *pm_rst;
>  	struct	reset_control *aclk_rst;
>  	struct	reset_control *pclk_rst;
> -	struct	clk *aclk_pcie;
> -	struct	clk *aclk_perf_pcie;
> -	struct	clk *hclk_pcie;
> -	struct	clk *clk_pcie_pm;
> +	struct  clk_bulk_data clks[ROCKCHIP_NUM_CLKS];
>  	struct	regulator *vpcie12v; /* 12V power supply */
>  	struct	regulator *vpcie3v3; /* 3.3V power supply */
>  	struct	regulator *vpcie1v8; /* 1.8V power supply */
> 
> base-commit: 35bb670d65fc0f80c62383ab4f2544cec85ac57a
> -- 
> 2.44.0
> 
> 

-- 
மணிவண்ணன் சதாசிவம்

