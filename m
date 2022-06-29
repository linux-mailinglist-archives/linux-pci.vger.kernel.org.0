Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BC4560502
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 17:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbiF2P5A (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 11:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbiF2P47 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 11:56:59 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7506134;
        Wed, 29 Jun 2022 08:56:57 -0700 (PDT)
Received: from fraeml707-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY5cp3LV3z6H7fH;
        Wed, 29 Jun 2022 23:54:34 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml707-chm.china.huawei.com (10.206.15.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 17:56:55 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 16:56:54 +0100
Date:   Wed, 29 Jun 2022 16:56:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 18/46] cxl/hdm: Add support for allocating DPA to an
 endpoint decoder
Message-ID: <20220629165652.00004ca3@Huawei.com>
In-Reply-To: <165603883814.551046.17226119386543525679.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603883814.551046.17226119386543525679.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
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

On Thu, 23 Jun 2022 19:47:18 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> The region provisioning flow will roughly follow a sequence of:
> 
> 1/ Allocate DPA to a set of decoders
> 
> 2/ Allocate HPA to a region
> 
> 3/ Associate decoders with a region and validate that the DPA allocations
>    and topologies match the parameters of the region.
> 
> For now, this change (step 1) arranges for DPA capacity to be allocated
> and deleted from non-committed decoders based on the decoder's mode /
> partition selection. Capacity is allocated from the lowest DPA in the
> partition and any 'pmem' allocation blocks out all remaining ram
> capacity in its 'skip' setting. DPA allocations are enforced in decoder
> instance order. I.e. decoder N + 1 always starts at a higher DPA than
> instance N, and deleting allocations must proceed from the
> highest-instance allocated decoder to the lowest.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

The error value setting in here might save a few lines, but to me it
is less readable than setting rc in each error path.

> ---
>  Documentation/ABI/testing/sysfs-bus-cxl |   37 +++++++
>  drivers/cxl/core/core.h                 |    7 +
>  drivers/cxl/core/hdm.c                  |  160 +++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c                 |   73 ++++++++++++++
>  4 files changed, 275 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 091459216e11..85844f9bc00b 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -171,7 +171,7 @@ Date:		May, 2022
>  KernelVersion:	v5.20
>  Contact:	linux-cxl@vger.kernel.org
>  Description:
> -		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> +		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
>  		translates from a host physical address range, to a device local
>  		address range. Device-local address ranges are further split
>  		into a 'ram' (volatile memory) range and 'pmem' (persistent
> @@ -180,3 +180,38 @@ Description:
>  		when a decoder straddles the volatile/persistent partition
>  		boundary, and 'none' indicates the decoder is not actively
>  		decoding, or no DPA allocation policy has been set.
> +
> +		'mode' can be written, when the decoder is in the 'disabled'
> +		state, with either 'ram' or 'pmem' to set the boundaries for the
> +		next allocation.
> +

As before, documentation above this in the file only uses single line break between
entries.

> +
> +What:		/sys/bus/cxl/devices/decoderX.Y/dpa_resource
> +Date:		May, 2022
> +KernelVersion:	v5.20
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) When a CXL decoder is of devtype "cxl_decoder_endpoint",
> +		and its 'dpa_size' attribute is non-zero, this attribute
> +		indicates the device physical address (DPA) base address of the
> +		allocation.

Why _resource rather than _base or _start?

> +
> +
> +What:		/sys/bus/cxl/devices/decoderX.Y/dpa_size
> +Date:		May, 2022
> +KernelVersion:	v5.20
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RW) When a CXL decoder is of devtype "cxl_decoder_endpoint" it
> +		translates from a host physical address range, to a device local
> +		address range. The range, base address plus length in bytes, of
> +		DPA allocated to this decoder is conveyed in these 2 attributes.
> +		Allocations can be mutated as long as the decoder is in the
> +		disabled state. A write to 'size' releases the previous DPA

'dpa_size' ?

> +		allocation and then attempts to allocate from the free capacity
> +		in the device partition referred to by 'decoderX.Y/mode'.
> +		Allocate and free requests can only be performed on the highest
> +		instance number disabled decoder with non-zero size. I.e.
> +		allocations are enforced to occur in increasing 'decoderX.Y/id'
> +		order and frees are enforced to occur in decreasing
> +		'decoderX.Y/id' order.
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index 1a50c0fc399c..47cf0c286fc3 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -17,6 +17,13 @@ int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
>  void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  				   resource_size_t length);
>  
> +int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> +		     enum cxl_decoder_mode mode);
> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size);
> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled);
> +resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled);
> +resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled);
> +
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
>  void cxl_mbox_init(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 8805afe63ebf..ceb4c28abc1b 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -248,6 +248,166 @@ static int cxl_dpa_reserve(struct cxl_endpoint_decoder *cxled,
>  	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
>  }
>  
> +resource_size_t cxl_dpa_size(struct cxl_endpoint_decoder *cxled)
> +{
> +	resource_size_t size = 0;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	if (cxled->dpa_res)
> +		size = resource_size(cxled->dpa_res);
> +	up_read(&cxl_dpa_rwsem);
> +
> +	return size;
> +}
> +
> +resource_size_t cxl_dpa_resource(struct cxl_endpoint_decoder *cxled)

Instinct would be to expect this to return the resource, not the start.
Rename?


> +{
> +	resource_size_t base = -1;
> +
> +	down_read(&cxl_dpa_rwsem);
> +	if (cxled->dpa_res)
> +		base = cxled->dpa_res->start;
> +	up_read(&cxl_dpa_rwsem);
> +
> +	return base;
> +}
> +
> +int cxl_dpa_free(struct cxl_endpoint_decoder *cxled)
> +{
> +	int rc = -EBUSY;
> +	struct device *dev = &cxled->cxld.dev;
> +	struct cxl_port *port = to_cxl_port(dev->parent);
> +
> +	down_write(&cxl_dpa_rwsem);
> +	if (!cxled->dpa_res) {
> +		rc = 0;
> +		goto out;
> +	}
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> +		dev_dbg(dev, "decoder enabled\n");

I'd prefer explicit setting of rc = -EBUSY in the two
'error' paths to make it really clear when looking at these
that they are treated as errors.

> +		goto out;
> +	}
> +	if (cxled->cxld.id != port->dpa_end) {
> +		dev_dbg(dev, "expected decoder%d.%d\n", port->id,
> +			port->dpa_end);
> +		goto out;
> +	}
> +	__cxl_dpa_release(cxled, true);
> +	rc = 0;
> +out:
> +	up_write(&cxl_dpa_rwsem);
> +	return rc;
> +}
> +
> +int cxl_dpa_set_mode(struct cxl_endpoint_decoder *cxled,
> +		     enum cxl_decoder_mode mode)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct device *dev = &cxled->cxld.dev;
> +	int rc = -EBUSY;

