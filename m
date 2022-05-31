Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCD415395AD
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 19:57:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346724AbiEaR52 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 13:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239219AbiEaR51 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 13:57:27 -0400
X-Greylist: delayed 415 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 May 2022 10:57:24 PDT
Received: from mail.bwidawsk.net (mail.bwidawsk.net [107.170.211.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7402D33A13;
        Tue, 31 May 2022 10:57:22 -0700 (PDT)
Received: by mail.bwidawsk.net (Postfix, from userid 5001)
        id 1E599123291; Tue, 31 May 2022 10:57:22 -0700 (PDT)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
Received: from mail.bwidawsk.net (c-24-20-163-23.hsd1.or.comcast.net [24.20.163.23])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by mail.bwidawsk.net (Postfix) with ESMTPSA id B0F00120013;
        Tue, 31 May 2022 10:57:17 -0700 (PDT)
Date:   Tue, 31 May 2022 10:57:16 -0700
From:   Ben Widawsky <ben@bwidawsk.net>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V9 5/9] cxl/port: Find a DOE mailbox which supports CDAT
Message-ID: <20220531175716.jlkwu7aerxh5ucte@mail.bwidawsk.net>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
 <20220531152632.1397976-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531152632.1397976-6-ira.weiny@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-05-31 08:26:28, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Each CXL device may have multiple DOE mailbox capabilities and each
> mailbox may support multiple protocols.  CXL port devices need to query
> the CDAT information specifically.
> 
> Search the DOE mailboxes for one which supports the CDAT protocol.
> Cache that mailbox to be used for future queries.
> 
> Only support memory devices at this time.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V8
> 	Incorporate feedback from Jonathan
> 	Move all this to the cxl_port object
> 
> Changes from V7
> 	Minor code clean ups
> 
> Changes from V6
> 	Adjust for aux devices being a CXL only concept
> 	Update commit msg.
> 	Ensure devices iterated by auxiliary_find_device() are checked
> 		to be DOE devices prior to checking for the CDAT
> 		protocol
> 	From Ben
> 		Ensure reference from auxiliary_find_device() is dropped
> ---
>  drivers/cxl/core/pci.c  | 28 ++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c |  2 ++
>  drivers/cxl/cxl.h       |  2 ++
>  drivers/cxl/cxlpci.h    |  1 +
>  4 files changed, 33 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c4c99ff7b55e..5497a65bdcf3 100644
> --- a/drivers/cxl/core/pci.c
> +++ b/drivers/cxl/core/pci.c
> @@ -4,11 +4,14 @@
>  #include <linux/device.h>
>  #include <linux/delay.h>
>  #include <linux/pci.h>
> +#include <linux/pci-doe.h>
>  #include <cxlpci.h>
>  #include <cxlmem.h>
>  #include <cxl.h>
>  #include "core.h"
>  
> +#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
> +
>  /**
>   * DOC: cxl core pci
>   *
> @@ -458,3 +461,28 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> +
> +void cxl_find_cdat_mb(struct cxl_port *port)

kdoc would be good for exported symbols IMO. Also if you can come up with a
better verb than "find" for something that mutates the port's state, I think
that would be beneficial.

I'm not sure why this is exported yet, but I suppose I'll see soon :-)

> +{
> +	struct device *dev = port->uport;
> +	struct cxl_memdev *cxlmd;
> +	struct cxl_dev_state *cxlds;
> +	int i;
> +
> +	if (!is_cxl_memdev(dev))
> +		return;
> +
> +	cxlmd = to_cxl_memdev(dev);
> +	cxlds = cxlmd->cxlds;
> +
> +	for (i = 0; i < cxlds->num_mbs; i++) {
> +		struct pci_doe_mb *cur = cxlds->doe_mbs[i];
> +
> +		if (pci_doe_supports_prot(cur, PCI_DVSEC_VENDOR_ID_CXL,
> +					  CXL_DOE_PROTOCOL_TABLE_ACCESS)) {
> +			port->cdat_mb = cur;
> +			return;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_find_cdat_mb, CXL);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index ea60abda6500..2e2bd65c1024 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -461,6 +461,8 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  	if (IS_ERR(port))
>  		return port;
>  
> +	cxl_find_cdat_mb(port);
> +
>  	dev = &port->dev;
>  	if (is_cxl_memdev(uport))
>  		rc = dev_set_name(dev, "endpoint%d", port->id);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 140dc3278cde..0a86be589ffc 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -267,6 +267,7 @@ struct cxl_nvdimm {
>   * @component_reg_phys: component register capability base address (optional)
>   * @dead: last ep has been removed, force port re-creation
>   * @depth: How deep this port is relative to the root. depth 0 is the root.
> + * @cdat_mb: Mailbox which supports the CDAT protocol
>   */
>  struct cxl_port {
>  	struct device dev;
> @@ -278,6 +279,7 @@ struct cxl_port {
>  	resource_size_t component_reg_phys;
>  	bool dead;
>  	unsigned int depth;
> +	struct pci_doe_mb *cdat_mb;
>  };
>  
>  /**
> diff --git a/drivers/cxl/cxlpci.h b/drivers/cxl/cxlpci.h
> index fce1c11729c2..366b21bd1a01 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -74,4 +74,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
> +void cxl_find_cdat_mb(struct cxl_port *port);
>  #endif /* __CXL_PCI_H__ */
> -- 
> 2.35.1
> 
