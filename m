Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F5A55A0AB
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 20:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiFXSZL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 14:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiFXSZK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 14:25:10 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4E369999;
        Fri, 24 Jun 2022 11:25:05 -0700 (PDT)
Received: from fraeml708-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LV58L15yWz684kT;
        Sat, 25 Jun 2022 02:22:58 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml708-chm.china.huawei.com (10.206.15.36) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 24 Jun 2022 20:25:03 +0200
Received: from localhost (10.122.247.231) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 24 Jun
 2022 19:25:02 +0100
Date:   Fri, 24 Jun 2022 19:25:01 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>, "Ben Widawsky" <bwidawsk@kernel.org>
Subject: Re: [PATCH 40/46] cxl/region: Attach endpoint decoders
Message-ID: <20220624192501.00003b53@huawei.com>
In-Reply-To: <20220624041950.559155-15-dan.j.williams@intel.com>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-15-dan.j.williams@intel.com>
Organization: Huawei Technologies R&D (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml738-chm.china.huawei.com (10.201.108.188) To
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
Hi Dam,
n
Only managed to grab a few mins today to debug that crash.. So I know
the immediate cause but not yet why we got to that state.

Test case (happened to be one I had open) is 2x HB, 2x RP on each,
direct connected type 3s on all ports.

Manual test script is:

insmod modules/5.19.0-rc3+/kernel/drivers/cxl/core/cxl_core.ko
insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_acpi.ko
insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_port.ko
insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_pci.ko
insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_mem.ko
insmod modules/5.19.0-rc3+/kernel/drivers/cxl/cxl_pmem.ko

cd /sys/bus/cxl/devices/decoder0.0/
cat create_pmem_region
echo region0 > create_pmem_region

cd region0/
echo 4 > interleave_ways
echo $((256 << 22)) > size
echo 6a6b9b22-e0d4-11ec-9d64-0242ac120002 > uuid
ls -lh /sys/bus/cxl/devices/endpoint?/upo*

# Then figure out the order hopefully write the correct targets 
echo decoder5.0 > target0

Location of crash below...
No idea if these breadcrumbs will be much use. I'll poke
it some more next week. Have a good weekend,

Jonathan


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
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 36b6bd8dac2b..0e4e5c2d9452 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -42,6 +42,13 @@ resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
>  resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled);
>  extern struct rw_semaphore cxl_dpa_rwsem;
>  
> +bool is_switch_decoder(struct device *dev);
> +static inline struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> +					 struct cxl_memdev *cxlmd)
> +{
> +	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
> +}
> +
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 7756409d0a58..fde2a2e103d4 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -447,7 +447,7 @@ bool is_root_decoder(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
>  
> -static bool is_switch_decoder(struct device *dev)
> +bool is_switch_decoder(struct device *dev)
>  {
>  	return is_root_decoder(dev) || dev->type == &cxl_decoder_switch_type;
>  }
> @@ -503,6 +503,7 @@ static void cxl_port_release(struct device *dev)
>  		cxl_ep_remove(port, ep);
>  	xa_destroy(&port->endpoints);
>  	xa_destroy(&port->dports);
> +	xa_destroy(&port->regions);
>  	ida_free(&cxl_port_ida, port->id);
>  	kfree(port);
>  }
> @@ -633,6 +634,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>  	port->dpa_end = -1;
>  	xa_init(&port->dports);
>  	xa_init(&port->endpoints);
> +	xa_init(&port->regions);
>  
>  	device_initialize(dev);
>  	lockdep_set_class_and_subclass(&dev->mutex, &cxl_port_key, port->depth);
> @@ -1110,12 +1112,6 @@ static void reap_dports(struct cxl_port *port)
>  	}
>  }
>  
> -static struct cxl_ep *cxl_ep_load(struct cxl_port *port,
> -				  struct cxl_memdev *cxlmd)
> -{
> -	return xa_load(&port->endpoints, (unsigned long)&cxlmd->dev);
> -}
> -
>  int devm_cxl_add_endpoint(struct cxl_memdev *cxlmd,
>  			  struct cxl_dport *parent_dport)
>  {
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 4830365f3857..65bf84abad57 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -428,6 +428,254 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  	return rc;
>  }
>  
> +static int match_free_decoder(struct device *dev, void *data)
> +{
> +	struct cxl_decoder *cxld;
> +	int *id = data;
> +
> +	if (!is_switch_decoder(dev))
> +		return 0;
> +
> +	cxld = to_cxl_decoder(dev);
> +
> +	/* enforce ordered allocation */
> +	if (cxld->id != *id)
> +		return 0;
> +
> +	if (!cxld->region)
> +		return 1;
> +
> +	(*id)++;
> +
> +	return 0;
> +}
> +
> +static struct cxl_decoder *cxl_region_find_decoder(struct cxl_port *port,
> +						   struct cxl_region *cxlr)
> +{
> +	struct device *dev;
> +	int id = 0;
> +
> +	dev = device_find_child(&port->dev, &id, match_free_decoder);
> +	if (!dev)
> +		return NULL;
> +	/*
> +	 * This decoder is pinned registered as long as the endpoint decoder is
> +	 * registered, and endpoint decoder unregistration holds the
> +	 * cxl_region_rwsem over unregister events, so no need to hold on to
> +	 * this extra reference.
> +	 */
> +	put_device(dev);
> +	return to_cxl_decoder(dev);
> +}
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
> +static struct cxl_region_ref *cxl_rr_load(struct cxl_port *port,
> +					  struct cxl_region *cxlr)
> +{
> +	return xa_load(&port->regions, (unsigned long)cxlr);
> +}
> +
> +static void cxl_port_detach_region(struct cxl_port *port,
> +				   struct cxl_region *cxlr,
> +				   struct cxl_endpoint_decoder *cxled)
> +{
> +	struct cxl_region_ref *cxl_rr;
> +	struct cxl_ep *ep;
> +
> +	lockdep_assert_held_write(&cxl_region_rwsem);
> +
> +	cxl_rr = cxl_rr_load(port, cxlr);
> +	if (!cxl_rr)
> +		return;
> +
> +	ep = xa_erase(&cxl_rr->endpoints, (unsigned long)cxled);
> +	if (ep) {
> +		struct cxl_ep *ep_iter;
> +		unsigned long index;
> +		int found = 0;
> +
> +		cxl_rr->nr_eps--;
> +		xa_for_each(&cxl_rr->endpoints, index, ep_iter) {
> +			if (ep_iter->next == ep->next) {
> +				found++;
> +				break;
> +			}
> +		}
> +		if (!found)
> +			cxl_rr->nr_targets--;
> +	}
> +
> +	if (cxl_rr->nr_eps == 0)
> +		free_region_ref(cxl_rr);
> +}
> +
>  /*
>   * - Check that the given endpoint is attached to a host-bridge identified
>   *   in the root interleave.
> @@ -435,14 +683,28 @@ static size_t show_targetN(struct cxl_region *cxlr, char *buf, int pos)
>  static int cxl_region_attach(struct cxl_region *cxlr,
>  			     struct cxl_endpoint_decoder *cxled, int pos)
>  {
> +	struct cxl_root_decoder *cxlrd = to_cxl_root_decoder(cxlr->dev.parent);
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_port *ep_port, *root_port, *iter;
>  	struct cxl_region_params *p = &cxlr->params;
> +	struct cxl_dport *dport;
> +	int i, rc = -ENXIO;
>  
>  	if (cxled->mode == CXL_DECODER_DEAD) {
>  		dev_dbg(&cxlr->dev, "%s dead\n", dev_name(&cxled->cxld.dev));
>  		return -ENODEV;
>  	}
>  
> -	if (pos >= p->interleave_ways) {
> +	/* all full of members, or interleave config not established? */
> +	if (p->state > CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +		dev_dbg(&cxlr->dev, "region already active\n");
> +		return -EBUSY;
> +	} else if (p->state < CXL_CONFIG_INTERLEAVE_ACTIVE) {
> +		dev_dbg(&cxlr->dev, "interleave config missing\n");
> +		return -ENXIO;
> +	}
> +
> +	if (pos < 0 || pos >= p->interleave_ways) {
>  		dev_dbg(&cxlr->dev, "position %d out of range %d\n", pos,
>  			p->interleave_ways);
>  		return -ENXIO;
> @@ -461,15 +723,83 @@ static int cxl_region_attach(struct cxl_region *cxlr,
>  		return -EBUSY;
>  	}
>  
> +	for (i = 0; i < p->interleave_ways; i++) {
> +		struct cxl_endpoint_decoder *cxled_target;
> +		struct cxl_memdev *cxlmd_target;
> +
> +		cxled_target = p->targets[pos];
> +		if (!cxled_target)
> +			continue;
> +
> +		cxlmd_target = cxled_to_memdev(cxled_target);
> +		if (cxlmd_target == cxlmd) {
> +			dev_dbg(&cxlr->dev,
> +				"%s already specified at position %d via: %s\n",
> +				dev_name(&cxlmd->dev), pos,
> +				dev_name(&cxled_target->cxld.dev));
> +			return -EBUSY;
> +		}
> +	}
> +
> +	ep_port = cxled_to_port(cxled);
> +	root_port = cxlrd_to_port(cxlrd);
> +	dport = cxl_dport_load(root_port, ep_port->host_bridge);
> +	if (!dport) {
> +		dev_dbg(&cxlr->dev, "%s:%s invalid target for %s\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			dev_name(cxlr->dev.parent));
> +		return -ENXIO;
> +	}
> +
> +	if (cxlrd->calc_hb(cxlrd, pos) != dport) {
> +		dev_dbg(&cxlr->dev, "%s:%s invalid target position for %s\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			dev_name(&cxlrd->cxlsd.cxld.dev));
> +		return -ENXIO;
> +	}
> +
> +	if (cxled->cxld.target_type != cxlr->type) {
> +		dev_dbg(&cxlr->dev, "%s:%s type mismatch: %d vs %d\n",
> +			dev_name(&cxlmd->dev), dev_name(&cxled->cxld.dev),
> +			cxled->cxld.target_type, cxlr->type);
> +		return -ENXIO;
> +	}
> +
> +	if (resource_size(cxled->dpa_res) * p->interleave_ways !=

At this point cxled->dpa_res is NULL.

> +	    resource_size(p->res)) {
> +		dev_dbg(&cxlr->dev,
> +			"decoder-size-%#llx * ways-%d != region-size-%#llx\n",
> +			(u64)resource_size(cxled->dpa_res), p->interleave_ways,
> +			(u64)resource_size(p->res));
> +		return -EINVAL;
> +	}
> +
> +	for (iter = ep_port; !is_cxl_root(iter);
> +	     iter = to_cxl_port(iter->dev.parent)) {
> +		rc = cxl_port_attach_region(iter, cxlr, cxled, pos);
> +		if (rc)
> +			goto err;
> +	}
> +
>  	p->targets[pos] = cxled;
>  	cxled->pos = pos;
>  	p->nr_targets++;
>  
> +	if (p->nr_targets == p->interleave_ways)
> +		p->state = CXL_CONFIG_ACTIVE;
> +
>  	return 0;
> +
> +err:
> +	for (iter = ep_port; !is_cxl_root(iter);
> +	     iter = to_cxl_port(iter->dev.parent))
> +		cxl_port_detach_region(iter, cxlr, cxled);
> +	return rc;
>  }
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
> +		p->state = CXL_CONFIG_INTERLEAVE_ACTIVE;
>  	p->targets[cxled->pos] = NULL;
>  	p->nr_targets--;
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 30227348f768..09dbd46cc4c7 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -414,6 +414,7 @@ struct cxl_nvdimm {
>   * @id: id for port device-name
>   * @dports: cxl_dport instances referenced by decoders
>   * @endpoints: cxl_ep instances, endpoints that are a descendant of this port
> + * @regions: cxl_region_ref instances, regions mapped by this port
>   * @parent_dport: dport that points to this port in the parent
>   * @decoder_ida: allocator for decoder ids
>   * @dpa_end: cursor to track highest allocated decoder for allocation ordering
> @@ -428,6 +429,7 @@ struct cxl_port {
>  	int id;
>  	struct xarray dports;
>  	struct xarray endpoints;
> +	struct xarray regions;
>  	struct cxl_dport *parent_dport;
>  	struct ida decoder_ida;
>  	int dpa_end;
> @@ -470,6 +472,24 @@ struct cxl_ep {
>  	struct cxl_port *next;
>  };
>  
> +/**
> + * struct cxl_region_ref - track a region's interest in a port
> + * @port: point in topology to install this reference
> + * @decoder: decoder assigned for @region in @port
> + * @region: region for this reference
> + * @endpoints: cxl_ep references for region members beneath @port
> + * @nr_eps: number of endpoints beneath @port
> + * @nr_targets: number of distinct targets needed to reach @nr_eps
> + */
> +struct cxl_region_ref {
> +	struct cxl_port *port;
> +	struct cxl_decoder *decoder;
> +	struct cxl_region *region;
> +	struct xarray endpoints;
> +	int nr_eps;
> +	int nr_targets;
> +};
> +
>  /*
>   * The platform firmware device hosting the root is also the top of the
>   * CXL port topology. All other CXL ports have another CXL port as their
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index eee96016c3c7..a83bb6782d23 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -55,6 +55,11 @@ static inline struct cxl_port *cxled_to_port(struct cxl_endpoint_decoder *cxled)
>  	return to_cxl_port(cxled->cxld.dev.parent);
>  }
>  
> +static inline struct cxl_port *cxlrd_to_port(struct cxl_root_decoder *cxlrd)
> +{
> +	return to_cxl_port(cxlrd->cxlsd.cxld.dev.parent);
> +}
> +
>  static inline struct cxl_memdev *
>  cxled_to_memdev(struct cxl_endpoint_decoder *cxled)
>  {

