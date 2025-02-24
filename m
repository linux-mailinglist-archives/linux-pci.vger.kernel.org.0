Return-Path: <linux-pci+bounces-22257-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5F47A42CDF
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 20:40:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 232D23AAE22
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 19:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503E4204C30;
	Mon, 24 Feb 2025 19:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NldbVFHN"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238AF200138;
	Mon, 24 Feb 2025 19:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740426055; cv=none; b=ItTf022l9ovW4v2cby1h2szjGb8moDfh6sS0rqNTWnBBy5wQCjAb1vqpZNO7Y0SlO8+MCtY9q1VOvdISPOgyy5fVwAkY3ZDbghmqk5SSPnfuZh/LPujqir7WiYSs9XhycPVDHGlEovd55FBbUPQzXcydWMQiycJU+LJ6s7ZDpSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740426055; c=relaxed/simple;
	bh=hMex1cz3FOarspx5oeedx9An0Mnh8D7KFW8Kqj+Quzo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=cHb/Ap4QisKsnU+sbk8w+FNzS4qIxI3xoL8Jy0+7UBf0U1Nn8dWuxP9sKSPpw1Y9Hmefrft7k3yNAbFLFTfwfz9lcJ4nLyIdW3Ug+U/36PAso0kqKoOIFd6LdSE/96iyZvBVKrn31sWuvAXwv1ulumrEauUw56i01yX0dAvkh7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NldbVFHN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63347C4CED6;
	Mon, 24 Feb 2025 19:40:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740426054;
	bh=hMex1cz3FOarspx5oeedx9An0Mnh8D7KFW8Kqj+Quzo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=NldbVFHNpZiCpcv67PptuQijfgFhox8iriFrlS0hHfHj9YRAivOHQNikaNhYRQkJ+
	 tnSzjUoddhFWNW86xDaW2HxhpqxZPrL9GRMDrlzfUitz4IEOPoPtecch/hdT5/IJbk
	 u23/zZH2uZvedKiNeIS9E+mmvVMQxdXNOhZUrufVoLI7fdTL6dunCObDBCPd2he1Gm
	 uovusqzNVB5oB6SRhjPnZ5eBkEMfXiPfh/YO9pXMF0grf1xG+tLntvIHqY3iQBI59T
	 gLMDnMmii0fzwGXxhcVRJqu+LlDeRQCqxwAHu0Wj+JrN6oYQ88Q5w/tEFmJ8Sl67nk
	 0qUH5Tcp6lvag==
Date: Mon, 24 Feb 2025 13:40:53 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Anshuman Gupta <anshuman.gupta@intel.com>
Cc: intel-xe@lists.freedesktop.org, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
	bhelgaas@google.com, ilpo.jarvinen@linux.intel.com,
	lucas.demarchi@intel.com, rodrigo.vivi@intel.com,
	badal.nilawar@intel.com, kam.nasim@intel.com,
	Varun Gupta <varun.gupta@intel.com>
Subject: Re: [RFC 1/6] PCI/ACPI: Implement PCI FW _DSM method
Message-ID: <20250224194053.GA471229@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250224164849.3746751-2-anshuman.gupta@intel.com>

On Mon, Feb 24, 2025 at 10:18:44PM +0530, Anshuman Gupta wrote:
> Implement _DSM method 10 and _DSM Method 11 as per PCI firmware specs
> section 4.6.10 and 4.6.11.

Please split into two patches, one for each _DSM.  Include spec
citations, e.g., PCI Firmware r3.3, sec 4.6.10.  Section numbers are
not guaranteed to stay consistent across spec revisions, so we need
both the revision and section number.

Include some descriptive words about the DSM in each subject line,
e.g., "D3cold Aux Power Limit", "PERST# Assertion Delay".

> Current assumption is only one PCIe Endpoint driver (XeKMD for Battlemage GPU)
> will request for Aux Power Limit under a given Root Port but
> theoretically it is possible that other Non-Intel GPU or Non-GPU
> PCIe Endpoint driver can also request for Aux Power Limit and request to
> block the core power removal under same Root Port.
> That will disrupt the Battlemage GPU VRAM Self Refresh.

I guess this is sort of an acknowledgement of the r3.3, sec 4.6.10
spec text about system software being responsible for tracking and
aggregating requests when there are multiple functions below the
Downstream Port?

If so, remove the Battlemage-specific language and just say something
about the fact that this implementation doesn't do any of that
tracking and aggregation.

> One possible mitigation would be only allowing only first PCIe
> Non-Bridge Endpoint Function 0 driver to call_DSM method 10.

Wrap to fill 75 columns in commit logs.  Add blank lines between
paragraphs.

> Signed-off-by: Varun Gupta <varun.gupta@intel.com>
> Signed-off-by: Badal Nilawar <badal.nilawar@intel.com>
> Signed-off-by: Anshuman Gupta <anshuman.gupta@intel.com>
> ---
>  drivers/pci/pci-acpi.c   | 123 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pci-acpi.h |  13 +++++
>  2 files changed, 136 insertions(+)
> 
> diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
> index af370628e583..806f6d19f46c 100644
> --- a/drivers/pci/pci-acpi.c
> +++ b/drivers/pci/pci-acpi.c
> @@ -1421,6 +1421,129 @@ static void pci_acpi_optimize_delay(struct pci_dev *pdev,
>  	ACPI_FREE(obj);
>  }
>  
> +/**
> + * pci_acpi_request_d3cold_aux_power - Request D3cold auxiliary power via ACPI DSM
> + * @dev: PCI device instance
> + * @requested_power: Requested auxiliary power in milliwatts
> + *
> + * This function sends a request to the host BIOS via ACPI _DSM Function 9 to grant
> + * the required D3Cold Auxiliary power for the specified PCI device.
> + * It evaluates the _DSM (Device Specific Method) to request the Auxiliary power and
> + * handles the response accordingly.
> + *
> + * This function shall be only called by 1st non-bridge Endpoint driver on Function 0.
> + * For a Multi-Function Device, the driver for Function 0 is required to report an
> + * aggregate power requirement covering all functions contained within the device.

Wrap to fit in 80 columns like the rest of the file.

> + * Return: Returns 0 on success and errno on failure.
> + */
> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power)
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
> +	if (!dev || !ACPI_HANDLE(&dev->dev))
> +		return -EINVAL;
> +
> +	handle = ACPI_HANDLE(&dev->dev);
> +
> +	out_obj = acpi_evaluate_dsm_typed(handle,
> +					  &pci_acpi_dsm_guid,
> +					  4,
> +					  DSM_PCI_D3COLD_AUX_POWER_LIMIT,
> +					  &in_obj,
> +					  ACPI_TYPE_INTEGER);

