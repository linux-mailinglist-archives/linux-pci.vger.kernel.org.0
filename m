Return-Path: <linux-pci+bounces-35472-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69131B4456A
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 20:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 28727172C73
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 18:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C7101A23A9;
	Thu,  4 Sep 2025 18:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OF4hLLQk"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2462136988;
	Thu,  4 Sep 2025 18:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757010648; cv=none; b=Id8hD+X3BrV0QGxmAO9OcO6XQkR0s62ZOrCQoS8G+tGp19w1zPfK4WZr8v9OPFZ3PQ3537y2ebJf9XHN7xWQ+hruUxbcSf3Q3PuSyG8LqiPqEvZoN0sHvEu3DQVZxcbrQaqS9p6XRiGS1AnMCnd6IWeQeMw5yf8PK1w+menPCOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757010648; c=relaxed/simple;
	bh=clsffvWNe7CRZlbmQww0liyl8L1BsLLcWkfBfiG4m5I=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=NVZBz59u8J7kQdhP0GjEO4d+HLLjpfWbPRGruwKaUwsHkPw2p4j1NkEB++uXkhrVpSM6YzoQ+j12E/q9LpEmFS9eEXpI0vArcFYODJXUtuWtf+aZg8a2a/JpliVsjrVmcyA2zB5Q2mEOoUqQSWYVBhtRNHb0C9S6LtveqJ1tbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OF4hLLQk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AE1C4CEF0;
	Thu,  4 Sep 2025 18:30:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757010648;
	bh=clsffvWNe7CRZlbmQww0liyl8L1BsLLcWkfBfiG4m5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=OF4hLLQkzLqgwsgK2b+/HKVukhj+CPaxsLKNdALf8BwJmyXgekeig/pBRN9JYLORi
	 hAmsXMlMpfyLDTYHh/+E6JnecT7LqpUNe/xMwFTfIlRUc3+3GoXh+OzO/5skIcy1Te
	 GLqOVrTo/6D/4K0KgffnVXT5IuTN+idbR4hCh4yEHFumrXpq0hv7+ZT+YJBE0KC6qs
	 2ET1r6mKQOvuax7oDp7iEqQJrYzEOyqJLv8jZu5OBcsuSR2L+rgFKUU1SQM/kMU5/U
	 d9LLGRa/YcnPwctwWNpGwvGeUN3GzYwreGL8ZwFLQDOARIFnWgChB2v4hWtthBWpvq
	 RfpBKe2jOnQZg==
Date: Thu, 4 Sep 2025 13:30:46 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com, varun.gupta@intel.com,
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Subject: Re: [PATCH v4 01/11] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
Message-ID: <20250904183046.GA1267851@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529111654.3140766-2-badal.nilawar@intel.com>

On Thu, May 29, 2025 at 04:46:44PM +0530, Badal Nilawar wrote:
> From: Anshuman Gupta <anshuman.gupta@intel.com>
> 
> Implement _DSM method 0Ah according to PCI firmware specifications,
> section 4.6.10 Rev 3.3., to request auxilary power needed for the
> device when in D3Cold.

Cite as "PCI Firmware r3.3, sec 4.6.10"
> 
> Note that this implementation assumes only a single device below the
> Downstream Port will request for Aux Power Limit under a given
> Root Port because it does not track and aggregate requests
> from all child devices below the Downstream Port as required
> by Section 4.6.10 Rev 3.3.

Wrap to fill 75 columns.  Update citation as above.

> One possible mitigation would be only allowing only first PCIe
> Non-Bridge Endpoint Function 0 driver to call_DSM method 0Ah.

I don't quite understand how this mitigation would address the lack of
aggregation or how the mitigation could be enforced.  Maybe just drop
this?

s/call_DSM/call _DSM/

