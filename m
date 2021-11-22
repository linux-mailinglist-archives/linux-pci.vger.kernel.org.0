Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BED245943A
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 18:48:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbhKVRv1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 12:51:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4145 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbhKVRv0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 12:51:26 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HyZV05f14z67KRy;
        Tue, 23 Nov 2021 01:47:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 18:48:18 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 17:48:17 +0000
Date:   Mon, 22 Nov 2021 17:48:16 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 21/23] cxl: Unify port enumeration for decoders
Message-ID: <20211122174816.00001046@Huawei.com>
In-Reply-To: <20211120000250.1663391-22-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-22-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.41]
X-ClientProxiedBy: lhreml737-chm.china.huawei.com (10.201.108.187) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 19 Nov 2021 16:02:48 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The port driver exists to do proper enumeration of the component
> registers for ports, including HDM decoder resources. Any port which
> follows the CXL specification to implement HDM decoder registers should
> be handled by the port driver. This includes host bridge registers that
> are currently handled within the cxl_acpi driver.
> 
> In moving the responsibility from cxl_acpi to cxl_port, three primary
> things are accomplished here:
> 1. Multi-port host bridges are now handled by the port driver
> 2. Single port host bridges are handled by the port driver
> 3. Single port switches without component registers will be handled by
>    the port driver.
> 
> While it's tempting to remove decoder APIs from cxl_core entirely, it is
> still required that platform specific drivers are able to add decoders
> which aren't specified in CXL 2.0+. An example of this is the CFMWS
> parsing which is implementing in cxl_acpi.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
One trivial suggestion inline, but looks fine to me otherwise.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> 
> ---
> Changes since RFCv2:
> - Renamed subject
> - Reworded commit message
> - Handle *all* host bridge port enumeration in cxl_port (Dan)
>   - Handle passthrough decoding in cxl_port
> ---
>  drivers/cxl/acpi.c     | 41 +++-----------------------------
>  drivers/cxl/core/bus.c |  6 +++--
>  drivers/cxl/cxl.h      |  2 ++
>  drivers/cxl/port.c     | 54 +++++++++++++++++++++++++++++++++++++++++-
>  4 files changed, 62 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index c12e4fed7941..c85a04ecbf7f 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -210,8 +210,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
>  	struct acpi_pci_root *pci_root;
>  	struct cxl_walk_context ctx;
> -	int single_port_map[1], rc;
> -	struct cxl_decoder *cxld;
>  	struct cxl_dport *dport;
>  	struct cxl_port *port;
>  
> @@ -245,43 +243,9 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  		return -ENODEV;
>  	if (ctx.error)
>  		return ctx.error;
> -	if (ctx.count > 1)
> -		return 0;
>  
> -	/* TODO: Scan CHBCR for HDM Decoder resources */
> -
> -	/*
> -	 * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability
> -	 * Structure) single ported host-bridges need not publish a decoder
> -	 * capability when a passthrough decode can be assumed, i.e. all
> -	 * transactions that the uport sees are claimed and passed to the single
> -	 * dport. Disable the range until the first CXL region is enumerated /
> -	 * activated.
> -	 */
> -	cxld = cxl_decoder_alloc(port, 1);
> -	if (IS_ERR(cxld))
> -		return PTR_ERR(cxld);
> -
> -	cxld->interleave_ways = 1;
> -	cxld->interleave_granularity = PAGE_SIZE;
> -	cxld->target_type = CXL_DECODER_EXPANDER;
> -	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
> -
> -	device_lock(&port->dev);
> -	dport = list_first_entry(&port->dports, typeof(*dport), list);
> -	device_unlock(&port->dev);
> -
> -	single_port_map[0] = dport->port_id;
> -
> -	rc = cxl_decoder_add(cxld, single_port_map);
> -	if (rc)
> -		put_device(&cxld->dev);
> -	else
> -		rc = cxl_decoder_autoremove(host, cxld);
> -
> -	if (rc == 0)
> -		dev_dbg(host, "add: %s\n", dev_name(&cxld->dev));
> -	return rc;
> +	/* Host bridge ports are enumerated by the port driver. */
> +	return 0;
>  }
>  
>  struct cxl_chbs_context {
> @@ -448,3 +412,4 @@ module_platform_driver(cxl_acpi_driver);
>  MODULE_LICENSE("GPL v2");
>  MODULE_IMPORT_NS(CXL);
>  MODULE_IMPORT_NS(ACPI);
> +MODULE_SOFTDEP("pre: cxl_port");
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 46a06cfe79bd..acfa212eea21 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -62,7 +62,7 @@ void cxl_unregister_topology_host(struct device *host)
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_unregister_topology_host, CXL);
>  
> -static struct device *get_cxl_topology_host(void)
> +struct device *get_cxl_topology_host(void)
>  {
>  	down_read(&topology_host_sem);
>  	if (cxl_topology_host)
> @@ -70,12 +70,14 @@ static struct device *get_cxl_topology_host(void)
>  	up_read(&topology_host_sem);
>  	return NULL;
>  }
> +EXPORT_SYMBOL_NS_GPL(get_cxl_topology_host, CXL);
>  
> -static void put_cxl_topology_host(struct device *dev)
> +void put_cxl_topology_host(struct device *dev)
>  {
>  	WARN_ON(dev != cxl_topology_host);
>  	up_read(&topology_host_sem);
>  }
> +EXPORT_SYMBOL_NS_GPL(put_cxl_topology_host, CXL);
>  
>  static int decoder_match(struct device *dev, void *data)
>  {
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 24fa16157d5e..f8354241c5a3 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -170,6 +170,8 @@ void __iomem *devm_cxl_iomap_block(struct device *dev, resource_size_t addr,
>  
>  int cxl_register_topology_host(struct device *host);
>  void cxl_unregister_topology_host(struct device *host);
> +struct device *get_cxl_topology_host(void);
> +void put_cxl_topology_host(struct device *dev);
>  
>  /*
>   * cxl_decoder flags that define the type of memory / devices this
> diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
> index 3c03131517af..7a1fc726fe9f 100644
> --- a/drivers/cxl/port.c
> +++ b/drivers/cxl/port.c
> @@ -233,12 +233,64 @@ static int enumerate_hdm_decoders(struct cxl_port *port,
>  	return 0;
>  }
>  
> +/*
> + * Per the CXL specification (8.2.5.12 CXL HDM Decoder Capability Structure)
> + * single ported host-bridges need not publish a decoder capability when a
> + * passthrough decode can be assumed, i.e. all transactions that the uport sees
> + * are claimed and passed to the single dport. Disable the range until the first
> + * CXL region is enumerated / activated.
> + */
> +static int add_passthrough_decoder(struct cxl_port *port)
> +{
> +	int single_port_map[1], rc;
> +	struct cxl_decoder *cxld;
> +	struct cxl_dport *dport;
> +
> +	device_lock_assert(&port->dev);
> +
> +	cxld = cxl_decoder_alloc(port, 1);
> +	if (IS_ERR(cxld))
> +		return PTR_ERR(cxld);
> +
> +	cxld->interleave_ways = 1;
> +	cxld->interleave_granularity = PAGE_SIZE;
> +	cxld->target_type = CXL_DECODER_EXPANDER;
> +	cxld->platform_res = (struct resource)DEFINE_RES_MEM(0, 0);
> +
> +	dport = list_first_entry(&port->dports, typeof(*dport), list);
> +	single_port_map[0] = dport->port_id;
> +
> +	rc = cxl_decoder_add_locked(cxld, single_port_map);
> +	if (rc)
> +		put_device(&cxld->dev);

I would handle this error path entirely here, or use a goto rather
than messing up the good path with conditionals on each element,
particularly as there isn't much to do in the error paths.
I guess this might get more complicated in later patches though.

Obviously that tidy up would make this more complex than simply moving
the code. (I might have commented on this before, but too long ago to remember ;)

	if (rc) {
		put_device(&cxld->dev);
		return rc;
	}
	rc = cxl_decoder...
	if (rc)
		return rc;

	dev_dbg(..

	return 0;

> +	else
> +		rc = cxl_decoder_autoremove(&port->dev, cxld);
> +
> +	if (rc == 0)
> +		dev_dbg(&port->dev, "add: %s\n", dev_name(&cxld->dev));
> +
> +	return rc;
> +}
> +
