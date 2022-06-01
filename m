Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12F2F53B03C
	for <lists+linux-pci@lfdr.de>; Thu,  2 Jun 2022 00:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232284AbiFAWDl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Jun 2022 18:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232276AbiFAWDk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 1 Jun 2022 18:03:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE723F33E;
        Wed,  1 Jun 2022 15:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654121018; x=1685657018;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZMrcofCoLlZIVTW0pWtzQrRw9+mw2XoCO+V8YRUxJeI=;
  b=kkLPz8mOMYCb8yuYvvmE+B81xCX03wWaTtt6jsnwMCKXsG9IDMF+XIG/
   NkGG6DMha13gP23jyjGptKSKzMqtyKH3Kp+mzyT5dTxhsCyQSsy1OdGTh
   EBF5ubPVHFT1DmEc4lw4yGNLjhist6NvqQGRcSztYXxxgcux/DGKh0Pnq
   lf5bFZKBlJzPm32LEEbRQ0SHU34FbW/vVkUc+/+B4WUNGCi4ws7+vynWr
   5qtPJqpYQqZlNUenVHbcUhHtI6jV502xfg3hp47sP/KHyunoku/dd5JxT
   dXKPZ6meWB7H28TxIH4g6mMDhlR2oCX9L6ccQUkM5IJ4mKeWpLJGKGOSw
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10365"; a="275753916"
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="275753916"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 15:03:38 -0700
X-IronPort-AV: E=Sophos;i="5.91,269,1647327600"; 
   d="scan'208";a="577168733"
Received: from cwmurphy-mobl2.amr.corp.intel.com (HELO localhost) ([10.212.32.23])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2022 15:03:38 -0700
Date:   Wed, 1 Jun 2022 15:03:37 -0700
From:   Ira Weiny <ira.weiny@intel.com>
To:     Ben Widawsky <ben@bwidawsk.net>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V9 5/9] cxl/port: Find a DOE mailbox which supports CDAT
Message-ID: <YpfiOeglKe1w1fJb@iweiny-desk3>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-6-ira.weiny@intel.com>
 <20220531175716.jlkwu7aerxh5ucte@mail.bwidawsk.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531175716.jlkwu7aerxh5ucte@mail.bwidawsk.net>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, May 31, 2022 at 10:57:16AM -0700, Ben Widawsky wrote:
> On 22-05-31 08:26:28, ira.weiny@intel.com wrote:
> > From: Ira Weiny <ira.weiny@intel.com>
> > 
> > Each CXL device may have multiple DOE mailbox capabilities and each
> > mailbox may support multiple protocols.  CXL port devices need to query
> > the CDAT information specifically.
> > 
> > Search the DOE mailboxes for one which supports the CDAT protocol.
> > Cache that mailbox to be used for future queries.
> > 
> > Only support memory devices at this time.
> > 
> > Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> > 
> > ---
> > Changes from V8
> > 	Incorporate feedback from Jonathan
> > 	Move all this to the cxl_port object
> > 
> > Changes from V7
> > 	Minor code clean ups
> > 
> > Changes from V6
> > 	Adjust for aux devices being a CXL only concept
> > 	Update commit msg.
> > 	Ensure devices iterated by auxiliary_find_device() are checked
> > 		to be DOE devices prior to checking for the CDAT
> > 		protocol
> > 	From Ben
> > 		Ensure reference from auxiliary_find_device() is dropped
> > ---
> >  drivers/cxl/core/pci.c  | 28 ++++++++++++++++++++++++++++
> >  drivers/cxl/core/port.c |  2 ++
> >  drivers/cxl/cxl.h       |  2 ++
> >  drivers/cxl/cxlpci.h    |  1 +
> >  4 files changed, 33 insertions(+)
> > 
> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index c4c99ff7b55e..5497a65bdcf3 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -4,11 +4,14 @@
> >  #include <linux/device.h>
> >  #include <linux/delay.h>
> >  #include <linux/pci.h>
> > +#include <linux/pci-doe.h>
> >  #include <cxlpci.h>
> >  #include <cxlmem.h>
> >  #include <cxl.h>
> >  #include "core.h"
> >  
> > +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> > +
> >  /**
> >   * DOC: cxl core pci
> >   *
> > @@ -458,3 +461,28 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
> >  	return 0;
> >  }
> >  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> > +
> > +void cxl_find_cdat_mb(struct cxl_port *port)
> 
> kdoc would be good for exported symbols IMO.

Yes.  This was not exported before and I forgot.

> Also if you can come up with a
> better verb than "find" for something that mutates the port's state, I think
> that would be beneficial.

cxl_cache_cdat_mb()?

Ira

> 
> I'm not sure why this is exported yet, but I suppose I'll see soon :-)
> 
> > +{
> > +	struct device *dev = port->uport;
> > +	struct cxl_memdev *cxlmd;
> > +	struct cxl_dev_state *cxlds;
> > +	int i;
> > +
> > +	if (!is_cxl_memdev(dev))
> > +		return;
> > +
> > +	cxlmd = to_cxl_memdev(dev);
> > +	cxlds = cxlmd->cxlds;
> > +
> > +	for (i = 0; i < cxlds->num_mbs; i++) {
> > +		struct pci_doe_mb *cur = cxlds->doe_mbs[i];
> > +
> > +		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
> > +					  CXL_DOE_PROTOCOL_TABLE_ACCESS)) {
> > +			port->cdat_mb = cur;
> > +			return;
> > +		}
> > +	}
> > +}
> > +EXPORT_SYMBOL_NS_GPL(cxl_find_cdat_mb, CXL);
> > diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> > index ea60abda6500..2e2bd65c1024 100644
> > --- a/drivers/cxl/core/port.c
> > +++ b/drivers/cxl/core/port.c
> > @@ -461,6 +461,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> >  	if (IS_ERR(port))
> >  		return port;
> >  
> > +	cxl_find_cdat_mb(port);
> > +
> >  	dev = &port->dev;
> >  	if (is_cxl_memdev(uport))
> >  		rc = dev_set_name(dev, "endpoint%d", port->id);
> > diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> > index 140dc3278cde..0a86be589ffc 100644
> > --- a/drivers/cxl/cxl.h
> > +++ b/drivers/cxl/cxl.h
> > @@ -267,6 +267,7 @@ struct cxl_nvdimm {
> >   * @component_reg_phys: component register capability base address (optional)
> >   * @dead: last ep has been removed, force port re-creation
> >   * @depth: How deep this port is relative to the root. depth 0 is the root.
> > + * @cdat_mb: Mailbox which supports the CDAT protocol
> >   */
> >  struct cxl_port {
> >  	struct device dev;
> > @@ -278,6 +279,7 @@ struct cxl_port {
> >  	resource_size_t component_reg_phys;
> >  	bool dead;
> >  	unsigned int depth;
> > +	struct pci_doe_mb *cdat_mb;
> >  };
> >  
> >  /**
> > diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> > index fce1c11729c2..366b21bd1a01 100644
> > --- a/drivers/cxl/cxlpci.h
> > +++ b/drivers/cxl/cxlpci.h
> > @@ -74,4 +74,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
> >  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
> >  struct cxl_dev_state;
> >  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
> > +void cxl_find_cdat_mb(struct cxl_port *port);
> >  #endif /* __CXL_PCI_H__ */
> > -- 
> > 2.35.1
> > 
