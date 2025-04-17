Return-Path: <linux-pci+bounces-26137-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28318A923DF
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 19:22:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 771803AD42A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AE742550C4;
	Thu, 17 Apr 2025 17:22:21 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D2D1A0730;
	Thu, 17 Apr 2025 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744910541; cv=none; b=nVJWf1UeD4tHverpNEDi6f4CHTd0pz3vLqD76ntysLSHUwG2pUaetBiI5ExiUrXbENWP4rFdeAIwPGxqx39GJiWw2UVneN6HknPBQUtZi/m3OtZ2JsMqAu7UWOX3t278WOn0+gSAC4RX32VIQczLvqEvUosMTsRSzCF/Ohw/gYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744910541; c=relaxed/simple;
	bh=QaiiSw2sc68sB4+5GNZUMgQk4P7YNtfdfuop79iBfVg=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t9L7iOz++fw756E4BVPhiW9vzAjQ837Qo20FTKVIGrfl4LE/GkNuy4xGdYun2EQpKzNScCp4RIImEy8BB+ulZOUcxfNQZMKO2bFzKVqo9j8Dtho5FlrXmqAY61+A24VQfwPVTRhxxedHopvkeRG6yX+qofPG7WwvXg6ieu9lZgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Zdl3B2gGGz6M4fj;
	Fri, 18 Apr 2025 01:18:14 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 21D01140145;
	Fri, 18 Apr 2025 01:22:15 +0800 (CST)
Received: from localhost (10.203.177.66) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Thu, 17 Apr
 2025 19:22:14 +0200
Date: Thu, 17 Apr 2025 18:22:12 +0100
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: Terry Bowman <terry.bowman@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <nifan.cxl@gmail.com>, <dave@stgolabs.net>,
	<dave.jiang@intel.com>, <alison.schofield@intel.com>,
	<vishal.l.verma@intel.com>, <dan.j.williams@intel.com>,
	<bhelgaas@google.com>, <mahesh@linux.ibm.com>, <ira.weiny@intel.com>,
	<oohall@gmail.com>, <Benjamin.Cheatham@amd.com>, <rrichter@amd.com>,
	<nathan.fontenot@amd.com>, <Smita.KoralahalliChannabasappa@amd.com>,
	<lukas@wunner.de>, <ming.li@zohomail.com>,
	<PradeepVineshReddy.Kodamati@amd.com>
Subject: Re: [PATCH v8 14/16] cxl/pci: Remove unnecessary CXL Endpoint
 handling helper functions
Message-ID: <20250417182212.000078d2@huawei.com>
In-Reply-To: <20250327014717.2988633-15-terry.bowman@amd.com>
References: <20250327014717.2988633-1-terry.bowman@amd.com>
	<20250327014717.2988633-15-terry.bowman@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500011.china.huawei.com (7.191.174.215) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 26 Mar 2025 20:47:15 -0500
Terry Bowman <terry.bowman@amd.com> wrote:

> The cxl_handle_endpoint_cor_ras()/cxl_handle_endpoint_ras() functions
> are unnecessary helper function and only used for Endpoints. Remove these
> functions because they are not necessary and do not align with a common
> handling API for all CXL devices' errors.
Having done this, what does the double underscore in the naming denote?
I assume original intent was perhaps that only the wrappers should
ever be called.  If that's not the case after this change maybe get
rid of the __ prefix?

> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>  drivers/cxl/core/pci.c | 17 ++++-------------
>  1 file changed, 4 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index f2139b382839..a67925dfdbe1 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -670,11 +670,6 @@ static void __cxl_handle_cor_ras(struct device *cxl_dev, struct device *pcie_dev
>  	trace_cxl_aer_correctable_error(cxl_dev, pcie_dev, serial, status);
>  }
>  
> -static void cxl_handle_endpoint_cor_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_cor_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, cxlds->regs.ras);
Previously second parameter was NULL. After this change you pass &pdev->dev.
That makes it look at least like there is a functional change here.
If this doesn't matter perhaps you should explain why in the description.

> -}
> -
>  /* CXL spec rev3.0 8.2.4.16.1 */
>  static void header_log_copy(void __iomem *ras_base, u32 *log)
>  {
> @@ -732,14 +727,8 @@ static pci_ers_result_t __cxl_handle_ras(struct device *cxl_dev, struct device *
>  	return PCI_ERS_RESULT_PANIC;
>  }
>  
> -static bool cxl_handle_endpoint_ras(struct cxl_dev_state *cxlds)
> -{
> -	return __cxl_handle_ras(&cxlds->cxlmd->dev, NULL, cxlds->serial, cxlds->regs.ras);
> -}
> -
>  #ifdef CONFIG_PCIEAER_CXL
>  
> -

Unrelated change. I think this ifdef was added earlier in series so avoid
adding the bonus line wherever it came from...

>  void cxl_port_cor_error_detected(struct device *cxl_dev,
>  				 struct cxl_prot_error_info *err_info)
>  {
> @@ -868,7 +857,8 @@ void cxl_cor_error_detected(struct device *dev, struct cxl_prot_error_info *err_
>  		if (cxlds->rcd)
>  			cxl_handle_rdport_errors(cxlds);
>  
> -		cxl_handle_endpoint_cor_ras(cxlds);
> +		__cxl_handle_cor_ras(&cxlds->cxlmd->dev, &pdev->dev,
> +				     cxlds->serial, cxlds->regs.ras);
>  	}
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_cor_error_detected, "CXL");
> @@ -907,7 +897,8 @@ pci_ers_result_t cxl_error_detected(struct device *dev,
>  		 * chance the situation is recoverable dump the status of the RAS
>  		 * capability registers and bounce the active state of the memdev.
>  		 */
> -		ue = cxl_handle_endpoint_ras(cxlds);
> +		ue = __cxl_handle_ras(&cxlds->cxlmd->dev, &pdev->dev,
> +				      cxlds->serial, cxlds->regs.ras);
>  	}
>  
>  	if (ue)


