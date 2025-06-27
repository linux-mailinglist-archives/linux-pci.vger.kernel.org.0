Return-Path: <linux-pci+bounces-30922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75D92AEB6E0
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 13:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BC54B7AF520
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 11:51:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4498F2BF018;
	Fri, 27 Jun 2025 11:52:11 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFD72C15BD;
	Fri, 27 Jun 2025 11:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751025131; cv=none; b=OO7rMF15EgItllWQ13boOxyGngn0zdDfZla1ninVFiDyYhA68J6YFZkem7qAysovwargyafBz1R/DvMaFDjxR/7Df11MDOT9JadDerYs2EHtg84JKKs6mufATdthd483WCKGV+QNG+LY0qUMgHdSaomi8F4LVu0/PdUKDD3BG+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751025131; c=relaxed/simple;
	bh=XsFBoM55j4bAYZ7L9ORFlVbOLZCzG1Kh4FVMZp84x5c=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hDyZZ7k4vM6KqhiKJYRpFSXImgLXtgTY6SkyKARBGJ7SZvZcg+eX66XsfwdWVEgzO4hMn/kI/1ETjUs1VtYUZlNS9aLWGLbOINNHtSZ+R7w+4Aauu2mGh95u9rrs0F3nk1jU957CDpzU9WWICp8TKb1yTMuVyP3yRlq/e+2TkHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bTDRw3mZ5z6L5K9;
	Fri, 27 Jun 2025 19:51:56 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 04ADC14011D;
	Fri, 27 Jun 2025 19:52:06 +0800 (CST)
Received: from localhost (10.48.153.213) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 27 Jun
 2025 13:52:04 +0200
Date: Fri, 27 Jun 2025 12:52:03 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>
Subject: Re: [PATCH v10 14/17] cxl/pci: Introduce CXL Endpoint protocol
 error handlers
Message-ID: <20250627125203.00002564@huawei.com>
In-Reply-To: <20250626224252.1415009-15-terry.bowman@amd.com>
References: <20250626224252.1415009-1-terry.bowman@amd.com>
	<20250626224252.1415009-15-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Thu, 26 Jun 2025 17:42:49 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL Endpoint protocol errors are currently handled using PCI error
> handlers. The CXL Endpoint requires CXL specific handling in the case of
> uncorrectable error (UCE) handling not provided by the PCI handlers.
> 
> Add CXL specific handlers for CXL Endpoints. Rename the existing
> cxl_error_handlers to be pci_error_handlers to more correctly indicate
> the error type and follow naming consistency.
> 
> The PCI handlers will be called if the CXL device is not trained for
> alternate protocol (CXL). Update the CXL Endpoint PCI handlers to call the
> CXL UCE handlers.
> 
> The existing EP UCE handler includes checks for various results. These are
> no longer needed because CXL UCE recovery will not be attempted. Implement
> cxl_handle_ras() to return PCI_ERS_RESULT_NONE or PCI_ERS_RESULT_PANIC. The
> CXL UCE handler is called by cxl_do_recovery() that acts on the return
> value. In the case of the PCI handler path, call panic() if the result is
> PCI_ERS_RESULT_PANIC.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

A few minor comments inline.

J
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index 887b54cf3395..7209ffb5c2fe 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c


>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> +pci_ers_result_t cxl_error_detected(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
> +	pci_ers_result_t ue;
> +
> +	scoped_guard(device, cxlmd_dev) {
I think there is nothing much happening after this (maybe introduced in later
patches in which case ignore this comment).

So can you just use a guard and reduce the indent of the rest?

> +
> +		if (!cxlmd_dev->driver) {
>  			dev_warn(&pdev->dev,
>  				 "%s: memdev disabled, abort error handling\n",
>  				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> +			return PCI_ERS_RESULT_PANIC;
>  		}
>  
>  		if (cxlds->rcd)
> @@ -881,29 +888,23 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);

little hard to tell from this code blob but can you return here?

>  	}
>  
> -
> -	switch (state) {
> -	case pci_channel_io_normal:
> -		if (ue) {
> -			device_release_driver(dev);
> -			return PCI_ERS_RESULT_NEED_RESET;
> -		}
> -		return PCI_ERS_RESULT_CAN_RECOVER;
> -	case pci_channel_io_frozen:
> -		dev_warn(&pdev->dev,
> -			 "%s: frozen state error detected, disable CXL.mem\n",
> -			 dev_name(dev));
> -		device_release_driver(dev);
> -		return PCI_ERS_RESULT_NEED_RESET;
> -	case pci_channel_io_perm_failure:
> -		dev_warn(&pdev->dev,
> -			 "failure state error detected, request disconnect\n");
> -		return PCI_ERS_RESULT_DISCONNECT;
> -	}
> -	return PCI_ERS_RESULT_NEED_RESET;
> +	return ue;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_error_detected, "CXL");

