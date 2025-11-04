Return-Path: <linux-pci+bounces-40294-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 81219C32E2A
	for <lists+linux-pci@lfdr.de>; Tue, 04 Nov 2025 21:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C1CF189D611
	for <lists+linux-pci@lfdr.de>; Tue,  4 Nov 2025 20:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0986B1E520D;
	Tue,  4 Nov 2025 20:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMAtEB3P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BEBE8488;
	Tue,  4 Nov 2025 20:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762287313; cv=none; b=OO0e0D/FPsLQYww8OKmTl2EF+68TyaVIvXBmAn9pAUKJ0EaRAwRMbVkPhSmyR9s4fOcPhEyPmTzfDAKSYT2zBNQmSsYIleBeai133mX3Ov5TLcHF3xvIbh6lJ6JWExwasCkJat0Yccsgow1vZWZ9zPz9g4XPWvFzh0UT0NpA/0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762287313; c=relaxed/simple;
	bh=skXNhSinJcoYmwwLrET6oq2BuORR0pxCLkKF886bR8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a4mTSTQpti9ARGHas12YG4ep942f04oPhydbMNMdXa4I1cz46gA5J0Lb7iR16nCNnt4ofNzAfib7WyFLzLbeA5lNmHnsWqrXO2QPMCHh85KohuP9qI+f7fXtd34/cVmjgrzSjQDCgcDcyO8Ms8IfJkfq+9PUP2ZuZTIwvTyM2Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMAtEB3P; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762287312; x=1793823312;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=skXNhSinJcoYmwwLrET6oq2BuORR0pxCLkKF886bR8g=;
  b=fMAtEB3P59owRcJQW8HLYbOegtwR3oR8SewExoNBN0uG+xfd8TC03uDM
   SDzWJjxnIBgk7smwF1wcx3zO0RxyoiD2nURruVpJMM1BWNz1JsHPcUudF
   6umxJAPB1K4qse8RJQfSGShI/U+WAwNNAwwDWEkKDks9EoH3+X3thmVUM
   +RTuniWwvWIiwv3fKcEP/JN5hB2mVz5PgvUTBNbIVIKFBI9A1cn3f0/Ti
   8fKK4N1fg9Qry91HxZlyjAX0ye6PIUWrwEoSmhdYIefp4/vclpeD4CTAd
   9NAZyriO98ggnJ4MjH22WTaho2lmCWpR2vYyOodhRUXbaDU2njDdJ5zTa
   Q==;
X-CSE-ConnectionGUID: G752hUooT92621L9tlg2Ag==
X-CSE-MsgGUID: 2CboLBWXQc6ge5hg+z/TvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="63599143"
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="63599143"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 12:15:11 -0800
X-CSE-ConnectionGUID: qh62l5YKQwCFV4hmfoG+Mg==
X-CSE-MsgGUID: 54LCA9DCTBK6bOgKJ1CQZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,280,1754982000"; 
   d="scan'208";a="187198873"
Received: from vverma7-desk1.amr.corp.intel.com (HELO [10.125.110.201]) ([10.125.110.201])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Nov 2025 12:15:10 -0800
Message-ID: <846760d0-01a4-4b2b-b1cb-78b5d5149870@intel.com>
Date: Tue, 4 Nov 2025 13:15:08 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND v13 18/25] cxl: Change CXL handlers to use guard()
 instead of scoped_guard()
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, alucerop@amd.com, ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20251104170305.4163840-1-terry.bowman@amd.com>
 <20251104170305.4163840-19-terry.bowman@amd.com>
From: Dave Jiang <dave.jiang@intel.com>
Content-Language: en-US
In-Reply-To: <20251104170305.4163840-19-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 11/4/25 10:02 AM, Terry Bowman wrote:
> The CXL protocol error handlers use scoped_guard() to guarantee access to
> the underlying CXL memory device. Improve readability and reduce complexity
> by changing the current scoped_guard() to be guard().
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>> 
> ---
> 
> Changes in v12->v13:
> - New patch
> ---
>  drivers/cxl/core/ras.c | 53 +++++++++++++++++++++---------------------
>  1 file changed, 26 insertions(+), 27 deletions(-)
> 
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 19d9ffe885bf..cb712772de5c 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -254,19 +254,19 @@ void cxl_cor_error_detected(struct pci_dev *pdev)
>  	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
>  	struct device *dev = &cxlds->cxlmd->dev;
>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return;
> -		}
> -
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> +	guard(device)(dev);
>  
> -		cxl_handle_cor_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
> +	if (!dev->driver) {
> +		dev_warn(&pdev->dev,
> +			 "%s: memdev disabled, abort error handling\n",
> +			 dev_name(dev));
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
> @@ -278,25 +278,24 @@ pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
>  	struct device *dev = &cxlmd->dev;
>  	bool ue;
>  
> -	scoped_guard(device, dev) {
> -		if (!dev->driver) {
> -			dev_warn(&pdev->dev,
> -				 "%s: memdev disabled, abort error handling\n",
> -				 dev_name(dev));
> -			return PCI_ERS_RESULT_DISCONNECT;
> -		}
> +	guard(device)(dev);
>  
> -		if (cxlds->rcd)
> -			cxl_handle_rdport_errors(cxlds);
> -		/*
> -		 * A frozen channel indicates an impending reset which is fatal to
> -		 * CXL.mem operation, and will likely crash the system. On the off
> -		 * chance the situation is recoverable dump the status of the RAS
> -		 * capability registers and bounce the active state of the memdev.
> -		 */
> -		ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
> +	if (!dev->driver) {
> +		dev_warn(&pdev->dev,
> +			 "%s: memdev disabled, abort error handling\n",
> +			 dev_name(dev));
> +		return PCI_ERS_RESULT_DISCONNECT;
>  	}
>  
> +	if (cxlds->rcd)
> +		cxl_handle_rdport_errors(cxlds);
> +	/*
> +	 * A frozen channel indicates an impending reset which is fatal to
> +	 * CXL.mem operation, and will likely crash the system. On the off
> +	 * chance the situation is recoverable dump the status of the RAS
> +	 * capability registers and bounce the active state of the memdev.
> +	 */
> +	ue = cxl_handle_ras(&cxlds->cxlmd->dev, cxlds->serial, cxlds->regs.ras);
>  
>  	switch (state) {
>  	case pci_channel_io_normal:


