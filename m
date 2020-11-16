Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1E142B4EB9
	for <lists+linux-pci@lfdr.de>; Mon, 16 Nov 2020 19:02:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730910AbgKPR7V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 16 Nov 2020 12:59:21 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2107 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731742AbgKPR7V (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 16 Nov 2020 12:59:21 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4CZcGz2Wssz67Ckl;
        Tue, 17 Nov 2020 01:57:31 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Mon, 16 Nov 2020 18:59:18 +0100
Received: from localhost (10.52.125.36) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1913.5; Mon, 16 Nov
 2020 17:59:17 +0000
Date:   Mon, 16 Nov 2020 17:59:09 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 2/9] cxl/acpi: add OSC support
Message-ID: <20201116175909.00007e53@Huawei.com>
In-Reply-To: <20201111054356.793390-3-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
        <20201111054356.793390-3-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.52.125.36]
X-ClientProxiedBy: lhreml702-chm.china.huawei.com (10.201.108.51) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Nov 2020 21:43:49 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> From: Vishal Verma <vishal.l.verma@intel.com>
> 
> Add support to advertise OS capabilities, and request OS control for CXL
> features using the ACPI _OSC mechanism. Advertise support for all
> possible CXL features, and attempt to request control too for all
> possible features.
> 
> Based on a patch by Sean Kelley.
> 
> Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

I guess unsurprisingly a lot of this is cut and paste from PCIe
so can we share some of the code?

Thanks,

Jonathan

