Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8F844D08F
	for <lists+linux-pci@lfdr.de>; Thu, 11 Nov 2021 04:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhKKEBO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 10 Nov 2021 23:01:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:28361 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230314AbhKKEBN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 10 Nov 2021 23:01:13 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10164"; a="319043025"
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="319043025"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 19:58:24 -0800
X-IronPort-AV: E=Sophos;i="5.87,225,1631602800"; 
   d="scan'208";a="670107834"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2021 19:58:24 -0800
Date:   Wed, 10 Nov 2021 19:58:24 -0800
From:   Ira Weiny <ira.weiny@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH 5/5] cxl/cdat: Parse out DSMAS data from CDAT table
Message-ID: <20211111035824.GM3538886@iweiny-DESK2.sc.intel.com>
References: <20211105235056.3711389-1-ira.weiny@intel.com>
 <20211105235056.3711389-6-ira.weiny@intel.com>
 <20211108145239.000010a5@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211108145239.000010a5@Huawei.com>
User-Agent: Mutt/1.11.1 (2018-12-01)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Nov 08, 2021 at 02:52:39PM +0000, Jonathan Cameron wrote:
> On Fri, 5 Nov 2021 16:50:56 -0700
> <ira.weiny@intel.com> wrote:
> 
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Parse and cache the DSMAS data from the CDAT table.  Store this data in
> > Unmarshaled data structures for use later.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> A few minor comments inline.  In particular I think we need to conclude if
> failure to parse is an error or not.  Right now it's reported as an error
> but then we carry on anyway.

I report it as an error because if the device supports CDAT I made the
assumption that it was required for something up the stack.  However, I did not
want to make that decision at this point because all this code does is cache
the raw data.

So it may not be a fatal error depending on what the data is used for.  But IMO
it is still and error.

> 
> Jonathan
> 
> > 
> > ---
> > Changes from V4
> > 	New patch
> > ---
> >  drivers/cxl/core/memdev.c | 111 ++++++++++++++++++++++++++++++++++++++
> >  drivers/cxl/cxlmem.h      |  23 ++++++++
> >  2 files changed, 134 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > index c35de9e8298e..e5a2d30a3491 100644
> > --- a/drivers/cxl/core/memdev.c
> > +++ b/drivers/cxl/core/memdev.c
> > @@ -6,6 +6,7 @@
> 
> ...
> 
> > +
> > +static int parse_dsmas(struct cxl_memdev *cxlmd)
> > +{
> > +	struct cxl_dsmas *dsmas_ary = NULL;
> > +	u32 *data = cxlmd->cdat_table;
> > +	int bytes_left = cxlmd->cdat_length;
> > +	int nr_dsmas = 0;
> > +	size_t dsmas_byte_size;
> > +	int rc = 0;
> > +
> > +	if (!data || !cdat_hdr_valid(cxlmd))
> 
> If that's invalid, right answer might be to run it again as we probably
> just raced with an update...  Perhaps try it a couple of times before
> failing hard?

I find it odd that the mailbox would return invalid data even during an update?

That said perhaps validating the header should be done as part of reading the
CDAT.

Thoughts?  Should I push this back to the previous patch?

> 
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
> > +			new_ary = krealloc(dsmas_ary,
> > +					   sizeof(*dsmas_ary) * (nr_dsmas+1),
> 
> Spaces around the +

Sure.

> You could do this with devm_krealloc() and then just assign it at the end
> rather than allocate a new one and copy.

I failed to see that call when I wrote this...  yes thanks!

> 
> 
> > +					   GFP_KERNEL);
> > +			if (!new_ary) {
> > +				dev_err(&cxlmd->dev,
> > +					"Failed to allocate memory for DSMAS data\n");
> > +				rc = -ENOMEM;
> > +				goto free_dsmas;
> > +			}
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
> > +		data += (length/sizeof(u32));
> 
> spaces around /

Yep.

> 

> > +		bytes_left -= length;
> > +	}
> > +
> > +	if (nr_dsmas == 0) {
> > +		rc = -ENXIO;
> > +		goto free_dsmas;
> > +	}
> > +
> > +	dev_dbg(&cxlmd->dev, "Found %d DSMAS entries\n", nr_dsmas);
> > +
> > +	dsmas_byte_size = sizeof(*dsmas_ary) * nr_dsmas;
> > +	cxlmd->dsmas_ary = devm_kzalloc(&cxlmd->dev, dsmas_byte_size, GFP_KERNEL);
> 
> As above, you could have done a devm_krealloc() and then just assigned here.
> Side effect of that being direct returns should be fine.

Yep devm_krealloc is much cleaner.

> However, that relies
> treating an error from this function as an error that will result in failures below.
> 
> 
> > +	if (!cxlmd->dsmas_ary) {
> > +		rc = -ENOMEM;
> > +		goto free_dsmas;
> > +	}
> > +
> > +	memcpy(cxlmd->dsmas_ary, dsmas_ary, dsmas_byte_size);
> > +	cxlmd->nr_dsmas = nr_dsmas;
> > +
> > +free_dsmas:
> > +	kfree(dsmas_ary);
> > +	return rc;
> > +}
> > +
> >  struct cxl_memdev *
> >  devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> >  {
> > @@ -339,6 +446,10 @@ devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> >  		cxl_mem_cdat_read_table(cxlds, cxlmd->cdat_table, cxlmd->cdat_length);
> >  	}
> >  
> > +	rc = parse_dsmas(cxlmd);
> > +	if (rc)
> > +		dev_err(dev, "No DSMAS data found: %d\n", rc);
> 
> dev_info() maybe as it's not being treated as an error?

This is an error.  But not a fatal error.

> 
> However I think it should be treated as an error.  It's a device failure if
> we can't parse this (and table protocol is available)

Shouldn't we let the consumer of this data determine if this is a fatal error and
bail out at that point?

Ira

> 
> If it turns out we need to quirk some devices, then fair enough.
> 
> 
> 
> > +
> >  	/*
> >  	 * Activate ioctl operations, no cxl_memdev_rwsem manipulation
> >  	 * needed as this is ordered with cdev_add() publishing the device.
> 
