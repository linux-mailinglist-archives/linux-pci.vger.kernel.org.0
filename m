Return-Path: <linux-pci+bounces-24281-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEEF1A6B277
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 02:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C21C8189D3F3
	for <lists+linux-pci@lfdr.de>; Fri, 21 Mar 2025 01:00:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 455F11EA65;
	Fri, 21 Mar 2025 01:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cZsQXIs8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DF0184F
	for <linux-pci@vger.kernel.org>; Fri, 21 Mar 2025 01:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742518813; cv=none; b=Yc2KQONPfqQ6ZSUTyZbczTG1q6ICBvL890Bq61tpHeLpD8fmRnk1BjD0y7IyP3XwT54RaZHSlD7rMWTHu+TIUsNrUXGvSLkDfHV5W/LpoKGjBP0zz3gM5AZdJdP5b10cRoQ2P2ML3fyO1SJN4Zaox74vZ8Q4J/4q6SfnI/XJPIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742518813; c=relaxed/simple;
	bh=auag+boPzIZDk5C2GRIwHjQpngviOwTfeK8A2SltueA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WrSAI8RR5GkH7cxA+UhrtuSSpWdwoqwjfWDAOdf+n4fQV5le9Fi0tCRowmKdhqLefe67GujsQfVJTHWbnTS3rB49KXITEnva4eUxZTqc/9JcxNbWZNJXp8gRdOWGk01CwPe2TbgThlI2ArZ05L1nRFVbzvBb3y8+XQNX03XZRtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cZsQXIs8; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742518812; x=1774054812;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=auag+boPzIZDk5C2GRIwHjQpngviOwTfeK8A2SltueA=;
  b=cZsQXIs8TxkG8P1ChxtKMSUGX/ZDUTQuEK46X7Jt8w9AlY6EzqRP3dzD
   XJrvIyDpeoZaZnTmuNtH+IY9qNU6kGp8p/gnRoktZ4uh4/HgurBrJ3LUp
   Oo8elcuaHWvJ+RK2xt565/bbHt0YJymMvnNkYIP066PvZoepfaxMWv5FZ
   ISdUaxlzJZgW6wJ9AZUNkznF9Wu6zBdSL5Y/49vchzWHQDk5X/52Wvk2j
   bwDyyBy5b/4gWnmjbdj7u+y3PJxNaJBAxhBYQG/PZkDpAVgTmEOSKh1Ts
   2V06NEewlUDd3Fm9GhPLQGBLxA4XErGwNzWiamk1YAjOA/L3m/StZb/ga
   A==;
X-CSE-ConnectionGUID: QgPWTlWgQwW0LQBMWhEpBw==
X-CSE-MsgGUID: +tt+IAW+SZ2Xx4f+6IgN5Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11379"; a="47552765"
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="47552765"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:00:10 -0700
X-CSE-ConnectionGUID: /tYNQ0nNQHmb0yyBN4FVcg==
X-CSE-MsgGUID: oOfE369BQ8yeTVwsRm/A+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,263,1736841600"; 
   d="scan'208";a="127415316"
Received: from jairdeje-mobl1.amr.corp.intel.com (HELO [10.124.221.27]) ([10.124.221.27])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2025 18:00:08 -0700
Message-ID: <85bd0cd9-c09f-464d-9397-ced829df27d7@linux.intel.com>
Date: Thu, 20 Mar 2025 18:00:08 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/7] PCI/AER: Introduce ratelimit for error logs
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
 <20250320082057.622983-6-pandoh@google.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250320082057.622983-6-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/20/25 1:20 AM, Jon Pan-Doh wrote:
> Spammy devices can flood kernel logs with AER errors and slow/stall
> execution. Add per-device ratelimits for AER correctable and uncorrectable
> errors that use the kernel defaults (10 per 5s).

Should we exclude fatal errors from the rate limit? Fatal error logs 
would be
really useful for debug analysis, and they not happen very frequently.

