Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C518C55E7E7
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238517AbiF1QTs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 12:19:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348590AbiF1QTH (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 12:19:07 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FF273A1AE;
        Tue, 28 Jun 2022 09:12:08 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXV2f75DQz6GD4L;
        Wed, 29 Jun 2022 00:11:22 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 18:12:06 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 17:12:05 +0100
Date:   Tue, 28 Jun 2022 17:12:04 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <bwidawsk@kernel.org>,
        <hch@infradead.org>, <alison.schofield@intel.com>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>,
        <patches@lists.linux.dev>
Subject: Re: [PATCH 08/46] cxl/core: Define a 'struct cxl_switch_decoder'
Message-ID: <20220628171204.00006ad4@Huawei.com>
In-Reply-To: <165603875762.551046.12872423961024324769.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603875762.551046.12872423961024324769.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
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

On Thu, 23 Jun 2022 19:45:57 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Currently 'struct cxl_decoder' contains the superset of attributes
> needed for all decoder types. Before more type-specific attributes are
> added to the common definition, reorganize 'struct cxl_decoder' into type
> specific objects.
> 
> This patch, the first of three, factors out a cxl_switch_decoder type.
> The 'switch' decoder type represents the decoder instances of cxl_port's
> that route from the root of a CXL memory decode topology to the
> endpoints. They come in two flavors, root-level decoders, statically
> defined by platform firmware, and mid-level decoders, where
> interleave-granularity, interleave-width, and the target list are
> mutable.

I'd like to see this info on cxl_switch_decoder being used for
switches AND other stuff as docs next to the definition. It confused
me when looked directly at the resulting of applying this series
and made more sense once I read to this patch.

> 
> Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Basic idea is fine, but there are a few places where I think this is
'too clever' with error handling and it's worth duplicating a few
error messages to keep the flow simpler.

Also, nice to drop the white space tweaks that have snuck in here.
Particularly the wrong one ;)


> ---
>  drivers/cxl/acpi.c           |    4 +
>  drivers/cxl/core/hdm.c       |   21 +++++---
>  drivers/cxl/core/port.c      |  115 +++++++++++++++++++++++++++++++-----------
>  drivers/cxl/cxl.h            |   27 ++++++----
>  tools/testing/cxl/test/cxl.c |   12 +++-
>  5 files changed, 128 insertions(+), 51 deletions(-)
> 

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 46635105a1f1..2d1f3e6eebea 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c


