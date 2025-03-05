Return-Path: <linux-pci+bounces-22942-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E60A4F6C9
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 06:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0036E3A68F7
	for <lists+linux-pci@lfdr.de>; Wed,  5 Mar 2025 05:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1A81CBEAA;
	Wed,  5 Mar 2025 05:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="grmVl+xa"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAFCB193436
	for <linux-pci@vger.kernel.org>; Wed,  5 Mar 2025 05:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741154359; cv=none; b=j37OQ2/AqpSxEqOlosSBlMB24IcdqR6Bv322T9cdoGfHPFMafNORMZplXKWkiS4YTNKIxOfChGawAEvTCktgdTKokOmKNKZHix0X9mtagkkw/pdt4g+gxUAnC4e3dI1vTrSKPQgDjCGN0x+4TkabUBZPOIovY4EzD/qA6A18mhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741154359; c=relaxed/simple;
	bh=7rLixmlIIXqk8+K9coKKUsSCgpN57KNLFA4aYhVOSkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cr5Jx86gWatmt14NDoObtYoNeHHLgx7mgNLoNH3LYdRs0yh+MRukMkpOSEe2a89joVkgkOLzW+z8PPfsRw2t7xoEhFeGvg1OO5bZ6h0wH9yJnkMrOPy8LgmLSQaUDk91NmG+TMmgf8UcvplbXrlC4ZWNwG292G6mzBwhnglw3bA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=grmVl+xa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2234e5347e2so130580745ad.1
        for <linux-pci@vger.kernel.org>; Tue, 04 Mar 2025 21:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1741154355; x=1741759155; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=plRmfwScFOt47OIZ2jjZ3EgjKALlcE07TkgC4+reH1M=;
        b=grmVl+xahdJpM9PiduDO8CbnO8FGSNxpRCHNpdGXhKF1PUBgvIqSo3YDurHirLOoYo
         NSUrZ2p25JZaE4AVMNZitWA8ZvDGLRPUpS6yxwQGInnNzP17yHHbMPz1b1+7pbnoZL9T
         4oUAgWCwQZL1eBby2478EfO482Zgmq/Aqr/ZyTyRlHq+4oDvFOr5hqE0LkHJOmNq4VWK
         96dkTWuQ0BL2bL2OgXUfO23mIEHT4i0lxjJfkonpwUBfjeLdifk1jTySvP0AMbfnRQfI
         XrkZeeFvWiNvlsna04PGcKCftoj/nEVSAEoRi7XXkpV50qqQM92WYB5VZ7yWjHMTPa9W
         Id6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741154355; x=1741759155;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=plRmfwScFOt47OIZ2jjZ3EgjKALlcE07TkgC4+reH1M=;
        b=PBxs+sjcm47DOi+VtcPC9idQKVHdNOSkN5U+3+d1rhgW9WFVzMlpeeCrdw6U2mKr4q
         LHQlm5PslwqiD+Sbl9o0o1p6vJQkkNSRLqmha34RcEcxWsUrbAaIv/7HNiGupMUqjVko
         SKpJRFa5beV8yx2XsO10cMTuCP6V1TPqHAZs2b92Dr4l4npcucyxFk/GJdw9tnISGZlL
         ZNVXQH9yNQnBdo7hjAILjQMCY2BOymShcOwUozO/p9XFtu46aactHTIuSu4emELz1yN2
         LaPCe43gfLFRFClu6AbQ7X8Rz+8HuhTWW5CAFCdaYlFVBifZfhc9TykhKgj4mKYknsdv
         Ftgg==
X-Forwarded-Encrypted: i=1; AJvYcCVjjbyIPqfW+SbCLmM204SsuEoh70xNCgPP97d9XpqjtqpG85tGh3zuq/IeZGELbH8cNMP2sspHtWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo8ajic5y8IqUuvkhqhtmBmP6RdDd4rANoRbLAzpM3Gp117uJJ
	TiwrrdoMZw04pmACDr2SSLZzTjwhYxmoOQ7l0lVzuOadrsrOIE88hDmS9XCF8g==
