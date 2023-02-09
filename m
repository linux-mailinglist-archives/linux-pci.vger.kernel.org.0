Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B340E690830
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 13:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbjBIMHb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 07:07:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229660AbjBIMHT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 07:07:19 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19AE6ADFE;
        Thu,  9 Feb 2023 03:58:55 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCFcx5Dsjz6J7lx;
        Thu,  9 Feb 2023 19:53:37 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 11:58:04 +0000
Date:   Thu, 9 Feb 2023 11:58:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 04/18] cxl: Add common helpers for cdat parsing
Message-ID: <20230209115803.00002778@Huawei.com>
In-Reply-To: <167571659666.587790.1381783105886436293.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571659666.587790.1381783105886436293.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
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

On Mon, 06 Feb 2023 13:49:58 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Add helper functions to parse the CDAT table and provide a callback to
> parse the sub-table. Helpers are provided for DSMAS and DSLBIS sub-table
> parsing. The code is patterned after the ACPI table parsing helpers.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
> ---
>  drivers/cxl/core/Makefile |    1 
>  drivers/cxl/core/cdat.c   |   98 +++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/cdat.h   |   15 +++++++
>  drivers/cxl/cxl.h         |    9 ++++
>  4 files changed, 123 insertions(+)
>  create mode 100644 drivers/cxl/core/cdat.c
>  create mode 100644 drivers/cxl/core/cdat.h
> 
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 79c7257f4107..438ce27faf77 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -10,4 +10,5 @@ cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
>  cxl_core-y += hdm.o
> +cxl_core-y += cdat.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> new file mode 100644
> index 000000000000..be09c8a690f5
> --- /dev/null
> +++ b/drivers/cxl/core/cdat.c
> @@ -0,0 +1,98 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> +#include "cxl.h"
> +#include "cdat.h"
> +
> +static u8 cdat_get_subtable_entry_type(struct cdat_subtable_entry *entry)
> +{
> +	return entry->hdr->type;
> +}

Are these all worthwhile given the resulting function name is longer
than accessing it directly.  If aim is to move the details of the
struct cdat_subtable_entry away from being exposed at caller, then
fair enough, but if that is the plan I'd expect to see something about
that in the patch description.

Feels like some premature abstraction, but I don't feel particularly
strongly about this.


> +
> +static u16 cdat_get_subtable_entry_length(struct cdat_subtable_entry *entry)
> +{
> +	return entry->hdr->length;
> +}
> +
> +static bool has_handler(struct cdat_subtable_proc *proc)
> +{
> +	return proc->handler;
> +}
> +
> +static int call_handler(struct cdat_subtable_proc *proc,
> +			struct cdat_subtable_entry *ent)
> +{
> +	if (proc->handler)

Use your wrapper...

> +		return proc->handler(ent->hdr, proc->arg);
> +	return -EINVAL;
> +}
> +
> +static int cdat_table_parse_entries(enum acpi_cdat_type type,
> +				    struct acpi_table_cdat *table_header,
> +				    struct cdat_subtable_proc *proc,
> +				    unsigned int max_entries)

Documentation needed.  max_entries wasn't what I was expecting.
I would have expected it to be a cap on number of entries of
matching type, whereas it seems to be number of entries of any type.

Also, max_entries == 0 non obvious parameter value.