Wrap to fill 78-80 columns.

> +	if (!out_obj)
> +		return -EINVAL;
> +
> +	result = out_obj->integer.value;
> +
> +	switch (result) {
> +	case 0x0:
> +		dev_dbg(&dev->dev, "D3cold Aux Power request denied.\n");

Include requested_power here too, for debugging purposes.

> +		break;
> +	case 0x1:
> +		dev_info(&dev->dev, "D3cold Aux Power request granted: %u mW.\n", requested_power);
> +		ret = 0;
> +		break;
> +	case 0x2:
> +		dev_info(&dev->dev, "D3cold Aux Power: Main power will not be removed.\n");

No periods at end of messages.

> +		ret = -EBUSY;
> +		break;
> +	default:
> +		if (result >= 0x11 && result <= 0x1F) {
> +			int retry_interval = result & 0xF;
> +
> +			dev_warn(&dev->dev,
> +				 "D3cold Aux Power request needs retry. Interval: %d seconds.\n", retry_interval);
> +			msleep(retry_interval * 1000);
> +			ret = -EAGAIN;
> +		} else {
> +			dev_err(&dev->dev, "D3cold Aux Power: Reserved or unsupported response: 0x%x.\n", result);
> +		}
> +		break;
> +	}
> +
> +	ACPI_FREE(out_obj);
> +	return ret;
> +}
> +EXPORT_SYMBOL(pci_acpi_request_d3cold_aux_power);
> +
> +/**
> + * pci_acpi_add_perst_assertion_delay - Request PERST delay via ACPI DSM
> + * @dev: PCI device instance
> + * @delay_us: Requested delay_us
> + *
> + * This function sends a request to the host BIOS via ACPI _DSM to grant the required
> + * PERST dealy for the specified PCI device. It evaluates the _DSM (Device
> + * Specific Method) to request the PERST delay and handles the response accordingly.

s/PERST/PERST#/
s/dealy/delay/

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
> +	if (!dev || !ACPI_HANDLE(&dev->dev))
> +		return -EINVAL;
> +
> +	handle = ACPI_HANDLE(&dev->dev);
> +
> +	out_obj = acpi_evaluate_dsm_typed(handle, &pci_acpi_dsm_guid, 4,
> +					  DSM_PCI_PERST_ASSERTION_DELAY, &in_obj, ACPI_TYPE_INTEGER);

Wrap to fit in 78-80 columns.

> +	if (!out_obj)
> +		return -EINVAL;
> +
> +	result = out_obj->integer.value;
> +
> +	if (result == delay_us) {
> +		dev_info(&dev->dev, "PERST# Assertion Delay set to %u microseconds.\n", delay_us);
> +		ret = 0;
> +	} else if (result == 0) {
> +		dev_warn(&dev->dev, "PERST# Assertion Delay request failed, no previous valid request.\n");
> +	} else {
> +		dev_warn(&dev->dev,
> +			 "PERST# Assertion Delay request failed. Previous valid delay: %u microseconds.\n", result);
> +	}
> +
> +	ACPI_FREE(out_obj);
> +	return ret;
> +}
> +EXPORT_SYMBOL(pci_acpi_add_perst_assertion_delay);
> +
>  static void pci_acpi_set_external_facing(struct pci_dev *dev)
>  {
>  	u8 val;
> diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
> index 078225b514d4..4b7373f91a9a 100644
> --- a/include/linux/pci-acpi.h
> +++ b/include/linux/pci-acpi.h
> @@ -121,6 +121,8 @@ extern const guid_t pci_acpi_dsm_guid;
>  #define DSM_PCI_DEVICE_NAME			0x07
>  #define DSM_PCI_POWER_ON_RESET_DELAY		0x08
>  #define DSM_PCI_DEVICE_READINESS_DURATIONS	0x09
> +#define DSM_PCI_D3COLD_AUX_POWER_LIMIT		0x0A
> +#define DSM_PCI_PERST_ASSERTION_DELAY		0x0B
>  
>  #ifdef CONFIG_PCIE_EDR
>  void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
> @@ -132,10 +134,21 @@ static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
>  
>  int pci_acpi_set_companion_lookup_hook(struct acpi_device *(*func)(struct pci_dev *));
>  void pci_acpi_clear_companion_lookup_hook(void);
> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power);
> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us);
>  
>  #else	/* CONFIG_ACPI */
>  static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
>  static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
> +int pci_acpi_request_d3cold_aux_power(struct pci_dev *dev, u32 requested_power)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int pci_acpi_add_perst_assertion_delay(struct pci_dev *dev, u32 delay_us)
> +{
> +	return -EOPNOTSUPP;
> +}
>  #endif	/* CONFIG_ACPI */
>  
>  #endif	/* _PCI_ACPI_H_ */
> -- 
> 2.34.1
> 

