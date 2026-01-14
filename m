Return-Path: <linux-pci+bounces-44857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D3791D212AE
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 21:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CFEFA302C8F8
	for <lists+linux-pci@lfdr.de>; Wed, 14 Jan 2026 20:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11BB5330D43;
	Wed, 14 Jan 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmTQOYP3"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0EE232C924;
	Wed, 14 Jan 2026 20:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768422261; cv=none; b=lVMF/Gx/tWPHpQ2S7DNNEOBXxMv5YB3f7Dnwikj7W465SfRn59djZSJlYHZCYFJ2hp0yUktV6ddPGdChpcifUTT5aM2LWwokMYsTjFzP8tGDYSJ+wzRKaJBrQSiUXSC2hbOfn4V6xljFeLgStLFgB9h3WDR3oj6pw1Ed1s9uA4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768422261; c=relaxed/simple;
	bh=2QdzLaUu11/vxbPCOmbk67hSo2EwQNx/2DHWgb15TpU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=B3fGkWNJVPvATJ0UusyL7P/4/EhfnqMLgAxb93sOpuq7gyz4r58VYiiEe4GxNfzAS/JMgDBgAxDFsInu6ENvggV+ogCgIEK6SMsKxhntouFPIc+BeDBcW0rDGBGu38d+wkRAc6V8iyzXmEbxDOCQXcP0/qFDR+CkzE8dw0WUazo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmTQOYP3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62607C4CEF7;
	Wed, 14 Jan 2026 20:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768422260;
	bh=2QdzLaUu11/vxbPCOmbk67hSo2EwQNx/2DHWgb15TpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OmTQOYP3EX/M2oj/bD+vFJbeX6mnzLjYQLa2cIz3urjOTgTfhc/MPyYaZujrYByd2
	 Hc4rK7TQmPew2HN0QoVmeOI/6izyuzlDrpRPaIqgG0N3/J4whZ7p28Y4ngSBVaOtKt
	 5tONS8e8fcEjCDmr0FvLBjO0idvYsIG2m7Pc09k3/ZNlJQxBP3d+ZJFQc3bHJhrEhM
	 T251PSw0oHYDrCaGLsqsUqHfDUrTy5+BZzy58WpALdjhUoolVdtKkT/n8mS6BpY4UZ
	 41I5+Gh7qeBxQxeOIE2cVTgeRzohe2w4gQaQ4iJt5buorj7PxNyLvHYPPr7CTeH3lp
	 IiR8ZsqO9iD5A==
Date: Wed, 14 Jan 2026 14:24:19 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, rodrigo.vivi@intel.com,
	varun.gupta@intel.com, ville.syrjala@linux.intel.com,
	uma.shankar@intel.com, karthik.poosa@intel.com,
	matthew.auld@intel.com, sk.anirban@intel.com, raag.jadav@intel.com
Subject: Re: [PATCH v6 01/12] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
Message-ID: <20260114202419.GA831656@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260113164200.1151788-15-badal.nilawar@intel.com>

