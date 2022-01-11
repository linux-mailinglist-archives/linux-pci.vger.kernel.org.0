Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5F6948B9B1
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 22:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245339AbiAKVcM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 16:32:12 -0500
Received: from mga07.intel.com ([134.134.136.100]:23573 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245377AbiAKVcL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jan 2022 16:32:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641936731; x=1673472731;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8KiDPEBXN3DIxu+tbJkTbCrX/h+9tD/s/wCwvZ89tvE=;
  b=Y3BItdXyG8dh3XwsPSUIT9bc58LsYBTtcotSE3srBiA18T+WfgH7JOJa
   62+oktM8lhItjFD4+OKnCBB6gAkWJXDUB6ieY/ho6ARlBbVuF/vGoyo+8
   EK1HFwq1kvCNUN0yxNLG05bly0iViuGShBsWaAnrL3H2RH91jikq680xt
   ZWOIlUG+79oHYk6XsGiyHwz3TboT9NRJf9jd2p/sVwRgmiWIdkgxacJzG
   P+gOJahW4PE7js9c0Ru4G42+d3jrKjQXcKGwFrTuyfzl4VstU4mzoHSjs
   hQD3j4VJd5rcI7bvf8wsxFvp98AiJWUIvhAsg2pZAGemFYhLDNbcGgk9a
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="306940203"
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="306940203"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 13:32:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,279,1635231600"; 
   d="scan'208";a="762659909"
Received: from zedchen-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.139.117])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 13:32:09 -0800
Date:   Tue, 11 Jan 2022 13:32:08 -0800
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
Message-ID: <20220111213208.k6e4kxity2j2zciw@intel.com>
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
> 
> > >    
> 

Gotcha. I combined the idx increment as well, what do you think about this (just
typed, not tested):

#define for_each_cxl_decoder_target(dport, decoder, idx)                      \
        for (idx = 0, dport = (decoder)->target[idx];                         \
             idx < (decoder)->nr_targets;                                     \
             dport = (decoder)->target[++idx])
