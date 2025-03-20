Return-Path: <linux-pci+bounces-24197-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAF9A69EAA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 04:23:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ED95B7A23BA
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 03:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0DC1D6188;
	Thu, 20 Mar 2025 03:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HdAVKtU6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71BD149DFF
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 03:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742440986; cv=none; b=kUrLLfx0q84QytISG1gZEwpDYAWVog7CLGQ3/0OhKTmTBhHhS7TQh6NdcP/1f40fgTvc6E/75JSzm0M7OqRRd8MswhPzfYMosXP+PibNxx+oTrDLnAyDe8AdUbJnQaXvKgPugzBaBU7TvwOx9tj8YyTI483BEO2J1uPMWsF8QXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742440986; c=relaxed/simple;
	bh=w9hDQE9fhbQZzHLuCcRA9HGMjbjspU2Ed8xujp+rMK4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b9IIkDH1/3kO6DqZNRFpmVdpkpx9aUe636LbGSfuDfpZaECxUKYI35etEqP6WVIDmo7QcO2yPiNOQb49vbXzhbcmpweFybvDm2yYvAvtUhpGK/MHZVpJZAfvVB2xIqa33OGYLnIRfnPm5NTyYGXfjo7JwQO0tETsl0KLdCcFBgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HdAVKtU6; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742440984; x=1773976984;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=w9hDQE9fhbQZzHLuCcRA9HGMjbjspU2Ed8xujp+rMK4=;
  b=HdAVKtU6MyGS3ZUGDu2Q+DorYNyboPhFMTVHRLrelxL6xT2+XFOxeb/V
   /MI/vdAZeOV1VQh8KJFCvA5FsC1RiGO5FXabe7EIMtuU5Ym/pCJOVcExk
   wCOY31npdFrr9vM3zCJJhqoPV4OkLq8jWeh/4QXZXT3d7FaUq5Iy3+9qZ
   BppTr1Dnqbz3obRarLgFZfRZA8EHugk4LxL4Sfz41H+a+kY08cHVh+xXP
   ORn3rrx1MTbyk9SQPz1JzaqdPgif8LlrSk4vQPajg30KGPeEgh33kKEBm
   5xedkALp97Uz0GvXPzpv+QAkPw2C+uDktOg3pt15tGYd30Q9lp9xK6h2B
   w==;
X-CSE-ConnectionGUID: mm5sszt4QyGQ40ERFaIzsQ==
X-CSE-MsgGUID: I2zfjR5BTkKDR4thLGXWUw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43768663"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="43768663"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 20:23:01 -0700
X-CSE-ConnectionGUID: EgZMI3Q5TIagp+jzCVWsjA==
X-CSE-MsgGUID: 5J2ZbrFnQKe3v04onl+6jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="122634739"
Received: from uaeoff-desk2.amr.corp.intel.com (HELO [10.124.220.142]) ([10.124.220.142])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 20:23:00 -0700
Message-ID: <9208619f-5640-47f8-ac46-898894198499@linux.intel.com>
Date: Wed, 19 Mar 2025 20:22:59 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/8] PCI/AER: Move AER stat collection out of
 __aer_print_error()
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <Terry.bowman@amd.com>
References: <20250319084050.366718-1-pandoh@google.com>
 <20250319084050.366718-4-pandoh@google.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250319084050.366718-4-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/19/25 1:40 AM, Jon Pan-Doh wrote:
> Decouple stat collection from internal AER print functions. AERs from ghes
> or cxl drivers have stat collection in pci_print_aer() as that is where
> aer_err_info is populated.

pci_print_aer() also seems to do more than printing the AER stat. Why only
care about stat collection in __aer_print_error(). If the motivation is 
to just improve the code readability, I am not sure it is worth the 
effort. Please correct me if my understanding is incorrect.
>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> ---
>   drivers/pci/pci.h      |  1 +
>   drivers/pci/pcie/aer.c | 10 ++++++----
>   drivers/pci/pcie/dpc.c |  1 +
>   3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 75985b96ecc1..9d63d32f041c 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -551,6 +551,7 @@ struct aer_err_info {
>   };
>   
>   int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
> +void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info);
>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);
>   
>   int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 7eeaad917134..8e4d4f9326e1 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -617,8 +617,7 @@ const struct attribute_group aer_stats_attr_group = {
>   	.is_visible = aer_stats_attrs_are_visible,
>   };
>   
> -static void pci_dev_aer_stats_incr(struct pci_dev *pdev,
> -				   struct aer_err_info *info)
> +void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
>   {
>   	unsigned long status = info->status & ~info->mask;
>   	int i, max = -1;
> @@ -691,7 +690,6 @@ static void __aer_print_error(struct pci_dev *dev,
>   		aer_printk(level, dev, "   [%2d] %-22s%s\n", i, errmsg,
>   				info->first_error == i ? " (First)" : "");
>   	}
> -	pci_dev_aer_stats_incr(dev, info);
>   }
>   
>   void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
> @@ -784,6 +782,8 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	info.mask = mask;
>   	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>   
> +	pci_dev_aer_stats_incr(dev, &info);
> +
>   	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>   	__aer_print_error(dev, &info, level);
>   	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
> @@ -1263,8 +1263,10 @@ static inline void aer_process_err_devices(struct aer_err_info *e_info,
>   
>   	/* Report all before handle them, not to lost records by reset etc. */
>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
> -		if (aer_get_device_error_info(e_info->dev[i], e_info))
> +		if (aer_get_device_error_info(e_info->dev[i], e_info)) {
> +			pci_dev_aer_stats_incr(e_info->dev[i], e_info);
>   			aer_print_error(e_info->dev[i], e_info, level);
> +		}
>   	}
>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>   		if (aer_get_device_error_info(e_info->dev[i], e_info))
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 9e4c9ac737a7..81cd6e8ff3a4 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -289,6 +289,7 @@ void dpc_process_error(struct pci_dev *pdev)
>   	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
>   		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>   		 aer_get_device_error_info(pdev, &info)) {
> +		pci_dev_aer_stats_incr(pdev, &info);
>   		aer_print_error(pdev, &info, KERN_ERR);
>   		pci_aer_clear_nonfatal_status(pdev);
>   		pci_aer_clear_fatal_status(pdev);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