>
> Tested using aer-inject[1]. Sent 11 AER errors. Observed 10 errors logged
> while AER stats (cat /sys/bus/pci/devices/<dev>/aer_dev_correctable) show
> true count of 11.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/gong.chen/aer-inject.git
>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Reviewed-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> ---
>   drivers/pci/pcie/aer.c | 74 +++++++++++++++++++++++++++++++++---------
>   1 file changed, 58 insertions(+), 16 deletions(-)
>
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 3069376b3553..081cef5fc678 100644
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
> @@ -379,6 +384,15 @@ void pci_aer_init(struct pci_dev *dev)
>   
>   	dev->aer_report = kzalloc(sizeof(*dev->aer_report), GFP_KERNEL);
>   
> +	/*
> +	 * Ratelimits are doubled as a given error produces 2 logs (root port
> +	 * and endpoint) that should be under same ratelimit.
> +	 */
> +	ratelimit_state_init(&dev->aer_report->cor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST * 2);
> +	ratelimit_state_init(&dev->aer_report->uncor_log_ratelimit,
> +			     DEFAULT_RATELIMIT_INTERVAL, DEFAULT_RATELIMIT_BURST * 2);
> +
>   	/*
>   	 * We save/restore PCI_ERR_UNCOR_MASK, PCI_ERR_UNCOR_SEVER,
>   	 * PCI_ERR_COR_MASK, and PCI_ERR_CAP.  Root and Root Complex Event
> @@ -668,6 +682,17 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
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
> +	return __ratelimit(ratelimit);
> +}
> +
>   static void __aer_print_error(struct pci_dev *dev,
>   			      struct aer_err_info *info,
>   			      const char *level)
> @@ -698,6 +723,12 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
>   	int layer, agent;
>   	int id = pci_dev_id(dev);
>   
> +	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> +			info->severity, info->tlp_header_valid, &info->tlp);
> +
> +	if (!aer_ratelimit(dev, info->severity))
> +		return;
> +
>   	if (!info->status) {
>   		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
>   			aer_error_severity_string[info->severity]);
> @@ -722,21 +753,28 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
>   out:
>   	if (info->id && info->error_dev_num > 1 && info->id == id)
>   		pci_err(dev, "  Error of this Agent is reported first\n");
> -
> -	trace_aer_event(dev_name(&dev->dev), (info->status & ~info->mask),
> -			info->severity, info->tlp_header_valid, &info->tlp);
>   }
>   
>   static void aer_print_port_info(struct pci_dev *dev, struct aer_err_info *info)
>   {
>   	u8 bus = info->id >> 8;
>   	u8 devfn = info->id & 0xff;
> +	struct pci_dev *endpoint;
> +	int i;
> +
> +	/* extract endpoint device ratelimit */
> +	for (i = 0; i < info->error_dev_num; i++) {
> +		endpoint = info->dev[i];
> +		if (info->id == pci_dev_id(endpoint))
> +			break;
> +	}
>   
> -	pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> -		 info->multi_error_valid ? "Multiple " : "",
> -		 aer_error_severity_string[info->severity],
> -		 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> -		 PCI_FUNC(devfn));
> +	if (aer_ratelimit(endpoint, info->severity))
> +		pci_info(dev, "%s%s error message received from %04x:%02x:%02x.%d\n",
> +			 info->multi_error_valid ? "Multiple " : "",
> +			 aer_error_severity_string[info->severity],
> +			 pci_domain_nr(dev->bus), bus, PCI_SLOT(devfn),
> +			 PCI_FUNC(devfn));
>   }
>   
>   #ifdef CONFIG_ACPI_APEI_PCIEAER
> @@ -784,6 +822,12 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   
>   	pci_dev_aer_stats_incr(dev, &info);
>   
> +	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> +			aer_severity, tlp_header_valid, &aer->header_log);
> +
> +	if (!aer_ratelimit(dev, aer_severity))
> +		return;
> +
>   	aer_printk(level, dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
>   	__aer_print_error(dev, &info, level);
>   	aer_printk(level, dev, "aer_layer=%s, aer_agent=%s\n",
> @@ -795,9 +839,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   
>   	if (tlp_header_valid)
>   		pcie_print_tlp_log(dev, &aer->header_log, dev_fmt("  "));
> -
> -	trace_aer_event(dev_name(&dev->dev), (status & ~mask),
> -			aer_severity, tlp_header_valid, &aer->header_log);
>   }
>   EXPORT_SYMBOL_NS_GPL(pci_print_aer, "CXL");
>   
> @@ -1299,10 +1340,11 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   			e_info.multi_error_valid = 1;
>   		else
>   			e_info.multi_error_valid = 0;
> -		aer_print_port_info(pdev, &e_info);
>   
> -		if (find_source_device(pdev, &e_info))
> +		if (find_source_device(pdev, &e_info)) {
> +			aer_print_port_info(pdev, &e_info);
>   			aer_process_err_devices(&e_info, KERN_WARNING);
> +		}
>   	}
>   
>   	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
> @@ -1318,10 +1360,10 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   		else
>   			e_info.multi_error_valid = 0;
>   
> -		aer_print_port_info(pdev, &e_info);
> -
> -		if (find_source_device(pdev, &e_info))
> +		if (find_source_device(pdev, &e_info)) {
> +			aer_print_port_info(pdev, &e_info);
>   			aer_process_err_devices(&e_info, KERN_ERR);
> +		}
>   	}
>   }
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


