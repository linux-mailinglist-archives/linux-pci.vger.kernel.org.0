Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F373B80BE
	for <lists+linux-pci@lfdr.de>; Wed, 30 Jun 2021 12:17:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhF3KTy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Jun 2021 06:19:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234079AbhF3KTx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Jun 2021 06:19:53 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B5ECC061766
        for <linux-pci@vger.kernel.org>; Wed, 30 Jun 2021 03:17:24 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u11so2897097wrw.11
        for <linux-pci@vger.kernel.org>; Wed, 30 Jun 2021 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=8nIzMejevNlcayC5ysEAr8LTPQnvQ1k4Qis/Zmzckfs=;
        b=AMTJyNglTori0IxVNpucKG+59a7Jt+/Au26IZkPquBgEfc7jBsmIimc5Az4UWR6Seh
         1pHxNefyU5KyQtM2bS4AhwrXu8JD1Bboj2jvRsXTnbbDVBbd/fpFOeQ3ZLG8J6dBRI1g
         EjpuLlJ4dWElA8vwZRaHuU/D4ZzKfVXC7MPpEI8ER/7CJPMFg3cGZ02zMdwxW/3jedgf
         gymz8FSTJYY/4t2t8mHuYJ6wOzgyPkr3Uji0sJG/Pyky95qd+wIZIR8bZamp07VJMoqa
         J+nOBdym/Hypdk8DH4F2+WM95MhEnFSf7fUJEQLUCG8NRuW/9vVKR5BBWtkICo/HriP+
         Rx7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=8nIzMejevNlcayC5ysEAr8LTPQnvQ1k4Qis/Zmzckfs=;
        b=c3ls/gjZFMo/+13R0ZDgNLuRda5fbNh4JjrhhVLfTkPN8c4iWJ/awp7YKd0BZKdr7w
         63LriHTp2lYrxWWoxESldFKLSckWBME4CfMiRWDQLbvx6CDrqQp8gmt0GDnJVM7g1xyy
         L+DP0YPbDb+jeDgQbrxSl/w12OmWuNuXg73b5sXOzEHYmh+b6KAhjmhUviQEF6wqnjEc
         QyJ73VXDD6PN5Lm/XVINsJztLbmA94+7etIOPP58HcTaOEWnoIna7A0tohO/uaDoqIE1
         cdTMsXQa/M8oiOUm4TIdTSE0KYvcpooqDSF1fNOs0lBjzv/JJk1g1fCLXNrm/TsH39V2
         ygtA==
X-Gm-Message-State: AOAM533wXgtttzeDW1J4S7SDs7XMgjcgRTcQztp2hWnlyvOtfSQe8Jtb
        trQF5OiT7d1gBxChHNY4iTKWjw==
X-Google-Smtp-Source: ABdhPJyBy0lJW8EeksUz43z1dVZXdAyVcITFlfhSYrJrftXGur0j7mj0Ix0a5MfMwE/o+4bu5w77uA==
X-Received: by 2002:adf:f850:: with SMTP id d16mr17863257wrq.258.1625048242462;
        Wed, 30 Jun 2021 03:17:22 -0700 (PDT)
Received: from dell ([95.144.13.171])
        by smtp.gmail.com with ESMTPSA id o33sm15060349wms.32.2021.06.30.03.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 03:17:22 -0700 (PDT)
Date:   Wed, 30 Jun 2021 11:17:19 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     "David E. Box" <david.e.box@linux.intel.com>
Cc:     hdegoede@redhat.com, mgross@linux.intel.com, bhelgaas@google.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 3/4] MFD: Intel Out of Band Management Services Module
 (OOBMSM) driver
Message-ID: <YNxEr+X8GozvxNrW@dell>
References: <20210617215408.1412409-1-david.e.box@linux.intel.com>
 <20210617215408.1412409-4-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210617215408.1412409-4-david.e.box@linux.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 17 Jun 2021, David E. Box wrote:

