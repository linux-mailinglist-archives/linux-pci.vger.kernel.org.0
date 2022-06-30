Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E191B5620CD
	for <lists+linux-pci@lfdr.de>; Thu, 30 Jun 2022 19:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235881AbiF3RFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Jun 2022 13:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbiF3RFs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 Jun 2022 13:05:48 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5829C338B1;
        Thu, 30 Jun 2022 10:05:46 -0700 (PDT)
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LYl7V6mg1z687rC;
        Fri,  1 Jul 2022 01:04:54 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 30 Jun 2022 19:05:43 +0200
Received: from localhost (10.81.200.250) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 30 Jun
 2022 18:05:43 +0100
Date:   Thu, 30 Jun 2022 18:05:41 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>,
        <hch@lst.de>
Subject: Re: [PATCH 42/46] cxl/hdm: Commit decoder state to hardware
Message-ID: <20220630180541.0000259c@Huawei.com>
In-Reply-To: <20220624041950.559155-17-dan.j.williams@intel.com>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <20220624041950.559155-17-dan.j.williams@intel.com>
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

On Thu, 23 Jun 2022 21:19:46 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> After all the soft validation of the region has completed, convey the
> region configuration to hardware while being careful to commit decoders
> in specification mandated order. In addition to programming the endpoint
> decoder base-addres, intereleave ways and granularity, the switch
> decoder target lists are also established.
> 
> While the kernel can enforce spec-mandated commit order, it can not
> enforce spec-mandated reset order. For example, the kernel can't stop
> someone from removing an endpoint device that is occupying decoderN in a
> switch decoder where decoderN+1 is also committed. To reset decoderN,
> decoderN+1 must be torn down first. That "tear down the world"
> implementation is saved for a follow-on patch.
> 
> Callback operations are provided for the 'commit' and 'reset'
> operations. While those callbacks may prove useful for CXL accelerators
> (Type-2 devices with memory) the primary motivation is to enable a
> simple way for cxl_test to intercept those operations.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Trivial comments only in this one.

Jonathan

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |  16 ++
>  drivers/cxl/core/hdm.c                  | 218 ++++++++++++++++++++++++
>  drivers/cxl/core/port.c                 |   1 +
>  drivers/cxl/core/region.c               | 189 ++++++++++++++++++--
>  drivers/cxl/cxl.h                       |  11 ++
>  tools/testing/cxl/test/cxl.c            |  46 +++++
>  6 files changed, 471 insertions(+), 10 deletions(-)
> 

> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 2ee62dde8b23..72f98f1a782c 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -129,6 +129,8 @@ struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
>  		return ERR_PTR(-ENXIO);
>  	}
>  
> +	dev_set_drvdata(&port->dev, cxlhdm);

Trivial, but dev == &port->dev I think so you might as well use dev.

This feels like a bit of a hack as it just so happens nothing else is
in the port drvdata.  Maybe it's better to add a pointer from
port to cxlhdm?

> +
>  	return cxlhdm;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
> @@ -444,6 +446,213 @@ int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  

