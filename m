Return-Path: <linux-pci+bounces-28101-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E08BABD77F
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 13:55:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C606D16829E
	for <lists+linux-pci@lfdr.de>; Tue, 20 May 2025 11:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D1527BF85;
	Tue, 20 May 2025 11:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="CQn7nIlY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6710D276030;
	Tue, 20 May 2025 11:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747742146; cv=none; b=SmHnhIYI71DXEUQGgJIH1/XriJAi8Qattbpcp+o6ycxU2Xqyg305Z/b8Z10CDNi0UsOu03rVWw29GdC5cz9tbvzFqeL5MCNCfeGt2urxfcCgBI0Hta8L3xNvclBsZduHkX37hgI5zjItftho1ZxYhKF2c8Pt/D/wanNiSqqZNOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747742146; c=relaxed/simple;
	bh=vvt5Aff1jYxxBlojONYn3kzxnHulIt+0qte78GboiKo=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=tUvM8KwfYGWwh9qOyh0N7LgGCHYUKxvxykHURQiXwPYPu4upynu14oKKGkAF3QTBat1NpJUNj9sdisxYYZz/1y3ch0VZ/9Cm4hlDmAZO2bAK4zph4m2+ij89WoAsRiDMEexTpm1BIG6rB36hvvIn8TS19JBzPaJGZmUE+uvZTng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=CQn7nIlY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1747742145; x=1779278145;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=vvt5Aff1jYxxBlojONYn3kzxnHulIt+0qte78GboiKo=;
  b=CQn7nIlYMxkOMZQgXpSW8Yy/ev/L91U4CihEmu3VbLzU//0fne/Lr5lq
   RsBz2HF7374ul0JkGGIoEs+MaKN2pVoF/T9eACIzDakf+aDM3qcvpQVzi
   FmAvZi4Le3cyYHHAwX0NZM5DICtSqk4R5J0oFu8AQGpXwVLDgMZFH7tiT
   I9JORkbg6+TUTnd5emfAwmhrt05kLyhimoXaS6YerlQMXTnTyAXff+V91
   glt4ZD0Cta63gzD3qW2FIxxLHqU48Vl3ADf9WTPt85ODX3h68pneA1sHR
   xE777LVomx1hoYIKBJDDYmrU0WZ3Hv0KfdEv6IAQXsE0Qo5nEP9DjZ+q1
   g==;
X-CSE-ConnectionGUID: hfuHUR8hSleSaHXa7kShig==
X-CSE-MsgGUID: 5W3eq2T7TyGsO9pNk8NFAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11438"; a="49772794"
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="49772794"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:55:43 -0700
X-CSE-ConnectionGUID: eZCTOcbDQuSsQmsfQff0fQ==
X-CSE-MsgGUID: 63G9ibHYRB2pLuOX+dQZgA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,302,1739865600"; 
   d="scan'208";a="144421998"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.235])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2025 04:55:35 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 20 May 2025 14:55:32 +0300 (EEST)
To: Bjorn Helgaas <helgaas@kernel.org>
cc: linux-pci@vger.kernel.org, Jon Pan-Doh <pandoh@google.com>, 
    Karolina Stolarek <karolina.stolarek@oracle.com>, 
    Martin Petersen <martin.petersen@oracle.com>, 
    Ben Fuller <ben.fuller@oracle.com>, Drew Walton <drewwalton@microsoft.com>, 
    Anil Agrawal <anilagrawal@meta.com>, Tony Luck <tony.luck@intel.com>, 
    Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>, 
    Lukas Wunner <lukas@wunner.de>, 
    Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
    Sargun Dhillon <sargun@meta.com>, "Paul E . McKenney" <paulmck@kernel.org>, 
    Mahesh J Salgaonkar <mahesh@linux.ibm.com>, 
    Oliver O'Halloran <oohall@gmail.com>, Kai-Heng Feng <kaihengf@nvidia.com>, 
    Keith Busch <kbusch@kernel.org>, Robert Richter <rrichter@amd.com>, 
    Terry Bowman <terry.bowman@amd.com>, Shiju Jose <shiju.jose@huawei.com>, 
    Dave Jiang <dave.jiang@intel.com>, LKML <linux-kernel@vger.kernel.org>, 
    linuxppc-dev@lists.ozlabs.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH v6 14/16] PCI/AER: Introduce ratelimit for error logs
