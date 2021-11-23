Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04E245A0DF
	for <lists+linux-pci@lfdr.de>; Tue, 23 Nov 2021 12:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbhKWLJH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 23 Nov 2021 06:09:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4153 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234312AbhKWLJG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 23 Nov 2021 06:09:06 -0500
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Hz1Rw0164z67Ml8;
        Tue, 23 Nov 2021 19:02:03 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 23 Nov 2021 12:05:56 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Tue, 23 Nov
 2021 11:05:55 +0000
Date:   Tue, 23 Nov 2021 11:05:53 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 13/23] cxl/core: Move target population locking to
 caller
Message-ID: <20211123110553.00001e2b@Huawei.com>
In-Reply-To: <20211122215801.gshai367q2fhp6uj@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-14-ben.widawsky@intel.com>
        <20211122163302.00005ae9@Huawei.com>
        <20211122215801.gshai367q2fhp6uj@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 22 Nov 2021 13:58:01 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> On 21-11-22 16:33:02, Jonathan Cameron wrote:
> > On Fri, 19 Nov 2021 16:02:40 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> >   
> > > In preparation for a port driver that enumerates a descendant port +
> > > decoder hierarchy, arrange for an unlocked version of cxl_decoder_add().
> > > Otherwise a port-driver that adds a child decoder will deadlock on the
> > > device_lock() in ->probe().
> > >   
> > 
> > I think this description should call out that the lock was originally taken
> > for a much shorter time in decoder_populate_targets() but is moved
> > up one layer.  
> 
> Sounds good.
With that added and below discussion resolved.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> > 
> > One other query inline.  Seems like we the WARN_ON stuff is a bit
> > over paranoid given what's visible in this patch.  If there is a
> > good reason for that, then add something to the patch description to
> > justify it.
> >    
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > 
> > > ---
> > > 
> > > Changes since RFCv2:
> > > - Reword commit message (Dan)
> > > - Move decoder API changes into this patch (Dan)
> > > ---
> > >  drivers/cxl/core/bus.c | 59 +++++++++++++++++++++++++++++++-----------
> > >  drivers/cxl/cxl.h      |  1 +
> > >  2 files changed, 45 insertions(+), 15 deletions(-)
> > > 
> > > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > > index 16b15f54fb62..cd6fe7823c69 100644
> > > --- a/drivers/cxl/core/bus.c
> > > +++ b/drivers/cxl/core/bus.c
> > > @@ -487,28 +487,22 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
> > >  {
> > >  	int rc = 0, i;
> > >  
> > > +	device_lock_assert(&port->dev);
> > > +
> > >  	if (!target_map)
> > >  		return 0;
> > >  
> > > -	device_lock(&port->dev);
> > > -	if (list_empty(&port->dports)) {
> > > -		rc = -EINVAL;
> > > -		goto out_unlock;
> > > -	}
> > > +	if (list_empty(&port->dports))
> > > +		return -EINVAL;
> > >  
> > >  	for (i = 0; i < cxld->nr_targets; i++) {
> > >  		struct cxl_dport *dport = find_dport(port, target_map[i]);
> > >  
> > > -		if (!dport) {
> > > -			rc = -ENXIO;
> > > -			goto out_unlock;
> > > -		}
> > > +		if (!dport)
> > > +			return -ENXIO;
> > >  		cxld->target[i] = dport;
> > >  	}
> > >  
> > > -out_unlock:
> > > -	device_unlock(&port->dev);
> > > -
> > >  	return rc;
> > >  }
> > >  
> > > @@ -571,7 +565,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> > >  EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
> > >  
> > >  /**
> > > - * cxl_decoder_add - Add a decoder with targets
> > > + * cxl_decoder_add_locked - Add a decoder with targets
> > >   * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> > >   * @target_map: A list of downstream ports that this decoder can direct memory
> > >   *              traffic to. These numbers should correspond with the port number
> > > @@ -581,12 +575,14 @@ EXPORT_SYMBOL_NS_GPL(cxl_decoder_alloc, CXL);
> > >   * is an endpoint device. A more awkward example is a hostbridge whose root
> > >   * ports get hot added (technically possible, though unlikely).
> > >   *
> > > - * Context: Process context. Takes and releases the cxld's device lock.
> > > + * This is the locked variant of cxl_decoder_add().
> > > + *
> > > + * Context: Process context. Expects the cxld's device lock to be held.
> > >   *
> > >   * Return: Negative error code if the decoder wasn't properly configured; else
> > >   *	   returns 0.
> > >   */
> > > -int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
> > > +int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
> > >  {
> > >  	struct cxl_port *port;
> > >  	struct device *dev;
> > > @@ -619,6 +615,39 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
> > >  
> > >  	return device_add(dev);
> > >  }
> > > +EXPORT_SYMBOL_NS_GPL(cxl_decoder_add_locked, CXL);
> > > +
> > > +/**
> > > + * cxl_decoder_add - Add a decoder with targets
> > > + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> > > + * @target_map: A list of downstream ports that this decoder can direct memory
> > > + *              traffic to. These numbers should correspond with the port number
> > > + *              in the PCIe Link Capabilities structure.
> > > + *
> > > + * This is the unlocked variant of cxl_decoder_add_locked().
> > > + * See cxl_decoder_add_locked().
> > > + *
> > > + * Context: Process context. Takes and releases the cxld's device lock.
> > > + */
> > > +int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
> > > +{
> > > +	struct cxl_port *port;
> > > +	int rc;
> > > +
> > > +	if (WARN_ON_ONCE(!cxld))
> > > +		return -EINVAL;  
> > 
> > Why do we now need these protections but didn't before?  
> 
> I don't quite understand what you're trying to point out.
> 
> Prior to this patch, cxl_decoder_add() checks:
> - !cxld
> - IS_ERR(cxld)
> - cxld->interleave_ways != 0
> 
> After this patch, cxl_decoder_add() checks:
> - !cxld
> - IS_ERR(cxld)
> - (and then calls cxl_decoder_add_locked())
> 
> And cxl_decoder_add_locked() checks:
> - !cxld
> - IS_ERR(cxld)
> - cxld->interleave_ways != 0
> 
> Ultimately we want to check all 3, and since cxl_decoder_add() calls
> cxl_decoder_add_locked(), we're good there. The problem is to get from a cxld to
> a port, you need to make sure you have a valid cxld, and the API previously
> allowed !cxld and IS_ERR(cxld). So there are duplicative checks if you call
> cxl_decoder_add(), but other than that I don't see any new protections.

Ah. It was the duplication that I didn't follow.

Fair enough

J
> 
> > 
> >   
> > > +
> > > +	if (WARN_ON_ONCE(IS_ERR(cxld)))
> > > +		return PTR_ERR(cxld);
> > > +
> > > +	port = to_cxl_port(cxld->dev.parent);
> > > +
> > > +	device_lock(&port->dev);
> > > +	rc = cxl_decoder_add_locked(cxld, target_map);
> > > +	device_unlock(&port->dev);
> > > +
> > > +	return rc;
> > > +}
> > >  EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
> > >  
> > >  static void cxld_unregister(void *dev)
> > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > index b66ed8f241c6..2c5627fa8a34 100644
> > > --- a/drivers/cxl/cxl.h
> > > +++ b/drivers/cxl/cxl.h
> > > @@ -290,6 +290,7 @@ struct cxl_decoder *to_cxl_decoder(struct device *dev);
> > >  bool is_root_decoder(struct device *dev);
> > >  struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> > >  				      unsigned int nr_targets);
> > > +int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
> > >  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> > >  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
> > >    
> >   

