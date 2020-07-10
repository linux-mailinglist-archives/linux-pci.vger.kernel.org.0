Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1021BF68
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jul 2020 23:53:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726262AbgGJVxG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jul 2020 17:53:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:55332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726260AbgGJVxG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 10 Jul 2020 17:53:06 -0400
Received: from localhost (mobile-166-175-191-139.mycingular.net [166.175.191.139])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9A53B20725;
        Fri, 10 Jul 2020 21:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594417985;
        bh=3f59RhfbF8QO0TBC09ZsyPczKb2Ol+fbaWOmeNBJMgk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=aW2rQsCWU0PxhiyE/HTU/wRjqUygCgsIgLWazL41LDe/w/Kks+O9v/xTqAhdDiB5+
         cN2Nj5NeXcriZEir1PUwkbXorjF2A3CjTKAWP2/ubSFOLcI/c1Y5p4j5RvkM1YCrA2
         XiN4YpP59bgsbybD9F5gy91NsoaweJP0HnFD8Xng=
Date:   Fri, 10 Jul 2020 16:53:03 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Sean V Kelley <sean.v.kelley@linux.intel.com>
Cc:     rjw@rjwysocki.net, bhelgaas@google.com, lenb@kernel.org,
        robert.moore@intel.com, erik.kaneda@intel.com,
        linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: [RFC PATCH] ACPI: Add support for CXL_OSC
Message-ID: <20200710215303.GA87740@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200708235742.340914-1-sean.v.kelley@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jul 08, 2020 at 04:57:42PM -0700, Sean V Kelley wrote:
> Compute eXpress Link host bridges enumerate to the OS with
> ACPI-described support and control capabilities. An _OSC interface
> applies to host bridge ACPI devices that originate CXL hierarchies.
> 
> These ACPI devices have a _HID of (_CID including) EISAID(“ACPI0016”).
> For CXL 2.0 and later hierarchies, CXL _OSC is required. CXL _OSC is
> optional for CXL 1.1 hierarchies. A CXL host bridge also originates a
> PCIe hierarchy and will have a _CID of EISAID(“PNP0A08”). As such, a CXL
> Host Bridge device may expose either CXL _OSC or PCIe _OSC.
> 
> CXL end point devices connected behind a CXL bridge are standard PCI or
> CXL devices. It is the same device with two labels - ACPI0016 or PNP0A08
> label. For example, with a given bridge device ‘PC01’ definition, the OS
> will be able to find PCI devices connected behind this bridge.
> 
>                       | CPU Root Bus 0x14 |
>                       | Downstream Port   |
>                        -------------------
>                                |
>                                | Flex Bus
>                                |
>                       |                   |  ACPI Device PC01
>                       |  Root Bus 0x15    |
>                        -------------------
>                           |          |
>                           |          |
>                       | RCiEP |   | RCiEP |
>                       |       |   | or EP |
>                       | D0 F0 |   | D0 F1 |
>                        -------     -------
> 
> As a result, it instantiates another PNP0A08 or ACPI0016 device. PN0A08
> is therefore legacy support and the ACPI0016 is for a CXL aware OS. A CXL
> aware OS would look for CXL first. If the OS evaluates CXL _OSC, it shall
> not evaluate PCIe _OSC.

s/PN0A08/PNP0A08/

But Linux really doesn't use PNP0A08 at all except to avoid a warning
for conventional PCI host bridges for which we don't have an _OSC.

PNP0A03 is really all Linux uses today.  And presumably your CXL
bridges would also include PNP0A03 in their _CID.

> This patch implements support for CXL _OSC for CXL 1.1 hiearchies.  This
> is intended as an RFC to open discussion on the feature and its
> implementation.
> 
> Some caveats and questions to consider:
> 
> 1) pci_root.c goes through many levels of calls that may need some
> changes. These patches attempt to live-with the current state. Should
> the first step perhaps be more refactoring to make room so to speak
> for the addition of CXL?

