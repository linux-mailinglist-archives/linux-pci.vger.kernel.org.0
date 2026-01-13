Return-Path: <linux-pci+bounces-44649-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A61D1A84F
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 18:06:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32429303C9E7
	for <lists+linux-pci@lfdr.de>; Tue, 13 Jan 2026 17:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB103502A5;
	Tue, 13 Jan 2026 17:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPSbuIcB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27460350298;
	Tue, 13 Jan 2026 17:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768323908; cv=none; b=ulHey1atSt2yxw5G04TCuh0vmNrjXExIcmupVOnlD60oXdTc/3/J8Eo3A/YZhGbwf0ciTKgGpBStku2vsjDZD2Z3at7bxqTRWE7vEW98utyuQfxxJ+IT7ee17OsUFHtYkV36e4yRQHAaAZP0dRckF+rulMB9Ah7Gxhw5jg9iV5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768323908; c=relaxed/simple;
	bh=DGYb+ckWMh9r8I9aDwCYj/oN1UJ26JRRp+vf0ig+GQY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZC7ninKRZGobItox64xsowmvtPU4idl5R4VyOxfPCD6/FPjbUScDFH96jDZ6DZ3lC2g6FCYPrd5H2pEy6Fr4yXZT8uoHapBA/b/zx6ZEbcADVAoWv4vZUD8XaVaEC/3higTY0i94qZc9wrIqX2+sRSyltGnAhSEnz5BzSiUSyAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPSbuIcB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07C0C116C6;
	Tue, 13 Jan 2026 17:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768323907;
	bh=DGYb+ckWMh9r8I9aDwCYj/oN1UJ26JRRp+vf0ig+GQY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bPSbuIcBcU0NeKcnkX+oJvVFDcLg/FwcaCMhCVV0Fm4AasxgBp0knuL8U+LzB+g3z
	 ZakRqsDV9LFIWeDt8XbmjdTgMBP2V9Fn5g9V8kui9R4gWXUl/Jf0T6QrUYECFZsYCh
	 GTuMRYKcr29z+zjEQ/crZ8DjZKB+dC/UbhZVPMbEIdStZPQe/o5hexTdfeRSv5ZMWk
	 H70AVHALoCDHkn7GagAokLoR0OUQ14Lavyj1GPxVe7i1+QhaD8eThlO64mdcCdsx2H
	 TIlgCHqIofCdg/5Wy7cjsYrT53lc/J/APaXEce5NBu0TZXGqMvsuIzGzKsIX+QxiWf
	 k8tdlbsm3eJiQ==
Date: Tue, 13 Jan 2026 22:34:58 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org, 
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com, rafael@kernel.org, lenb@kernel.org, 
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com, rodrigo.vivi@intel.com, 
	varun.gupta@intel.com, ville.syrjala@linux.intel.com, uma.shankar@intel.com, 
	karthik.poosa@intel.com, matthew.auld@intel.com, sk.anirban@intel.com, 
	raag.jadav@intel.com
Subject: Re: [PATCH v6 02/12] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Message-ID: <dn4s77miw7ts7aqqrzltqvlt4qmdb5ego5vkxvxcq7ns42fixh@vubkzxtgverr>
References: <20260113164200.1151788-14-badal.nilawar@intel.com>
 <20260113164200.1151788-16-badal.nilawar@intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260113164200.1151788-16-badal.nilawar@intel.com>

On Tue, Jan 13, 2026 at 10:12:03PM +0530, Badal Nilawar wrote:
> From: Anshuman Gupta <anshuman.gupta@intel.com>
> 
> Implement _DSM Method 0Bh as per PCI Firmware r3.3, sec 4.6.10, to request

4.6.11

> fixed delay in timing between the time the PME_TO_Ack message is received
> at the PCI Express Downstream Port that originated the PME_Turn_Off
> message, and the time the platform asserts PERST# to the slot during the
> corresponding Endpoint’s or PCI Express Upstream Port’s transition to
> D3cold while the system is in an ACPI operational state.
> Host platform supporting this feature ensures that device is observing
> this delay in every applicable D3Cold transition.
> 
> Co-developed-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
> For VRSR feature with PERST# Assertion delay device will get enough time
> to transition to auxiliary power before main power removal.
> ---
>  drivers/pci/pci-acpi.c   | 60 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |  9 +++++-
>  2 files changed, 68 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index 645d3005ba50..73eaee20a270 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1554,6 +1554,66 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_mw,
>  }
>  EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
>  
> +/**
> + * pci_acpi_add_perst_assertion_delay - Request PERST# Delay via ACPI DSM

I'd name the API as "pci_acpi_set_perst_assertion_delay", but the firmware spec
calls the _DSM as 'Add PERST# Assertion Delay", so I guess it is fine.

But the description should be changed to "Add PERST# assertion delay via ACPI DSM"

> + * @dev: PCI device instance
> + * @delay_us: Requested delay_us

"Delay to be added"?

> + *
> + * Request PERST# Assertion Delay to platform firmware, via Root Port/

Here also.

> + * Switch Downstream Port ACPI _DSM Function 0Bh, for the specified
> + * PCI device.
> + * Evaluate the _DSM and handle the response accordingly.
> + *
> + * Return: returns 0 on success and errno on failure.
> + */
> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
> +{
> +	union acpi_object in_obj = {
> +		.integer.type = ACPI_TYPE_INTEGER,
> +		.integer.value = delay_us,
> +	};
> +
> +	union acpi_object *out_obj;
> +	int result, ret = -EINVAL;
> +	struct pci_dev *bdev;
> +	acpi_handle handle;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	for (bdev = dev; bdev; bdev = pci_upstream_bridge(bdev)) {
> +		handle = ACPI_HANDLE(&bdev->dev);
> +		if (handle &&
> +		    acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4,
> +				   1 << DSM_PCI_PERST_ASSERTION_DELAY))
> +			break;
> +	}
> +
> +	if (!bdev)
> +		return -ENODEV;
> +
> +	out_obj = acpi_evaluate_dsm_typed(ACPI_HANDLE(&bdev->dev),
> +					  &pci_acpi_dsm_guid, 4,
> +					  DSM_PCI_PERST_ASSERTION_DELAY,
> +					  &in_obj, ACPI_TYPE_INTEGER);
> +	if (!out_obj)
> +		return -EINVAL;
> +
> +	result = out_obj->integer.value;
> +	ACPI_FREE(out_obj);
> +
> +	if (result == delay_us) {
> +		pci_info(dev, "PERST# Assertion Delay set to %u microseconds\n", delay_us);
> +		ret = 0;
> +	} else {
> +		pci_info(dev, "PERST# Assertion Delay request failed, using %u microseconds\n",
> +			 result);
> +	}

How about:

	if (result != delay_us) {
		pci_warn(dev, "PERST# Assertion Delay request failed, using %u microseconds\n",
			 result);
		return -EINVAL;
	}

	pci_info(dev, "PERST# Assertion Delay set to %u microseconds\n", delay_us);

	return 0;

- Mani

-- 
மணிவண்ணன் சதாசிவம்

