Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C13F562057
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 18:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235741AbiF3Qep (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 12:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235389AbiF3Qen (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 12:34:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38D353B299;
        Thu, 30 Jun 2022 09:34:42 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYkRf6HsZz6885F;
        Fri,  1 Jul 2022 00:33:50 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 18:34:39 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 17:34:38 +0100
Date:   Thu, 30 Jun 2022 17:34:37 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 40/46] cxl/region: Attach endpoint decoders
Message-ID: <20220630173437.0000604d@Huawei.com>
In-Reply-To: <20220624041950.559155-15-dan.j.williams@intel.com>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-15-dan.j.williams@intel.com>
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

On Thu, 23 Jun 2022 21:19:44 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> CXL regions (interleave sets) are made up of a set of memory devices
> where each device maps a portion of the interleave with one of its
> decoders (see CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure).
> As endpoint decoders are identified by a provisioning tool they can be
> added to a region provided the region interleave properties are set
> (way, granularity, HPA) and DPA has been assigned to the decoder.
> 
> The attach event triggers several validation checks, for example:
> - is the DPA sized appropriately for the region
> - is the decoder reachable via the host-bridges identified by the
>   region's root decoder
> - is the device already active in a different region position slot
> - are there already regions with a higher HPA active on a given port
>   (per CXL 2.0 8.2.5.12.20 Committing Decoder Programming)
> 
> ...and the attach event affords an opportunity to collect data and
> resources relevant to later programming the target lists in switch
> decoders, for example:
> - allocate a decoder at each cxl_port in the decode chain
> - for a given switch port, how many the region's endpoints are hosted
>   through the port
> - how many unique targets (next hops) does a port need to map to reach
>   those endpoints
> 
> The act of reconciling this information and deploying it to the decoder
> configuration is saved for a follow-on patch.
> 
> Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/core/core.h   |   7 +
>  drivers/cxl/core/port.c   |  10 +-
>  drivers/cxl/core/region.c | 338 +++++++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h         |  20 +++
>  drivers/cxl/cxlmem.h      |   5 +
>  5 files changed, 372 insertions(+), 8 deletions(-)
> 


> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4830365f3857..65bf84abad57 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -428,6 +428,254 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  	return rc;
>  }
>  