> 
> ---
> 
> This uses a non-standard UUID for CXL and is meant as a change proposal
> to the CXL specification. The definition for _OSC intermixes PCIe and
> CXL Dwords, which makes a clean separation of CXL capabilities
> difficult, if not impossible. This is therefore subject to change.
> 
> ---
>  drivers/cxl/acpi.c | 210 ++++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/acpi.h |  18 ++++
>  2 files changed, 226 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 26e4f73838a7..c3e2f7f6ea02 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -12,6 +12,16 @@
>  #include <linux/pci.h>
>  #include "acpi.h"
>  
> +/*
> + * TODO: These are global for now to save the OSC state.
> + * This works if OSC can be expected to be uniform for every ACPI0016 object.
> + * If that is not the case, revisit this. These need to be saved because
> + * relinquishing control of a previously granted capability is disallowed.
> + */
> +static u32 cxl_osc_support_set;
> +static u32 cxl_osc_control_set;
> +static DEFINE_MUTEX(acpi_desc_lock);
> +
>  static void acpi_cxl_desc_init(struct acpi_cxl_desc *acpi_desc, struct device *dev)
>  {
>  	dev_set_drvdata(dev, acpi_desc);
> @@ -74,6 +84,199 @@ static struct acpi_driver acpi_cxl_driver = {
>  	},
>  };
>  
> +struct pci_osc_bit_struct {
> +	u32 bit;
> +	char *desc;
> +};
> +
> +static struct pci_osc_bit_struct cxl_osc_support_bit[] = {
> +	{ CXL_OSC_PORT_REG_ACCESS_SUPPORT, "CXLPortRegAccess" },
> +	{ CXL_OSC_PORT_DEV_REG_ACCESS_SUPPORT, "CXLPortDevRegAccess" },
> +	{ CXL_OSC_PER_SUPPORT, "CXLProtocolErrorReporting" },
> +	{ CXL_OSC_NATIVE_HP_SUPPORT, "CXLNativeHotPlug" },
> +};
> +
> +static struct pci_osc_bit_struct cxl_osc_control_bit[] = {
> +	{ CXL_OSC_MEM_ERROR_CONTROL, "CXLMemErrorReporting" },
> +};
> +
> +/*
> + * CXL 2.0 spec UUID - unusable as it PCI and CXL OSC are mixed
> + * static u8 cxl_osc_uuid_str[] = "68F2D50B-C469-4d8A-BD3D-941A103FD3FC";
> + */
> +/* New, proposed UUID for CXL-only OSC */
> +static u8 cxl_osc_uuid_str[] = "A4D1629D-FF52-4888-BE96-E5CADE548DB1";
> +
> +static void decode_osc_bits(struct device *dev, char *msg, u32 word,
> +			    struct pci_osc_bit_struct *table, int size)
> +{
> +	char buf[80];
> +	int i, len = 0;
> +	struct pci_osc_bit_struct *entry;
> +
> +	buf[0] = '\0';
> +	for (i = 0, entry = table; i < size; i++, entry++)
> +		if (word & entry->bit)
> +			len += scnprintf(buf + len, sizeof(buf) - len, "%s%s",
> +					len ? " " : "", entry->desc);
> +
> +	dev_info(dev, "_OSC: %s [%s]\n", msg, buf);

Can we look at sharing code with PCI?

> +}
> +
> +static void decode_cxl_osc_support(struct device *dev, char *msg, u32 word)
> +{
> +	decode_osc_bits(dev, msg, word, cxl_osc_support_bit,
> +			ARRAY_SIZE(cxl_osc_support_bit));
> +}
> +
> +static void decode_cxl_osc_control(struct device *dev, char *msg, u32 word)
> +{
> +	decode_osc_bits(dev, msg, word, cxl_osc_control_bit,
> +			ARRAY_SIZE(cxl_osc_control_bit));
> +}
> +
> +static acpi_status acpi_cap_run_osc(acpi_handle handle,
> +				    const u32 *capbuf, u8 *uuid_str, u32 *retval)
> +{
> +	struct acpi_osc_context context = {
> +		.uuid_str = uuid_str,
> +		.rev = 1,
> +		.cap.length = 20,
> +		.cap.pointer = (void *)capbuf,
> +	};
> +	acpi_status status;
> +
> +	status = acpi_run_osc(handle, &context);
> +	if (ACPI_SUCCESS(status)) {
> +		*retval = *((u32 *)(context.ret.pointer + 8));
> +		kfree(context.ret.pointer);
> +	}
> +	return status;
> +}
> +
> +static acpi_status cxl_query_osc(acpi_handle handle, u32 support, u32 *control)
> +{
> +	acpi_status status;
> +	u32 result, capbuf[5];
> +
> +	support &= CXL_OSC_SUPPORT_VALID_MASK;
> +	support |= cxl_osc_support_set;
> +
> +	capbuf[OSC_QUERY_DWORD] = OSC_QUERY_ENABLE;
> +	capbuf[CXL_OSC_SUPPORT_DWORD] = support;
> +	if (control) {
> +		*control &= CXL_OSC_CONTROL_VALID_MASK;
> +		capbuf[CXL_OSC_CONTROL_DWORD] = *control | cxl_osc_control_set;
> +	} else {
> +		/* Run _OSC query only with existing controls. */
> +		capbuf[CXL_OSC_CONTROL_DWORD] = cxl_osc_control_set;
> +	}
> +
> +	status = acpi_cap_run_osc(handle, capbuf, cxl_osc_uuid_str, &result);
> +	if (ACPI_SUCCESS(status)) {
> +		cxl_osc_support_set = support;
> +		if (control)
> +			*control = result;
> +	}
> +	return status;
> +}
> +
> +static acpi_status cxl_osc_advertise_support(acpi_handle handle, u32 flags)
> +{
> +	acpi_status status;
> +
> +	mutex_lock(&acpi_desc_lock);
> +	status = cxl_query_osc(handle, flags, NULL);
> +	mutex_unlock(&acpi_desc_lock);
> +	return status;
> +}
> +
> +/**
> + * cxl_osc_request_control - Request control of CXL root _OSC features.
> + * @adev: ACPI device for the PCI root bridge (or PCIe Root Complex).
> + * @mask: Mask of _OSC bits to request control of, place to store control mask.
> + * @req: Mask of _OSC bits the control of is essential to the caller.
> + **/
> +static acpi_status cxl_osc_request_control(struct acpi_device *adev, u32 *mask, u32 req)
> +{
> +	acpi_handle handle = adev->handle;
> +	struct device *dev = &adev->dev;
> +	acpi_status status = AE_OK;
> +	u32 ctrl, capbuf[5];
> +
> +	if (!mask)
> +		return AE_BAD_PARAMETER;
> +
> +	ctrl = *mask & CXL_OSC_MEM_ERROR_CONTROL;
> +	if ((ctrl & req) != req)
> +		return AE_TYPE;
> +
> +	mutex_lock(&acpi_desc_lock);
> +
> +	*mask = ctrl | cxl_osc_control_set;
> +	/* No need to evaluate _OSC if the control was already granted. */
> +	if ((cxl_osc_control_set & ctrl) == ctrl)
> +		goto out;
> +
> +	/* Need to check the available controls bits before requesting them. */
> +	while (*mask) {
> +		status = cxl_query_osc(handle, cxl_osc_support_set, mask);
> +		if (ACPI_FAILURE(status))
> +			goto out;
> +		if (ctrl == *mask)
> +			break;
> +		decode_cxl_osc_control(dev, "platform does not support", ctrl & ~(*mask));
> +		ctrl = *mask;
> +	}
> +
> +	if ((ctrl & req) != req) {
> +		decode_cxl_osc_control(dev, "not requesting control; platform does not support",
> +				       req & ~(ctrl));
> +		status = AE_SUPPORT;
> +		goto out;
> +	}
> +
> +	capbuf[OSC_QUERY_DWORD] = 0;
> +	capbuf[CXL_OSC_SUPPORT_DWORD] = cxl_osc_support_set;
> +	capbuf[CXL_OSC_CONTROL_DWORD] = ctrl;
> +	status = acpi_cap_run_osc(handle, capbuf, cxl_osc_uuid_str, mask);
> +	if (ACPI_SUCCESS(status))
> +		cxl_osc_control_set = *mask;
> +out:
> +	mutex_unlock(&acpi_desc_lock);
> +	return status;
> +}
> +
> +static int cxl_negotiate_osc(struct acpi_device *adev)
> +{
> +	u32 cxl_support, cxl_control, requested;
> +	acpi_handle handle = adev->handle;
> +	struct device *dev = &adev->dev;
> +	acpi_status status;
> +
> +	/* Declare support for everything */
> +	cxl_support = CXL_OSC_SUPPORT_VALID_MASK;
> +	decode_cxl_osc_support(dev, "OS supports", cxl_support);
> +	status = cxl_osc_advertise_support(handle, cxl_support);
> +	if (ACPI_FAILURE(status)) {
> +		dev_info(dev, "CXL_OSC failed (%s)\n", acpi_format_exception(status));
> +		return -ENXIO;
> +	}
> +
> +	/* Request control for everything */
> +	cxl_control = CXL_OSC_CONTROL_VALID_MASK;
> +	requested = cxl_control;
> +	status = cxl_osc_request_control(adev, &cxl_control, CXL_OSC_MEM_ERROR_CONTROL);
> +	if (ACPI_SUCCESS(status)) {
> +		decode_cxl_osc_control(dev, "OS now controls", cxl_control);
> +	} else {
> +		decode_cxl_osc_control(dev, "OS requested", requested);
> +		decode_cxl_osc_control(dev, "platform willing to grant", cxl_control);
> +		dev_info(dev, "_OSC failed (%s)\n", acpi_format_exception(status));
> +	}
> +	return 0;
> +}
> +
>  /*
>   * If/when CXL support is defined by other platform firmware the kernel
>   * will need a mechanism to select between the platform specific version
> @@ -84,6 +287,7 @@ int cxl_bus_prepared(struct pci_dev *pdev)
>  	struct acpi_device *adev;
>  	struct pci_dev *root_port;
>  	struct device *root;
> +	int rc;
>  
>  	root_port = pcie_find_root_port(pdev);
>  	if (!root_port)
> @@ -97,9 +301,11 @@ int cxl_bus_prepared(struct pci_dev *pdev)
>  	if (!adev)
>  		return -ENXIO;
>  
> -	/* TODO: OSC enabling */
> +	rc = cxl_negotiate_osc(adev);
> +	if (rc)
> +		dev_err(&pdev->dev, "Failed to negotiate OSC\n");
>  
> -	return 0;
> +	return rc;
>  }
>  EXPORT_SYMBOL_GPL(cxl_bus_prepared);
>  
> diff --git a/drivers/cxl/acpi.h b/drivers/cxl/acpi.h
> index 011505475cc6..bf8d078e1b2a 100644
> --- a/drivers/cxl/acpi.h
> +++ b/drivers/cxl/acpi.h
> @@ -10,6 +10,24 @@ struct acpi_cxl_desc {
>  	struct device *dev;
>  };
>  
> +/* Indexes into _OSC Capabilities Buffer */
> +#define CXL_OSC_SUPPORT_DWORD			1	/* DWORD 2 */
> +#define CXL_OSC_CONTROL_DWORD			2	/* DWORD 3 */
> +
> +/* CXL Host Bridge _OSC: Capabilities DWORD 2: Support Field */
> +#define CXL_OSC_PORT_REG_ACCESS_SUPPORT		0x00000001
> +#define CXL_OSC_PORT_DEV_REG_ACCESS_SUPPORT	0x00000002
> +#define CXL_OSC_PER_SUPPORT			0x00000004
> +#define CXL_OSC_NATIVE_HP_SUPPORT		0x00000008
> +#define CXL_OSC_SUPPORT_VALID_MASK		(CXL_OSC_PORT_REG_ACCESS_SUPPORT |	\
> +						 CXL_OSC_PORT_DEV_REG_ACCESS_SUPPORT |	\
> +						 CXL_OSC_PER_SUPPORT |			\
> +						 CXL_OSC_NATIVE_HP_SUPPORT)
> +
> +/* CXL Host Bridge _OSC: Capabilities DWORD 3: Control Field */
> +#define CXL_OSC_MEM_ERROR_CONTROL		0x00000001
> +#define CXL_OSC_CONTROL_VALID_MASK		(CXL_OSC_MEM_ERROR_CONTROL)
> +
>  int cxl_bus_prepared(struct pci_dev *pci_dev);
>  
>  #endif	/* __CXL_ACPI_H__ */