X-Gm-Gg: ASbGncvwylGolE35/aUH+owEz4oaL4GX0LuxSQsp2z5/ymv2Eh/U9gFCaa+/jQWVRu3
	Ai+Z842kzmu6uYTH0B1hNfpW5gOxJyigWScbjFiToCaHBNpIXCLb6Q1YO2snpytCPisIWBc4Cgb
	6jPfu03G12jcDGDry34JX13ReY/k9EbFxjItsEGTzK+hliaOH/pAdqM1LHpUBqfEW83D8Fx4Zkf
	3/iDTX6lItdHvPC6vhxa3vdiqd9HDht7yyM776Pw4F1JJLBfNm25INQNyWZUoBOxT81acweo+r0
	kYCgN624lASVl69dXlzhjSwyFICxvrxlOJtCItPIuOdEqzuwDBjahAB6
X-Google-Smtp-Source: AGHT+IHMCm1PvM4QtZ7O+C2jxAVodi0fiTMSuB9DDj7hvd24re/QfUJopOYHFxAIt5QpzCXVvX9B6g==
X-Received: by 2002:a17:902:ea10:b0:223:5ca1:3b0b with SMTP id d9443c01a7336-223f1cf326fmr36648005ad.40.1741154355016;
        Tue, 04 Mar 2025 21:59:15 -0800 (PST)
Received: from thinkpad ([120.60.140.239])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2235053b0cfsm105287545ad.254.2025.03.04.21.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 21:59:14 -0800 (PST)
Date: Wed, 5 Mar 2025 11:29:08 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Zhang Zekun <zhangzekun11@huawei.com>
Cc: songxiaowei@hisilicon.com, wangbinghui@hisilicon.com,
	lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
	bhelgaas@google.com, linux-pci@vger.kernel.org,
	ryder.lee@mediatek.com, jianjun.wang@mediatek.com,
	sergio.paracuellos@gmail.com,
	angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
	alyssa@rosenzweig.io, maz@kernel.org, thierry.reding@gmail.com,
	Jonathan.Cameron@Huawei.com
Subject: Re: [PATCH v3 6/6] PCI: tegra: Use helper function
 for_each_child_of_node_scoped()
Message-ID: <20250305055908.c4rcvzcqbijuiqc3@thinkpad>
References: <20240831040413.126417-1-zhangzekun11@huawei.com>
 <20240831040413.126417-7-zhangzekun11@huawei.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240831040413.126417-7-zhangzekun11@huawei.com>

On Sat, Aug 31, 2024 at 12:04:13PM +0800, Zhang Zekun wrote:
> for_each_child_of_node_scoped() provides a scope-based cleanup
> functionality to put the device_node automatically, and we don't need to
> call of_node_put() directly.  Let's simplify the code a bit with the use
> of these functions.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

- Mani

> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
> v2:
> - Use dev_err_probe() to simplify code.
> - Fix spelling error in commit message.
> 
> v3: Wrap the line which is too long.
> 
>  drivers/pci/controller/pci-tegra.c | 80 +++++++++++-------------------
>  1 file changed, 28 insertions(+), 52 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index d7517c3976e7..d2f29b87ffa5 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2106,47 +2106,39 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
>  static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> -	struct device_node *np = dev->of_node, *port;
> +	struct device_node *np = dev->of_node;
>  	const struct tegra_pcie_soc *soc = pcie->soc;
>  	u32 lanes = 0, mask = 0;
>  	unsigned int lane = 0;
>  	int err;
>  
>  	/* parse root ports */
> -	for_each_child_of_node(np, port) {
> +	for_each_child_of_node_scoped(np, port) {
>  		struct tegra_pcie_port *rp;
>  		unsigned int index;
>  		u32 value;
>  		char *label;
>  
>  		err = of_pci_get_devfn(port);
> -		if (err < 0) {
> -			dev_err(dev, "failed to parse address: %d\n", err);
> -			goto err_node_put;
> -		}
> +		if (err < 0)
> +			return dev_err_probe(dev, err, "failed to parse address\n");
>  
>  		index = PCI_SLOT(err);
>  
> -		if (index < 1 || index > soc->num_ports) {
> -			dev_err(dev, "invalid port number: %d\n", index);
> -			err = -EINVAL;
> -			goto err_node_put;
> -		}
> +		if (index < 1 || index > soc->num_ports)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid port number: %d\n", index);
>  
>  		index--;
>  
>  		err = of_property_read_u32(port, "nvidia,num-lanes", &value);
> -		if (err < 0) {
> -			dev_err(dev, "failed to parse # of lanes: %d\n",
> -				err);
> -			goto err_node_put;
> -		}
> +		if (err < 0)
> +			return dev_err_probe(dev, err,
> +					     "failed to parse # of lanes\n");
>  
> -		if (value > 16) {
> -			dev_err(dev, "invalid # of lanes: %u\n", value);
> -			err = -EINVAL;
> -			goto err_node_put;
> -		}
> +		if (value > 16)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "invalid # of lanes: %u\n", value);
>  
>  		lanes |= value << (index << 3);
>  
> @@ -2159,16 +2151,12 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		lane += value;
>  
>  		rp = devm_kzalloc(dev, sizeof(*rp), GFP_KERNEL);
> -		if (!rp) {
> -			err = -ENOMEM;
> -			goto err_node_put;
> -		}
> +		if (!rp)
> +			return -ENOMEM;
>  
>  		err = of_address_to_resource(port, 0, &rp->regs);
> -		if (err < 0) {
> -			dev_err(dev, "failed to parse address: %d\n", err);
> -			goto err_node_put;
> -		}
> +		if (err < 0)
> +			return dev_err_probe(dev, err, "failed to parse address\n");
>  
>  		INIT_LIST_HEAD(&rp->list);
>  		rp->index = index;
> @@ -2177,16 +2165,12 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		rp->np = port;
>  
>  		rp->base = devm_pci_remap_cfg_resource(dev, &rp->regs);
> -		if (IS_ERR(rp->base)) {
> -			err = PTR_ERR(rp->base);
> -			goto err_node_put;
> -		}
> +		if (IS_ERR(rp->base))
> +			return PTR_ERR(rp->base);
>  
>  		label = devm_kasprintf(dev, GFP_KERNEL, "pex-reset-%u", index);
> -		if (!label) {
> -			err = -ENOMEM;
> -			goto err_node_put;
> -		}
> +		if (!label)
> +			return -ENOMEM;
>  
>  		/*
>  		 * Returns -ENOENT if reset-gpios property is not populated
> @@ -2199,34 +2183,26 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  						       GPIOD_OUT_LOW,
>  						       label);
>  		if (IS_ERR(rp->reset_gpio)) {
> -			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
> +			if (PTR_ERR(rp->reset_gpio) == -ENOENT)
>  				rp->reset_gpio = NULL;
> -			} else {
> -				dev_err(dev, "failed to get reset GPIO: %ld\n",
> -					PTR_ERR(rp->reset_gpio));
> -				err = PTR_ERR(rp->reset_gpio);
> -				goto err_node_put;
> -			}
> +			else
> +				return dev_err_probe(dev, PTR_ERR(rp->reset_gpio),
> +						     "failed to get reset GPIO\n");
>  		}
>  
>  		list_add_tail(&rp->list, &pcie->ports);
>  	}
>  
>  	err = tegra_pcie_get_xbar_config(pcie, lanes, &pcie->xbar_config);
> -	if (err < 0) {
> -		dev_err(dev, "invalid lane configuration\n");
> -		return err;
> -	}
> +	if (err < 0)
> +		return dev_err_probe(dev, err,
> +				     "invalid lane configuration\n");
>  
>  	err = tegra_pcie_get_regulators(pcie, mask);
>  	if (err < 0)
>  		return err;
>  
>  	return 0;
> -
> -err_node_put:
> -	of_node_put(port);
> -	return err;
>  }
>  
>  /*
> -- 
> 2.17.1
> 

-- 
மணிவண்ணன் சதாசிவம்

