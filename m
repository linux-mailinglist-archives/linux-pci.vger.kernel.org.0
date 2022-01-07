Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C523487535
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 11:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346652AbiAGKHO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 05:07:14 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4364 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237203AbiAGKHO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 05:07:14 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JVf080sZ2z67wwW;
        Fri,  7 Jan 2022 18:02:16 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 11:07:11 +0100
Received: from localhost (10.47.80.90) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 10:07:10 +0000
Date:   Fri, 7 Jan 2022 10:07:14 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 09/13] cxl/region: Implement XHB verification
Message-ID: <20220107100714.00004461@Huawei.com>
In-Reply-To: <20220107003756.806582-10-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
        <20220107003756.806582-10-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.80.90]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu,  6 Jan 2022 16:37:52 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Cross host bridge verification primarily determines if the requested
> interleave ordering can be achieved by the root decoder, which isn't as
> programmable as other decoders.
> 
> The algorithm implemented here is based on the CXL Type 3 Memory Device
> Software Guide, chapter 2.13.14
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Hi Ben,

A few things I'm carrying 'fixes' for in here.

Jonathan

> ---
>  .clang-format        |  2 +
>  drivers/cxl/region.c | 89 +++++++++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/trace.h  |  3 ++
>  3 files changed, 93 insertions(+), 1 deletion(-)
> 
> diff --git a/.clang-format b/.clang-format
> index 15d4eaabc6b5..55f628f21722 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -169,6 +169,8 @@ ForEachMacros:
>    - 'for_each_cpu_and'
>    - 'for_each_cpu_not'
>    - 'for_each_cpu_wrap'
> +  - 'for_each_cxl_decoder_target'
> +  - 'for_each_cxl_endpoint'
>    - 'for_each_dapm_widgets'
>    - 'for_each_dev_addr'
>    - 'for_each_dev_scope'
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index c8e3c48dfbb9..ca559a4b5347 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -28,6 +28,17 @@
>   */
>  
>  #define region_ways(region) ((region)->config.eniw)
> +#define region_ig(region) (ilog2((region)->config.ig))
> +
> +#define for_each_cxl_endpoint(ep, region, idx)                                 \
> +	for (idx = 0, ep = (region)->config.targets[idx];                      \
> +	     idx < region_ways(region);                                        \
> +	     idx++, ep = (region)->config.targets[idx])
> +
> +#define for_each_cxl_decoder_target(target, decoder, idx)                      \
> +	for (idx = 0, target = (decoder)->target[idx];                         \
> +	     idx < (decoder)->nr_targets;                                      \
> +	     idx++, target++)
>  
>  static struct cxl_decoder *rootd_from_region(struct cxl_region *r)
>  {
> @@ -175,6 +186,30 @@ static bool qtg_match(const struct cxl_decoder *rootd,
>  	return true;
>  }
>  
> +static int get_unique_hostbridges(const struct cxl_region *region,
> +				  struct cxl_port **hbs)
> +{
> +	struct cxl_memdev *ep;
> +	int i, hb_count = 0;
> +
> +	for_each_cxl_endpoint(ep, region, i) {
> +		struct cxl_port *hb = get_hostbridge(ep);
> +		bool found = false;
> +		int j;
> +
> +		BUG_ON(!hb);
> +
> +		for (j = 0; j < hb_count; j++) {
> +			if (hbs[j] == hb)
> +				found = true;
> +		}
> +		if (!found)
> +			hbs[hb_count++] = hb;
> +	}
> +
> +	return hb_count;
> +}
> +
>  /**
>   * region_xhb_config_valid() - determine cross host bridge validity
>   * @rootd: The root decoder to check against
> @@ -188,7 +223,59 @@ static bool qtg_match(const struct cxl_decoder *rootd,
>  static bool region_xhb_config_valid(const struct cxl_region *region,
>  				    const struct cxl_decoder *rootd)
>  {
> -	/* TODO: */
> +	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
> +	int rootd_ig, i;
> +	struct cxl_dport *target;
> +
> +	/* Are all devices in this region on the same CXL host bridge */
> +	if (get_unique_hostbridges(region, hbs) == 1)
> +		return true;
> +
> +	rootd_ig = rootd->interleave_granularity;
> +
> +	/* CFMWS.HBIG >= Device.Label.IG */
> +	if (rootd_ig < region_ig(region)) {
> +		trace_xhb_valid(region,
> +				"granularity does not support the region interleave granularity\n");
> +		return false;
> +	}
> +
> +	/* ((2^(CFMWS.HBIG - Device.RLabel.IG) * (2^CFMWS.ENIW)) > Device.RLabel.NLabel) */
> +	if (1 << (rootd_ig - region_ig(region)) * (1 << rootd->interleave_ways) >

This maths isn't what the comment says it is.
((1 << (rootd_ig - region_ig(region))) * rootd->interleaveways)
so brackets needed to avoid 2^( all the rest) and rootd->interleave_ways seems to the
actual number of ways not the log2 of it.

That feeds through below.


> +	    region_ways(region)) {
> +		trace_xhb_valid(region,
> +				"granularity to device granularity ratio requires a larger number of devices than currently configured");
> +		return false;
> +	}
> +
> +	/* Check that endpoints are hooked up in the correct order */
> +	for_each_cxl_decoder_target(target, rootd, i) {
> +		struct cxl_memdev *endpoint = region->config.targets[i];
> +
> +		if (get_hostbridge(endpoint) != target->port) {

I think this should be
get_hostbridge(endpoint)->uport != target->dport

As it stands you are comparing the host bridge with the root object.

> +			trace_xhb_valid(region, "device ordering bad\n");
> +			return false;
> +		}
> +	}
> +
> +	/*
> +	 * CFMWS.InterleaveTargetList[n] must contain all devices, x where:
> +	 *	(Device[x],RegionLabel.Position >> (CFMWS.HBIG -
> +	 *	Device[x].RegionLabel.InterleaveGranularity)) &
> +	 *	((2^CFMWS.ENIW) - 1) = n
> +	 *
> +	 * Linux notes: All devices are known to have the same interleave
> +	 * granularity at this point.
> +	 */
> +	for_each_cxl_decoder_target(target, rootd, i) {
> +		if (((i >> (rootd_ig - region_ig(region)))) &
> +		    (((1 << rootd->interleave_ways) - 1) != target->port_id)) {
> +			trace_xhb_valid(region,
> +					"One or more devices are not connected to the correct hostbridge.");
> +			return false;
> +		}
> +	}
> +
>  	return true;
>  }
>  
> diff --git a/drivers/cxl/trace.h b/drivers/cxl/trace.h
> index a53f00ba5d0e..4de47d1111ac 100644
> --- a/drivers/cxl/trace.h
> +++ b/drivers/cxl/trace.h
> @@ -38,6 +38,9 @@ DEFINE_EVENT(cxl_region_template, sanitize_failed,
>  DEFINE_EVENT(cxl_region_template, allocation_failed,
>  	     TP_PROTO(const struct cxl_region *region, char *status),
>  	     TP_ARGS(region, status));
> +DEFINE_EVENT(cxl_region_template, xhb_valid,
> +	     TP_PROTO(const struct cxl_region *region, char *status),
> +	     TP_ARGS(region, status));
>  
>  #endif /* if !defined (__CXL_TRACE_H__) || defined(TRACE_HEADER_MULTI_READ) */
>  

