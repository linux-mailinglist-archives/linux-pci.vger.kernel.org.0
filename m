Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 910DF5535BC
	for <lists+linux-pci@lfdr.de>; Tue, 21 Jun 2022 17:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351477AbiFUPQj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 11:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351693AbiFUPQh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 11:16:37 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42187206
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 08:16:36 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id f16so11989356pjj.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Jun 2022 08:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=utQUa+oF9fWRDaamZZaPnhYaPJL6WgW8Mf9WbzgxH3I=;
        b=mVwRJ+OHn3pHTr7BcfAsDudznGjmNVWCdAAW5BiPqut1VfsBM1G9xlrrf5JBTLaiWY
         B9SBmZDnUQzEW6LWc3VhRxYVXOcE/Wb3DBLwpT//TvBcVT16IcE2yaF9L5G4gnFH13Hs
         QV11RmR2nJ9fX82P9091/AfdZKWrdMx1pR4tzRhh50vT4uXW9Z7YmQi1Gdh45Ppb7z3D
         PefaCEAlIJ6rQIaV6ATrrX+W00vtzLwuDV/WLAxaYdERVBF18vek019AG1fPM0k+derJ
         KKEvJyO91J/upkSo5zr/BhmLqeGRkpbrCjwgZEysmfutg35i497XY+uADaEM/UPJda1y
         7Yow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=utQUa+oF9fWRDaamZZaPnhYaPJL6WgW8Mf9WbzgxH3I=;
        b=eqDe5Ho55lpL+EnU3vOIx/f7/phsQYe5b+3GYvSA7uBDbZ8IcFEIpYz5wfgwNwA4cs
         pHOAGfQP9pR7OesJu4uGribeTfVqdDq9uYTI+ggp8Dp+MrdrNCXGcnHIdFlChkoxTQ6k
         GczhKwPoY5kFLtTXce8jrr+3AgV3inbCq1LirH5diqBdrxFLVYvBhfsV9nqDENEQ/RKi
         mPGc5LWg3O3LcChbdzFqKFit6js6/WDKgISsKg4Z/kZ80jeZBGPLKbLKYmQy9le1Ksaa
         r30dExi+W7agoVJbr8Q6ZtbOHbQi4XmM9M16bBgVGv5nfu1nybiGlybxF5WbV7dXWkRa
         zffQ==
X-Gm-Message-State: AJIora8KaBYXjjoFsV8n0RYkzNdvbpZbM2myQGsueInqf1weXwK/j5qN
        0rihBZfTTGYwu1+AGkxFxL1X
X-Google-Smtp-Source: AGRyM1u3X+1HZeOndQv31glaYp1I/VYCqt3Ev7SKHvEavA7rUIWAe7snUi+5/aQnqFlJu5f/kj4tuw==
X-Received: by 2002:a17:902:f78b:b0:16a:4ad:f359 with SMTP id q11-20020a170902f78b00b0016a04adf359mr22896128pln.99.1655824595664;
        Tue, 21 Jun 2022 08:16:35 -0700 (PDT)
Received: from thinkpad ([117.193.212.116])
        by smtp.gmail.com with ESMTPSA id h3-20020a170902680300b001651562eb16sm10909798plk.124.2022.06.21.08.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 08:16:35 -0700 (PDT)
Date:   Tue, 21 Jun 2022 20:46:26 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Lizhi Hou <lizhi.hou@xilinx.com>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        robh@kernel.org, yilun.xu@intel.com, maxz@xilinx.com,
        sonal.santan@xilinx.com, yliu@xilinx.com, michal.simek@xilinx.com,
        stefanos@xilinx.com, trix@redhat.com, mdf@kernel.org,
        dwmw2@infradead.org, linux-kernel@vger.kernel.org,
        Max Zhen <max.zhen@xilinx.com>, kishon@ti.com
Subject: Re: [PATCH V1 RESEND 3/4] fpga: xrt: management physical function
 driver
Message-ID: <20220621151626.GA32306@thinkpad>
References: <20220305052304.726050-1-lizhi.hou@xilinx.com>
 <20220305052304.726050-4-lizhi.hou@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220305052304.726050-4-lizhi.hou@xilinx.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

+ Kishon

On Fri, Mar 04, 2022 at 09:23:03PM -0800, Lizhi Hou wrote:
> The PCIe device driver which attaches to management function on Alveo
> devices. The first version of this driver demonstrates calling PCIe
> interface to create device tree node.
> 

I'm assuming that this driver implements the PCI endpoint functions. Then this
driver should be under drivers/pci/endpoint/functions/ making use of the
existing PCI endpoint subsystem.

Thanks,
Mani

