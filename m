Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77B374A4BAD
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 17:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380213AbiAaQTH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 11:19:07 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4572 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380232AbiAaQTF (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 11:19:05 -0500
Received: from fraeml714-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnY7X3gmmz67mMG;
        Tue,  1 Feb 2022 00:15:20 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml714-chm.china.huawei.com (10.206.15.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 17:19:03 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 16:19:02 +0000
Date:   Mon, 31 Jan 2022 16:18:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, Ben Widawsky <ben.widawsky@intel.com>,
        <linux-pci@vger.kernel.org>, <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v5 18/40] cxl/pmem: Introduce a find_cxl_root() helper
Message-ID: <20220131161856.00005cd0@Huawei.com>
In-Reply-To: <164324151672.3935633.11277011056733051668.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164322333437.3694981.17087130505938650994.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164324151672.3935633.11277011056733051668.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Wed, 26 Jan 2022 15:59:07 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> In preparation for switch port enumeration while also preserving the
> potential for multi-domain / multi-root CXL topologies. Introduce a
> 'struct device' generic mechanism for retrieving a root CXL port, if one
> is registered. Note that the only know multi-domain CXL configurations
> are running the cxl_test unit test on a system that also publishes an
> ACPI0017 device.
> 
> With this in hand the nvdimm-bridge lookup can be with
> device_find_child() instead of bus_find_device() + custom mocked lookup
> infrastructure in cxl_test.
> 
> The mechanism looks for a 2nd level port since the root level topology
> is platform-firmware specific and the 2nd level down follows standard
> PCIe topology expectations. The cxl_acpi 2nd level is associated with a
> PCIe Root Port.
> 
> Reported-by: Ben Widawsky <ben.widawsky@intel.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
A question inline.

Thanks,

Jonathan

> ---
> Changes since v4:
> - reset @iter each loop otherwise only the first dport can be scanned.
> 
>  drivers/cxl/core/pmem.c       |   14 ++++++++---
>  drivers/cxl/core/port.c       |   50 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxl.h             |    1 +
>  tools/testing/cxl/Kbuild      |    2 --
>  tools/testing/cxl/mock_pmem.c |   24 --------------------
>  5 files changed, 61 insertions(+), 30 deletions(-)
>  delete mode 100644 tools/testing/cxl/mock_pmem.c
> 
> diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
> index 40b3f5030496..8de240c4d96b 100644
> --- a/drivers/cxl/core/pmem.c
> +++ b/drivers/cxl/core/pmem.c
> @@ -57,24 +57,30 @@ bool is_cxl_nvdimm_bridge(struct device *dev)
>  }
>  EXPORT_SYMBOL_NS_GPL(is_cxl_nvdimm_bridge, CXL);
>  
> -__mock int match_nvdimm_bridge(struct device *dev, const void *data)
> +static int match_nvdimm_bridge(struct device *dev, void *data)
>  {
>  	return is_cxl_nvdimm_bridge(dev);
>  }
>  
>  struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd)
>  {
> +	struct cxl_port *port = find_cxl_root(&cxl_nvd->dev);
>  	struct device *dev;
>  
> -	dev = bus_find_device(&cxl_bus_type, NULL, cxl_nvd, match_nvdimm_bridge);
> +	if (!port)
> +		return NULL;
> +
> +	dev = device_find_child(&port->dev, NULL, match_nvdimm_bridge);
> +	put_device(&port->dev);
> +
>  	if (!dev)
>  		return NULL;
> +
>  	return to_cxl_nvdimm_bridge(dev);
>  }
>  EXPORT_SYMBOL_NS_GPL(cxl_find_nvdimm_bridge, CXL);
>  
> -static struct cxl_nvdimm_bridge *
> -cxl_nvdimm_bridge_alloc(struct cxl_port *port)
> +static struct cxl_nvdimm_bridge *cxl_nvdimm_bridge_alloc(struct cxl_port *port)
>  {
>  	struct cxl_nvdimm_bridge *cxl_nvb;
>  	struct device *dev;
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index 4c921c49f967..6447f12ef71d 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c
> @@ -457,6 +457,56 @@ int devm_cxl_register_pci_bus(struct device *host, struct device *uport,
>  }
>  EXPORT_SYMBOL_NS_GPL(devm_cxl_register_pci_bus, CXL);
>  
> +/* Find a 2nd level CXL port that has a dport that is an ancestor of @match */
> +static int match_cxl_root_child(struct device *dev, const void *match)
> +{
> +	const struct device *iter = NULL;
> +	struct cxl_port *port, *parent;
> +	struct cxl_dport *dport;
> +
> +	if (!is_cxl_port(dev))
> +		return 0;
> +
> +	port = to_cxl_port(dev);
> +	if (is_cxl_root(port))
> +		return 0;
> +
> +	parent = to_cxl_port(port->dev.parent);
> +	if (!is_cxl_root(parent))
> +		return 0;
> +
> +	cxl_device_lock(&port->dev);
> +	list_for_each_entry(dport, &port->dports, list) {
> +		iter = match;

This confuses me.  In the call below to bus_find_device()
data == NULL, which ends up as match here.

So how does that ever find a match?

> +		while (iter) {
> +			if (iter == dport->dport)
> +				goto out;
> +			iter = iter->parent;
> +		}
> +	}
> +out:
> +	cxl_device_unlock(&port->dev);
> +
> +	return !!iter;

return iter; should be sufficient as docs just say non zero for a match
in bus_find_device() match functions.

> +}
> +
> +struct cxl_port *find_cxl_root(struct device *dev)
> +{
> +	struct device *port_dev;
> +	struct cxl_port *root;
> +
> +	port_dev =
> +		bus_find_device(&cxl_bus_type, NULL, dev, match_cxl_root_child);

Line breaking is rather ugly to my eye.  Perhaps break
parameter list up instead?

> +	if (!port_dev)
> +		return NULL;
> +
> +	root = to_cxl_port(port_dev->parent);
> +	get_device(&root->dev);
> +	put_device(port_dev);
> +	return root;
> +}
> +EXPORT_SYMBOL_NS_GPL(find_cxl_root, CXL);
> +
>  static struct cxl_dport *find_dport(struct cxl_port *port, int id)
>  {
>  	struct cxl_dport *dport;
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> index 4e8d504546c5..7523e4d60953 100644
> --- a/drivers/cxl/cxl.h
> +++ b/drivers/cxl/cxl.h
> @@ -298,6 +298,7 @@ struct cxl_port *devm_cxl_add_port(struct device *host, struct device *uport,
>  
>  int cxl_add_dport(struct cxl_port *port, struct device *dport, int port_id,
>  		  resource_size_t component_reg_phys);
> +struct cxl_port *find_cxl_root(struct device *dev);
>  
>  struct cxl_decoder *to_cxl_decoder(struct device *dev);
>  bool is_root_decoder(struct device *dev);

