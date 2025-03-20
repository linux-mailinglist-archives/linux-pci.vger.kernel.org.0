Return-Path: <linux-pci+bounces-24189-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 227FBA69D0B
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 01:08:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3EF8119C0A90
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 00:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E02CB433C0;
	Thu, 20 Mar 2025 00:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ADZJNbxR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7F23C9
	for <linux-pci@vger.kernel.org>; Thu, 20 Mar 2025 00:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742429254; cv=none; b=hSr+DdvHwVsxSiNHwqcip6v/vZNEdRqZtKbEftLwrV/92zoptXDf/tLhNS00a5vHicqH5noO82oSvf2Ge6qQ3jFNliRD+V0iGSlm+PnQiWwLcKqnTobkxxgMKwL89B6rE2+T0QTzH9k7XdpUrDmkMZ7iQbzu57BJqgShOfevatw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742429254; c=relaxed/simple;
	bh=GvLSVcQrvAI5kKGaZkx1fCfFgJgcLwgXzIgmOvrfyLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pIwlnOAfKZ2LteBknMttzOY1VnhPIkCYibFfoR77CFz9KlFCDcj/4gukMIuY4kVz2SlDg7q/Evwms/5j/y6rZ/a48hQUL4Nbh41Ncov/Nj/UnGJ5Q/6+lZIydOBIfy6SzGgmyLuJmlxQ8Lh7AmxO8C2EUYCQbADhwN5WZOZMEyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ADZJNbxR; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742429254; x=1773965254;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=GvLSVcQrvAI5kKGaZkx1fCfFgJgcLwgXzIgmOvrfyLI=;
  b=ADZJNbxR2e3VqM0S/gpE0gy7B3f2hZy+zB5nkPlWGznGCYhfCmggrdDM
   ECF1AEkSxCK2yj18QxzHZs3D5lxsk3epQovTh54MgGxeNXAOO3Hd1PmzB
   kjSoeTOMgGj+ej5jJdaeicYTMCVQkkaV10C8sBOyynBKcwwVeLJnRzBfV
   j4m4xC1qp+rdmi+GDIjUgqBCpaubgH4oE4fjZ4vkgaXsDucxY/P+owUWN
   JmnW1QEU6Qa0+mK2PrzAN1F7BxRLIp1RBTcO2rUsrDmU6E0vWoo4QwUfg
   rs2+sbxVeeUrTw10NLMv3aygVCq6uGMZVvmkQu+gCqdxTRqkkoeS9vZ/F
   g==;
X-CSE-ConnectionGUID: wgKL/vM1Q029mGZ6ohtv4w==
X-CSE-MsgGUID: GnKz6rDZRAK5mp+FaFeUXQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11378"; a="54637112"
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="54637112"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 17:07:33 -0700
X-CSE-ConnectionGUID: 8ixokDnhTHyYYAu7P7Se0A==
X-CSE-MsgGUID: KXZdNJLnRoiVfs+Pee1fGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,260,1736841600"; 
   d="scan'208";a="123368845"
Received: from uaeoff-desk2.amr.corp.intel.com (HELO [10.124.220.142]) ([10.124.220.142])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2025 17:07:32 -0700
Message-ID: <256a57a6-e2a8-414c-bf48-34b1cdd7ddc8@linux.intel.com>
Date: Wed, 19 Mar 2025 17:07:30 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] PCI/AER: Check log level once and propagate down
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
 <20250319084050.366718-2-pandoh@google.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250319084050.366718-2-pandoh@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 3/19/25 1:40 AM, Jon Pan-Doh wrote:
> From: Karolina Stolarek <karolina.stolarek@oracle.com>
>
> When reporting an AER error, we check its type multiple times
> to determine the log level for each message. Do this check only
> in the top-level functions (aer_isr_one_error(), pci_print_aer()) and
> propagate the result down the call chain.
>
> Signed-off-by: Karolina Stolarek <karolina.stolarek@oracle.com>
> Signed-off-by: Jon Pan-Doh <pandoh@google.com>
> Reviewed-by: Jon Pan-Doh <pandoh@google.com>
> ---

