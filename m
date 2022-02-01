Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD394A63A5
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 19:21:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbiBASVd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 13:21:33 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4608 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbiBASVc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 13:21:32 -0500
Received: from fraeml734-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpCpJ69NPz67bSr;
        Wed,  2 Feb 2022 02:17:44 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml734-chm.china.huawei.com (10.206.15.215) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 19:21:30 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 18:21:29 +0000
Date:   Tue, 1 Feb 2022 18:21:28 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 10/14] cxl/region: Collect host bridge decoders
Message-ID: <20220201182128.000010d9@Huawei.com>
In-Reply-To: <20220128002707.391076-11-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
        <20220128002707.391076-11-ben.widawsky@intel.com>
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

On Thu, 27 Jan 2022 16:27:03 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Part of host bridge verification in the CXL Type 3 Memory Device
> Software Guide calculates the host bridge interleave target list (6th
> step in the flow chart), ie. verification and state update are done in
> the same step. Host bridge verification is already in place, so go ahead
> and store the decoders with their target lists.
> 
> Switches are implemented in a separate patch.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Looks like a little bit of code got in here that I think
belongs in a different patch.

> ---
>  drivers/cxl/region.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index 145d7bb02714..b8982be13bfe 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -428,6 +428,7 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
>  		return simple_config(cxlr, hbs[0]);
>  
>  	for (i = 0; i < hb_count; i++) {
> +		struct cxl_decoder *cxld;
>  		int idx, position_mask;
>  		struct cxl_dport *rp;
>  		struct cxl_port *hb;
> @@ -486,6 +487,18 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
>  						"One or more devices are not connected to the correct Host Bridge Root Port\n");
>  					goto err;
>  				}
> +
> +				if (!state_update)
> +					continue;
> +
> +				if (dev_WARN_ONCE(&cxld->dev,
> +						  port_grouping >= cxld->nr_targets,
> +						  "Invalid port grouping %d/%d\n",
> +						  port_grouping, cxld->nr_targets))
> +					goto err;
> +
> +				cxld->interleave_ways++;
> +				cxld->target[port_grouping] = get_rp(ep);
>  			}
>  		}
>  	}
> @@ -538,7 +551,7 @@ static bool rootd_valid(const struct cxl_region *cxlr,
>  
>  struct rootd_context {
>  	const struct cxl_region *cxlr;
> -	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
> +	const struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
>  	int count;
>  };
>  
> @@ -564,7 +577,7 @@ static struct cxl_decoder *find_rootd(const struct cxl_region *cxlr,
>  	struct rootd_context ctx;
>  	struct device *ret;
>  
> -	ctx.cxlr = cxlr;
> +	ctx.cxlr = (struct cxl_region *)cxlr;

Why is this here?  If it's needed, that need doesn't seem to have come in
as part of this patch.

>  
>  	ret = device_find_child((struct device *)&root->dev, &ctx, rootd_match);
>  	if (ret)

