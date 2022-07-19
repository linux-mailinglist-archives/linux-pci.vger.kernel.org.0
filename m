Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 479AA57A222
	for <lists+linux-pci@lfdr.de>; Tue, 19 Jul 2022 16:47:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232884AbiGSOrY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 19 Jul 2022 10:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236217AbiGSOrX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 19 Jul 2022 10:47:23 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CABEAC;
        Tue, 19 Jul 2022 07:47:22 -0700 (PDT)
Received: from fraeml738-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LnM822Ntyz67kvY;
        Tue, 19 Jul 2022 22:45:38 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml738-chm.china.huawei.com (10.206.15.219) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 19 Jul 2022 16:47:20 +0200
Received: from localhost (10.81.209.49) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 19 Jul
 2022 15:47:20 +0100
Date:   Tue, 19 Jul 2022 15:47:18 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 36/46] cxl/region: Add interleave ways attribute
Message-ID: <20220719154718.000077ec@Huawei.com>
In-Reply-To: <62cb6f9a74b33_3535162944e@dwillia2-xfh.notmuch>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-11-dan.j.williams@intel.com>
        <20220630144420.000005b5@Huawei.com>
        <62cb6f9a74b33_3535162944e@dwillia2-xfh.notmuch>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.209.49]
X-ClientProxiedBy: lhreml749-chm.china.huawei.com (10.201.108.199) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 10 Jul 2022 17:32:26 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Jonathan Cameron wrote:
> > On Thu, 23 Jun 2022 21:19:40 -0700
> > Dan Williams <dan.j.williams@intel.com> wrote:
> >   
> > > From: Ben Widawsky <bwidawsk@kernel.org>
> > > 
> > > Add an ABI to allow the number of devices that comprise a region to be
> > > set.  
> > 
> > Should at least mention interleave_granularity is being added as well!  
> 
> Added.
> 
> >   
> > > 
> > > Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> > > [djbw: reword changelog]
> > > Signed-off-by: Dan Williams <dan.j.williams@intel.com>  
> > 
> > Random diversion inline...
> >   
> > > ---
> > >  Documentation/ABI/testing/sysfs-bus-cxl |  21 ++++
> > >  drivers/cxl/core/region.c               | 128 ++++++++++++++++++++++++
> > >  drivers/cxl/cxl.h                       |  33 ++++++
> > >  3 files changed, 182 insertions(+)  
> >   
> > > diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> > > index f75978f846b9..78af42454760 100644
> > > --- a/drivers/cxl/core/region.c
> > > +++ b/drivers/cxl/core/region.c
> > > @@ -7,6 +7,7 @@  
> > 
> >   
> > > +static ssize_t interleave_granularity_store(struct device *dev,
> > > +					    struct device_attribute *attr,
> > > +					    const char *buf, size_t len)
> > > +{
> > > +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(dev->parent);
> > > +	struct cxl_decoder *cxld = &cxlrd->cxlsd.cxld;
> > > +	struct cxl_region *cxlr = to_cxl_region(dev);
> > > +	struct cxl_region_params *p = &cxlr->params;
> > > +	int rc, val;
> > > +	u16 ig;
> > > +
> > > +	rc = kstrtoint(buf, 0, &val);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	rc = granularity_to_cxl(val, &ig);
> > > +	if (rc)
> > > +		return rc;
> > > +
> > > +	/* region granularity must be >= root granularity */  
> > 
> > In general I think that's an implementation choice.  Sure today
> > we only support it this way, but it's perfectly possible to build
> > setups where that's not the case.  
> 
> If the region granularity is smaller than the host bridge interleave
> granularity it means that multiple devices per host bridge are needed to
> satsify a single "slot" in the interleave. Valid? Yes. Useful for Linux
> to support, not clear.

True.  Wait and see on this one makes sense to me. I only noticed because
my older test scripts (against hacks on top of Ben's code) were broken as
I did it the silly way :)

> 
> > Maybe the comment should say that this code goes with an
> > implementation choice inline with the software guide (that argues you
> > will always prefer small ig for interleaving at the host to make best
> > use of bandwidth etc).  
> 
> No, I would prefer that as far as the Linux implementation is concerned
> the software-guide does not exist. In the sense that the Linux
> implementation choices supersede and are otherwise a superset of what
> the guide recommends.

ah. I phrased that badly. I just meant lift the argument as a comment rather
than a cross reference.

> 
> Also, for the same reason that the code does not anticipate future
> implementation possibilities, neither should the comments. It is
> sufficient to just change this comment when / if the implemetation stops
> expecting region granularity >= root granularity.
> 
> > Interestingly the code I was previously testing QEMU with
> > allowed that option (might have been only option that worked).
> > That code was a mixture of Ben's earlier version and my own hacks.
> > It probably doesn't make sense to support other ways of picking
> > the interleaving granularity until / if we ever get a request
> > to do so. 
> > 
> > I think it results in a different device ordering.
> > 
> > Ordering with this
> > 
> >     Host
> >      | 4k
> >     / \
> >    /   \  
> >   HB   HB  8k
> >   |     |
> >  / \   / \
> > 0  2   1  3
> > 
> > Ordering with Larger granularity CFMWS over finer granularity HB
> > 
> >     Host
> >      | 8k
> >     / \
> >    /   \ 
> >   HB   HB 4k
> >   |     |
> >  / \   / \
> > 0  1   2  3
> > 
> > Not clear why you'd do the second one though :)  So can ignore for now.  
> 
> All I can think of is "ZOMG! My platform failed and the only one I have
> to recover my data has HB interleaves with larger granularity than my
> failed system!". Otherwise, I expect cross-platform CXL persistent
> memory recovery to be so rare as to not need to spend time too much time
> worrying about it now. It seems a straightforward constraint to lift at
> a later date without any risk to breaking the ABI.

It was cross platform that I was thinking but you make a fair point that
it is unlikely to occur that often.  + If another OS want's to do it wrong
that's their problem :)

J
