Return-Path: <linux-pci+bounces-29006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0570ACE6D1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jun 2025 00:50:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 13D98189A0F2
	for <lists+linux-pci@lfdr.de>; Wed,  4 Jun 2025 22:51:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08B5717B50F;
	Wed,  4 Jun 2025 22:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVKAeQn8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE3C10E9;
	Wed,  4 Jun 2025 22:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749077446; cv=none; b=UPo51aPpYb+ZrV4ohMYWqeaqNSwg3mf8I5cjz2HwbE7Nn+oHLkmnqW2qWQ2WOiC/2SfCqMnSsQEyI2LfS4OzdP6XN6MbAYiuZCrswdbFdKClVgx7lnqLMBSyQwZKOWbM0xlDn+HQD3IB02GYRh6eZTfZs+JabBWg/eK/tQWUonQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749077446; c=relaxed/simple;
	bh=cDKbpDO6ELDPkn3uTBJ/ray2Qg/fiDewMZ5l5xpsDC4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=qBEdSAroadFyYV1biTBKC7Dvr/n3i/VrKtlf5+KPuI0Rr05LfuXMnXhTBsU01nMWlcIaodp/eh5r1klUIr/NAZ8/2j1SaWTYTap1uz+j4tRyU3Llf2vjeLr3RjRW+A5fGu7/3zUNDhhS6DD9WxbeWOeog/49WJIYjIB7JxqzJEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FVKAeQn8; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749077444; x=1780613444;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=cDKbpDO6ELDPkn3uTBJ/ray2Qg/fiDewMZ5l5xpsDC4=;
  b=FVKAeQn84FW4VouV1AUUCyWgPECrPcXTT1h8Kgss+woU7M9oWsYg1kpu
   N/U4KKuVj4hjsuQFgeMtZQUG5A2tQwOVBD8/ypjGc4x+c3tYxIf7u38Z+
   3veZkQhLenF/YZxVdQR8DieSOAyd9SqX71LjRgRJ8T8W/fjBD2hyeV/hG
   vRwuA+lHPd0X0KCqx63LWKcrXib19rI8pMJZdFlcJsEGi0NVin5/K+4cT
   SegpIuvjlu8sVxfUxP7AuB/PGvlo/LzIfo7nsN7W/bsfltTkv+oMHQOIe
   UNpAgpBsuYVj4iyY8WukLwSERd/ggw/u418+RI8AUsNfS3Sjvrl1LEuGV
   A==;
X-CSE-ConnectionGUID: 5z38i6nmS7CMyduuyF2cdw==
X-CSE-MsgGUID: DaXlSEDkR3qQzDbzWTgUWQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11454"; a="51327485"
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="51327485"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 15:50:43 -0700
X-CSE-ConnectionGUID: +S59pNhnSiCxHCRVYBvz8w==
X-CSE-MsgGUID: +p0lU/F8RfieZAf/YnmBdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,210,1744095600"; 
   d="scan'208";a="176279356"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2025 15:50:44 -0700
Received: from [10.124.221.247] (unknown [10.124.221.247])
	by linux.intel.com (Postfix) with ESMTP id 5AE8320B5736;
	Wed,  4 Jun 2025 15:50:42 -0700 (PDT)
Message-ID: <52dfc3f1-b7e1-44f2-8f99-f3f37f44f00d@linux.intel.com>
Date: Wed, 4 Jun 2025 15:50:42 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 03/16] CXL/AER: Introduce kfifo for forwarding CXL
 errors
To: Terry Bowman <terry.bowman@amd.com>, PradeepVineshReddy.Kodamati@amd.com,
 dave@stgolabs.net, jonathan.cameron@huawei.com, dave.jiang@intel.com,
 alison.schofield@intel.com, vishal.l.verma@intel.com, ira.weiny@intel.com,
 dan.j.williams@intel.com, bhelgaas@google.com, bp@alien8.de,
 ming.li@zohomail.com, shiju.jose@huawei.com, dan.carpenter@linaro.org,
 Smita.KoralahalliChannabasappa@amd.com, kobayashi.da-06@fujitsu.com,
 yanfei.xu@intel.com, rrichter@amd.com, peterz@infradead.org, colyli@suse.de,
 uaisheng.ye@intel.com, fabio.m.de.francesco@linux.intel.com,
 ilpo.jarvinen@linux.intel.com, yazen.ghannam@amd.com,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250603172239.159260-1-terry.bowman@amd.com>
 <20250603172239.159260-4-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-4-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 10:22 AM, Terry Bowman wrote:
> CXL error handling will soon be moved from the AER driver into the CXL
> driver. This requires a notification mechanism for the AER driver to share
> the AER interrupt with the CXL driver. The notification will be used
> as an indication for the CXL drivers to handle and log the CXL RAS errors.
>
> Add a kfifo work queue to be used by the AER driver and CXL driver. The AER
> driver will be the sole kfifo producer adding work and the cxl_core will be
> the sole kfifo consumer removing work. Add the boilerplate kfifo support.
>
> Add CXL work queue handler registration functions in the AER driver. Export
> the functions allowing CXL driver to access. Implement registration
> functions for the CXL driver to assign or clear the work handler function.
>
> Introduce function cxl_create_prot_err_info() and 'struct cxl_prot_err_info'.
> Implement cxl_create_prot_err_info() to populate a 'struct cxl_prot_err_info'
> instance with the AER severity and the erring device's PCI SBDF. The SBDF
> details will be used to rediscover the erring device after the CXL driver
> dequeues the kfifo work. The device rediscovery will be introduced along
> with the CXL handling in future patches.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> ---
>   drivers/cxl/core/ras.c |  31 +++++++++-
>   drivers/cxl/cxlpci.h   |   1 +
>   drivers/pci/pcie/aer.c | 132 ++++++++++++++++++++++++++++-------------
>   include/linux/aer.h    |  36 +++++++++++
>   4 files changed, 157 insertions(+), 43 deletions(-)
>
> diff --git a/drivers/cxl/core/ras.c b/drivers/cxl/core/ras.c
> index 485a831695c7..d35525e79e04 100644
> --- a/drivers/cxl/core/ras.c
> +++ b/drivers/cxl/core/ras.c
> @@ -5,6 +5,7 @@
>   #include <linux/aer.h>
>   #include <cxl/event.h>
>   #include <cxlmem.h>
> +#include <cxlpci.h>
>   #include "trace.h"
>   
>   static void cxl_cper_trace_corr_port_prot_err(struct pci_dev *pdev,
> @@ -107,13 +108,41 @@ static void cxl_cper_prot_err_work_fn(struct work_struct *work)
>   }
>   static DECLARE_WORK(cxl_cper_prot_err_work, cxl_cper_prot_err_work_fn);
>   
> +#ifdef CONFIG_PCIEAER_CXL
> +
> +static void cxl_prot_err_work_fn(struct work_struct *work)
> +{
> +}
> +
> +#else
> +static void cxl_prot_err_work_fn(struct work_struct *work) { }
> +#endif /* CONFIG_PCIEAER_CXL */
> +
> +static struct work_struct cxl_prot_err_work;
> +static DECLARE_WORK(cxl_prot_err_work, cxl_prot_err_work_fn);
> +
>   int cxl_ras_init(void)
>   {
> -	return cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	int rc;
> +
> +	rc = cxl_cper_register_prot_err_work(&cxl_cper_prot_err_work);
> +	if (rc)
> +		pr_err("Failed to register CPER AER kfifo (%x)", rc);
> +
> +	rc = cxl_register_prot_err_work(&cxl_prot_err_work);
> +	if (rc) {
> +		pr_err("Failed to register native AER kfifo (%x)", rc);
> +		return rc;
> +	}
> +
> +	return 0;
>   }
>   
>   void cxl_ras_exit(void)
>   {
>   	cxl_cper_unregister_prot_err_work(&cxl_cper_prot_err_work);
>   	cancel_work_sync(&cxl_cper_prot_err_work);
> +
> +	cxl_unregister_prot_err_work();
> +	cancel_work_sync(&cxl_prot_err_work);
>   }
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index 54e219b0049e..6f1396ef7b77 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -4,6 +4,7 @@
>   #define __CXL_PCI_H__
>   #include <linux/pci.h>
>   #include "cxl.h"
> +#include "linux/aer.h"
>   
>   #define CXL_MEMORY_PROGIF	0x10
>   
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index adb4b1123b9b..5350fa5be784 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -114,6 +114,14 @@ struct aer_stats {
>   static int pcie_aer_disable;
>   static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
>   
> +#if defined(CONFIG_PCIEAER_CXL)
> +#define CXL_ERROR_SOURCES_MAX          128
> +static DEFINE_KFIFO(cxl_prot_err_fifo, struct cxl_prot_err_work_data,
> +		    CXL_ERROR_SOURCES_MAX);
> +static DEFINE_SPINLOCK(cxl_prot_err_fifo_lock);
> +struct work_struct *cxl_prot_err_work;
> +#endif
> +
>   void pci_no_aer(void)
>   {
>   	pcie_aer_disable = 1;
> @@ -1004,45 +1012,17 @@ static bool is_internal_error(struct aer_err_info *info)
>   	return info->status & PCI_ERR_UNC_INTN;
>   }
>   
> -static int cxl_rch_handle_error_iter(struct pci_dev *dev, void *data)
> +static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info)
>   {
> -	struct aer_err_info *info = (struct aer_err_info *)data;
> -	const struct pci_error_handlers *err_handler;
> +	if (!info || !info->is_cxl)
> +		return false;
>   
> -	if (!is_cxl_mem_dev(dev) || !cxl_error_is_native(dev))
> -		return 0;
> +	/* Only CXL Endpoints are currently supported */
> +	if ((pci_pcie_type(pdev) != PCI_EXP_TYPE_ENDPOINT) &&
> +	    (pci_pcie_type(pdev) != PCI_EXP_TYPE_RC_EC))
> +		return false;
>   
> -	/* Protect dev->driver */
> -	device_lock(&dev->dev);
> -
> -	err_handler = dev->driver ? dev->driver->err_handler : NULL;
> -	if (!err_handler)
> -		goto out;
> -
> -	if (info->severity == AER_CORRECTABLE) {
> -		if (err_handler->cor_error_detected)
> -			err_handler->cor_error_detected(dev);
> -	} else if (err_handler->error_detected) {
> -		if (info->severity == AER_NONFATAL)
> -			err_handler->error_detected(dev, pci_channel_io_normal);
> -		else if (info->severity == AER_FATAL)
> -			err_handler->error_detected(dev, pci_channel_io_frozen);
> -	}
> -out:
> -	device_unlock(&dev->dev);
> -	return 0;
> -}
> -
> -static void cxl_rch_handle_error(struct pci_dev *dev, struct aer_err_info *info)
> -{
> -	/*
> -	 * Internal errors of an RCEC indicate an AER error in an
> -	 * RCH's downstream port. Check and handle them in the CXL.mem
> -	 * device driver.
> -	 */
> -	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC &&
> -	    is_internal_error(info))
> -		pcie_walk_rcec(dev, cxl_rch_handle_error_iter, info);
> +	return is_internal_error(info);
>   }
>   
>   static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
> @@ -1056,13 +1036,17 @@ static int handles_cxl_error_iter(struct pci_dev *dev, void *data)
>   	return *handles_cxl;
>   }
>   
> -static bool handles_cxl_errors(struct pci_dev *rcec)
> +static bool handles_cxl_errors(struct pci_dev *dev)
>   {
>   	bool handles_cxl = false;
>   
> -	if (pci_pcie_type(rcec) == PCI_EXP_TYPE_RC_EC &&
> -	    pcie_aer_is_native(rcec))
> -		pcie_walk_rcec(rcec, handles_cxl_error_iter, &handles_cxl);
> +	if (!pcie_aer_is_native(dev))
> +		return false;
> +
> +	if (pci_pcie_type(dev) == PCI_EXP_TYPE_RC_EC)
> +		pcie_walk_rcec(dev, handles_cxl_error_iter, &handles_cxl);
> +	else
> +		handles_cxl = pcie_is_cxl(dev);
>   
>   	return handles_cxl;
>   }
> @@ -1076,10 +1060,46 @@ static void cxl_rch_enable_rcec(struct pci_dev *rcec)
>   	pci_info(rcec, "CXL: Internal errors unmasked");
>   }
>   
> +static int cxl_create_prot_error_info(struct pci_dev *pdev,
> +				      struct aer_err_info *aer_err_info,
> +				      struct cxl_prot_error_info *cxl_err_info)
> +{
> +	cxl_err_info->severity = aer_err_info->severity;
> +
> +	cxl_err_info->function = PCI_FUNC(pdev->devfn);
> +	cxl_err_info->device = PCI_SLOT(pdev->devfn);
> +	cxl_err_info->bus = pdev->bus->number;
> +	cxl_err_info->segment = pci_domain_nr(pdev->bus);
> +
> +	return 0;
> +}
> +
> +static void forward_cxl_error(struct pci_dev *pdev, struct aer_err_info *aer_err_info)
> +{
> +	struct cxl_prot_err_work_data wd;
> +	struct cxl_prot_error_info *cxl_err_info = &wd.err_info;
> +
> +	cxl_create_prot_error_info(pdev, aer_err_info, cxl_err_info);
> +
> +	if (!kfifo_put(&cxl_prot_err_fifo, wd)) {
> +		dev_err_ratelimited(&pdev->dev, "CXL kfifo overflow\n");
> +		return;
> +	}
> +
> +	schedule_work(cxl_prot_err_work);
> +}
> +
>   #else
>   static inline void cxl_rch_enable_rcec(struct pci_dev *dev) { }
>   static inline void cxl_rch_handle_error(struct pci_dev *dev,
>   					struct aer_err_info *info) { }
> +static inline void forward_cxl_error(struct pci_dev *dev,
> +				    struct aer_err_info *info) { }
> +static inline bool handles_cxl_errors(struct pci_dev *dev)
> +{
> +	return false;
> +}
> +static bool is_cxl_error(struct pci_dev *pdev, struct aer_err_info *info) { return 0; };
>   #endif
>   
>   /**
> @@ -1117,8 +1137,11 @@ static void pci_aer_handle_error(struct pci_dev *dev, struct aer_err_info *info)
>   
>   static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
>   {
> -	cxl_rch_handle_error(dev, info);
> -	pci_aer_handle_error(dev, info);
> +	if (is_cxl_error(dev, info))
> +		forward_cxl_error(dev, info);
> +	else
> +		pci_aer_handle_error(dev, info);
> +
>   	pci_dev_put(dev);
>   }
>   
> @@ -1582,6 +1605,31 @@ static pci_ers_result_t aer_root_reset(struct pci_dev *dev)
>   	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
>   }
>   
> +#if defined(CONFIG_PCIEAER_CXL)
> +
> +int cxl_register_prot_err_work(struct work_struct *work)
> +{
> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
> +	cxl_prot_err_work = work;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_prot_err_work, "CXL");
> +
> +int cxl_unregister_prot_err_work(void)
> +{
> +	guard(spinlock)(&cxl_prot_err_fifo_lock);
> +	cxl_prot_err_work = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_prot_err_work, "CXL");
> +

Above two functions can never fail, right? What not make them return void?

> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd)
> +{
> +	return kfifo_get(&cxl_prot_err_fifo, wd);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_prot_err_kfifo_get, "CXL");
> +#endif
> +
>   static struct pcie_port_service_driver aerdriver = {
>   	.name		= "aer",
>   	.port_type	= PCIE_ANY_PORT,
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index 02940be66324..550407240ab5 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -10,6 +10,7 @@
>   
>   #include <linux/errno.h>
>   #include <linux/types.h>
> +#include <linux/workqueue_types.h>
>   
>   #define AER_NONFATAL			0
>   #define AER_FATAL			1
> @@ -53,6 +54,27 @@ struct aer_capability_regs {
>   	u16 uncor_err_source;
>   };
>   
> +/**
> + * struct cxl_prot_err_info - Error information used in CXL error handling
> + * @severity: AER severity
> + * @function: Device's PCI function
> + * @device: Device's PCI device
> + * @bus: Device's PCI bus
> + * @segment: Device's PCI segment
> + */
> +struct cxl_prot_error_info {
> +	int severity;
> +
> +	u8 function;
> +	u8 device;
> +	u8 bus;
> +	u16 segment;
> +};
> +
> +struct cxl_prot_err_work_data {
> +	struct cxl_prot_error_info err_info;
> +};
> +
>   #if defined(CONFIG_PCIEAER)
>   int pci_aer_clear_nonfatal_status(struct pci_dev *dev);
>   int pcie_aer_is_native(struct pci_dev *dev);
> @@ -64,6 +86,20 @@ static inline int pci_aer_clear_nonfatal_status(struct pci_dev *dev)
>   static inline int pcie_aer_is_native(struct pci_dev *dev) { return 0; }
>   #endif
>   
> +#if defined(CONFIG_PCIEAER_CXL)
> +int cxl_register_prot_err_work(struct work_struct *work);
> +int cxl_unregister_prot_err_work(void);
> +int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd);
> +#else
> +static inline int
> +cxl_register_prot_err_work(struct work_struct *work)
> +{
> +	return 0;
> +}
> +static inline int cxl_unregister_prot_err_work(void) { return 0; }
> +static inline int cxl_prot_err_kfifo_get(struct cxl_prot_err_work_data *wd) { return 0; }
> +#endif
> +
>   void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   		    struct aer_capability_regs *aer);
>   int cper_severity_to_aer(int cper_severity);

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


