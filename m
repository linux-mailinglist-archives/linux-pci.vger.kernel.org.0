Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA314A5402
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 01:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiBAAYk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 19:24:40 -0500
Received: from mga05.intel.com ([192.55.52.43]:25238 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229945AbiBAAYk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 31 Jan 2022 19:24:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643675080; x=1675211080;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=m1R7cr6OIXa53vZXfOjUgTIaxKSyR6mZ2fu+tc7NLhA=;
  b=XqsmUOyyh0/Tl4CdnuLM0kUh5k5zE5/bxuSNvonHPCLnWHtrsTCEXN4X
   UtAuFDpa/CJU1nXhc607m/kHX34LehPEfbIj3gHCVyZd9AgzQ1ynThnqw
   EAwJ6wsw21wfM6cChVgcApicLYG0SwAXNFvwRB1OgB5xRK1x7B+4suDSH
   0lVnoa7pcAmSF5VcfDSU09P4gK4NMBymCRUVudHmhzH0BNfk+Ffq/rwpD
   yjoab3drxp6yWa+eyjP01WCv4txZGSVmLDj9tz/9B+iYdHzIpjUS6QChq
   C9rhQZlTABAaFIajdS7bZ8wEON1Pb1mYml79m1yYsG8Bb2sYPR8Sq2dUN
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="333944250"
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="333944250"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 16:24:38 -0800
X-IronPort-AV: E=Sophos;i="5.88,332,1635231600"; 
   d="scan'208";a="537572649"
Received: from sssheth-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.130.247])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 16:24:37 -0800
Date:   Mon, 31 Jan 2022 16:24:35 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Subject: Re: [PATCH v3 22/40] cxl/core/hdm: Add CXL standard decoder
 enumeration to the core
Message-ID: <20220201002435.oodbf3xuhb7xknus@intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
 <164298423561.3018233.8938479363856921038.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164298423561.3018233.8938479363856921038.stgit@dwillia2-desk3.amr.corp.intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-23 16:30:35, Dan Williams wrote:
> Unlike the decoder enumeration for "root decoders" described by platform
> firmware, standard coders can be enumerated from the component registers
                     ^ decoders

> space once the base address has been identified (via PCI, ACPI, or
> another mechanism).
> 
> Add common infrastructure for HDM (Host-managed-Device-Memory) Decoder
> enumeration and share it between host-bridge, upstream switch port, and
> cxl_test defined decoders.
> 
> The locking model for switch level decoders is to hold the port lock
> over the enumeration. This facilitates moving the dport and decoder
> enumeration to a 'port' driver. For now, the only enumerator of decoder
> resources is the cxl_acpi root driver.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

I authored some parts of this patch, not sure how much percentage-wise. If it
was intentional to drop me, that's fine - just checking.

Some comments below.

Reviewed-by: Ben Widawsky <ben.widawsky@intel.com>

