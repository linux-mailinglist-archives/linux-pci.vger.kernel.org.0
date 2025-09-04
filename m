Return-Path: <linux-pci+bounces-35474-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9DDB445AA
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 20:44:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DA355457C5
	for <lists+linux-pci@lfdr.de>; Thu,  4 Sep 2025 18:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D12E31A56D;
	Thu,  4 Sep 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPLjZeXT"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305231EE7B9;
	Thu,  4 Sep 2025 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757011469; cv=none; b=b0hVNzpJjQocIFIqKpd3ic8BONzSqFKxIAdk9mB1tKTUAg00PuCyWNGZ3oxvHmElM6KEJDZSZJuQqCGzAksNACuBV2FKCyhnSWNTYnKSwQGeUUKxCWh/oKUJ4M/yG3LZ57WVlte/dX1c5LUreSS2INBliW4CL2UC62xz1//cL5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757011469; c=relaxed/simple;
	bh=Nb/tN4WW/IDy9CTurmI7eX3/R7O/GHtYggrocLPhBLA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=mAq2XyrH/aZx4IsW11aCmDJ8+nYQf5MVA5A91kjbkyv8cfFXnQSQmik5TgofIIvu4pOCSpknTDFw14ujd71LHEYtwEvtsYsW982bkYUsrxNNwq1m9srjNwEGscZyN/dVpO+4gGA0YnGAoakoQVBUFZ0hhKPzyXWn4heUH9Fhuxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPLjZeXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8AF5C4CEF0;
	Thu,  4 Sep 2025 18:44:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757011469;
	bh=Nb/tN4WW/IDy9CTurmI7eX3/R7O/GHtYggrocLPhBLA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=DPLjZeXTe13aBSUlVLGBHZXeoXwUbxey2FMdo5B6r7GO8gz6Zdu8+o4rBlMgtKaRp
	 MHdNHcAbsgbrYTJz6IjI0vnSIm8wvDQPgmyJPCOFOAUNvjI9HVZegSz6fFry3JmH09
	 753u9YfjfpIUxutX8vCPll9jF99NmZYSoxUntFXFQEJtJx4gR1QFxFLdQkFcC3vtKp
	 7XSv5/1ed1nnoszb2FLut7yu9e/z4OB5GyoX2AcJDRXGGlCGbiynt/C6X7nWmACM8U
	 zb4COM90tDdm/fxTeakClaflRRTrpST04qVeRbGkpPCSXlF9DBGdJkYpqn/CNRdCwp
	 bMsfBhHaK4OsQ==
Date: Thu, 4 Sep 2025 13:44:27 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Badal Nilawar <badal.nilawar@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, anshuman.gupta@intel.com,
	rafael@kernel.org, lenb@kernel.org, bhelgaas@google.com,
	ilpo.jarvinen@linux.intel.com, lucas.demarchi@intel.com,
	rodrigo.vivi@intel.com, varun.gupta@intel.com,
	ville.syrjala@linux.intel.com, uma.shankar@intel.com
Subject: Re: [PATCH v4 03/11] PCI/ACPI: Add PERST# Assertion Delay _DSM method
Message-ID: <20250904184427.GA1271351@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250529111654.3140766-4-badal.nilawar@intel.com>

On Thu, May 29, 2025 at 04:46:46PM +0530, Badal Nilawar wrote:
> From: Anshuman Gupta <anshuman.gupta@intel.com>
> 
> Implement _DSM Method 0Bh as per PCI firmware specs
> section 4.6.11 Rev 3.3.

Update citation as for the other _DSM function.

> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> ---
>  drivers/pci/pci-acpi.c   | 57 ++++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |  8 +++++-
>  2 files changed, 64 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index d33efba4ca94..88044491feaa 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1531,6 +1531,63 @@ int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>  }
>  EXPORT_SYMBOL_GPL(pci_acpi_request_d3cold_aux_power);
>  
> +/**
> + * pci_acpi_add_perst_assertion_delay - Request PERST# delay via ACPI DSM
> + * @dev: PCI device instance
> + * @delay_us: Requested delay_us
> + *
> + * This function sends a request to the host BIOS via ACPI _DSM to grant the
> + * required PERST# delay for the specified PCI device. It evaluates the _DSM
> + * to request the PERST# delay and handles the response accordingly.

Reword in imperative mood.

Like pci_acpi_request_d3cold_aux_power(), I think the driver should
call this with its device, not the Root Port.

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
> +	acpi_handle handle;
> +	int result, ret = -EINVAL;
> +
> +	if (!dev)
> +		return -EINVAL;
> +
> +	handle = ACPI_HANDLE(&dev->dev);
> +	if (!handle)
> +		return -EINVAL;
> +
> +	if (!acpi_check_dsm(handle, &pci_acpi_dsm_guid, 4, 1 << DSM_PCI_PERST_ASSERTION_DELAY)) {
> +		pci_dbg(dev, "ACPI _DSM 0%Xh not supported\n", DSM_PCI_PERST_ASSERTION_DELAY);
> +		return -ENODEV;
> +	}
> +
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
> +					  DSM_PCI_PERST_ASSERTION_DELAY,
> +					  &in_obj, ACPI_TYPE_INTEGER);
> +	if (!out_obj)
> +		return -EINVAL;
> +
> +	result = out_obj->integer.value;
> +
> +	if (result == delay_us) {
> +		pci_info(dev, "PERST# Assertion Delay set to %u microseconds\n", delay_us);
> +		ret = 0;
> +	} else if (result == 0) {
> +		pci_warn(dev, "PERST# Assertion Delay request failed, no previous valid request\n");
> +	} else {
> +		pci_warn(dev, "PERST# Assertion Delay request failed, Previous valid delay: %u microseconds\n",
> +			 result);
> +	}
> +
> +	ACPI_FREE(out_obj);
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(pci_acpi_add_perst_assertion_delay);
> +
>  static void pci_acpi_set_external_facing(struct pci_dev *dev)
>  {
>  	u8 val;
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 6079306ad754..e53d4893cf56 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -122,6 +122,7 @@ extern const guid_t pci_acpi_dsm_guid;
>  #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
>  #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
>  #define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
> +#define DSM_PCI_PERST_ASSERTION_DELAY		0x0B
>  
>  #ifdef CONFIG_PCIE_EDR
>  void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
> @@ -135,7 +136,7 @@ int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_de
>  void pci_acpi_clear_companion_lookup_hook(void);
>  int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power,
>  				      u32 *retry_interval);
> -
> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us);
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> @@ -144,6 +145,11 @@ static inline int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 req
>  {
>  	return -EOPNOTSUPP;
>  }
> +
> +static inline int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)

Wrap to fit in 80 columns like the rest of the file.

> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif	/* CONFIG_ACPI */
>  
>  #endif	/* _PCI_ACPI_H_ */
> -- 
> 2.34.1
> 

