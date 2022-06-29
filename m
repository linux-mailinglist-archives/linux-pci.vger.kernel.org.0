Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4634B5606AE
	for <lists+linux-pci@lfdr.de>; Wed, 29 Jun 2022 18:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbiF2Qt5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Jun 2022 12:49:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229865AbiF2Qtn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Jun 2022 12:49:43 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7570B64EC;
        Wed, 29 Jun 2022 09:49:41 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LY6qS6ZRKz67NYq;
        Thu, 30 Jun 2022 00:48:52 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 18:49:39 +0200
Received: from localhost (10.202.226.42) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.24; Wed, 29 Jun
 2022 17:49:38 +0100
Date:   Wed, 29 Jun 2022 17:49:36 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@infradead.org>,
        <alison.schofield@intel.com>, <nvdimm@lists.linux.dev>,
        <linux-pci@vger.kernel.org>, <patches@lists.linux.dev>
Subject: Re: [PATCH 25/46] cxl/port: Record dport in endpoint references
Message-ID: <20220629174936.00003a1f@Huawei.com>
In-Reply-To: <165603888756.551046.17250550519692729454.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
        <165603888756.551046.17250550519692729454.stgit@dwillia2-xfh>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.42]
X-ClientProxiedBy: lhreml709-chm.china.huawei.com (10.201.108.58) To
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

On Thu, 23 Jun 2022 19:48:07 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Recall that the primary role of the cxl_mem driver is to probe if the
> given endoint is connected to a CXL port topology. In that process it
> walks its device ancestry to its PCI root port. If that root port is
> also a CXL root port then the probe process adds cxl_port object
> instances at switch in the path between to the root and the endpoint. As
> those cxl_port instances are added, or if a previous enumeration
> attempt already created the port a 'struct cxl_ep' instance is
port, a 

would make this more readable.

> registered with that port to track the endpoints interested in that
> port.
> 
> At the time the cxl_ep is registered the downstream egress path from the
> port to the endpoint is known. Take the opportunity to record that
> information as it will be needed for dynamic programming of decoder
> targets during region provisioning.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>

Otherwise, one comment on function naming not reflecting what it does
inline.

Jonathan

