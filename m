Return-Path: <linux-pci+bounces-12338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83DD9962698
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 14:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3A8B21CB6
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 12:11:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9F3515B968;
	Wed, 28 Aug 2024 12:11:23 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D000D15B119
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 12:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847083; cv=none; b=YgV174qo8GSJe06kIa+VlagJX5x1P8K8jMrA6LJ8pwVpWQhcPg0MQyl/O4CB7Ehgxspp2mxlJBSo8sc2J6hqKSDM6c1xIyxtVq2EFuRxcWvHkp+EqwrrJf5fwBMkRgB3QJJGx4AXoAKVwHB+7jDqmBncZbPhQeMgLl9O4DkSNes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847083; c=relaxed/simple;
	bh=6yfRnQKoWjXYE7G5tvQWIR2K/dMxe5WgfvAnD/e441Q=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=alOxP6seh2P1JxC0lz01qpg6ozlorFzKi0RNt7anLcnF0tyDx22bKmRJD2zVLTtG5YQMqVv7PCepZJjE1ctmxCoVT3RppdkFPGewHZtFTllN0a502NMqRfMyzx/KWCDd4T4M6kahDeAxz1KR4A7ly7+8tLYIPOmoUfRoOY1owis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv38L6Z6kz6J7ry;
	Wed, 28 Aug 2024 20:08:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 1F1941400D4;
	Wed, 28 Aug 2024 20:11:19 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 13:11:18 +0100
Date: Wed, 28 Aug 2024 13:11:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
CC: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
Subject: Re: [PATCH 1/5] PCI: kirin: Use helper function
 for_each_available_child_of_node_scoped()
Message-ID: <20240828131117.00004d1b@Huawei.com>
In-Reply-To: <20240828073825.43072-2-zhangzekun11@huawei.com>
References: <20240828073825.43072-1-zhangzekun11@huawei.com>
	<20240828073825.43072-2-zhangzekun11@huawei.com>
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

On Wed, 28 Aug 2024 15:38:21 +0800
Zhang Zekun <zhangzekun11@huawei.com> wrote:

> for_each_available_child_of_node_scoped() provides a scope-based cleanup
> functinality to put the device_node automatically, and we don't need to
> call of_node_put() directly.  Let's simplify the code a bit with the use
> of these functions.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
Hi.

Looks good.  A passing comment on another ugly bit of code in his
function that you could tidy up whilst here.

For what you have covered
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index 0a29136491b8..e9bda1746ca5 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -452,7 +452,7 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
>  				    struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *child, *node = dev->of_node;
> +	struct device_node *node = dev->of_node;
>  	void __iomem *apb_base;
>  	int ret;
>  
> @@ -477,17 +477,13 @@ static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
>  		return ret;
>  
Looking at this function I don't suppose you fancy also tidying up the oddity of:
	kirin_pcie->gpio_id_dwc_perst = of_get_named_gpio(dev->of_node,
							  "reset-gpios", 0);
	if (kirin_pcie->gpio_id_dwc_perst == -EPROBE_DEFER) {
		return -EPROBE_DEFER;
	} else if (!gpio_is_valid(kirin_pcie->gpio_id_dwc_perst)) {
		dev_err(dev, "unable to get a valid gpio pin\n");
		return -ENODEV;
	}

Where that else adds nothing and it could just be
	ret = of_get_named_gpio(dev->of_node, "reset-gpios", 0);
	if (ret < 0)
		return dev_err_probe(dev, ret,
				     "unable to get a valid gpio pin\n2);

	kirin_pcie->gpio_id_dwc_perst = ret;

or even update the gpio handling in general to use non deprecated
functions.

>  	/* Parse OF children */
> -	for_each_available_child_of_node(node, child) {
> +	for_each_available_child_of_node_scoped(node, child) {
>  		ret = kirin_pcie_parse_port(kirin_pcie, pdev, child);
>  		if (ret)
> -			goto put_node;
> +			return ret;
>  	}
>  
>  	return 0;
> -
> -put_node:
> -	of_node_put(child);
> -	return ret;
>  }
>  
>  static void kirin_pcie_sideband_dbi_w_mode(struct kirin_pcie *kirin_pcie,


