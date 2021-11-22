Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D81C44595A9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 20:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239870AbhKVTlB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 14:41:01 -0500
Received: from mga12.intel.com ([192.55.52.136]:35172 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231856AbhKVTlA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 22 Nov 2021 14:41:00 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10176"; a="214890335"
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="214890335"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 11:37:53 -0800
X-IronPort-AV: E=Sophos;i="5.87,255,1631602800"; 
   d="scan'208";a="456764356"
Received: from wqiu6-mobl.amr.corp.intel.com (HELO intel.com) ([10.252.143.45])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2021 11:37:52 -0800
Date:   Mon, 22 Nov 2021 11:37:51 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 12/23] cxl: Introduce endpoint decoders
Message-ID: <20211122193751.gipqgs5ap24dacm3@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
 <20211120000250.1663391-13-ben.widawsky@intel.com>
 <20211122162039.000022c1@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211122162039.000022c1@Huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 21-11-22 16:20:39, Jonathan Cameron wrote:
> On Fri, 19 Nov 2021 16:02:39 -0800
> Ben Widawsky <ben.widawsky@intel.com> wrote:
> 
> > Endpoints have decoders too. It is useful to share the same
> > infrastructure from cxl_core. Endpoints do not have dports (downstream
> > targets), only the underlying physical medium. As a result, some special
> > casing is needed.
> > 
> > There is no functional change introduced yet as endpoints don't actually
> > enumerate decoders yet.
> > 
> > Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> I'm not a fan of special values like using 0 here to indicate endpoint
> device.  I'd rather see a base cxl_decode_alloc(..., bool ep)
> and possibly wrappers for the non ep case and ep one.
> 
> Jonathan
> 

My inclination is the opposite. However, I think you and Dan both brought up
something to this effect in the previous RFCs.

Dan, do you have a preference here?

> > ---
> >  drivers/cxl/core/bus.c | 41 +++++++++++++++++++++++++++++++++--------
> >  1 file changed, 33 insertions(+), 8 deletions(-)
> > 
> > diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> > index 1ee12a60f3f4..16b15f54fb62 100644
> > --- a/drivers/cxl/core/bus.c
> > +++ b/drivers/cxl/core/bus.c
> > @@ -187,6 +187,12 @@ static const struct attribute_group *cxl_decoder_switch_attribute_groups[] = {
> >  	NULL,
> >  };
> >  
> > +static const struct attribute_group *cxl_decoder_endpoint_attribute_groups[] = {
> > +	&cxl_decoder_base_attribute_group,
> > +	&cxl_base_attribute_group,
> > +	NULL,
> > +};
> > +
> >  static void cxl_decoder_release(struct device *dev)
> >  {
> >  	struct cxl_decoder *cxld = to_cxl_decoder(dev);
> > @@ -196,6 +202,12 @@ static void cxl_decoder_release(struct device *dev)
> >  	kfree(cxld);
> >  }
> >  
> > +static const struct device_type cxl_decoder_endpoint_type = {
> > +	.name = "cxl_decoder_endpoint",
> > +	.release = cxl_decoder_release,
> > +	.groups = cxl_decoder_endpoint_attribute_groups,
> > +};
> > +
> >  static const struct device_type cxl_decoder_switch_type = {
> >  	.name = "cxl_decoder_switch",
> >  	.release = cxl_decoder_release,
> > @@ -208,6 +220,11 @@ static const struct device_type cxl_decoder_root_type = {
> >  	.groups = cxl_decoder_root_attribute_groups,
> >  };
> >  
> > +static bool is_endpoint_decoder(struct device *dev)
> > +{
> > +	return dev->type == &cxl_decoder_endpoint_type;
> > +}
> > +
> >  bool is_root_decoder(struct device *dev)
> >  {
> >  	return dev->type == &cxl_decoder_root_type;
> > @@ -499,7 +516,9 @@ static int decoder_populate_targets(struct cxl_decoder *cxld,
> >   * cxl_decoder_alloc - Allocate a new CXL decoder
> >   * @port: owning port of this decoder
> >   * @nr_targets: downstream targets accessible by this decoder. All upstream
> > - *		ports and root ports must have at least 1 target.
> > + *		ports and root ports must have at least 1 target. Endpoint
> > + *		devices will have 0 targets. Callers wishing to register an
> > + *		endpoint device should specify 0.
> >   *
> >   * A port should contain one or more decoders. Each of those decoders enable
> >   * some address space for CXL.mem utilization. A decoder is expected to be
> > @@ -516,7 +535,7 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  	struct device *dev;
> >  	int rc = 0;
> >  
> > -	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE || nr_targets == 0)
> > +	if (nr_targets > CXL_DECODER_MAX_INTERLEAVE)
> >  		return ERR_PTR(-EINVAL);
> >  
> >  	cxld = kzalloc(struct_size(cxld, target, nr_targets), GFP_KERNEL);
> > @@ -535,8 +554,11 @@ struct cxl_decoder *cxl_decoder_alloc(struct cxl_port *port,
> >  	dev->parent = &port->dev;
> >  	dev->bus = &cxl_bus_type;
> >  
> > +	/* Endpoints don't have a target list */
> > +	if (nr_targets == 0)
> > +		dev->type = &cxl_decoder_endpoint_type;
> >  	/* root ports do not have a cxl_port_type parent */
> > -	if (port->dev.parent->type == &cxl_port_type)
> > +	else if (port->dev.parent->type == &cxl_port_type)
> >  		dev->type = &cxl_decoder_switch_type;
> >  	else
> >  		dev->type = &cxl_decoder_root_type;
> > @@ -579,12 +601,15 @@ int cxl_decoder_add(struct cxl_decoder *cxld, int *target_map)
> >  	if (cxld->interleave_ways < 1)
> >  		return -EINVAL;
> >  
> > -	port = to_cxl_port(cxld->dev.parent);
> > -	rc = decoder_populate_targets(cxld, port, target_map);
> > -	if (rc)
> > -		return rc;
> > -
> >  	dev = &cxld->dev;
> > +
> > +	port = to_cxl_port(cxld->dev.parent);
> > +	if (!is_endpoint_decoder(dev)) {
> > +		rc = decoder_populate_targets(cxld, port, target_map);
> > +		if (rc)
> > +			return rc;
> > +	}
> > +
> >  	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);
> >  	if (rc)
> >  		return rc;
> 
