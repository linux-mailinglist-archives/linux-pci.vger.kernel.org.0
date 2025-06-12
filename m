Return-Path: <linux-pci+bounces-29572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6279EAD7889
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 18:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A51A13B3A22
	for <lists+linux-pci@lfdr.de>; Thu, 12 Jun 2025 16:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 244BF29B761;
	Thu, 12 Jun 2025 16:56:05 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A80B81F3BB0;
	Thu, 12 Jun 2025 16:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749747365; cv=none; b=KX8DYizOSxNjch8Os3e4pEIulqkogOJTRHwd8iaa9eIrWrDCDnO/he1FF37cOxh55DyEsBdwx8sIsG+J6cGxFfy2nUFJV9LQrxw6LLLVmUw8dz8VXIPjwnURD4sA3SGtTmupx7JIzVLiZfhVV0qWH1Aj3o8vtCH/Rc+OZNOu1TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749747365; c=relaxed/simple;
	bh=v89dW3iMfh6mZ1TxInMmlWaE+TSy57a+Fi/OSAIAcF0=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iXfMh+tHxTVR8FI4Ceu2mxmEsGuoo8KCkvUR11jfRlaVEtfsHknOG9Asfn4iH4sxJtzvZPhhVPTBSxjcNiEtSHSFKci0Gdjp7G/hPrs83oheXCdbI/vNIXHbBlRIeLzpzBO7O8REF3vV+TTngLoVU4dvvIChT+pKF/2FkgCdaW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bJ7v90vVqz6M529;
	Fri, 13 Jun 2025 00:55:33 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 29C90140276;
	Fri, 13 Jun 2025 00:55:59 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 12 Jun
 2025 18:55:58 +0200
Date: Thu, 12 Jun 2025 17:55:56 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <PradeepVineshReddy.Kodamati@amd.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <bp@alien8.de>,
	<ming.li@zohomail.com>, <shiju.jose@huawei.com>, <dan.carpenter@linaro.org>,
	<Smita.KoralahalliChannabasappa@amd.com>, <kobayashi.da-06@fujitsu.com>,
	<yanfei.xu@intel.com>, <rrichter@amd.com>, <peterz@infradead.org>,
	<colyli@suse.de>, <uaisheng.ye@intel.com>,
	<fabio.m.de.francesco@linux.intel.com>, <ilpo.jarvinen@linux.intel.com>,
	<yazen.ghannam@amd.com>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v9 12/16] cxl/pci: Introduce CXL Endpoint protocol error
 handlers
Message-ID: <20250612175556.000036b5@huawei.com>
In-Reply-To: <20250603172239.159260-13-terry.bowman@amd.com>
References: <20250603172239.159260-1-terry.bowman@amd.com>
	<20250603172239.159260-13-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 3 Jun 2025 12:22:35 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> CXL Endpoint protocol errors are currently handled using PCI error
> handlers. The CXL Endpoint requires CXL specific handling in the case of
> uncorrectable error handling not provided by the PCI handlers.
> 
> Add CXL specific handlers for CXL Endpoints. Rename the existing
> cxl_error_handlers to be pci_error_handlers to more correctly indicate
> the error type and follow naming consistency.

I wonder if a rename precursor patch would be better here than doing it
all in one go?

Having not read the patch description thoroughly this had me confused ;)

> 
> Keep the existing PCI Endpoint handlers. PCI handlers can be called if the
> CXL device is not trained for alternate protocol (CXL). Update the CXL
> Endpoint PCI handlers to call the CXL handler. If the CXL uncorrectable
> handler returns PCI_ERS_RESULT_PANIC then the PCI handler invokes panic().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>


>  
>  static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
>  {
> -

So this snuck in somewhere between upstream and here.  If it is in this
set let's push the removal back to where it came from.

>  	return __cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>  }
>  
> @@ -844,14 +843,15 @@ static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds)
>  static void cxl_handle_rdport_errors(struct cxl_dev_state *cxlds) { }
>  #endif
>
> +pci_ers_result_t cxl_error_detected(struct device *dev)
> +{
> +	struct pci_dev *pdev = to_pci_dev(dev);
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
> +	pci_ers_result_t ue;
> +
> +	scoped_guard(device, cxlmd_dev) {
>  		if (!dev->driver) {
>  			dev_warn(&pdev->dev,
>  				 "%s: memdev disabled, abort error handling\n",
>  				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> +			return PCI_ERS_RESULT_PANIC;
>  		}
>  
>  		if (cxlds->rcd)
> @@ -892,29 +900,25 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  		ue = cxl_handle_endpoint_ras(cxlds);
>  	}
>  
> -

Maybe something more in the patch description on why this chunk isn't relevant?
I guess we don't need the more complex handling as these are all panic :)

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

>  static int cxl_flit_size(struct pci_dev *pdev)
>  {
>  	if (cxl_pci_flit_256(pdev))
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 0ef8c2068c0c..664f532cc838 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

> @@ -244,6 +244,8 @@ static struct pci_dev *sbdf_to_pci(struct cxl_prot_error_info *err_info)
>  static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>  {
>  	struct pci_dev *pdev __free(pci_dev_put) = pci_dev_get(sbdf_to_pci(err_info));
> +	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> +	struct device *cxlmd_dev __free(put_device) = get_device(&cxlds->cxlmd->dev);
>  
>  	if (!pdev) {
>  		pr_err("Failed to find the CXL device\n");
> @@ -260,15 +262,13 @@ static void cxl_handle_prot_error(struct cxl_prot_error_info *err_info)
>  
>  	if (err_info->severity == AER_CORRECTABLE) {
>  		int aer = pdev->aer_cap;
> -		struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -		struct device *dev __free(put_device) = get_device(&cxlds->cxlmd->dev);

This code move seems somewhat unrelated?  Maybe it's in the wrong patch and
becomes necessary later?

>  
>  		if (aer)
>  			pci_clear_and_set_config_dword(pdev,
>  						       aer + PCI_ERR_COR_STATUS,
>  						       0, PCI_ERR_COR_INTERNAL);
>  
> -		cxl_cor_error_detected(pdev);
> +		cxl_cor_error_detected(&pdev->dev);
>  
>  		pcie_clear_device_status(pdev);
>  	} else {