> +{
> +	struct cdat_subtable_entry entry;
> +	unsigned long table_end, entry_len;
> +	int count = 0;
> +	int rc;
> +
> +	if (!has_handler(proc))
> +		return -EINVAL;
> +
> +	table_end = (unsigned long)table_header + table_header->length;
> +
> +	if (type >= ACPI_CDAT_TYPE_RESERVED)
> +		return -EINVAL;
> +
> +	entry.type = type;
> +	entry.hdr = (struct acpi_cdat_header *)((unsigned long)table_header +
> +					       sizeof(*table_header));

Common idiom for this is.

	entry.hdr = (struct acpi_cdat_header *)(table_header + 1);

> +
> +	while ((unsigned long)entry.hdr < table_end) {
> +		entry_len = cdat_get_subtable_entry_length(&entry);
> +
> +		if ((unsigned long)entry.hdr + entry_len > table_end)
> +			return -EINVAL;
> +
> +		if (max_entries && count >= max_entries)
> +			break;
> +
> +		if (entry_len == 0)
> +			return -EINVAL;
> +
> +		if (cdat_get_subtable_entry_type(&entry) == type) {

This is a little odd as we set entry.type above == type, but
the match here is on the value in the one in entry.hdr.

That's not particularly intuitive. Not sure on what a good solution
would be though.  Maybe just

		if (cdat_is_subtable_match(&entry))

> +			rc = call_handler(proc, &entry);
> +			if (rc)
> +				return rc;
> +		}

As above.  Maybe intent, but my initial assumption would have had
count not incremented unless there was a match. (so put it in this if block
not below)

> +
> +		entry.hdr = (struct acpi_cdat_header *)((unsigned long)entry.hdr + entry_len);
> +		count++;
> +	}
> +
> +	return count;
> +}
> +
> +int cdat_table_parse_dsmas(void *table, cdat_tbl_entry_handler handler, void *arg)
> +{
> +	struct acpi_table_cdat *header = (struct acpi_table_cdat *)table;

Now struct acpi_table_cdata exists, maybe just move to using
that type for all references.  Will make a mess of the range checking
efforts the hardening folk are working on as we will index off end of
it and it doesn't have a variable length array trailing element.

Random musing follows...
We could add a variable length element to that struct
definition and the magic to associate that with the length parameter
and get range protection if relevant hardening is turned on.

Structure definition comes (I think) from scripts in acpica so
would need to push such changes into acpica and I'm not sure
they will be keen even though it would be good for the kernel
to have the protections.

https://people.kernel.org/kees/bounded-flexible-arrays-in-c
for Kees Cook's blog on this stuff.  The last bit needs
the 'comming soon' part.

> +	struct cdat_subtable_proc proc = {
> +		.handler	= handler,
> +		.arg		= arg,
> +	};
> +
> +	return cdat_table_parse_entries(ACPI_CDAT_TYPE_DSMAS, header, &proc, 0);
> +}
> +EXPORT_SYMBOL_NS_GPL(cdat_table_parse_dsmas, CXL);
> +
> +int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler, void *arg)
> +{
> +	struct acpi_table_cdat *header = (struct acpi_table_cdat *)table;
> +	struct cdat_subtable_proc proc = {
> +		.handler	= handler,
> +		.arg		= arg,
> +	};
> +
> +	return cdat_table_parse_entries(ACPI_CDAT_TYPE_DSLBIS, header, &proc, 0);
> +}
> +EXPORT_SYMBOL_NS_GPL(cdat_table_parse_dslbis, CXL);
> diff --git a/drivers/cxl/core/cdat.h b/drivers/cxl/core/cdat.h
> new file mode 100644
> index 000000000000..f690325e82a6
> --- /dev/null
> +++ b/drivers/cxl/core/cdat.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2023 Intel Corporation. */
> +#ifndef __CXL_CDAT_H__
> +#define __CXL_CDAT_H__
> +
> +struct cdat_subtable_proc {
> +	cdat_tbl_entry_handler handler;
> +	void *arg;
> +};
> +
> +struct cdat_subtable_entry {
> +	struct acpi_cdat_header *hdr;
> +	enum acpi_cdat_type type;
> +};
> +#endif
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index f558bbfc0332..839a121c1997 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -9,6 +9,7 @@
>  #include <linux/bitops.h>
>  #include <linux/log2.h>
>  #include <linux/io.h>
> +#include <linux/acpi.h>
>  
>  /**
>   * DOC: cxl objects
> @@ -697,6 +698,14 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
>  }
>  #endif
>  
> +typedef int (*cdat_tbl_entry_handler)(struct acpi_cdat_header *header, void *arg);
> +
> +u8 cdat_table_checksum(u8 *buffer, u32 length);
> +int cdat_table_parse_dsmas(void *table, cdat_tbl_entry_handler handler,
> +			   void *arg);
> +int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler,
> +			    void *arg);
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> 
> 