On Tue, Jan 13, 2026 at 10:12:02PM +0530, Badal Nilawar wrote:
> From: Anshuman Gupta <anshuman.gupta@intel.com>
> 
> Implement _DSM method 0Ah, as per PCI Firmware r3.3, sec 4.6.10,
> to request auxiliary power required by the device when in D3cold state.
> 
> Implementation allows only a single device below the Downstream Port to
> request for Aux Power Limit under a given Root Port/Downstream Port
> because it does not track and aggregate requests from all child devices
> below the Downstream Port as required by PCI Firmware r3.3, sec 4.6.10.
> 
> Co-developed-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
> V2(Bjorn/Rafael):
>   - Call acpi_dsm_check() to find method 0Ah supported
>   - Return retry interval to caller
> V3(Kuppuswamy)
>   - Add NULL check for retry interval
> V4
>   - Define enums for aux power request status (Rafael)
>   - Add Co-developed-by and clean up Signed-off-by (Kappuswamy)
>  (Bjorn)
>   - Instead of root pci device pass the pci device of driver, traverse
>     up the tree and discover _DSM
>   - Allow only function 0 of device to request aux power
>   - Allow retry_interval to be NULL
>   - Refine commit message and function description
> V5(Rafael)
>   - Remove function 0 check and allow first caller of the given
>     downstream port (with _DSM) to requst aux power including
>     different function
>   - Squash Patch v5.02 to this patch
>   - In the logic, to allow single device to req power, use linked list
>     instead of adding extra variables to acpi device structure
>   - return positive code for no main power removal to distinguish from
>     aux power request granted
> ---
>  drivers/pci/pci-acpi.c   | 136 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |   9 +++
>  2 files changed, 145 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 9369377725fa..645d3005ba50 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1418,6 +1418,142 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  	ACPI_FREE(obj);
>  }
>  
> +static LIST_HEAD(acpi_aux_pwr_list);
> +static DEFINE_MUTEX(acpi_aux_pwr_lock);
> +
> +struct aux_pwr {
> +	u32 aux_pwr_limit;		/* aux power limit granted by platform firmware */
> +	struct device *dev;		/* device to which aux power is granted  */

Shorten these to fit in 80 columns like the rest of the file.

> +	struct acpi_device *adev;	/* root port/downstream port */
> +	struct list_head list;
> +};
> +
> +enum aux_pwr_req_status {
> +	AUX_PWR_REQ_DENIED               = 0x0,
> +	AUX_PWR_REQ_GRANTED              = 0x1,
> +	AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL  = 0x2,
> +	AUX_PWR_REQ_RETRY_INTERVAL_MIN   = 0x11,
> +	AUX_PWR_REQ_RETRY_INTERVAL_MAX   = 0x1F

Use lower-case hex ("0x1f") like the rest of the file.  Also below.

> +};
> +
> +/**
> + * pci_acpi_request_d3cold_aux_power - Request aux power while device is in D3cold

Shorten or wrap to fit in 80 columns.

> + * @dev: PCI device instance
> + * @requested_mw: Requested auxiliary power in milliwatts
> + * @retry_interval: Retry interval returned by platform to retry auxiliary
> + *                  power request
> + *
> + * Request auxilary power to platform firmware, via Root Port/Switch Downstream
> + * Port ACPI _DSM Function 0Ah, needed for the PCI device when it is in D3cold.
> + * Evaluate the _DSM and handle the response accordingly.

Drop this last sentence; I don't think it tells us anything new.

> + * For Multi-Function Devices, driver for Function 0 is required to report an
> + * aggregate power requirement covering all functions contained within the
> + * device.
> + *
> + * Return: 0 Aux power request granted
> + *	   1 No main power removal
> + *         errno on failure.
> + */
> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
> +				      u32 *retry_interval)
> +{
> +	union acpi_object in_obj = {
> +		.integer.type = ACPI_TYPE_INTEGER,
> +		.integer.value = requested_mw,
> +	};
> +
> +	union acpi_object *out_obj;
> +	int result;
> +	struct pci_dev *bdev;
> +	struct acpi_device *adev;
> +	acpi_handle handle;
> +	struct aux_pwr *apwr, *next;
> +
> +	if (!dev)
> +		return -EINVAL;

We talked about only allowing this for function 0:
https://lore.kernel.org/all/20250904183046.GA1267851@bhelgaas/

> +	for (bdev = dev; bdev; bdev = pci_upstream_bridge(bdev)) {

I think bdev should start with pci_upstream_bridge(dev) as in the
other patch because this _DSM is only allowed in Downstream Ports.

> +		handle = ACPI_HANDLE(&bdev->dev);
> +		if (handle &&
> +		    acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4,
> +				   1 << DSM_PCI_D3COLD_AUX_POWER_LIMIT))
> +			break;
> +	}
> +
> +	if (!bdev)
> +		return -ENODEV;
> +
> +	adev = ACPI_COMPANION(&bdev->dev);
> +	if (!adev)
> +		return -EINVAL;
> +
> +	guard(mutex)(&acpi_aux_pwr_lock);
> +	/* Check if aux power already granted to different device */
> +	list_for_each_entry_safe(apwr, next, &acpi_aux_pwr_list, list) {
> +		if (apwr->adev == adev && apwr->dev != &dev->dev) {
> +			pci_info(to_pci_dev(apwr->dev),
> +				 "D3cold Aux Power request already granted: %u mW\n",
> +				 apwr->aux_pwr_limit);
> +			return -EALREADY;
> +		}
> +		if (apwr->adev == adev && apwr->dev == &dev->dev) {
> +			list_del(&apwr->list);
> +			kfree(apwr);
> +			break;
> +		}
> +	}
> +
> +	out_obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
> +					  &pci_acpi_dsm_guid, 4,
> +					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
> +					  &in_obj, ACPI_TYPE_INTEGER);
> +	if (!out_obj)
> +		return -EINVAL;
> +
> +	result = out_obj->integer.value;
> +	ACPI_FREE(out_obj);
> +
> +	if (retry_interval)
> +		*retry_interval = 0;
> +
> +	switch (result) {
> +	case AUX_PWR_REQ_DENIED:
> +		pci_dbg(bdev, "D3cold Aux Power %u mW request denied\n",
> +			requested_mw);
> +		return -EINVAL;
> +	case AUX_PWR_REQ_GRANTED:
> +		pci_info(bdev, "D3cold Aux Power request granted: %u mW\n",
> +			 requested_mw);
> +		apwr = kzalloc(sizeof(*apwr), GFP_KERNEL);
> +		if (apwr) {
> +			apwr->aux_pwr_limit = requested_mw;
> +			apwr->dev = &dev->dev;
> +			apwr->adev = adev;
> +			INIT_LIST_HEAD(&apwr->list);
> +			list_add(&acpi_aux_pwr_list,
> +				 &apwr->list);
> +		}

I think we leak this allocation if the device is removed.  I think the
list idea is more complicated than aggregating would be.

I think we could:

  - add "aux_power_mw" in struct pci_dev

  - walk the tree below bdev, accumulating aux_power_mw
    (total_aux_power_mw += dev->aux_power_mw)

  - pass "total_aux_power_mw + requested_mw" to the _DSM

  - if successful, set dev->aux_power_mw = requested_mw

> +		return 0;
> +	case AUX_PWR_REQ_NO_MAIN_PWR_REMOVAL:
> +		pci_info(bdev, "D3cold Aux Power: Main power won't be removed\n");
> +		return 2;

Kernel-doc says we return 1 for this case.

> +	case AUX_PWR_REQ_RETRY_INTERVAL_MIN ... AUX_PWR_REQ_RETRY_INTERVAL_MAX:
> +		pci_info(bdev, "D3cold Aux Power request needs retry, interval: %u seconds\n",
> +			 result & 0xF);

Lower-case hex.

> +		if (retry_interval) {
> +			*retry_interval = result & 0xF;
> +			return -EAGAIN;
> +		}
> +		return -EINVAL;

I think we should do:

  case AUX_PWR_REQ_RETRY_INTERVAL_MIN ...  AUX_PWR_REQ_RETRY_INTERVAL_MAX:
    result &= 0xf;
    pci_info(bdev, "... needs retry", result);
    if (retry_interval)
      *retry_interval = result;
    return -EAGAIN;

I don't think it's useful to return different errors based on whether
the caller supplied a "retry_interval" pointer.

> +	default:
> +		pci_err(bdev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
> +			result);
> +		return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);