As above, I'd prefer seeing error set in each error path rther
than it being set in a few locations and having to go look
for which value it currently has.  To me having the
error code next to the condition is much easier to follow.

> +
> +	switch (mode) {
> +	case CXL_DECODER_RAM:
> +	case CXL_DECODER_PMEM:
> +		break;
> +	default:
> +		dev_dbg(dev, "unsupported mode: %d\n", mode);
> +		return -EINVAL;
> +	}
> +
> +	down_write(&cxl_dpa_rwsem);
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE)
> +		goto out;
> +	/*
> +	 * Only allow modes that are supported by the current partition
> +	 * configuration
> +	 */
> +	rc = -ENXIO;
> +	if (mode == CXL_DECODER_PMEM && !resource_size(&cxlds->pmem_res)) {
> +		dev_dbg(dev, "no available pmem capacity\n");
> +		goto out;
> +	}
> +	if (mode == CXL_DECODER_RAM && !resource_size(&cxlds->ram_res)) {
> +		dev_dbg(dev, "no available ram capacity\n");
> +		goto out;
> +	}
> +
> +	cxled->mode = mode;
> +	rc = 0;
> +out:
> +	up_write(&cxl_dpa_rwsem);
> +
> +	return rc;
> +}
> +
> +int cxl_dpa_alloc(struct cxl_endpoint_decoder *cxled, unsigned long long size)
> +{
> +	struct cxl_memdev *cxlmd = cxled_to_memdev(cxled);
> +	resource_size_t free_ram_start, free_pmem_start;
> +	struct cxl_port *port = cxled_to_port(cxled);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct device *dev = &cxled->cxld.dev;
> +	resource_size_t start, avail, skip;
> +	struct resource *p, *last;
> +	int rc = -EBUSY;
> +
> +	down_write(&cxl_dpa_rwsem);
> +	if (cxled->cxld.flags & CXL_DECODER_F_ENABLE) {
> +		dev_dbg(dev, "decoder enabled\n");
> +		goto out;


-EBUSY only used in this path, so clearer to me to push that setting down
to in this  error path.


> +	}
> +
> +	for (p = cxlds->ram_res.child, last = NULL; p; p = p->sibling)
> +		last = p;
> +	if (last)
> +		free_ram_start = last->end + 1;
> +	else
> +		free_ram_start = cxlds->ram_res.start;
> +
> +	for (p = cxlds->pmem_res.child, last = NULL; p; p = p->sibling)
> +		last = p;
> +	if (last)
> +		free_pmem_start = last->end + 1;
> +	else
> +		free_pmem_start = cxlds->pmem_res.start;
> +
> +	if (cxled->mode == CXL_DECODER_RAM) {
> +		start = free_ram_start;
> +		avail = cxlds->ram_res.end - start + 1;
> +		skip = 0;
> +	} else if (cxled->mode == CXL_DECODER_PMEM) {
> +		resource_size_t skip_start, skip_end;
> +
> +		start = free_pmem_start;
> +		avail = cxlds->pmem_res.end - start + 1;
> +		skip_start = free_ram_start;
> +		skip_end = start - 1;
> +		skip = skip_end - skip_start + 1;
> +	} else {
> +		dev_dbg(dev, "mode not set\n");
> +		rc = -EINVAL;
> +		goto out;
> +	}
> +
> +	if (size > avail) {
> +		dev_dbg(dev, "%pa exceeds available %s capacity: %pa\n", &size,
> +			cxled->mode == CXL_DECODER_RAM ? "ram" : "pmem",
> +			&avail);
> +		rc = -ENOSPC;
> +		goto out;
> +	}
> +
> +	rc = __cxl_dpa_reserve(cxled, start, size, skip);
> +out:
> +	up_write(&cxl_dpa_rwsem);
> +
> +	if (rc)
> +		return rc;
> +
> +	return devm_add_action_or_reset(&port->dev, cxl_dpa_release, cxled);
> +}
> +
>  static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
>  			    int *target_map, void __iomem *hdm, int which,
>  			    u64 *dpa_base)

>  
> 

