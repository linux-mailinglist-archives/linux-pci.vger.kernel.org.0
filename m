Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E0D690B61
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 15:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjBIOK2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 09:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbjBIOK0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 09:10:26 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2CEC5D1FB;
        Thu,  9 Feb 2023 06:10:25 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCJd54jmhz6J9Sj;
        Thu,  9 Feb 2023 22:08:57 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 14:10:21 +0000
Date:   Thu, 9 Feb 2023 14:10:20 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 09/18] cxl: Add helper function to retrieve ACPI handle
 of CXL root device
Message-ID: <20230209141020.00004831@Huawei.com>
In-Reply-To: <167571664152.587790.608196538260467034.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571664152.587790.608196538260467034.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 06 Feb 2023 13:50:42 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Provide a helper to find the ACPI0017 device in order to issue the _DSM.
> The helper will take the 'struct device' from a cxl_port and iterate until
> the root device is reached. The ACPI handle will be returned from the root
> device.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/acpi.c |   30 ++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    1 +
>  2 files changed, 31 insertions(+)
> 
> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
> index 86dc6c9c1f24..05fcd4751619 100644
> --- a/drivers/cxl/core/acpi.c
> +++ b/drivers/cxl/core/acpi.c
> @@ -5,6 +5,7 @@
>  #include <linux/kernel.h>
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
> +#include <linux/platform_device.h>
>  #include <asm/div64.h>
>  #include "cxlpci.h"
>  #include "cxl.h"
> @@ -13,6 +14,35 @@ const guid_t acpi_cxl_qtg_id_guid =
>  	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
>  		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
>  
> +/**
> + * cxl_acpi_get_root_acpi_handle - get the ACPI handle of the CXL root device
> + * @dev: 'struct device' to start searching from. Should be from cxl_port->dev.
> + * Looks for the ACPI0017 device and return the ACPI handle
> + **/

Inconsistent comment style.

> +acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev)
> +{
> +	struct device *itr = dev, *root_dev;

Not nice for readability to have an assignment in a list of definitions
all on the same line.

> +	acpi_handle handle;
> +
> +	if (!dev)
> +		return ERR_PTR(-EINVAL);
> +
> +	while (itr->parent) {
> +		root_dev = itr;
> +		itr = itr->parent;
> +	}
> +
> +	if (!dev_is_platform(root_dev))
> +		return ERR_PTR(-ENODEV);
> +
> +	handle = ACPI_HANDLE(root_dev);
> +	if (!handle)
> +		return ERR_PTR(-ENODEV);
> +
> +	return handle;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_acpi_get_rootdev_handle, CXL);
> +
>  /**
>   * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
>   * @handle: ACPI handle
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index e70df07f9b4b..ac6ea550ab0a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -733,6 +733,7 @@ struct qtg_dsm_output {
>  
>  struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
>  						 struct qtg_dsm_input *input);
> +acpi_handle cxl_acpi_get_rootdev_handle(struct device *dev);
>  
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
> 
> 

