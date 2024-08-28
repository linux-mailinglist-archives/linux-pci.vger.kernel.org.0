Return-Path: <linux-pci+bounces-12342-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA369626D7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 14:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E2E1F2376A
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 12:22:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D27B115E5B5;
	Wed, 28 Aug 2024 12:22:01 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FF2516F0C3
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 12:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847721; cv=none; b=o6vf6muefqRgRz3yGD4NLr0nUJ7ajt5pnf8FT8yxlRTQaLyppi6VcNpmTVfZXVF5aDft2mtRaSMtmEWMlz8P0DW43VtXSsvFYCLn16+gx+ogumy/8ZvIPLnM/hLf0v5nwANFz4gdPCz1NgWVLbV0oYIcqRwpBqKn637Aea0N120=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847721; c=relaxed/simple;
	bh=ezsk9SbxeviCYqsXSfBruyxUtn/l7vYQXb834tnh8g8=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rdFOz6m+uS+5BBJffbXYQLciJU3J1HTum18bUHzlqeX3n+qCECcB9WDwAa6HOi5EXdAPaz3jcqFOyBxeiJ/y4mcj+ubXzccrRmZisRMNIR0o0jYh9f83JK5aGlR8x6Cbw/qygJu+dtIwdxuE/v1l2Cc9CqRNJURdhqwFI2MP+Y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv3Nc2Xfdz6J7pP;
	Wed, 28 Aug 2024 20:18:40 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 8D56C140B39;
	Wed, 28 Aug 2024 20:21:56 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 13:21:56 +0100
Date: Wed, 28 Aug 2024 13:21:55 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
CC: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
Subject: Re: [PATCH 5/5] PCI: tegra: Use helper function
 for_each_child_of_node_scoped()
Message-ID: <20240828132155.000033fc@Huawei.com>
In-Reply-To: <20240828073825.43072-6-zhangzekun11@huawei.com>
References: <20240828073825.43072-1-zhangzekun11@huawei.com>
	<20240828073825.43072-6-zhangzekun11@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Wed, 28 Aug 2024 15:38:25 +0800
Zhang Zekun <zhangzekun11@huawei.com> wrote:

> for_each_child_of_node_scoped() provides a scope-based cleanup
> functinality to put the device_node automatically, and we don't need to
> call of_node_put() directly.  Let's simplify the code a bit with the use
> of these functions.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
This one will heavily benefit from dev_err_probe()
So I'd strongly suggest using that throughout this function.

Jonathan

> ---
>  drivers/pci/controller/pci-tegra.c | 41 ++++++++++--------------------
>  1 file changed, 14 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index d7517c3976e7..f1214b3374da 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2106,14 +2106,14 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
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
> @@ -2122,15 +2122,14 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		err = of_pci_get_devfn(port);
>  		if (err < 0) {
>  			dev_err(dev, "failed to parse address: %d\n", err);
> -			goto err_node_put;
> +			return err;
>  		}
>  
>  		index = PCI_SLOT(err);
>  
>  		if (index < 1 || index > soc->num_ports) {
>  			dev_err(dev, "invalid port number: %d\n", index);
> -			err = -EINVAL;
> -			goto err_node_put;
> +			return -EINVAL;
>  		}
>  
>  		index--;
> @@ -2139,13 +2138,12 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		if (err < 0) {
>  			dev_err(dev, "failed to parse # of lanes: %d\n",
>  				err);
> -			goto err_node_put;
> +			return err;
>  		}
>  
>  		if (value > 16) {
>  			dev_err(dev, "invalid # of lanes: %u\n", value);
> -			err = -EINVAL;
> -			goto err_node_put;
> +			return -EINVAL;
>  		}
>  
>  		lanes |= value << (index << 3);
> @@ -2159,15 +2157,13 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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
>  		if (err < 0) {
>  			dev_err(dev, "failed to parse address: %d\n", err);
> -			goto err_node_put;
> +			return err;
>  		}
>  
>  		INIT_LIST_HEAD(&rp->list);
> @@ -2177,16 +2173,12 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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
> @@ -2204,8 +2196,7 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  			} else {
>  				dev_err(dev, "failed to get reset GPIO: %ld\n",
>  					PTR_ERR(rp->reset_gpio));
> -				err = PTR_ERR(rp->reset_gpio);
> -				goto err_node_put;
> +				return PTR_ERR(rp->reset_gpio);
>  			}
>  		}
>  
> @@ -2223,10 +2214,6 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
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


