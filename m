Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62FEA56189A
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 12:56:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiF3K4p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 06:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiF3K4o (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 06:56:44 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476BF427D3;
        Thu, 30 Jun 2022 03:56:43 -0700 (PDT)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYZxj0mmHz6GD68;
        Thu, 30 Jun 2022 18:55:53 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Thu, 30 Jun 2022 12:56:40 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 11:56:40 +0100
Date:   Thu, 30 Jun 2022 11:56:38 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 08/46] cxl/core: Define a 'struct cxl_switch_decoder'
Message-ID: <20220630115638.000021be@Huawei.com>
In-Reply-To: <20220628171204.00006ad4@Huawei.com>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603875762.551046.12872423961024324769.stgit@dwillia2-xfh>
        <20220628171204.00006ad4@Huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.200.250]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 28 Jun 2022 17:12:04 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Thu, 23 Jun 2022 19:45:57 -0700
> Dan Williams <dan.j.williams@intel.com> wrote:
> 
> > Currently 'struct cxl_decoder' contains the superset of attributes
> > needed for all decoder types. Before more type-specific attributes are
> > added to the common definition, reorganize 'struct cxl_decoder' into type
> > specific objects.
> > 
> > This patch, the first of three, factors out a cxl_switch_decoder type.
> > The 'switch' decoder type represents the decoder instances of cxl_port's
> > that route from the root of a CXL memory decode topology to the
> > endpoints. They come in two flavors, root-level decoders, statically
> > defined by platform firmware, and mid-level decoders, where
> > interleave-granularity, interleave-width, and the target list are
> > mutable.  
> 
> I'd like to see this info on cxl_switch_decoder being used for
> switches AND other stuff as docs next to the definition. It confused
> me when looked directly at the resulting of applying this series
> and made more sense once I read to this patch.
> 
> > 
> > Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> 
> Basic idea is fine, but there are a few places where I think this is
> 'too clever' with error handling and it's worth duplicating a few
> error messages to keep the flow simpler.
> 

follow up on that. I'd missed the kfree(alloc) hiding in plain
sight at the end of the function.



> > @@ -1179,13 +1210,27 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  {
> >  	struct cxl_decoder *cxld;
> >  	struct device *dev;
> > +	void *alloc;
> >  	int rc = 0;
> >  
> >  	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> >  		return ERR_PTR(-EINVAL);
> >  
> > -	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> > -	if (!cxld)
> > +	if (nr_targets) {
> > +		struct cxl_switch_decoder *cxlsd;
> > +
> > +		alloc = kzalloc(struct_size(cxlsd, target, nr_targets), GFP_KERNEL);  
> 
> I'd rather see a local check on the allocation failure even if it adds a few lines
> of duplicated code - which after you've dropped the local alloc variable won't be
> much even after a later patch adds another path in here.  The eventual code
> of this function is more than a little nasty when an early return in each
> path would, as far as I can tell, give the same result without the at least
> 3 null checks prior to returning (to ensure nothing happens before reaching
> the if (!alloc)

clearly not enough caffeine that day as I'd missed the use for unifying
the frees at the end of the function... Just noticed that in a later patch
that touches the error path.

I still don't much like the complexity of the flow, but can see why you did it
this way now.



> 
> 
> 
> 
> 		cxlsd = kzalloc()
> 		if (!cxlsd)
> 			return ERR_PTR(-ENOMEM);
> 
> 		cxlsd->nr_targets = nr_targets;
> 		seqlock_init(...)
> 
> 	} else {
> 		cxld = kzalloc(sizerof(*cxld), GFP_KERNEL);
> 		if (!cxld)
> 			return ERR_PTR(-ENOMEM);
> 
> > +		cxlsd = alloc;
> > +		if (cxlsd) {
> > +			cxlsd->nr_targets = nr_targets;
> > +			seqlock_init(&cxlsd->target_lock);
> > +			cxld = &cxlsd->cxld;
> > +		}
> > +	} else {
> > +		alloc = kzalloc(sizeof(*cxld), GFP_KERNEL);
> > +		cxld = alloc;
> > +	}
> > +	if (!alloc)
> >  		return ERR_PTR(-ENOMEM);
> >  
> >  	rc = ida_alloc(&port->decoder_ida, GFP_KERNEL);
> > @@ -1196,8 +1241,6 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  	get_device(&port->dev);
> >  	cxld->id = rc;
> >  
> > -	cxld->nr_targets = nr_targets;
> > -	seqlock_init(&cxld->target_lock);
> >  	dev = &cxld->dev;
> >  	device_initialize(dev);
> >  	lockdep_set_class(&dev->mutex, &cxl_decoder_key);
> > @@ -1222,7 +1265,7 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  
> >  	return cxld;
> >  err:
> > -	kfree(cxld);
> > +	kfree(alloc);
> >  	return ERR_PTR(rc);
> >  }
