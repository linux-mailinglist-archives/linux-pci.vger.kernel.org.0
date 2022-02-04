Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359514A99CB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 14:17:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241636AbiBDNRp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 08:17:45 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4672 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbiBDNRp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 08:17:45 -0500
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jqx015Hssz67dLY;
        Fri,  4 Feb 2022 21:17:05 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 14:17:41 +0100
Received: from localhost (10.47.31.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Feb
 2022 13:17:41 +0000
Date:   Fri, 4 Feb 2022 13:17:38 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 08/10] cxl/cdat: Introduce cdat_hdr_valid()
Message-ID: <20220204131738.00004acf@Huawei.com>
In-Reply-To: <20220201222903.GP785175@iweiny-DESK2.sc.intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
        <20220201071952.900068-9-ira.weiny@intel.com>
        <20220201185640.4kc5v66vsxd3cial@intel.com>
        <20220201222903.GP785175@iweiny-DESK2.sc.intel.com>
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

On Tue, 1 Feb 2022 14:29:03 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Feb 01, 2022 at 10:56:40AM -0800, Widawsky, Ben wrote:
> > On 22-01-31 23:19:50, ira.weiny@intel.com wrote:  
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The CDAT data is protected by a checksum which should be checked when
> > > the CDAT is read to ensure it is valid.  In addition the lengths
> > > specified should be checked.
> > > 
> > > Introduce cdat_hdr_valid() to check the checksum.  While at it check and
> > > store the sequence number.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > > Changes from V5
> > > 	New patch, split out
> > > 	Update cdat_hdr_valid()
> > > 		Remove revision and cs field parsing
> > > 			There is no point in these
> > > 		Add seq check and debug print.
> > > ---
> > >  drivers/cxl/cdat.h |  2 ++
> > >  drivers/cxl/pci.c  | 32 ++++++++++++++++++++++++++++++++
> > >  2 files changed, 34 insertions(+)
> > > 
> > > diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
> > > index 4722b6bbbaf0..a7725d26f2d2 100644
> > > --- a/drivers/cxl/cdat.h
> > > +++ b/drivers/cxl/cdat.h
> > > @@ -88,10 +88,12 @@
> > >   *
> > >   * @table: cache of CDAT table
> > >   * @length: length of cached CDAT table
> > > + * @seq: Last read Sequence number of the CDAT table
> > >   */
> > >  struct cxl_cdat {
> > >  	void *table;
> > >  	size_t length;
> > > +	u32 seq;
> > >  };
> > >  
> > >  #endif /* !__CXL_CDAT_H__ */
> > > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > > index 28b973a9e29e..c362c75feed2 100644
> > > --- a/drivers/cxl/pci.c
> > > +++ b/drivers/cxl/pci.c
> > > @@ -586,6 +586,35 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
> > >  	return 0;
> > >  }
> > >  
> > > +static bool cxl_cdat_hdr_valid(struct device *dev, struct cxl_cdat *cdat)
> > > +{
> > > +	u32 *table = cdat->table;
> > > +	u8 *data8 = cdat->table;
> > > +	u32 length, seq;
> > > +	u8 check;
> > > +	int i;
> > > +
> > > +	length = FIELD_GET(CDAT_HEADER_DW0_LENGTH, table[0]);
> > > +	if (length < CDAT_HEADER_LENGTH_BYTES)
> > > +		return false;
> > > +
> > > +	if (length > cdat->length)
> > > +		return false;
> > > +
> > > +	seq = FIELD_GET(CDAT_HEADER_DW3_SEQUENCE, table[3]);
> > > +
> > > +	/* Store the sequence for now. */
> > > +	if (cdat->seq != seq) {
> > > +		dev_info(dev, "CDAT seq change %x -> %x\n", cdat->seq, seq);
> > > +		cdat->seq = seq;
> > > +	}  
> > 
> > If sequence hasn't changed you could short-circuit the checksum.  
> 
> I'm not sure.  Jonathan mentioned that reading may race with updates and that
> the correct thing to do is re-read.[1]

As things stand I 'think' a failure of the checksum on a previous run wouldn't
mean we didn't store the sequence number.

Now we only call this once at the moment so that doesn't matter yet..

If on each call we rerun to hopefully get an update after the race with
a good checksum / sequence number and don't store it on failure to validate
then we could indeed just use the sequence check to skip the checksum validation.
Mind you this isn't a hot path... Do we really care? 


> 
> But I should probably check the CS first...
> 
> Ira
> 
> [1] https://lore.kernel.org/linux-cxl/20211108145239.000010a5@Huawei.com/
> 
> >   
> > > +
> > > +	for (check = 0, i = 0; i < length; i++)
> > > +		check += data8[i];
> > > +
> > > +	return check == 0;
> > > +}
> > > +
> > >  #define CDAT_DOE_REQ(entry_handle)					\
> > >  	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
> > >  		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
> > > @@ -658,6 +687,9 @@ static int cxl_cdat_read_table(struct cxl_dev_state *cxlds,
> > >  
> > >  	} while (entry_handle != 0xFFFF);
> > >  
> > > +	if (!cxl_cdat_hdr_valid(cxlds->dev, cdat))
> > > +		return -EIO;
> > > +
> > >  	return 0;
> > >  }
> > >  
> > > -- 
> > > 2.31.1
> > >   

