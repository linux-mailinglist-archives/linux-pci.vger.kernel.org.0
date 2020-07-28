Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8CA82304CF
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jul 2020 09:59:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgG1H7E (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jul 2020 03:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbgG1H7D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jul 2020 03:59:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20289C061794
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 00:59:03 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c80so16374003wme.0
        for <linux-pci@vger.kernel.org>; Tue, 28 Jul 2020 00:59:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=XvzdyrAp+x7F3eELUs10pEpzk9iTwE1+D4iQltTfwX0=;
        b=mf9FNmQd1q8v4rNzkngKybgB4ZpZ0H2V5vyJztQCBqIDKZeeizYKswHQ+XnKbrRJCE
         ItzZe5y15XQKyEqvf9U5KjOsZPXUaM3RMglhY8vG8hHkTB0+1wctMwUL09qykdCDdVpw
         hBLac3Dlrh/QkiCJHZlVWdX8ud6sE+WuhgoBu1nT4cyw0FCinKreKLxl4iqs0tNSNcL6
         Kf5TAIWAg8+gBQfncGHlb506+IWw+FRLkriguzKNIXNQmOlsh/AEIGRHCKdtkhfqY3U0
         /k/lh13mLO8bBSLuM3O+Ud2kVSYXXV1GDW5qrHBl1R72aIcOxoGUfJ7WiZWNZE/Um0Dx
         0v7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=XvzdyrAp+x7F3eELUs10pEpzk9iTwE1+D4iQltTfwX0=;
        b=UH88CIk4Kmg5LzLoMQJwbqANZt+SBbYYTCgcOZC9K/BhXmHQkPVp4S4Du2GnMrc0cY
         AUOUMBKzCVYBtQfR9KgxUmfTt3f+A07D3osOOH/TYrQwoWL6RfJfhZvacgH9UH68fzBW
         6t1IgXYnKUa0YHWLOrZCFOY+uBTd9gT4kuWEUmhMLf+p+PPDDK4OZWOl1Jkut4gPTgUn
         LY9qA12zEk2cYqTR1B4qjcAWmcxUAbinodv8e+tnSYcxOtnRIH1BmkVccXcG/V0jj5MX
         O3B36SZbWvADyGfHR6B2YQExdo7ayppt41Dwp/4qsga6jVtgVzCfDX4yYqOFlOASVjVd
         +87g==
X-Gm-Message-State: AOAM533JFWQtHNZq6cLBYyTfs691f6T+MMobp7eEBqteCpEwBaeif5ka
        WSw8Gjt+vLwry3j0RuzJsY0ulg==
X-Google-Smtp-Source: ABdhPJxNM9FngXrj+ydayrPeJjZVYwN8NF/LQE/dM5w4mzrIhPbgMrRHl66Negt1WT27AehVRFXCFw==
X-Received: by 2002:a1c:7f91:: with SMTP id a139mr2675522wmd.153.1595923141639;
        Tue, 28 Jul 2020 00:59:01 -0700 (PDT)
Received: from dell ([2.27.167.73])
        by smtp.gmail.com with ESMTPSA id m14sm7375016wrx.76.2020.07.28.00.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 00:59:00 -0700 (PDT)
Date:   Tue, 28 Jul 2020 08:58:59 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     dvhart@infradead.org, andy@infradead.org, bhelgaas@google.com,
        alexander.h.duyck@linux.intel.com, linux-kernel@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-pci@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH V4 2/3] mfd: Intel Platform Monitoring Technology support
Message-ID: <20200728075859.GH1850026@dell>
References: <20200714062323.19990-1-david.e.box@linux.intel.com>
 <20200717190620.29821-3-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200717190620.29821-3-david.e.box@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 17 Jul 2020, David E. Box wrote:

