Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 447F84594A9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Nov 2021 19:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhKVSZn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Nov 2021 13:25:43 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4152 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236375AbhKVSZn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Nov 2021 13:25:43 -0500
Received: from fraeml739-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4HybB95VN8z6H8XV;
        Tue, 23 Nov 2021 02:18:41 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml739-chm.china.huawei.com (10.206.15.220) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 22 Nov 2021 19:22:33 +0100
Received: from localhost (10.202.226.41) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 22 Nov
 2021 18:22:32 +0000
Date:   Mon, 22 Nov 2021 18:22:31 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "Alison Schofield" <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: Re: [PATCH 15/23] cxl/core: Store global list of root ports
Message-ID: <20211122182231.000037d1@Huawei.com>
In-Reply-To: <20211120000250.1663391-16-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
        <20211120000250.1663391-16-ben.widawsky@intel.com>
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

On Fri, 19 Nov 2021 16:02:42 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> CXL root ports (the downstream port to a host bridge) are to be
> enumerated by a platform specific driver. In the case of ACPI compliant
> systems, this is like the cxl_acpi driver. Root ports are the first
> CXL spec defined component that can be "found" by that platform specific
> driver.
> 
> By storing a list of these root ports components in lower levels of the
> topology (switches and endpoints), have a mechanism to walk up their
> device hierarchy to find an enumerated root port. This will be necessary
> for region programming.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
> 
> ---
> Dan points out in review this is possible to do without a new global
> list. While I agree, I was unable to get it working in a reasonable
> mount of time. Will punt on that for now.

This has made me curious.  Is this a punt it for v1, or a punt it for longer
term and maybe revisit later?

What you have looks like it should work fine to me.