> Signed-off-by: Sonal Santan <sonal.santan@xilinx.com>
> Signed-off-by: Max Zhen <max.zhen@xilinx.com>
> Signed-off-by: Lizhi Hou <lizhi.hou@xilinx.com>
> ---
>  drivers/fpga/Kconfig              |  3 ++
>  drivers/fpga/Makefile             |  3 ++
>  drivers/fpga/xrt/Kconfig          | 24 ++++++++++++
>  drivers/fpga/xrt/Makefile         |  8 ++++
>  drivers/fpga/xrt/mgmt/Makefile    | 12 ++++++
>  drivers/fpga/xrt/mgmt/xmgmt-drv.c | 63 +++++++++++++++++++++++++++++++
>  6 files changed, 113 insertions(+)
>  create mode 100644 drivers/fpga/xrt/Kconfig
>  create mode 100644 drivers/fpga/xrt/Makefile
>  create mode 100644 drivers/fpga/xrt/mgmt/Makefile
>  create mode 100644 drivers/fpga/xrt/mgmt/xmgmt-drv.c
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 991b3f361ec9..93ae387c97c5 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -243,4 +243,7 @@ config FPGA_MGR_VERSAL_FPGA
>  	  configure the programmable logic(PL).
>  
>  	  To compile this as a module, choose M here.
> +
> +source "drivers/fpga/xrt/Kconfig"
> +
>  endif # FPGA
> diff --git a/drivers/fpga/Makefile b/drivers/fpga/Makefile
> index 0bff783d1b61..81ea43c40c64 100644
> --- a/drivers/fpga/Makefile
> +++ b/drivers/fpga/Makefile
> @@ -49,3 +49,6 @@ obj-$(CONFIG_FPGA_DFL_NIOS_INTEL_PAC_N3000)	+= dfl-n3000-nios.o
>  
>  # Drivers for FPGAs which implement DFL
>  obj-$(CONFIG_FPGA_DFL_PCI)		+= dfl-pci.o
> +
> +# XRT drivers for Xilinx Alveo platforms
> +obj-$(CONFIG_FPGA_XRT)		+= xrt/
> diff --git a/drivers/fpga/xrt/Kconfig b/drivers/fpga/xrt/Kconfig
> new file mode 100644
> index 000000000000..47efc8f71cec
> --- /dev/null
> +++ b/drivers/fpga/xrt/Kconfig
> @@ -0,0 +1,24 @@
> +
> +# XRT Alveo FPGA device configuration
> +#
> +
> +config FPGA_XRT
> +	tristate "XRT Alveo Drivers"
> +	depends on OF
> +	select OF_EMPTY_ROOT
> +	select OF_OVERLAY
> +	help
> +	  Select this option to enable Xilinx XRT Alveo drivers. Xilinx Alveo
> +	  card is PCIe device and has two PCIe functions. The first function
> +	  performs board manangement and XRT management driver will be attached
> +	  to it. The second function performs data movement, compute unit
> +	  scheduling etc. And an XRT user driver will be attached to it.
> +
> +config FPGA_XRT_XMGMT
> +	tristate "Xilinx Alveo Management Driver"
> +	depends on FPGA_XRT
> +	help
> +	  Select this option to enable XRT PCIe driver for Xilinx Alveo FPGA.
> +	  This driver provides interfaces for userspace application to access
> +	  Alveo FPGA device, such as: downloading FPGA bitstream, query card
> +	  information, hot reset card etc.
> diff --git a/drivers/fpga/xrt/Makefile b/drivers/fpga/xrt/Makefile
> new file mode 100644
> index 000000000000..2d251b5653bb
> --- /dev/null
> +++ b/drivers/fpga/xrt/Makefile
> @@ -0,0 +1,8 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
> +#
> +# Authors: Lizhi.Hou@xilinx.com
> +#
> +
> +obj-$(CONFIG_FPGA_XRT_XMGMT) += mgmt/
> diff --git a/drivers/fpga/xrt/mgmt/Makefile b/drivers/fpga/xrt/mgmt/Makefile
> new file mode 100644
> index 000000000000..b893c7293d70
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/Makefile
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Copyright (C) 2020-2022 Xilinx, Inc. All rights reserved.
> +#
> +# Authors: Sonal.Santan@xilinx.com
> +#          Lizhi.Hou@xilinx.com
> +#
> +
> +obj-$(CONFIG_FPGA_XRT_XMGMT) += xrt-mgmt.o
> +
> +xrt-mgmt-objs :=		\
> +	xmgmt-drv.o
> diff --git a/drivers/fpga/xrt/mgmt/xmgmt-drv.c b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
> new file mode 100644
> index 000000000000..60742a478a43
> --- /dev/null
> +++ b/drivers/fpga/xrt/mgmt/xmgmt-drv.c
> @@ -0,0 +1,63 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Xilinx Alveo Management Function Driver
> + *
> + * Copyright (C) 2020-2022 Xilinx, Inc.
> + *
> + * Authors:
> + *     Cheng Zhen <maxz@xilinx.com>
> + *     Lizhi Hou <lizhih@xilinx.com>
> + */
> +
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/aer.h>
> +#include <linux/vmalloc.h>
> +#include <linux/delay.h>
> +#include <linux/of_pci.h>
> +
> +#define XMGMT_MODULE_NAME	"xrt-mgmt"
> +
> +/* PCI Device IDs */
> +#define PCI_DEVICE_ID_U50	0x5020
> +static const struct pci_device_id xmgmt_pci_ids[] = {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_XILINX, PCI_DEVICE_ID_U50), }, /* Alveo U50 */
> +	{ 0, }
> +};
> +
> +static int xmgmt_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	devm_of_pci_create_bus_endpoint(pdev);
> +
> +	return 0;
> +}
> +
> +static struct pci_driver xmgmt_driver = {
> +	.name = XMGMT_MODULE_NAME,
> +	.id_table = xmgmt_pci_ids,
> +	.probe = xmgmt_probe,
> +};
> +
> +static int __init xmgmt_init(void)
> +{
> +	int res;
> +
> +	res = pci_register_driver(&xmgmt_driver);
> +	if (res)
> +		return res;
> +
> +	return 0;
> +}
> +
> +static __exit void xmgmt_exit(void)
> +{
> +	pci_unregister_driver(&xmgmt_driver);
> +}
> +
> +module_init(xmgmt_init);
> +module_exit(xmgmt_exit);
> +
> +MODULE_DEVICE_TABLE(pci, xmgmt_pci_ids);
> +MODULE_AUTHOR("XRT Team <runtime@xilinx.com>");
> +MODULE_DESCRIPTION("Xilinx Alveo management function driver");
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.27.0
> 

-- 
மணிவண்ணன் சதாசிவம்
