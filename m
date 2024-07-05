Return-Path: <linux-pci+bounces-9830-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B48C9286A6
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 12:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06CE0282D54
	for <lists+linux-pci@lfdr.de>; Fri,  5 Jul 2024 10:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1886249629;
	Fri,  5 Jul 2024 10:18:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74D3E14658F;
	Fri,  5 Jul 2024 10:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720174693; cv=none; b=CVetXmBZOquRiUFA9ymw8qRE6ib7pK4mGFJjRf91+q/wYp4MlMZ5qk4swOvO4qlfQD9b6OZUkjorvXysD4vgmFsAQoUKFaD7UFkcMIYvx9BobTZzCNmxOdDO5LOcPvffonR5OgzWPope1w7b9pj8Q7+hq+wWf9DmJqcVXE9Nnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720174693; c=relaxed/simple;
	bh=Th4AfzywcjYj8OEFQ3u+l3YaNfR9p1X690dvSI5OpXk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gm8K5gBddckGr72v8POggFZJMJ8lVSVd6I9rzgFC/9i1U1UXwH7mxnAIgEKa6F9Z0j5I08+TK0niSws400B3eKwOU0oCa83iC0kakM7mtWoQ7gIDLBFnTcPWA3Jp7hMXD88h5y3SQgnSM7TQ7VTG/8guUqka5fSUYr46ogFfEzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4WFqFZ6tSxz6JB2x;
	Fri,  5 Jul 2024 18:17:22 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id E2F6A140A30;
	Fri,  5 Jul 2024 18:18:06 +0800 (CST)
Received: from localhost (10.203.174.77) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 5 Jul
 2024 11:18:06 +0100
Date: Fri, 5 Jul 2024 11:18:05 +0100
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Javier Carrasco <javier.carrasco.cruz@gmail.com>
CC: Xiaowei Song <songxiaowei@hisilicon.com>, Binghui Wang
	<wangbinghui@hisilicon.com>, Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>, Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>, Linus Walleij
	<linus.walleij@linaro.org>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PCI: kirin: fix memory leak in kirin_pcie_parse_port()
Message-ID: <20240705111805.00002010@Huawei.com>
In-Reply-To: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
References: <20240609-pcie-kirin-memleak-v1-1-62b45b879576@gmail.com>
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
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Sun, 09 Jun 2024 12:56:14 +0200
Javier Carrasco <javier.carrasco.cruz@gmail.com> wrote:

> The conversion of this file to use the agnostic GPIO API has introduced
> a new early return where the refcounts of two device nodes (parent and
> child) are not decremented.
> 
> Given that the device nodes are not required outside the loops where
> they are used, and to avoid potential bugs every time a new error path
> is introduced to the loop, the _scoped() versions of the macros have
> been applied. The bug was introduced recently, and the fix is not
> relevant for old stable kernels that might not support the scoped()
> variant.
> 
> Fixes: 1d38f9d89f85 ("PCI: kirin: Convert to use agnostic GPIO API")
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Diff on this on is irritating as it doesn't actually show the
buggy code...  Ah well.

Change is valid, but one suggestion inline.

Looks like it's queued now already, but if not.
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> ---
> This bug was found while analyzing the code and I don't have hardware to
> validate it beyond compilation and static analysis. Any test with real
> hardware to make sure there are no regressions is always welcome.
> 
> The dev_err() messages have not been converted into dev_err_probe() to
> keep the current format, but I am open to convert them if preferred.
> ---
>  drivers/pci/controller/dwc/pcie-kirin.c | 21 ++++++---------------
>  1 file changed, 6 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
> index d1f54f188e71..0a29136491b8 100644
> --- a/drivers/pci/controller/dwc/pcie-kirin.c
> +++ b/drivers/pci/controller/dwc/pcie-kirin.c
> @@ -403,11 +403,10 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  				 struct device_node *node)
>  {
>  	struct device *dev = &pdev->dev;
> -	struct device_node *parent, *child;
>  	int ret, slot, i;
>  
> -	for_each_available_child_of_node(node, parent) {
> -		for_each_available_child_of_node(parent, child) {
> +	for_each_available_child_of_node_scoped(node, parent) {
> +		for_each_available_child_of_node_scoped(parent, child) {
>  			i = pcie->num_slots;
>  
>  			pcie->id_reset_gpio[i] = devm_fwnode_gpiod_get_index(dev,
> @@ -424,14 +423,13 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			pcie->num_slots++;
>  			if (pcie->num_slots > MAX_PCI_SLOTS) {
>  				dev_err(dev, "Too many PCI slots!\n");
> -				ret = -EINVAL;
> -				goto put_node;
> +				return -EINVAL;
Perhaps a future change, but this would be nicer as
				return dev_err_probe(dev, -EINVAL,
						     "Too many PCI slots!\n");
Maybe as part of a general change to this driver to use
dev_err_probe() for all the error prints in paths only called
from probe().

>  			}
>  
>  			ret = of_pci_get_devfn(child);
>  			if (ret < 0) {
>  				dev_err(dev, "failed to parse devfn: %d\n", ret);
> -				goto put_node;
> +				return ret;
>  			}
>  
>  			slot = PCI_SLOT(ret);
> @@ -439,10 +437,8 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  			pcie->reset_names[i] = devm_kasprintf(dev, GFP_KERNEL,
>  							      "pcie_perst_%d",
>  							      slot);
> -			if (!pcie->reset_names[i]) {
> -				ret = -ENOMEM;
> -				goto put_node;
> -			}
> +			if (!pcie->reset_names[i])
> +				return -ENOMEM;
>  
>  			gpiod_set_consumer_name(pcie->id_reset_gpio[i],
>  						pcie->reset_names[i]);
> @@ -450,11 +446,6 @@ static int kirin_pcie_parse_port(struct kirin_pcie *pcie,
>  	}
>  
>  	return 0;
> -
> -put_node:
> -	of_node_put(child);
> -	of_node_put(parent);
> -	return ret;
>  }
>  
>  static long kirin_pcie_get_resource(struct kirin_pcie *kirin_pcie,
> 
> ---
> base-commit: d35b2284e966c0bef3e2182a5c5ea02177dd32e4
> change-id: 20240609-pcie-kirin-memleak-18c83a31d111
> 
> Best regards,


