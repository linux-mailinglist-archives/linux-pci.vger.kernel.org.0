Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D6A4A99D5
	for <lists+linux-pci@lfdr.de>; Fri,  4 Feb 2022 14:20:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354433AbiBDNUX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Feb 2022 08:20:23 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4673 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353696AbiBDNUV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 4 Feb 2022 08:20:21 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jqx326Zlwz67k2V;
        Fri,  4 Feb 2022 21:19:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Fri, 4 Feb 2022 14:20:19 +0100
Received: from localhost (10.47.31.86) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Fri, 4 Feb
 2022 13:20:18 +0000
Date:   Fri, 4 Feb 2022 13:20:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     Ben Widawsky <ben.widawsky@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH V6 09/10] cxl/mem: Retry reading CDAT on failure
Message-ID: <20220204132015.00006443@Huawei.com>
In-Reply-To: <20220201223159.GQ785175@iweiny-DESK2.sc.intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
        <20220201071952.900068-10-ira.weiny@intel.com>
        <20220201185928.ffdgvnn6mcmo7by7@intel.com>
        <20220201223159.GQ785175@iweiny-DESK2.sc.intel.com>
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

On Tue, 1 Feb 2022 14:31:59 -0800
Ira Weiny <ira.weiny@intel.com> wrote:

> On Tue, Feb 01, 2022 at 10:59:28AM -0800, Widawsky, Ben wrote:
> > On 22-01-31 23:19:51, ira.weiny@intel.com wrote:  
> > > From: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > The CDAT read may fail for a number of reasons but mainly it is possible
> > > to get different parts of a valid state.  The checksum in the CDAT table
> > > protects against this.
> > > 
> > > Now that the checksum is validated issue a retry if the CDAT read fails.
> > > For now 2 retries are implemented.
> > > 
> > > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > > 
> > > ---
> > > NOTE: Is 2 enough?  Should this just be delayed until the time when the
> > > data is actually needed and not there?  
> > 
> > I can't speak to retries at all, but one small issue below. It might make sense
> > if we keep this to make it a modparam.  
> 
> Not a bad idea.

Ah. Here is the retry - I should have read the rest of the thread :)

This whole cycle isn't in a hot path and is fairly cheap. I'd just
go with c. 5 and assume that is enough for anyone.  If we need a module
parameter later because this race turns out to be something that
actually happens then it is easy enough to add then.




> 
> >   
> > > 
> > > Changes from V5:
> > > 	New patch -- easy to push off or drop.
> > > ---
> > >  drivers/cxl/core/memdev.c | 17 ++++++++++++++++-
> > >  1 file changed, 16 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> > > index a01068e98333..11d721c56f08 100644
> > > --- a/drivers/cxl/core/memdev.c
> > > +++ b/drivers/cxl/core/memdev.c
> > > @@ -356,7 +356,8 @@ static const struct file_operations cxl_memdev_fops = {
> > >  	.llseek = noop_llseek,
> > >  };
> > >  
> > > -static int read_cdat_data(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
> > > +static int __read_cdat_data(struct cxl_memdev *cxlmd,
> > > +			    struct cxl_dev_state *cxlds)
> > >  {
> > >  	struct device *dev = &cxlmd->dev;
> > >  	size_t cdat_length;
> > > @@ -371,6 +372,20 @@ static int read_cdat_data(struct cxl_memdev *cxlmd, struct cxl_dev_state *cxlds)
> > >  	return cxl_mem_cdat_read_table(cxlds, &cxlmd->cdat);
> > >  }
> > >  
> > > +static int read_cdat_data(struct cxl_memdev *cxlmd,
> > > +			  struct cxl_dev_state *cxlds)
> > > +{
> > > +	int retries = 2;
> > > +	int rc;
> > > +
> > > +	while (--retries) {  
> > 
> > You either want retries--, or retries = 3...  
> 
> Opps yea.
> 
> Thanks,
> Ira
> 
> >   
> > > +		rc = __read_cdat_data(cxlmd, cxlds);
> > > +		if (!rc)
> > > +			break;
> > > +	}
> > > +	return rc;
> > > +}
> > > +
> > >  struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
> > >  {
> > >  	struct cxl_memdev *cxlmd;
> > > -- 
> > > 2.31.1
> > >   

