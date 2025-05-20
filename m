Return-Path: <linux-pci+bounces-28063-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BF9AABCE59
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 06:59:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E38B3A94FA
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 04:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FFC21D3C6;
	Tue, 20 May 2025 04:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XDiKeq5+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5AE33F9;
	Tue, 20 May 2025 04:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747717176; cv=none; b=dOkwPoS6CjYi34CdtOY/e1fA0HnvECfBnmvkpPnhSeD1RMOC8M+uDbcaQqW0fUjSHr5LMdGxDtH8KqQ6GUfkCOJr+vL6QBurrD+bqQE+MnX8CtTDKU2gG1Zdv1dVMXktieywzXgvCm2ZZdXsmV5OVfwkyKCliAC1bzVJrUpIGdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747717176; c=relaxed/simple;
	bh=GZDcuorP/pXX666TLKaJr4ROBUaG28ei/hv6M8Pc4+A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H7tm3J3/km0EKNC5Ez5wGVmYCtyRZfs1ar9JuuN1J8HlQ4lO7DjzOrbOPNpSHB82xMak2NnMIZ/3TOxSCDnMw5NyoirUzbtksOQqeqqn/lssIU5VMmWPS/92lBNVafopwC+0/1QMwF5EhLfr87fpWn5p95Q5rTQTbMwEhwe06NY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XDiKeq5+; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747717174; x=1779253174;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GZDcuorP/pXX666TLKaJr4ROBUaG28ei/hv6M8Pc4+A=;
  b=XDiKeq5+nJkVRD47Ci6vS/netqSeim3dOXhP9WNAhVWlyJi6oXr9fVWk
   W+5WdBTYw1hpExR0jU4+TT0NomlWomXxB+zML4V8SJAkECMQDz/mTkd71
   egfvSBtRM5LPyeFS+IkCkZpYdj8sjiut8nihNKaxiiVn1O3IPhLDgrM42
   fIcKVSRat/JCDwuR18ccDelxY7pnk7os2ps8RIdc/LVVCgewOjJsI1WSt
   1Tg+C7ncXprIKM6DR+hQLStjTYTC5OthfbL1559A0e+xpje9KRvar/eLL
   yJMq/5/AaTvKpx0DHrSmgX+aRghq0KbsA5X5vbsD4kNaWU4dE2GGfrfJl
   A==;
X-CSE-ConnectionGUID: Trf4vIapTsu8417lewlqMA==
X-CSE-MsgGUID: VVUc8rAdSkK5jt94RvRDiw==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="37251631"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="37251631"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:59:33 -0700
X-CSE-ConnectionGUID: 0keAV7GJTkOovI04xB5YHA==
X-CSE-MsgGUID: vSHYEWaeQXqQ/cV2uOL9Uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="139305901"
Received: from mdroper-mobl2.amr.corp.intel.com (HELO [10.124.221.39]) ([10.124.221.39])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:59:31 -0700
Message-ID: <e056eb23-e38a-4a0e-83d7-c17c62c0f9f7@linux.intel.com>
Date: Mon, 19 May 2025 21:59:29 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 14/16] PCI/AER: Introduce ratelimit for error logs
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
 <20250519213603.1257897-15-helgaas@kernel.org>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250519213603.1257897-15-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Bjorn,

On 5/19/25 2:35 PM, Bjorn Helgaas wrote:
> From: Jon Pan-Doh <pandoh@google.com>
>
> Spammy devices can flood kernel logs with AER errors and slow/stall
> execution. Add per-device ratelimits for AER correctable and uncorrectable
> errors that use the kernel defaults (10 per 5s).
>
> There are two AER logging entry points:
>
>    - aer_print_error() is used by DPC and native AER
>
>    - pci_print_aer() is used by GHES and CXL
>
> The native AER aer_print_error() case includes a loop that may log details
> from multiple devices.  This is ratelimited by the union of ratelimits for
> these devices, set by add_error_device(), which collects the devices.  If
> no such device is found, the Error Source message is ratelimited by the
> Root Port or RCEC that received the ERR_* message.
>
> The DPC aer_print_error() case is currently not ratelimited.

Can we also not rate limit fatal errors in AER driver?

