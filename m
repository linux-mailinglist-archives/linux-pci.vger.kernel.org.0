Return-Path: <linux-pci+bounces-6724-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 131258B44C4
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 09:23:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 330B41C20D5B
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 07:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DBC03BBD2;
	Sat, 27 Apr 2024 07:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fg/2IeCW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03E242055
	for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 07:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714202634; cv=none; b=mZdD70HbBYAc8HbpTyDvLz7cpLrWAJP9Sa/CMWmVjs6DF5GfC/knAipvq7YhvCvGgpY8WvVuzeOX4/q/9YJKlko43tX38xZTeuFAN3QO0rd82NHT6sPvbRv7L1LxsVEVbAv7OhLQlNXRzdc7cKxLjZmI+cKqZLKXdYEiliZwMa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714202634; c=relaxed/simple;
	bh=QQ9X6/B/OY5Rpbf27ZZgDjJFLbBrR5d8bJENXinX6zw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=II+XqeS/pfxnsmzXdWF/O8LuyMP5s4yMmSt1QEUhSpBrmkFwKyPm38Ka3ogj/lQU3f7Wi5cpdjrnQjYf5GyNFlc9UHalvZCWTfiueks1FMdefeSXtavACq+4k3ilFfB423uQrWY12GbPBVJW8HNj49kTqa7esXbduOkV28RtPnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fg/2IeCW; arc=none smtp.client-ip=209.85.167.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3c70a55988dso1688368b6e.0
        for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 00:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714202631; x=1714807431; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=X6/zlDycsKlLm9oMWJCj8T6cyudX5ggjd/VxiVnvZxs=;
        b=fg/2IeCWyMO/S6izUCgCQNDghhIKYjU+T6hOND0LtmyTjS8Byu2OiK4pMtEivGByOs
         r2xXmIJe/oxBCwRhLSEuapbFxR/vMymVGFlDuCW/mLscC4Qb+QKKut/+DZwezvQGB6CY
         68reJeSPKIi7flNd1LfjDl40RNIsGwkzySSaE3DYJmInQNRxFtoPwKYW8jty9XKDd1Kh
         sTzY1h7Fhly2ijIiKCEj7cBwuvxxCPvM29RDIZSYzMJ5mFTMvGKRFasJvP+SVGfzeT8w
         zrMR1ATysDxQ3dnVor8ovLWSoGtQYrbCYWT7xY77FDfAuErpQNeyEQYbN61M2z1KbWVN
         BYEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714202631; x=1714807431;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X6/zlDycsKlLm9oMWJCj8T6cyudX5ggjd/VxiVnvZxs=;
        b=Peue6dFbYPYxgvi7T7m+fd1ueqRE7D7aNOhw5DXsXX2bBnE2exxXuOYWzMg0CVhgyo
         jCEp3RAxpVWKyPDYjXp5IS0tbjzN99G6hGmLv+nHSeBJfhvbH3WbF2HnDDc26y+UqWdw
         JBIa/2HwxSEc82msw4uGzKqsgPPILKMfuK3TV3P8Ojei2qfLeE+WjZSinhgaPBWZhoAj
         MWqyng34VZ6fyHaAQWUfaVGwjKUjcpJ8dR0laRtr5mHwJYWNEUFybCzHPiFc34QGvMxu
         blHI+F0lSLiBa6FUruTH6CXbdNogMIzs4n8Hwa3PNSKZX6oWHkIc/a8J4Xy59SjHgN/w
         GKAA==
X-Forwarded-Encrypted: i=1; AJvYcCWpEw9kETEiBGx8SFEzsgfS3Vj2Yt9BQu9JfZFLAeNWB+MZm3LU3CGorBpKoy5VaKBMGPwWw8y0UAbfD1DxJrmm+GxknC091nde
X-Gm-Message-State: AOJu0YzM4KqZ2iyfyeE71kdqKD/LerdgTD6DHvVWAnACMuXG9MtW2EMN
	b9d8123V7as4vnaEPQuWbku5ozJTMhtsv/xI//e5zWqDvU5HGLrajv+bXJxJsg==