> @@ -226,8 +226,15 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  
>  		if (is_cxl_endpoint(port))
>  			cxld = cxl_endpoint_decoder_alloc(port);
> -		else
> -			cxld = cxl_switch_decoder_alloc(port, target_count);
> +		else {
> +			struct cxl_switch_decoder *cxlsd;
> +
> +			cxlsd = cxl_switch_decoder_alloc(port, target_count);
> +			if (IS_ERR(cxlsd))
> +				cxld = ERR_CAST(cxlsd);

As described later, I'd rather local error handing in these branches
as I think it will be more readable than this dance with error casting. for
the cost of maybe 2 lines.

> +			else
> +				cxld = &cxlsd->cxld;
> +		}
>  		if (IS_ERR(cxld)) {
>  			dev_warn(&port->dev,
>  				 "Failed to allocate the decoder\n");
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 13c321afe076..fd1cac13cd2e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c

....

>  
> +static void __cxl_decoder_release(struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +
> +	ida_free(&port->decoder_ida, cxld->id);
> +	put_device(&port->dev);
> +}
> +
>  static void cxl_decoder_release(struct device *dev)
>  {
>  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> -	struct cxl_port *port = to_cxl_port(dev->parent);
>  
> -	ida_free(&port->decoder_ida, cxld->id);
> +	__cxl_decoder_release(cxld);
>  	kfree(cxld);
> -	put_device(&port->dev);

I was going to moan about this reorder, but this is actually
the right order as we allocate then get_device() so
reverse should indeed do the put _device first.
So good incidental clean up of ordering :)

> +}
> +
> +static void cxl_switch_decoder_release(struct device *dev)
> +{
> +	struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
> +
> +	__cxl_decoder_release(&cxlsd->cxld);
> +	kfree(cxlsd);
>  }
>  
>  static const struct device_type cxl_decoder_endpoint_type = {
> @@ -250,13 +267,13 @@ static const struct device_type cxl_decoder_endpoint_type = {
>  
>  static const struct device_type cxl_decoder_switch_type = {
>  	.name = "cxl_decoder_switch",
> -	.release = cxl_decoder_release,
> +	.release = cxl_switch_decoder_release,
>  	.groups = cxl_decoder_switch_attribute_groups,
>  };
>  
>  static const struct device_type cxl_decoder_root_type = {
>  	.name = "cxl_decoder_root",
> -	.release = cxl_decoder_release,
> +	.release = cxl_switch_decoder_release,
>  	.groups = cxl_decoder_root_attribute_groups,
>  };
>  
> @@ -271,15 +288,29 @@ bool is_root_decoder(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_root_decoder, CXL);
>  
> +static bool is_switch_decoder(struct device *dev)
> +{
> +	return is_root_decoder(dev) || dev->type == &cxl_decoder_switch_type;
> +}
> +
>  struct cxl_decoder *to_cxl_decoder(struct device *dev)
>  {
> -	if (dev_WARN_ONCE(dev, dev->type->release != cxl_decoder_release,
> +	if (dev_WARN_ONCE(dev,
> +			  !is_switch_decoder(dev) && !is_endpoint_decoder(dev),
>  			  "not a cxl_decoder device\n"))
>  		return NULL;
>  	return container_of(dev, struct cxl_decoder, dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(to_cxl_decoder, CXL);
>  
> +static struct cxl_switch_decoder *to_cxl_switch_decoder(struct device *dev)
> +{
> +	if (dev_WARN_ONCE(dev, !is_switch_decoder(dev),
> +			  "not a cxl_switch_decoder device\n"))
> +		return NULL;
> +	return container_of(dev, struct cxl_switch_decoder, cxld.dev);
> +}
> +
>  static void cxl_ep_release(struct cxl_ep *ep)
>  {
>  	if (!ep)
> @@ -1129,7 +1160,7 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_dport_by_dev, CXL);
>  
> -static int decoder_populate_targets(struct cxl_decoder *cxld,
> +static int decoder_populate_targets(struct cxl_switch_decoder *cxlsd,
>  				    struct cxl_port *port, int *target_map)
>  {
>  	int i, rc = 0;
> @@ -1142,17 +1173,17 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
>  	if (list_empty(&port->dports))
>  		return -EINVAL;
>  
> -	write_seqlock(&cxld->target_lock);
> -	for (i = 0; i < cxld->nr_targets; i++) {
> +	write_seqlock(&cxlsd->target_lock);
> +	for (i = 0; i < cxlsd->nr_targets; i++) {
>  		struct cxl_dport *dport = find_dport(port, target_map[i]);
>  
>  		if (!dport) {
>  			rc = -ENXIO;
>  			break;
>  		}
> -		cxld->target[i] = dport;
> +		cxlsd->target[i] = dport;
>  	}
> -	write_sequnlock(&cxld->target_lock);
> +	write_sequnlock(&cxlsd->target_lock);
>  
>  	return rc;
>  }
> @@ -1179,13 +1210,27 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  {
>  	struct cxl_decoder *cxld;
>  	struct device *dev;
> +	void *alloc;
>  	int rc = 0;
>  
>  	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
>  		return ERR_PTR(-EINVAL);
>  
> -	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> -	if (!cxld)
> +	if (nr_targets) {
> +		struct cxl_switch_decoder *cxlsd;
> +
> +		alloc = kzalloc(struct_size(cxlsd, target, nr_targets), GFP_KERNEL);

I'd rather see a local check on the allocation failure even if it adds a few lines
of duplicated code - which after you've dropped the local alloc variable won't be
much even after a later patch adds another path in here.  The eventual code
of this function is more than a little nasty when an early return in each
path would, as far as I can tell, give the same result without the at least
3 null checks prior to returning (to ensure nothing happens before reaching
the if (!alloc)




		cxlsd = kzalloc()
		if (!cxlsd)
			return ERR_PTR(-ENOMEM);

		cxlsd->nr_targets = nr_targets;
		seqlock_init(...)

	} else {
		cxld = kzalloc(sizerof(*cxld), GFP_KERNEL);
		if (!cxld)
			return ERR_PTR(-ENOMEM);

> +		cxlsd = alloc;
> +		if (cxlsd) {
> +			cxlsd->nr_targets = nr_targets;
> +			seqlock_init(&cxlsd->target_lock);
> +			cxld = &cxlsd->cxld;
> +		}
> +	} else {
> +		alloc = kzalloc(sizeof(*cxld), GFP_KERNEL);
> +		cxld = alloc;
> +	}
> +	if (!alloc)
>  		return ERR_PTR(-ENOMEM);
>  
>  	rc = ida_alloc(&port->decoder_ida, GFP_KERNEL);
> @@ -1196,8 +1241,6 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  	get_device(&port->dev);
>  	cxld->id = rc;
>  
> -	cxld->nr_targets = nr_targets;
> -	seqlock_init(&cxld->target_lock);
>  	dev = &cxld->dev;
>  	device_initialize(dev);
>  	lockdep_set_class(&dev->mutex, &cxl_decoder_key);
> @@ -1222,7 +1265,7 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>  
>  	return cxld;
>  err:
> -	kfree(cxld);
> +	kfree(alloc);
>  	return ERR_PTR(rc);
>  }
>  
> @@ -1236,13 +1279,18 @@ static struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
>   * firmware description of CXL resources into a CXL standard decode
>   * topology.
>   */
> -struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> -					   unsigned int nr_targets)
> +struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> +						  unsigned int nr_targets)
>  {
> +	struct cxl_decoder *cxld;
> +
>  	if (!is_cxl_root(port))
>  		return ERR_PTR(-EINVAL);
>  
> -	return cxl_decoder_alloc(port, nr_targets);
> +	cxld = cxl_decoder_alloc(port, nr_targets);
> +	if (IS_ERR(cxld))
> +		return ERR_CAST(cxld);
> +	return to_cxl_switch_decoder(&cxld->dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
>  
> @@ -1257,13 +1305,18 @@ EXPORT_SYMBOL_NS_GPL(cxl_root_decoder_alloc, CXL);
>   * that sit between Switch Upstream Ports / Switch Downstream Ports and
>   * Host Bridges / Root Ports.
>   */
> -struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> -					     unsigned int nr_targets)
> +struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> +						    unsigned int nr_targets)
>  {
> +	struct cxl_decoder *cxld;
> +
>  	if (is_cxl_root(port) || is_cxl_endpoint(port))
>  		return ERR_PTR(-EINVAL);
>  
> -	return cxl_decoder_alloc(port, nr_targets);
> +	cxld = cxl_decoder_alloc(port, nr_targets);
> +	if (IS_ERR(cxld))
> +		return ERR_CAST(cxld);
> +	return to_cxl_switch_decoder(&cxld->dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
>  
> @@ -1320,7 +1373,9 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
>  
>  	port = to_cxl_port(cxld->dev.parent);
>  	if (!is_endpoint_decoder(dev)) {
> -		rc = decoder_populate_targets(cxld, port, target_map);
> +		struct cxl_switch_decoder *cxlsd = to_cxl_switch_decoder(dev);
> +
> +		rc = decoder_populate_targets(cxlsd, port, target_map);
>  		if (rc && (cxld->flags & CXL_DECODER_F_ENABLE)) {
>  			dev_err(&port->dev,
>  				"Failed to populate active decoder targets\n");
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index fd02f9e2a829..7525b55b11bb 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -220,7 +220,7 @@ enum cxl_decoder_type {
>  #define CXL_DECODER_MAX_INTERLEAVE 16
>  
>  /**
> - * struct cxl_decoder - CXL address range decode configuration
> + * struct cxl_decoder - Common CXL HDM Decoder Attributes
>   * @dev: this decoder's device
>   * @id: kernel device name id
>   * @hpa_range: Host physical address range mapped by this decoder
> @@ -228,10 +228,7 @@ enum cxl_decoder_type {
>   * @interleave_granularity: data stride per dport
>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @flags: memory type capabilities and locking
> - * @target_lock: coordinate coherent reads of the target list
> - * @nr_targets: number of elements in @target
> - * @target: active ordered target list in current decoder configuration
> - */
> +*/

?

>  struct cxl_decoder {
>  	struct device dev;
>  	int id;
> @@ -240,12 +237,22 @@ struct cxl_decoder {
>  	int interleave_granularity;
>  	enum cxl_decoder_type target_type;
>  	unsigned long flags;
> +};
> +
> +/**
> + * struct cxl_switch_decoder - Switch specific CXL HDM Decoder

Whilst you define the broad use of switch in the patch description, I think
it is worth explaining here that it's CFMWS, HB and switch decoders
(if I understand correctly - this had me very confused when looking
at the overall code)

> + * @cxld: base cxl_decoder object
> + * @target_lock: coordinate coherent reads of the target list
> + * @nr_targets: number of elements in @target
> + * @target: active ordered target list in current decoder configuration
> + */
> +struct cxl_switch_decoder {
> +	struct cxl_decoder cxld;
>  	seqlock_t target_lock;
>  	int nr_targets;
>  	struct cxl_dport *target[];
>  };
>  
> -

*grumble grumble*  Unconnected white space fix.

>  /**
>   * enum cxl_nvdimm_brige_state - state machine for managing bus rescans
>   * @CXL_NVB_NEW: Set at bridge create and after cxl_pmem_wq is destroyed
> @@ -363,10 +370,10 @@ struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
>  bool is_endpoint_decoder(struct device *dev);
> -struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> -					   unsigned int nr_targets);
> -struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> -					     unsigned int nr_targets);
> +struct cxl_switch_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
> +						  unsigned int nr_targets);
> +struct cxl_switch_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
> +						    unsigned int nr_targets);
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
>  struct cxl_decoder *cxl_endpoint_decoder_alloc(struct cxl_port *port);
>  int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 7a08b025f2de..68288354b419 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -451,9 +451,15 @@ static int mock_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  		struct cxl_decoder *cxld;
>  		int rc;
>  
> -		if (target_count)
> -			cxld = cxl_switch_decoder_alloc(port, target_count);
> -		else
> +		if (target_count) {
> +			struct cxl_switch_decoder *cxlsd;
> +
> +			cxlsd = cxl_switch_decoder_alloc(port, target_count);
> +			if (IS_ERR(cxlsd))
> +				cxld = ERR_CAST(cxlsd);

Looks cleaner to me to move error handling into the branches. You duplicate
an error print but avoid ERR_CAST mess just to cast it back to an error in the
error path a few lines later.


			if (IS_ERR(cxlsd)) {
				dev_warn(&port->dev,
					 "Failed to allocate switch decoder\n");
				return PTR_ERR(cxlsd);
			}
			cxld = &cxlsd->cxld;
		} else {
			cxld = cxl_endpoint_decoder_alloc(port);
			if (IS_ERR(cxld)) {
				dev_warn(&port->dev,
					 "Failed to allocate EP decoder\n");
				return PTR_ERR(cxld);
		}


> +			else
> +				cxld = &cxlsd->cxld;
> +		} else
>  			cxld = cxl_endpoint_decoder_alloc(port);
>  		if (IS_ERR(cxld)) {
>  			dev_warn(&port->dev,
> 