> Intel Platform Monitoring Technology (PMT) is an architecture for
> enumerating and accessing hardware monitoring facilities. PMT supports
> multiple types of monitoring capabilities. This driver creates platform
> devices for each type so that they may be managed by capability specific
> drivers (to be introduced). Capabilities are discovered using PCIe DVSEC
> ids. Support is included for the 3 current capability types, Telemetry,
> Watcher, and Crashlog. The features are available on new Intel platforms
> starting from Tiger Lake for which support is added.
> 
> Also add a quirk mechanism for several early hardware differences and bugs.
> For Tiger Lake, do not support Watcher and Crashlog capabilities since they
> will not be compatible with future product. Also, fix use a quirk to fix
> the discovery table offset.
> 
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Co-developed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>

This should be in chronological order.

> ---
>  MAINTAINERS             |   5 +
>  drivers/mfd/Kconfig     |  10 ++
>  drivers/mfd/Makefile    |   1 +
>  drivers/mfd/intel_pmt.c | 215 ++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 231 insertions(+)
>  create mode 100644 drivers/mfd/intel_pmt.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index b4a43a9e7fbc..2e42bf0c41ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8845,6 +8845,11 @@ F:	drivers/mfd/intel_soc_pmic*
>  F:	include/linux/mfd/intel_msic.h
>  F:	include/linux/mfd/intel_soc_pmic*
>  
> +INTEL PMT DRIVER
> +M:	"David E. Box" <david.e.box@linux.intel.com>
> +S:	Maintained
> +F:	drivers/mfd/intel_pmt.c
> +
>  INTEL PRO/WIRELESS 2100, 2200BG, 2915ABG NETWORK CONNECTION SUPPORT
>  M:	Stanislav Yakovlev <stas.yakovlev@gmail.com>
>  L:	linux-wireless@vger.kernel.org
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index a37d7d171382..1a62ce2c68d9 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -670,6 +670,16 @@ config MFD_INTEL_PMC_BXT
>  	  Register and P-unit access. In addition this creates devices
>  	  for iTCO watchdog and telemetry that are part of the PMC.
>  
> +config MFD_INTEL_PMT
> +	tristate "Intel Platform Monitoring Technology support"

Nit: "Intel Platform Monitoring Technology (PMT) support"

> +	depends on PCI
> +	select MFD_CORE
> +	help
> +	  The Intel Platform Monitoring Technology (PMT) is an interface that
> +	  provides access to hardware monitor registers. This driver supports
> +	  Telemetry, Watcher, and Crashlog PMT capabilities/devices for
> +	  platforms starting from Tiger Lake.
> +
>  config MFD_IPAQ_MICRO
>  	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>  	depends on SA1100_H3100 || SA1100_H3600
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 9367a92f795a..1961b4737985 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -216,6 +216,7 @@ obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
>  obj-$(CONFIG_MFD_INTEL_MSIC)	+= intel_msic.o
>  obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
> +obj-$(CONFIG_MFD_INTEL_PMT)	+= intel_pmt.o
>  obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
>  obj-$(CONFIG_MFD_VIPERBOARD)    += viperboard.o
>  obj-$(CONFIG_MFD_RC5T583)	+= rc5t583.o rc5t583-irq.o
> diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
> new file mode 100644
> index 000000000000..6857eaf4ff86
> --- /dev/null
> +++ b/drivers/mfd/intel_pmt.c
> @@ -0,0 +1,215 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Platform Monitoring Technology MFD driver

s/MFD/(PMT)/

> + * Copyright (c) 2020, Intel Corporation.
> + * All Rights Reserved.
> + *
> + * Authors: David E. Box <david.e.box@linux.intel.com>

Looks odd to use a plural for a single author.

> + */
> +
> +#include <linux/bits.h>
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/platform_device.h>
> +#include <linux/pm.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/mfd/core.h>
> +#include <linux/types.h>

Alphabetical please.

