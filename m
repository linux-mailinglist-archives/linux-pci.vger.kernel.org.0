Return-Path: <linux-pci+bounces-28362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3251AC2DA3
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 08:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C18B1BC3875
	for <lists+linux-pci@lfdr.de>; Sat, 24 May 2025 06:00:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77270190497;
	Sat, 24 May 2025 06:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QNgqjhN8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2121C84B7;
	Sat, 24 May 2025 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748066407; cv=none; b=sV+YJqMkfYxGUeywxPhYibwhRYfqMxKlaX7mKfEPrhPQMahnAGtaxtKtcXHgbwdasDnbXFJN2Vin0lhVpdnKkpNtntPdbH9PXfJJbO45mKC7qtOsIwn6fRgiyoenEE3cwJVryT+ncUmC4WrAfGHyp015LiZhevTUG6AiA9LJDy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748066407; c=relaxed/simple;
	bh=0wImLY/RpvtqNWA5NsG5JnTLTECAbi+hPUGBK5OMHRM=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=P9lPt8YpprXpasuwyc6i2v2Dt/tbs9h3nFq5q2F45do36XRuFMDyCN4Mhc0Js/89vgy+schsjKxnrHRQlMSVL1SHCCmcEK/RiQ12j5oeXNcGwlOE7UEtIx7ISTaM+y0AKMBif/h6DT6VxjgSElH3SeeULTUrLf0oPQ5QuCQMhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QNgqjhN8; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748066405; x=1779602405;
  h=message-id:date:mime-version:from:subject:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=0wImLY/RpvtqNWA5NsG5JnTLTECAbi+hPUGBK5OMHRM=;
  b=QNgqjhN8Ap2E2vPQ3Yh48dp+qjx2MSBhzr7BGGUHmaxQYtSvZ4cRuTri
   FpWp44TRhux64kCuhSsQdlAVha9+jm+jAht21Rr67jGynynCXLRNwgClX
   bbOXRvv1BIl1jyUrFULBYrrTwDuKh1q5MDbRgZVO9kMW3nipn97TfRD+U
   AO/Rct3SHMwQE+XN/xV0DNEOwPZVUL5mncaZtsQ2SWn8mJCXD8K30AxNU
   h5E9lOvAGv0X0KCtylJFGQw98JT4DoxQSeLp+CS/N4ItC/mOSvC5d02H+
   cnkyKZ9RPUMNqQzuOQKetnNS0OYtB/iE6FxwW091J3rdSlb73BIo1znsS
   Q==;
X-CSE-ConnectionGUID: 4wiKogqaS+yVvh3LTx2hfQ==
X-CSE-MsgGUID: FG9PmpCXTIK+myeUc7Q18g==
X-IronPort-AV: E=McAfee;i="6700,10204,11441"; a="52744466"
X-IronPort-AV: E=Sophos;i="6.15,310,1739865600"; 
   d="scan'208";a="52744466"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 23:00:05 -0700
X-CSE-ConnectionGUID: y6MzXLV2TPOdKRWQ2i8Iyw==
X-CSE-MsgGUID: si4AEil3QPa43A9NXP5dqA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,310,1739865600"; 
   d="scan'208";a="178569868"
Received: from bjrankin-mobl3.amr.corp.intel.com (HELO [10.124.220.158]) ([10.124.220.158])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2025 23:00:04 -0700
Message-ID: <e9b74268-7b5b-432f-9a4b-9566b0a62ca0@linux.intel.com>
Date: Fri, 23 May 2025 23:00:03 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH v3 01/11] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
To: Badal Nilawar <badal.nilawar@intel.com>, intel-xe@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com, rafael@kernel.org, lenb@kernel.org,
 bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
 lucas.demarchi@intel.com, rodrigo.vivi@intel.com, varun.gupta@intel.com,
 ville.syrjala@linux.intel.com, uma.shankar@intel.com
References: <20250523190155.2623462-1-badal.nilawar@intel.com>
 <20250523190155.2623462-2-badal.nilawar@intel.com>
Content-Language: en-US
In-Reply-To: <20250523190155.2623462-2-badal.nilawar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/23/25 12:01 PM, Badal Nilawar wrote:
> From: Anshuman Gupta<anshuman.gupta@intel.com>
>
> Implement _DSM method 0Ah according to PCI firmware specifications,
> section 4.6.10 Rev 3.3., to request auxilary power needed for the
> device when in D3Cold.
>
> Note that this implementation assumes only a single device below the
> Downstream Port will request for Aux Power Limit under a given
> Root Port because it does not track and aggregate requests
> from all child devices below the Downstream Port as required
> by Section 4.6.10 Rev 3.3.

Add some info about why you are not adding this support?

> One possible mitigation would be only allowing only first PCIe
> Non-Bridge Endpoint Function 0 driver to call_DSM method 0Ah.
>
> V2(Bjorn/Rafael):
>    - Call acpi_dsm_check() to find method 0Ah supported
>    - Return retry interval to caller
>
> Signed-off-by: Varun Gupta<varun.gupta@intel.com>
> Signed-off-by: Badal Nilawar<badal.nilawar@intel.com>
> Signed-off-by: Anshuman Gupta<anshuman.gupta@intel.com>
> ---
>   drivers/pci/pci-acpi.c   | 87 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci-acpi.h |  8 ++++
>   2 files changed, 95 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..76b19525535f 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1421,6 +1421,93 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>   	ACPI_FREE(obj);
>   }
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
> + *
> + * This function shall be only called by 1st non-bridge Endpoint driver
> + * on Function 0. For a Multi-Function Device, the driver for Function 0 is
> + * required to report an aggregate power requirement covering all
> + * functions contained within the device.
> + *
> + * Return: Returns 0 on success and errno on failure.
> + */
> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
> +				      u32 *retry_interval)
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
> +	if (!dev)
> +		return -EINVAL;

Is retry_interval param optional? If not may be a check here for non NULL condition is needed.

> +
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

is this not a error?

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
>   static void pci_acpi_set_external_facing(struct pci_dev *dev)
>   {
>   	u8 val;
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 078225b514d4..1705d03bfe26 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -121,6 +121,7 @@ extern const guid_t pci_acpi_dsm_guid;
>   #define DSM_PCI_DEVICE_NAME			0x07
>   #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
>   #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
> +#define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
>   
>   #ifdef CONFIG_PCIE_EDR
>   void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
> @@ -132,10 +133,17 @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
>   
>   int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
>   void pci_acpi_clear_companion_lookup_hook(void);
> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
> +				      u32 *retry_interval);
>   
>   #else	/* CONFIG_ACPI */
>   static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>   static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> +static int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
> +					     u32 *retry_interval)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif	/* CONFIG_ACPI */
>   
>   #endif	/* _PCI_ACPI_H_ */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


