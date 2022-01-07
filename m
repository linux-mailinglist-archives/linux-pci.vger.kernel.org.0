Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D6244875C3
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 11:38:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346832AbiAGKix (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 05:38:53 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4367 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237776AbiAGKib (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 05:38:31 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JVfhF33xyz67vrB;
        Fri,  7 Jan 2022 18:33:33 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 11:38:29 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 10:38:28 +0000
Date:   Fri, 7 Jan 2022 10:38:27 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 09/13] cxl/region: Implement XHB verification
Message-ID: <20220107103827.00006e4c@huawei.com>
In-Reply-To: <20220107103052.00006c4b@huawei.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
        <20220107003756.806582-10-ben.widawsky@intel.com>
        <20220107103052.00006c4b@huawei.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 7 Jan 2022 10:30:52 +0000
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> On Thu,  6 Jan 2022 16:37:52 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > Cross host bridge verification primarily determines if the requested
> > interleave ordering can be achieved by the root decoder, which isn't as
> > programmable as other decoders.
> > 
> > The algorithm implemented here is based on the CXL Type 3 Memory Device
> > Software Guide, chapter 2.13.14
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> 
> Trivial thing inline.
> 
> > diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> > index c8e3c48dfbb9..ca559a4b5347 100644
> > --- a/drivers/cxl/region.c
> > +++ b/drivers/cxl/region.c
> > @@ -28,6 +28,17 @@
> >   */
> >  
> >  #define region_ways(region) ((region)->config.eniw)
> > +#define region_ig(region) (ilog2((region)->config.ig))
> > +
> > +#define for_each_cxl_endpoint(ep, region, idx)                                 \
> > +	for (idx = 0, ep = (region)->config.targets[idx];                      \
> > +	     idx < region_ways(region);                                        \
> > +	     idx++, ep = (region)->config.targets[idx])
> > +
> > +#define for_each_cxl_decoder_target(target, decoder, idx)                      \
> > +	for (idx = 0, target = (decoder)->target[idx];                         \  
> 
> As target is used too often in here, you'll replace it in ->target[idx] as well.
> It happens to work today because the parameter always happens to be target
> 
> > +	     idx < (decoder)->nr_targets;                                      \
> > +	     idx++, target++)
I should have read the next few lines :)

target++ doesn't get (decoder)->target[idx] which is what we want - it indexes
off the end of a particular instance rather than through the array.

I'm guessing this was from my unclear comment yesterday. I should have spent
a little more time being explicit there.

Jonathan

> >    

