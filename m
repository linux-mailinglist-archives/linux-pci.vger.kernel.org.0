Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C61D57BBFF
	for <lists+linux-pci@lfdr.de>; Wed, 20 Jul 2022 18:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbiGTQxN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 20 Jul 2022 12:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiGTQxL (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 20 Jul 2022 12:53:11 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DF0A69F04;
        Wed, 20 Jul 2022 09:53:10 -0700 (PDT)
Received: from fraeml704-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Lp1rk0ZgRz6J6Bh;
        Thu, 21 Jul 2022 00:49:42 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml704-chm.china.huawei.com (10.206.15.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Wed, 20 Jul 2022 18:53:08 +0200
Received: from localhost (10.81.205.121) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Wed, 20 Jul
 2022 17:53:07 +0100
Date:   Wed, 20 Jul 2022 17:53:06 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <hch@lst.de>,
        <nvdimm@lists.linux.dev>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 10/28] cxl/port: Record dport in endpoint references
Message-ID: <20220720175306.000009d7@Huawei.com>
In-Reply-To: <165784329944.1758207.15203961796832072116.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
        <165784329944.1758207.15203961796832072116.stgit@dwillia2-xfh.jf.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.81.205.121]
X-ClientProxiedBy: lhreml754-chm.china.huawei.com (10.201.108.204) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, 14 Jul 2022 17:01:39 -0700
Dan Williams <dan.j.williams@intel.com> wrote:

> Recall that the primary role of the cxl_mem driver is to probe if the
> given endpoint is connected to a CXL port topology. In that process it
> walks its device ancestry to its PCI root port. If that root port is
> also a CXL root port then the probe process adds cxl_port object
> instances at switch in the path between to the root and the endpoint. As
> those cxl_port instances are added, or if a previous enumeration
> attempt already created the port, a 'struct cxl_ep' instance is
> registered with that port to track the endpoints interested in that
> port.
> 
> At the time the cxl_ep is registered the downstream egress path from the
> port to the endpoint is known. Take the opportunity to record that
> information as it will be needed for dynamic programming of decoder
> targets during region provisioning.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
You answered my queries on previous version, so I'm happy with this.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/core/port.c |   52 ++++++++++++++++++++++++++++++++---------------
>  drivers/cxl/cxl.h       |    2 ++
>  2 files changed, 37 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index fdc1be7db917..a8d350361548 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -882,8 +882,9 @@ static struct cxl_ep *find_ep(struct cxl_port *port, struct device *ep_dev)
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
> @@ -901,14 +902,14 @@ static int add_ep(struct cxl_port *port, struct cxl_ep *new)
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
> @@ -919,8 +920,9 @@ static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
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
> @@ -929,11 +931,13 @@ static int cxl_add_ep(struct cxl_port *port, struct device *ep_dev)
>  struct cxl_find_port_ctx {
>  	const struct device *dport_dev;
>  	const struct cxl_port *parent_port;
> +	struct cxl_dport **dport;
>  };
>  
>  static int match_port_by_dport(struct device *dev, const void *data)
>  {
>  	const struct cxl_find_port_ctx *ctx = data;
> +	struct cxl_dport *dport;
>  	struct cxl_port *port;
>  
>  	if (!is_cxl_port(dev))
> @@ -942,7 +946,10 @@ static int match_port_by_dport(struct device *dev, const void *data)
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
> @@ -958,24 +965,32 @@ static struct cxl_port *__find_cxl_port(struct cxl_find_port_ctx *ctx)
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
> @@ -1060,7 +1075,7 @@ static void cxl_detach_ep(void *data)
>  		if (!dport_dev)
>  			break;
>  
> -		port = find_cxl_port(dport_dev);
> +		port = find_cxl_port(dport_dev, NULL);
>  		if (!port)
>  			continue;
>  
> @@ -1135,6 +1150,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	struct device *dparent = grandparent(dport_dev);
>  	struct cxl_port *port, *parent_port = NULL;
>  	resource_size_t component_reg_phys;
> +	struct cxl_dport *dport;
>  	int rc;
>  
>  	if (!dparent) {
> @@ -1148,7 +1164,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  		return -ENXIO;
>  	}
>  
> -	parent_port = find_cxl_port(dparent);
> +	parent_port = find_cxl_port(dparent, NULL);
>  	if (!parent_port) {
>  		/* iterate to create this parent_port */
>  		return -EAGAIN;
> @@ -1163,13 +1179,14 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
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
> @@ -1179,7 +1196,7 @@ static int add_port_attach_ep(struct cxl_memdev *cxlmd,
>  	else {
>  		dev_dbg(&cxlmd->dev, "add to new port %s:%s\n",
>  			dev_name(&port->dev), dev_name(port->uport));
> -		rc = cxl_add_ep(port, &cxlmd->dev);
> +		rc = cxl_add_ep(dport, &cxlmd->dev);
>  		if (rc == -EEXIST) {
>  			/*
>  			 * "can't" happen, but this error code means
> @@ -1213,6 +1230,7 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
>  	for (iter = dev; iter; iter = grandparent(iter)) {
>  		struct device *dport_dev = grandparent(iter);
>  		struct device *uport_dev;
> +		struct cxl_dport *dport;
>  		struct cxl_port *port;
>  
>  		if (!dport_dev)
> @@ -1228,12 +1246,12 @@ int devm_cxl_enumerate_ports(struct cxl_memdev *cxlmd)
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
> @@ -1274,7 +1292,7 @@ EXPORT_SYMBOL_NS_GPL(devm_cxl_enumerate_ports, CXL);
>  
>  struct cxl_port *cxl_mem_find_port(struct cxl_memdev *cxlmd)
>  {
> -	return find_cxl_port(grandparent(&cxlmd->dev));
> +	return find_cxl_port(grandparent(&cxlmd->dev), NULL);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_mem_find_port, CXL);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 70cd24e4f3ce..31f33844279a 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -371,10 +371,12 @@ struct cxl_dport {
>  /**
>   * struct cxl_ep - track an endpoint's interest in a port
>   * @ep: device that hosts a generic CXL endpoint (expander or accelerator)
> + * @dport: which dport routes to this endpoint on @port
>   * @list: node on port->endpoints list
>   */
>  struct cxl_ep {
>  	struct device *ep;
> +	struct cxl_dport *dport;
>  	struct list_head list;
>  };
>  
> 

