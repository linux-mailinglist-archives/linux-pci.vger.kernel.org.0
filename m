Return-Path: <linux-pci+bounces-12509-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AC213966144
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 14:03:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D19731C22B99
	for <lists+linux-pci@lfdr.de>; Fri, 30 Aug 2024 12:03:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20014196D9D;
	Fri, 30 Aug 2024 12:03:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425A41917C8
	for <linux-pci@vger.kernel.org>; Fri, 30 Aug 2024 12:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725019421; cv=none; b=igNFptrngcd0HBcHk5Aj3pKm01NFOGk6pkLJj6HkA9Yy7aN6mQQ/yMx2A8ylhRZTgzr9tZAwSjtU/mZOvTibbCvpEqmFfQUNzpT0kxUELvLpAafrXQL5CuzWEo32d4uTU/TZQogFb9pndpBfDiIVAadhioL3z3MLx5iBrzImQ+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725019421; c=relaxed/simple;
	bh=9kLz4fHjrw57nY7sMrFjvDhL5yhnRvr1bt2rC8aJjeE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MaeakhtVbIn+I7sQkaXixyIKWGRw63pZGPBT4HZNqN7ayy8CIOqzllkd/wTlVAR9IMmYo82WrdLMg8Ah93pV9h4sErKo7bb+vZ8KqG38lGCLIeRhNkiv07gVNGsVVBSR5+lAHOSu1SoduE+PG5yw/iuDkPmDfiw5Aytrq/MMUWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WwGtM5Skwz6K5m3;
	Fri, 30 Aug 2024 20:00:11 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id A62321402C7;
	Fri, 30 Aug 2024 20:03:35 +0800 (CST)
Received: from localhost (10.203.177.66) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 30 Aug
 2024 13:03:34 +0100
Date: Fri, 30 Aug 2024 13:03:34 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Zhang Zekun <zhangzekun11@huawei.com>
CC: <songxiaowei@hisilicon.com>, <wangbinghui@hisilicon.com>,
	<lpieralisi@kernel.org>, <kw@linux.com>, <manivannan.sadhasivam@linaro.org>,
	<robh@kernel.org>, <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
	<ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
	<sergio.paracuellos@gmail.com>, <angelogioacchino.delregno@collabora.com>,
	<matthias.bgg@gmail.com>, <alyssa@rosenzweig.io>, <maz@kernel.org>,
	<thierry.reding@gmail.com>
Subject: Re: [PATCH v2 6/6] PCI: tegra: Use helper function
 for_each_child_of_node_scoped()
Message-ID: <20240830130334.00005cf9@Huawei.com>
In-Reply-To: <20240830035819.13718-7-zhangzekun11@huawei.com>
References: <20240830035819.13718-1-zhangzekun11@huawei.com>
	<20240830035819.13718-7-zhangzekun11@huawei.com>
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

On Fri, 30 Aug 2024 11:58:19 +0800
Zhang Zekun <zhangzekun11@huawei.com> wrote:

> for_each_child_of_node_scoped() provides a scope-based cleanup
> functionality to put the device_node automatically, and we don't need to
> call of_node_put() directly.  Let's simplify the code a bit with the use
> of these functions.
> 
> Signed-off-by: Zhang Zekun <zhangzekun11@huawei.com>
One coding style thing + some long lines that could do with wrapping.
With those tidied up.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> v2:
> - Use dev_err_probe() to simplify code.
> - Fix spelling error in commit message.
> 
>  drivers/pci/controller/pci-tegra.c | 74 ++++++++++--------------------
>  1 file changed, 23 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-tegra.c b/drivers/pci/controller/pci-tegra.c
> index d7517c3976e7..94a768a4616d 100644
> --- a/drivers/pci/controller/pci-tegra.c
> +++ b/drivers/pci/controller/pci-tegra.c
> @@ -2106,47 +2106,36 @@ static int tegra_pcie_get_regulators(struct tegra_pcie *pcie, u32 lane_mask)
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
> +			return dev_err_probe(dev, -EINVAL, "invalid port number: %d\n", index);
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
> +			return dev_err_probe(dev, err, "failed to parse # of lanes\n");
>  
> -		if (value > 16) {
> -			dev_err(dev, "invalid # of lanes: %u\n", value);
> -			err = -EINVAL;
> -			goto err_node_put;
> -		}
> +		if (value > 16)
> +			return dev_err_probe(dev, -EINVAL, "invalid # of lanes: %u\n", value);
Long line that I'd wrap.  Same for other similar cases.

>  
>  		lanes |= value << (index << 3);
>  

> @@ -2201,32 +2182,23 @@ static int tegra_pcie_parse_dt(struct tegra_pcie *pcie)
>  		if (IS_ERR(rp->reset_gpio)) {
>  			if (PTR_ERR(rp->reset_gpio) == -ENOENT) {
This { is only here because of the coding style rule about being
consistent.  You aren't any more as

>  				rp->reset_gpio = NULL;
> -			} else {
> -				dev_err(dev, "failed to get reset GPIO: %ld\n",
> -					PTR_ERR(rp->reset_gpio));
> -				err = PTR_ERR(rp->reset_gpio);
> -				goto err_node_put;
> -			}
> +			} else
this is never valid under the kernel coding style.
However, you don't need the {} at all any more as all branches are if
the if / else are single lines.


> +				return dev_err_probe(dev, PTR_ERR(rp->reset_gpio),
> +						     "failed to get reset GPIO\n");
>  		}