> ---
>  drivers/cxl/acpi.c            |  4 ++--
>  drivers/cxl/core/bus.c        | 34 +++++++++++++++++++++++++++++++++-
>  drivers/cxl/cxl.h             |  5 ++++-
>  tools/testing/cxl/mock_acpi.c |  4 ++--
>  4 files changed, 41 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 82cc42ab38c6..c12e4fed7941 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -159,7 +159,7 @@ __mock int match_add_root_ports(struct pci_dev *pdev, void *data)
>  		creg = cxl_reg_block(pdev, &map);
>  
>  	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> -	rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
> +	rc = cxl_add_dport(port, &pdev->dev, port_num, creg, true);
>  	if (rc) {
>  		ctx->error = rc;
>  		return rc;
> @@ -341,7 +341,7 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  		return 0;
>  	}
>  
> -	rc = cxl_add_dport(root_port, match, uid, ctx.chbcr);
> +	rc = cxl_add_dport(root_port, match, uid, ctx.chbcr, false);
>  	if (rc) {
>  		dev_err(host, "failed to add downstream port: %s\n",
>  			dev_name(match));
> diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/bus.c
> index 2ad38167796d..9e0d7d5d9298 100644
> --- a/drivers/cxl/core/bus.c
> +++ b/drivers/cxl/core/bus.c
> @@ -26,6 +26,8 @@
>  
>  static DEFINE_IDA(cxl_port_ida);
>  static DECLARE_RWSEM(topology_host_sem);
> +static LIST_HEAD(cxl_root_ports);
> +static DECLARE_RWSEM(root_port_sem);
>  
>  static struct device *cxl_topology_host;
>  
> @@ -326,12 +328,31 @@ struct cxl_port *to_cxl_port(struct device *dev)
>  	return container_of(dev, struct cxl_port, dev);
>  }
>  
> +struct cxl_dport *cxl_get_root_dport(struct device *dev)
> +{
> +	struct cxl_dport *ret = NULL;
> +	struct cxl_dport *dport;
> +
> +	down_read(&root_port_sem);
> +	list_for_each_entry(dport, &cxl_root_ports, root_port_link) {
> +		if (dport->dport == dev) {
> +			ret = dport;
> +			break;
> +		}
> +	}
> +
> +	up_read(&root_port_sem);
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_get_root_dport, CXL);
> +
>  static void unregister_port(void *_port)
>  {
>  	struct cxl_port *port = _port;
>  	struct cxl_dport *dport;
>  
>  	device_lock(&port->dev);
> +	down_read(&root_port_sem);
>  	list_for_each_entry(dport, &port->dports, list) {
>  		char link_name[CXL_TARGET_STRLEN];
>  
> @@ -339,7 +360,10 @@ static void unregister_port(void *_port)
>  			     dport->port_id) >= CXL_TARGET_STRLEN)
>  			continue;
>  		sysfs_remove_link(&port->dev.kobj, link_name);
> +
> +		list_del_init(&dport->root_port_link);
>  	}
> +	up_read(&root_port_sem);
>  	device_unlock(&port->dev);
>  	device_unregister(&port->dev);
>  }
> @@ -493,12 +517,13 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
>   * @dport_dev: firmware or PCI device representing the dport
>   * @port_id: identifier for this dport in a decoder's target list
>   * @component_reg_phys: optional location of CXL component registers
> + * @root_port: is this a root port (hostbridge downstream)
>   *
>   * Note that all allocations and links are undone by cxl_port deletion
>   * and release.
>   */
>  int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
> -		  resource_size_t component_reg_phys)
> +		  resource_size_t component_reg_phys, bool root_port)
>  {
>  	char link_name[CXL_TARGET_STRLEN];
>  	struct cxl_dport *dport;
> @@ -513,6 +538,7 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
>  		return -ENOMEM;
>  
>  	INIT_LIST_HEAD(&dport->list);
> +	INIT_LIST_HEAD(&dport->root_port_link);
>  	dport->dport = get_device(dport_dev);
>  	dport->port_id = port_id;
>  	dport->component_reg_phys = component_reg_phys;
> @@ -526,6 +552,12 @@ int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
>  	if (rc)
>  		goto err;
>  
> +	if (root_port) {
> +		down_write(&root_port_sem);
> +		list_add_tail(&dport->root_port_link, &cxl_root_ports);
> +		up_write(&root_port_sem);
> +	}
> +
>  	return 0;
>  err:
>  	cxl_dport_release(dport);
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 6fac4826d22b..3962a5e6a950 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -272,6 +272,7 @@ struct cxl_port {
>   * @component_reg_phys: downstream port component registers
>   * @port: reference to cxl_port that contains this downstream port
>   * @list: node for a cxl_port's list of cxl_dport instances
> + * @root_port_link: node for global list of root ports
>   */
>  struct cxl_dport {
>  	struct device *dport;
> @@ -279,6 +280,7 @@ struct cxl_dport {
>  	resource_size_t component_reg_phys;
>  	struct cxl_port *port;
>  	struct list_head list;
> +	struct list_head root_port_link;
>  };
>  
>  struct cxl_port *to_cxl_port(struct device *dev);
> @@ -287,7 +289,8 @@ struct cxl_port *devm_cxl_add_port(struct device *uport,
>  				   struct cxl_port *parent_port);
>  
>  int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
> -		  resource_size_t component_reg_phys);
> +		  resource_size_t component_reg_phys, bool root_port);
> +struct cxl_dport *cxl_get_root_dport(struct device *dev);
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);
> diff --git a/tools/testing/cxl/mock_acpi.c b/tools/testing/cxl/mock_acpi.c
> index 4c8a493ace56..ddefc4345f36 100644
> --- a/tools/testing/cxl/mock_acpi.c
> +++ b/tools/testing/cxl/mock_acpi.c
> @@ -57,7 +57,7 @@ static int match_add_root_port(struct pci_dev *pdev, void *data)
>  
>  	/* TODO walk DVSEC to find component register base */
>  	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> -	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE);
> +	rc = cxl_add_dport(port, &pdev->dev, port_num, CXL_RESOURCE_NONE, true);
>  	if (rc) {
>  		dev_err(dev, "failed to add dport: %s (%d)\n",
>  			dev_name(&pdev->dev), rc);
> @@ -78,7 +78,7 @@ static int mock_add_root_port(struct platform_device *pdev, void *data)
>  	struct device *dev = ctx->dev;
>  	int rc;
>  
> -	rc = cxl_add_dport(port, &pdev->dev, pdev->id, CXL_RESOURCE_NONE);
> +	rc = cxl_add_dport(port, &pdev->dev, pdev->id, CXL_RESOURCE_NONE, true);
>  	if (rc) {
>  		dev_err(dev, "failed to add dport: %s (%d)\n",
>  			dev_name(&pdev->dev), rc);