> +/* Intel DVSEC capability vendor space offsets */
> +#define INTEL_DVSEC_ENTRIES		0xA
> +#define INTEL_DVSEC_SIZE		0xB
> +#define INTEL_DVSEC_TABLE		0xC
> +#define INTEL_DVSEC_TABLE_BAR(x)	((x) & GENMASK(2, 0))
> +#define INTEL_DVSEC_TABLE_OFFSET(x)	((x) & GENMASK(31, 3))
> +#define INTEL_DVSEC_ENTRY_SIZE		4
> +
> +/* PMT capabilities */
> +#define DVSEC_INTEL_ID_TELEMETRY	2
> +#define DVSEC_INTEL_ID_WATCHER		3
> +#define DVSEC_INTEL_ID_CRASHLOG		4
> +
> +#define TELEMETRY_DEV_NAME		"pmt_telemetry"
> +#define WATCHER_DEV_NAME		"pmt_watcher"
> +#define CRASHLOG_DEV_NAME		"pmt_crashlog"

Please don't define names of things.  It makes grepping a pain, at the
very least.  Just use the 'raw' string in-place.

> +struct intel_dvsec_header {
> +	u16	length;
> +	u16	id;
> +	u8	num_entries;
> +	u8	entry_size;
> +	u8	tbir;
> +	u32	offset;
> +};
> +
> +enum pmt_quirks {
> +	/* Watcher capability not supported */
> +	PMT_QUIRK_NO_WATCHER	= BIT(0),
> +
> +	/* Crashlog capability not supported */
> +	PMT_QUIRK_NO_CRASHLOG	= BIT(1),
> +
> +	/* Use shift instead of mask to read discovery table offset */
> +	PMT_QUIRK_TABLE_SHIFT	= BIT(2),
> +};
> +
> +struct pmt_platform_info {
> +	unsigned long quirks;
> +};
> +
> +static const struct pmt_platform_info tgl_info = {
> +	.quirks = PMT_QUIRK_NO_WATCHER | PMT_QUIRK_NO_CRASHLOG |
> +		  PMT_QUIRK_TABLE_SHIFT,
> +};
> +
> +static int
> +pmt_add_dev(struct pci_dev *pdev, struct intel_dvsec_header *header,
> +	    struct pmt_platform_info *info)

My personal preference is to a) only break when you have to and b) to
align with the '('.  Perhaps point b) is satisfied and it's just the
patch format that's shifting the tab though?