> ---
>  drivers/cxl/acpi.c            |   43 ++-----
>  drivers/cxl/core/Makefile     |    1 
>  drivers/cxl/core/core.h       |    2 
>  drivers/cxl/core/hdm.c        |  247 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c       |   65 ++++++++---
>  drivers/cxl/core/regs.c       |    5 -
>  drivers/cxl/cxl.h             |   33 ++++-
>  drivers/cxl/cxlmem.h          |    8 +
>  tools/testing/cxl/Kbuild      |    4 +
>  tools/testing/cxl/test/cxl.c  |   29 +++++
>  tools/testing/cxl/test/mock.c |   50 ++++++++
>  tools/testing/cxl/test/mock.h |    3 
>  12 files changed, 436 insertions(+), 54 deletions(-)
>  create mode 100644 drivers/cxl/core/hdm.c
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 259441245687..8c2ced91518b 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -168,10 +168,10 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	struct device *host = root_port->dev.parent;
>  	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
>  	struct acpi_pci_root *pci_root;
> -	int single_port_map[1], rc;
> -	struct cxl_decoder *cxld;
>  	struct cxl_dport *dport;
> +	struct cxl_hdm *cxlhdm;
>  	struct cxl_port *port;
> +	int rc;
>  
>  	if (!bridge)
>  		return 0;
> @@ -200,37 +200,24 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	rc = devm_cxl_port_enumerate_dports(host, port);
>  	if (rc < 0)
>  		return rc;
> -	if (rc > 1)
> -		return 0;
> -
> -	/* TODO: Scan CHBCR for HDM Decoder resources */
> -
> -	/*
> -	 * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
> -	 * Structure) single ported host-bridges need not publish a decoder
> -	 * capability when a passthrough decode can be assumed, i.e. all
> -	 * transactions that the uport sees are claimed and passed to the single
> -	 * dport. Disable the range until the first CXL region is enumerated /
> -	 * activated.
> -	 */
> -	cxld = cxl_switch_decoder_alloc(port, 1);
> -	if (IS_ERR(cxld))
> -		return PTR_ERR(cxl);
> -
>  	cxl_device_lock(&port->dev);
> -	dport = list_first_entry(&port->dports, typeof(*dport), list);
> -	cxl_device_unlock(&port->dev);
> +	if (rc == 1) {
> +		rc = devm_cxl_add_passthrough_decoder(host, port);
> +		goto out;
> +	}
>  
> -	single_port_map[0] = dport->port_id;
> +	cxlhdm = devm_cxl_setup_hdm(host, port);
> +	if (IS_ERR(cxlhdm)) {
> +		rc = PTR_ERR(cxlhdm);
> +		goto out;
> +	}
>  
> -	rc = cxl_decoder_add(cxld, single_port_map);
> +	rc = devm_cxl_enumerate_decoders(host, cxlhdm);
>  	if (rc)
> -		put_device(&cxld->dev);
> -	else
> -		rc = cxl_decoder_autoremove(host, cxld);
> +		dev_err(&port->dev, "Couldn't enumerate decoders (%d)\n", rc);
>  
> -	if (rc == 0)
> -		dev_dbg(host, "add: %s\n", dev_name(&cxld->dev));
> +out:
> +	cxl_device_unlock(&port->dev);
>  	return rc;
>  }
>  
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 91057f0ec763..6d37cd78b151 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -8,3 +8,4 @@ cxl_core-y += regs.o
>  cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
>  cxl_core-y += pci.o
> +cxl_core-y += hdm.o
> diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
> index e0c9aacc4e9c..1a50c0fc399c 100644
> --- a/drivers/cxl/core/core.h
> +++ b/drivers/cxl/core/core.h
> @@ -14,6 +14,8 @@ struct cxl_mem_query_commands;
>  int cxl_query_cmd(struct cxl_memdev *cxlmd,
>  		  struct cxl_mem_query_commands __user *q);
>  int cxl_send_cmd(struct cxl_memdev *cxlmd, struct cxl_send_command __user *s);
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +				   resource_size_t length);
>  
>  int cxl_memdev_init(void);
>  void cxl_memdev_exit(void);
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> new file mode 100644
> index 000000000000..802048dc2046
> --- /dev/null
> +++ b/drivers/cxl/core/hdm.c
> @@ -0,0 +1,247 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2022 Intel Corporation. All rights reserved. */
> +#include <linux/io-64-nonatomic-hi-lo.h>
> +#include <linux/device.h>
> +#include <linux/delay.h>
> +
> +#include "cxlmem.h"
> +#include "core.h"
> +
> +/**
> + * DOC: cxl core hdm
> + *
> + * Compute Express Link Host Managed Device Memory, starting with the
> + * CXL 2.0 specification, is managed by an array of HDM Decoder register
> + * instances per CXL port and per CXL endpoint. Define common helpers
> + * for enumerating these registers and capabilities.
> + */
> +
> +static int add_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> +			   int *target_map)
> +{
> +	int rc;
> +
> +	rc = cxl_decoder_add_locked(cxld, target_map);
> +	if (rc) {
> +		put_device(&cxld->dev);
> +		dev_err(&port->dev, "Failed to add decoder\n");
> +		return rc;
> +	}
> +
> +	rc = cxl_decoder_autoremove(&port->dev, cxld);
> +	if (rc)
> +		return rc;
> +
> +	dev_dbg(&cxld->dev, "Added to port %s\n", dev_name(&port->dev));
> +
> +	return 0;
> +}
> +
> +/*
> + * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability Structure)
> + * single ported host-bridges need not publish a decoder capability when a
> + * passthrough decode can be assumed, i.e. all transactions that the uport sees
> + * are claimed and passed to the single dport. Disable the range until the first
> + * CXL region is enumerated / activated.
> + */
> +int devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port)
> +{
> +	struct cxl_decoder *cxld;
> +	struct cxl_dport *dport;
> +	int single_port_map[1];
> +
> +	cxld = cxl_switch_decoder_alloc(port, 1);
> +	if (IS_ERR(cxld))
> +		return PTR_ERR(cxld);
> +
> +	device_lock_assert(&port->dev);
> +
> +	dport = list_first_entry(&port->dports, typeof(*dport), list);
> +	single_port_map[0] = dport->port_id;
> +
> +	return add_hdm_decoder(port, cxld, single_port_map);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_passthrough_decoder, CXL);

