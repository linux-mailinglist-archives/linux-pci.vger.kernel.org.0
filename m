Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC6755EA3D
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 18:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232429AbiF1Quk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 12:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbiF1Qpv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 12:45:51 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84175F74;
        Tue, 28 Jun 2022 09:43:51 -0700 (PDT)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LXVgR3m5zz6H775;
        Wed, 29 Jun 2022 00:39:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 28 Jun 2022 18:43:48 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 17:43:47 +0100
Date:   Tue, 28 Jun 2022 17:43:46 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 09/46] cxl/acpi: Track CXL resources in iomem_resource
Message-ID: <20220628174346.00005dcc@Huawei.com>
In-Reply-To: <165603876550.551046.11015869763159096807.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603876550.551046.11015869763159096807.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml712-chm.china.huawei.com (10.201.108.63) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 23 Jun 2022 19:46:05 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Recall that CXL capable address ranges, on ACPI platforms, are published
> in the CEDT.CFMWS (CXL Early Discovery Table - CXL Fixed Memory Window
> Structures). These windows represent both the actively mapped capacity
> and the potential address space that can be dynamically assigned to a
> new CXL decode configuration.
> 
> CXL endpoints like DDR DIMMs can be mapped at any physical address
> including 0 and legacy ranges.
> 
> There is an expectation and requirement that the /proc/iomem interface
> and the iomem_resource in the kernel reflect the full set of platform
> address ranges. I.e. that every address range that platform firmware and
> bus drivers enumerate be reflected as an iomem_resource entry. The hard
> requirement to do this for CXL arises from the fact that capabilities
> like CONFIG_DEVICE_PRIVATE expect to be able to treat empty
> iomem_resource ranges as free for software to use as proxy address
> space. Without CXL publishing its potential address ranges in
> iomem_resource, the CONFIG_DEVICE_PRIVATE mechanism may inadvertently
> steal capacity reserved for runtime provisioning of new CXL regions.
> 
> The approach taken supports dynamically publishing the CXL window map on
> demand when a CXL platform driver like cxl_acpi loads. The windows are
> then forced into the first level of iomem_resource tree via the
> insert_resource_expand_to_fit() API. This forcing sacrifices some
> resource boundary accurracy in order to better reflect the decode
> hierarchy of a CXL window hosting "System RAM" and other resources.

I don't fully understand this and in particular what assumptions it
is making.  How do we end up with overlaping resources via just parsing
the CFMWS for instance...

I would shout a lot louder in this description about using the CXL NS
for that export.  That's liable to be controversial.

> 
> Walkers of the iomem_resource tree will also need to have access to the
> related 'struct cxl_decoder' instances to disambiguate which portions of
> a CXL memory resource are present vs expanded to enforce the expected
> resource topology.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.c |  110 +++++++++++++++++++++++++++++++++++++++++++++++++++-
>  kernel/resource.c  |    7 +++
>  2 files changed, 114 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index d1b914dfa36c..003fa4fde357 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -73,6 +73,7 @@ static int cxl_acpi_cfmws_verify(struct device *dev,
>  struct cxl_cfmws_context {
>  	struct device *dev;
>  	struct cxl_port *root_port;
> +	int id;
>  };
>  
>  static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
> @@ -84,8 +85,10 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	struct cxl_switch_decoder *cxlsd;
>  	struct device *dev = ctx->dev;
>  	struct acpi_cedt_cfmws *cfmws;
> +	struct resource *cxl_res;
>  	struct cxl_decoder *cxld;
>  	unsigned int ways, i, ig;
> +	struct resource *res;
>  	int rc;
>  
>  	cfmws = (struct acpi_cedt_cfmws *) header;
> @@ -107,6 +110,24 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	for (i = 0; i < ways; i++)
>  		target_map[i] = cfmws->interleave_targets[i];
>  
> +	res = kzalloc(sizeof(*res), GFP_KERNEL);
> +	if (!res)
> +		return -ENOMEM;
> +
> +	res->name = kasprintf(GFP_KERNEL, "CXL Window %d", ctx->id++);
> +	if (!res->name)
> +		goto err_name;
> +
> +	res->start = cfmws->base_hpa;
> +	res->end = cfmws->base_hpa + cfmws->window_size - 1;
> +	res->flags = IORESOURCE_MEM;
> +
> +	/* add to the local resource tracking to establish a sort order */
> +	cxl_res = dev_get_drvdata(&root_port->dev);

As mentioned below, why not add cxl_res to the ctx?

> +	rc = insert_resource(cxl_res, res);
> +	if (rc)
> +		goto err_insert;
> +
>  	cxlsd = cxl_root_decoder_alloc(root_port, ways);
>  	if (IS_ERR(cxld))
>  		return 0;
> @@ -115,8 +136,8 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	cxld->flags = cfmws_to_decoder_flags(cfmws->restrictions);
>  	cxld->target_type = CXL_DECODER_EXPANDER;
>  	cxld->hpa_range = (struct range) {
> -		.start = cfmws->base_hpa,
> -		.end = cfmws->base_hpa + cfmws->window_size - 1,
> +		.start = res->start,
> +		.end = res->end,
>  	};
>  	cxld->interleave_ways = ways;
>  	cxld->interleave_granularity = ig;
> @@ -131,12 +152,19 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  			cxld->hpa_range.start, cxld->hpa_range.end);
>  		return 0;
>  	}
> +
Another whitespace tweak that shouldn't be in a patch like this...

