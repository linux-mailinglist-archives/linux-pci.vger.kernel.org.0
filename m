Return-Path: <linux-pci+bounces-35806-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 541B7B517CC
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 15:23:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5796F1BC824C
	for <lists+linux-pci@lfdr.de>; Wed, 10 Sep 2025 13:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063A71E834B;
	Wed, 10 Sep 2025 13:23:45 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577213F9D2;
	Wed, 10 Sep 2025 13:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757510624; cv=none; b=AmswaRy2qzLxbkFIHdSM4LDlV8d01vj5g0khTMKHxW8PCaHosPeKofGBDnA183gcnnKnHWKYixK+PEQaO0G/atlTL2gvld1O6rHI3ywzqiH2vGj58Tm3222CJEOyHTBVt22y1tttJVBF28K2PZmH9C8kh4TheSiunFl+gXQiqu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757510624; c=relaxed/simple;
	bh=YY+mBMCDHFwzdMEPQ7CtQqRwcQGfGq8iOcmBEO2u2Rw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j7L9hSdssaNU8bgLi/qS0azD/kGeAEqdmvM7ZTlRYQVU0XAqTQYcU0GpS+vxPD+hs+dOEbZuAFjaUMWb0YPoW8bcfvCShPNt5uaJPDeJcTYhTS/wd4fCQtitQmtNnbxe10X/mU5+kESUV3FePD2IsW9g0QlwqsY/RaJabZqgh1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.31])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cMLvk1hmLz6GD9r;
	Wed, 10 Sep 2025 21:22:26 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id BCAA81402F2;
	Wed, 10 Sep 2025 21:23:38 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Wed, 10 Sep
 2025 15:23:37 +0200
Date: Wed, 10 Sep 2025 14:23:35 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <dave@stgolabs.net>, <dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<dan.j.williams@intel.com>, <bhelgaas@google.com>, <shiju.jose@huawei.com>,
	<ming.li@zohomail.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<rrichter@amd.com>, <dan.carpenter@linaro.org>,
	<PradeepVineshReddy.Kodamati@amd.com>, <lukas@wunner.de>,
	<Benjamin.Cheatham@amd.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<linux-cxl@vger.kernel.org>, <alucerop@amd.com>, <ira.weiny@intel.com>,
	<linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v11 16/23] cxl/pci: Introduce CXL Endpoint protocol
 error handlers
Message-ID: <20250910142335.00001f53@huawei.com>
In-Reply-To: <20250827013539.903682-17-terry.bowman@amd.com>
References: <20250827013539.903682-1-terry.bowman@amd.com>
	<20250827013539.903682-17-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml100009.china.huawei.com (7.191.174.83) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Tue, 26 Aug 2025 20:35:31 -0500
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
> 
> ---
> Changes in v10->v11:
> - cxl_error_detected() - Change handlers' scoped_guard() to guard() (Jonathan)
> - cxl_error_detected() - Remove extra line (Shiju)
> - Changes moved to core/ras.c (Terry)
> - cxl_error_detected(), remove 'ue' and return with function call. (Jonathan)
> - Remove extra space in documentation for PCI_ERS_RESULT_PANIC definition
> - Move #include "pci.h from cxl.h to core.h (Terry)
> - Remove unnecessary includes of cxl.h and core.h in mem.c (Terry)
Hi Terry,

A few suggested renames inline just because things like pci_cor_error_detected()
sounds like it should have nothing CXL specific in it. 

Whilst it is clunky to use cxl_pci_cor_error_detected() I think that is
worth doing to avoid this potential confusion.

> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 42b6e0b092d5..b285448c2d9c 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c

>  
> -void cxl_cor_error_detected(struct pci_dev *pdev)
> +void cxl_cor_error_detected(struct device *dev)
>  {
> +	struct pci_dev *pdev = to_pci_dev(dev);
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
> -	struct device *dev = &cxlds->cxlmd->dev;
> +	struct device *cxlmd_dev = &cxlds->cxlmd->dev;
>  
> -	scoped_guard(device, dev) {

Dropping the scoped_guard() to guard() here makes it harder
to tell what is going on.  I guess it isn't quite worth a precursor
patch unless there are several similar refactors to do.

> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return;
> -		}
> +	guard(device)(cxlmd_dev);
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
> +	if (!cxlmd_dev->driver) {
> +		dev_warn(&pdev->dev, "%s: memdev disabled, abort error handling", dev_name(dev));
> +		return;
>  	}
> +
> +	if (cxlds->rcd)
> +		cxl_handle_rdport_errors(cxlds);
> +
> +	cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
>  
> -pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
> -				    pci_channel_state_t state)
> +void pci_cor_error_detected(struct pci_dev *pdev)
>  {
> +	cxl_cor_error_detected(&pdev->dev);
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_cor_error_detected, "CXL");

I'd go with a cxl_pci_ prefix for this to avoid impression it is is more
generic than that.

>
> +
> +pci_ers_result_t pci_error_detected(struct pci_dev *pdev,

Given this is CXL specific, probably makes sense to prefix to give
cxl_pci_error_detected()


Then when we see the call it is more obvious it isn't a 'generic'
PCI thing.


> +				    pci_channel_state_t error)
> +{
> +	pci_ers_result_t rc;
> +
> +	rc = cxl_error_detected(&pdev->dev);
> +	if (rc == PCI_ERS_RESULT_PANIC)
> +		panic("CXL cachemem error.");
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(pci_error_detected, "CXL");



