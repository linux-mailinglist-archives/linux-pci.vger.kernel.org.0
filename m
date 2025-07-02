Return-Path: <linux-pci+bounces-31249-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B6EAF13DC
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 13:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A28C2444A5C
	for <lists+linux-pci@lfdr.de>; Wed,  2 Jul 2025 11:28:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 482FD264A65;
	Wed,  2 Jul 2025 11:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VdjtxUyP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E0E92620FA;
	Wed,  2 Jul 2025 11:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751455750; cv=none; b=X4IoGLO4ceBaYzTz5pF9qysJaoV55gtYSjT1PNR17FLg3lDXQawpp2NjO7WNJY0mFCErJx4Z3aLc+y3wnU5HlyTHbj92txJzx7zG6dtysnKGsUtO3cH38pWR7QR88hxQp5syNV+uvHa4LU5sQlpUGFXCPff+bpgZ7JjRd1PBBSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751455750; c=relaxed/simple;
	bh=ye5X6obKoSEg1H58wS5paYr733c6PnCpeelFGlRpih0=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=gik18cLeH/n713jqRwZRKYXfc32Npj5dMYlzEbW0LNry0oggbYKqWQiEBgHXkuWCGvyY/WcokHkLbZ4uCxFyjwg1SIiunZT76WzrwDArp8Gm8Inmd9EnmxYBx7MlaqSoLo+6u8DZECejdO/g9fD3Co2rQi2cxMGkCUcW0wlOk1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VdjtxUyP; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1751455749; x=1782991749;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=ye5X6obKoSEg1H58wS5paYr733c6PnCpeelFGlRpih0=;
  b=VdjtxUyPlgqQ9o/9kFQdDzpnAdaTbAFzwsCHxFrrPw/Up+Mgnu4prBj7
   kMItUz8jayDydEIE04AbXgoti1v2kQYUN1Yrym+P0LVEYtfJNeDydUdba
   jISk1AxeqBfX950ahZ9dyhqVcz3twcWKwkMFJZE+JUbl3IeWJO3XAse7V
   ZnDsYyDdo4NtwRXhPCyQPezpsKksBN9YD9gNcsnCcFputcQbgKLQ19Q4V
   W2Z6AWcJikv6QtFD86hy+2ceB4TfPWvZGhoGezZgU0WLlfmzO6zES0zjd
   aXmN8HBpWVZ2EangxeF89N57txCa3ljIbKhaWzMgQjZJlsxKylB3c3K1o
   w==;
X-CSE-ConnectionGUID: HnHT6DM5TPmisifccTaGdg==
X-CSE-MsgGUID: l26l8053TACx4A2RQdyEGA==
X-IronPort-AV: E=McAfee;i="6800,10657,11481"; a="71312956"
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="71312956"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:29:07 -0700
X-CSE-ConnectionGUID: 6LQ9sz59SMmbijbCNfm0/Q==
X-CSE-MsgGUID: 8wdgoqVFRg63/w0PtLAeew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,281,1744095600"; 
   d="scan'208";a="153820832"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.228])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jul 2025 04:29:02 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 2 Jul 2025 14:28:59 +0300 (EEST)
To: Badal Nilawar <badal.nilawar@intel.com>
cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
    linux-pci@vger.kernel.org, anshuman.gupta@intel.com, 
    "Rafael J. Wysocki" <rafael@kernel.org>, lenb@kernel.org, 
    bhelgaas@google.com, lucas.demarchi@intel.com, rodrigo.vivi@intel.com, 
    varun.gupta@intel.com, ville.syrjala@linux.intel.com, 
    uma.shankar@intel.com
Subject: Re: [PATCH v4 02/11] PCI/ACPI: Per root port allow one Aux power
 limit request
In-Reply-To: <20250529111654.3140766-3-badal.nilawar@intel.com>
Message-ID: <ec3bd3a0-98d3-3b55-198e-a27a2c1dfe8a@linux.intel.com>
References: <20250529111654.3140766-1-badal.nilawar@intel.com> <20250529111654.3140766-3-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII

On Thu, 29 May 2025, Badal Nilawar wrote:

> For given root port allow one Aux power limit request.
> 
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Cc: Anshuman Gupta <anshuman.gupta@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> ---
>  drivers/acpi/scan.c     |  1 +
>  drivers/pci/pci-acpi.c  | 25 ++++++++++++++++++++++++-
>  include/acpi/acpi_bus.h |  2 ++
>  3 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/scan.c b/drivers/acpi/scan.c
> index fb1fe9f3b1a3..9ae7be9db01a 100644
> --- a/drivers/acpi/scan.c
> +++ b/drivers/acpi/scan.c
> @@ -745,6 +745,7 @@ int acpi_device_add(struct acpi_device *device)
>  	INIT_LIST_HEAD(&device->physical_node_list);
>  	INIT_LIST_HEAD(&device->del_list);
>  	mutex_init(&device->physical_node_lock);
> +	mutex_init(&device->power.aux_pwr_lock);

Hi,

mutex_destroy() also exists but I don't find any added by this patch?
I think the pre-existing mutex might also have this same problem.

>  
>  	mutex_lock(&acpi_device_lock);
>  
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 87f30910a5f1..d33efba4ca94 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1451,6 +1451,7 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>  	union acpi_object *out_obj;
>  	acpi_handle handle;
>  	int result, ret = -EINVAL;
> +	struct acpi_device *adev;
>  
>  	if (!dev || !retry_interval)
>  		return -EINVAL;
> @@ -1464,11 +1465,27 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>  		return -ENODEV;
>  	}
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
>  	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
>  					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
>  					  &in_obj, ACPI_TYPE_INTEGER);
> -	if (!out_obj)
> +	if (!out_obj) {
> +		mutex_unlock(&adev->power.aux_pwr_lock);
>  		return -EINVAL;
> +	}
>  
>  	result = out_obj->integer.value;
>  	if (retry_interval)
> @@ -1478,14 +1495,17 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>  	case 0x0:
>  		pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
>  			requested_power);
> +		adev->power.aux_power_limit = 0;
>  		break;
>  	case 0x1:
>  		pci_info(dev, "D3cold Aux Power request granted: %u mW\n",
>  			 requested_power);
> +		adev->power.aux_power_limit = requested_power;
>  		ret = 0;
>  		break;
>  	case 0x2:
>  		pci_info(dev, "D3cold Aux Power: Main power won't be removed\n");
> +		adev->power.aux_power_limit = 0;
>  		ret = -EBUSY;
>  		break;
>  	default:
> @@ -1500,9 +1520,12 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>  			pci_err(dev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
>  				result);
>  		}
> +		adev->power.aux_power_limit = 0;
>  		break;
>  	}
>  
> +	mutex_unlock(&adev->power.aux_pwr_lock);
> +
>  	ACPI_FREE(out_obj);
>  	return ret;
>  }
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index aad1a95e6863..c4ce3d84be00 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -294,6 +294,8 @@ struct acpi_device_power {
>  	struct acpi_device_power_flags flags;
>  	struct acpi_device_power_state states[ACPI_D_STATE_COUNT];	/* Power states (D0-D3Cold) */
>  	u8 state_for_enumeration; /* Deepest power state for enumeration */
> +	u32 aux_power_limit;		/* aux power limit granted by bios */
> +	struct mutex aux_pwr_lock;	/* prevent concurrent aux power limit requests */
>  };
>  
>  struct acpi_dep_data {
> 

-- 
 i.