>  	dev_dbg(dev, "add: %s node: %d range [%#llx - %#llx]\n",
>  		dev_name(&cxld->dev),
>  		phys_to_target_node(cxld->hpa_range.start),
>  		cxld->hpa_range.start, cxld->hpa_range.end);
>  
>  	return 0;
> +
> +err_insert:
> +	kfree(res->name);
> +err_name:
> +	kfree(res);
> +	return -ENOMEM;
>  }
>  
>  __mock struct acpi_device *to_cxl_host_bridge(struct device *host,
> @@ -291,9 +319,66 @@ static void cxl_acpi_lock_reset_class(void *dev)
>  	device_lock_reset_class(dev);
>  }
>  
> +static void del_cxl_resource(struct resource *res)
> +{
> +	kfree(res->name);
> +	kfree(res);
> +}
> +
> +static void remove_cxl_resources(void *data)
> +{
> +	struct resource *res, *next, *cxl = data;
> +
> +	for (res = cxl->child; res; res = next) {
> +		struct resource *victim = (struct resource *) res->desc;
> +
> +		next = res->sibling;
> +		remove_resource(res);
> +
> +		if (victim) {
> +			remove_resource(victim);
> +			kfree(victim);
> +		}
> +
> +		del_cxl_resource(res);
> +	}
> +}
> +
> +static int add_cxl_resources(struct resource *cxl)

I'd like to see some documentation of what this is doing...

> +{
> +	struct resource *res, *new, *next;
> +
> +	for (res = cxl->child; res; res = next) {
> +		new = kzalloc(sizeof(*new), GFP_KERNEL);
> +		if (!new)
> +			return -ENOMEM;
> +		new->name = res->name;
> +		new->start = res->start;
> +		new->end = res->end;
> +		new->flags = IORESOURCE_MEM;
> +		res->desc = (unsigned long) new;
> +
> +		insert_resource_expand_to_fit(&iomem_resource, new);

Given you've called out limitations of this call in the patch description
it would be good to have some of that info in the code.

> +
> +		next = res->sibling;
> +		while (next && resource_overlaps(new, next)) {

I'm struggling to grasp why we'd have overlaps, comments would probably help.

> +			if (resource_contains(new, next)) {
> +				struct resource *_next = next->sibling;
> +
> +				remove_resource(next);
> +				del_cxl_resource(next);
> +				next = _next;
> +			} else
> +				next->start = new->end + 1;
> +		}
> +	}
> +	return 0;
> +}
> +
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>  	int rc;
> +	struct resource *cxl_res;
>  	struct cxl_port *root_port;
>  	struct device *host = &pdev->dev;
>  	struct acpi_device *adev = ACPI_COMPANION(host);
> @@ -305,21 +390,40 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	if (rc)
>  		return rc;
>  
> +	cxl_res = devm_kzalloc(host, sizeof(*cxl_res), GFP_KERNEL);
> +	if (!cxl_res)
> +		return -ENOMEM;
> +	cxl_res->name = "CXL mem";
> +	cxl_res->start = 0;
> +	cxl_res->end = -1;
> +	cxl_res->flags = IORESOURCE_MEM;
> +
>  	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
>  	if (IS_ERR(root_port))
>  		return PTR_ERR(root_port);
>  	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
> +	dev_set_drvdata(&root_port->dev, cxl_res);

Rather ugly way of sneaking it into the callback. If that is the only
purpose, perhaps better to just add to the cxl_cfmws_context.

>  
>  	rc = bus_for_each_dev(adev->dev.bus, NULL, root_port,
>  			      add_host_bridge_dport);
>  	if (rc < 0)
>  		return rc;
>  
> +	rc = devm_add_action_or_reset(host, remove_cxl_resources, cxl_res);
> +	if (rc)
> +		return rc;
> +
>  	ctx = (struct cxl_cfmws_context) {
>  		.dev = host,
>  		.root_port = root_port,
>  	};
> -	acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
> +	rc = acpi_table_parse_cedt(ACPI_CEDT_TYPE_CFMWS, cxl_parse_cfmws, &ctx);
> +	if (rc < 0)
> +		return -ENXIO;
> +
> +	rc = add_cxl_resources(cxl_res);
> +	if (rc)
> +		return rc;
>  
>  	/*
>  	 * Root level scanned with host-bridge as dports, now scan host-bridges

