Return-Path: <linux-pci+bounces-12340-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A6F49626B7
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 14:17:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E8ED1C20F7E
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 12:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915B416BE1A;
	Wed, 28 Aug 2024 12:17:35 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACE1C15958D
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 12:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847455; cv=none; b=OUFYR+xK+A9xpJLR2vmzUDa5byCmA2utNNIN8CzQHonZJjIbaGB6hzx0pJ+EzdrzlDw2HfiZszPmE9QRBYPaQNdU1tRJiNhwdp+nT91FDhtb+uN5+ktHuypZn0G15rzLH4rrEcWa8vu1dXtHLmKZWgtPJephWPEGiiUXjen3q48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847455; c=relaxed/simple;
	bh=LXnaLewMxPNZnvF0gMKlBV6N4XWcbxbz5kRn+vNnB9g=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pr/1fWd/5gtPTwwi9KqQDqVaA3rTZCV7Qe3jiUDis/NPTFQfqhulXa3SmC30EEBcCPjfzd/5FYxa2wKcFFIaub+ghxp9+p7rEw3kajK5zg2ZdJQSpUQjeP2oEoWeBzytxcPkscsnJAxp4Z2aa6oHfNLX0S+GbehRwwOzhRFqE4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv3HS5cvzz6K9X2;
	Wed, 28 Aug 2024 20:14:12 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 07D95140B39;
	Wed, 28 Aug 2024 20:17:31 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 13:17:30 +0100
Date: Wed, 28 Aug 2024 13:17:29 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
CC: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
Subject: Re: [PATCH 3/5] PCI: mt7621: Use helper function
 for_each_available_child_of_node_scoped()
Message-ID: <20240828131729.00006ff1@Huawei.com>
In-Reply-To: <20240828073825.43072-4-zhangzekun11@huawei.com>
References: <20240828073825.43072-1-zhangzekun11@huawei.com>
	<20240828073825.43072-4-zhangzekun11@huawei.com>
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

On Wed, 28 Aug 2024 15:38:23 +0800
Zhang Zekun <zhangzekun11@huawei.com> wrote:

> for_each_available_child_of_node_scoped() provides a scope-based cleanup
> functinality to put the device_node automatically, and we don't need to
> call of_node_put() directly.  Let's simplify the code a bit with the use
> of these functions.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Another case in here where return dev_err_probe()
would be nice, but looks good to me either way.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>  drivers/pci/controller/pcie-mt7621.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mt7621.c b/drivers/pci/controller/pcie-mt7621.c
> index 9b4754a45515..16c3df1c49a1 100644
> --- a/drivers/pci/controller/pcie-mt7621.c
> +++ b/drivers/pci/controller/pcie-mt7621.c
> @@ -258,19 +258,18 @@ static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
>  	struct platform_device *pdev = to_platform_device(dev);
> -	struct device_node *node = dev->of_node, *child;
> +	struct device_node *node = dev->of_node;
>  	int err;
>  
>  	pcie->base = devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(pcie->base))
>  		return PTR_ERR(pcie->base);
>  
> -	for_each_available_child_of_node(node, child) {
> +	for_each_available_child_of_node_scoped(node, child) {
>  		int slot;
>  
>  		err = of_pci_get_devfn(child);
>  		if (err < 0) {
> -			of_node_put(child);
>  			dev_err(dev, "failed to parse devfn: %d\n", err);
>  			return err;
>  		}
> @@ -278,10 +277,8 @@ static int mt7621_pcie_parse_dt(struct mt7621_pcie *pcie)
>  		slot = PCI_SLOT(err);
>  
>  		err = mt7621_pcie_parse_port(pcie, child, slot);
> -		if (err) {
> -			of_node_put(child);
> +		if (err)
>  			return err;
> -		}
>  	}
>  
>  	return 0;


