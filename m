Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3584A5CAF
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 14:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238293AbiBAM76 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 07:59:58 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4601 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233789AbiBAM76 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 07:59:58 -0500
Received: from fraeml735-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jp4fH0CtNz67xDg;
        Tue,  1 Feb 2022 20:55:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml735-chm.china.huawei.com (10.206.15.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 13:59:56 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 12:59:56 +0000
Date:   Tue, 1 Feb 2022 12:59:54 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <ben.widawsky@intel.com>
Subject: Re: [PATCH 2/2] cxl/core/port: Handle invalid decoders
Message-ID: <20220201125954.000038c4@Huawei.com>
In-Reply-To: <164317464918.3438644.12371149695618136198.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164317463887.3438644.4087819721493502301.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164317464918.3438644.12371149695618136198.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml733-chm.china.huawei.com (10.201.108.84) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 25 Jan 2022 21:24:09 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In case init_hdm_decoder() finds invalid settings, skip to the next
> valid decoder. Only fail port enumeration if zero valid decoders are
> found. This protects the driver init against broken hardware and / or
> future interleave capabilities.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
One comment inline, but I'm fine with this as it is.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/hdm.c |   36 ++++++++++++++++++++++++++++++------
>  1 file changed, 30 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/core/hdm.c b/drivers/cxl/core/hdm.c
> index c966ab0d51fe..4955ba16c9c8 100644
> --- a/drivers/cxl/core/hdm.c
> +++ b/drivers/cxl/core/hdm.c
> @@ -150,8 +150,8 @@ static int to_interleave_ways(u32 ctrl)
>  	}
>  }
>  
> -static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
> -			     void __iomem *hdm, int which)
> +static int init_hdm_decoder(struct cxl_port *port, struct cxl_decoder *cxld,
> +			    int *target_map, void __iomem *hdm, int which)
>  {
>  	u64 size, base;
>  	u32 ctrl;
> @@ -167,6 +167,11 @@ static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
>  
>  	if (!(ctrl & CXL_HDM_DECODER0_CTRL_COMMITTED))
>  		size = 0;
> +	if (base == U64_MAX || size == U64_MAX) {
> +		dev_warn(&port->dev, "decoder%d.%d: Invalid resource range\n",
> +			 port->id, cxld->id);
> +		return -ENXIO;
> +	}
>  
>  	cxld->decoder_range = (struct range) {
>  		.start = base,
> @@ -180,6 +185,12 @@ static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
>  			cxld->flags |= CXL_DECODER_F_LOCK;
>  	}
>  	cxld->interleave_ways = to_interleave_ways(ctrl);
> +	if (!cxld->interleave_ways) {
> +		dev_warn(&port->dev,
> +			 "decoder%d.%d: Invalid interleave ways (ctrl: %#x)\n",
> +			 port->id, cxld->id, ctrl);
> +		return -ENXIO;
> +	}
>  	cxld->interleave_granularity = to_interleave_granularity(ctrl);
>  
>  	if (FIELD_GET(CXL_HDM_DECODER0_CTRL_TYPE, ctrl))
> @@ -188,12 +199,14 @@ static void init_hdm_decoder(struct cxl_decoder *cxld, int *target_map,
>  		cxld->target_type = CXL_DECODER_ACCELERATOR;
>  
>  	if (is_cxl_endpoint(to_cxl_port(cxld->dev.parent)))
> -		return;
> +		return 0;
>  
>  	target_list.value =
>  		ioread64_hi_lo(hdm + CXL_HDM_DECODER0_TL_LOW(which));
>  	for (i = 0; i < cxld->interleave_ways; i++)
>  		target_map[i] = target_list.target_id[i];
> +
> +	return 0;
>  }
>  
>  /**
> @@ -204,7 +217,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  {
>  	void __iomem *hdm = cxlhdm->regs.hdm_decoder;
>  	struct cxl_port *port = cxlhdm->port;
> -	int i, committed;
> +	int i, committed, failed;
>  	u32 ctrl;
>  
>  	/*
> @@ -224,7 +237,7 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  	if (committed != cxlhdm->decoder_count)
>  		msleep(20);
>  
> -	for (i = 0; i < cxlhdm->decoder_count; i++) {
> +	for (i = 0, failed = 0; i < cxlhdm->decoder_count; i++) {
>  		int target_map[CXL_DECODER_MAX_INTERLEAVE] = { 0 };
>  		int rc, target_count = cxlhdm->target_count;
>  		struct cxl_decoder *cxld;
> @@ -239,7 +252,13 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  			return PTR_ERR(cxld);
>  		}
>  
> -		init_hdm_decoder(cxld, target_map, cxlhdm->regs.hdm_decoder, i);
> +		rc = init_hdm_decoder(port, cxld, target_map,
> +				      cxlhdm->regs.hdm_decoder, i);
> +		if (rc) {
> +			put_device(&cxld->dev);
> +			failed++;
Not sure I'd have done it this way around, as opposed to
inited++ or similar, but up to you.
> +			continue;
> +		}
>  		rc = add_hdm_decoder(port, cxld, target_map);
>  		if (rc) {
>  			dev_warn(&port->dev,
> @@ -248,6 +267,11 @@ int devm_cxl_enumerate_decoders(struct cxl_hdm *cxlhdm)
>  		}
>  	}
>  
> +	if (failed == cxlhdm->decoder_count) {
> +		dev_err(&port->dev, "No valid decoders found\n");
> +		return -ENXIO;
> +	}
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_decoders, CXL);
> 

