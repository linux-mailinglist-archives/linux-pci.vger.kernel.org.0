Return-Path: <linux-pci+bounces-24244-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A8AE8A6AC43
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 18:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C33447A48A0
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257811DFDB9;
	Thu, 20 Mar 2025 17:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="St3Mtc8W"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118951D7E41
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 17:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742492531; cv=none; b=pHn9S2NAT5yLzi1p+JJMDZ2nzUcbnK4w32RU+N2Yq1YOO9gpf5WZLkYeUooiyXEVaX9djqsQHFJCDbG55NTQyzFJLebx3og67uKJcaa1jOrojpBGSgAsC1i6TyDpkWuNERVeI8pERrBx/I/xn0DoGvm2gZzsxStRiBYVXeWTFSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742492531; c=relaxed/simple;
	bh=9Pv/qoo4bYyr300IUP594unVIKy2BaWn3Zfq4WBDwKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=INAKfPPunIcNKS5PQuDPNT1VkWiUZJUJ+89EdTAkx8J3d2nRfzQMi1X1y/xAC6Jmvp9uPqVrXXYifIKPyDbkHoZQWFsUlr08MeBTK7TuXvduzxlftzrIjAr/eyYOkFJVNFCdLoAPWCqZK/93ZLHv6fv+e9DCwB9Amjrg/vIASGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=St3Mtc8W; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742492529; x=1774028529;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9Pv/qoo4bYyr300IUP594unVIKy2BaWn3Zfq4WBDwKg=;
  b=St3Mtc8Ws+IMLAQZUX+eIrYhX2mD4BIhfMuj5L5cnsmEqPbQZWLMN83Z
   xM1C3UInoybAN5booqIUIB/xh8IyAxiG5rFi/GnSxPrfTYYne65QApBO8
   7UT9kzpXbsitSq581pPUWBsWtcyf0LWmo30Jn8uooF88vAqHRbyj8JCJ+
   c2+B0e9OkvXNyhiUm5KZRTUc/IkqY5VyRYIxnwX9fpOVPXd2U2NsEdl2H
   5pDQDAAP1DGNLh0GyHjXE1NZI0ovpiPyqqTNXhD8gDcGqF5y+0GHD+2UI
   /TkWfVVNgohS0t+iTVP8dF0i86Z5NE9GbHlq+4klHO3M4lwb0BhcV4stQ
   w==;
X-CSE-ConnectionGUID: yVNi6yORQAif+TIcbkLyxA==
X-CSE-MsgGUID: NA6uC+jsRxm3nK1U6wydLA==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="42986757"
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="42986757"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 10:42:08 -0700
X-CSE-ConnectionGUID: bdLSUF0pRSaojq6b1S9HbA==
X-CSE-MsgGUID: eTK1sFVdT3WBJ242kP3AEg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,262,1736841600"; 
   d="scan'208";a="123916607"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO [10.124.221.27]) ([10.124.221.27])
  by fmviesa009-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 10:42:07 -0700
Message-ID: <9aeae39b-b923-453f-975a-cf9445459b0e@linux.intel.com>
Date: Thu, 20 Mar 2025 10:42:07 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] PCI/AER: Rename struct aer_stats to aer_report
To: Jon Pan-Doh <pandoh@google.com>, Bjorn Helgaas <bhelgaas@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>
Cc: linux-pci@vger.kernel.org, Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Terry Bowman <Terry.bowman@amd.com>
References: <20250320082057.622983-1-pandoh@google.com>
 <20250320082057.622983-5-pandoh@google.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250320082057.622983-5-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/20/25 1:20 AM, Jon Pan-Doh wrote:
> Update name to reflect the broader definition of structs/variables that
> are stored (e.g. ratelimits).

I think you meant rate limit will be added by an upcoming patch. Please
mention that it is a preparatory patch for adding rate limit support.

or move this patch after ratelimit support patch. That way this rename
will make more sense.

