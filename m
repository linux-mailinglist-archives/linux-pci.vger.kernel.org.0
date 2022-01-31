Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C89C34A4B3C
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 17:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244953AbiAaQFW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 11:05:22 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4571 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380049AbiAaQFA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 11:05:00 -0500
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnXtz5shjz67jfG;
        Tue,  1 Feb 2022 00:04:27 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 17:04:58 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 16:04:57 +0000
Date:   Mon, 31 Jan 2022 16:04:52 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 17/40] cxl/port: Introduce cxl_port_to_pci_bus()
Message-ID: <20220131160452.00007f45@Huawei.com>
In-Reply-To: <164298420951.3018233.1498794101372312682.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298420951.3018233.1498794101372312682.stgit@dwillia2-desk3.amr.corp.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.29; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.73.212]
X-ClientProxiedBy: lhreml704-chm.china.huawei.com (10.201.108.53) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sun, 23 Jan 2022 16:30:09 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> Add a helper for converting a PCI enumerated cxl_port into the pci_bus
> that hosts its dports. For switch ports this is trivial, but for root
> ports there is no generic way to go from a platform defined host bridge
> device, like ACPI0016 to its corresponding pci_bus. Rather than spill
> ACPI goop outside of the cxl_acpi driver, just arrange for it to
> register an xarray translation from the uport device to the
> corresponding pci_bus.
> 
> This is in preparation for centralizing dport enumeration in the core.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Trivial comment inline. Otherwise LGTM

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/cxl/acpi.c      |   14 +++++++++-----
>  drivers/cxl/core/port.c |   37 +++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h       |    3 +++
>  3 files changed, 49 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 93d1dc56892a..ab2b76532272 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -225,17 +225,21 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  		return 0;
>  	}
>  
> +	/*
> +	 * Note that this lookup already succeeded in
> +	 * to_cxl_host_bridge(), so no need to check for failure here
> +	 */
> +	pci_root = acpi_pci_find_root(bridge->handle);
> +	rc = devm_cxl_register_pci_bus(host, match, pci_root->bus);
> +	if (rc)
> +		return rc;
> +
>  	port = devm_cxl_add_port(host, match, dport->component_reg_phys,
>  				 root_port);
>  	if (IS_ERR(port))
>  		return PTR_ERR(port);
>  	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
>  
> -	/*
> -	 * Note that this lookup already succeeded in
> -	 * to_cxl_host_bridge(), so no need to check for failure here
> -	 */
> -	pci_root = acpi_pci_find_root(bridge->handle);
>  	ctx = (struct cxl_walk_context){
>  		.dev = host,
>  		.root = pci_root->bus,
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 58089ea09aa3..e1372fe13a11 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -25,6 +25,7 @@
>   */
>  
>  static DEFINE_IDA(cxl_port_ida);
> +static DEFINE_XARRAY(cxl_root_buses);
>  
>  static ssize_t devtype_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
> @@ -420,6 +421,42 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_add_port, CXL);
>  
> +struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port)
> +{
> +	/* There is no pci_bus associated with a CXL platform-root port */
> +	if (is_cxl_root(port))
> +		return NULL;
> +
> +	if (dev_is_pci(port->uport)) {
> +		struct pci_dev *pdev = to_pci_dev(port->uport);
> +
> +		return pdev->subordinate;
> +	}
> +
> +	return xa_load(&cxl_root_buses, (unsigned long)port->uport);
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_port_to_pci_bus, CXL);
> +
> +static void unregister_pci_bus(void *uport)
> +{
> +	xa_erase(&cxl_root_buses, (unsigned long) uport);

Trivial: Inconsistent spacing before uport.

> +}
> +
> +int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
> +			      struct pci_bus *bus)
> +{
> +	int rc;
> +
> +	if (dev_is_pci(uport))
> +		return -EINVAL;
> +
> +	rc = xa_insert(&cxl_root_buses, (unsigned long)uport, bus, GFP_KERNEL);
> +	if (rc)
> +		return rc;
> +	return devm_add_action_or_reset(host, unregister_pci_bus, uport);
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_register_pci_bus, CXL);
> +
>  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  {
>  	struct cxl_dport *dport;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 47c256ad105f..4e8d504546c5 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -289,6 +289,9 @@ static inline bool is_cxl_root(struct cxl_port *port)
>  
>  bool is_cxl_port(struct device *dev);
>  struct cxl_port *to_cxl_port(struct device *dev);
> +int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
> +			      struct pci_bus *bus);
> +struct pci_bus *cxl_port_to_pci_bus(struct cxl_port *port);
>  struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  				   resource_size_t component_reg_phys,
>  				   struct cxl_port *parent_port);
> 

