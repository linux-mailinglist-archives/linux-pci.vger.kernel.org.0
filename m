Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70F4353ED2A
	for <lists+linux-pci@lfdr.de>; Mon,  6 Jun 2022 19:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230047AbiFFRs0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Jun 2022 13:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiFFRsZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Jun 2022 13:48:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDA232EEB;
        Mon,  6 Jun 2022 10:48:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 65747B81AC0;
        Mon,  6 Jun 2022 17:48:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E30C385A9;
        Mon,  6 Jun 2022 17:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654537701;
        bh=lOIwjZPFduWzF4p12LQgqQGU+8inbntKFhATkukdnAA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pkfuQzSimBGGvyyoijy+xIdUPepciJbyFYeblvbEeS93pn+tOfpHbPNHZrsuOTU3p
         axshPmVVE9UJuY7fhQ1S45flA8oEGS8LPSDKFaa3HuNtwq8K0x1aVT+/asJ5Fi8jbW
         JoDpbVIaPc9VNY0Ot0P8rHSwa3uxCuDJtI+MDXBYOr6bVl/lOExDFdqw0K7qGLvx7K
         WC8w4252cezRDp3Wy4rx+rJS2DosZ9quP0IaOxhU2enumwCAosmnjwnb5MRzre2Rkk
         Nd7wZ3KkyngwHfB3RIXXUQ7cRhar60h+d9XgOw9SXsqW21vdJvH9G1VPzCyKgd8gSs
         s7PQ3fcCMQbKQ==
Date:   Mon, 6 Jun 2022 10:48:19 -0700
From:   Ben Widawsky <bwidawsk@kernel.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH V10 5/9] cxl/port: Find a DOE mailbox which supports CDAT
Message-ID: <20220606174819.hhnb4jh27nxxvrdf@bwidawsk-mobl5>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
 <20220605005049.2155874-6-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220605005049.2155874-6-ira.weiny@intel.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 22-06-04 17:50:45, ira.weiny@intel.com wrote:
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
> Cc: Ben Widawsky <ben.widawsky@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes from V9
> 	Ben Widawsky
> 		s/cxl_find_cdat_mb/cxl_cache_cdat_mb/; add kdoc
> 	Jonathan Cameron
> 		Move cache_cdat to port probe [Not 100% necessary but it
> 		goes along with reading the cdat data.]
> 
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
>  drivers/cxl/core/pci.c | 35 +++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h      |  2 ++
>  drivers/cxl/cxlpci.h   |  1 +
>  drivers/cxl/port.c     |  2 ++
>  4 files changed, 40 insertions(+)
> 
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> index c4c99ff7b55e..d814d8317975 100644
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
> @@ -458,3 +461,35 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm)
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_hdm_decode_init, CXL);
> +
> +/**
> + * cxl_cache_cdat_mb() -- cache the DOE mailbox which suports the CDAT protocol
> + *
> + * @port: Port to containing DOE Mailboxes
> + *
> + * Cache a pointer to the doe mailbox which supports CDAT.
> + */
> +void cxl_cache_cdat_mb(struct cxl_port *port)
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

What happens if cxl_pci is unloaded after this? Would it be better to copy out
the CDAT info? Otherwise, I think you need to hold a ref on the PCI device
(though I only took a quick look).

> +			return;
> +		}
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_cache_cdat_mb, CXL);
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
> index fce1c11729c2..ddbb8b77752e 100644
> --- a/drivers/cxl/cxlpci.h
> +++ b/drivers/cxl/cxlpci.h
> @@ -74,4 +74,5 @@ static inline resource_size_t cxl_regmap_to_base(struct pci_dev *pdev,
>  int devm_cxl_port_enumerate_dports(struct cxl_port *port);
>  struct cxl_dev_state;
>  int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm);
> +void cxl_cache_cdat_mb(struct cxl_port *port);
>  #endif /* __CXL_PCI_H__ */
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 3cf308f114c4..04f3d1fc6e07 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -49,6 +49,8 @@ static int cxl_port_probe(struct device *dev)
>  	if (IS_ERR(cxlhdm))
>  		return PTR_ERR(cxlhdm);
>  
> +	cxl_cache_cdat_mb(port);
> +
>  	if (is_cxl_endpoint(port)) {
>  		struct cxl_memdev *cxlmd = to_cxl_memdev(port->uport);
>  		struct cxl_dev_state *cxlds = cxlmd->cxlds;
> -- 
> 2.35.1
> 