Hmm, this makes me realize I need to modify the region driver to not care about
finding decoder resources for a passthrough decoder.
> +
> +static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
> +{
> +	u32 hdm_cap;
> +
> +	hdm_cap = readl(cxlhdm->regs.hdm_decoder + CXL_HDM_DECODER_CAP_OFFSET);
> +	cxlhdm->decoder_count = cxl_hdm_decoder_count(hdm_cap);
> +	cxlhdm->target_count =
> +		FIELD_GET(CXL_HDM_DECODER_TARGET_COUNT_MASK, hdm_cap);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_11_8, hdm_cap))
> +		cxlhdm->interleave_mask |= GENMASK(11, 8);
> +	if (FIELD_GET(CXL_HDM_DECODER_INTERLEAVE_14_12, hdm_cap))
> +		cxlhdm->interleave_mask |= GENMASK(14, 12);
> +}
> +
> +static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
> +					  void __iomem *crb)
> +{
> +	struct cxl_register_map map;
> +	struct cxl_component_reg_map *comp_map = &map.component_map;
> +
> +	cxl_probe_component_regs(&port->dev, crb, comp_map);
> +	if (!comp_map->hdm_decoder.valid) {
> +		dev_err(&port->dev, "HDM decoder registers invalid\n");
> +		return IOMEM_ERR_PTR(-ENXIO);
> +	}
> +
> +	return crb + comp_map->hdm_decoder.offset;
> +}
> +
> +/**
> + * devm_cxl_setup_hdm - map HDM decoder component registers
> + * @port: cxl_port to map
> + */

This got messed up on the fixup. You need @host and @port at this point. It'd be
pretty cool if we could skip straight to not @host arg.

