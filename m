Return-Path: <linux-pci+bounces-32710-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97302B0D6EB
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 12:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 925DE7AF1D8
	for <lists+linux-pci@lfdr.de>; Tue, 22 Jul 2025 10:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6C7A23ABBF;
	Tue, 22 Jul 2025 10:05:40 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F5E72DFA28;
	Tue, 22 Jul 2025 10:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753178740; cv=none; b=H3ndazexKROwEOGTjMcuHy2ImbdbeW/DAwtRYiDzdxF2jpOUsE03wr6U/oAW8wmRNWkyb659B7kraHg0dDTxlFvfWZygttq4T5NblZAeffz2xtYrRY2ytWYM678JrBm7r3wMGa2lk1ZQB4Ezy7OTfePqp7xcEbuM04InsbWbPq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753178740; c=relaxed/simple;
	bh=lSZJM+Cmkevs2pRpsraF39Zvx0NW8Mvm/3hNXQnS4JE=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S/MCE4V/CZZ9+kK0WiMBeoUCOhV7I7KckKfM0KuZLXvg/tMvtB6sQM+Ui8/gF0ZZrWVrVL/0GdmNjp+rFO8FnXDOuMx0iHyGjMfBpucgT33RERRNxlz+SsLH2EgO5FGlB76rfz4hXrBHtxtmxQIfe261zpVMT/qzXbBMPE8uGrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bmXsq1MCFz6GBbq;
	Tue, 22 Jul 2025 18:03:59 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BEE5C140158;
	Tue, 22 Jul 2025 18:05:28 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 22 Jul
 2025 12:05:28 +0200
Date: Tue, 22 Jul 2025 11:05:26 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Johan Hovold <johan+linaro@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, Manivannan Sadhasivam
	<mani@kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 1/3] PCI/pwrctrl: Fix device leak at registration
Message-ID: <20250722110526.00002a60@huawei.com>
In-Reply-To: <20250721153609.8611-2-johan+linaro@kernel.org>
References: <20250721153609.8611-1-johan+linaro@kernel.org>
	<20250721153609.8611-2-johan+linaro@kernel.org>
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

On Mon, 21 Jul 2025 17:36:07 +0200
Johan Hovold <johan+linaro@kernel.org> wrote:

> Make sure to drop the reference to the pwrctrl device taken by
> of_find_device_by_node() when registering a PCI device.
> 
> Fixes: b458ff7e8176 ("PCI/pwrctl: Ensure that pwrctl drivers are probed before PCI client drivers")
> Cc: stable@vger.kernel.org	# 6.13
> Cc: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Hi Johan,

Perhaps time for 
DEFINE_FREE(put_pdev, struct platform_device *, if (_T) put_device(&_T->dev));

then...

> ---
>  drivers/pci/bus.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
> index 69048869ef1c..0394a9c77b38 100644
> --- a/drivers/pci/bus.c
> +++ b/drivers/pci/bus.c
> @@ -362,11 +362,15 @@ void pci_bus_add_device(struct pci_dev *dev)
>  	 * before PCI client drivers.
>  	 */
>  	pdev = of_find_device_by_node(dn);
> -	if (pdev && of_pci_supply_present(dn)) {
> -		if (!device_link_add(&dev->dev, &pdev->dev,
> -				     DL_FLAG_AUTOREMOVE_CONSUMER))
> -			pci_err(dev, "failed to add device link to power control device %s\n",
> -				pdev->name);

	struct platform_device *pdev __free(put_pdev) =
		of_find_device_by_node(dn);
> +	if (pdev) {
> +		if (of_pci_supply_present(dn)) {
> +			if (!device_link_add(&dev->dev, &pdev->dev,
> +					     DL_FLAG_AUTOREMOVE_CONSUMER)) {
> +				pci_err(dev, "failed to add device link to power control device %s\n",
> +					pdev->name);
> +			}
> +		}
> +		put_device(&pdev->dev);

and no need for any explicit put.

We already do this extensively in some subsystems (e.g. CXL) and it
greatly simplifies code.

>  	}
>  
>  	if (!dn || of_device_is_available(dn))


