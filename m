Return-Path: <linux-pci+bounces-24198-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF9DA69ED5
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 04:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CB826468196
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 03:29:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEEA71EB9E3;
	Thu, 20 Mar 2025 03:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Sekb1wqH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D2D1C54A6
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 03:29:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742441359; cv=none; b=NOacoSkxBucrCv6zIRl70WZUG9lcWEsNymYk7q7J5xPKsjlWoTfazCLKRCQPhkm6upaMG1uObHqcew33VtRRUp29JtyTQAWIs5JSFYYLY6wi5LisH777kdHcGhE3J/lb2f2IpkV3swtUWLgqjeofaf9W/GtAZ46S/kOHMad4CLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742441359; c=relaxed/simple;
	bh=fFlivDYclXW/i1cnFOkgFcEHRoAVaVbxhwOwezc20Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NId28T0Z9zfm7OKNM707OCFn/XaX4XtL3FouCflY9vvaH+B33m+fXMaM1dd6oUUNDQdkDQXSOvtX4bMX48xTgCz3WuvcLZWz/0C8zDKrxq5hfqt/FKVpGa9nke5MgBIYtfat1dtPXPe7X6Zbah/wFU593T8oIpchT0JiDjW2VLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Sekb1wqH; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742441358; x=1773977358;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=fFlivDYclXW/i1cnFOkgFcEHRoAVaVbxhwOwezc20Qw=;
  b=Sekb1wqH5LGa/Gr8vtOdGB8j/hQVDv/Z69dySoBxW4xWz4TjsFgUZzMu
   MtQMJKB58vXAZh9tF8e/ruK3oKHU5g7MGvS4OAIM0E0VJS2lGi5KJSrcW
   wvo1XVlZPMzcwPkUZX6iFak8zqK83vogznuJrF+fm/yGapHqQjy7stPpd
   C2d4Xpx9i/qs1DAwhWHIxPyFTJNu9YnigbPgiB6a6TdDDKsQc/SxDR0Ma
   V0zVd987NvQElzhYkOt4qMnTXykDuJ2HKKwtqFXIG4VgytpR3QZf7fByu
   UhDNPXNLHnZdkkRYGZV78s+2FGN+ZUvpEzgj/5lO1pfGHoqQn/fFUNJ06
   g==;
X-CSE-ConnectionGUID: a3kzalHGSJifbBdQ6dIfjA==
X-CSE-MsgGUID: sTLq5U4UT8CSjLmqsNvADw==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="43545709"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="43545709"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 20:29:17 -0700
X-CSE-ConnectionGUID: meZ2P9HwQPiU0CYDZC37Zw==
X-CSE-MsgGUID: XvSnoRHzQdylGVlzGLswkg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="122872659"
Received: from uaeoff-desk2.amr.corp.intel.com (HELO [10.124.220.142]) ([10.124.220.142])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 20:29:16 -0700
Message-ID: <8e0a2c15-f26d-451d-b91d-bc7b8029a9af@linux.intel.com>
Date: Wed, 19 Mar 2025 20:29:15 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/8] PCI/AER: Rename struct aer_stats to aer_report
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
 <20250319084050.366718-5-pandoh@google.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250319084050.366718-5-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 3/19/25 1:40 AM, Jon Pan-Doh wrote:
> Update name to reflect the broader definition of structs/variables that
> are stored (e.g. ratelimits).
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
> index 8e4d4f9326e1..3a12980f7dd7 100644
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

This struct only seems to have details related to AER error status. Why 
rename
it to aer_report() ? Are you extending it in future patches? If yes, 
include that
motivation in the commit log.

>   
>   	/*
> -	 * Fields for all AER capable devices. They indicate the errors
> +	 * Stats for all AER capable devices. They indicate the errors
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