> +struct cxl_hdm *devm_cxl_setup_hdm(struct device *host, struct cxl_port *port)
> +{
> +	void __iomem *crb, __iomem *hdm;
> +	struct device *dev = &port->dev;
> +	struct cxl_hdm *cxlhdm;
> +
> +	cxlhdm = devm_kzalloc(host, sizeof(*cxlhdm), GFP_KERNEL);
> +	if (!cxlhdm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlhdm->port = port;
> +	crb = devm_cxl_iomap_block(host, port->component_reg_phys,
> +				   CXL_COMPONENT_REG_BLOCK_SIZE);
> +	if (!crb) {
> +		dev_err(dev, "No component registers mapped\n");
> +		return ERR_PTR(-ENXIO);
> +	}

Does this work if the port is operating in passthrough decoder mode? Is the idea
to just not call this thing if so?

> +
> +	hdm = map_hdm_decoder_regs(port, crb);
> +	if (IS_ERR(hdm))
> +		return ERR_CAST(hdm);
> +	cxlhdm->regs.hdm_decoder = hdm;
> +
> +	parse_hdm_decoder_caps(cxlhdm);
> +	if (cxlhdm->decoder_count == 0) {
> +		dev_err(dev, "Spec violation. Caps invalid\n");
> +		return ERR_PTR(-ENXIO);
> +	}
> +
> +	return cxlhdm;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_setup_hdm, CXL);
> +
> +static int to_interleave_granularity(u32 ctrl)
> +{
> +	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IG_MASK, ctrl);
> +
> +	return 256 << val;
> +}
> +
> +static int to_interleave_ways(u32 ctrl)
> +{
> +	int val = FIELD_GET(CXL_HDM_DECODER0_CTRL_IW_MASK, ctrl);
> +
> +	switch (val) {
> +	case 0 ... 4:
> +		return 1 << val;
> +	case 8 ... 10:
> +		return 3 << (val - 8);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
> +			     void __iomem *hdm, int which)
> +{
> +	u64 size, base;
> +	u32 ctrl;
> +	int i;
> +	union {
> +		u64 value;
> +		unsigned char target_id[8];
> +	} target_list;
> +
> +	ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(which));
> +	base = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_BASE_LOW_OFFSET(which));
> +	size = ioread64_hi_lo(hdm + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(which));
> +
> +	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
> +		size = 0;
> +
> +	cxld->decoder_range = (struct range) {
> +		.start = base,
> +		.end = base + size - 1,
> +	};
> +
> +	/* switch decoders are always enabled if committed */
> +	if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED) {
> +		cxld->flags |= CXL_DECODER_F_ENABLE;
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_LOCK)
> +			cxld->flags |= CXL_DECODER_F_LOCK;
> +	}
> +	cxld->interleave_ways = to_interleave_ways(ctrl);
> +	cxld->interleave_granularity = to_interleave_granularity(ctrl);
> +
> +	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
> +		cxld->target_type = CXL_DECODER_EXPANDER;
> +	else
> +		cxld->target_type = CXL_DECODER_ACCELERATOR;
> +
> +	target_list.value =
> +		ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
> +	for (i = 0; i < cxld->interleave_ways; i++)
> +		target_map[i] = target_list.target_id[i];
> +}
> +
> +/**
> + * devm_cxl_enumerate_decoders - add decoder objects per HDM register set
> + * @port: cxl_port HDM capability to scan
> + */
> +int devm_cxl_enumerate_decoders(struct device *host, struct cxl_hdm *cxlhdm)
> +{
> +	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
> +	struct cxl_port *port = cxlhdm->port;
> +	int i, committed;
> +	u32 ctrl;
> +
> +	/*
> +	 * Since the register resource was recently claimed via request_region()
> +	 * be careful about trusting the "not-committed" status until the commit
> +	 * timeout has elapsed.  The commit timeout is 10ms (CXL 2.0
> +	 * 8.2.5.12.20), but double it to be tolerant of any clock skew between
> +	 * host and target.
> +	 */
> +	for (i = 0, committed = 0; i < cxlhdm->decoder_count; i++) {
> +		ctrl = readl(hdm + CXL_HDM_DECODER0_CTRL_OFFSET(i));
> +		if (ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED)
> +			committed++;
> +	}
> +
> +	/* ensure that future checks of committed can be trusted */
> +	if (committed != cxlhdm->decoder_count)
> +		msleep(20);
> +
> +	for (i = 0; i < cxlhdm->decoder_count; i++) {
> +		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };
> +		int rc, target_count = cxlhdm->target_count;
> +		struct cxl_decoder *cxld;
> +
> +		cxld = cxl_switch_decoder_alloc(port, target_count);
> +		if (IS_ERR(cxld)) {
> +			dev_warn(&port->dev,
> +				 "Failed to allocate the decoder\n");
> +			return PTR_ERR(cxld);
> +		}
> +
> +		init_hdm_decoder(cxld, target_map, cxlhdm->regs.hdm_decoder, i);
> +		rc = add_hdm_decoder(port, cxld, target_map);
> +		if (rc) {
> +			dev_warn(&port->dev,
> +				 "Failed to add decoder to switch port\n");
> +			return rc;
> +		}
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, CXL);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 777de6d91dde..72633865b386 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -591,33 +591,27 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
>  static int decoder_populate_targets(struct cxl_decoder *cxld,
>  				    struct cxl_port *port, int *target_map)
>  {
> -	int rc = 0, i;
> +	int i;
>  
>  	if (!target_map)
>  		return 0;
>  
> -	cxl_device_lock(&port->dev);
> -	if (list_empty(&port->dports)) {
> -		rc = -EINVAL;
> -		goto out_unlock;
> -	}
> +	device_lock_assert(&port->dev);
> +
> +	if (list_empty(&port->dports))
> +		return -EINVAL;
>  
>  	write_seqlock(&cxld->target_lock);
>  	for (i = 0; i < cxld->nr_targets; i++) {
>  		struct cxl_dport *dport = find_dport(port, target_map[i]);
>  
> -		if (!dport) {
> -			rc = -ENXIO;
> -			goto out_unlock;
> -		}
> +		if (!dport)
> +			return -ENXIO;
>  		cxld->target[i] = dport;
>  	}
>  	write_sequnlock(&cxld->target_lock);
>  
> -out_unlock:
> -	cxl_device_unlock(&port->dev);
> -
> -	return rc;
> +	return 0;
>  }
>  
>  /**
> @@ -713,7 +707,7 @@ struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
>  EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
>  
>  /**
> - * cxl_decoder_add - Add a decoder with targets
> + * cxl_decoder_add_locked - Add a decoder with targets
>   * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
>   * @target_map: A list of downstream ports that this decoder can direct memory
>   *              traffic to. These numbers should correspond with the port number
> @@ -723,12 +717,15 @@ EXPORT_SYMBOL_NS_GPL(cxl_switch_decoder_alloc, CXL);
>   * is an endpoint device. A more awkward example is a hostbridge whose root
>   * ports get hot added (technically possible, though unlikely).
>   *
> - * Context: Process context. Takes and releases the cxld's device lock.
> + * This is the locked variant of cxl_decoder_add().
> + *
> + * Context: Process context. Expects the device lock of the port that owns the
> + *	    @cxld to be held.
>   *
>   * Return: Negative error code if the decoder wasn't properly configured; else
>   *	   returns 0.
>   */
> -int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
> +int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
>  {
>  	struct cxl_port *port;
>  	struct device *dev;
> @@ -762,6 +759,40 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
>  
>  	return device_add(dev);
>  }
> +EXPORT_SYMBOL_NS_GPL(cxl_decoder_add_locked, CXL);
> +
> +/**
> + * cxl_decoder_add - Add a decoder with targets
> + * @cxld: The cxl decoder allocated by cxl_decoder_alloc()
> + * @target_map: A list of downstream ports that this decoder can direct memory
> + *              traffic to. These numbers should correspond with the port number
> + *              in the PCIe Link Capabilities structure.
> + *
> + * This is the unlocked variant of cxl_decoder_add_locked().
> + * See cxl_decoder_add_locked().
> + *
> + * Context: Process context. Takes and releases the device lock of the port that
> + *	    owns the @cxld.
> + */
> +int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
> +{
> +	struct cxl_port *port;
> +	int rc;
> +
> +	if (WARN_ON_ONCE(!cxld))
> +		return -EINVAL;
> +
> +	if (WARN_ON_ONCE(IS_ERR(cxld)))
> +		return PTR_ERR(cxld);
> +
> +	port = to_cxl_port(cxld->dev.parent);
> +
> +	cxl_device_lock(&port->dev);
> +	rc = cxl_decoder_add_locked(cxld, target_map);
> +	cxl_device_unlock(&port->dev);
> +
> +	return rc;
> +}
>  EXPORT_SYMBOL_NS_GPL(cxl_decoder_add, CXL);
>  
>  static void cxld_unregister(void *dev)
> diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
> index 65d7f5880671..718b6b0ae4b3 100644
> --- a/drivers/cxl/core/regs.c
> +++ b/drivers/cxl/core/regs.c
> @@ -159,9 +159,8 @@ void cxl_probe_device_regs(struct device *dev, void __iomem *base,
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_probe_device_regs, CXL);
>  
> -static void __iomem *devm_cxl_iomap_block(struct device *dev,
> -					  resource_size_t addr,
> -					  resource_size_t length)
> +void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
> +				   resource_size_t length)
>  {
>  	void __iomem *ret_val;
>  	struct resource *res;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 7de9504bc995..ca3777061181 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -17,6 +17,9 @@
>   * (port-driver, region-driver, nvdimm object-drivers... etc).
>   */
>  
> +/* CXL 2.0 8.2.4 CXL Component Register Layout and Definition */
> +#define CXL_COMPONENT_REG_BLOCK_SIZE SZ_64K
> +
>  /* CXL 2.0 8.2.5 CXL.cache and CXL.mem Registers*/
>  #define CXL_CM_OFFSET 0x1000
>  #define CXL_CM_CAP_HDR_OFFSET 0x0
> @@ -36,11 +39,23 @@
>  #define CXL_HDM_DECODER_CAP_OFFSET 0x0
>  #define   CXL_HDM_DECODER_COUNT_MASK GENMASK(3, 0)
>  #define   CXL_HDM_DECODER_TARGET_COUNT_MASK GENMASK(7, 4)
> -#define CXL_HDM_DECODER0_BASE_LOW_OFFSET 0x10
> -#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET 0x14
> -#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET 0x18
> -#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET 0x1c
> -#define CXL_HDM_DECODER0_CTRL_OFFSET 0x20
> +#define   CXL_HDM_DECODER_INTERLEAVE_11_8 BIT(8)
> +#define   CXL_HDM_DECODER_INTERLEAVE_14_12 BIT(9)
> +#define CXL_HDM_DECODER_CTRL_OFFSET 0x4
> +#define   CXL_HDM_DECODER_ENABLE BIT(1)
> +#define CXL_HDM_DECODER0_BASE_LOW_OFFSET(i) (0x20 * (i) + 0x10)
> +#define CXL_HDM_DECODER0_BASE_HIGH_OFFSET(i) (0x20 * (i) + 0x14)
> +#define CXL_HDM_DECODER0_SIZE_LOW_OFFSET(i) (0x20 * (i) + 0x18)
> +#define CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(i) (0x20 * (i) + 0x1c)
> +#define CXL_HDM_DECODER0_CTRL_OFFSET(i) (0x20 * (i) + 0x20)
> +#define   CXL_HDM_DECODER0_CTRL_IG_MASK GENMASK(3, 0)
> +#define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> +#define   CXL_HDM_DECODER0_CTRL_LOCK BIT(8)
> +#define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> +#define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> +#define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
> +#define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> +#define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
>  
>  static inline int cxl_hdm_decoder_count(u32 cap_hdr)
>  {
> @@ -162,7 +177,8 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  #define CXL_DECODER_F_TYPE2 BIT(2)
>  #define CXL_DECODER_F_TYPE3 BIT(3)
>  #define CXL_DECODER_F_LOCK  BIT(4)
> -#define CXL_DECODER_F_MASK  GENMASK(4, 0)
> +#define CXL_DECODER_F_ENABLE    BIT(5)
> +#define CXL_DECODER_F_MASK  GENMASK(5, 0)
>  
>  enum cxl_decoder_type {
>         CXL_DECODER_ACCELERATOR = 2,
> @@ -300,7 +316,12 @@ struct cxl_decoder *cxl_root_decoder_alloc(struct cxl_port *port,
>  struct cxl_decoder *cxl_switch_decoder_alloc(struct cxl_port *port,
>  					     unsigned int nr_targets);
>  int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map);
> +int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map);
>  int cxl_decoder_autoremove(struct device *host, struct cxl_decoder *cxld);
> +struct cxl_hdm;
> +struct cxl_hdm *devm_cxl_setup_hdm(struct device *host, struct cxl_port *port);
> +int devm_cxl_enumerate_decoders(struct device *host, struct cxl_hdm *cxlhdm);
> +int devm_cxl_add_passthrough_decoder(struct device *host, struct cxl_port *port);
>  
>  extern struct bus_type cxl_bus_type;
>  
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index 8d96d009ad90..fca2d1b5f6ff 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -264,4 +264,12 @@ int cxl_mem_create_range_info(struct cxl_dev_state *cxlds);
>  struct cxl_dev_state *cxl_dev_state_create(struct device *dev);
>  void set_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
>  void clear_exclusive_cxl_commands(struct cxl_dev_state *cxlds, unsigned long *cmds);
> +
> +struct cxl_hdm {
> +	struct cxl_component_regs regs;
> +	unsigned int decoder_count;
> +	unsigned int target_count;
> +	unsigned int interleave_mask;
> +	struct cxl_port *port;
> +};
>  #endif /* __CXL_MEM_H__ */
> diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
> index 61123544aa49..3045d7cba0db 100644
> --- a/tools/testing/cxl/Kbuild
> +++ b/tools/testing/cxl/Kbuild
> @@ -5,6 +5,9 @@ ldflags-y += --wrap=acpi_evaluate_integer
>  ldflags-y += --wrap=acpi_pci_find_root
>  ldflags-y += --wrap=nvdimm_bus_register
>  ldflags-y += --wrap=devm_cxl_port_enumerate_dports
> +ldflags-y += --wrap=devm_cxl_setup_hdm
> +ldflags-y += --wrap=devm_cxl_add_passthrough_decoder
> +ldflags-y += --wrap=devm_cxl_enumerate_decoders
>  
>  DRIVERS := ../../../drivers
>  CXL_SRC := $(DRIVERS)/cxl
> @@ -31,6 +34,7 @@ cxl_core-y += $(CXL_CORE_SRC)/regs.o
>  cxl_core-y += $(CXL_CORE_SRC)/memdev.o
>  cxl_core-y += $(CXL_CORE_SRC)/mbox.o
>  cxl_core-y += $(CXL_CORE_SRC)/pci.o
> +cxl_core-y += $(CXL_CORE_SRC)/hdm.o
>  cxl_core-y += config_check.o
>  
>  obj-m += test/
> diff --git a/tools/testing/cxl/test/cxl.c b/tools/testing/cxl/test/cxl.c
> index ef002e909d38..81c09380c537 100644
> --- a/tools/testing/cxl/test/cxl.c
> +++ b/tools/testing/cxl/test/cxl.c
> @@ -8,6 +8,7 @@
>  #include <linux/acpi.h>
>  #include <linux/pci.h>
>  #include <linux/mm.h>
> +#include <cxlmem.h>
>  #include "mock.h"
>  
>  #define NR_CXL_HOST_BRIDGES 4
> @@ -398,6 +399,31 @@ static struct acpi_pci_root *mock_acpi_pci_find_root(acpi_handle handle)
>  	return &mock_pci_root[host_bridge_index(adev)];
>  }
>  
> +static struct cxl_hdm *mock_cxl_setup_hdm(struct device *host,
> +					  struct cxl_port *port)
> +{
> +	struct cxl_hdm *cxlhdm = devm_kzalloc(&port->dev, sizeof(*cxlhdm), GFP_KERNEL);
> +
> +	if (!cxlhdm)
> +		return ERR_PTR(-ENOMEM);
> +
> +	cxlhdm->port = port;
> +	return cxlhdm;
> +}
> +
> +static int mock_cxl_add_passthrough_decoder(struct device *host,
> +					    struct cxl_port *port)
> +{
> +	dev_err(&port->dev, "unexpected passthrough decoder for cxl_test\n");
> +	return -EOPNOTSUPP;
> +}
> +
> +static int mock_cxl_enumerate_decoders(struct device *host,
> +				       struct cxl_hdm *cxlhdm)
> +{
> +	return 0;
> +}
> +
>  static int mock_cxl_port_enumerate_dports(struct device *host,
>  					  struct cxl_port *port)
>  {
> @@ -439,6 +465,9 @@ static struct cxl_mock_ops cxl_mock_ops = {
>  	.acpi_evaluate_integer = mock_acpi_evaluate_integer,
>  	.acpi_pci_find_root = mock_acpi_pci_find_root,
>  	.devm_cxl_port_enumerate_dports = mock_cxl_port_enumerate_dports,
> +	.devm_cxl_setup_hdm = mock_cxl_setup_hdm,
> +	.devm_cxl_add_passthrough_decoder = mock_cxl_add_passthrough_decoder,
> +	.devm_cxl_enumerate_decoders = mock_cxl_enumerate_decoders,
>  	.list = LIST_HEAD_INIT(cxl_mock_ops.list),
>  };
>  
> diff --git a/tools/testing/cxl/test/mock.c b/tools/testing/cxl/test/mock.c
> index 56b4b7d734bc..18d3b65e2a9b 100644
> --- a/tools/testing/cxl/test/mock.c
> +++ b/tools/testing/cxl/test/mock.c
> @@ -131,6 +131,56 @@ __wrap_nvdimm_bus_register(struct device *dev,
>  }
>  EXPORT_SYMBOL_GPL(__wrap_nvdimm_bus_register);
>  
> +struct cxl_hdm *__wrap_devm_cxl_setup_hdm(struct device *host,
> +					  struct cxl_port *port)
> +{
> +	int index;
> +	struct cxl_hdm *cxlhdm;
> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> +
> +	if (ops && ops->is_mock_port(port->uport))
> +		cxlhdm = ops->devm_cxl_setup_hdm(host, port);
> +	else
> +		cxlhdm = devm_cxl_setup_hdm(host, port);
> +	put_cxl_mock_ops(index);
> +
> +	return cxlhdm;
> +}
> +EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_setup_hdm, CXL);
> +
> +int __wrap_devm_cxl_add_passthrough_decoder(struct device *host,
> +					    struct cxl_port *port)
> +{
> +	int rc, index;
> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> +
> +	if (ops && ops->is_mock_port(port->uport))
> +		rc = ops->devm_cxl_add_passthrough_decoder(host, port);
> +	else
> +		rc = devm_cxl_add_passthrough_decoder(host, port);
> +	put_cxl_mock_ops(index);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_add_passthrough_decoder, CXL);
> +
> +int __wrap_devm_cxl_enumerate_decoders(struct device *host,
> +				       struct cxl_hdm *cxlhdm)
> +{
> +	int rc, index;
> +	struct cxl_port *port = cxlhdm->port;
> +	struct cxl_mock_ops *ops = get_cxl_mock_ops(&index);
> +
> +	if (ops && ops->is_mock_port(port->uport))
> +		rc = ops->devm_cxl_enumerate_decoders(host, cxlhdm);
> +	else
> +		rc = devm_cxl_enumerate_decoders(host, cxlhdm);
> +	put_cxl_mock_ops(index);
> +
> +	return rc;
> +}
> +EXPORT_SYMBOL_NS_GPL(__wrap_devm_cxl_enumerate_decoders, CXL);
> +
>  int __wrap_devm_cxl_port_enumerate_dports(struct device *host,
>  					  struct cxl_port *port)
>  {
> diff --git a/tools/testing/cxl/test/mock.h b/tools/testing/cxl/test/mock.h
> index 99e7ff38090d..15e48063ea4b 100644
> --- a/tools/testing/cxl/test/mock.h
> +++ b/tools/testing/cxl/test/mock.h
> @@ -21,6 +21,9 @@ struct cxl_mock_ops {
>  	bool (*is_mock_dev)(struct device *dev);
>  	int (*devm_cxl_port_enumerate_dports)(struct device *host,
>  					      struct cxl_port *port);
> +	struct cxl_hdm *(*devm_cxl_setup_hdm)(struct device *host, struct cxl_port *port);
> +	int (*devm_cxl_add_passthrough_decoder)(struct device *host, struct cxl_port *port);
> +	int (*devm_cxl_enumerate_decoders)(struct device *host, struct cxl_hdm *hdm);
>  };
>  
>  void register_cxl_mock_ops(struct cxl_mock_ops *ops);
> 