With my comments fixed, you can add

Reviewed-by: Kuppuswamy Sathyanarayanan 
<sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/pci/pci.h      |  2 +-
>   drivers/pci/pcie/aer.c | 37 ++++++++++++++++++++-----------------
>   drivers/pci/pcie/dpc.c |  2 +-
>   3 files changed, 22 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
> index b8911d1e10dc..75985b96ecc1 100644
> --- a/drivers/pci/pci.h
> +++ b/drivers/pci/pci.h
> @@ -551,7 +551,7 @@ struct aer_err_info {
>   };
>   
>   int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info);
> -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info);
> +void aer_print_error(struct pci_dev *dev, struct aer_err_info *info, const char *level);
>   
>   int pcie_read_tlp_log(struct pci_dev *dev, int where, int where2,
>   		      unsigned int tlp_len, bool flit,
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 9cff7069577e..cc9c80cd88f3 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -670,20 +670,18 @@ static void pci_rootport_aer_stats_incr(struct pci_dev *pdev,
>   }
>   
>   static void __aer_print_error(struct pci_dev *dev,
> -			      struct aer_err_info *info)
> +			      struct aer_err_info *info,
> +			      const char *level)
>   {
>   	const char **strings;
>   	unsigned long status = info->status & ~info->mask;
> -	const char *level, *errmsg;
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
> @@ -696,11 +694,11 @@ static void __aer_print_error(struct pci_dev *dev,
>   	pci_dev_aer_stats_incr(dev, info);
>   }
>   
> -void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
> +void aer_print_error(struct pci_dev *dev, struct aer_err_info *info,
> +		     const char *level)
>   {
>   	int layer, agent;
>   	int id = pci_dev_id(dev);
> -	const char *level;
>   
>   	if (!info->status) {
>   		pci_err(dev, "PCIe Bus Error: severity=%s, type=Inaccessible, (Unregistered Agent ID)\n",
> @@ -711,8 +709,6 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   	layer = AER_GET_LAYER_ERROR(info->severity, info->status);
>   	agent = AER_GET_AGENT(info->severity, info->status);
>   
> -	level = (info->severity == AER_CORRECTABLE) ? KERN_WARNING : KERN_ERR;
> -
>   	aer_printk(level, dev, "PCIe Bus Error: severity=%s, type=%s, (%s)\n",
>   		   aer_error_severity_string[info->severity],
>   		   aer_error_layer[layer], aer_agent_string[agent]);
> @@ -720,7 +716,7 @@ void aer_print_error(struct pci_dev *dev, struct aer_err_info *info)
>   	aer_printk(level, dev, "  device [%04x:%04x] error status/mask=%08x/%08x\n",
>   		   dev->vendor, dev->device, info->status, info->mask);
>   
> -	__aer_print_error(dev, info);
> +	__aer_print_error(dev, info, level);
>   
>   	if (info->tlp_header_valid)
>   		pcie_print_tlp_log(dev, &info->tlp, dev_fmt("  "));
> @@ -765,15 +761,18 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   {
>   	int layer, agent, tlp_header_valid = 0;
>   	u32 status, mask;
> +	const char *level;
>   	struct aer_err_info info;
>   
>   	if (aer_severity == AER_CORRECTABLE) {
>   		status = aer->cor_status;
>   		mask = aer->cor_mask;
> +		level = KERN_WARNING;
>   	} else {
>   		status = aer->uncor_status;
>   		mask = aer->uncor_mask;
>   		tlp_header_valid = status & AER_LOG_TLP_MASKS;
> +		level = KERN_ERR;
>   	}
>   
>   	layer = AER_GET_LAYER_ERROR(aer_severity, status);
> @@ -786,7 +785,7 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   	info.first_error = PCI_ERR_CAP_FEP(aer->cap_control);
>   
>   	pci_err(dev, "aer_status: 0x%08x, aer_mask: 0x%08x\n", status, mask);
> -	__aer_print_error(dev, &info);
> +	__aer_print_error(dev, &info, level);
>   	pci_err(dev, "aer_layer=%s, aer_agent=%s\n",
>   		aer_error_layer[layer], aer_agent_string[agent]);
>   
> @@ -1257,14 +1256,15 @@ int aer_get_device_error_info(struct pci_dev *dev, struct aer_err_info *info)
>   	return 1;
>   }
>   
> -static inline void aer_process_err_devices(struct aer_err_info *e_info)
> +static inline void aer_process_err_devices(struct aer_err_info *e_info,
> +					   const char *level)
>   {
>   	int i;
>   
>   	/* Report all before handle them, not to lost records by reset etc. */
>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>   		if (aer_get_device_error_info(e_info->dev[i], e_info))
> -			aer_print_error(e_info->dev[i], e_info);
> +			aer_print_error(e_info->dev[i], e_info, level);
>   	}
>   	for (i = 0; i < e_info->error_dev_num && e_info->dev[i]; i++) {
>   		if (aer_get_device_error_info(e_info->dev[i], e_info))
> @@ -1282,6 +1282,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   {
>   	struct pci_dev *pdev = rpc->rpd;
>   	struct aer_err_info e_info;
> +	const char *level;
>   
>   	pci_rootport_aer_stats_incr(pdev, e_src);
>   
> @@ -1292,6 +1293,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   	if (e_src->status & PCI_ERR_ROOT_COR_RCV) {
>   		e_info.id = ERR_COR_ID(e_src->id);
>   		e_info.severity = AER_CORRECTABLE;
> +		level = KERN_WARNING;
>   
>   		if (e_src->status & PCI_ERR_ROOT_MULTI_COR_RCV)
>   			e_info.multi_error_valid = 1;
> @@ -1300,11 +1302,12 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   		aer_print_port_info(pdev, &e_info);
>   
>   		if (find_source_device(pdev, &e_info))
> -			aer_process_err_devices(&e_info);
> +			aer_process_err_devices(&e_info, level);

Since this path is only taken for correctable error, you can directly use
aer_process_err_devices(&e_info, KERN_WARNING)

>   	}
>   
>   	if (e_src->status & PCI_ERR_ROOT_UNCOR_RCV) {
>   		e_info.id = ERR_UNCOR_ID(e_src->id);
> +		level = KERN_ERR;
>   
>   		if (e_src->status & PCI_ERR_ROOT_FATAL_RCV)
>   			e_info.severity = AER_FATAL;
> @@ -1319,7 +1322,7 @@ static void aer_isr_one_error(struct aer_rpc *rpc,
>   		aer_print_port_info(pdev, &e_info);
>   
>   		if (find_source_device(pdev, &e_info))
> -			aer_process_err_devices(&e_info);
> +			aer_process_err_devices(&e_info, level);

Same as above.

aer_process_err_devices(&e_info, KERN_ERR)

>   	}
>   }
>   
> diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
> index df42f15c9829..9e4c9ac737a7 100644
> --- a/drivers/pci/pcie/dpc.c
> +++ b/drivers/pci/pcie/dpc.c
> @@ -289,7 +289,7 @@ void dpc_process_error(struct pci_dev *pdev)
>   	else if (reason == PCI_EXP_DPC_STATUS_TRIGGER_RSN_UNCOR &&
>   		 dpc_get_aer_uncorrect_severity(pdev, &info) &&
>   		 aer_get_device_error_info(pdev, &info)) {
> -		aer_print_error(pdev, &info);
> +		aer_print_error(pdev, &info, KERN_ERR);
>   		pci_aer_clear_nonfatal_status(pdev);
>   		pci_aer_clear_fatal_status(pdev);
>   	}

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


