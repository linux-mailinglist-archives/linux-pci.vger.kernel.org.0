Return-Path: <linux-pci+bounces-28682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4321AAC83A0
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 23:36:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F1B404A2B2F
	for <lists+linux-pci@lfdr.de>; Thu, 29 May 2025 21:36:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987DB21C18E;
	Thu, 29 May 2025 21:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N/iaYIvU"
X-Original-To: linux-pci@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB5020E00A;
	Thu, 29 May 2025 21:36:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748554566; cv=none; b=nhftzD2jhkRWRQs3CFNJ+Z8MmeAO1UakCWRe7P7ZMmLKarLmhyZd2SCNWk6C2F06ExZJOuWMepX6U/xbVx7yyMORS4m6uDKYejFPbXc3sYF19bbEhYE1C75VjMkeP5AC/QSwH1KbN61sPSBt4CukiRQCGN12mQVhaxd9fNgcIpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748554566; c=relaxed/simple;
	bh=LzhtoUUtob6BW3NDMIKUhZacP+Xe9hn6FTWxC++UeLw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ieOoyVTpzzBz9QQ0aT+/BoIIwhrEtEomOUSe1UnD79KasIj1mdN4jU3uovN2fXweWtQgFoTUKTiv9oGiR9xa6ZHIlnsa6sp+EKFQVV24AXUqHa/kECHcA/dTKC0QZutlGE3N9W+grFl7Dw5xpP6nBA8Rmu+DybQJeDVMYkkr3jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N/iaYIvU; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1748554565; x=1780090565;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=LzhtoUUtob6BW3NDMIKUhZacP+Xe9hn6FTWxC++UeLw=;
  b=N/iaYIvUR/j/8S0a9x+dybQIxZhUIRmuqfwY4b17EiTLWd6Ol6zwF+6Q
   TdGdMba6gT9ojujWRMMIm61giJih7GGjenpqzphSwJwybkwlL1kN3QGPB
   Jc/XwGgcKwyJKJLfeEKyui1a/MLPXKQmew9DCyFdBxzDHKoavBrsQWHfs
   nIqXQhBbofQotn4fzTfGNoLD0tatUCfUq7ThZbC70fcXUb/NMuMJMNovX
   ACjL+TeqeZ04lDcne79zti7h9tev+ajGaZX4rmGKNlpt9r5G2Esdq5ffF
   1FojDdqHdIqohM6zrl5XJ1FRTwwagOv5XKqzOQgxqdHEeWAoz22fK8g2O
   Q==;
X-CSE-ConnectionGUID: 8KKB09haQ2C4a+EsG7v9rA==
X-CSE-MsgGUID: UZ6Gk+3aRROMBryVeb339A==
X-IronPort-AV: E=McAfee;i="6700,10204,11448"; a="50338394"
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="50338394"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 14:36:04 -0700
X-CSE-ConnectionGUID: /JS7tU04QeyEv/4+PNzE3w==
X-CSE-MsgGUID: NrUvxHDRSwK3sIVRnm5czQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,194,1744095600"; 
   d="scan'208";a="143510312"
Received: from linux.intel.com ([10.54.29.200])
  by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2025 14:36:03 -0700
Received: from [10.124.222.225] (unknown [10.124.222.225])
	by linux.intel.com (Postfix) with ESMTP id 11BF320B5736;
	Thu, 29 May 2025 14:36:02 -0700 (PDT)
Message-ID: <1c5ddf3c-5184-45aa-878a-48df2c5d6aed@linux.intel.com>
Date: Thu, 29 May 2025 14:36:01 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/11] PCI/ACPI: Add D3cold Aux Power Limit_DSM method
To: Badal Nilawar <badal.nilawar@intel.com>, intel-xe@lists.freedesktop.org,
 linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Cc: anshuman.gupta@intel.com, rafael@kernel.org, lenb@kernel.org,
 bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
 lucas.demarchi@intel.com, rodrigo.vivi@intel.com, varun.gupta@intel.com,
 ville.syrjala@linux.intel.com, uma.shankar@intel.com
References: <20250529111654.3140766-1-badal.nilawar@intel.com>
 <20250529111654.3140766-2-badal.nilawar@intel.com>
Content-Language: en-US
From: Sathyanarayanan Kuppuswamy <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20250529111654.3140766-2-badal.nilawar@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 5/29/25 4:16 AM, Badal Nilawar wrote:
> From: Anshuman Gupta <anshuman.gupta@intel.com>
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
>
> One possible mitigation would be only allowing only first PCIe
> Non-Bridge Endpoint Function 0 driver to call_DSM method 0Ah.
>
> Signed-off-by: Varun Gupta <varun.gupta@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>

If it is Co-developed by above people, you need to add Co-developed-by tag followed
by Signed-off-by tag.

> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
> V2(Bjorn/Rafael):
>    - Call acpi_dsm_check() to find method 0Ah supported
>    - Return retry interval to caller
> V3(Kuppuswamy)
>    - Add NULL check for retry interval
> ---
>   drivers/pci/pci-acpi.c   | 87 ++++++++++++++++++++++++++++++++++++++++
>   include/linux/pci-acpi.h |  8 ++++
>   2 files changed, 95 insertions(+)
>
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..87f30910a5f1 100644
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
> +	if (!dev || !retry_interval)
> +		return -EINVAL;
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

Since you already do NULL check at the top, you don't need above check.

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

Same as above.

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
> index 078225b514d4..6079306ad754 100644
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
> +static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
> +						    u32 *retry_interval)
> +{
> +	return -EOPNOTSUPP;
> +}
>   #endif	/* CONFIG_ACPI */
>   
>   #endif	/* _PCI_ACPI_H_ */

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer


