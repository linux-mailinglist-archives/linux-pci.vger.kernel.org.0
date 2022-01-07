Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5225487BDF
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 19:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240710AbiAGSO7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 13:14:59 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4375 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiAGSO7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 7 Jan 2022 13:14:59 -0500
Received: from fraeml711-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JVrrl5cX7z67w7v;
        Sat,  8 Jan 2022 02:11:35 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml711-chm.china.huawei.com (10.206.15.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 7 Jan 2022 19:14:56 +0100
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.20; Fri, 7 Jan
 2022 18:14:55 +0000
Date:   Fri, 7 Jan 2022 18:14:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>
Subject: Re: [PATCH 12/13] cxl/region: Record host bridge target list
Message-ID: <20220107181454.00004a1b@huawei.com>
In-Reply-To: <20220107003756.806582-13-ben.widawsky@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
        <20220107003756.806582-13-ben.widawsky@intel.com>
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

On Thu,  6 Jan 2022 16:37:55 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Part of host bridge verification in the CXL Type 3 Memory Device
> Software Guide calculates the host bridge interleave target list (6th
> step in the flow chart). With host bridge verification already done, it
> is trivial to store away the configuration information.
> 
> TODO: Needs support for switches (7th step in the flow chart).
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  drivers/cxl/region.c | 41 +++++++++++++++++++++++++++++++----------
>  1 file changed, 31 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index eafd95419895..3120b65b0bc5 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -385,6 +385,7 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
>  	}
>  
>  	for (i = 0; i < hb_count; i++) {
> +		struct cxl_decoder *cxld;
>  		int idx, position_mask;
>  		struct cxl_dport *rp;
>  		struct cxl_port *hb;
> @@ -422,10 +423,8 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
>  				if (get_rp(ep) != rp)
>  					continue;
>  
> -				if (port_grouping == -1) {
> +				if (port_grouping == -1)
>  					port_grouping = idx & position_mask;
> -					continue;
> -				}
>  
>  				/*
>  				 * Do all devices in the region connected to this CXL
> @@ -436,10 +435,32 @@ static bool region_hb_rp_config_valid(struct cxl_region *region,
>  							  "One or more devices are not connected to the correct Host Bridge Root Port\n");
>  					return false;
>  				}
> +
> +				if (!state_update)
> +					continue;
> +
> +				if (dev_WARN_ONCE(&cxld->dev,
> +						  port_grouping >= cxld->nr_targets,
> +						  "Invalid port grouping %d/%d\n",
> +						  port_grouping, cxld->nr_targets))
> +					return false;
> +
> +				cxld->interleave_ways++;
> +				cxld->target[port_grouping] = get_rp(ep);

Hi Ben,

Just one more based on debug rather than review.

The reason is across 2 patches so not necessary obvious from what is visible here,
but port_grouping here for a 2hb, 2rp on each and 1 ep on each of those
case goes 0,1,2,3 resulting in us setting one of the host bridges to have
a decoder with targets 2 and 3 rather than 0 and 1 set.

I haven't figured out a particularly good solution yet...  If everything is nice and symmetric
and power of 2 then you can simply change the mask on the index to reflect num_root_ports / num_host_bridges

With that change in place my decoders all look good on this particular configuration :)
Note this is eyeball based testing only and on just one configuration so far.

I'll have to try your tool as it is really annoying that the mem devices change order on every
boot as my script is dumb currently so have to edit it every run.

Jonathan

>  			}
>  		}
> -		if (state_update)
> +
> +		if (state_update) {
> +			/* IG doesn't change across host bridges */
> +			cxld->interleave_granularity = region_ig(region);
> +
> +			cxld->decoder_range = (struct range) {
> +				.start = region->res->start,
> +				.end = region->res->end
> +			};
> +
>  			list_add_tail(&cxld->region_link, &region->staged_list);
> +		}
>  	}
>  
>  	return true;
> @@ -464,7 +485,7 @@ static bool rootd_contains(const struct cxl_region *region,
>  	return true;
>  }
>  
> -static bool rootd_valid(const struct cxl_region *region,
> +static bool rootd_valid(struct cxl_region *region,
>  			const struct cxl_decoder *rootd,
>  			bool state_update)
>  {
> @@ -489,20 +510,20 @@ static bool rootd_valid(const struct cxl_region *region,
>  }
>  
>  struct rootd_context {
> -	const struct cxl_region *region;
> -	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
> +	struct cxl_region *region;
> +	const struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
>  	int count;
>  };
>  
>  static int rootd_match(struct device *dev, void *data)
>  {
>  	struct rootd_context *ctx = (struct rootd_context *)data;
> -	const struct cxl_region *region = ctx->region;
> +	struct cxl_region *region = ctx->region;
>  
>  	if (!is_root_decoder(dev))
>  		return 0;
>  
> -	return !!rootd_valid(region, to_cxl_decoder(dev), false);
> +	return rootd_valid(region, to_cxl_decoder(dev), false);
>  }
>  
>  /*
> @@ -516,7 +537,7 @@ static struct cxl_decoder *find_rootd(const struct cxl_region *region,
>  	struct rootd_context ctx;
>  	struct device *ret;
>  
> -	ctx.region = region;
> +	ctx.region = (struct cxl_region *)region;
>  
>  	ret = device_find_child((struct device *)&root->dev, &ctx, rootd_match);
>  	if (ret)