> +
> +static struct cxl_region_ref *alloc_region_ref(struct cxl_port *port,
> +					       struct cxl_region *cxlr)
> +{
> +	struct cxl_region_ref *cxl_rr;
> +
> +	cxl_rr = kzalloc(sizeof(*cxl_rr), GFP_KERNEL);
> +	if (!cxl_rr)
> +		return NULL;
> +	cxl_rr->port = port;
> +	cxl_rr->region = cxlr;
> +	xa_init(&cxl_rr->endpoints);
> +	return cxl_rr;
> +}
> +
> +static void free_region_ref(struct cxl_region_ref *cxl_rr)
> +{
> +	struct cxl_port *port = cxl_rr->port;
> +	struct cxl_region *cxlr = cxl_rr->region;
> +	struct cxl_decoder *cxld = cxl_rr->decoder;
> +
> +	dev_WARN_ONCE(&cxlr->dev, cxld->region != cxlr, "region mismatch\n");
> +	if (cxld->region == cxlr) {
> +		cxld->region = NULL;
> +		put_device(&cxlr->dev);
> +	}
> +
> +	xa_erase(&port->regions, (unsigned long)cxlr);

Why do we have things in a free_ function that aren't simply removing things
created in the alloc()?  I'd kind of expect this to be in a cxl_rr_del() or similar.

> +	xa_destroy(&cxl_rr->endpoints);
> +	kfree(cxl_rr);
> +}
> +
> +static int cxl_rr_add(struct cxl_region_ref *cxl_rr)
> +{
> +	struct cxl_port *port = cxl_rr->port;
> +	struct cxl_region *cxlr = cxl_rr->region;
> +
> +	return xa_insert(&port->regions, (unsigned long)cxlr, cxl_rr,
> +			 GFP_KERNEL);
> +}
> +
> +static int cxl_rr_ep_add(struct cxl_region_ref *cxl_rr,
> +			 struct cxl_endpoint_decoder *cxled)
> +{
> +	int rc;
> +	struct cxl_port *port = cxl_rr->port;
> +	struct cxl_region *cxlr = cxl_rr->region;
> +	struct cxl_decoder *cxld = cxl_rr->decoder;
> +	struct cxl_ep *ep = cxl_ep_load(port, cxled_to_memdev(cxled));
> +
> +	rc = xa_insert(&cxl_rr->endpoints, (unsigned long)cxled, ep,
> +			 GFP_KERNEL);
> +	if (rc)
> +		return rc;
> +	cxl_rr->nr_eps++;
> +
> +	if (!cxld->region) {
> +		cxld->region = cxlr;
> +		get_device(&cxlr->dev);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_port_attach_region(struct cxl_port *port,
> +				  struct cxl_region *cxlr,
> +				  struct cxl_endpoint_decoder *cxled, int pos)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_ep *ep = cxl_ep_load(port, cxlmd);
> +	struct cxl_region_ref *cxl_rr = NULL, *iter;
> +	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_decoder *cxld = NULL;
> +	unsigned long index;
> +	int rc = -EBUSY;
> +
> +	lockdep_assert_held_write(&cxl_region_rwsem);

This function is complex enough that maybe it would benefit from
some saying what each part is doing.

> +
> +	xa_for_each(&port->regions, index, iter) {
> +		struct cxl_region_params *ip = &iter->region->params;
> +
> +		if (iter->region == cxlr)
> +			cxl_rr = iter;
> +		if (ip->res->start > p->res->start) {
> +			dev_dbg(&cxlr->dev,
> +				"%s: HPA order violation %s:%pr vs %pr\n",
> +				dev_name(&port->dev),
> +				dev_name(&iter->region->dev), ip->res, p->res);
> +			return -EBUSY;
> +		}
> +	}
> +
> +	if (cxl_rr) {
> +		struct cxl_ep *ep_iter;
> +		int found = 0;
> +
> +		cxld = cxl_rr->decoder;
> +		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
> +			if (ep_iter == ep)
> +				continue;
> +			if (ep_iter->next == ep->next) {
> +				found++;
> +				break;
> +			}
> +		}
> +
> +		/*
> +		 * If this is a new target or if this port is direct connected
> +		 * to this endpoint then add to the target count.
> +		 */
> +		if (!found || !ep->next)
> +			cxl_rr->nr_targets++;
> +	} else {
> +		cxl_rr = alloc_region_ref(port, cxlr);
> +		if (!cxl_rr) {
> +			dev_dbg(&cxlr->dev,
> +				"%s: failed to allocate region reference\n",
> +				dev_name(&port->dev));
> +			return -ENOMEM;
> +		}
> +		rc = cxl_rr_add(cxl_rr);
> +		if (rc) {
> +			dev_dbg(&cxlr->dev,
> +				"%s: failed to track region reference\n",
> +				dev_name(&port->dev));
> +			kfree(cxl_rr);
> +			return rc;
> +		}
> +	}
> +
> +	if (!cxld) {
> +		if (port == cxled_to_port(cxled))
> +			cxld = &cxled->cxld;
> +		else
> +			cxld = cxl_region_find_decoder(port, cxlr);
> +		if (!cxld) {
> +			dev_dbg(&cxlr->dev, "%s: no decoder available\n",
> +				dev_name(&port->dev));
> +			goto out_erase;
> +		}
> +
> +		if (cxld->region) {
> +			dev_dbg(&cxlr->dev, "%s: %s already attached to %s\n",
> +				dev_name(&port->dev), dev_name(&cxld->dev),
> +				dev_name(&cxld->region->dev));
> +			rc = -EBUSY;
> +			goto out_erase;
> +		}
> +
> +		cxl_rr->decoder = cxld;
> +	}
> +
> +	rc = cxl_rr_ep_add(cxl_rr, cxled);
> +	if (rc) {
> +		dev_dbg(&cxlr->dev,
> +			"%s: failed to track endpoint %s:%s reference\n",
> +			dev_name(&port->dev), dev_name(&cxlmd->dev),
> +			dev_name(&cxld->dev));
> +		goto out_erase;
> +	}
> +
> +	return 0;
> +out_erase:
> +	if (cxl_rr->nr_eps == 0)
> +		free_region_ref(cxl_rr);
> +	return rc;
> +}
> +

>  
>  static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  {
> +	struct cxl_port *iter, *ep_port = cxled_to_port(cxled);
>  	struct cxl_region *cxlr = cxled->cxld.region;
>  	struct cxl_region_params *p;
>  
> @@ -481,6 +811,10 @@ static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  	p = &cxlr->params;
>  	get_device(&cxlr->dev);
>  
> +	for (iter = ep_port; !is_cxl_root(iter);
> +	     iter = to_cxl_port(iter->dev.parent))
> +		cxl_port_detach_region(iter, cxlr, cxled);
> +
>  	if (cxled->pos < 0 || cxled->pos >= p->interleave_ways ||
>  	    p->targets[cxled->pos] != cxled) {
>  		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> @@ -491,6 +825,8 @@ static void cxl_region_detach(struct cxl_endpoint_decoder *cxled)
>  		goto out;
>  	}
>  
> +	if (p->state == CXL_CONFIG_ACTIVE)

I 'think' the state is either CXL_CONFIG_ACTIVE or CXL_CONFIG_INTERLEAVE_ACTIVE,
so you could set this unconditionally.  A comment here on permissible
states would be useful for future reference.

> +		p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
>  	p->targets[cxled->pos] = NULL;
>  	p->nr_targets--;