negotiate_os_control() is incredibly ugly.  I'd love it if it could be
simplified somehow, but I don't have any good suggestions.  I've tried
and failed several times.

> 2) I avoided rename where possible, and so where you see say OSC_SUPPORT
> that implies PCI.
> 
> 3) I attempted to avoid increasing the complexity of an existing function
> by creating a new CXL specific one.  In some cases CXL and PCI handling
> coexist in the same function.
> 
> As with my past CXL Enumeration RFC there are no fw images or device
> drivers yet and so this is not ready for consideration for merge.
> However, I would like to get discussion started on the ACPI changes
> needed especially if it points to some prior refactoring needs.
> 
> DocLink: https://www.computeexpresslink.org/
> DocLink: https://uefi.org/

More specific references would be useful.  Specific document,
revision, and section number.

Of course, this will all have to be packaged up with users before it
makes sense to merge it.  I know that's obvious :)

> Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
> ---
>  drivers/acpi/pci_root.c | 374 ++++++++++++++++++++++++++++------------
>  include/acpi/acpi_bus.h |   6 +-
>  include/linux/acpi.h    |  18 ++
>  3 files changed, 288 insertions(+), 110 deletions(-)
> 
> diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
> index f90e841c59f5..e71fb682072b 100644
> --- a/drivers/acpi/pci_root.c
> +++ b/drivers/acpi/pci_root.c
> @@ -45,6 +45,7 @@ static int acpi_pci_root_scan_dependent(struct acpi_device *adev)
>  
>  static const struct acpi_device_id root_device_ids[] = {
>  	{"PNP0A03", 0},
> +	{"ACPI0016", 0},
>  	{"", 0},
>  };
>  
> @@ -135,6 +136,13 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
>  	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-Type3" },
>  };
>  
> +static struct pci_osc_bit_struct cxl_osc_support_bit[] = {
> +	{ OSC_CXL_PORT_REG_ACCESS_SUPPORT, "CXLPortRegAccess" },
> +	{ OSC_CXL_PORT_DEV_REG_ACCESS_SUPPORT, "CXLPortDevRegAccess" },
> +	{ OSC_CXL_PER_SUPPORT, "CXLProtocolErrorReporting" },
> +	{ OSC_CXL_NATIVE_HP_SUPPORT, "CXLNativeHotPlug" },
> +};
> +
>  static struct pci_osc_bit_struct pci_osc_control_bit[] = {
>  	{ OSC_PCI_EXPRESS_NATIVE_HP_CONTROL, "PCIeHotplug" },
>  	{ OSC_PCI_SHPC_NATIVE_HP_CONTROL, "SHPCHotplug" },
> @@ -145,6 +153,10 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
>  	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
>  };
>  
> +static struct pci_osc_bit_struct cxl_osc_control_bit[] = {
> +	{ OSC_CXL_MEM_PER_CONTROL, "CXLMemProtocolErrorReport" },
> +};
> +
>  static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
>  			    struct pci_osc_bit_struct *table, int size)
>  {
> @@ -161,27 +173,40 @@ static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
>  	dev_info(&root->device->dev, "_OSC: %s [%s]\n", msg, buf);
>  }
>  
> -static void decode_osc_support(struct acpi_pci_root *root, char *msg, u32 word)
> +static void decode_cxl_osc_support(struct acpi_pci_root *root, char *msg, u32 word)
> +{
> +	decode_osc_bits(root, msg, word, cxl_osc_support_bit,
> +			ARRAY_SIZE(cxl_osc_support_bit));
> +}
> +
> +static void decode_cxl_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
> +{
> +	decode_osc_bits(root, msg, word, cxl_osc_control_bit,
> +			ARRAY_SIZE(cxl_osc_control_bit));
> +}
> +
> +static void decode_pci_osc_support(struct acpi_pci_root *root, char *msg, u32 word)
>  {
>  	decode_osc_bits(root, msg, word, pci_osc_support_bit,
>  			ARRAY_SIZE(pci_osc_support_bit));
>  }
>  
> -static void decode_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
> +static void decode_pci_osc_control(struct acpi_pci_root *root, char *msg, u32 word)
>  {
>  	decode_osc_bits(root, msg, word, pci_osc_control_bit,
>  			ARRAY_SIZE(pci_osc_control_bit));
>  }
>  
>  static u8 pci_osc_uuid_str[] = "33DB4D5B-1FF7-401C-9657-7441C03DD766";
> +static u8 cxl_osc_uuid_str[] = "68F2D50B-C469-4d8A-BD3D-941A103FD3FC";
>  
> -static acpi_status acpi_pci_run_osc(acpi_handle handle,
> -				    const u32 *capbuf, u32 *retval)
> +static acpi_status acpi_cap_run_osc(acpi_handle handle,
> +				    const u32 *capbuf, u8 *uuid_str, u32 *retval)
>  {
>  	struct acpi_osc_context context = {
> -		.uuid_str = pci_osc_uuid_str,
> +		.uuid_str = uuid_str,
>  		.rev = 1,
> -		.cap.length = 12,
> +		.cap.length = 20,
>  		.cap.pointer = (void *)capbuf,
>  	};
>  	acpi_status status;
> @@ -194,12 +219,41 @@ static acpi_status acpi_pci_run_osc(acpi_handle handle,
>  	return status;
>  }
>  
> +static acpi_status acpi_cxl_query_osc(struct acpi_pci_root *root,
> +				      u32 support,
> +				      u32 *control)
> +{
> +	acpi_status status;
> +	u32 result, capbuf[5];
> +
> +	support &= OSC_CXL_SUPPORT_MASKS;
> +	support |= root->cxl_osc_support_set;
> +
> +	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
> +	capbuf[CXL_OSC_SUPPORT_DWORD] = support;
> +	if (control) {
> +		*control &= OSC_CXL_CONTROL_MASKS;
> +		capbuf[CXL_OSC_CONTROL_DWORD] = *control | root->cxl_osc_control_set;
> +	} else {
> +		/* Run _OSC query only with existing controls. */
> +		capbuf[CXL_OSC_CONTROL_DWORD] = root->cxl_osc_control_set;
> +	}
> +
> +	status = acpi_cap_run_osc(root->device->handle, capbuf, cxl_osc_uuid_str, &result);
> +	if (ACPI_SUCCESS(status)) {
> +		root->cxl_osc_support_set = support;
> +		if (control)
> +			*control = result;
> +	}
> +	return status;
> +}
> +
>  static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
> -					u32 support,
> -					u32 *control)
> +				      u32 support,
> +				      u32 *control)
>  {
>  	acpi_status status;
> -	u32 result, capbuf[3];
> +	u32 result, capbuf[5];
>  
>  	support &= OSC_PCI_SUPPORT_MASKS;
>  	support |= root->osc_support_set;
> @@ -214,7 +268,7 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>  		capbuf[OSC_CONTROL_DWORD] = root->osc_control_set;
>  	}
>  
> -	status = acpi_pci_run_osc(root->device->handle, capbuf, &result);
> +	status = acpi_cap_run_osc(root->device->handle, capbuf, pci_osc_uuid_str, &result);
>  	if (ACPI_SUCCESS(status)) {
>  		root->osc_support_set = support;
>  		if (control)
> @@ -223,6 +277,16 @@ static acpi_status acpi_pci_query_osc(struct acpi_pci_root *root,
>  	return status;
>  }
>  
> +static acpi_status acpi_cxl_osc_support(struct acpi_pci_root *root, u32 flags)
> +{
> +	acpi_status status;
> +
> +	mutex_lock(&osc_lock);
> +	status = acpi_cxl_query_osc(root, flags, NULL);
> +	mutex_unlock(&osc_lock);
> +	return status;
> +}
> +
>  static acpi_status acpi_pci_osc_support(struct acpi_pci_root *root, u32 flags)
>  {
>  	acpi_status status;
> @@ -359,7 +423,7 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
>  {
>  	struct acpi_pci_root *root;
>  	acpi_status status = AE_OK;
> -	u32 ctrl, capbuf[3];
> +	u32 ctrl, capbuf[5];
>  
>  	if (!mask)
>  		return AE_BAD_PARAMETER;
> @@ -386,14 +450,14 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
>  			goto out;
>  		if (ctrl == *mask)
>  			break;
> -		decode_osc_control(root, "platform does not support",
> -				   ctrl & ~(*mask));
> +		decode_pci_osc_control(root, "platform does not support",
> +				       ctrl & ~(*mask));
>  		ctrl = *mask;
>  	}
>  
>  	if ((ctrl & req) != req) {
> -		decode_osc_control(root, "not requesting control; platform does not support",
> -				   req & ~(ctrl));
> +		decode_pci_osc_control(root, "not requesting control; platform does not support",
> +				       req & ~(ctrl));
>  		status = AE_SUPPORT;
>  		goto out;
>  	}
> @@ -401,7 +465,7 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
>  	capbuf[OSC_QUERY_DWORD] = 0;
>  	capbuf[OSC_SUPPORT_DWORD] = root->osc_support_set;
>  	capbuf[OSC_CONTROL_DWORD] = ctrl;
> -	status = acpi_pci_run_osc(handle, capbuf, mask);
> +	status = acpi_cap_run_osc(handle, capbuf, pci_osc_uuid_str, mask);
>  	if (ACPI_SUCCESS(status))
>  		root->osc_control_set = *mask;
>  out:
> @@ -410,119 +474,212 @@ acpi_status acpi_pci_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
>  }
>  EXPORT_SYMBOL(acpi_pci_osc_control_set);
>  
> +/**
> + * acpi_cxl_osc_control_set - Request control of CXL root _OSC features.
> + * @handle: ACPI handle of a PCI root bridge (or PCIe Root Complex).
> + * @mask: Mask of _OSC bits to request control of, place to store control mask.
> + * @req: Mask of _OSC bits the control of is essential to the caller.
> + **/
> +acpi_status acpi_cxl_osc_control_set(acpi_handle handle, u32 *mask, u32 req)
> +{
> +	struct acpi_pci_root *root;
> +	acpi_status status = AE_OK;
> +	u32 ctrl, capbuf[5];
> +
> +	if (!mask)
> +		return AE_BAD_PARAMETER;
> +
> +	ctrl = *mask & OSC_CXL_CONTROL_MASKS;
> +	if ((ctrl & req) != req)
> +		return AE_TYPE;
> +
> +	root = acpi_pci_find_root(handle);
> +	if (!root)
> +		return AE_NOT_EXIST;
> +
> +	mutex_lock(&osc_lock);
> +
> +	*mask = ctrl | root->cxl_osc_control_set;
> +	/* No need to evaluate _OSC if the control was already granted. */
> +	if ((root->cxl_osc_control_set & ctrl) == ctrl)
> +		goto out;
> +
> +	/* Need to check the available controls bits before requesting them. */
> +	while (*mask) {
> +		status = acpi_cxl_query_osc(root, root->cxl_osc_support_set, mask);
> +		if (ACPI_FAILURE(status))
> +			goto out;
> +		if (ctrl == *mask)
> +			break;
> +		decode_cxl_osc_control(root, "platform does not support",
> +				       ctrl & ~(*mask));
> +		ctrl = *mask;
> +	}
> +
> +	if ((ctrl & req) != req) {
> +		decode_cxl_osc_control(root, "not requesting control; platform does not support",
> +				       req & ~(ctrl));
> +		status = AE_SUPPORT;
> +		goto out;
> +	}
> +
> +	capbuf[OSC_QUERY_DWORD] = 0;
> +	capbuf[CXL_OSC_SUPPORT_DWORD] = root->cxl_osc_support_set;
> +	capbuf[CXL_OSC_CONTROL_DWORD] = ctrl;
> +	status = acpi_cap_run_osc(handle, capbuf, cxl_osc_uuid_str, mask);
> +	if (ACPI_SUCCESS(status))
> +		root->cxl_osc_control_set = *mask;
> +out:
> +	mutex_unlock(&osc_lock);
> +	return status;
> +}
> +EXPORT_SYMBOL(acpi_cxl_osc_control_set);
> +
>  static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
> -				 bool is_pcie)
> +				 bool is_pcie, bool is_cxl)
>  {
> -	u32 support, control, requested;
> +	u32 cxl_support, cxl_control, pci_support, pci_control, requested;
>  	acpi_status status;
>  	struct acpi_device *device = root->device;
>  	acpi_handle handle = device->handle;
>  
> -	/*
> -	 * Apple always return failure on _OSC calls when _OSI("Darwin") has
> -	 * been called successfully. We know the feature set supported by the
> -	 * platform, so avoid calling _OSC at all
> -	 */
> -	if (x86_apple_machine) {
> -		root->osc_control_set = ~OSC_PCI_EXPRESS_PME_CONTROL;
> -		decode_osc_control(root, "OS assumes control of",
> -				   root->osc_control_set);
> -		return;
> -	}
>  
> -	/*
> -	 * All supported architectures that use ACPI have support for
> -	 * PCI domains, so we indicate this in _OSC support capabilities.
> -	 */
> -	support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
> -	support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
> -	if (pci_ext_cfg_avail())
> -		support |= OSC_PCI_EXT_CONFIG_SUPPORT;
> -	if (pcie_aspm_support_enabled())
> -		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
> -	if (pci_msi_enabled())
> -		support |= OSC_PCI_MSI_SUPPORT;
> -	if (IS_ENABLED(CONFIG_PCIE_EDR))
> -		support |= OSC_PCI_EDR_SUPPORT;
> -
> -	decode_osc_support(root, "OS supports", support);
> -	status = acpi_pci_osc_support(root, support);
> -	if (ACPI_FAILURE(status)) {
> -		*no_aspm = 1;
> +	if (is_cxl) {

It would drastically shorten your patch if you used this style
instead:

  if (is_cxl) {
    ...
    return;
  }

  <existing code>

Or, probably even better, just make a new negotiate_cxl_control() and
make the caller choose.

> +		cxl_support = 0; /* No presumed default CXL_OSC support capabilities */
> +		cxl_control = 0; /* No presumed default CXL_OSC control capabilities */
>  
> -		/* _OSC is optional for PCI host bridges */
> -		if ((status == AE_NOT_FOUND) && !is_pcie)
> +		decode_cxl_osc_support(root, "OS supports", cxl_support);
> +		status = acpi_cxl_osc_support(root, cxl_support);
> +		if (ACPI_FAILURE(status)) {
> +			dev_info(&device->dev, "CXL_OSC failed (%s)\n",
> +				 acpi_format_exception(status));
>  			return;
> +		}
>  
> -		dev_info(&device->dev, "_OSC failed (%s)%s\n",
> -			 acpi_format_exception(status),
> -			 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
> -		return;
> -	}
> +		cxl_control = OSC_CXL_MEM_PER_CONTROL;
> +		requested = cxl_control;
> +		status = acpi_cxl_osc_control_set(handle, &cxl_control,
> +						  OSC_CXL_MEM_PER_CONTROL);
> +		if (ACPI_SUCCESS(status)) {
> +			decode_cxl_osc_control(root, "OS now controls",
> +					       cxl_control);
> +		} else {
> +			decode_cxl_osc_control(root, "OS requested", requested);
> +			decode_cxl_osc_control(root, "platform willing to grant",
> +					       cxl_control);
> +			dev_info(&device->dev, "_OSC failed (%s)\n",
> +				 acpi_format_exception(status));
> +		}
>  
> -	if (pcie_ports_disabled) {
> -		dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
> -		return;
> -	}
> +	} else { /* PCI/PCIe */
>  
> -	if ((support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
> -		decode_osc_support(root, "not requesting OS control; OS requires",
> -				   ACPI_PCIE_REQ_SUPPORT);
> -		return;
> -	}
> +		/*
> +		 * Apple always return failure on _OSC calls when _OSI("Darwin") has
> +		 * been called successfully. We know the feature set supported by the
> +		 * platform, so avoid calling _OSC at all
> +		 */
> +		if (x86_apple_machine) {
> +			root->osc_control_set = ~OSC_PCI_EXPRESS_PME_CONTROL;
> +			decode_pci_osc_control(root, "OS assumes control of",
> +					       root->osc_control_set);
> +			return;
> +		}
> +
> +		/*
> +		 * All supported architectures that use ACPI have support for
> +		 * PCI domains, so we indicate this in _OSC support capabilities.
> +		 */
> +		pci_support = OSC_PCI_SEGMENT_GROUPS_SUPPORT;
> +		pci_support |= OSC_PCI_HPX_TYPE_3_SUPPORT;
> +		if (pci_ext_cfg_avail())
> +			pci_support |= OSC_PCI_EXT_CONFIG_SUPPORT;
> +		if (pcie_aspm_support_enabled())
> +			pci_support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
> +		if (pci_msi_enabled())
> +			pci_support |= OSC_PCI_MSI_SUPPORT;
> +		if (IS_ENABLED(CONFIG_PCIE_EDR))
> +			pci_support |= OSC_PCI_EDR_SUPPORT;
> +
> +		decode_pci_osc_support(root, "OS supports", pci_support);
> +		status = acpi_pci_osc_support(root, pci_support);
> +		if (ACPI_FAILURE(status)) {
> +			*no_aspm = 1;
> +
> +			/* _OSC is optional for PCI host bridges */
> +			if (status == AE_NOT_FOUND && !is_pcie)
> +				return;
> +
> +			dev_info(&device->dev, "_OSC failed (%s)%s\n",
> +				 acpi_format_exception(status),
> +				 pcie_aspm_support_enabled() ? "; disabling ASPM" : "");
> +			return;
> +		}
> +
> +		if (pcie_ports_disabled) {
> +			dev_info(&device->dev, "PCIe port services disabled; not requesting _OSC control\n");
> +			return;
> +		}
>  
> -	control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> -		| OSC_PCI_EXPRESS_PME_CONTROL;
> +		if ((pci_support & ACPI_PCIE_REQ_SUPPORT) != ACPI_PCIE_REQ_SUPPORT) {
> +			decode_pci_osc_support(root, "not requesting OS control; OS requires",
> +					       ACPI_PCIE_REQ_SUPPORT);
> +			return;
> +		}
>  
> -	if (IS_ENABLED(CONFIG_PCIEASPM))
> -		control |= OSC_PCI_EXPRESS_LTR_CONTROL;
> +		pci_control = OSC_PCI_EXPRESS_CAPABILITY_CONTROL
> +			| OSC_PCI_EXPRESS_PME_CONTROL;
>  
> -	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> -		control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
> +		if (IS_ENABLED(CONFIG_PCIEASPM))
> +			pci_control |= OSC_PCI_EXPRESS_LTR_CONTROL;
>  
> -	if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> -		control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
> +		if (IS_ENABLED(CONFIG_HOTPLUG_PCI_PCIE))
> +			pci_control |= OSC_PCI_EXPRESS_NATIVE_HP_CONTROL;
>  
> -	if (pci_aer_available())
> -		control |= OSC_PCI_EXPRESS_AER_CONTROL;
> +		if (IS_ENABLED(CONFIG_HOTPLUG_PCI_SHPC))
> +			pci_control |= OSC_PCI_SHPC_NATIVE_HP_CONTROL;
>  
> -	/*
> -	 * Per the Downstream Port Containment Related Enhancements ECN to
> -	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> -	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
> -	 * and EDR.
> -	 */
> -	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> -		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> +		if (pci_aer_available())
> +			pci_control |= OSC_PCI_EXPRESS_AER_CONTROL;
> +
> +		/*
> +		 * Per the Downstream Port Containment Related Enhancements ECN to
> +		 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
> +		 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
> +		 * and EDR.
> +		 */
> +		if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
> +			pci_control |= OSC_PCI_EXPRESS_DPC_CONTROL;
> +
> +		requested = pci_control;
> +		status = acpi_pci_osc_control_set(handle, &pci_control,
> +						  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
> +		if (ACPI_SUCCESS(status)) {
> +			decode_pci_osc_control(root, "OS now controls", pci_control);
> +			if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
> +				/*
> +				 * We have ASPM control, but the FADT indicates that
> +				 * it's unsupported. Leave existing configuration
> +				 * intact and prevent the OS from touching it.
> +				 */
> +				dev_info(&device->dev, "FADT indicates ASPM is unsupported, using BIOS configuration\n");
> +				*no_aspm = 1;
> +			}
> +		} else {
> +			decode_pci_osc_control(root, "OS requested", requested);
> +			decode_pci_osc_control(root, "platform willing to grant",
> +					       pci_control);
> +			dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
> +				 acpi_format_exception(status));
>  
> -	requested = control;
> -	status = acpi_pci_osc_control_set(handle, &control,
> -					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
> -	if (ACPI_SUCCESS(status)) {
> -		decode_osc_control(root, "OS now controls", control);
> -		if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_ASPM) {
>  			/*
> -			 * We have ASPM control, but the FADT indicates that
> -			 * it's unsupported. Leave existing configuration
> -			 * intact and prevent the OS from touching it.
> +			 * We want to disable ASPM here, but aspm_disabled
> +			 * needs to remain in its state from boot so that we
> +			 * properly handle PCIe 1.1 devices.  So we set this
> +			 * flag here, to defer the action until after the ACPI
> +			 * root scan.
>  			 */
> -			dev_info(&device->dev, "FADT indicates ASPM is unsupported, using BIOS configuration\n");
>  			*no_aspm = 1;
>  		}
> -	} else {
> -		decode_osc_control(root, "OS requested", requested);
> -		decode_osc_control(root, "platform willing to grant", control);
> -		dev_info(&device->dev, "_OSC failed (%s); disabling ASPM\n",
> -			acpi_format_exception(status));
> -
> -		/*
> -		 * We want to disable ASPM here, but aspm_disabled
> -		 * needs to remain in its state from boot so that we
> -		 * properly handle PCIe 1.1 devices.  So we set this
> -		 * flag here, to defer the action until after the ACPI
> -		 * root scan.
> -		 */
> -		*no_aspm = 1;
>  	}
>  }
>  
> @@ -536,7 +693,7 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  	acpi_handle handle = device->handle;
>  	int no_aspm = 0;
>  	bool hotadd = system_state == SYSTEM_RUNNING;
> -	bool is_pcie;
> +	bool is_pcie, is_cxl;
>  
>  	root = kzalloc(sizeof(struct acpi_pci_root), GFP_KERNEL);
>  	if (!root)
> @@ -595,7 +752,8 @@ static int acpi_pci_root_add(struct acpi_device *device,
>  	root->mcfg_addr = acpi_pci_root_get_mcfg_addr(handle);
>  
>  	is_pcie = strcmp(acpi_device_hid(device), "PNP0A08") == 0;
> -	negotiate_os_control(root, &no_aspm, is_pcie);
> +	is_cxl = strcmp(acpi_device_hid(device), "ACPI0016") == 0;
> +	negotiate_os_control(root, &no_aspm, is_pcie, is_cxl);
>  
>  	/*
>  	 * TBD: Need PCI interface for enumeration/configuration of roots.
> diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> index 5afb6ceb284f..8f3068b6118b 100644
> --- a/include/acpi/acpi_bus.h
> +++ b/include/acpi/acpi_bus.h
> @@ -577,8 +577,10 @@ struct acpi_pci_root {
>  	u16 segment;
>  	struct resource secondary;	/* downstream bus range */
>  
> -	u32 osc_support_set;	/* _OSC state of support bits */
> -	u32 osc_control_set;	/* _OSC state of control bits */
> +	u32 osc_support_set;		/* _OSC state of support bits */
> +	u32 osc_control_set;		/* _OSC state of control bits */
> +	u32 cxl_osc_support_set;	/* _OSC state of CXL support bits */
> +	u32 cxl_osc_control_set;	/* _OSC state of CXL control bits */

Probably "osc_cxl_support_set".  Also for the #defines below.

I assume there will be a CONFIG_PCI_CXL or similar that will wrap much
of this code.

>  	phys_addr_t mcfg_addr;
>  };
>  
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d661cd0ee64d..7c41535f4dc9 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -527,6 +527,8 @@ acpi_status acpi_run_osc(acpi_handle handle, struct acpi_osc_context *context);
>  #define OSC_QUERY_DWORD				0	/* DWORD 1 */
>  #define OSC_SUPPORT_DWORD			1	/* DWORD 2 */
>  #define OSC_CONTROL_DWORD			2	/* DWORD 3 */
> +#define CXL_OSC_SUPPORT_DWORD			3	/* DWORD 4 */
> +#define CXL_OSC_CONTROL_DWORD			4	/* DWORD 5 */
>  
>  /* _OSC Capabilities DWORD 1: Query/Control and Error Returns (generic) */
>  #define OSC_QUERY_ENABLE			0x00000001  /* input */
> @@ -570,6 +572,20 @@ extern bool osc_pc_lpi_support_confirmed;
>  #define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
>  #define OSC_PCI_CONTROL_MASKS			0x000000bf
>  
> +/* CXL Host Bridge _OSC: Capabilities DWORD 4: Support Field */
> +#define OSC_CXL_PORT_REG_ACCESS_SUPPORT		0x00000001
> +#define OSC_CXL_PORT_DEV_REG_ACCESS_SUPPORT	0x00000002
> +#define OSC_CXL_PER_SUPPORT			0x00000004
> +#define OSC_CXL_NATIVE_HP_SUPPORT		0x00000008
> +#define OSC_CXL_SUPPORT_MASKS			0x0000000f
> +
> +/* CXL Host Bridge _OSC: Capabilities DWORD 5: Control Field */
> +#define OSC_CXL_MEM_PER_CONTROL			0x00000001
> +#define OSC_CXL_CONTROL_MASKS			0x00000001
> +
> +/* CXL Host Bridge _OSC: Capabilities DWORD 6: Query/Returns Field */
> +#define OSC_CXL_MEM_EXPANDER_PER_CONTROL	0x00000001
> +
>  #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
>  #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
>  #define ACPI_GSB_ACCESS_ATTRIB_BYTE		0x00000006
> @@ -581,6 +597,8 @@ extern bool osc_pc_lpi_support_confirmed;
>  #define ACPI_GSB_ACCESS_ATTRIB_RAW_BYTES	0x0000000E
>  #define ACPI_GSB_ACCESS_ATTRIB_RAW_PROCESS	0x0000000F
>  
> +extern acpi_status acpi_cxl_osc_control_set(acpi_handle handle,
> +					     u32 *mask, u32 req);

No need for this to be extern, right?  (I just sent a patch to make
acpi_pci_osc_control_set() static also.)

>  extern acpi_status acpi_pci_osc_control_set(acpi_handle handle,
>  					     u32 *mask, u32 req);
>  
> -- 
> 2.27.0
> 
