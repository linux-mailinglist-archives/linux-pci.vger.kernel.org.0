Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 696B7487A62
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 17:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240150AbiAGQcb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 11:32:31 -0500
Received: from mga04.intel.com ([192.55.52.120]:27278 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239847AbiAGQc3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jan 2022 11:32:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641573148; x=1673109148;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YXyhi7jWupoTDySA3DCVw1DwpBEsMEZGa9+qIrGsldw=;
  b=oGUW4XXgq0uEFSc5FbR1iUbrAqSBQvmd8zFV8X36RPasGWr8KAqF3OeJ
   dvt/4fTHYWw7iCPkU9I+UfsKKBZIK1LbKvqsvHULOes54toxscmXGPuxd
   SZLiM0MvqG0uco49XUcSwefm7f79YqLJ24QUS61BZG1YA8E1ob3Iv+Feg
   DrT+q/sDKjNKf8lBHVVjcHiE/RjJFED6oCycDjjmPg/V9g0VmBEvSlX5S
   wSSTkhOTfymlb9Kydd0Xgzzjq4EQ+c5oKdf5zdn19wwFg52lpblA+CaSC
   sLPhegYgQi0aZJUVwMmZ6yoyFNCZ/oDWBBTGoKc53LJbLQR6OM1iJKFaJ
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10219"; a="241707538"
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="241707538"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 08:32:28 -0800
X-IronPort-AV: E=Sophos;i="5.88,270,1635231600"; 
   d="scan'208";a="621962441"
Received: from njclifto-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.135.14])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 08:32:27 -0800
Date:   Fri, 7 Jan 2022 08:32:26 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, patches@lists.linux.dev,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 09/13] cxl/region: Implement XHB verification
Message-ID: <20220107163226.cdqqylscu4qvcqly@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
 <20220107003756.806582-10-ben.widawsky@intel.com>
 <20220107103052.00006c4b@huawei.com>
 <20220107103827.00006e4c@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107103827.00006e4c@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-07 10:38:27, Jonathan Cameron wrote:
> On Fri, 7 Jan 2022 10:30:52 +0000
> Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> 
> > On Thu,  6 Jan 2022 16:37:52 -0800
> > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > 
> > > Cross host bridge verification primarily determines if the requested
> > > interleave ordering can be achieved by the root decoder, which isn't as
> > > programmable as other decoders.
> > > 
> > > The algorithm implemented here is based on the CXL Type 3 Memory Device
> > > Software Guide, chapter 2.13.14
> > > 
> > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>  
> > 
> > Trivial thing inline.
> > 
> > > diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> > > index c8e3c48dfbb9..ca559a4b5347 100644
> > > --- a/drivers/cxl/region.c
> > > +++ b/drivers/cxl/region.c
> > > @@ -28,6 +28,17 @@
> > >   */
> > >  
> > >  #define region_ways(region) ((region)->config.eniw)
> > > +#define region_ig(region) (ilog2((region)->config.ig))
> > > +
> > > +#define for_each_cxl_endpoint(ep, region, idx)                                 \
> > > +	for (idx = 0, ep = (region)->config.targets[idx];                      \
> > > +	     idx < region_ways(region);                                        \
> > > +	     idx++, ep = (region)->config.targets[idx])
> > > +
> > > +#define for_each_cxl_decoder_target(target, decoder, idx)                      \
> > > +	for (idx = 0, target = (decoder)->target[idx];                         \  
> > 
> > As target is used too often in here, you'll replace it in ->target[idx] as well.
> > It happens to work today because the parameter always happens to be target
> > 
> > > +	     idx < (decoder)->nr_targets;                                      \
> > > +	     idx++, target++)
> I should have read the next few lines :)
> 
> target++ doesn't get (decoder)->target[idx] which is what we want - it indexes
> off the end of a particular instance rather than through the array.
> 
> I'm guessing this was from my unclear comment yesterday. I should have spent
> a little more time being explicit there.
> 
> Jonathan

Yeah. I was working quickly because I ended up losing childcare for this week
and wanted to get this out ASAP. I'll fix it up on the next round.

> 
> > >    
> 
