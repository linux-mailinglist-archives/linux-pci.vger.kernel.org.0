Return-Path: <linux-pci+bounces-28683-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 443ACAC83A6
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 23:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0F744A33AB
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 21:41:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA6B22CBD2;
	Thu, 29 May 2025 21:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fMIHkpx6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 927071D63D8;
	Thu, 29 May 2025 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748554865; cv=none; b=Dooj7a6Mz7L74dkZkxYcAlgbNcYf76BNeqm2rQnijHRZZ//Q0SZqL6zigEr3gNJbMwWqswAfaxd5IgcXR0FLg/bJBxDPE6jqlc8qOXoAHbzjrr4MDFLYp8o0ytEGrm6T4kAnhoQmfXAHlG4lxUR6S+yumjgJHRyl5YrSBFK7VaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748554865; c=relaxed/simple;
	bh=yquT3Q4Y6eg+V6FFQsYXuCPYWA9Chl04Rh0ku0nJ8pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lNFeNktKGJUrXRnUyaBLaIwZUlsycHLYd6j+sGUwfHe30t76P1NkLEo1+fQHHOMuveVsm/wNUokX1uJiOiay77J1Hd+rU5aKronydGqj0hmnFY3rFZf8DOx8q5+pa0ch5A1/u39wF8FR0CW3bIqOk4ppHGB6DSs8YjT//yQLTjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fMIHkpx6; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748554864; x=1780090864;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=yquT3Q4Y6eg+V6FFQsYXuCPYWA9Chl04Rh0ku0nJ8pY=;
  b=fMIHkpx6dtF3Y6NG/tCM+qk9v7AKPhUg9zj9ChEeoUlJ2iSIPgFCE5+l
   Nbkot8Tr0PLiexC4L6xQ7gJP6Spuxq7W5EoftA/cCRJM58KY+feRGIX/L
   c+CE1/BCh6pCkUBkhGSDzGOxrrwrtNhyN2nsd9YTCU1Pac/x+mir17o3a
   iYQWDBMmyxB3zBtLjpv42sqU/6CIy8Z+LHpQu260DkjLOcPQoeVnB8S+K
   Y2iht49fLF+RdgHk7Q8D4sSCplI5Y7J/48yO3Aeaym0XofnBqRvao2w73
   arJG/RaN8/bMCnlGBWl6oI4u3gXQYW64vuxsput90fDNQ3Zgo1I+IxHf/
   A==;
X-CSE-ConnectionGUID: 0a/H9yw7Sjm/RcIoX9vuSQ==
X-CSE-MsgGUID: Jo/o/uoYQm+MJ4h/EKkF0g==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50522139"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="50522139"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 14:41:03 -0700
X-CSE-ConnectionGUID: 5MEdQjDERmmsOI2lYMSOZQ==
X-CSE-MsgGUID: RA+F4muaQNKdTjJTYvCpvw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="143638735"
Received: from linux.intel.com ([10.54.29.200])
  by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 14:41:03 -0700
Received: from [10.124.222.225] (unknown [10.124.222.225])
	by linux.intel.com (Postfix) with ESMTP id D020A20B5736;
	Thu, 29 May 2025 14:41:01 -0700 (PDT)
Message-ID: <98fc8402-0bda-4333-8407-75c7a6472375@linux.intel.com>
Date: Thu, 29 May 2025 14:41:01 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 02/11] PCI/ACPI: Per root port allow one Aux power
 limit request
To: Badal Nilawar <badal.nilawar@intel.com>, intel-xe@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com, rafael@kernel.org, lenb@kernel.org,
 bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
 lucas.demarchi@intel.com, rodrigo.vivi@intel.com, varun.gupta@intel.com,
 ville.syrjala@linux.intel.com, uma.shankar@intel.com
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
 <20250529111654.3140766-3-badal.nilawar@intel.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250529111654.3140766-3-badal.nilawar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/29/25 4:16 AM, Badal Nilawar wrote:
> For given root port allow one Aux power limit request.
>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> ---
>   drivers/acpi/scan.c     |  1 +
>   drivers/pci/pci-acpi.c  | 25 ++++++++++++++++++++++++-
>   include/acpi/acpi_bus.h |  2 ++
>   3 files changed, 27 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fb1fe9f3b1a3..9ae7be9db01a 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -745,6 +745,7 @@ int acpi_device_add(struct acpi_device *device)
>   	INIT_LIST_HEAD(&device->physical_node_list);
>   	INIT_LIST_HEAD(&device->del_list);
>   	mutex_init(&device->physical_node_lock);
> +	mutex_init(&device->power.aux_pwr_lock);
>   
>   	mutex_lock(&acpi_device_lock);
>   
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 87f30910a5f1..d33efba4ca94 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1451,6 +1451,7 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>   	union acpi_object *out_obj;
>   	acpi_handle handle;
>   	int result, ret = -EINVAL;
> +	struct acpi_device *adev;
>   
>   	if (!dev || !retry_interval)
>   		return -EINVAL;
> @@ -1464,11 +1465,27 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>   		return -ENODEV;
>   	}
>   
> +	adev = ACPI_COMPANION(&dev->dev);
> +	if (!adev)
> +		return -EINVAL;
> +
> +	mutex_lock(&adev->power.aux_pwr_lock);
> +
> +	/* Check if aux power already granted */
> +	if (adev->power.aux_power_limit) {
> +		pci_info(dev, "D3cold Aux Power request already granted: %u mW\n",
> +			 adev->power.aux_power_limit);
> +		mutex_unlock(&adev->power.aux_pwr_lock);
> +		return -EPERM;
> +	}
> +
>   	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
>   					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
>   					  &in_obj, ACPI_TYPE_INTEGER);
> -	if (!out_obj)
> +	if (!out_obj) {
> +		mutex_unlock(&adev->power.aux_pwr_lock);
>   		return -EINVAL;
> +	}
>   
>   	result = out_obj->integer.value;
>   	if (retry_interval)
> @@ -1478,14 +1495,17 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>   	case 0x0:
>   		pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
>   			requested_power);
> +		adev->power.aux_power_limit = 0;
>   		break;
>   	case 0x1:
>   		pci_info(dev, "D3cold Aux Power request granted: %u mW\n",
>   			 requested_power);
> +		adev->power.aux_power_limit = requested_power;
>   		ret = 0;
>   		break;
>   	case 0x2:
>   		pci_info(dev, "D3cold Aux Power: Main power won't be removed\n");
> +		adev->power.aux_power_limit = 0;
>   		ret = -EBUSY;
>   		break;
>   	default:
> @@ -1500,9 +1520,12 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>   			pci_err(dev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
>   				result);
>   		}
> +		adev->power.aux_power_limit = 0;
>   		break;
>   	}
>   
> +	mutex_unlock(&adev->power.aux_pwr_lock);
> +
>   	ACPI_FREE(out_obj);
>   	return ret;
>   }
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index aad1a95e6863..c4ce3d84be00 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -294,6 +294,8 @@ struct acpi_device_power {
>   	struct acpi_device_power_flags flags;
>   	struct acpi_device_power_state states[ACPI_D_STATE_COUNT];	/* Power states (D0-D3Cold) */
>   	u8 state_for_enumeration; /* Deepest power state for enumeration */
> +	u32 aux_power_limit;		/* aux power limit granted by bios */
> +	struct mutex aux_pwr_lock;	/* prevent concurrent aux power limit requests */


Do you need a new lock ? Is it possible to reuse existing mutex like device_lock()?


>   };
>   
>   struct acpi_dep_data {

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


