Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A98D511D58
	for <lists+linux-pci@lfdr.de>; Wed, 27 Apr 2022 20:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244584AbiD0SE3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Apr 2022 14:04:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244542AbiD0SE2 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Apr 2022 14:04:28 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D2D37CEBB;
        Wed, 27 Apr 2022 11:01:16 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KpRKL4s2cz67gQT;
        Thu, 28 Apr 2022 01:57:10 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 20:01:14 +0200
Received: from localhost (10.81.200.74) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 27 Apr
 2022 19:01:13 +0100
Date:   Wed, 27 Apr 2022 19:01:11 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     <ira.weiny@intel.com>
CC:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V8 10/10] cxl/port: Parse out DSMAS data from CDAT table
Message-ID: <20220427190111.0000785e@Huawei.com>
In-Reply-To: <20220414203237.2198665-11-ira.weiny@intel.com>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
        <20220414203237.2198665-11-ira.weiny@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.74]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Apr 2022 13:32:37 -0700
ira.weiny@intel.com wrote:

> From: Ira Weiny <ira.weiny@intel.com>
> 
> CXL Ports with memory devices attached need the information from the
> Device Scoped Memory Affinity Structure (DSMAS).  This information is
> contained within the CDAT table buffer which is previously read and
> cached in the device state.
> 
> If CDAT data is available, parse and cache DSMAS data from the table.
> Store this data in unmarshaled struct dsmas data structures for ease of
> use.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

You could hold off on this patch and having it in the series that uses
the data.

Patch itself looks fine - it's just a bit random to parse one particular
record and do nothing with it beyond some debug prints :)

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes from V7
> 	Rebased on cxl-pending
> 
> Changes from V6
> 	Move to port.c
> 	It is not an error if no DSMAS data is found
> 
> Changes from V5
> 	Fix up sparse warnings
> 	Split out cdat_hdr_valid()
> 	Update cdat_hdr_valid()
> 		Remove revision and cs field parsing
> 			There is no point in these
> 		Add seq check and debug print.
> 	From Jonathan
> 		Add spaces around '+' and '/'
> 		use devm_krealloc() for dmas_ary
> ---
>  drivers/cxl/cdat.h | 17 ++++++++++++
>  drivers/cxl/cxl.h  |  6 +++++
>  drivers/cxl/port.c | 65 ++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+)
> 
> diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> index a7725d26f2d2..66706b238bc9 100644
> --- a/drivers/cxl/cdat.h
> +++ b/drivers/cxl/cdat.h
> @@ -83,6 +83,23 @@
>  #define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
>  #define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
>  
> +/**
> + * struct cxl_dsmas - host unmarshaled version of DSMAS data
> + *
> + * As defined in the Coherent Device Attribute Table (CDAT) specification this
> + * represents a single DSMAS entry in that table.
> + *
> + * @dpa_base: The lowest Device Physical Address associated with this DSMAD
> + * @length: Length in bytes of this DSMAD
> + * @non_volatile: If set, the memory region represents Non-Volatile memory
> + */
> +struct cxl_dsmas {
> +	u64 dpa_base;
> +	u64 length;
> +	/* Flags */
> +	u8 non_volatile:1;
> +};
> +
>  /**
>   * struct cxl_cdat - CXL CDAT data
>   *
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 50817fd2c912..80fd39769a65 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -9,6 +9,8 @@
>  #include <linux/bitops.h>
>  #include <linux/io.h>
>  
> +#include "cdat.h"
> +
>  /**
>   * DOC: cxl objects
>   *
> @@ -269,6 +271,8 @@ struct cxl_nvdimm {
>   * @component_reg_phys: component register capability base address (optional)
>   * @dead: last ep has been removed, force port re-creation
>   * @depth: How deep this port is relative to the root. depth 0 is the root.
> + * @dsmas_ary: Array of DSMAS entries as parsed from the CDAT table
> + * @nr_dsmas: Number of entries in dsmas_ary
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -280,6 +284,8 @@ struct cxl_port {
>  	resource_size_t component_reg_phys;
>  	bool dead;
>  	unsigned int depth;
> +	struct cxl_dsmas *dsmas_ary;
> +	int nr_dsmas;
>  };
>  
>  /**
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index d420da5fc39c..2288432a27cd 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -30,6 +30,70 @@ static void schedule_detach(void *cxlmd)
>  	schedule_cxl_memdev_detach(cxlmd);
>  }
>  
> +static void parse_dsmas(struct cxl_port *port, struct cxl_dev_state *cxlds)
> +{
> +	struct device *dev = &port->dev;
> +	struct cxl_dsmas *dsmas_ary = NULL;
> +	u32 *data = cxlds->cdat.table;
> +	int bytes_left = cxlds->cdat.length;
> +	int nr_dsmas = 0;
> +
> +	if (!data) {
> +		dev_info(dev, "No CDAT data available for DSMAS\n");
> +		return;
> +	}
> +
> +	/* Skip header */
> +	data += CDAT_HEADER_LENGTH_DW;
> +	bytes_left -= CDAT_HEADER_LENGTH_BYTES;
> +
> +	while (bytes_left > 0) {
> +		u32 *cur_rec = data;
> +		u8 type = FIELD_GET(CDAT_STRUCTURE_DW0_TYPE, cur_rec[0]);
> +		u16 length = FIELD_GET(CDAT_STRUCTURE_DW0_LENGTH, cur_rec[0]);
> +
> +		if (type == CDAT_STRUCTURE_DW0_TYPE_DSMAS) {
> +			struct cxl_dsmas *new_ary;
> +			u8 flags;
> +
> +			new_ary = devm_krealloc(dev, dsmas_ary,
> +					   sizeof(*dsmas_ary) * (nr_dsmas + 1),
> +					   GFP_KERNEL);
> +			if (!new_ary) {
> +				dev_err(dev,
> +					"Failed to allocate memory for DSMAS data (nr_dsmas %d)\n",
> +					nr_dsmas);
> +				return;
> +			}
> +			dsmas_ary = new_ary;
> +
> +			flags = FIELD_GET(CDAT_DSMAS_DW1_FLAGS, cur_rec[1]);
> +
> +			dsmas_ary[nr_dsmas].dpa_base = CDAT_DSMAS_DPA_OFFSET(cur_rec);
> +			dsmas_ary[nr_dsmas].length = CDAT_DSMAS_DPA_LEN(cur_rec);
> +			dsmas_ary[nr_dsmas].non_volatile = CDAT_DSMAS_NON_VOLATILE(flags);
> +
> +			dev_dbg(dev, "DSMAS %d: %llx:%llx %s\n",
> +				nr_dsmas,
> +				dsmas_ary[nr_dsmas].dpa_base,
> +				dsmas_ary[nr_dsmas].dpa_base +
> +					dsmas_ary[nr_dsmas].length,
> +				(dsmas_ary[nr_dsmas].non_volatile ?
> +					"Persistent" : "Volatile")
> +				);
> +
> +			nr_dsmas++;
> +		}
> +
> +		data += (length / sizeof(u32));
> +		bytes_left -= length;
> +	}
> +
> +	dev_dbg(dev, "Found %d DSMAS entries\n", nr_dsmas);
> +	port->dsmas_ary = dsmas_ary;
> +	port->nr_dsmas = nr_dsmas;
> +}
> +