> ---
>  drivers/cxl/core/port.c |   52 ++++++++++++++++++++++++++++++++---------------
>  drivers/cxl/cxl.h       |    2 ++
>  2 files changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 4e4e26ca507c..c54e1dbf92cb 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -866,8 +866,9 @@ static struct cxl_ep *find_ep(struct cxl_port *port, struct device *ep_dev)
>  	return NULL;
>  }
>  
> -static int add_ep(struct cxl_port *port, struct cxl_ep *new)
> +static int add_ep(struct cxl_ep *new)
>  {
> +	struct cxl_port *port = new->dport->port;
>  	struct cxl_ep *dup;
>  
>  	device_lock(&port->dev);
> @@ -885,14 +886,14 @@ static int add_ep(struct cxl_port *port, struct cxl_ep *new)
>  
>  /**
>   * cxl_add_ep - register an endpoint's interest in a port
> - * @port: a port in the endpoint's topology ancestry
> + * @dport: the dport that routes to @ep_dev
>   * @ep_dev: device representing the endpoint
>   *
>   * Intermediate CXL ports are scanned based on the arrival of endpoints.
>   * When those endpoints depart the port can be destroyed once all
>   * endpoints that care about that port have been removed.
>   */
> -static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
> +static int cxl_add_ep(struct cxl_dport *dport, struct device *ep_dev)
>  {
>  	struct cxl_ep *ep;
>  	int rc;
> @@ -903,8 +904,9 @@ static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
>  
>  	INIT_LIST_HEAD(&ep->list);
>  	ep->ep = get_device(ep_dev);
> +	ep->dport = dport;
>  
> -	rc = add_ep(port, ep);
> +	rc = add_ep(ep);
>  	if (rc)
>  		cxl_ep_release(ep);
>  	return rc;
> @@ -913,11 +915,13 @@ static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
>  struct cxl_find_port_ctx {
>  	const struct device *dport_dev;
>  	const struct cxl_port *parent_port;
> +	struct cxl_dport **dport;
>  };
>  
>  static int match_port_by_dport(struct device *dev, const void *data)
>  {

This seems a little oddly name for a function that 'returns'
the dport via ctx when a match is found.


>  	const struct cxl_find_port_ctx *ctx = data;
> +	struct cxl_dport *dport;
>  	struct cxl_port *port;
>  
>  	if (!is_cxl_port(dev))
> @@ -926,7 +930,10 @@ static int match_port_by_dport(struct device *dev, const void *data)
>  		return 0;
>  
>  	port = to_cxl_port(dev);
> -	return cxl_find_dport_by_dev(port, ctx->dport_dev) != NULL;
> +	dport = cxl_find_dport_by_dev(port, ctx->dport_dev);
> +	if (ctx->dport)
> +		*ctx->dport = dport;
> +	return dport != NULL;
>  }
>  
>  static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
> @@ -942,24 +949,32 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
>  	return NULL;
>  }
>  
> -static struct cxl_port *find_cxl_port(struct device *dport_dev)
> +static struct cxl_port *find_cxl_port(struct device *dport_dev,
> +				      struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
> +		.dport = dport,
>  	};
> +	struct cxl_port *port;
>  
> -	return __find_cxl_port(&ctx);
> +	port = __find_cxl_port(&ctx);
> +	return port;
>  }
>  
>  static struct cxl_port *find_cxl_port_at(struct cxl_port *parent_port,
> -					 struct device *dport_dev)
> +					 struct device *dport_dev,
> +					 struct cxl_dport **dport)
>  {
>  	struct cxl_find_port_ctx ctx = {
>  		.dport_dev = dport_dev,
>  		.parent_port = parent_port,
> +		.dport = dport,
>  	};
> +	struct cxl_port *port;
>  
> -	return __find_cxl_port(&ctx);
> +	port = __find_cxl_port(&ctx);
> +	return port;
>  }
>  
>  /*
> @@ -1044,7 +1059,7 @@ static void cxl_detach_ep(void *data)
>  		if (!dport_dev)
>  			break;
>  
> -		port = find_cxl_port(dport_dev);
> +		port = find_cxl_port(dport_dev, NULL);
>  		if (!port)
>  			continue;
>  
> @@ -1119,6 +1134,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	struct device *dparent = grandparent(dport_dev);
>  	struct cxl_port *port, *parent_port = NULL;
>  	resource_size_t component_reg_phys;
> +	struct cxl_dport *dport;
>  	int rc;
>  
>  	if (!dparent) {
> @@ -1132,7 +1148,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		return -ENXIO;
>  	}
>  
> -	parent_port = find_cxl_port(dparent);
> +	parent_port = find_cxl_port(dparent, NULL);
>  	if (!parent_port) {
>  		/* iterate to create this parent_port */
>  		return -EAGAIN;
> @@ -1147,13 +1163,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		goto out;
>  	}
>  
> -	port = find_cxl_port_at(parent_port, dport_dev);
> +	port = find_cxl_port_at(parent_port, dport_dev, &dport);
>  	if (!port) {
>  		component_reg_phys = find_component_registers(uport_dev);
>  		port = devm_cxl_add_port(&parent_port->dev, uport_dev,
>  					 component_reg_phys, parent_port);
> +		/* retry find to pick up the new dport information */
>  		if (!IS_ERR(port))
> -			get_device(&port->dev);
> +			port = find_cxl_port_at(parent_port, dport_dev, &dport);
>  	}
>  out:
>  	device_unlock(&parent_port->dev);
> @@ -1163,7 +1180,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	else {
>  		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
>  			dev_name(&port->dev), dev_name(port->uport));
> -		rc = cxl_add_ep(port, &cxlmd->dev);
> +		rc = cxl_add_ep(dport, &cxlmd->dev);
>  		if (rc == -EEXIST) {
>  			/*
>  			 * "can't" happen, but this error code means
> @@ -1197,6 +1214,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  	for (iter = dev; iter; iter = grandparent(iter)) {
>  		struct device *dport_dev = grandparent(iter);
>  		struct device *uport_dev;
> +		struct cxl_dport *dport;
>  		struct cxl_port *port;
>  
>  		if (!dport_dev)
> @@ -1212,12 +1230,12 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  		dev_dbg(dev, "scan: iter: %s dport_dev: %s parent: %s\n",
>  			dev_name(iter), dev_name(dport_dev),
>  			dev_name(uport_dev));
> -		port = find_cxl_port(dport_dev);
> +		port = find_cxl_port(dport_dev, &dport);
>  		if (port) {
>  			dev_dbg(&cxlmd->dev,
>  				"found already registered port %s:%s\n",
>  				dev_name(&port->dev), dev_name(port->uport));
> -			rc = cxl_add_ep(port, &cxlmd->dev);
> +			rc = cxl_add_ep(dport, &cxlmd->dev);
>  
>  			/*
>  			 * If the endpoint already exists in the port's list,
> @@ -1258,7 +1276,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
>  
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
>  {
> -	return find_cxl_port(grandparent(&cxlmd->dev));
> +	return find_cxl_port(grandparent(&cxlmd->dev), NULL);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index d8edbdaa6208..e654251a54dd 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -363,10 +363,12 @@ struct cxl_dport {
>  /**
>   * struct cxl_ep - track an endpoint's interest in a port
>   * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
> + * @dport: which dport routes to this endpoint on this port
>   * @list: node on port->endpoints list
>   */
>  struct cxl_ep {
>  	struct device *ep;
> +	struct cxl_dport *dport;
>  	struct list_head list;
>  };
>  
> 

