Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3549745949E
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 19:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbhKVSX0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 13:23:26 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4151 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbhKVSXZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 13:23:25 -0500
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HybBv5Jm8z67nQM;
        Tue, 23 Nov 2021 02:19:19 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 19:20:17 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 18:20:16 +0000
Date:   Mon, 22 Nov 2021 18:20:15 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 14/23] cxl: Introduce topology host registration
Message-ID: <20211122182015.000045dc@Huawei.com>
In-Reply-To: <20211120000250.1663391-15-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-15-ben.widawsky@intel.com>
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

On Fri, 19 Nov 2021 16:02:41 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> The description of the CXL topology will be conveyed by a platform
> specific entity that is expected to be a singleton. For ACPI based
> systems, this is ACPI0017. When the topology host goes away, which as of
> now can only be triggered by module unload, it is desirable to have the
> entire topology cleaned up. Regular devm unwinding handles most
> situations already, but what's missing is the ability to teardown the
> root port. Since the root port is platform specific, the core needs a
> set of APIs to allow platform specific drivers to register their root
> ports. With that, all the automatic teardown can occur.
> 
> cxl_test makes for an interesting case. cxl_test creates an alternate
> universe where there are possibly two root topology hosts (a real
> ACPI0016, and a fake ACPI0016). For this to work in the future, cxl_acpi
> (or some future platform host driver) will need to be unloaded first.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
This is a little unusual looking but having followed through how it is used
it seems like a sensible approach to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
> The topology lock can be used for more things. I'd like to save that as
> an add-on patch since it's extra risk for no reward, at this point.
> ---
>  drivers/cxl/acpi.c     | 18 ++++++++++---
>  drivers/cxl/core/bus.c | 57 +++++++++++++++++++++++++++++++++++++++---
>  drivers/cxl/cxl.h      |  5 +++-
>  3 files changed, 73 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3415184a2e61..82cc42ab38c6 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -224,8 +224,7 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  		return 0;
>  	}
>  
> -	port = devm_cxl_add_port(host, match, dport->component_reg_phys,
> -				 root_port);
> +	port = devm_cxl_add_port(match, dport->component_reg_phys, root_port);
>  	if (IS_ERR(port))
>  		return PTR_ERR(port);
>  	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
> @@ -376,6 +375,11 @@ static int add_root_nvdimm_bridge(struct device *match, void *data)
>  	return 1;
>  }
>  
> +static void clear_topology_host(void *data)
> +{
> +	cxl_unregister_topology_host(data);
> +}
> +
>  static int cxl_acpi_probe(struct platform_device *pdev)
>  {
>  	int rc;
> @@ -384,7 +388,15 @@ static int cxl_acpi_probe(struct platform_device *pdev)
>  	struct acpi_device *adev = ACPI_COMPANION(host);
>  	struct cxl_cfmws_context ctx;
>  
> -	root_port = devm_cxl_add_port(host, host, CXL_RESOURCE_NONE, NULL);
> +	rc = cxl_register_topology_host(host);
> +	if (rc)
> +		return rc;
> +
> +	rc = devm_add_action_or_reset(host, clear_topology_host, host);
> +	if (rc)
> +		return rc;
> +
> +	root_port = devm_cxl_add_port(host, CXL_RESOURCE_NONE, root_port);
>  	if (IS_ERR(root_port))
>  		return PTR_ERR(root_port);
>  	dev_dbg(host, "add: %s\n", dev_name(&root_port->dev));
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index cd6fe7823c69..2ad38167796d 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -25,6 +25,53 @@
>   */
>  
>  static DEFINE_IDA(cxl_port_ida);
> +static DECLARE_RWSEM(topology_host_sem);
> +
> +static struct device *cxl_topology_host;
> +
> +int cxl_register_topology_host(struct device *host)
> +{
> +	down_write(&topology_host_sem);
> +	if (cxl_topology_host) {
> +		up_write(&topology_host_sem);
> +		pr_warn("%s host currently in use. Please try unloading %s",
> +			dev_name(cxl_topology_host), host->driver->name);
> +		return -EBUSY;
> +	}
> +
> +	cxl_topology_host = host;
> +	up_write(&topology_host_sem);
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_register_topology_host, CXL);
> +
> +void cxl_unregister_topology_host(struct device *host)
> +{
> +	down_write(&topology_host_sem);
> +	if (cxl_topology_host == host)
> +		cxl_topology_host = NULL;
> +	else
> +		pr_warn("topology host in use by %s\n",
> +			cxl_topology_host->driver->name);
> +	up_write(&topology_host_sem);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_unregister_topology_host, CXL);
> +
> +static struct device *get_cxl_topology_host(void)
> +{
> +	down_read(&topology_host_sem);
> +	if (cxl_topology_host)
> +		return cxl_topology_host;
> +	up_read(&topology_host_sem);
> +	return NULL;
> +}
> +
> +static void put_cxl_topology_host(struct device *dev)
> +{
> +	WARN_ON(dev != cxl_topology_host);
> +	up_read(&topology_host_sem);
> +}
>  
>  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
> @@ -362,17 +409,16 @@ static struct cxl_port *cxl_port_alloc(struct device *uport,
>  
>  /**
>   * devm_cxl_add_port - register a cxl_port in CXL memory decode hierarchy
> - * @host: host device for devm operations
>   * @uport: "physical" device implementing this upstream port
>   * @component_reg_phys: (optional) for configurable cxl_port instances
>   * @parent_port: next hop up in the CXL memory decode hierarchy
>   */
> -struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> +struct cxl_port *devm_cxl_add_port(struct device *uport,
>  				   resource_size_t component_reg_phys,
>  				   struct cxl_port *parent_port)
>  {
> +	struct device *dev, *host;
>  	struct cxl_port *port;
> -	struct device *dev;
>  	int rc;
>  
>  	port = cxl_port_alloc(uport, component_reg_phys, parent_port);
> @@ -391,7 +437,12 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  	if (rc)
>  		goto err;
>  
> +	host = get_cxl_topology_host();
> +	if (!host)
> +		return ERR_PTR(-ENODEV);
> +
>  	rc = devm_add_action_or_reset(host, unregister_port, port);
> +	put_cxl_topology_host(host);
>  	if (rc)
>  		return ERR_PTR(rc);
>  
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 2c5627fa8a34..6fac4826d22b 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -152,6 +152,9 @@ int cxl_find_regblock(struct pci_dev *pdev, enum cxl_regloc_type type,
>  #define CXL_RESOURCE_NONE ((resource_size_t) -1)
>  #define CXL_TARGET_STRLEN 20
>  
> +int cxl_register_topology_host(struct device *host);
> +void cxl_unregister_topology_host(struct device *host);
> +
>  /*
>   * cxl_decoder flags that define the type of memory / devices this
>   * decoder supports as well as configuration lock status See "CXL 2.0
> @@ -279,7 +282,7 @@ struct cxl_dport {
>  };
>  
>  struct cxl_port *to_cxl_port(struct device *dev);
> -struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
> +struct cxl_port *devm_cxl_add_port(struct device *uport,
>  				   resource_size_t component_reg_phys,
>  				   struct cxl_port *parent_port);
>  

