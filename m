Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A6E48BAED
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 23:47:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231574AbiAKWrt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 11 Jan 2022 17:47:49 -0500
Received: from mga09.intel.com ([134.134.136.24]:33716 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230248AbiAKWrs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 11 Jan 2022 17:47:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641941268; x=1673477268;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=LsfPa2o7Q+vpSqVmm7FQAFi1coP/UQNAj7eSPlGJbSM=;
  b=jo6l8DIMJgfzGcBpqZYpZIw+a5d1bMfwHU+X/AzxP5c0OW9232948itD
   ANwtYS05hW6pVl13dHAYm3A3pfiRNxl9b0e65CYCCA1FRtln3kB/z61Vc
   sIZ5Kb+/O/lCHW13rzCXAroTTH9JeTe7r4FHjAlDdQMM+cSn86xVgDuLL
   kR98VDwj7N1QWdpxCUTetkUc7Xokr8nZEUxBXDS/paCGpGW/jFf0CRM7K
   v00omkV/QY2OaqjuoO20y3VXL7aBLr8w8f7s/1/u1Y9QwQW38fOmCa2Rn
   NAA17C+IP/ZUJQ5RYZalhncfb1EB3yvH0aDHNxqajYXy0iggbaEMTWFIi
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10224"; a="243399529"
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="243399529"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 14:47:47 -0800
X-IronPort-AV: E=Sophos;i="5.88,281,1635231600"; 
   d="scan'208";a="762682053"
Received: from zedchen-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.139.117])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2022 14:47:46 -0800
Date:   Tue, 11 Jan 2022 14:47:45 -0800
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
Message-ID: <20220111224745.uji3y3zbycdpj2cm@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
 <20220107003756.806582-10-ben.widawsky@intel.com>
 <20220107100714.00004461@Huawei.com>
 <20220107115524.0000344a@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107115524.0000344a@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-07 11:55:24, Jonathan Cameron wrote:
> On Fri, 7 Jan 2022 10:07:14 +0000
> Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:
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
> > Hi Ben,
> > 
> > A few things I'm carrying 'fixes' for in here.
> > 
> > Jonathan
> > 
> > > ---
> > >  .clang-format        |  2 +
> > >  drivers/cxl/region.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
> > >  drivers/cxl/trace.h  |  3 ++
> > >  3 files changed, 93 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/.clang-format b/.clang-format
> > > index 15d4eaabc6b5..55f628f21722 100644
> > > --- a/.clang-format
> > > +++ b/.clang-format
> > > @@ -169,6 +169,8 @@ ForEachMacros:
> > >    - 'for_each_cpu_and'
> > >    - 'for_each_cpu_not'
> > >    - 'for_each_cpu_wrap'
> > > +  - 'for_each_cxl_decoder_target'
> > > +  - 'for_each_cxl_endpoint'
> > >    - 'for_each_dapm_widgets'
> > >    - 'for_each_dev_addr'
> > >    - 'for_each_dev_scope'
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
> > > +	     idx < (decoder)->nr_targets;                                      \
> > > +	     idx++, target++)
> > >  
> > >  static struct cxl_decoder *rootd_from_region(struct cxl_region *r)
> > >  {
> > > @@ -175,6 +186,30 @@ static bool qtg_match(const struct cxl_decoder *rootd,
> > >  	return true;
> > >  }
> > >  
> > > +static int get_unique_hostbridges(const struct cxl_region *region,
> > > +				  struct cxl_port **hbs)
> > > +{
> > > +	struct cxl_memdev *ep;
> > > +	int i, hb_count = 0;
> > > +
> > > +	for_each_cxl_endpoint(ep, region, i) {
> > > +		struct cxl_port *hb = get_hostbridge(ep);
> > > +		bool found = false;
> > > +		int j;
> > > +
> > > +		BUG_ON(!hb);
> > > +
> > > +		for (j = 0; j < hb_count; j++) {
> > > +			if (hbs[j] == hb)
> > > +				found = true;
> > > +		}
> > > +		if (!found)
> > > +			hbs[hb_count++] = hb;
> > > +	}
> > > +
> > > +	return hb_count;
> > > +}
> > > +
> > >  /**
> > >   * region_xhb_config_valid() - determine cross host bridge validity
> > >   * @rootd: The root decoder to check against
> > > @@ -188,7 +223,59 @@ static bool qtg_match(const struct cxl_decoder *rootd,
> > >  static bool region_xhb_config_valid(const struct cxl_region *region,
> > >  				    const struct cxl_decoder *rootd)
> > >  {
> > > -	/* TODO: */
> > > +	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
> > > +	int rootd_ig, i;
> > > +	struct cxl_dport *target;
> > > +
> > > +	/* Are all devices in this region on the same CXL host bridge */
> > > +	if (get_unique_hostbridges(region, hbs) == 1)
> > > +		return true;
> > > +
> > > +	rootd_ig = rootd->interleave_granularity;
> > > +
> > > +	/* CFMWS.HBIG >= Device.Label.IG */
> > > +	if (rootd_ig < region_ig(region)) {
> > > +		trace_xhb_valid(region,
> > > +				"granularity does not support the region interleave granularity\n");
> > > +		return false;
> > > +	}
> > > +
> > > +	/* ((2^(CFMWS.HBIG - Device.RLabel.IG) * (2^CFMWS.ENIW)) > Device.RLabel.NLabel) */
> > > +	if (1 << (rootd_ig - region_ig(region)) * (1 << rootd->interleave_ways) >  
> > 
> > This maths isn't what the comment says it is.
> > ((1 << (rootd_ig - region_ig(region))) * rootd->interleaveways)
> > so brackets needed to avoid 2^( all the rest) and rootd->interleave_ways seems to the
> > actual number of ways not the log2 of it.
> > 
> > That feeds through below.

You're correct on both counts. Nice catch.

> > 
> > 
> > > +	    region_ways(region)) {
> > > +		trace_xhb_valid(region,
> > > +				"granularity to device granularity ratio requires a larger number of devices than currently configured");
> > > +		return false;
> > > +	}
> > > +
> > > +	/* Check that endpoints are hooked up in the correct order */
> > > +	for_each_cxl_decoder_target(target, rootd, i) {
> > > +		struct cxl_memdev *endpoint = region->config.targets[i];
> > > +
> > > +		if (get_hostbridge(endpoint) != target->port) {  
> > 
> > I think this should be
> > get_hostbridge(endpoint)->uport != target->dport
> > 
> > As it stands you are comparing the host bridge with the root object.
> 
> On closer inspection this code doesn't do what it is meant to do at all
> if there are multiple EP below a given root bridge.
> 
> You'd expect multiple endpoints to match to each target->port.
> Something along the lines of this should work:
> 
>         {
>                 struct cxl_memdev **epgroupstart = region->config.targets;
>                 struct cxl_memdev **endpoint;
> 
>                 for_each_cxl_decoder_target(target, rootd, i) {
>                         /* Find start of next endpoint group */
>                         endpoint = epgroupstart;
>                         if (*endpoint == NULL) {
>                                 printk("No endpoints under decoder target\n");
>                                 return false;
>                         }
>                         while (*epgroupstart &&
>                                 get_hostbridge(*endpoint) == get_hostbridge(*epgroupstart))
>                                 epgroupstart++;
>                 }
>                 if (*epgroupstart) {
>                         printk("still some entries left. boom\n");
>                         return false;
>                 }
>         }
> 
> Only lightly tested with correct inputs...
> 
> Next up is figuring out why the EP HDM decoder won't commit. :)
> 
> Jonathan
> 

You're correct that what I have isn't correct. However, I think this was just
bogus leftover from an aborted attempt to try to implement this. See below...

> 
> > 
> > > +			trace_xhb_valid(region, "device ordering bad\n");
> > > +			return false;
> > > +		}
> > > +	}
> > > +
> > > +	/*
> > > +	 * CFMWS.InterleaveTargetList[n] must contain all devices, x where:
> > > +	 *	(Device[x],RegionLabel.Position >> (CFMWS.HBIG -
> > > +	 *	Device[x].RegionLabel.InterleaveGranularity)) &
> > > +	 *	((2^CFMWS.ENIW) - 1) = n
> > > +	 *
> > > +	 * Linux notes: All devices are known to have the same interleave
> > > +	 * granularity at this point.
> > > +	 */
> > > +	for_each_cxl_decoder_target(target, rootd, i) {
> > > +		if (((i >> (rootd_ig - region_ig(region)))) &
> > > +		    (((1 << rootd->interleave_ways) - 1) != target->port_id)) {
> > > +			trace_xhb_valid(region,
> > > +					"One or more devices are not connected to the correct hostbridge.");
> > > +			return false;
> > > +		}
> > > +	}
> > > +

I think this does the correct XHB calculation. So I think I can just remove the
top hunk and we're good. Do you agree?

> > >  	return true;
> > >  }
> > >  
> > > diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
> > > index a53f00ba5d0e..4de47d1111ac 100644
> > > --- a/drivers/cxl/trace.h
> > > +++ b/drivers/cxl/trace.h
> > > @@ -38,6 +38,9 @@ DEFINE_EVENT(cxl_region_template, sanitize_failed,
> > >  DEFINE_EVENT(cxl_region_template, allocation_failed,
> > >  	     TP_PROTO(const struct cxl_region *region, char *status),
> > >  	     TP_ARGS(region, status));
> > > +DEFINE_EVENT(cxl_region_template, xhb_valid,
> > > +	     TP_PROTO(const struct cxl_region *region, char *status),
> > > +	     TP_ARGS(region, status));
> > >  
> > >  #endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
> > >    
> > 
> 
