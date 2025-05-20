Return-Path: <linux-pci+bounces-28056-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 44EE5ABCD70
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 04:49:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C5FE3B52C1
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 02:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA54256C73;
	Tue, 20 May 2025 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZuGRy/oG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C42E21D3C6;
	Tue, 20 May 2025 02:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747709349; cv=none; b=XPGbvwld3VutGgfVaaaeHLZ/uoUcDCHjgHRPevntZNXGIkU28bKSIHr+d5gdVcVDQjW9xlrekmgUWpHUa+DVDabfh+TEXI0z2eKg29nC35cDCuwRzX1XDQxDNvFixU2wRZnIz6+8UvE3d25iiGBSb+/MqOfzScYtZMzcv/5+aeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747709349; c=relaxed/simple;
	bh=f+EwkHAuPc4qt8/+C6P/FzidlYLXQ88MqyHsnREda2Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=j16nsRseR+GXzFpIUQQLqsK0/PejyAabHhy7Rr8pGD2JIpWj9v/qIoA5+is1YXb8gP8FMC45MXV+16Z2HkKg1jpPC31sfoWrC0hEOLNu0sICdF0vWiG0NJNKus3UwEpPsWDcGB0YsUd505bS65yI84mIBJM9NIxN+LhLv0Jvz90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZuGRy/oG; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747709347; x=1779245347;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=f+EwkHAuPc4qt8/+C6P/FzidlYLXQ88MqyHsnREda2Q=;
  b=ZuGRy/oGkjdrs25deKqIuj1nMUzBWG2r83IrPmAWE3fJ448A6v5pAUcu
   HGhrtWn+ZrXUmC0S7IavIs0pghjm/FENrofwFh8oGkXKp+3tnUXlpVGco
   NVbrLkC3VZ6YwfHlbxCd491d8k4vK3k9mMousUMJfMKbyaptOZ1dwBwWz
   K0/mv9AJUlXUuXd9zwdrVmOOmKZh5+qqmLOIghjSkCxwsRrfa076N7vJx
   7P/sPA/N5DQ0OVsRcuRLHpxBDKS6A50wNvV9YKKuNKBXOZ2VRQzV628Ma
   azp57n1IO+upa/ri5v0fotTUMh2mL+wgHFqYkebc2jnfhgYtGB5SOzDaI
   w==;
X-CSE-ConnectionGUID: vuX0ePrmTaSqnDKSxJFJmg==
X-CSE-MsgGUID: fVneOD5qRTWa+LOpL1sRoQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49726510"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49726510"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:49:07 -0700
X-CSE-ConnectionGUID: FpHOij47RNKOcpBMhhPAWw==
X-CSE-MsgGUID: MnG31mjTQeSpvoOY4NMz0A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144303750"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 19:49:05 -0700
Message-ID: <ea5d0024-9483-4069-aa6f-b859bfa58a4a@linux.intel.com>
Date: Mon, 19 May 2025 19:49:04 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 11/16] PCI/AER: Check log level once and remember it
To: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
Cc: Jon Pan-Doh <pandoh@google.com>,
 Karolina Stolarek <karolina.stolarek@oracle.com>,
 Martin Petersen <martin.petersen@oracle.com>,
 Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>,
 Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>,
 Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>,
 Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>,
 Dave Jiang <dave.jiang@intel.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
References: <20250519213603.1257897-1-helgaas@kernel.org>
 <20250519213603.1257897-12-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-12-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Karolina Stolarek <karolina.stolarek@oracle.com>
>
> When reporting an AER error, we check its type multiple times to determine
> the log level for each message. Do this check only in the top-level
> functions (aer_isr_one_error(), pci_print_aer()) and save the level in
> struct aer_err_info.
>
> [bhelgaas: save log level in struct aer_err_info instead of passing it
> as a parameter]
> Link: https://lore.kernel.org/r/20250321015806.954866-2-pandoh@google.com
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pci.h      |  1 +
>   drivers/pci/pcie/aer.c | 21 ++++++++++-----------
>   drivers/pci/pcie/dpc.c |  1 +
>   3 files changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b81e99cd4b62..705f9ef58acc 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -588,6 +588,7 @@ static inline bool pci_dev_test_and_set_removed(struct pci_dev *dev)
>   struct aer_err_info {
>   	struct pci_dev *dev[AER_MAX_MULTI_ERR_DEVICES];
>   	int error_dev_num;
> +	const char *level;		/* printk level */
>   
>   	unsigned int id:16;
>   
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 4683a99c7568..73b03a195b14 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -672,21 +672,18 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>   	}
>   }
>   
> -static void __aer_print_error(struct pci_dev *dev,
> -			      struct aer_err_info *info)
> +static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   {
>   	const char **strings;
>   	unsigned long status = info->status & ~info->mask;
> -	const char *level, *errmsg;
> +	const char *level = info->level;
> +	const char *errmsg;
>   	int i;
>   
> -	if (info->severity == AER_CORRECTABLE) {
> +	if (info->severity == AER_CORRECTABLE)
>   		strings = aer_correctable_error_string;
> -		level = KERN_WARNING;
> -	} else {
> +	else
>   		strings = aer_uncorrectable_error_string;
> -		level = KERN_ERR;
> -	}
>   
>   	for_each_set_bit(i, &status, 32) {
>   		errmsg = strings[i];
> @@ -714,7 +711,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   {
>   	int layer, agent;
>   	int id = pci_dev_id(dev);
> -	const char *level;
> +	const char *level = info->level;
>   
>   	pci_dev_aer_stats_incr(dev, info);
>   
> @@ -727,8 +724,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>   	agent = AER_GET_AGENT(info->severity, info->status);
>   
> -	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
> -
>   	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>   		   aer_error_severity_string[info->severity],
>   		   aer_error_layer[layer], aer_agent_string[agent]);
> @@ -774,9 +769,11 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	if (aer_severity == AER_CORRECTABLE) {
>   		status = aer->cor_status;
>   		mask = aer->cor_mask;
> +		info.level = KERN_WARNING;
>   	} else {
>   		status = aer->uncor_status;
>   		mask = aer->uncor_mask;
> +		info.level = KERN_ERR;
>   		tlp_header_valid = status & AER_LOG_TLP_MASKS;
>   	}
>   
> @@ -1297,6 +1294,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   		struct aer_err_info e_info = {
>   			.id = ERR_COR_ID(e_src->id),
>   			.severity = AER_CORRECTABLE,
> +			.level = KERN_WARNING,
>   			.multi_error_valid = multi ? 1 : 0,
>   		};
>   
> @@ -1312,6 +1310,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   		struct aer_err_info e_info = {
>   			.id = ERR_UNCOR_ID(e_src->id),
>   			.severity = fatal ? AER_FATAL : AER_NONFATAL,
> +			.level = KERN_ERR,
>   			.multi_error_valid = multi ? 1 : 0,
>   		};
>   
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 315bf2bfd570..34af0ea45c0d 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -252,6 +252,7 @@ static int dpc_get_aer_uncorrect_severity(struct pci_dev *dev,
>   	else
>   		info->severity = AER_NONFATAL;
>   
> +	info->level = KERN_WARNING;

As Weinan pointed out, it should be KERN_ERR.

>   	return 1;
>   }
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


