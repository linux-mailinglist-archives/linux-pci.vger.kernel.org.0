Return-Path: <linux-pci+bounces-32711-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF819B0D6F4
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:10:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BD76161B6A
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 10:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805A028C5AC;
	Tue, 22 Jul 2025 10:08:39 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1861B28A1F3;
	Tue, 22 Jul 2025 10:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178919; cv=none; b=C1k+5eBrkxZ5cVWWvL1WD7/L1cKHaRTebOuN+CHxPul1w7R5xcRUZ7EGE8hABO+wg6/9IJ8rtyepysWeDakJgEIPqH3LBP5UZI15atdVsLJJbXkVyH7wGfo8XWmXPWJKeJmilZmuVkbSypP2rj9l+sGaLsrVdTIzN+lo1mNJCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178919; c=relaxed/simple;
	bh=/lmfn8m8BXPuN3hA9ffT9BeMgg83Ako6mc6zGVbLX24=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ak6lh+ViBoPnKh4UeUksAJ3+N1lreQYInDCiIFLnM16fbihMq3PaU0QNMo0aCk506jSzZDlXGKtLAniZm6z/igd7x7ijdPrtuLNzabeO5T9sqoldS84C22pNFHymlgdQ+gsl85IJufJOtmiHTzIxZ9ROzliJTn8FUPrGBvfsKJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bmXxP0VsMz6GBtb;
	Tue, 22 Jul 2025 18:07:05 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id A2AE41400E3;
	Tue, 22 Jul 2025 18:08:34 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Jul
 2025 12:08:34 +0200
Date: Tue, 22 Jul 2025 11:08:33 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Johan Hovold <johan+linaro@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam
	<mani@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] PCI/pwrctrl: Fix device and OF node leak at bus
 scan
Message-ID: <20250722110833.0000542d@huawei.com>
In-Reply-To: <20250721153609.8611-3-johan+linaro@kernel.org>
References: <20250721153609.8611-1-johan+linaro@kernel.org>
	<20250721153609.8611-3-johan+linaro@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Mon, 21 Jul 2025 17:36:08 +0200
Johan Hovold <johan+linaro@kernel.org> wrote:

> Make sure to drop the references to the pwrctrl OF node and device taken
> by of_pci_find_child_device() and of_find_device_by_node() respectively
> when scanning the bus.
> 
> Fixes: 957f40d039a9 ("PCI/pwrctrl: Move creation of pwrctrl devices to pci_scan_device()")
> Cc: stable@vger.kernel.org	# 6.15
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Similar to previous, I'd use a new DEFINE_FREE for the platform device and
the infrastructure is already in place for the for the of_node
(and used a lot in the core DT code).

One other comment inline.


> ---
>  drivers/pci/probe.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 4b8693ec9e4c..c5f59de790c7 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -2515,9 +2515,15 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
>  	struct device_node *np;
>  
>  	np = of_pci_find_child_device(dev_of_node(&bus->dev), devfn);
> -	if (!np || of_find_device_by_node(np))
> +	if (!np)
>  		return NULL;
>  
> +	pdev = of_find_device_by_node(np);
Given we have two entirely different pdevs in here, I'd use an extra
local variable to indicate what this one is the pwctrl one created below.

> +	if (pdev) {
> +		put_device(&pdev->dev);
> +		goto err_put_of_node;
> +	}
> +
>  	/*
>  	 * First check whether the pwrctrl device really needs to be created or
>  	 * not. This is decided based on at least one of the power supplies
> @@ -2525,17 +2531,24 @@ static struct platform_device *pci_pwrctrl_create_device(struct pci_bus *bus, in
>  	 */
>  	if (!of_pci_supply_present(np)) {
>  		pr_debug("PCI/pwrctrl: Skipping OF node: %s\n", np->name);
> -		return NULL;
> +		goto err_put_of_node;
>  	}
>  
>  	/* Now create the pwrctrl device */
>  	pdev = of_platform_device_create(np, NULL, &host->dev);
>  	if (!pdev) {
>  		pr_err("PCI/pwrctrl: Failed to create pwrctrl device for node: %s\n", np->name);
> -		return NULL;
> +		goto err_put_of_node;
>  	}
>  
> +	of_node_put(np);
> +
>  	return pdev;
> +
> +err_put_of_node:
> +	of_node_put(np);
> +
> +	return NULL;
>  }
>  
>  /*


