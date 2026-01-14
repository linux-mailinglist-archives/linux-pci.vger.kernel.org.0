Return-Path: <linux-pci+bounces-44864-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 86E84D2143B
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 22:06:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 06FF83020C5F
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24605357A55;
	Wed, 14 Jan 2026 21:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ILzwr5kG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A0F63451C8;
	Wed, 14 Jan 2026 21:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768424768; cv=none; b=IjUpD3FfGsEUwHHjBs0wS8thyVhkb65vsMPD/YxWkJi0fbircM0x/le1p3tofHxByxccqbTYtbqyZNEfBm4lAqS+RSNYgemTzWptt9IW3VrwHXNQDbijvJbizzzWK3TQoEmBQ3EO5l2fxAN5JMA1nyd4QohpKiJr7Pbfc7x+44k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768424768; c=relaxed/simple;
	bh=WXCdLeYEpQ/wkrnsenLPDACz1n3BJFdqZZuQ1zcnhlE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lBWoXiUW2TQRao8ZE0+LtpnL7D0pkNms65MMKijc4g7SiEmLJX7MeBeytwBqA89M+RMMe6NaFxwyA7ER98fLEF1U8BxU/cCMyNrRmShqxaud8bdglZVz9BolWFT1PAxKFtURzGBGTA9X+3z/wclb2XX4EwURof7Zw0qbIQHAFuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ILzwr5kG; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1768424766; x=1799960766;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=WXCdLeYEpQ/wkrnsenLPDACz1n3BJFdqZZuQ1zcnhlE=;
  b=ILzwr5kGkM5MSV+jUUVW5CTAxGdgsN+rlpKWbzacB6XzEjc18oEfTSRP
   zY9DvKSuTfNj9XL6CaECR/WXFE+xF24WJ4624P1UPoj06SOFotaO97XN1
   62FtFR8dN6WnECabJPMV7CYiVQxXm62J7fBGGTrnUQu/MA9c7iUxq2WvM
   KoXI7eWwyRKraFn2eRt8zSJGhJH9lgooOHo/jYy5Mgnkniv3sgL32RzjQ
   WE6Sqe5+VgelXzOHRIdDp1U0FzdQmzEBzSVq+ernmNPY/4+L4W76bTHww
   4zdDOG1/4Zh/xcoyZ6BHePGSegBceJDRFNNbAVhprseB3l8M+xDAX7u1V
   A==;
X-CSE-ConnectionGUID: Y/bAAxkWTjy5wZea6BjfFw==
X-CSE-MsgGUID: g0TPMQSSSR+sahg0E6tYSQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="68941341"
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="68941341"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:06:05 -0800
X-CSE-ConnectionGUID: XcD/GyWcQe+BkVCZWAzdNg==
X-CSE-MsgGUID: US1axb6iTHW/a6SBGBws/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,226,1763452800"; 
   d="scan'208";a="235504693"
Received: from dwoodwor-mobl2.amr.corp.intel.com (HELO [10.125.111.5]) ([10.125.111.5])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 13:06:04 -0800
Message-ID: <4e758ada-2633-4651-bf87-2f1e504b82fe@intel.com>
Date: Wed, 14 Jan 2026 14:06:02 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 15/34] PCI/AER: Update struct aer_err_info with
 kernel-doc formatting
To: Terry Bowman <terry.bowman@amd.com>, dave@stgolabs.net,
 jonathan.cameron@huawei.com, alison.schofield@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, shiju.jose@huawei.com,
 ming.li@zohomail.com, Smita.KoralahalliChannabasappa@amd.com,
 rrichter@amd.com, dan.carpenter@linaro.org,
 PradeepVineshReddy.Kodamati@amd.com, lukas@wunner.de,
 Benjamin.Cheatham@amd.com, sathyanarayanan.kuppuswamy@linux.intel.com,
 linux-cxl@vger.kernel.org, vishal.l.verma@intel.com, alucerop@amd.com,
 ira.weiny@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260114182055.46029-1-terry.bowman@amd.com>
 <20260114182055.46029-16-terry.bowman@amd.com>
Content-Language: en-US
From: Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20260114182055.46029-16-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/14/26 11:20 AM, Terry Bowman wrote:
> Update the existing 'struct aer_err_info' definition to use kernel-doc
> formatting. Remove the inline comments to reduce noise and do not introduce
> functional changes. This will improve readability and maintainability.
> 
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Dan Williams <dan.j.williams@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>

> 
> ---
> 
> Changes in v13->v14:
> - New commit
> ---
>  drivers/pci/pci.h | 29 +++++++++++++++++++++++------
>  1 file changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 41ec38e82c08..dbc547db208a 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -724,16 +724,33 @@ static inline bool pci_dev_binding_disallowed(struct pci_dev *dev)
>  
>  #define AER_MAX_MULTI_ERR_DEVICES	5	/* Not likely to have more */
>  
> +/**
> + * struct aer_err_info - AER Error Information
> + * @dev: Devices reporting error
> + * @ratelimit_print: Flag to log or not log the devices' error. 0=NotLog/1=Log
> + * @error_dev_num: Number of devices reporting an error
> + * @level: printk level to use in logging
> + * @id: Value from register PCI_ERR_ROOT_ERR_SRC
> + * @severity: AER severity, 0-UNCOR Non-fatal, 1-UNCOR fatal, 2-COR
> + * @root_ratelimit_print: Flag to log or not log the root's error. 0=NotLog/1=Log
> + * @multi_error_valid: If multiple errors are reported
> + * @first_error: First reported error
> + * @is_cxl: Bus type error: 0-PCI Bus error, 1-CXL Bus error
> + * @tlp_header_valid: Indicates if TLP field contains error information
> + * @status: COR/UNCOR error status
> + * @mask: COR/UNCOR mask
> + * @tlp: Transaction packet information
> + */
>  struct aer_err_info {
>  	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>  	int ratelimit_print[AER_MAX_MULTI_ERR_DEVICES];
>  	int error_dev_num;
> -	const char *level;		/* printk level */
> +	const char *level;
>  
>  	unsigned int id:16;
>  
> -	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
> -	unsigned int root_ratelimit_print:1;	/* 0=skip, 1=print */
> +	unsigned int severity:2;
> +	unsigned int root_ratelimit_print:1;
>  	unsigned int __pad1:4;
>  	unsigned int multi_error_valid:1;
>  
> @@ -742,9 +759,9 @@ struct aer_err_info {
>  	unsigned int is_cxl:1;
>  	unsigned int tlp_header_valid:1;
>  
> -	unsigned int status;		/* COR/UNCOR Error Status */
> -	unsigned int mask;		/* COR/UNCOR Error Mask */
> -	struct pcie_tlp_log tlp;	/* TLP Header */
> +	unsigned int status;
> +	unsigned int mask;
> +	struct pcie_tlp_log tlp;
>  };
>  
>  int aer_get_device_error_info(struct aer_err_info *info, int i);


