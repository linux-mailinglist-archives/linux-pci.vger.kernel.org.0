Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3BEF4A63C0
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 19:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232619AbiBAS0S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 13:26:18 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4609 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230476AbiBAS0R (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 1 Feb 2022 13:26:17 -0500
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JpCvp1J0Vz67mB8;
        Wed,  2 Feb 2022 02:22:30 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Tue, 1 Feb 2022 19:26:15 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Tue, 1 Feb
 2022 18:26:14 +0000
Date:   Tue, 1 Feb 2022 18:26:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 11/14] cxl/region: Add support for single switch
 level
Message-ID: <20220201182613.00005fdf@Huawei.com>
In-Reply-To: <20220128002707.391076-12-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
        <20220128002707.391076-12-ben.widawsky@intel.com>
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

On Thu, 27 Jan 2022 16:27:04 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> CXL switches have HDM decoders just like host bridges and endpoints.
> Their programming works in a similar fashion.
> 
> The spec does not prohibit multiple levels of switches, however, those
> are not implemented at this time.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
One trivial comment inline, but it's end of day here so I've not taken as
deeper look at this as I probably will at some later date.

Thanks,

Jonathan

> ---
>  drivers/cxl/cxl.h    |  5 ++++
>  drivers/cxl/region.c | 61 ++++++++++++++++++++++++++++++++++++++++++--
>  2 files changed, 64 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 8ace6cca0776..d70d8c85d05f 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -96,6 +96,11 @@ static inline u8 cxl_to_ig(u16 g)
>  	return ilog2(g) - 8;
>  }
>  
> +static inline int cxl_to_ways(u8 ways)
> +{
> +	return 1 << ways;

This special case of cxl_to_interleave_ways probably needs some
documentation or a name that makes it clear why it is special.

> +}
> +
>  static inline bool cxl_is_interleave_ways_valid(int iw)
>  {
>  	switch (iw) {
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index b8982be13bfe..f748060733dd 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -359,6 +359,23 @@ static bool has_switch(const struct cxl_region *cxlr)
>  	return false;
>  }
>  
> +static bool has_multi_switch(const struct cxl_region *cxlr)
> +{
> +	struct cxl_memdev *ep;
> +	int i;
> +
> +	for_each_cxl_endpoint(ep, cxlr, i)
> +		if (ep->port->depth > 3)
> +			return true;
> +
> +	return false;
> +}
> +
> +static struct cxl_port *get_switch(struct cxl_memdev *ep)
> +{
> +	return to_cxl_port(ep->port->dev.parent);
> +}
> +
>  static struct cxl_decoder *get_decoder(struct cxl_region *cxlr,
>  				       struct cxl_port *p)
>  {
> @@ -409,6 +426,8 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
>  				      const struct cxl_decoder *rootd,
>  				      bool state_update)
>  {
> +	const int region_ig = cxl_to_ig(cxlr->config.interleave_granularity);
> +	const int region_eniw = cxl_to_eniw(cxlr->config.interleave_ways);
>  	const int num_root_ports = get_num_root_ports(cxlr);
>  	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
>  	struct cxl_decoder *cxld, *c;
> @@ -416,8 +435,12 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
>  
>  	hb_count = get_unique_hostbridges(cxlr, hbs);
>  
> -	/* TODO: Switch support */
> -	if (has_switch(cxlr))
> +	/* TODO: support multiple levels of switches */
> +	if (has_multi_switch(cxlr))
> +		return false;
> +
> +	/* TODO: x3 interleave for switches is hard. */
> +	if (has_switch(cxlr) && !is_power_of_2(region_ways(cxlr)))
>  		return false;
>  
>  	/*
> @@ -470,8 +493,14 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
>  		list_for_each_entry(rp, &hb->dports, list) {
>  			struct cxl_memdev *ep;
>  			int port_grouping = -1;
> +			int target_ndx;
>  
>  			for_each_cxl_endpoint_hb(ep, cxlr, hb, idx) {
> +				struct cxl_decoder *switch_cxld;
> +				struct cxl_dport *target;
> +				struct cxl_port *switch_port;
> +				bool found = false;
> +
>  				if (get_rp(ep) != rp)
>  					continue;
>  
> @@ -499,6 +528,34 @@ static bool region_hb_rp_config_valid(struct cxl_region *cxlr,
>  
>  				cxld->interleave_ways++;
>  				cxld->target[port_grouping] = get_rp(ep);
> +
> +				/*
> +				 * At least one switch is connected here if the endpoint
> +				 * has a depth > 2
> +				 */
> +				if (ep->port->depth == 2)
> +					continue;
> +
> +				/* Check the staged list to see if this
> +				 * port has already been added
> +				 */
> +				switch_port = get_switch(ep);
> +				list_for_each_entry(switch_cxld, &cxlr->staged_list, region_link) {
> +					if (to_cxl_port(switch_cxld->dev.parent) == switch_port)
> +						found = true;
> +				}
> +
> +				if (found) {
> +					target = cxl_find_dport_by_dev(switch_port, ep->dev.parent->parent);
> +					switch_cxld->target[target_ndx++] = target;
> +					continue;
> +				}
> +
> +				target_ndx = 0;
> +
> +				switch_cxld = get_decoder(cxlr, switch_port);
> +				switch_cxld->interleave_ways++;
> +				switch_cxld->interleave_granularity = cxl_to_ways(region_ig + region_eniw);
>  			}
>  		}
>  	}

