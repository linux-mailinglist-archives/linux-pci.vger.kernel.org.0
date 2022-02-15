Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1310D4B7211
	for <lists+linux-pci@lfdr.de>; Tue, 15 Feb 2022 17:41:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239794AbiBOQf4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Feb 2022 11:35:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233621AbiBOQfz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Feb 2022 11:35:55 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00711986EC;
        Tue, 15 Feb 2022 08:35:44 -0800 (PST)
Received: from fraeml703-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Jymsh197Pz67j34;
        Wed, 16 Feb 2022 00:35:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml703-chm.china.huawei.com (10.206.15.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.21; Tue, 15 Feb 2022 17:35:42 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Tue, 15 Feb
 2022 16:35:41 +0000
Date:   Tue, 15 Feb 2022 16:35:40 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <patches@lists.linux.dev>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Bjorn Helgaas" <helgaas@kernel.org>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 08/14] cxl/region: HB port config verification
Message-ID: <20220215163540.00003c5a@Huawei.com>
In-Reply-To: <20220128002707.391076-9-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
        <20220128002707.391076-9-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml701-chm.china.huawei.com (10.201.108.50) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 27 Jan 2022 16:27:01 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> Host bridge root port verification determines if the device ordering in
> an interleave set can be programmed through the host bridges and
> switches.
> 
> The algorithm implemented here is based on the CXL Type 3 Memory Device
> Software Guide, chapter 2.13.15. The current version of the guide does
> not yet support x3 interleave configurations, and so that's not
> supported here either.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> ---
>  .clang-format           |   1 +
>  drivers/cxl/core/port.c |   1 +
>  drivers/cxl/cxl.h       |   2 +
>  drivers/cxl/region.c    | 127 +++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 130 insertions(+), 1 deletion(-)
> 
> diff --git a/.clang-format b/.clang-format
> index 1221d53be90b..5e20206f905e 100644
> --- a/.clang-format
> +++ b/.clang-format
> @@ -171,6 +171,7 @@ ForEachMacros:
>    - 'for_each_cpu_wrap'
>    - 'for_each_cxl_decoder_target'
>    - 'for_each_cxl_endpoint'
> +  - 'for_each_cxl_endpoint_hb'
>    - 'for_each_dapm_widgets'
>    - 'for_each_dev_addr'
>    - 'for_each_dev_scope'
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 0847e6ce19ef..1d81c5f56a3e 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -706,6 +706,7 @@ struct cxl_dport *devm_cxl_add_dport(struct cxl_port *port,
>  		return ERR_PTR(-ENOMEM);
>  
>  	INIT_LIST_HEAD(&dport->list);
> +	INIT_LIST_HEAD(&dport->verify_link);
>  	dport->dport = dport_dev;
>  	dport->port_id = port_id;
>  	dport->component_reg_phys = component_reg_phys;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index a291999431c7..ed984465b59c 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -350,6 +350,7 @@ struct cxl_port {
>   * @component_reg_phys: downstream port component registers
>   * @port: reference to cxl_port that contains this downstream port
>   * @list: node for a cxl_port's list of cxl_dport instances
> + * @verify_link: node used for hb root port verification
>   */
>  struct cxl_dport {
>  	struct device *dport;
> @@ -357,6 +358,7 @@ struct cxl_dport {
>  	resource_size_t component_reg_phys;
>  	struct cxl_port *port;
>  	struct list_head list;
> +	struct list_head verify_link;
>  };
>  
>  /**
> diff --git a/drivers/cxl/region.c b/drivers/cxl/region.c
> index 562c8720da56..d2f6c990c8a8 100644
> --- a/drivers/cxl/region.c
> +++ b/drivers/cxl/region.c
> @@ -4,6 +4,7 @@
>  #include <linux/genalloc.h>
>  #include <linux/device.h>
>  #include <linux/module.h>
> +#include <linux/sort.h>
>  #include <linux/pci.h>
>  #include "cxlmem.h"
>  #include "region.h"
> @@ -36,6 +37,12 @@
>  	for (idx = 0, ep = (region)->config.targets[idx];                      \
>  	     idx < region_ways(region); ep = (region)->config.targets[++idx])
>  
> +#define for_each_cxl_endpoint_hb(ep, region, hb, idx)                          \
> +	for (idx = 0, (ep) = (region)->config.targets[idx];                    \
> +	     idx < region_ways(region);                                        \
> +	     idx++, (ep) = (region)->config.targets[idx])                      \
> +		if (get_hostbridge(ep) == (hb))
> +
>  #define for_each_cxl_decoder_target(dport, decoder, idx)                       \
>  	for (idx = 0, dport = (decoder)->target[idx];                          \
>  	     idx < (decoder)->nr_targets - 1;                                  \
> @@ -299,6 +306,59 @@ static bool region_xhb_config_valid(const struct cxl_region *cxlr,
>  	return true;
>  }
>  
> +static struct cxl_dport *get_rp(struct cxl_memdev *ep)
> +{
> +	struct cxl_port *port, *parent_port = port = ep->port;
> +	struct cxl_dport *dport;
> +
> +	while (!is_cxl_root(port)) {
> +		parent_port = to_cxl_port(port->dev.parent);
> +		if (parent_port->depth == 1)
> +			list_for_each_entry(dport, &parent_port->dports, list)
> +				if (dport->dport == port->uport->parent->parent)
> +					return dport;
> +		port = parent_port;
> +	}
> +
> +	BUG();
> +	return NULL;
> +}
> +
> +static int get_num_root_ports(const struct cxl_region *cxlr)
> +{
> +	struct cxl_memdev *endpoint;
> +	struct cxl_dport *dport, *tmp;
> +	int num_root_ports = 0;
> +	LIST_HEAD(root_ports);
> +	int idx;
> +
> +	for_each_cxl_endpoint(endpoint, cxlr, idx) {
> +		struct cxl_dport *root_port = get_rp(endpoint);
> +
> +		if (list_empty(&root_port->verify_link)) {
> +			list_add_tail(&root_port->verify_link, &root_ports);
> +			num_root_ports++;
> +		}
> +	}
> +
> +	list_for_each_entry_safe(dport, tmp, &root_ports, verify_link)
> +		list_del_init(&dport->verify_link);
> +
> +	return num_root_ports;
> +}
> +
> +static bool has_switch(const struct cxl_region *cxlr)
> +{
> +	struct cxl_memdev *ep;
> +	int i;
> +
> +	for_each_cxl_endpoint(ep, cxlr, i)
> +		if (ep->port->depth > 2)
> +			return true;
> +
> +	return false;
> +}
> +
>  /**
>   * region_hb_rp_config_valid() - determine root port ordering is correct
>   * @cxlr: Region to validate
> @@ -312,7 +372,72 @@ static bool region_xhb_config_valid(const struct cxl_region *cxlr,
>  static bool region_hb_rp_config_valid(const struct cxl_region *cxlr,
>  				      const struct cxl_decoder *rootd)
>  {
> -	/* TODO: */
> +	const int num_root_ports = get_num_root_ports(cxlr);
> +	struct cxl_port *hbs[CXL_DECODER_MAX_INTERLEAVE];
> +	int hb_count, i;
> +
> +	hb_count = get_unique_hostbridges(cxlr, hbs);
> +
> +	/* TODO: Switch support */
> +	if (has_switch(cxlr))
> +		return false;
> +
> +	/*
> +	 * Are all devices in this region on the same CXL Host Bridge
> +	 * Root Port?
> +	 */
> +	if (num_root_ports == 1 && !has_switch(cxlr))
> +		return true;
> +
> +	for (i = 0; i < hb_count; i++) {
> +		int idx, position_mask;
> +		struct cxl_dport *rp;
> +		struct cxl_port *hb;
> +
> +		/* Get next CXL Host Bridge this region spans */
> +		hb = hbs[i];
> +
> +		/*
> +		 * Calculate the position mask: NumRootPorts = 2^PositionMask
> +		 * for this region.
> +		 *
> +		 * XXX: pos_mask is actually (1 << PositionMask)  - 1
> +		 */
> +		position_mask = (1 << (ilog2(num_root_ports))) - 1;

Needs to account for the root ports potentially being spread over multiple host
bridges.  For now I'm assuming some symmetry to move my own testing forwards
but that's not strictly required if we want to be really flexible.

So I've been using

		position_mask = (1 << (ilog2(num_root_ports/hb_count)) - 1;


> +
> +		/*
> +		 * Calculate the PortGrouping for each device on this CXL Host
> +		 * Bridge Root Port:
> +		 * PortGrouping = RegionLabel.Position & PositionMask
> +		 *
> +		 * The following nest iterators effectively iterate over each
> +		 * root port in the region.
> +		 *   for_each_unique_rootport(rp, cxlr)
> +		 */
> +		list_for_each_entry(rp, &hb->dports, list) {
> +			struct cxl_memdev *ep;
> +			int port_grouping = -1;
> +
> +			for_each_cxl_endpoint_hb(ep, cxlr, hb, idx) {
> +				if (get_rp(ep) != rp)
> +					continue;
> +
> +				if (port_grouping == -1)
> +					port_grouping = idx & position_mask;
> +
> +				/*
> +				 * Do all devices in the region connected to this CXL
> +				 * Host Bridge Root Port have the same PortGrouping?
> +				 */
> +				if ((idx & position_mask) != port_grouping) {
> +					dev_dbg(&cxlr->dev,
> +						"One or more devices are not connected to the correct Host Bridge Root Port\n");
> +					return false;
> +				}
> +			}
> +		}
> +	}
> +
>  	return true;
>  }
>  