In-Reply-To: <20250519213603.1257897-15-helgaas@kernel.org>
Message-ID: <a983acbd-bf6e-63df-a3cc-e4d61a602537@linux.intel.com>
References: <20250519213603.1257897-1-helgaas@kernel.org> <20250519213603.1257897-15-helgaas@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Mon, 19 May 2025, Bjorn Helgaas wrote:

> From: Jon Pan-Doh <pandoh@google.com>
> 
> Spammy devices can flood kernel logs with AER errors and slow/stall
> execution. Add per-device ratelimits for AER correctable and uncorrectable
> errors that use the kernel defaults (10 per 5s).
> 
> There are two AER logging entry points:
> 
>   - aer_print_error() is used by DPC and native AER
> 
>   - pci_print_aer() is used by GHES and CXL
> 
> The native AER aer_print_error() case includes a loop that may log details
> from multiple devices.  This is ratelimited by the union of ratelimits for
> these devices, set by add_error_device(), which collects the devices.  If
> no such device is found, the Error Source message is ratelimited by the
> Root Port or RCEC that received the ERR_* message.
> 
> The DPC aer_print_error() case is currently not ratelimited.
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
>  drivers/pci/pci.h      |  3 ++-
>  drivers/pci/pcie/aer.c | 49 ++++++++++++++++++++++++++++++++++++------
>  drivers/pci/pcie/dpc.c |  1 +
>  3 files changed, 46 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index 705f9ef58acc..65c466279ade 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -593,7 +593,8 @@ struct aer_err_info {
>  	unsigned int id:16;
>  
>  	unsigned int severity:2;	/* 0:NONFATAL | 1:FATAL | 2:COR */
> -	unsigned int __pad1:5;
> +	unsigned int ratelimit:1;	/* 0=skip, 1=print */
> +	unsigned int __pad1:4;
>  	unsigned int multi_error_valid:1;
>  
>  	unsigned int first_error:5;
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index da62032bf024..c335e0bb9f51 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -28,6 +28,7 @@
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
>  #include <linux/kfifo.h>
> +#include <linux/ratelimit.h>
>  #include <linux/slab.h>
>  #include <acpi/apei.h>
>  #include <acpi/ghes.h>
> @@ -88,6 +89,10 @@ struct aer_report {
>  	u64 rootport_total_cor_errs;
>  	u64 rootport_total_fatal_errs;
>  	u64 rootport_total_nonfatal_errs;
> +
> +	/* Ratelimits for errors */
> +	struct ratelimit_state cor_log_ratelimit;
> +	struct ratelimit_state uncor_log_ratelimit;
>  };
>  
>  #define AER_LOG_TLP_MASKS		(PCI_ERR_UNC_POISON_TLP|	\
> @@ -379,6 +384,11 @@ void pci_aer_init(struct pci_dev *dev)
>  
>  	dev->aer_report = kzalloc(sizeof(*dev->aer_report), GFP_KERNEL);
>  
> +	ratelimit_state_init(&dev->aer_report->cor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +	ratelimit_state_init(&dev->aer_report->uncor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST);
> +
>  	/*
>  	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
>  	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
> @@ -672,6 +682,18 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>  	}
>  }
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
>  static void __aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  {
>  	const char **strings;
> @@ -715,6 +737,9 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>  
>  	pci_dev_aer_stats_incr(dev, info);
>  
> +	if (!info->ratelimit)
> +		return;
> +
>  	if (!info->status) {
>  		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>  			aer_error_severity_string[info->severity]);
> @@ -785,6 +810,9 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>  
>  	pci_dev_aer_stats_incr(dev, &info);
>  
> +	if (!aer_ratelimit(dev, info.severity))
> +		return;
> +
>  	layer = AER_GET_LAYER_ERROR(aer_severity, status);
>  	agent = AER_GET_AGENT(aer_severity, status);
>  
> @@ -815,8 +843,14 @@ EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>   */
>  static int add_error_device(struct aer_err_info *e_info, struct pci_dev *dev)
>  {
> +	/*
> +	 * Ratelimit AER log messages.  Generally we add the Error Source
> +	 * device, but there are is_error_source() cases that can result in
> +	 * multiple devices being added here, so we OR them all together.

I can see the code uses OR ;-) but I wasn't helpful because this comment 
didn't explain why at all. As this ratelimit thing is using reverse logic 
to begin with, this is a very tricky bit.

Perhaps something less vague like:

... we ratelimit if all devices have reached their ratelimit.

Assuming that was the intention here? (I'm not sure.)

> +	 */
>  	if (e_info->error_dev_num < AER_MAX_MULTI_ERR_DEVICES) {
>  		e_info->dev[e_info->error_dev_num] = pci_dev_get(dev);
> +		e_info->ratelimit |= aer_ratelimit(dev, e_info->severity);
>  		e_info->error_dev_num++;
>  		return 0;
>  	}
> @@ -914,7 +948,7 @@ static int find_device_iter(struct pci_dev *dev, void *data)
>   * e_info->error_dev_num and e_info->dev[], based on the given information.
>   */
>  static bool find_source_device(struct pci_dev *parent,
> -		struct aer_err_info *e_info)
> +			       struct aer_err_info *e_info)
>  {
>  	struct pci_dev *dev = parent;
>  	int result;
> @@ -935,10 +969,12 @@ static bool find_source_device(struct pci_dev *parent,
>  	/*
>  	 * If we didn't find any devices with errors logged in the AER
>  	 * Capability, just print the Error Source ID from the Root Port or
> -	 * RCEC that received an ERR_* Message.
> +	 * RCEC that received an ERR_* Message, ratelimited by the RP or
> +	 * RCEC.
>  	 */
>  	if (!e_info->error_dev_num) {
> -		aer_print_source(parent, e_info, " (no details found)");
> +		if (aer_ratelimit(parent, e_info->severity))
> +			aer_print_source(parent, e_info, " (no details found)");
>  		return false;
>  	}
>  	return true;
> @@ -1147,9 +1183,10 @@ static void aer_recover_work_func(struct work_struct *work)
>  		pdev = pci_get_domain_bus_and_slot(entry.domain, entry.bus,
>  						   entry.devfn);
>  		if (!pdev) {
> -			pr_err("no pci_dev for %04x:%02x:%02x.%x\n",
> -			       entry.domain, entry.bus,
> -			       PCI_SLOT(entry.devfn), PCI_FUNC(entry.devfn));
> +			pr_err_ratelimited("%04x:%02x:%02x.%x: no pci_dev found\n",

This case was not mentioned in the changelog.

> +					   entry.domain, entry.bus,
> +					   PCI_SLOT(entry.devfn),
> +					   PCI_FUNC(entry.devfn));
>  			continue;
>  		}
>  		pci_print_aer(pdev, entry.severity, entry.regs);
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index 34af0ea45c0d..597df7790f36 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -301,6 +301,7 @@ void dpc_process_error(struct pci_dev *pdev)
>  	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
>  		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>  		 aer_get_device_error_info(pdev, &info)) {
> +		info.ratelimit = 1;	/* no ratelimiting */
>  		aer_print_error(pdev, &info);
>  		pci_aer_clear_nonfatal_status(pdev);
>  		pci_aer_clear_fatal_status(pdev);
> 

-- 
 i.


