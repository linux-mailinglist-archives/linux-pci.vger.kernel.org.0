Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C994E690B35
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 15:02:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbjBIOC3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 09:02:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjBIOCX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 09:02:23 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80FAD5241;
        Thu,  9 Feb 2023 06:02:21 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCJRm6R0Pz6J9hQ;
        Thu,  9 Feb 2023 22:00:52 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 14:02:18 +0000
Date:   Thu, 9 Feb 2023 14:02:17 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 08/18] cxl: Add support for _DSM Function for retrieving
 QTG ID
Message-ID: <20230209140217.00002d22@Huawei.com>
In-Reply-To: <167571663199.587790.13615282047168132392.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571663199.587790.13615282047168132392.stgit@djiang5-mobl3.local>
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

On Mon, 06 Feb 2023 13:50:33 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> CXL spec v3.0 9.17.3 CXL Root Device Specific Methods (_DSM)
> 
> Add support to retrieve QTG ID via ACPI _DSM call. The _DSM call requires
> an input of an ACPI package with 4 dwords (read latency, write latency,
> read bandwidth, write bandwidth). The call returns a package with 1 WORD
> that provides the max supported QTG ID and a package that may contain 0 or
> more WORDs as the recommended QTG IDs in the recommended order.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A few minor bits inline.

Jonathan

> ---
>  drivers/cxl/core/Makefile |    1 
>  drivers/cxl/core/acpi.c   |   99 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h         |   15 +++++++
>  3 files changed, 115 insertions(+)
>  create mode 100644 drivers/cxl/core/acpi.c
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 438ce27faf77..11ccc2016ab7 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -11,4 +11,5 @@ cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
>  cxl_core-y += cdat.o
> +cxl_core-y += acpi.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/acpi.c b/drivers/cxl/core/acpi.c
> new file mode 100644
> index 000000000000..86dc6c9c1f24
> --- /dev/null
> +++ b/drivers/cxl/core/acpi.c
> @@ -0,0 +1,99 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/module.h>
> +#include <linux/device.h>
> +#include <linux/kernel.h>
> +#include <linux/acpi.h>
> +#include <linux/pci.h>
> +#include <asm/div64.h>
> +#include "cxlpci.h"
> +#include "cxl.h"
> +
> +const guid_t acpi_cxl_qtg_id_guid =
> +	GUID_INIT(0xF365F9A6, 0xA7DE, 0x4071,
> +		  0xA6, 0x6A, 0xB4, 0x0C, 0x0B, 0x4F, 0x8E, 0x52);
> +
> +/**
> + * cxl_acpi_evaluate_qtg_dsm - Retrieve QTG ids via ACPI _DSM
> + * @handle: ACPI handle
> + * @input: bandwidth and latency data
> + *
> + * Issue QTG _DSM with accompanied bandwidth and latency data in order to get
> + * the QTG IDs that falls within the performance data.
> + */
> +struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
> +						 struct qtg_dsm_input *input)
> +{
> +	struct qtg_dsm_output *output;
> +	union acpi_object *out_obj, *out_buf, *pkg, in_buf, in_obj;

Reorder to reverse Xmas tree perhaps.

> +	int len;
> +	int rc;
Might as well put those on one line.

> +
> +	in_obj.type = ACPI_TYPE_PACKAGE;
> +	in_obj.package.count = 1;
> +	in_obj.package.elements = &in_buf;
> +	in_buf.type = ACPI_TYPE_BUFFER;
> +	in_buf.buffer.pointer = (u8 *)input;
> +	in_buf.buffer.length = sizeof(u32) * 4;
c99 style is nicer to read.

	union acpi_object in_obj = {
		.type = 

	}
> +
> +	out_obj = acpi_evaluate_dsm(handle, &acpi_cxl_qtg_id_guid, 1, 1, &in_obj);
> +	if (!out_obj)
> +		return ERR_PTR(-ENXIO);
> +
> +	if (out_obj->type != ACPI_TYPE_PACKAGE) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	/*
> +	 * CXL spec v3.0 9.17.3.1
> +	 * There should be 2 elements in the package. 1 WORD for max QTG ID supported
> +	 * by the platform, and the other a package of recommended QTGs
> +	 */
> +	if (out_obj->package.count != 2) {

This stuff is usually designed to be extensible - tends to be explicitly allowed in
stuff in the ACPI spec (not mentioned AFAICT in the CXL spec).  So I'd be tempted to allow
> 2 just don't read them.

	if (out_obj->package.count < 2) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	pkg = &out_obj->package.elements[1];
> +	if (pkg->type != ACPI_TYPE_PACKAGE) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	out_buf = &pkg->package.elements[0];
> +	if (out_buf->type != ACPI_TYPE_BUFFER) {
> +		rc = -ENXIO;
> +		goto err;
> +	}
> +
> +	len = out_buf->buffer.length;
> +	output = kmalloc(len + sizeof(*output), GFP_KERNEL);
> +	if (!output) {
> +		rc = -ENOMEM;
> +		goto err;
> +	}
> +
> +	/* It's legal to have 0 QTG entries */
> +	if (len == 0) {
> +		output->nr = 0;
> +		goto out;
> +	}
> +
> +	/* Malformed package, not multiple of WORD size */
> +	if (len % sizeof(u16)) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	output->nr = len / sizeof(u16);
> +	memcpy(output->qtg_ids, out_buf->buffer.pointer, len);

Worth checking them against Max Support QTG ID as provided in the
outer package?  Obviously if they are greater than that there is
a bug, but meh.

> +out:
> +	ACPI_FREE(out_obj);
> +	return output;
> +
> +err:
> +	ACPI_FREE(out_obj);
> +	return ERR_PTR(rc);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_acpi_evaluate_qtg_dsm, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 849b22236f1d..e70df07f9b4b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -719,6 +719,21 @@ int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler,
>  int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg);
>  int cxl_dslbis_parse_entry(struct acpi_cdat_header *header, void *arg);
>  
> +struct qtg_dsm_input {
> +	u32 rd_lat;
> +	u32 wr_lat;
> +	u32 rd_bw;
> +	u32 wr_bw;
> +};
> +
> +struct qtg_dsm_output {
> +	int nr;
> +	u16 qtg_ids[];
> +};
> +
> +struct qtg_dsm_output *cxl_acpi_evaluate_qtg_dsm(acpi_handle handle,
> +						 struct qtg_dsm_input *input);
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> 
> 

