Return-Path: <linux-pci+bounces-12339-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D4A9626B4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 14:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77C58B22717
	for <lists+linux-pci@lfdr.de>; Wed, 28 Aug 2024 12:16:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65EA81741C3;
	Wed, 28 Aug 2024 12:16:24 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C53117333A
	for <linux-pci@vger.kernel.org>; Wed, 28 Aug 2024 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724847384; cv=none; b=Bx3tZhIvs4Rz4NlcURXhSGpG1CL/vj+tr2wUTi7+7NZHcpfviSeHA84P166iHkwO6yWzkkV7emT/b4Go5c/ELwq0Ui6ro598Lcr4lTZQrht2ni48eGCwNtIxbJRSVZtKSGuc7EacvW1JVAwpzpRztufxeF8sKV+x3JpXK6ASv9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724847384; c=relaxed/simple;
	bh=wAx9R3gxFMOpfLXE/a/TKBp7t6TxmXpA7+X4cwqrMK0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EUKfL58lZ7euLp3uME5EyDbS/OHl60gdL+YSYI+vBk8jRK2vttpzFMpAQT3R1k1I8mdTFlH19BnYHyHlOzSWsGDjUbp4LeWl/9WhRrlCKCojoSQtF/ewA/GfYTy8jkHfjc1FMVHMFS1kDvIfR8po6Ve+tq1GtjmO6J9gU1WLmeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Wv3G66Byzz6J7x3;
	Wed, 28 Aug 2024 20:13:02 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 746A01400D4;
	Wed, 28 Aug 2024 20:16:19 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 28 Aug
 2024 13:16:18 +0100
Date: Wed, 28 Aug 2024 13:16:17 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
CC: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
Subject: Re: [PATCH 2/5] PCI: mediatek: Use helper function
 for_each_available_child_of_node_scoped()
Message-ID: <20240828131617.00006c68@Huawei.com>
In-Reply-To: <20240828073825.43072-3-zhangzekun11@huawei.com>
References: <20240828073825.43072-1-zhangzekun11@huawei.com>
	<20240828073825.43072-3-zhangzekun11@huawei.com>
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

On Wed, 28 Aug 2024 15:38:22 +0800
Zhang Zekun <zhangzekun11@huawei.com> wrote:

> for_each_available_child_of_node_scoped() provides a scope-based cleanup
> functinality to put the device_node automatically, and we don't need to
> call of_node_put() directly.  Let's simplify the code a bit with the use
> of these functions.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
A nice to have inline.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/controller/pcie-mediatek.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/controller/pcie-mediatek.c b/drivers/pci/controller/pcie-mediatek.c
> index 9be3cebd862e..d14e8d151c08 100644
> --- a/drivers/pci/controller/pcie-mediatek.c
> +++ b/drivers/pci/controller/pcie-mediatek.c
> @@ -1042,24 +1042,24 @@ static int mtk_pcie_subsys_powerup(struct mtk_pcie *pcie)
>  static int mtk_pcie_setup(struct mtk_pcie *pcie)
>  {
>  	struct device *dev = pcie->dev;
> -	struct device_node *node = dev->of_node, *child;
> +	struct device_node *node = dev->of_node;
>  	struct mtk_pcie_port *port, *tmp;
>  	int err, slot;
>  
>  	slot = of_get_pci_domain_nr(dev->of_node);
>  	if (slot < 0) {
> -		for_each_available_child_of_node(node, child) {
> +		for_each_available_child_of_node_scoped(node, child) {
>  			err = of_pci_get_devfn(child);
>  			if (err < 0) {
>  				dev_err(dev, "failed to get devfn: %d\n", err);
> -				goto error_put_node;
> +				return err;

Could do			return dev_err_probe(dev, err, "failed to get devfn\n");

>  			}
>  
>  			slot = PCI_SLOT(err);
>  
>  			err = mtk_pcie_parse_port(pcie, child, slot);
>  			if (err)
> -				goto error_put_node;
> +				return err;
>  		}
>  	} else {
>  		err = mtk_pcie_parse_port(pcie, node, slot);
> @@ -1080,9 +1080,6 @@ static int mtk_pcie_setup(struct mtk_pcie *pcie)
>  		mtk_pcie_subsys_powerdown(pcie);
>  
>  	return 0;
> -error_put_node:
> -	of_node_put(child);
> -	return err;
>  }
>  
>  static int mtk_pcie_probe(struct platform_device *pdev)