> +{
> +	struct device *dev = &pdev->dev;
> +	struct resource *res, *tmp;
> +	struct mfd_cell *cell;
> +	const char *name;
> +	int count = header->num_entries;
> +	int size = header->entry_size;
> +	int i;
> +
> +	switch (header->id) {
> +	case DVSEC_INTEL_ID_TELEMETRY:
> +		name = TELEMETRY_DEV_NAME;
> +		break;
> +	case DVSEC_INTEL_ID_WATCHER:
> +		if (info->quirks & PMT_QUIRK_NO_WATCHER) {
> +			dev_info(dev, "Watcher not supported\n");
> +			return 0;
> +		}
> +		name = WATCHER_DEV_NAME;
> +		break;
> +	case DVSEC_INTEL_ID_CRASHLOG:
> +		if (info->quirks & PMT_QUIRK_NO_CRASHLOG) {
> +			dev_info(dev, "Crashlog not supported\n");
> +			return 0;
> +		}
> +		name = CRASHLOG_DEV_NAME;
> +		break;
> +	default:
> +		return -EINVAL;

Doesn't deserve an error message?

> +	}
> +
> +	if (!header->num_entries || !header->entry_size) {
> +		dev_warn(dev, "Invalid count or size for %s header\n", name);
> +		return -EINVAL;

If you're returning an error, this should be dev_err().

Even if you only handle it as a warning at the call site.

> +	}
> +
> +	cell = devm_kzalloc(dev, sizeof(*cell), GFP_KERNEL);
> +	if (!cell)
> +		return -ENOMEM;
> +
> +	res = devm_kcalloc(dev, count, sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	if (info->quirks & PMT_QUIRK_TABLE_SHIFT)
> +		header->offset >>= 3;
> +
> +	for (i = 0, tmp = res; i < count; i++, tmp++) {
> +		tmp->start = pdev->resource[header->tbir].start +
> +			     header->offset + i * (size << 2);

Deserves a comment I think.

> +		tmp->end = tmp->start + (size << 2) - 1;
> +		tmp->flags = IORESOURCE_MEM;
> +	}
> +
> +	cell->resources = res;
> +	cell->num_resources = count;
> +	cell->name = name;
> +
> +	return devm_mfd_add_devices(dev, PLATFORM_DEVID_AUTO, cell, 1, NULL, 0,
> +				    NULL);
> +}
> +
> +static int
> +pmt_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct intel_dvsec_header header;
> +	struct pmt_platform_info *info;
> +	bool found_devices = false;
> +	int ret, pos = 0;
> +	u32 table;
> +	u16 vid;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	info = devm_kmemdup(&pdev->dev, (void *)id->driver_data, sizeof(*info),
> +			    GFP_KERNEL);
> +	if (!info)
> +		return -ENOMEM;
> +
> +	pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
> +	while (pos) {

If you do:

	do {
		int pos;

		pos = pci_find_next_ext_capability(pdev, pos, PCI_EXT_CAP_ID_DVSEC);
		if (!pos)
			break;

Then you can invoke pci_find_next_ext_capability() once, no?

> +		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vid);
> +		if (vid != PCI_VENDOR_ID_INTEL)
> +			continue;
> +
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2,
> +				     &header.id);
> +		pci_read_config_byte(pdev, pos + INTEL_DVSEC_ENTRIES,
> +				     &header.num_entries);
> +		pci_read_config_byte(pdev, pos + INTEL_DVSEC_SIZE,
> +				     &header.entry_size);
> +		pci_read_config_dword(pdev, pos + INTEL_DVSEC_TABLE,
> +				      &table);
> +
> +		header.tbir = INTEL_DVSEC_TABLE_BAR(table);
> +		header.offset = INTEL_DVSEC_TABLE_OFFSET(table);
> +
> +		ret = pmt_add_dev(pdev, &header, info);
> +		if (ret)
> +			dev_warn(&pdev->dev,
> +				 "Failed to add devices for DVSEC id %d\n",

"device", so not all devices, right?

> +				 header.id);

Don't you want to continue here?

Else you're going to set found_devices for a failed device.

> +		found_devices = true;
> +
> +		pos = pci_find_next_ext_capability(pdev, pos,
> +						   PCI_EXT_CAP_ID_DVSEC);
> +	}
> +
> +	if (!found_devices) {
> +		dev_err(&pdev->dev, "No supported PMT capabilities found.\n");
> +		return -ENODEV;
> +	}
> +
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_allow(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static void pmt_pci_remove(struct pci_dev *pdev)
> +{
> +	pm_runtime_forbid(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +}
> +
> +#define PCI_DEVICE_ID_INTEL_PMT_TGL	0x9a0d

What's this for?

If this is PCI_DEVICE_DATA magic, it would be worth tying it to the
struct i.e. remove the empty line between it and the table below.

> +static const struct pci_device_id pmt_pci_ids[] = {
> +	{ PCI_DEVICE_DATA(INTEL, PMT_TGL, &tgl_info) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, pmt_pci_ids);
> +
> +static struct pci_driver pmt_pci_driver = {
> +	.name = "intel-pmt",
> +	.id_table = pmt_pci_ids,
> +	.probe = pmt_pci_probe,
> +	.remove = pmt_pci_remove,
> +};
> +module_pci_driver(pmt_pci_driver);
> +
> +MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
> +MODULE_DESCRIPTION("Intel Platform Monitoring Technology MFD driver");

s/MFD/(PMT)/

> +MODULE_LICENSE("GPL v2");

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
