Return-Path: <linux-pci+bounces-12508-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B3EED966139
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 14:00:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F9BA1F29404
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 12:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891551917E2;
	Fri, 30 Aug 2024 12:00:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC4C1917C8
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 12:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019239; cv=none; b=GW8uplbQwaPkBTn5uYu8GA8WPNlELUIA0GvVVNB3xi1lwsunpI+65jqV2WUEB4K5Sn4TaJCKn7WsJpy2Rp0mRXtfYX0K6DxOwZbUG16lmYUaRtfqLhedgKD5F20L3zHdZxqhq+nzspTa6hjl2lHJWWPcToAku1soPoWLi7Nm7yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019239; c=relaxed/simple;
	bh=QNqxcTUVAoBGS7b8t38lIHA6LveQelB8WIb+2wkFLVY=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AHzIbYZIMtigxDkDlBa67QrIBPZYPDzVRV5kxk2STpTdH+tq9WABtNMauFHlsESpoI92dfksWvMvlLBzRBJGqPktYTx5miloSAuhRxuWiixNMsiJiRA0DEQ0MUkDzVY39X9+Z+UZz7FyLDwHgmgHlN9dz9J9dCuwB/l6JPT/M8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwGpy0fJKz6H8RD;
	Fri, 30 Aug 2024 19:57:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id 3B84C1402C7;
	Fri, 30 Aug 2024 20:00:33 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 13:00:32 +0100
Date: Fri, 30 Aug 2024 13:00:31 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
CC: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
Subject: Re: [PATCH v2 2/6] PCI: kirin: Tidy up _probe() related function
 with dev_err_probe()
Message-ID: <20240830130031.00003d08@Huawei.com>
In-Reply-To: <20240830035819.13718-3-zhangzekun11@huawei.com>
References: <20240830035819.13718-1-zhangzekun11@huawei.com>
	<20240830035819.13718-3-zhangzekun11@huawei.com>
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
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Fri, 30 Aug 2024 11:58:15 +0800
Zhang Zekun <zhangzekun11@huawei.com> wrote:

> The combination of dev_err() and the returned error code could be
> replaced by dev_err_probe() in driver's probe function. Let's,
> converting to dev_err_probe() to make code more simple.
> 
> Suggested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
There are a few unnecessarily long lines in here. I'd wrap them.
Otherwise LGTM.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 36 +++++++++----------------
>  1 file changed, 12 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index e9bda1746ca5..fc0a71575085 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -216,10 +216,8 @@ static int hi3660_pcie_phy_start(struct hi3660_pcie_phy *phy)
>  
>  	usleep_range(PIPE_CLK_WAIT_MIN, PIPE_CLK_WAIT_MAX);
>  	reg_val = kirin_apb_phy_readl(phy, PCIE_APB_PHY_STATUS0);
> -	if (reg_val & PIPE_CLK_STABLE) {
> -		dev_err(dev, "PIPE clk is not stable\n");
> -		return -EINVAL;
> -	}
> +	if (reg_val & PIPE_CLK_STABLE)
> +		return dev_err_probe(dev, -EINVAL, "PIPE clk is not stable\n");
>  
>  	return 0;
>  }
> @@ -371,10 +369,8 @@ static int kirin_pcie_get_gpio_enable(struct kirin_pcie *pcie,
>  	if (ret < 0)
>  		return 0;
>  
> -	if (ret > MAX_PCI_SLOTS) {
> -		dev_err(dev, "Too many GPIO clock requests!\n");
> -		return -EINVAL;
> -	}
> +	if (ret > MAX_PCI_SLOTS)
> +		return dev_err_probe(dev, -EINVAL, "Too many GPIO clock requests!\n");
>  
>  	pcie->n_gpio_clkreq = ret;
>  
> @@ -421,16 +417,12 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			}
>  
>  			pcie->num_slots++;
> -			if (pcie->num_slots > MAX_PCI_SLOTS) {
> -				dev_err(dev, "Too many PCI slots!\n");
> -				return -EINVAL;
> -			}
> +			if (pcie->num_slots > MAX_PCI_SLOTS)
> +				return dev_err_probe(dev, -EINVAL, "Too many PCI slots!\n");

Lines are getting a bit long, I'd wrap after -EINVAL,
Same in other cases.


>  
>  			ret = of_pci_get_devfn(child);
> -			if (ret < 0) {
> -				dev_err(dev, "failed to parse devfn: %d\n", ret);
> -				return ret;
> -			}
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret, "failed to parse devfn\n");
>  
>  			slot = PCI_SLOT(ret);
>  


