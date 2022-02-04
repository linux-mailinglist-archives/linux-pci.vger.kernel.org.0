Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B466A4A99F8
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 14:33:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358840AbiBDNdK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 08:33:10 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4674 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiBDNdK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 08:33:10 -0500
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JqxG21Chnz67Zm5;
        Fri,  4 Feb 2022 21:29:14 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 14:33:07 +0100
Received: from localhost (10.47.31.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Feb
 2022 13:33:06 +0000
Date:   Fri, 4 Feb 2022 13:33:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 10/10] cxl/cdat: Parse out DSMAS data from CDAT table
Message-ID: <20220204133303.0000667b@Huawei.com>
In-Reply-To: <20220201223717.GR785175@iweiny-DESK2.sc.intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
        <20220201071952.900068-11-ira.weiny@intel.com>
        <20220201190532.ynwr73ninobqx7bm@intel.com>
        <20220201223717.GR785175@iweiny-DESK2.sc.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.86]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 1 Feb 2022 14:37:17 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Feb 01, 2022 at 11:05:32AM -0800, Widawsky, Ben wrote:
> > On 22-01-31 23:19:52, ira.weiny@intel.com wrote:  
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > CXL memory devices need the information in the Device Scoped Memory
> > > Affinity Structure (DSMAS).  This information is contained within the
> > > CDAT table buffer which is already read and cached.
> > > 
> > > Parse and cache DSMAS data from the CDAT table.  Store this data in
> > > unmarshaled struct dsmas data structures for ease of use.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > > Changes from V5
> > > 	Fix up sparse warnings
> > > 	Split out cdat_hdr_valid()
> > > 	Update cdat_hdr_valid()
> > > 		Remove revision and cs field parsing
> > > 			There is no point in these
> > > 		Add seq check and debug print.
> > > 	From Jonathan
> > > 		Add spaces around '+' and '/'
> > > 		use devm_krealloc() for dmas_ary
> > > 
> > > Changes from V4
> > > 	New patch
> > > ---
> > >  drivers/cxl/cdat.h        | 21 ++++++++++++
> > >  drivers/cxl/core/memdev.c | 70 +++++++++++++++++++++++++++++++++++++++
> > >  2 files changed, 91 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> > > index a7725d26f2d2..f8c126190d18 100644
> > > --- a/drivers/cxl/cdat.h
> > > +++ b/drivers/cxl/cdat.h
> > > @@ -83,17 +83,38 @@
> > >  #define CDAT_SSLBIS_ENTRY_PORT_Y(entry, i) (((entry)[4 + (i) * 2] & 0xffff0000) >> 16)
> > >  #define CDAT_SSLBIS_ENTRY_LAT_OR_BW(entry, i) ((entry)[4 + (i) * 2 + 1] & 0x0000ffff)
> > >  
> > > +/**
> > > + * struct cxl_dsmas - host unmarshaled version of DSMAS data
> > > + *
> > > + * As defined in the Coherent Device Attribute Table (CDAT) specification this
> > > + * represents a single DSMAS entry in that table.
> > > + *
> > > + * @dpa_base: The lowest DPA address associated with this DSMAD
> > > + * @dpa_length: Length in bytes of this DSMAD
> > > + * @non_volatile: If set, the memory region represents Non-Volatile memory
> > > + */
> > > +struct cxl_dsmas {
> > > +	u64 dpa_base;
> > > +	u64 dpa_length;
> > > +	/* Flags */
> > > +	u8 non_volatile:1;
> > > +};
> > > +
> > >  /**
> > >   * struct cxl_cdat - CXL CDAT data
> > >   *
> > >   * @table: cache of CDAT table
> > >   * @length: length of cached CDAT table
> > >   * @seq: Last read Sequence number of the CDAT table
> > > + * @dsmas_ary: Array of DSMAS entries as parsed from the CDAT table
> > > + * @nr_dsmas: Number of entries in dsmas_ary
> > >   */
> > >  struct cxl_cdat {
> > >  	void *table;
> > >  	size_t length;
> > >  	u32 seq;
> > > +	struct cxl_dsmas *dsmas_ary;
> > > +	int nr_dsmas;
> > >  };
> > >  
> > >  #endif /* !__CXL_CDAT_H__ */
> > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > index 11d721c56f08..32342a15e991 100644
> > > --- a/drivers/cxl/core/memdev.c
> > > +++ b/drivers/cxl/core/memdev.c
> > > @@ -6,6 +6,7 @@
> > >  #include <linux/idr.h>
> > >  #include <linux/pci.h>
> > >  #include <cxlmem.h>
> > > +#include "cdat.h"
> > >  #include "core.h"
> > >  
> > >  static DECLARE_RWSEM(cxl_memdev_rwsem);
> > > @@ -386,6 +387,71 @@ static int read_cdat_data(struct cxl_memdev *cxlmd,
> > >  	return rc;
> > >  }
> > >  
> > > +static int parse_dsmas(struct cxl_memdev *cxlmd)
> > > +{
> > > +	struct cxl_dsmas *dsmas_ary = NULL;
> > > +	u32 *data = cxlmd->cdat.table;
> > > +	int bytes_left = cxlmd->cdat.length;
> > > +	int nr_dsmas = 0;
> > > +
> > > +	if (!data)
> > > +		return -ENXIO;
> > > +
> > > +	/* Skip header */
> > > +	data += CDAT_HEADER_LENGTH_DW;
> > > +	bytes_left -= CDAT_HEADER_LENGTH_BYTES;
> > > +
> > > +	while (bytes_left > 0) {
> > > +		u32 *cur_rec = data;
> > > +		u8 type = FIELD_GET(CDAT_STRUCTURE_DW0_TYPE, cur_rec[0]);
> > > +		u16 length = FIELD_GET(CDAT_STRUCTURE_DW0_LENGTH, cur_rec[0]);
> > > +
> > > +		if (type == CDAT_STRUCTURE_DW0_TYPE_DSMAS) {
> > > +			struct cxl_dsmas *new_ary;
> > > +			u8 flags;
> > > +
> > > +			new_ary = devm_krealloc(&cxlmd->dev, dsmas_ary,
> > > +					   sizeof(*dsmas_ary) * (nr_dsmas + 1),
> > > +					   GFP_KERNEL);
> > > +			if (!new_ary) {
> > > +				dev_err(&cxlmd->dev,
> > > +					"Failed to allocate memory for DSMAS data\n");
> > > +				return -ENOMEM;
> > > +			}  
> > 
> > One thought here - it looks like there are at most 256 DSMAS entries. You could
> > allocate the full 256 up front, and then realloc *down* to the actual number.
> >   
> > > +			dsmas_ary = new_ary;
> > > +
> > > +			flags = FIELD_GET(CDAT_DSMAS_DW1_FLAGS, cur_rec[1]);
> > > +
> > > +			dsmas_ary[nr_dsmas].dpa_base = CDAT_DSMAS_DPA_OFFSET(cur_rec);
> > > +			dsmas_ary[nr_dsmas].dpa_length = CDAT_DSMAS_DPA_LEN(cur_rec);
> > > +			dsmas_ary[nr_dsmas].non_volatile = CDAT_DSMAS_NON_VOLATILE(flags);
> > > +
> > > +			dev_dbg(&cxlmd->dev, "DSMAS %d: %llx:%llx %s\n",
> > > +				nr_dsmas,
> > > +				dsmas_ary[nr_dsmas].dpa_base,
> > > +				dsmas_ary[nr_dsmas].dpa_base +
> > > +					dsmas_ary[nr_dsmas].dpa_length,
> > > +				(dsmas_ary[nr_dsmas].non_volatile ?
> > > +					"Persistent" : "Volatile")
> > > +				);
> > > +
> > > +			nr_dsmas++;
> > > +		}
> > > +
> > > +		data += (length / sizeof(u32));
> > > +		bytes_left -= length;
> > > +	}
> > > +
> > > +	if (nr_dsmas == 0)
> > > +		return -ENXIO;  
> > 
> > Hmm is there documentation that suggests a DSMAS must be implemented? Could this
> > just return 0? I'd put maybe dev_dbg here if it's unexpected but not a failure
> > and return success.  
> 
> For this call I was not envisioning this as an error.  I wanted to leave it up
> to the caller.
> 
> I think it would make more sense to return the number of DSMAS' found or
> negative errno on failure...
> 
> I'll clean it up.  Including below...
> 
> >   
> > > +
> > > +	dev_dbg(&cxlmd->dev, "Found %d DSMAS entries\n", nr_dsmas);
> > > +	cxlmd->cdat.dsmas_ary = dsmas_ary;
> > > +	cxlmd->cdat.nr_dsmas = nr_dsmas;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > >  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> > >  {
> > >  	struct cxl_memdev *cxlmd;
> > > @@ -407,6 +473,10 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> > >  	if (rc)
> > >  		goto err;
> > >  
> > > +	rc = parse_dsmas(cxlmd);
> > > +	if (rc)
> > > +		dev_warn(dev, "No DSMAS data found: %d\n", rc);
> > > +  
> 
> This was changed to dev_warn() because I think here we do expect dsmas data?
> Don't we?

There are flags in the CXL Range registers that specify that some stuff
is communicated via CDAT.  That includes one for whether it is nonvolatile
or not which is a DSMAS flag.  So if that is set we definitely expect them.

We would also expect them if QTG _DSM is in use as that has specific references
to DMSAS regions.

More generally a switch implementing CDAT wouldn't have DSMAS but
we are fairly safe that if a memory device has CDAT at all, DSMAS is expected
because most of the other structures reference the DSMAS handle.

Message is in general wrong though as it could be a memory failure
in parse_dsmas() so you need to check the actual error code.

J

> 
> Thanks,
> Ira
> 
> > >  	/*
> > >  	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
> > >  	 * needed as this is ordered with cdev_add() publishing the device.
> > > -- 
> > > 2.31.1
> > >   