X-Google-Smtp-Source: AGHT+IHfipPHYlZH0dzUMyHUrOzKZyinCxBfDMz+pa+y5kowAJsMrQzIMhjdPr+G4bo6/Uiu7Lh6tA==
X-Received: by 2002:a05:6808:85:b0:3c7:4b27:57fb with SMTP id s5-20020a056808008500b003c74b2757fbmr5763377oic.29.1714202630707;
        Sat, 27 Apr 2024 00:23:50 -0700 (PDT)
Received: from thinkpad ([120.60.53.237])
        by smtp.gmail.com with ESMTPSA id i123-20020a639d81000000b005f7ff496050sm13702516pgd.76.2024.04.27.00.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Apr 2024 00:23:50 -0700 (PDT)
Date: Sat, 27 Apr 2024 12:53:35 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Frank Li <Frank.Li@nxp.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-omap@vger.kernel.org, linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev, linux-amlogic@lists.infradead.org,
	linux-arm-msm@vger.kernel.org, linux-tegra@vger.kernel.org,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
	Richard Zhu <hongxing.zhu@nxp.com>,
	Lucas Stach <l.stach@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>, Yue Wang <yue.wang@Amlogic.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Xiaowei Song <songxiaowei@hisilicon.com>,
	Binghui Wang <wangbinghui@hisilicon.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Subject: Re: [PATCH v2 4/4] PCI: kirin: Convert to agnostic GPIO API
Message-ID: <20240427072335.GC1981@thinkpad>
References: <20240423172208.2723892-1-andriy.shevchenko@linux.intel.com>
 <20240423172208.2723892-5-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240423172208.2723892-5-andriy.shevchenko@linux.intel.com>

