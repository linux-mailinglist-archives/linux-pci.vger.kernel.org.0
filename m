Return-Path: <linux-pci+bounces-35473-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C95B44590
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 20:37:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32CD7481196
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 18:37:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A767F30BBBC;
	Thu,  4 Sep 2025 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fK9TtnAK"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1622D6630;
	Thu,  4 Sep 2025 18:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011021; cv=none; b=jW5uednLDTDFrpp328hYJsD3FYWK37zCXESbnRS0NpDl2+2enbP2UV1ZVzDtY7zITvQD7HWb68UrC4BMYAghw2c+TDbpFNrO9O1k8Tweibc4DwkVj/09Ju0N8+u+bbkxI16jcwwDqE9v7fu2Jd2iDTqFQCoWnSRs0F/mLZyOoWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011021; c=relaxed/simple;
	bh=ftjP0BgBhol/aJqy+0EAcs43kMLIGJAJVDQe4elAqE4=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=h0ACGuTdABIgH0uFNJcnfgrKPGvV3NyvZRMb1PWCXYHBluFNGn44hpWzAHncvatmxbR+USsvsvBlYl/a7rncQ6br+xqYzyMkp4g34Q3P2C5YJ1EgSOEas06uQsmjD+g4S/j7WpOI8bhAiZB4W9ngmM42GBsZ5bn+qq+dUodOx1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fK9TtnAK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBB9FC4CEF0;
	Thu,  4 Sep 2025 18:37:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757011021;
	bh=ftjP0BgBhol/aJqy+0EAcs43kMLIGJAJVDQe4elAqE4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=fK9TtnAKgXX/kekyaKxa6YXvorPUEg6avFCJKW5o6hy8TneIFexM7MlDX4I167iE3
	 EwO9anL4coTCc35WrDYsxvkW4xgN5a5ivg89pJUyIySyWFa9wi0bOTYCknilvZtMWT
	 8hjAzcy9qigvBk6oo2MNBYxfOGHKrv/2gK7BjRuL64TMZePW2DN72v8JMTED5g0KMi
	 z1AJHjUwEiMGdTrlnis2laZaZzD58lgLmtgLjgnVy0HTpl07f9o+9yCjA7NSH+QZya
	 4oP2mYzZxuGn9s8W9f/Qkw7FdkwKY26cWuuNAEv5WSDDoQW6iE/WQWc5H1/+NikuVn
	 EBV7fea9xR9nA==
Date: Thu, 4 Sep 2025 13:36:59 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com, varun.gupta@intel.com,
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Subject: Re: [PATCH v4 02/11] PCI/ACPI: Per root port allow one Aux power
 limit request
Message-ID: <20250904183659.GA1271032@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529111654.3140766-3-badal.nilawar@intel.com>

On Thu, May 29, 2025 at 04:46:45PM +0530, Badal Nilawar wrote:
> For given root port allow one Aux power limit request.

Please include the reason why we do this.  I don't think we need it.

PCI Firmware r3.3, sec 4.6.10 says this _DSM function can be invoked
multiple times with different requests.

We might need a mutex just to avoid concurrent evaluations of this
_DSM function by different drivers; I'm not sure whether there's a
requirement to avoid that or whether the ACPI core already enforces
something like that.  But that would be a separate thing from
aux_power_limit.

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
> -- 
> 2.34.1
> 

