Return-Path: <linux-pci+bounces-29070-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFB4ACFA7D
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 02:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 769563ABF8D
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 00:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B07792AD22;
	Fri,  6 Jun 2025 00:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="irHw+2s2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D038D5223;
	Fri,  6 Jun 2025 00:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749171118; cv=none; b=qsQf+9j/eJS7B9mwIebod8IysVJbEnkLJ1ti9iuZd+BN7+sXRGDo4uwrsTYW77j0c3ishE04ivrfC0ZlaZEuQitoxsYvdGn8F20Ave4d+4wBljRNfrZAKf0P3IbZ6a3dUkior7ksJdDeA0BzHP6WpDEeXC0tIRd5TZ1QoBvFeC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749171118; c=relaxed/simple;
	bh=GjZsXE6imN4TLudPRr86MYiFtxqZ2oSp/FwjQcorbUY=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rE+5OVFFZGnF93mF8y8oSrnPDl5osj3sZdAcynaTUXh8c1tR2jo274GAB5qCOWo0i2+dQZimf6g99y0S6H2NM5ccxMm/hCpDpBgmBbr5zTvDwg0EiZJdU7CzTEUB4wEYT7R3XX+DMtU1GJUj+NUUdvQPvGD0jEEZJiKg4sQfXyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=irHw+2s2; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749171116; x=1780707116;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=GjZsXE6imN4TLudPRr86MYiFtxqZ2oSp/FwjQcorbUY=;
  b=irHw+2s2RsVflbndo+cfxCxXtu7eLq+NcFROe9nr5JL5zNjnIX5p3qQn
   Fr7m2wag5WiHL8xrzJ+En9GgQ4cFviusM5UWnXzaimSIriwkBPuyPnCse
   1YRoP+33r69XQ2eXvAOa/Lwx+Iz1ErkCUBV28sGUX/32j/b69lzMfURhM
   Ib1vUg0N2VL+aIeQ0WrzxyXDtl9Ui0gQv2w4DPUFKDhNphELXL5g8mrP2
   F8+KGA2G0xSEyvENMEpMKxL7BQQRQKmhW9Vne7AaBiMJ7SNce0uxQDBus
   RpzxznZLrYdBR0VyzZk6cBVCUovPa3TKVYuwt3UNIckZTMHpQ3ipgkX46
   g==;
X-CSE-ConnectionGUID: gFsAUVqRQM+rOpvs9MTtcw==
X-CSE-MsgGUID: 3wEzwF0CQjuNKlmBwEaAJw==
X-IronPort-AV: E=McAfee;i="6800,10657,11455"; a="51174725"
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="51174725"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 17:51:55 -0700
X-CSE-ConnectionGUID: FXLIaEmsTpm7ASEmGZdsgw==
X-CSE-MsgGUID: nO4SilR4T4e6oSCA57hv3w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,213,1744095600"; 
   d="scan'208";a="146636526"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2025 17:51:55 -0700
Received: from [10.124.222.132] (unknown [10.124.222.132])
	by linux.intel.com (Postfix) with ESMTP id D189D20B5736;
	Thu,  5 Jun 2025 17:51:53 -0700 (PDT)
Message-ID: <6b47a383-3e57-44f7-a3c6-45af88c04897@linux.intel.com>
Date: Thu, 5 Jun 2025 17:51:53 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 15/16] CXL/PCI: Enable CXL protocol errors during CXL
 Port probe
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
 <20250603172239.159260-16-terry.bowman@amd.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250603172239.159260-16-terry.bowman@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 6/3/25 10:22 AM, Terry Bowman wrote:
> CXL protocol errors are not enabled for all CXL devices after boot. These
> must be enabled inorder to process CXL protocol errors.
>
> Export the AER service driver's pci_aer_unmask_internal_errors().
>
> Introduce cxl_unmask_prot_interrupts() to call pci_aer_unmask_internal_errors().
> pci_aer_unmask_internal_errors() expects the pdev->aer_cap is initialized.
> But, dev->aer_cap is not initialized for CXL Upstream Switch Ports and CXL
> Downstream Switch Ports. Initialize the dev->aer_cap if necessary. Enable AER
> correctable internal errors and uncorrectable internal errors for all CXL
> devices.
>
> Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>   drivers/cxl/port.c     | 29 +++++++++++++++++++++++++++--
>   drivers/pci/pcie/aer.c |  3 ++-
>   include/linux/aer.h    |  1 +
>   3 files changed, 30 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 0f7c4010ba58..3687848ae772 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -3,6 +3,7 @@
>   #include <linux/device.h>
>   #include <linux/module.h>
>   #include <linux/slab.h>
> +#include <linux/pci.h>
>   
>   #include "cxlmem.h"
>   #include "cxlpci.h"
> @@ -60,6 +61,21 @@ static int discover_region(struct device *dev, void *unused)
>   
>   #ifdef CONFIG_PCIEAER_CXL
>   
> +static void cxl_unmask_prot_interrupts(struct device *dev)
> +{
> +	struct pci_dev *pdev __free(pci_dev_put) =
> +		pci_dev_get(to_pci_dev(dev));
> +
> +	if (!pdev->aer_cap) {
> +		pdev->aer_cap = pci_find_ext_capability(pdev,
> +							PCI_EXT_CAP_ID_ERR);
> +		if (!pdev->aer_cap)
> +			return;
> +	}
> +
> +	pci_aer_unmask_internal_errors(pdev);
> +}
> +
>   static void cxl_dport_map_rch_aer(struct cxl_dport *dport)
>   {
>   	resource_size_t aer_phys;
> @@ -118,8 +134,12 @@ static void cxl_uport_init_ras_reporting(struct cxl_port *port,
>   
>   	map->host = host;
>   	if (cxl_map_component_regs(map, &port->uport_regs,
> -				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>   		dev_dbg(&port->dev, "Failed to map RAS capability\n");
> +		return;
> +	}
> +
> +	cxl_unmask_prot_interrupts(port->uport_dev);
>   }
>   
>   /**
> @@ -144,9 +164,12 @@ void cxl_dport_init_ras_reporting(struct cxl_dport *dport, struct device *host)
>   	}
>   
>   	if (cxl_map_component_regs(&dport->reg_map, &dport->regs.component,
> -				   BIT(CXL_CM_CAP_CAP_ID_RAS)))
> +				   BIT(CXL_CM_CAP_CAP_ID_RAS))) {
>   		dev_dbg(dport->dport_dev, "Failed to map RAS capability\n");
> +		return;
> +	}
>   
> +	cxl_unmask_prot_interrupts(dport->dport_dev);
>   }
>   EXPORT_SYMBOL_NS_GPL(cxl_dport_init_ras_reporting, "CXL");
>   
> @@ -177,6 +200,8 @@ static void cxl_endpoint_port_init_ras(struct cxl_port *port)
>   	}
>   
>   	cxl_dport_init_ras_reporting(dport, &cxlmd->dev);
> +
> +	cxl_unmask_prot_interrupts(cxlmd->cxlds->dev);
>   }
>   
>   #else
> diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
> index 5efe5a718960..2d202ad1453a 100644
> --- a/drivers/pci/pcie/aer.c
> +++ b/drivers/pci/pcie/aer.c
> @@ -964,7 +964,7 @@ static bool find_source_device(struct pci_dev *parent,
>    * Note: AER must be enabled and supported by the device which must be
>    * checked in advance, e.g. with pcie_aer_is_native().
>    */
> -static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   {
>   	int aer = dev->aer_cap;
>   	u32 mask;
> @@ -977,6 +977,7 @@ static void pci_aer_unmask_internal_errors(struct pci_dev *dev)
>   	mask &= ~PCI_ERR_COR_INTERNAL;
>   	pci_write_config_dword(dev, aer + PCI_ERR_COR_MASK, mask);
>   }
> +EXPORT_SYMBOL_NS_GPL(pci_aer_unmask_internal_errors, "CXL");
>   
>   static bool is_cxl_mem_dev(struct pci_dev *dev)
>   {
> diff --git a/include/linux/aer.h b/include/linux/aer.h
> index c9a18eca16f8..74600e75705f 100644
> --- a/include/linux/aer.h
> +++ b/include/linux/aer.h
> @@ -107,5 +107,6 @@ void pci_print_aer(struct pci_dev *dev, int aer_severity,
>   int cper_severity_to_aer(int cper_severity);
>   void aer_recover_queue(int domain, unsigned int bus, unsigned int devfn,
>   		       int severity, struct aer_capability_regs *aer_regs);
> +void pci_aer_unmask_internal_errors(struct pci_dev *dev);
>   #endif //_AER_H_
>   

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


