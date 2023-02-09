Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67F8B690ADD
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 14:50:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230297AbjBINuN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Feb 2023 08:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjBINuM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 9 Feb 2023 08:50:12 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405DC3C2B2;
        Thu,  9 Feb 2023 05:50:10 -0800 (PST)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PCJ6D47Vxz6J7N8;
        Thu,  9 Feb 2023 21:45:40 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Thu, 9 Feb
 2023 13:50:07 +0000
Date:   Thu, 9 Feb 2023 13:50:07 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dave Jiang <dave.jiang@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-acpi@vger.kernel.org>, <dan.j.williams@intel.com>,
        <ira.weiny@intel.com>, <vishal.l.verma@intel.com>,
        <alison.schofield@intel.com>, <rafael@kernel.org>,
        <bhelgaas@google.com>, <robert.moore@intel.com>
Subject: Re: [PATCH 07/18] cxl: Add callback to parse the DSLBIS subtable
 from CDAT
Message-ID: <20230209135007.0000667d@Huawei.com>
In-Reply-To: <167571662248.587790.4362747686454305108.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
        <167571662248.587790.4362747686454305108.stgit@djiang5-mobl3.local>
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

On Mon, 06 Feb 2023 13:50:23 -0700
Dave Jiang <dave.jiang@intel.com> wrote:

> Provide a callback to parse the Device Scoped Latency and Bandwidth
> Information Structure (DSLBIS) in the CDAT structures. The DSLBIS
> contains the bandwidth and latency information that's tied to a DSMAS
> handle. The driver will retrieve the read and write latency and
> bandwidth associated with the DSMAS which is tied to a DPA range.
> 
> Signed-off-by: Dave Jiang <dave.jiang@intel.com>
A few comments inline,

Thanks,

Jonathan

> ---
>  drivers/cxl/core/cdat.c |   34 ++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    2 ++
>  drivers/cxl/port.c      |    9 ++++++++-
>  include/acpi/actbl1.h   |    5 +++++
>  4 files changed, 49 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cxl/core/cdat.c b/drivers/cxl/core/cdat.c
> index f9a64a0f1ee4..3c8f3956487e 100644
> --- a/drivers/cxl/core/cdat.c
> +++ b/drivers/cxl/core/cdat.c
> @@ -121,3 +121,37 @@ int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_dsmas_parse_entry, CXL);
> +
> +int cxl_dslbis_parse_entry(struct acpi_cdat_header *header, void *arg)
> +{
> +	struct cxl_port *port = (struct cxl_port *)arg;
> +	struct dsmas_entry *dent;
> +	struct acpi_cdat_dslbis *dslbis;

Perhaps reorder to maintain the pretty upside-down Christmas trees
(I don't care :)

> +	u64 val;
> +
> +	if (header->type != ACPI_CDAT_TYPE_DSLBIS)
> +		return -EINVAL;

Isn't this guaranteed by the caller?  Seems overkill do it twice
and I don't think these will ever be called outside of that wrapper that
loops over the entries. I could be wrong though!

> +
> +	dslbis = (struct acpi_cdat_dslbis *)((unsigned long)header + sizeof(*header));
header + 1

> +	if ((dslbis->flags & ACPI_CEDT_DSLBIS_MEM_MASK) !=

This field 'must be ignored' if the DSMAS handle isn't a match
(as it's an initiator only entry) Odd though it may seem I think we
might see one of those on a type 3 device and we are probably going to
have other users of this function anyway.

I think you need to do the walk below to check we have a DSMAS match, before
running this check.

> +	     ACPI_CEDT_DSLBIS_MEM_MEMORY)
> +		return 0;
> +
> +	if (dslbis->data_type > ACPI_HMAT_WRITE_BANDWIDTH)
> +		return -ENXIO;

This would probably imply a new HMAT spec value, so probably just
log it and ignore rather than error out.

> +
> +	/* Value calculation with base_unit, see ACPI Spec 6.5 5.2.28.4 */
> +	val = dslbis->entry[0] * dslbis->entry_base_unit;

In theory this might overflow as u64 * u16.
Doubt it will ever happen in reality, but maybe a check and debug print if it does?

> +
> +	mutex_lock(&port->cdat.dsmas_lock);
> +	list_for_each_entry(dent, &port->cdat.dsmas_list, list) {
> +		if (dslbis->handle == dent->handle) {
> +			dent->qos[dslbis->data_type] = val;
> +			break;
> +		}
> +	}
> +	mutex_unlock(&port->cdat.dsmas_lock);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_dslbis_parse_entry, CXL);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 1e5e69f08480..849b22236f1d 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -705,6 +705,7 @@ struct dsmas_entry {
>  	struct list_head list;
>  	struct range dpa_range;
>  	u16 handle;
> +	u64 qos[ACPI_HMAT_WRITE_BANDWIDTH + 1];
>  };
>  
>  typedef int (*cdat_tbl_entry_handler)(struct acpi_cdat_header *header, void *arg);
> @@ -716,6 +717,7 @@ int cdat_table_parse_dslbis(void *table, cdat_tbl_entry_handler handler,
>  			    void *arg);
>  
>  int cxl_dsmas_parse_entry(struct acpi_cdat_header *header, void *arg);
> +int cxl_dslbis_parse_entry(struct acpi_cdat_header *header, void *arg);
>  
>  /*
>   * Unit test builds overrides this to __weak, find the 'strong' version
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index b1da73e99bab..8de311208b37 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -65,8 +65,15 @@ static int cxl_port_probe(struct device *dev)
>  			rc = cdat_table_parse_dsmas(port->cdat.table,
>  						    cxl_dsmas_parse_entry,
>  						    (void *)port);
> -			if (rc < 0)
> +			if (rc > 0) {
> +				rc = cdat_table_parse_dslbis(port->cdat.table,
> +							     cxl_dslbis_parse_entry,
> +							     (void *)port);
> +				if (rc <= 0)
> +					dev_dbg(dev, "Failed to parse DSLBIS: %d\n", rc);

If we have entries and they won't parse, I think we should be screaming louder.
dev_warn() would be my preference for this and the one in the previous patch.
Sure we can carry on, but something on the device is not working as expected.

> +			} else {
>  				dev_dbg(dev, "Failed to parse DSMAS: %d\n", rc);
> +			}
>  		}
>  
>  		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index e8297cefde09..ff6092e45196 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -369,6 +369,11 @@ struct acpi_cdat_dslbis {
>  	u16 reserved2;
>  };
>  
> +/* Flags for subtable above */
> +
> +#define ACPI_CEDT_DSLBIS_MEM_MASK	GENMASK(3, 0)
> +#define ACPI_CEDT_DSLBIS_MEM_MEMORY	0
> +
>  /* Subtable 2: Device Scoped Memory Side Cache Information Structure (DSMSCIS) */
>  
>  struct acpi_cdat_dsmscis {
> 
> 