> Signed-off-by: Varun Gupta <varun.gupta@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
> V2(Bjorn/Rafael):
>   - Call acpi_dsm_check() to find method 0Ah supported
>   - Return retry interval to caller
> V3(Kuppuswamy)
>   - Add NULL check for retry interval
> ---
>  drivers/pci/pci-acpi.c   | 87 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |  8 ++++
>  2 files changed, 95 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..87f30910a5f1 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1421,6 +1421,93 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  	ACPI_FREE(obj);
>  }
>  
> +/**
> + * pci_acpi_request_d3cold_aux_power - Request aux power while device is in D3Cold
> + * @dev: PCI device instance
> + * @requested_power: Requested auxiliary power in milliwatts
> + * @retry_interval: Retry interval returned by platform to retry auxiliary
> + *                  power request
> + *
> + * This function sends a request to the host BIOS via root port ACPI _DSM Function 0Ah
> + * for the auxiliary power needed by the PCI device when it is in D3Cold.
> + * It checks and evaluates the _DSM (Device Specific Method) to request the auxiliary
> + * power and handles the response accordingly.

s/This functions sends a request/Request auxiliary power .../ (imperative mood)
s/the host BIOS/platform firmware/ (non-x86 firmware may not be BIOS)
s/D3Cold/D3cold/ (twice) to match other usage
s/root port/Root Port/ to match spec usage
s/It checks and evaluates the/Evaluate the/
s/and handles/and handle/

It's not quite clear from this description, but the code assumes this
is called for a Root Port.  I don't think that's quite the right
approach because the spec only says this _DSM function is implemented
in the scope of a Downstream Port.  That *could* be a Root Port, but
it doesn't have to be; it could be a Switch Downstream Port.

The caller shouldn't have to traverse up the tree, checking whether
this _DSM function is implemented at each level.  So I think the
driver should call this with *its* device, and
pci_acpi_request_d3cold_aux_power() should walk up the tree looking
for this _DSM function.

> + * This function shall be only called by 1st non-bridge Endpoint driver
> + * on Function 0. For a Multi-Function Device, the driver for Function 0 is
> + * required to report an aggregate power requirement covering all
> + * functions contained within the device.

This last paragraph covers two separate issues:

  1) Sec 4.6.10 requires driver for function 0 to aggregate power
     requirements for all functions in a multi-function device.  We
     can't enforce that the driver, e.g., xe, does this, but it seems
     like this is a hint that we should only evaluate this _DSM for
     function 0 of a multi-function device.  So it seems like we
     should return an error if called for a function other than 0.

  2) The "Location" part of sec 4.6.10 has a separate restriction
     that system software, i.e., the PCI core, should aggregate
     requests from child devices, which we don't do so far.

     If drivers call pci_acpi_request_d3cold_aux_power() for their
     devices (not the Root Port), there might be a way to do this
     aggregation by tracking the sum of all requests at the Downstream
     Port where we find this _DSM function implemented.  But I don't
     know whether it's worth trying to implement this now because it
     seems complicated.

I don't know what "1st non-bridge Endpoint driver" means.  How does a
driver writer know whether the driver qualifies?  Maybe just keep the
part about this only being supported for function 0 and note that we
don't support the aggregation across multiple devices?

Wrap this all to fit in 80 columns like the rest of the file.

> + * Return: Returns 0 on success and errno on failure.
> + */
> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
> +				      u32 *retry_interval)

Name the parameter "requested_power_mw" or even just "requested_mw" so
we know the units.  Also in header file.

> +{
> +	union acpi_object in_obj = {
> +		.integer.type = ACPI_TYPE_INTEGER,
> +		.integer.value = requested_power,
> +	};
> +
> +	union acpi_object *out_obj;
> +	acpi_handle handle;
> +	int result, ret = -EINVAL;
> +
> +	if (!dev || !retry_interval)
> +		return -EINVAL;

I think it's reasonable to allow retry_interval to be NULL if the
caller doesn't want to bother with retries.

> +	handle = ACPI_HANDLE(&dev->dev);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4, 1 << DSM_PCI_D3COLD_AUX_POWER_LIMIT)) {
> +		pci_dbg(dev, "ACPI _DSM 0%Xh not supported\n", DSM_PCI_D3COLD_AUX_POWER_LIMIT);
> +		return -ENODEV;
> +	}
> +
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
> +					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
> +					  &in_obj, ACPI_TYPE_INTEGER);
> +	if (!out_obj)
> +		return -EINVAL;
> +
> +	result = out_obj->integer.value;
> +	if (retry_interval)
> +		*retry_interval = 0;
> +
> +	switch (result) {
> +	case 0x0:
> +		pci_dbg(dev, "D3cold Aux Power %u mW request denied\n",
> +			requested_power);
> +		break;
> +	case 0x1:
> +		pci_info(dev, "D3cold Aux Power request granted: %u mW\n",
> +			 requested_power);
> +		ret = 0;
> +		break;
> +	case 0x2:
> +		pci_info(dev, "D3cold Aux Power: Main power won't be removed\n");
> +		ret = -EBUSY;
> +		break;
> +	default:
> +		if (result >= 0x11 && result <= 0x1F) {
> +			if (retry_interval) {
> +				*retry_interval = result & 0xF;
> +				pci_warn(dev, "D3cold Aux Power request needs retry interval: %u seconds\n",
> +					 *retry_interval);

Seems like pci_info() to me; the user can't do anything about this,
nothing is really wrong, and the message shouldn't prompt a bug
report.

> +				ret = -EAGAIN;
> +			}
> +		} else {
> +			pci_err(dev, "D3cold Aux Power: Reserved or unsupported response: 0x%x\n",
> +				result);
> +		}
> +		break;
> +	}
> +
> +	ACPI_FREE(out_obj);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
> +
>  static void pci_acpi_set_external_facing(struct pci_dev *dev)
>  {
>  	u8 val;
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 078225b514d4..6079306ad754 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -121,6 +121,7 @@ extern const guid_t pci_acpi_dsm_guid;
>  #define DSM_PCI_DEVICE_NAME			0x07
>  #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
>  #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
> +#define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
>  
>  #ifdef CONFIG_PCIE_EDR
>  void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
> @@ -132,10 +133,17 @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
>  
>  int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
>  void pci_acpi_clear_companion_lookup_hook(void);
> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
> +				      u32 *retry_interval);
>  
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> +static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
> +						    u32 *retry_interval)

Wrap this to fit in 80 columns like the rest of the file.

> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif	/* CONFIG_ACPI */
>  
>  #endif	/* _PCI_ACPI_H_ */
> -- 
> 2.34.1
> 