>
> The GHES and CXL pci_print_aer() cases are ratelimited by the Error Source
> device.
>
> Sargun at Meta reported internally that a flood of AER errors causes RCU
> CPU stall warnings and CSD-lock warnings.
>
> Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
> while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
> true count of 11.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
>
> [bhelgaas: commit log, factor out trace_aer_event() and aer_print_rp_info()
> changes to previous patches, collect single aer_err_info.ratelimit as union
> of ratelimits of all error source devices]
> Link: https://lore.kernel.org/r/20250321015806.954866-7-pandoh@google.com
> Reported-by: Sargun Dhillon <sargun@meta.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>   drivers/pci/pci.h      |  3 ++-
>   drivers/pci/pcie/aer.c | 49 ++++++++++++++++++++++++++++++++++++------
>   drivers/pci/pcie/dpc.c |  1 +
>   3 files changed, 46 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 705f9ef58acc..65c466279ade 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -593,7 +593,8 @@ struct aer_err_info {
>   	unsigned int id:16;
>   
>   	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
> -	unsigned int __pad1:5;
> +	unsigned int ratelimit:1;	/* 0=skip, 1=print */
> +	unsigned int __pad1:4;
>   	unsigned int multi_error_valid:1;
>   
>   	unsigned int first_error:5;
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index da62032bf024..c335e0bb9f51 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -28,6 +28,7 @@
>   #include <linux/interrupt.h>
>   #include <linux/delay.h>
>   #include <linux/kfifo.h>
> +#include <linux/ratelimit.h>
>   #include <linux/slab.h>
>   #include <acpi/apei.h>
>   #include <acpi/ghes.h>
> @@ -88,6 +89,10 @@ struct aer_report {
>   	u64 rootport_total_cor_errs;
>   	u64 rootport_total_fatal_errs;
>   	u64 rootport_total_nonfatal_errs;
> +
> +	/* Ratelimits for errors */
> +	struct ratelimit_state cor_log_ratelimit;
> +	struct ratelimit_state uncor_log_ratelimit;
>   };
>   
>   #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
> @@ -379,6 +384,11 @@ void pci_aer_init(struct pci_dev *dev)
>   
>   	dev->aer_report = kzalloc(sizeof(*dev->aer_report), GFP_KERNEL);
>   
> +	ratelimit_state_init(&dev->aer_report->cor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +	ratelimit_state_init(&dev->aer_report->uncor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +
>   	/*
>   	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
>   	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
> @@ -672,6 +682,18 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>   	}
>   }
>   
> +static int aer_ratelimit(struct pci_dev *dev, unsigned int severity)
> +{
> +	struct ratelimit_state *ratelimit;
> +
> +	if (severity == AER_CORRECTABLE)
> +		ratelimit = &dev->aer_report->cor_log_ratelimit;
> +	else
> +		ratelimit = &dev->aer_report->uncor_log_ratelimit;
> +
> +	return __ratelimit(ratelimit);
> +}
> +
>   static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   {
>   	const char **strings;
> @@ -715,6 +737,9 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   
>   	pci_dev_aer_stats_incr(dev, info);
>   
> +	if (!info->ratelimit)
> +		return;
> +
>   	if (!info->status) {
>   		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>   			aer_error_severity_string[info->severity]);
> @@ -785,6 +810,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   
>   	pci_dev_aer_stats_incr(dev, &info);
>   
> +	if (!aer_ratelimit(dev, info.severity))
> +		return;
> +
>   	layer = AER_GET_LAYER_ERROR(aer_severity, status);
>   	agent = AER_GET_AGENT(aer_severity, status);
>   
> @@ -815,8 +843,14 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>    */
>   static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>   {
> +	/*
> +	 * Ratelimit AER log messages.  Generally we add the Error Source
> +	 * device, but there are is_error_source() cases that can result in
> +	 * multiple devices being added here, so we OR them all together.
> +	 */
>   	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
>   		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> +		e_info->ratelimit |= aer_ratelimit(dev, e_info->severity);
>   		e_info->error_dev_num++;
>   		return 0;
>   	}
> @@ -914,7 +948,7 @@ static int find_device_iter(struct pci_dev *dev, void *data)
>    * e_info->error_dev_num and e_info->dev[], based on the given information.
>    */
>   static bool find_source_device(struct pci_dev *parent,
> -		struct aer_err_info *e_info)
> +			       struct aer_err_info *e_info)
>   {
>   	struct pci_dev *dev = parent;
>   	int result;
> @@ -935,10 +969,12 @@ static bool find_source_device(struct pci_dev *parent,
>   	/*
>   	 * If we didn't find any devices with errors logged in the AER
>   	 * Capability, just print the Error Source ID from the Root Port or
> -	 * RCEC that received an ERR_* Message.
> +	 * RCEC that received an ERR_* Message, ratelimited by the RP or
> +	 * RCEC.
>   	 */
>   	if (!e_info->error_dev_num) {
> -		aer_print_source(parent, e_info, " (no details found)");
> +		if (aer_ratelimit(parent, e_info->severity))
> +			aer_print_source(parent, e_info, " (no details found)");
>   		return false;
>   	}
>   	return true;
> @@ -1147,9 +1183,10 @@ static void aer_recover_work_func(struct work_struct *work)
>   		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
>   						   entry.devfn);
>   		if (!pdev) {
> -			pr_err("no pci_dev for %04x:%02x:%02x.%x\n",
> -			       entry.domain, entry.bus,
> -			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
> +			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",
> +					   entry.domain, entry.bus,
> +					   PCI_SLOT(entry.devfn),
> +					   PCI_FUNC(entry.devfn));
>   			continue;
>   		}
>   		pci_print_aer(pdev, entry.severity, entry.regs);
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 34af0ea45c0d..597df7790f36 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -301,6 +301,7 @@ void dpc_process_error(struct pci_dev *pdev)
>   	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
>   		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>   		 aer_get_device_error_info(pdev, &info)) {
> +		info.ratelimit = 1;	/* no ratelimiting */
>   		aer_print_error(pdev, &info);
>   		pci_aer_clear_nonfatal_status(pdev);
>   		pci_aer_clear_fatal_status(pdev);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