> The Intel Out of Band Management Services Module (OOBMSM) is a device
> that provides access to Intel capabilities described in PCIE vendor
> specific extended capability registers (both VSEC and DVSEC). These
> capabilities include features like Intel Platform Monitoring Technology
> as well as others that are not supported by the intel_pmt driver. Add a
> driver for creating platform devices for these capabilities coming from
> OOBMSM.
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
>  MAINTAINERS                  |  1 +
>  drivers/mfd/Kconfig          | 11 +++++++
>  drivers/mfd/Makefile         |  1 +
>  drivers/mfd/intel_oobmsm.c   | 61 ++++++++++++++++++++++++++++++++++++
>  drivers/platform/x86/Kconfig |  4 +--
>  5 files changed, 76 insertions(+), 2 deletions(-)
>  create mode 100644 drivers/mfd/intel_oobmsm.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ebdc2a0f794b..0961e3f89497 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9356,6 +9356,7 @@ INTEL PMT DRIVER
>  M:	"David E. Box" <david.e.box@linux.intel.com>
>  S:	Maintained
>  F:	drivers/mfd/intel_extended_cap.c
> +F:	drivers/mfd/intel_oobmsm.c
>  F:	drivers/mfd/intel_pmt.c
>  F:	drivers/platform/x86/intel_pmt_*
>  
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 4dde8e223a9e..269312de2666 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -687,6 +687,17 @@ config MFD_INTEL_PMT
>  	  Telemetry, Watcher, and Crashlog PMT capabilities/devices for
>  	  platforms starting from Tiger Lake.
>  
> +config MFD_INTEL_OOBMSM
> +	tristate "Intel Out Of Band Management Services Module (OOBMSM) support"
> +	depends on PCI
> +	select MFD_INTEL_EXTENDED_CAPS
> +	help
> +	  The Intel Out of Band Management Service Module driver is used to
> +	  enumerate auxiliary platform features described in both Vendor
> +	  Specific and Designated Vendor Specific PCIe config space. Supported
> +	  features include Intel Platform Monitoring Technology (PMT) as well
> +	  as other non-PMT capabilities.
> +
>  config MFD_IPAQ_MICRO
>  	bool "Atmel Micro ASIC (iPAQ h3100/h3600/h3700) Support"
>  	depends on SA1100_H3100 || SA1100_H3600
> diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
> index 7fa35399ec76..50fa38810bbd 100644
> --- a/drivers/mfd/Makefile
> +++ b/drivers/mfd/Makefile
> @@ -213,6 +213,7 @@ obj-$(CONFIG_MFD_INTEL_EXTENDED_CAPS)	+= intel_extended_caps.o
>  obj-$(CONFIG_MFD_INTEL_LPSS)	+= intel-lpss.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_PCI)	+= intel-lpss-pci.o
>  obj-$(CONFIG_MFD_INTEL_LPSS_ACPI)	+= intel-lpss-acpi.o
> +obj-$(CONFIG_MFD_INTEL_OOBMSM)	+= intel_oobmsm.o
>  obj-$(CONFIG_MFD_INTEL_PMC_BXT)	+= intel_pmc_bxt.o
>  obj-$(CONFIG_MFD_INTEL_PMT)	+= intel_pmt.o
>  obj-$(CONFIG_MFD_PALMAS)	+= palmas.o
> diff --git a/drivers/mfd/intel_oobmsm.c b/drivers/mfd/intel_oobmsm.c
> new file mode 100644
> index 000000000000..c66532f11c29
> --- /dev/null
> +++ b/drivers/mfd/intel_oobmsm.c
> @@ -0,0 +1,61 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Intel Out of Band Management Services Module driver
> + *
> + * Copyright (c) 2021, Intel Corporation.
> + * All Rights Reserved.
> + *
> + * Author: David E. Box <david.e.box@linux.intel.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/pm_runtime.h>

This doesn't appear to have anything to do with MFD?

> +#include "intel_extended_caps.h"
> +
> +static int intel_oobmsm_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct intel_ext_cap_platform_info *info;
> +	int ret;
> +
> +	ret = pcim_enable_device(pdev);
> +	if (ret)
> +		return ret;
> +
> +	info = (struct intel_ext_cap_platform_info *)id->driver_data;
> +
> +	ret = intel_ext_cap_probe(pdev, info);
> +	if (ret)
> +		return ret;
> +
> +	pm_runtime_put(&pdev->dev);
> +	pm_runtime_allow(&pdev->dev);
> +
> +	return 0;
> +}
> +
> +static void intel_oobmsm_pci_remove(struct pci_dev *pdev)
> +{
> +	pm_runtime_forbid(&pdev->dev);
> +	pm_runtime_get_sync(&pdev->dev);
> +}
> +
> +#define PCI_DEVICE_ID_INTEL_PMT_OOBMSM	0x09a7
> +static const struct pci_device_id intel_oobmsm_pci_ids[] = {
> +	{ PCI_DEVICE_DATA(INTEL, PMT_OOBMSM, NULL) },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(pci, intel_oobmsm_pci_ids);
> +
> +static struct pci_driver intel_oobmsm_pci_driver = {
> +	.name = "intel-oobmsm",
> +	.id_table = intel_oobmsm_pci_ids,
> +	.probe = intel_oobmsm_pci_probe,
> +	.remove = intel_oobmsm_pci_remove,
> +};
> +module_pci_driver(intel_oobmsm_pci_driver);
> +
> +MODULE_AUTHOR("David E. Box <david.e.box@linux.intel.com>");
> +MODULE_DESCRIPTION("Intel Out of Band Management Services Module driver");
> +MODULE_LICENSE("GPL v2");
> diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
> index 60592fb88e7a..4dd3af9f848e 100644
> --- a/drivers/platform/x86/Kconfig
> +++ b/drivers/platform/x86/Kconfig
> @@ -1226,7 +1226,7 @@ config INTEL_PMT_CLASS
>  
>  config INTEL_PMT_TELEMETRY
>  	tristate "Intel Platform Monitoring Technology (PMT) Telemetry driver"
> -	depends on MFD_INTEL_PMT
> +	depends on MFD_INTEL_PMT || MFD_INTEL_OOBMSM
>  	select INTEL_PMT_CLASS
>  	help
>  	  The Intel Platform Monitory Technology (PMT) Telemetry driver provides
> @@ -1238,7 +1238,7 @@ config INTEL_PMT_TELEMETRY
>  
>  config INTEL_PMT_CRASHLOG
>  	tristate "Intel Platform Monitoring Technology (PMT) Crashlog driver"
> -	depends on MFD_INTEL_PMT
> +	depends on MFD_INTEL_PMT || MFD_INTEL_OOBMSM
>  	select INTEL_PMT_CLASS
>  	help
>  	  The Intel Platform Monitoring Technology (PMT) crashlog driver provides

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