On Tue, Apr 23, 2024 at 08:19:07PM +0300, Andy Shevchenko wrote:
> The of_gpio.h is going to be removed. In preparation of that convert
> the driver to the agnostic API.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 105 ++++++++----------------
>  1 file changed, 35 insertions(+), 70 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index d5523f302102..1753ab63a541 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -12,12 +12,10 @@
>  #include <linux/compiler.h>
>  #include <linux/delay.h>
>  #include <linux/err.h>
> -#include <linux/gpio.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/interrupt.h>
>  #include <linux/mfd/syscon.h>
>  #include <linux/of.h>
> -#include <linux/of_gpio.h>
>  #include <linux/of_pci.h>
>  #include <linux/phy/phy.h>
>  #include <linux/pci.h>
> @@ -78,16 +76,16 @@ struct kirin_pcie {
>  	void		*phy_priv;	/* only for PCIE_KIRIN_INTERNAL_PHY */
>  
>  	/* DWC PERST# */
> -	int		gpio_id_dwc_perst;
> +	struct gpio_desc *id_dwc_perst_gpio;
>  
>  	/* Per-slot PERST# */
>  	int		num_slots;
> -	int		gpio_id_reset[MAX_PCI_SLOTS];
> +	struct gpio_desc *id_reset_gpio[MAX_PCI_SLOTS];
>  	const char	*reset_names[MAX_PCI_SLOTS];
>  
>  	/* Per-slot clkreq */
>  	int		n_gpio_clkreq;
> -	int		gpio_id_clkreq[MAX_PCI_SLOTS];
> +	struct gpio_desc *id_clkreq_gpio[MAX_PCI_SLOTS];
>  	const char	*clkreq_names[MAX_PCI_SLOTS];
>  };
>  
> @@ -381,15 +379,20 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
>  	pcie->n_gpio_clkreq = ret;
>  
>  	for (i = 0; i < pcie->n_gpio_clkreq; i++) {
> -		pcie->gpio_id_clkreq[i] = of_get_named_gpio(dev->of_node,
> -						    "hisilicon,clken-gpios", i);
> -		if (pcie->gpio_id_clkreq[i] < 0)
> -			return pcie->gpio_id_clkreq[i];
> +		pcie->id_clkreq_gpio[i] = devm_gpiod_get_index(dev,
> +							"hisilicon,clken", i,
> +							GPIOD_ASIS);

Please don't use GPIOD_ASIS even if the old code was using it.

For all 3 GPIOs in this driver, GPIOD_OUT_LOW flag should be used as the default
state is assert (considering the fact that the DT uses GPIO_ACTIVE_HIGH).

- Mani

> +		if (IS_ERR(pcie->id_clkreq_gpio[i]))
> +			return dev_err_probe(dev, PTR_ERR(pcie->id_clkreq_gpio[i]),
> +					     "unable to get a valid clken gpio\n");
>  
>  		pcie->clkreq_names[i] = devm_kasprintf(dev, GFP_KERNEL,
>  						       "pcie_clkreq_%d", i);
>  		if (!pcie->clkreq_names[i])
>  			return -ENOMEM;
> +
> +		gpiod_set_consumer_name(pcie->id_clkreq_gpio[i],
> +					pcie->clkreq_names[i]);
>  	}
>  
>  	return 0;
> @@ -407,10 +410,16 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  		for_each_available_child_of_node(parent, child) {
>  			i = pcie->num_slots;
>  
> -			pcie->gpio_id_reset[i] = of_get_named_gpio(child,
> -							"reset-gpios", 0);
> -			if (pcie->gpio_id_reset[i] < 0)
> -				continue;
> +			pcie->id_reset_gpio[i] = devm_fwnode_gpiod_get_index(dev,
> +							 of_fwnode_handle(child),
> +							 "reset", 0, GPIOD_ASIS,
> +							 NULL);
> +			if (IS_ERR(pcie->id_reset_gpio[i])) {
> +				if (PTR_ERR(pcie->id_reset_gpio[i]) == -ENOENT)
> +					continue;
> +				return dev_err_probe(dev, PTR_ERR(pcie->id_reset_gpio[i]),
> +						     "unable to get a valid reset gpio\n");
> +			}
>  
>  			pcie->num_slots++;
>  			if (pcie->num_slots > MAX_PCI_SLOTS) {
> @@ -434,6 +443,9 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  				ret = -ENOMEM;
>  				goto put_node;
>  			}
> +
> +			gpiod_set_consumer_name(pcie->id_reset_gpio[i],
> +						pcie->reset_names[i]);
>  		}
>  	}
>  
> @@ -463,14 +475,11 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
>  		return PTR_ERR(kirin_pcie->apb);
>  
>  	/* pcie internal PERST# gpio */
> -	kirin_pcie->gpio_id_dwc_perst = of_get_named_gpio(dev->of_node,
> -							  "reset-gpios", 0);
> -	if (kirin_pcie->gpio_id_dwc_perst == -EPROBE_DEFER) {
> -		return -EPROBE_DEFER;
> -	} else if (!gpio_is_valid(kirin_pcie->gpio_id_dwc_perst)) {
> -		dev_err(dev, "unable to get a valid gpio pin\n");
> -		return -ENODEV;
> -	}
> +	kirin_pcie->id_dwc_perst_gpio = devm_gpiod_get(dev, "reset", GPIOD_ASIS);
> +	if (IS_ERR(kirin_pcie->id_dwc_perst_gpio))
> +		return dev_err_probe(dev, PTR_ERR(kirin_pcie->id_dwc_perst_gpio),
> +				     "unable to get a valid gpio pin\n");
> +	gpiod_set_consumer_name(kirin_pcie->id_dwc_perst_gpio, "pcie_perst_bridge");
>  
>  	ret = kirin_pcie_get_gpio_enable(kirin_pcie, pdev);
>  	if (ret)
> @@ -553,7 +562,7 @@ static int kirin_pcie_add_bus(struct pci_bus *bus)
>  
>  	/* Send PERST# to each slot */
>  	for (i = 0; i < kirin_pcie->num_slots; i++) {
> -		ret = gpio_direction_output(kirin_pcie->gpio_id_reset[i], 1);
> +		ret = gpiod_direction_output_raw(kirin_pcie->id_reset_gpio[i], 1);
>  		if (ret) {
>  			dev_err(pci->dev, "PERST# %s error: %d\n",
>  				kirin_pcie->reset_names[i], ret);
> @@ -623,44 +632,6 @@ static int kirin_pcie_host_init(struct dw_pcie_rp *pp)
>  	return 0;
>  }
>  
> -static int kirin_pcie_gpio_request(struct kirin_pcie *kirin_pcie,
> -				   struct device *dev)
> -{
> -	int ret, i;
> -
> -	for (i = 0; i < kirin_pcie->num_slots; i++) {
> -		if (!gpio_is_valid(kirin_pcie->gpio_id_reset[i])) {
> -			dev_err(dev, "unable to get a valid %s gpio\n",
> -				kirin_pcie->reset_names[i]);
> -			return -ENODEV;
> -		}
> -
> -		ret = devm_gpio_request(dev, kirin_pcie->gpio_id_reset[i],
> -					kirin_pcie->reset_names[i]);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++) {
> -		if (!gpio_is_valid(kirin_pcie->gpio_id_clkreq[i])) {
> -			dev_err(dev, "unable to get a valid %s gpio\n",
> -				kirin_pcie->clkreq_names[i]);
> -			return -ENODEV;
> -		}
> -
> -		ret = devm_gpio_request(dev, kirin_pcie->gpio_id_clkreq[i],
> -					kirin_pcie->clkreq_names[i]);
> -		if (ret)
> -			return ret;
> -
> -		ret = gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 0);
> -		if (ret)
> -			return ret;
> -	}
> -
> -	return 0;
> -}
> -
>  static const struct dw_pcie_ops kirin_dw_pcie_ops = {
>  	.read_dbi = kirin_pcie_read_dbi,
>  	.write_dbi = kirin_pcie_write_dbi,
> @@ -680,7 +651,7 @@ static int kirin_pcie_power_off(struct kirin_pcie *kirin_pcie)
>  		return hi3660_pcie_phy_power_off(kirin_pcie);
>  
>  	for (i = 0; i < kirin_pcie->n_gpio_clkreq; i++)
> -		gpio_direction_output(kirin_pcie->gpio_id_clkreq[i], 1);
> +		gpiod_direction_output_raw(kirin_pcie->id_clkreq_gpio[i], 1);
>  
>  	phy_power_off(kirin_pcie->phy);
>  	phy_exit(kirin_pcie->phy);
> @@ -707,10 +678,6 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
>  		if (IS_ERR(kirin_pcie->phy))
>  			return PTR_ERR(kirin_pcie->phy);
>  
> -		ret = kirin_pcie_gpio_request(kirin_pcie, dev);
> -		if (ret)
> -			return ret;
> -
>  		ret = phy_init(kirin_pcie->phy);
>  		if (ret)
>  			goto err;
> @@ -723,11 +690,9 @@ static int kirin_pcie_power_on(struct platform_device *pdev,
>  	/* perst assert Endpoint */
>  	usleep_range(REF_2_PERST_MIN, REF_2_PERST_MAX);
>  
> -	if (!gpio_request(kirin_pcie->gpio_id_dwc_perst, "pcie_perst_bridge")) {
> -		ret = gpio_direction_output(kirin_pcie->gpio_id_dwc_perst, 1);
> -		if (ret)
> -			goto err;
> -	}
> +	ret = gpiod_direction_output_raw(kirin_pcie->id_dwc_perst_gpio, 1);
> +	if (ret)
> +		goto err;
>  
>  	usleep_range(PERST_2_ACCESS_MIN, PERST_2_ACCESS_MAX);
>  
> -- 
> 2.43.0.rc1.1336.g36b5255a03ac
> 

-- 
மணிவண்ணன் சதாசிவம்