>
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> ---
>   drivers/pci/pcie/aer.c | 50 +++++++++++++++++++++---------------------
>   include/linux/pci.h    |  2 +-
>   2 files changed, 26 insertions(+), 26 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index e5db1fdd8421..3069376b3553 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -54,11 +54,11 @@ struct aer_rpc {
>   	DECLARE_KFIFO(aer_fifo, struct aer_err_source, AER_ERROR_SOURCES_MAX);
>   };
>   
> -/* AER stats for the device */
> -struct aer_stats {
> +/* AER report for the device */
> +struct aer_report {

As Bjorn suggested, I also think be aer_info would be a better name for it.

>   
>   	/*
> -	 * Fields for all AER capable devices. They indicate the errors
> +	 * Stats for all AER capable devices. They indicate the errors

If you move this patch after ratelimit support patch, try adding that
detail in the help content as well.

May be "Tracks error statistics and AER debug related controls for all
AER capable devices"

>   	 * "as seen by this device". Note that this may mean that if an
>   	 * end point is causing problems, the AER counters may increment
>   	 * at its link partner (e.g. root port) because the errors will be
> @@ -80,7 +80,7 @@ struct aer_stats {
>   	u64 dev_total_nonfatal_errs;
>   
>   	/*
> -	 * Fields for Root ports & root complex event collectors only, these
> +	 * Stats for Root ports & root complex event collectors only, these
>   	 * indicate the total number of ERR_COR, ERR_FATAL, and ERR_NONFATAL
>   	 * messages received by the root port / event collector, INCLUDING the
>   	 * ones that are generated internally (by the rootport itself)
> @@ -377,7 +377,7 @@ void pci_aer_init(struct pci_dev *dev)
>   	if (!dev->aer_cap)
>   		return;
>   
> -	dev->aer_stats = kzalloc(sizeof(struct aer_stats), GFP_KERNEL);
> +	dev->aer_report = kzalloc(sizeof(*dev->aer_report), GFP_KERNEL);
>   
>   	/*
>   	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
> @@ -398,8 +398,8 @@ void pci_aer_init(struct pci_dev *dev)
>   
>   void pci_aer_exit(struct pci_dev *dev)
>   {
> -	kfree(dev->aer_stats);
> -	dev->aer_stats = NULL;
> +	kfree(dev->aer_report);
> +	dev->aer_report = NULL;
>   }
>   
>   #define AER_AGENT_RECEIVER		0
> @@ -537,10 +537,10 @@ static const char *aer_agent_string[] = {
>   {									\
>   	unsigned int i;							\
>   	struct pci_dev *pdev = to_pci_dev(dev);				\
> -	u64 *stats = pdev->aer_stats->stats_array;			\
> +	u64 *stats = pdev->aer_report->stats_array;			\
>   	size_t len = 0;							\
>   									\
> -	for (i = 0; i < ARRAY_SIZE(pdev->aer_stats->stats_array); i++) {\
> +	for (i = 0; i < ARRAY_SIZE(pdev->aer_report->stats_array); i++) {\
>   		if (strings_array[i])					\
>   			len += sysfs_emit_at(buf, len, "%s %llu\n",	\
>   					     strings_array[i],		\
> @@ -551,7 +551,7 @@ static const char *aer_agent_string[] = {
>   					     i, stats[i]);		\
>   	}								\
>   	len += sysfs_emit_at(buf, len, "TOTAL_%s %llu\n", total_string,	\
> -			     pdev->aer_stats->total_field);		\
> +			     pdev->aer_report->total_field);		\
>   	return len;							\
>   }									\
>   static DEVICE_ATTR_RO(name)
> @@ -572,7 +572,7 @@ aer_stats_dev_attr(aer_dev_nonfatal, dev_nonfatal_errs,
>   		     char *buf)						\
>   {									\
>   	struct pci_dev *pdev = to_pci_dev(dev);				\
> -	return sysfs_emit(buf, "%llu\n", pdev->aer_stats->field);	\
> +	return sysfs_emit(buf, "%llu\n", pdev->aer_report->field);	\
>   }									\
>   static DEVICE_ATTR_RO(name)
>   
> @@ -599,7 +599,7 @@ static umode_t aer_stats_attrs_are_visible(struct kobject *kobj,
>   	struct device *dev = kobj_to_dev(kobj);
>   	struct pci_dev *pdev = to_pci_dev(dev);
>   
> -	if (!pdev->aer_stats)
> +	if (!pdev->aer_report)
>   		return 0;
>   
>   	if ((a == &dev_attr_aer_rootport_total_err_cor.attr ||
> @@ -622,25 +622,25 @@ void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
>   	unsigned long status = info->status & ~info->mask;
>   	int i, max = -1;
>   	u64 *counter = NULL;
> -	struct aer_stats *aer_stats = pdev->aer_stats;
> +	struct aer_report *aer_report = pdev->aer_report;
>   
> -	if (!aer_stats)
> +	if (!aer_report)
>   		return;
>   
>   	switch (info->severity) {
>   	case AER_CORRECTABLE:
> -		aer_stats->dev_total_cor_errs++;
> -		counter = &aer_stats->dev_cor_errs[0];
> +		aer_report->dev_total_cor_errs++;
> +		counter = &aer_report->dev_cor_errs[0];
>   		max = AER_MAX_TYPEOF_COR_ERRS;
>   		break;
>   	case AER_NONFATAL:
> -		aer_stats->dev_total_nonfatal_errs++;
> -		counter = &aer_stats->dev_nonfatal_errs[0];
> +		aer_report->dev_total_nonfatal_errs++;
> +		counter = &aer_report->dev_nonfatal_errs[0];
>   		max = AER_MAX_TYPEOF_UNCOR_ERRS;
>   		break;
>   	case AER_FATAL:
> -		aer_stats->dev_total_fatal_errs++;
> -		counter = &aer_stats->dev_fatal_errs[0];
> +		aer_report->dev_total_fatal_errs++;
> +		counter = &aer_report->dev_fatal_errs[0];
>   		max = AER_MAX_TYPEOF_UNCOR_ERRS;
>   		break;
>   	}
> @@ -652,19 +652,19 @@ void pci_dev_aer_stats_incr(struct pci_dev *pdev, struct aer_err_info *info)
>   static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>   				 struct aer_err_source *e_src)
>   {
> -	struct aer_stats *aer_stats = pdev->aer_stats;
> +	struct aer_report *aer_report = pdev->aer_report;
>   
> -	if (!aer_stats)
> +	if (!aer_report)
>   		return;
>   
>   	if (e_src->status & PCI_ERR_ROOT_COR_RCV)
> -		aer_stats->rootport_total_cor_errs++;
> +		aer_report->rootport_total_cor_errs++;
>   
>   	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
>   		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
> -			aer_stats->rootport_total_fatal_errs++;
> +			aer_report->rootport_total_fatal_errs++;
>   		else
> -			aer_stats->rootport_total_nonfatal_errs++;
> +			aer_report->rootport_total_nonfatal_errs++;
>   	}
>   }
>   
> diff --git a/include/linux/pci.h b/include/linux/pci.h
> index e4bf67bf8172..900edb6f8f62 100644
> --- a/include/linux/pci.h
> +++ b/include/linux/pci.h
> @@ -346,7 +346,7 @@ struct pci_dev {
>   	u8		hdr_type;	/* PCI header type (`multi' flag masked out) */
>   #ifdef CONFIG_PCIEAER
>   	u16		aer_cap;	/* AER capability offset */
> -	struct aer_stats *aer_stats;	/* AER stats for this device */
> +	struct aer_report *aer_report;	/* AER report for this device */
>   #endif
>   #ifdef CONFIG_PCIEPORTBUS
>   	struct rcec_ea	*rcec_ea;	/* RCEC cached endpoint association */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