> +static int cxl_decoder_commit(struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	int id = cxld->id, rc;
> +	u64 base, size;
> +	u32 ctrl;
> +
> +	if (cxld->flags & CXL_DECODER_F_ENABLE)
> +		return 0;
> +
> +	if (port->commit_end + 1 != id) {
> +		dev_dbg(&port->dev,
> +			"%s: out of order commit, expected decoder%d.%d\n",
> +			dev_name(&cxld->dev), port->id, port->commit_end + 1);
> +		return -EBUSY;
> +	}
> +
> +	down_read(&cxl_dpa_rwsem);
> +	/* common decoder settings */
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> +	cxld_set_interleave(cxld, &ctrl);
> +	cxld_set_type(cxld, &ctrl);
> +	cxld_set_hpa(cxld, &base, &size);
> +
> +	writel(upper_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(base), hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(id));
> +	writel(upper_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(id));
> +	writel(lower_32_bits(size), hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(id));
> +
> +	if (is_switch_decoder(&cxld->dev)) {
> +		struct cxl_switch_decoder *cxlsd =
> +			to_cxl_switch_decoder(&cxld->dev);
> +		void __iomem *tl_hi = hdm + CXL_HDM_DECODER0_TL_HIGH(id);
> +		void __iomem *tl_lo = hdm + CXL_HDM_DECODER0_TL_LOW(id);
> +		u64 targets;
> +
> +		rc = cxlsd_set_targets(cxlsd, &targets);
> +		if (rc) {
> +			dev_dbg(&port->dev, "%s: target configuration error\n",
> +				dev_name(&cxld->dev));
> +			goto err;
> +		}
> +
> +		writel(upper_32_bits(targets), tl_hi);
> +		writel(lower_32_bits(targets), tl_lo);
> +	} else {
> +		struct cxl_endpoint_decoder *cxled =
> +			to_cxl_endpoint_decoder(&cxld->dev);
> +		void __iomem *sk_hi = hdm + CXL_HDM_DECODER0_SKIP_HIGH(id);
> +		void __iomem *sk_lo = hdm + CXL_HDM_DECODER0_SKIP_LOW(id);
> +
> +		writel(upper_32_bits(cxled->skip), sk_hi);
> +		writel(lower_32_bits(cxled->skip), sk_lo);
> +	}
> +
> +	writel(ctrl, hdm + CXL_HDM_DECODER0_CTRL_OFFSET(id));
> +	up_read(&cxl_dpa_rwsem);
> +
> +	port->commit_end++;

Obviously doesn't matter as resetting on error, but
feels like the increment of commit_end++ should only follow
succesful commit / await_commit();

> +	rc = cxld_await_commit(hdm, cxld->id);
> +err:
> +	if (rc) {
> +		dev_dbg(&port->dev, "%s: error %d committing decoder\n",
> +			dev_name(&cxld->dev), rc);
> +		cxld->reset(cxld);
> +		return rc;
> +	}
> +	cxld->flags |= CXL_DECODER_F_ENABLE;
> +
> +	return 0;
> +}
> +
> +static int cxl_decoder_reset(struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	struct cxl_hdm *cxlhdm = dev_get_drvdata(&port->dev);
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	int id = cxld->id;
> +	u32 ctrl;
> +
> +	if ((cxld->flags & CXL_DECODER_F_ENABLE) ==  0)

extra space after ==

> +		return 0;
> +

...


>  		
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 7034300e72b2..eee1615d2319 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -630,6 +630,7 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>  	port->component_reg_phys = component_reg_phys;
>  	ida_init(&port->decoder_ida);
>  	port->dpa_end = -1;
> +	port->commit_end = -1;
>  	xa_init(&port->dports);
>  	xa_init(&port->endpoints);
>  	xa_init(&port->regions);
> diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
> index 071b8cafe2bb..b90160c4f975 100644
> --- a/drivers/cxl/core/region.c
> +++ b/drivers/cxl/core/region.c
> @@ -112,6 +112,168 @@ static ssize_t uuid_store(struct device *dev, struct device_attribute *attr,
>  }
>  static DEVICE_ATTR_RW(uuid);

...


> +static int cxl_region_decode_reset(struct cxl_region *cxlr, int count)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int i;
> +
> +	for (i = count - 1; i >= 0; i--) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +		struct cxl_port *iter = cxled_to_port(cxled);
> +		struct cxl_ep *ep;
> +		int rc;
> +
> +		while (!is_cxl_root(to_cxl_port(iter->dev.parent)))
> +			iter = to_cxl_port(iter->dev.parent);
> +
> +		for (ep = cxl_ep_load(iter, cxlmd); iter;
> +		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
> +			struct cxl_region_ref *cxl_rr;
> +			struct cxl_decoder *cxld;
> +
> +			cxl_rr = cxl_rr_load(iter, cxlr);
> +			cxld = cxl_rr->decoder;
> +			rc = cxld->reset(cxld);
> +			if (rc)
> +				return rc;
> +		}
> +
> +		rc = cxled->cxld.reset(&cxled->cxld);
> +		if (rc)
> +			return rc;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_region_decode_commit(struct cxl_region *cxlr)
> +{
> +	struct cxl_region_params *p = &cxlr->params;
> +	int i, rc;
> +
> +	for (i = 0; i < p->nr_targets; i++) {
> +		struct cxl_endpoint_decoder *cxled = p->targets[i];
> +		struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +		struct cxl_region_ref *cxl_rr;
> +		struct cxl_decoder *cxld;
> +		struct cxl_port *iter;
> +		struct cxl_ep *ep;
> +
> +		/* commit bottom up */
> +		for (iter = cxled_to_port(cxled); !is_cxl_root(iter);
> +		     iter = to_cxl_port(iter->dev.parent)) {
> +			cxl_rr = cxl_rr_load(iter, cxlr);
> +			cxld = cxl_rr->decoder;
> +			rc = cxld->commit(cxld);
> +			if (rc)
> +				break;
> +		}
> +
> +		if (is_cxl_root(iter))
> +			continue;
> +
> +		/* teardown top down */

Comment on why we are tearing down.  I guess because previous
somehow didn't end up at the root?

> +		for (ep = cxl_ep_load(iter, cxlmd); ep && iter;
> +		     iter = ep->next, ep = cxl_ep_load(iter, cxlmd)) {
> +			cxl_rr = cxl_rr_load(iter, cxlr);
> +			cxld = cxl_rr->decoder;
> +			cxld->reset(cxld);
> +		}
> +
> +		cxled->cxld.reset(&cxled->cxld);
> +		if (i == 0)
> +			return rc;
> +		break;
> +	}
> +
> +	if (i >= p->nr_targets)
> +		return 0;
> +
> +	/* undo the targets that were successfully committed */
> +	cxl_region_decode_reset(cxlr, i);
> +	return rc;
> +}
> +
> +static ssize_t commit_store(struct device *dev, struct device_attribute *attr,
> +			    const char *buf, size_t len)
> +{
> +	struct cxl_region *cxlr = to_cxl_region(dev);
> +	struct cxl_region_params *p = &cxlr->params;
> +	bool commit;
> +	ssize_t rc;
> +
> +	rc = kstrtobool(buf, &commit);
> +	if (rc)
> +		return rc;
> +
> +	rc = down_write_killable(&cxl_region_rwsem);
> +	if (rc)
> +		return rc;
> +
> +	/* Already in the requested state? */
> +	if (commit && p->state >= CXL_CONFIG_COMMIT)
> +		goto out;
> +	if (!commit && p->state < CXL_CONFIG_COMMIT)
> +		goto out;
> +
> +	/* Not ready to commit? */
> +	if (commit && p->state < CXL_CONFIG_ACTIVE) {
> +		rc = -ENXIO;
> +		goto out;
> +	}
> +
> +	if (commit)
> +		rc = cxl_region_decode_commit(cxlr);
> +	else {
> +		p->state = CXL_CONFIG_RESET_PENDING;
> +		up_write(&cxl_region_rwsem);
> +		device_release_driver(&cxlr->dev);
> +		down_write(&cxl_region_rwsem);
> +
> +		if (p->state == CXL_CONFIG_RESET_PENDING)

What path results in that changing in last few lines?
Perhaps a comment if there is something we need to protect against?


> +			rc = cxl_region_decode_reset(cxlr, p->interleave_ways);
> +	}
> +
> +	if (rc)
> +		goto out;
> +
> +	if (commit)
> +		p->state = CXL_CONFIG_COMMIT;
> +	else if (p->state == CXL_CONFIG_RESET_PENDING)
> +		p->state = CXL_CONFIG_ACTIVE;
> +
> +out:
> +	up_write(&cxl_region_rwsem);
> +
> +	if (rc)
> +		return rc;
> +	return len;
> +}


...


> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a93d7c4efd1a..fc14f6805f2c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -54,6 +54,7 @@
>  #define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
>  #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
>  #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
>  #define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
>  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
>  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> @@ -257,6 +258,8 @@ enum cxl_decoder_type {
>   * @target_type: accelerator vs expander (type2 vs type3) selector
>   * @region: currently assigned region for this decoder
>   * @flags: memory type capabilities and locking
> + * @commit: device/decoder-type specific callback to commit settings to hw
> + * @commit: device/decoder-type specific callback to reset hw settings

@reset

>  */
>  struct cxl_decoder {
>  	struct device dev;
> @@ -267,6 +270,8 @@ struct cxl_decoder {
>  	enum cxl_decoder_type target_type;
>  	struct cxl_region *region;
>  	unsigned long flags;
> +	int (*commit)(struct cxl_decoder *cxld);
> +	int (*reset)(struct cxl_decoder *cxld);
>  };
>  


> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index 51d517fa62ee..94653201631c 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -429,6 +429,50 @@ static int map_targets(struct device *dev, void *data)
>  	return 0;
>  }
>  

...

> +static int mock_decoder_reset(struct cxl_decoder *cxld)
> +{
> +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> +	int id = cxld->id;
> +
> +	if ((cxld->flags & CXL_DECODER_F_ENABLE) ==  0)

bonus space after ==


> +		return 0;
> +
> +	dev_dbg(&port->dev, "%s reset\n", dev_name(&cxld->dev));
> +	if (port->commit_end != id) {
> +		dev_dbg(&port->dev,
> +			"%s: out of order reset, expected decoder%d.%d\n",
> +			dev_name(&cxld->dev), port->id, port->commit_end);
> +		return -EBUSY;
> +	}
> +
> +	port->commit_end--;
> +	cxld->flags &= ~CXL_DECODER_F_ENABLE;
> +
> +	return 0;
> +}
> 

