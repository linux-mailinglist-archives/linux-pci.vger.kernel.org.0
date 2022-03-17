Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5807F4DC439
	for <lists+linux-pci@lfdr.de>; Thu, 17 Mar 2022 11:48:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231205AbiCQKtb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 17 Mar 2022 06:49:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiCQKta (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 17 Mar 2022 06:49:30 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42841700B9;
        Thu, 17 Mar 2022 03:48:13 -0700 (PDT)
Received: from fraeml737-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KK3j361X4z67xsC;
        Thu, 17 Mar 2022 18:46:15 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml737-chm.china.huawei.com (10.206.15.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 17 Mar 2022 11:48:10 +0100
Received: from localhost (10.47.67.192) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Thu, 17 Mar
 2022 10:48:10 +0000
Date:   Thu, 17 Mar 2022 10:48:08 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <ben.widawsky@intel.com>,
        <vishal.l.verma@intel.com>, <alison.schofield@intel.com>,
        <ira.weiny@intel.com>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH 5/8] cxl/port: Limit the port driver to just the HDM
 Decoder Capability
Message-ID: <20220317104808.00000c1e@Huawei.com>
In-Reply-To: <164740404858.3912056.13421993054614655037.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164740404858.3912056.13421993054614655037.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.67.192]
X-ClientProxiedBy: lhreml732-chm.china.huawei.com (10.201.108.83) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 15 Mar 2022 21:14:08 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Update the port driver to use cxl_map_component_registers() so that the
> component register block can be shared between the cxl_pci driver and
> the cxl_port driver. I.e. stop the port driver from reserving the entire
> component register block for itself via request_region() when it only
> needs the HDM Decoder Capability subset.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

We go through a dance in the other callers to cxl_probe_component_regs
cxl_map_component_regs that means we don't have block mapped at tim
of calling cxl_map_component_regs().

I'd gotten it into my head that we had that separation for a reason,
and it doesn't exist here as both are called with the block mapped.
Looking again I think that was needed because of use of pci_iomap
for the bar so I guess the same constraint doesn't apply here?

Thanks,

Jonathan



> ---
>  drivers/cxl/core/hdm.c |   32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index 0e89a7a932d4..09221afca309 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -77,18 +77,22 @@ static void parse_hdm_decoder_caps(struct cxl_hdm *cxlhdm)
>  		cxlhdm->interleave_mask |= GENMASK(14, 12);
>  }
>  
> -static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
> -					  void __iomem *crb)
> +static int map_hdm_decoder_regs(struct cxl_port *port, void __iomem *crb,
> +				struct cxl_component_regs *regs)
>  {
> -	struct cxl_component_reg_map map;
> +	struct cxl_register_map map = {
> +		.resource = port->component_reg_phys,
> +		.base = crb,
> +		.max_size = CXL_COMPONENT_REG_BLOCK_SIZE,
> +	};
>  
> -	cxl_probe_component_regs(&port->dev, crb, &map);
> -	if (!map.hdm_decoder.valid) {
> +	cxl_probe_component_regs(&port->dev, crb, &map.component_map);
> +	if (!map.component_map.hdm_decoder.valid) {
>  		dev_err(&port->dev, "HDM decoder registers invalid\n");
> -		return IOMEM_ERR_PTR(-ENXIO);
> +		return -ENXIO;
>  	}
>  
> -	return crb + map.hdm_decoder.offset;
> +	return cxl_map_component_regs(&port->dev, regs, &map);
>  }
>  
>  /**
> @@ -98,25 +102,25 @@ static void __iomem *map_hdm_decoder_regs(struct cxl_port *port,
>  struct cxl_hdm *devm_cxl_setup_hdm(struct cxl_port *port)
>  {
>  	struct device *dev = &port->dev;
> -	void __iomem *crb, *hdm;
>  	struct cxl_hdm *cxlhdm;
> +	void __iomem *crb;
> +	int rc;
>  
>  	cxlhdm = devm_kzalloc(dev, sizeof(*cxlhdm), GFP_KERNEL);
>  	if (!cxlhdm)
>  		return ERR_PTR(-ENOMEM);
>  
>  	cxlhdm->port = port;
> -	crb = devm_cxl_iomap_block(dev, port->component_reg_phys,
> -				   CXL_COMPONENT_REG_BLOCK_SIZE);
> +	crb = ioremap(port->component_reg_phys, CXL_COMPONENT_REG_BLOCK_SIZE);
>  	if (!crb) {
>  		dev_err(dev, "No component registers mapped\n");
>  		return ERR_PTR(-ENXIO);
>  	}
>  
> -	hdm = map_hdm_decoder_regs(port, crb);
> -	if (IS_ERR(hdm))
> -		return ERR_CAST(hdm);
> -	cxlhdm->regs.hdm_decoder = hdm;
> +	rc = map_hdm_decoder_regs(port, crb, &cxlhdm->regs);
> +	iounmap(crb);
> +	if (rc)
> +		return ERR_PTR(rc);
>  
>  	parse_hdm_decoder_caps(cxlhdm);
>  	if (cxlhdm->decoder_count == 0) {
> 

