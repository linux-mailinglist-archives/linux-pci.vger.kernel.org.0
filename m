Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 632E748A427
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jan 2022 01:05:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345812AbiAKAFK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Jan 2022 19:05:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:32928 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242685AbiAKAFK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Jan 2022 19:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641859510; x=1673395510;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H2fbRA/uYSTvN7YXLcWkKt3nlptWhdsD3O8Q/GOy/9g=;
  b=m4UHyLpqVTUAr4FXQkX7vQwlJ+0PMJ5LRxePwTkfoqs4uLj+t9k5EYHs
   zr+KFeqZiu+jNcSmsDDg/zQ4DbKutoIIW3Ng++Ltxr1EzFOBEIhyF9D31
   4fKZc7yP0h40FR6Ji+d1gVxcN8rU+9ejyoTRioK1yDAUfAHmNp69G92SA
   Ll4SyCh8/5I6wveK2NNMwERVjKZy2Y38o+PEpyfemJe2tLruwo5I3Y8p/
   hNuORfrZc5dMB3EOyDP+M9c715oBgvOmfKYd16BJWqU76Lb5kbZTO/b0n
   UX9vKePYGrqMA5kHm3pwyPmBOYJfH2q8VSdkMoUoxKz7x9Bp4tsGmy3tU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10223"; a="230706305"
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="230706305"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 16:05:10 -0800
X-IronPort-AV: E=Sophos;i="5.88,278,1635231600"; 
   d="scan'208";a="472261068"
Received: from meghanma-mobl1.amr.corp.intel.com (HELO intel.com) ([10.252.135.79])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2022 16:05:09 -0800
Date:   Mon, 10 Jan 2022 16:05:08 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, patches@lists.linux.dev,
        Bjorn Helgaas <helgaas@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 13/13] cxl: Program decoders for regions
Message-ID: <20220111000508.xg3de4la5zgf5o5j@intel.com>
References: <20220107003756.806582-1-ben.widawsky@intel.com>
 <20220107003756.806582-14-ben.widawsky@intel.com>
 <20220107161812.00007956@huawei.com>
 <20220107163341.mb7pchctbfcaev7r@intel.com>
 <20220107172222.000068ac@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220107172222.000068ac@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-01-07 17:22:22, Jonathan Cameron wrote:
> On Fri, 7 Jan 2022 08:33:41 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > On 22-01-07 16:18:12, Jonathan Cameron wrote:
> > > On Thu,  6 Jan 2022 16:37:56 -0800
> > > Ben Widawsky <ben.widawsky@intel.com> wrote:
> > >   
> > > > Do the HDM decoder programming for all endpoints and host bridges in a
> > > > region. Switches are currently unimplemented.
> > > > 
> > > > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> > > > ---
> > > >  drivers/cxl/core/hdm.c | 198 +++++++++++++++++++++++++++++++++++++++++
> > > >  drivers/cxl/cxl.h      |   3 +
> > > >  drivers/cxl/region.c   |  39 +++++++-
> > > >  3 files changed, 237 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> > > > index 44e48cea8cd4..c7293cbd8547 100644
> > > > --- a/drivers/cxl/core/hdm.c
> > > > +++ b/drivers/cxl/core/hdm.c
> > > > @@ -242,3 +242,201 @@ int devm_cxl_enumerate_switch_decoders(struct cxl_port *port)
> > > >  	return 0;
> > > >  }
> > > >  EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_switch_decoders, CXL);
> > > > +
> > > > +#define COMMIT_TIMEOUT_MS 10
> > > > +static int wait_for_commit(struct cxl_decoder *cxld)
> > > > +{
> > > > +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > > > +	const unsigned long start = jiffies;
> > > > +	struct cxl_port_state *cxlps;
> > > > +	void __iomem *hdm_decoder;
> > > > +	unsigned long end = start;
> > > > +	u32 ctrl;
> > > > +
> > > > +	cxlps = dev_get_drvdata(&port->dev);
> > > > +	hdm_decoder = cxlps->regs.hdm_decoder;
> > > > +
> > > > +	do {
> > > > +		end = jiffies;
> > > > +		ctrl = readl(hdm_decoder +
> > > > +			     CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> > > > +		if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> > > > +			break;
> > > > +
> > > > +		if (time_after(end, start + COMMIT_TIMEOUT_MS)) {
> > > > +			dev_err(&cxld->dev, "HDM decoder commit timeout %x\n", ctrl);
> > > > +			return -ETIMEDOUT;
> > > > +		}
> > > > +		if ((ctrl & CXL_HDM_DECODER0_CTRL_COMMIT_ERROR) != 0) {
> > > > +			dev_err(&cxld->dev, "HDM decoder commit error %x\n", ctrl);
> > > > +			return -ENXIO;
> > > > +		}
> > > > +	} while (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl));  
> > > 
> > > Hi Ben,
> > > 
> > > Thanks for posting this btw - it's very helpful indeed for hammering out bugs
> > > in the qemu code and to identify what isn't there yet.
> > > 
> > > Took me a while to work out how this seemed to succeed on QEMU with no
> > > implementation of the commit for the host bridges (just adding that now ;)
> > > Reason is this condition is inverse of what I think you intend.
> > > 
> > > Given you have an exit condition above this could probably just be a while (1)
> > > loop.
> > > 
> > > Jonathan  
> > 
> > Quick response without looking at code. I thought I did implement this in QEMU,
> > but you're correct that the logic is inverted. If you have a QEMU branch for me
> > to use when I fix this, please let me know.
> 
> The branch I got from your gitlab has it specifically for the type3 device, but
> not more generally.
> 
> Qemu wise will see if I can hammer something into a shape to share but might take
> a little while to hammer out remaining bugs.  I've made a few fiddly changes to
> try and simplify the setup + avoid fixed PA address ranges anywhere.
> 
> Jonathan
> 

Just pushed a bugfix to my v4 branch for this (I've also updated the kernel
patch).

> > 
> > >   
> > > > +
> > > > +	return 0;
> > > > +}
> > > > +
> > > > +/**
> > > > + * cxl_commit_decoder() - Program a configured cxl_decoder
> > > > + * @cxld: The preconfigured cxl decoder.
> > > > + *
> > > > + * A cxl decoder that is to be committed should have been earmarked as enabled.
> > > > + * This mechanism acts as a soft reservation on the decoder.
> > > > + *
> > > > + * Returns 0 if commit was successful, negative error code otherwise.
> > > > + */
> > > > +int cxl_commit_decoder(struct cxl_decoder *cxld)
> > > > +{
> > > > +	u32 ctrl, tl_lo, tl_hi, base_lo, base_hi, size_lo, size_hi;
> > > > +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > > > +	struct cxl_port_state *cxlps;
> > > > +	void __iomem *hdm_decoder;
> > > > +	int rc;
> > > > +
> > > > +	/*
> > > > +	 * Decoder flags are entirely software controlled and therefore this
> > > > +	 * case is purely a driver bug.
> > > > +	 */
> > > > +	if (dev_WARN_ONCE(&port->dev, (cxld->flags & CXL_DECODER_F_ENABLE) != 0,
> > > > +			  "Invalid %s enable state\n", dev_name(&cxld->dev)))
> > > > +		return -ENXIO;
> > > > +
> > > > +	cxlps = dev_get_drvdata(&port->dev);
> > > > +	hdm_decoder = cxlps->regs.hdm_decoder;
> > > > +	ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> > > > +
> > > > +	/*
> > > > +	 * A decoder that's currently active cannot be changed without the
> > > > +	 * system being quiesced. While the driver should prevent against this,
> > > > +	 * for a variety of reasons the hardware might not be in sync with the
> > > > +	 * hardware and so, do not splat on error.
> > > > +	 */
> > > > +	size_hi = readl(hdm_decoder +
> > > > +			CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
> > > > +	size_lo =
> > > > +		readl(hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
> > > > +	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl) &&
> > > > +	    (size_lo + size_hi)) {
> > > > +		dev_err(&port->dev, "Tried to change an active decoder (%s)\n",
> > > > +			dev_name(&cxld->dev));
> > > > +		return -EBUSY;
> > > > +	}
> > > > +
> > > > +	u32p_replace_bits(&ctrl, 8 - ilog2(cxld->interleave_granularity),
> > > > +			  CXL_HDM_DECODER0_CTRL_IG_MASK);
> > > > +	u32p_replace_bits(&ctrl, ilog2(cxld->interleave_ways),
> > > > +			  CXL_HDM_DECODER0_CTRL_IW_MASK);
> > > > +	u32p_replace_bits(&ctrl, 1, CXL_HDM_DECODER0_CTRL_COMMIT);
> > > > +
> > > > +	/* TODO: set based on type */
> > > > +	u32p_replace_bits(&ctrl, 1, CXL_HDM_DECODER0_CTRL_TYPE);
> > > > +
> > > > +	base_lo = FIELD_PREP(GENMASK(31, 28),
> > > > +			     (u32)(cxld->decoder_range.start & 0xffffffff));
> > > > +	base_hi = FIELD_PREP(~0, (u32)(cxld->decoder_range.start >> 32));
> > > > +
> > > > +	size_lo = (u32)(range_len(&cxld->decoder_range)) & GENMASK(31, 28);
> > > > +	size_hi = (u32)((range_len(&cxld->decoder_range) >> 32));
> > > > +
> > > > +	if (cxld->nr_targets > 0) {
> > > > +		tl_lo |= FIELD_PREP(GENMASK(7, 0), cxld->target[0]->port_id);
> > > > +		if (cxld->interleave_ways > 1)
> > > > +			tl_lo |= FIELD_PREP(GENMASK(15, 8),
> > > > +					    cxld->target[1]->port_id);
> > > > +		if (cxld->interleave_ways > 2)
> > > > +			tl_lo |= FIELD_PREP(GENMASK(23, 16),
> > > > +					    cxld->target[2]->port_id);
> > > > +		if (cxld->interleave_ways > 3)
> > > > +			tl_lo |= FIELD_PREP(GENMASK(31, 24),
> > > > +					    cxld->target[3]->port_id);
> > > > +		if (cxld->interleave_ways > 4)
> > > > +			tl_hi |= FIELD_PREP(GENMASK(7, 0),
> > > > +					    cxld->target[4]->port_id);
> > > > +		if (cxld->interleave_ways > 5)
> > > > +			tl_hi |= FIELD_PREP(GENMASK(15, 8),
> > > > +					    cxld->target[5]->port_id);
> > > > +		if (cxld->interleave_ways > 6)
> > > > +			tl_hi |= FIELD_PREP(GENMASK(23, 16),
> > > > +					    cxld->target[6]->port_id);
> > > > +		if (cxld->interleave_ways > 7)
> > > > +			tl_hi |= FIELD_PREP(GENMASK(31, 24),
> > > > +					    cxld->target[7]->port_id);
> > > > +
> > > > +		writel(tl_hi, hdm_decoder + CXL_HDM_DECODER0_TL_HIGH(cxld->id));
> > > > +		writel(tl_lo, hdm_decoder + CXL_HDM_DECODER0_TL_LOW(cxld->id));
> > > > +	}
> > > > +
> > > > +	writel(size_hi,
> > > > +	       hdm_decoder + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
> > > > +	writel(size_lo,
> > > > +	       hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
> > > > +	writel(base_hi,
> > > > +	       hdm_decoder + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(cxld->id));
> > > > +	writel(base_lo,
> > > > +	       hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(cxld->id));
> > > > +	writel(ctrl, hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> > > > +
> > > > +	rc = wait_for_commit(cxld);
> > > > +	if (rc)
> > > > +		return rc;
> > > > +
> > > > +	cxld->flags |= CXL_DECODER_F_ENABLE;
> > > > +
> > > > +#define DPORT_TL_STR "%d %d %d %d %d %d %d %d"
> > > > +#define DPORT(i)                                                               \
> > > > +	(cxld->nr_targets && cxld->interleave_ways > (i)) ?                    \
> > > > +		      cxld->target[(i)]->port_id :                                   \
> > > > +		      -1
> > > > +#define DPORT_TL                                                               \
> > > > +	DPORT(0), DPORT(1), DPORT(2), DPORT(3), DPORT(4), DPORT(5), DPORT(6),  \
> > > > +		DPORT(7)
> > > > +
> > > > +	dev_dbg(&port->dev,
> > > > +		"%s\n\tBase %pa\n\tSize %llu\n\tIG %u\n\tIW %u\n\tTargetList: " DPORT_TL_STR,
> > > > +		dev_name(&cxld->dev), &cxld->decoder_range.start,
> > > > +		range_len(&cxld->decoder_range), cxld->interleave_granularity,
> > > > +		cxld->interleave_ways, DPORT_TL);
> > > > +#undef DPORT_TL
> > > > +#undef DPORT
> > > > +#undef DPORT_TL_STR
> > > > +	return 0;
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(cxl_commit_decoder);
> > > > +
> > > > +/**
> > > > + * cxl_disable_decoder() - Disables a decoder
> > > > + * @cxld: The active cxl decoder.
> > > > + *
> > > > + * CXL decoders (as of 2.0 spec) have no way to deactivate them other than to
> > > > + * set the size of the HDM to 0. This function will clear all registers, and if
> > > > + * the decoder is active, commit the 0'd out registers.
> > > > + */
> > > > +void cxl_disable_decoder(struct cxl_decoder *cxld)
> > > > +{
> > > > +	struct cxl_port *port = to_cxl_port(cxld->dev.parent);
> > > > +	struct cxl_port_state *cxlps;
> > > > +	void __iomem *hdm_decoder;
> > > > +	u32 ctrl;
> > > > +
> > > > +	cxlps = dev_get_drvdata(&port->dev);
> > > > +	hdm_decoder = cxlps->regs.hdm_decoder;
> > > > +	ctrl = readl(hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> > > > +
> > > > +	if (dev_WARN_ONCE(&port->dev, (cxld->flags & CXL_DECODER_F_ENABLE) == 0,
> > > > +			  "Invalid decoder enable state\n"))
> > > > +		return;
> > > > +
> > > > +	/* There's no way to "uncommit" a committed decoder, only 0 size it */
> > > > +	writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_HIGH(cxld->id));
> > > > +	writel(0, hdm_decoder + CXL_HDM_DECODER0_TL_LOW(cxld->id));
> > > > +	writel(0, hdm_decoder + CXL_HDM_DECODER0_SIZE_HIGH_OFFSET(cxld->id));
> > > > +	writel(0, hdm_decoder + CXL_HDM_DECODER0_SIZE_LOW_OFFSET(cxld->id));
> > > > +	writel(0, hdm_decoder + CXL_HDM_DECODER0_BASE_HIGH_OFFSET(cxld->id));
> > > > +	writel(0, hdm_decoder + CXL_HDM_DECODER0_BASE_LOW_OFFSET(cxld->id));
> > > > +
> > > > +	/* If the device isn't actually active, just zero out all the fields */
> > > > +	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_COMMITTED, ctrl))
> > > > +		writel(CXL_HDM_DECODER0_CTRL_COMMIT,
> > > > +		       hdm_decoder + CXL_HDM_DECODER0_CTRL_OFFSET(cxld->id));
> > > > +}
> > > > +EXPORT_SYMBOL_GPL(cxl_disable_decoder);
> > > > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > > > index 79bca9a8246c..587b75f7fa53 100644
> > > > --- a/drivers/cxl/cxl.h
> > > > +++ b/drivers/cxl/cxl.h
> > > > @@ -54,6 +54,7 @@
> > > >  #define   CXL_HDM_DECODER0_CTRL_IW_MASK GENMASK(7, 4)
> > > >  #define   CXL_HDM_DECODER0_CTRL_COMMIT BIT(9)
> > > >  #define   CXL_HDM_DECODER0_CTRL_COMMITTED BIT(10)
> > > > +#define   CXL_HDM_DECODER0_CTRL_COMMIT_ERROR BIT(11)
> > > >  #define   CXL_HDM_DECODER0_CTRL_TYPE BIT(12)
> > > >  #define CXL_HDM_DECODER0_TL_LOW(i) (0x20 * (i) + 0x24)
> > > >  #define CXL_HDM_DECODER0_TL_HIGH(i) (0x20 * (i) + 0x28)
> > > > @@ -364,6 +365,8 @@ int devm_cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
> > > >  struct cxl_dport *cxl_find_dport_by_dev(struct cxl_port *port,
> > > >  					const struct device *dev);
> > > >  struct cxl_port *ep_find_cxl_port(struct cxl_memdev *cxlmd, unsigned int depth);
> > > > +int cxl_commit_decoder(struct cxl_decoder *cxld);
> > > > +void cxl_disable_decoder(struct cxl_decoder *cxld);
> > > >  
> > > >  struct cxl_decoder *to_cxl_decoder(struct device *dev);
> > > >  bool is_cxl_decoder(struct device *dev);
> > > > diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> > > > index 3120b65b0bc5..fd82d37ba573 100644
> > > > --- a/drivers/cxl/region.c
> > > > +++ b/drivers/cxl/region.c
> > > > @@ -580,10 +580,30 @@ static void cleanup_staged_decoders(struct cxl_region *region)
> > > >  	}
> > > >  }
> > > >  
> > > > -static int bind_region(const struct cxl_region *region)
> > > > +static int bind_region(struct cxl_region *region)
> > > >  {
> > > > -	/* TODO: */
> > > > -	return 0;
> > > > +	struct cxl_decoder *cxld, *d;
> > > > +	int rc;
> > > > +
> > > > +	list_for_each_entry_safe(cxld, d, &region->staged_list, region_link) {
> > > > +		rc = cxl_commit_decoder(cxld);
> > > > +		if (!rc)
> > > > +			list_move_tail(&cxld->region_link, &region->commit_list);
> > > > +		else
> > > > +			break;
> > > > +	}
> > > > +
> > > > +	list_for_each_entry_safe(cxld, d, &region->commit_list, region_link) {
> > > > +		if (rc)
> > > > +			cxl_disable_decoder(cxld);
> > > > +		list_del(&cxld->region_link);
> > > > +	}
> > > > +
> > > > +	if (rc)
> > > > +		cleanup_staged_decoders((struct cxl_region *)region);
> > > > +
> > > > +	BUG_ON(!list_empty(&region->staged_list));
> > > > +	return rc;
> > > >  }
> > > >  
> > > >  static int cxl_region_probe(struct device *dev)
> > > > @@ -650,9 +670,22 @@ static int cxl_region_probe(struct device *dev)
> > > >  	return ret;
> > > >  }
> > > >  
> > > > +static void cxl_region_remove(struct device *dev)
> > > > +{
> > > > +	struct cxl_region *region = to_cxl_region(dev);
> > > > +	struct cxl_decoder *cxld, *d;
> > > > +
> > > > +	list_for_each_entry_safe(cxld, d, &region->commit_list, region_link) {
> > > > +		cxl_disable_decoder(cxld);
> > > > +		list_del(&cxld->region_link);
> > > > +		cxl_put_decoder(cxld);
> > > > +	}
> > > > +}
> > > > +
> > > >  static struct cxl_driver cxl_region_driver = {
> > > >  	.name = "cxl_region",
> > > >  	.probe = cxl_region_probe,
> > > > +	.remove = cxl_region_remove,
> > > >  	.id = CXL_DEVICE_REGION,
> > > >  };
> > > >  module_cxl_driver(cxl_region_driver);  
> > >   
> 
