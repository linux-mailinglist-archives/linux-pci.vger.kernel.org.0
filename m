Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E940C6909F3
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 14:29:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229750AbjBIN3j (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 08:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjBIN3i (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 08:29:38 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B69B059B58;
        Thu,  9 Feb 2023 05:29:29 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCHfm6NfDz6J659;
        Thu,  9 Feb 2023 21:25:20 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 13:29:26 +0000
Date:   Thu, 9 Feb 2023 13:29:25 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 06/18] cxl: Add callback to parse the DSMAS subtables
 from CDAT
Message-ID: <20230209132925.00006711@Huawei.com>
In-Reply-To: <167571661375.587790.16681436923769338643.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571661375.587790.16681436923769338643.stgit@djiang5-mobl3.local>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
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

On Mon, 06 Feb 2023 13:50:15 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Provide a callback function to the CDAT parser in order to parse the Device
> Scoped Memory Affinity Structure (DSMAS). Each DSMAS structure contains the
> DPA range and its associated attributes in each entry. See the CDAT
> specification for details.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
Hi Dave,

A few minor questions / comments inline,

Jonathan

> ---
>  drivers/cxl/core/cdat.c |   25 +++++++++++++++++++++++++
>  drivers/cxl/core/port.c |    2 ++
>  drivers/cxl/cxl.h       |   11 +++++++++++
>  drivers/cxl/port.c      |    8 ++++++++
>  4 files changed, 46 insertions(+)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index be09c8a690f5..f9a64a0f1ee4 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -96,3 +96,28 @@ int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler, void *a
>  	return cdat_table_parse_entries(ACPI_CDAT_TYPE_DSLBIS, header, &proc, 0);
>  }
>  EXPORT_SYMBOL_NS_GPL(cdat_table_parse_dslbis, CXL);
> +
> +int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg)
> +{
> +	struct cxl_port *port = (struct cxl_port *)arg;
> +	struct dsmas_entry *dent;
> +	struct acpi_cdat_dsmas *dsmas;
> +
> +	if (header->type != ACPI_CDAT_TYPE_DSMAS)
> +		return -EINVAL;
> +
> +	dent = devm_kzalloc(&port->dev, sizeof(*dent), GFP_KERNEL);
> +	if (!dent)
> +		return -ENOMEM;
> +
> +	dsmas = (struct acpi_cdat_dsmas *)((unsigned long)header + sizeof(*header));

I'd prefer header + 1


> +	dent->handle = dsmas->dsmad_handle;
> +	dent->dpa_range.start = dsmas->dpa_base_address;
> +	dent->dpa_range.end = dsmas->dpa_base_address + dsmas->dpa_length - 1;
> +
> +	mutex_lock(&port->cdat.dsmas_lock);
> +	list_add_tail(&dent->list, &port->cdat.dsmas_list);
> +	mutex_unlock(&port->cdat.dsmas_lock);
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fe78daf7e7c8..2b27319cfd42 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -660,6 +660,8 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>  	device_set_pm_not_required(dev);
>  	dev->bus = &cxl_bus_type;
>  	dev->type = &cxl_port_type;
> +	INIT_LIST_HEAD(&port->cdat.dsmas_list);
> +	mutex_init(&port->cdat.dsmas_lock);
>  
>  	return port;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 839a121c1997..1e5e69f08480 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -8,6 +8,7 @@
>  #include <linux/bitfield.h>
>  #include <linux/bitops.h>
>  #include <linux/log2.h>
> +#include <linux/list.h>
>  #include <linux/io.h>
>  #include <linux/acpi.h>
>  
> @@ -520,6 +521,8 @@ struct cxl_port {
>  	struct cxl_cdat {
>  		void *table;
>  		size_t length;
> +		struct list_head dsmas_list;
> +		struct mutex dsmas_lock; /* lock for dsmas_list */

I'm curious, what might race with the dsmas_list changing and hence what is lock for?

>  	} cdat;
>  	bool cdat_available;
>  };
> @@ -698,6 +701,12 @@ static inline struct cxl_pmem_region *to_cxl_pmem_region(struct device *dev)
>  }
>  #endif
>  
> +struct dsmas_entry {
> +	struct list_head list;
> +	struct range dpa_range;
> +	u16 handle;

handle is 1 byte in the spec. Why larger here?

> +};
> +
>  typedef int (*cdat_tbl_entry_handler)(struct acpi_cdat_header *header, void *arg);
>  
>  u8 cdat_table_checksum(u8 *buffer, u32 length);
> @@ -706,6 +715,8 @@ int cdat_table_parse_dsmas(void *table, cdat_tbl_entry_handler handler,
>  int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler,
>  			    void *arg);
>  
> +int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg);
> +
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
>   * of these symbols in tools/testing/cxl/.
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 5453771bf330..b1da73e99bab 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -61,6 +61,14 @@ static int cxl_port_probe(struct device *dev)
>  		if (rc)
>  			return rc;
>  
> +		if (port->cdat.table) {
> +			rc = cdat_table_parse_dsmas(port->cdat.table,
> +						    cxl_dsmas_parse_entry,
> +						    (void *)port);
> +			if (rc < 0)
> +				dev_dbg(dev, "Failed to parse DSMAS: %d\n", rc);
> +		}
> +
>  		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
>  		if (rc)
>  			return rc;
> 
> 

