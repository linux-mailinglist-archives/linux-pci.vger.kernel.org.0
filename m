Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E2E04A6811
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 23:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241611AbiBAWhS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 17:37:18 -0500
Received: from mga05.intel.com ([192.55.52.43]:26581 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235380AbiBAWhS (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 17:37:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643755038; x=1675291038;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3bJXWMpijyxnuSq4wqUM7+ER5kCt79vqJYQBft68eDA=;
  b=NE7kI8iWjwQUjptmrXeOQO/RHRh2u+eF7w+CpCaWGnK9js2A5WeBuy9m
   1bAMdCPCh04hhIWMRqQt7cgcsjRbQTZM0MBa/CJJFzGq34ypkIgR77O3m
   1gxFIn7vGM7Ny0NGtsTEWtiixJZLWDzYq9mCQ0ADPQf5fn6DPXK2KaBgB
   5gLjaCfVpjTcKQxcX4iH6l3jkz0LHtAGWmq2HodFpp0odFqJv/Wc2x7u0
   Lzhqf24+HGM9DSEotTLmozfWO5NjG/FF63oaK//DeGAJ0yGXgcB3OrSaD
   AHcuXF7nnYyjJbFPwy/2HB+gI0htVRW5TV5GZ3X/pBG75XYo6uLEzQJdw
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="334168599"
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="334168599"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:37:18 -0800
X-IronPort-AV: E=Sophos;i="5.88,335,1635231600"; 
   d="scan'208";a="538015351"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Feb 2022 14:37:17 -0800
Date:   Tue, 1 Feb 2022 14:37:17 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V6 10/10] cxl/cdat: Parse out DSMAS data from CDAT table
Message-ID: <20220201223717.GR785175@iweiny-DESK2.sc.intel.com>
Mail-Followup-To: Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
References: <20220201071952.900068-1-ira.weiny@intel.com>
 <20220201071952.900068-11-ira.weiny@intel.com>
 <20220201190532.ynwr73ninobqx7bm@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220201190532.ynwr73ninobqx7bm@intel.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Feb 01, 2022 at 11:05:32AM -0800, Widawsky, Ben wrote:
> On 22-01-31 23:19:52, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > CXL memory devices need the information in the Device Scoped Memory
> > Affinity Structure (DSMAS).  This information is contained within the
> > CDAT table buffer which is already read and cached.
> > 
> > Parse and cache DSMAS data from the CDAT table.  Store this data in
> > unmarshaled struct dsmas data structures for ease of use.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V5
> > 	Fix up sparse warnings
> > 	Split out cdat_hdr_valid()
> > 	Update cdat_hdr_valid()
> > 		Remove revision and cs field parsing
> > 			There is no point in these
> > 		Add seq check and debug print.
> > 	From Jonathan
> > 		Add spaces around '+' and '/'
> > 		use devm_krealloc() for dmas_ary
> > 
> > Changes from V4
> > 	New patch
> > ---
> >  drivers/cxl/cdat.h        | 21 ++++++++++++
> >  drivers/cxl/core/memdev.c | 70 +++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 91 insertions(+)
> > 
> > diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> > index a7725d26f2d2..f8c126190d18 100644
> > --- a/drivers/cxl/cdat.h
> > +++ b/drivers/cxl/cdat.h
> > @@ -83,17 +83,38 @@
> >  #define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
> >  #define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
> >  
> > +/**
> > + * struct cxl_dsmas - host unmarshaled version of DSMAS data
> > + *
> > + * As defined in the Coherent Device Attribute Table (CDAT) specification this
> > + * represents a single DSMAS entry in that table.
> > + *
> > + * @dpa_base: The lowest DPA address associated with this DSMAD
> > + * @dpa_length: Length in bytes of this DSMAD
> > + * @non_volatile: If set, the memory region represents Non-Volatile memory
> > + */
> > +struct cxl_dsmas {
> > +	u64 dpa_base;
> > +	u64 dpa_length;
> > +	/* Flags */
> > +	u8 non_volatile:1;
> > +};
> > +
> >  /**
> >   * struct cxl_cdat - CXL CDAT data
> >   *
> >   * @table: cache of CDAT table
> >   * @length: length of cached CDAT table
> >   * @seq: Last read Sequence number of the CDAT table
> > + * @dsmas_ary: Array of DSMAS entries as parsed from the CDAT table
> > + * @nr_dsmas: Number of entries in dsmas_ary
> >   */
> >  struct cxl_cdat {
> >  	void *table;
> >  	size_t length;
> >  	u32 seq;
> > +	struct cxl_dsmas *dsmas_ary;
> > +	int nr_dsmas;
> >  };
> >  
> >  #endif /* !__CXL_CDAT_H__ */
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index 11d721c56f08..32342a15e991 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -6,6 +6,7 @@
> >  #include <linux/idr.h>
> >  #include <linux/pci.h>
> >  #include <cxlmem.h>
> > +#include "cdat.h"
> >  #include "core.h"
> >  
> >  static DECLARE_RWSEM(cxl_memdev_rwsem);
> > @@ -386,6 +387,71 @@ static int read_cdat_data(struct cxl_memdev *cxlmd,
> >  	return rc;
> >  }
> >  
> > +static int parse_dsmas(struct cxl_memdev *cxlmd)
> > +{
> > +	struct cxl_dsmas *dsmas_ary = NULL;
> > +	u32 *data = cxlmd->cdat.table;
> > +	int bytes_left = cxlmd->cdat.length;
> > +	int nr_dsmas = 0;
> > +
> > +	if (!data)
> > +		return -ENXIO;
> > +
> > +	/* Skip header */
> > +	data += CDAT_HEADER_LENGTH_DW;
> > +	bytes_left -= CDAT_HEADER_LENGTH_BYTES;
> > +
> > +	while (bytes_left > 0) {
> > +		u32 *cur_rec = data;
> > +		u8 type = FIELD_GET(CDAT_STRUCTURE_DW0_TYPE, cur_rec[0]);
> > +		u16 length = FIELD_GET(CDAT_STRUCTURE_DW0_LENGTH, cur_rec[0]);
> > +
> > +		if (type == CDAT_STRUCTURE_DW0_TYPE_DSMAS) {
> > +			struct cxl_dsmas *new_ary;
> > +			u8 flags;
> > +
> > +			new_ary = devm_krealloc(&cxlmd->dev, dsmas_ary,
> > +					   sizeof(*dsmas_ary) * (nr_dsmas + 1),
> > +					   GFP_KERNEL);
> > +			if (!new_ary) {
> > +				dev_err(&cxlmd->dev,
> > +					"Failed to allocate memory for DSMAS data\n");
> > +				return -ENOMEM;
> > +			}
> 
> One thought here - it looks like there are at most 256 DSMAS entries. You could
> allocate the full 256 up front, and then realloc *down* to the actual number.
> 
> > +			dsmas_ary = new_ary;
> > +
> > +			flags = FIELD_GET(CDAT_DSMAS_DW1_FLAGS, cur_rec[1]);
> > +
> > +			dsmas_ary[nr_dsmas].dpa_base = CDAT_DSMAS_DPA_OFFSET(cur_rec);
> > +			dsmas_ary[nr_dsmas].dpa_length = CDAT_DSMAS_DPA_LEN(cur_rec);
> > +			dsmas_ary[nr_dsmas].non_volatile = CDAT_DSMAS_NON_VOLATILE(flags);
> > +
> > +			dev_dbg(&cxlmd->dev, "DSMAS %d: %llx:%llx %s\n",
> > +				nr_dsmas,
> > +				dsmas_ary[nr_dsmas].dpa_base,
> > +				dsmas_ary[nr_dsmas].dpa_base +
> > +					dsmas_ary[nr_dsmas].dpa_length,
> > +				(dsmas_ary[nr_dsmas].non_volatile ?
> > +					"Persistent" : "Volatile")
> > +				);
> > +
> > +			nr_dsmas++;
> > +		}
> > +
> > +		data += (length / sizeof(u32));
> > +		bytes_left -= length;
> > +	}
> > +
> > +	if (nr_dsmas == 0)
> > +		return -ENXIO;
> 
> Hmm is there documentation that suggests a DSMAS must be implemented? Could this
> just return 0? I'd put maybe dev_dbg here if it's unexpected but not a failure
> and return success.

For this call I was not envisioning this as an error.  I wanted to leave it up
to the caller.

I think it would make more sense to return the number of DSMAS' found or
negative errno on failure...

I'll clean it up.  Including below...

> 
> > +
> > +	dev_dbg(&cxlmd->dev, "Found %d DSMAS entries\n", nr_dsmas);
> > +	cxlmd->cdat.dsmas_ary = dsmas_ary;
> > +	cxlmd->cdat.nr_dsmas = nr_dsmas;
> > +
> > +	return 0;
> > +}
> > +
> >  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> >  {
> >  	struct cxl_memdev *cxlmd;
> > @@ -407,6 +473,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> >  	if (rc)
> >  		goto err;
> >  
> > +	rc = parse_dsmas(cxlmd);
> > +	if (rc)
> > +		dev_warn(dev, "No DSMAS data found: %d\n", rc);
> > +

This was changed to dev_warn() because I think here we do expect dsmas data?
Don't we?

Thanks,
Ira

> >  	/*
> >  	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
> >  	 * needed as this is ordered with cdev_add() publishing the device.
> > -- 
> > 2.31.1
> > 
