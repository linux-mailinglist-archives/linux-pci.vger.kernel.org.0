Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBF854A4CB3
	for <lists+linux-pci@lfdr.de>; Mon, 31 Jan 2022 18:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380245AbiAaRDE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 31 Jan 2022 12:03:04 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:4575 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380698AbiAaRCf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 31 Jan 2022 12:02:35 -0500
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4JnZ4j2RZkz685Pf;
        Tue,  1 Feb 2022 00:57:57 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Mon, 31 Jan 2022 18:02:32 +0100
Received: from localhost (10.47.73.212) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2308.21; Mon, 31 Jan
 2022 17:02:31 +0000
Date:   Mon, 31 Jan 2022 17:02:26 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
Subject: Re: [PATCH v3 21/40] cxl/core: Generalize dport enumeration in the
 core
Message-ID: <20220131170226.00003bac@Huawei.com>
In-Reply-To: <164298423047.3018233.6769866347542494809.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
        <164298423047.3018233.6769866347542494809.stgit@dwillia2-desk3.amr.corp.intel.com>
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

On Sun, 23 Jan 2022 16:30:30 -0800
Dan Williams <dan.j.williams@intel.com> wrote:

> The core houses infrastructure for decoder resources. A CXL port's
> dports are more closely related to decoder infrastructure than topology
> enumeration. Implement generic PCI based dport enumeration in the core,
> i.e. arrange for existing root port enumeration from cxl_acpi to share
> code with switch port enumeration which is just amounts to a small

which just amounts 

> difference in a pci_walk_bus() invocation once the appropriate 'struct
> pci_bus' has been retrieved.
> 
> This also simplifies assumptions about the state of a cxl_port relative
> to when its dports are populated. Previously threads racing enumeration
> and port lookup could find the port in partially initialized state with
> respect to its dports. Now it can assume that the arrival of decoder
> objects indicates the dport description is stable.

Possibly worth clarifying if that race caused any known bugs, or
if you just mean it's removal leads to simplifications

A few additional comment inline.

Jonathan

> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  drivers/cxl/acpi.c            |   71 ++++------------------------
>  drivers/cxl/core/Makefile     |    1 
>  drivers/cxl/core/pci.c        |  104 +++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/core/port.c       |   91 +++++++++++++++++++++---------------
>  drivers/cxl/cxl.h             |   16 ++----
>  drivers/cxl/cxlpci.h          |    1 
>  tools/testing/cxl/Kbuild      |    3 +
>  tools/testing/cxl/mock_acpi.c |   78 -------------------------------
>  tools/testing/cxl/test/cxl.c  |   67 ++++++++++++++++++--------
>  tools/testing/cxl/test/mock.c |   45 +++++++-----------
>  tools/testing/cxl/test/mock.h |    6 ++
>  11 files changed, 243 insertions(+), 240 deletions(-)
>  create mode 100644 drivers/cxl/core/pci.c
> 
> diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
> index 3485ae9d3baf..259441245687 100644
> --- a/drivers/cxl/acpi.c
> +++ b/drivers/cxl/acpi.c
> @@ -130,48 +130,6 @@ static int cxl_parse_cfmws(union acpi_subtable_headers *header, void *arg,
>  	return 0;
>  }
>  
> -__mock int match_add_root_ports(struct pci_dev *pdev, void *data)
> -{
> -	resource_size_t creg = CXL_RESOURCE_NONE;
> -	struct cxl_walk_context *ctx = data;
> -	struct pci_bus *root_bus = ctx->root;
> -	struct cxl_port *port = ctx->port;
> -	int type = pci_pcie_type(pdev);
> -	struct device *dev = ctx->dev;
> -	struct cxl_register_map map;
> -	u32 lnkcap, port_num;
> -	int rc;
> -
> -	if (pdev->bus != root_bus)
> -		return 0;
> -	if (!pci_is_pcie(pdev))
> -		return 0;
> -	if (type != PCI_EXP_TYPE_ROOT_PORT)
> -		return 0;
> -	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> -				  &lnkcap) != PCIBIOS_SUCCESSFUL)
> -		return 0;
> -
> -	/* The driver doesn't rely on component registers for Root Ports yet. */
> -	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> -	if (!rc)
> -		dev_info(&pdev->dev, "No component register block found\n");
> -
> -	creg = cxl_regmap_to_base(pdev, &map);
> -
> -	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> -	rc = cxl_add_dport(port, &pdev->dev, port_num, creg);
> -	if (rc) {
> -		ctx->error = rc;
> -		return rc;
> -	}
> -	ctx->count++;
> -
> -	dev_dbg(dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
> -
> -	return 0;
> -}
> -
>  static struct cxl_dport *find_dport_by_dev(struct cxl_port *port, struct device *dev)
>  {
>  	struct cxl_dport *dport;
> @@ -210,7 +168,6 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  	struct device *host = root_port->dev.parent;
>  	struct acpi_device *bridge = to_cxl_host_bridge(host, match);
>  	struct acpi_pci_root *pci_root;
> -	struct cxl_walk_context ctx;
>  	int single_port_map[1], rc;
>  	struct cxl_decoder *cxld;
>  	struct cxl_dport *dport;
> @@ -240,18 +197,10 @@ static int add_host_bridge_uport(struct device *match, void *arg)
>  		return PTR_ERR(port);
>  	dev_dbg(host, "%s: add: %s\n", dev_name(match), dev_name(&port->dev));
>  
> -	ctx = (struct cxl_walk_context){
> -		.dev = host,
> -		.root = pci_root->bus,
> -		.port = port,
> -	};
> -	pci_walk_bus(pci_root->bus, match_add_root_ports, &ctx);
> -
> -	if (ctx.count == 0)
> -		return -ENODEV;
> -	if (ctx.error)
> -		return ctx.error;
> -	if (ctx.count > 1)
> +	rc = devm_cxl_port_enumerate_dports(host, port);
> +	if (rc < 0)
> +		return rc;
> +	if (rc > 1)
>  		return 0;
>  
>  	/* TODO: Scan CHBCR for HDM Decoder resources */
> @@ -311,9 +260,9 @@ static int cxl_get_chbcr(union acpi_subtable_headers *header, void *arg,
>  
>  static int add_host_bridge_dport(struct device *match, void *arg)
>  {
> -	int rc;
>  	acpi_status status;
>  	unsigned long long uid;
> +	struct cxl_dport *dport;
>  	struct cxl_chbs_context ctx;
>  	struct cxl_port *root_port = arg;
>  	struct device *host = root_port->dev.parent;
> @@ -342,13 +291,13 @@ static int add_host_bridge_dport(struct device *match, void *arg)
>  		return 0;
>  	}
>  
> -	device_lock(&root_port->dev);
> -	rc = cxl_add_dport(root_port, match, uid, ctx.chbcr);
> -	device_unlock(&root_port->dev);
> -	if (rc) {
> +	cxl_device_lock(&root_port->dev);

Ah.  This is putting back the cxl_device_lock dropped in previous patch I think...

> +	dport = devm_cxl_add_dport(host, root_port, match, uid, ctx.chbcr);
> +	cxl_device_unlock(&root_port->dev);
> +	if (IS_ERR(dport)) {
>  		dev_err(host, "failed to add downstream port: %s\n",
>  			dev_name(match));
> -		return rc;
> +		return PTR_ERR(dport);
>  	}
>  	dev_dbg(host, "add dport%llu: %s\n", uid, dev_name(match));
>  	return 0;
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index a90202ac88d2..91057f0ec763 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -7,3 +7,4 @@ cxl_core-y += pmem.o
>  cxl_core-y += regs.o
>  cxl_core-y += memdev.o
>  cxl_core-y += mbox.o
> +cxl_core-y += pci.o
> diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> new file mode 100644
> index 000000000000..48c9a004ae8e
> --- /dev/null
> +++ b/drivers/cxl/core/pci.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2021 Intel Corporation. All rights reserved. */
> +#include <linux/device.h>
> +#include <linux/pci.h>
> +#include <cxlpci.h>
> +#include <cxl.h>
> +#include "core.h"
> +
> +/**
> + * DOC: cxl core pci
> + *
> + * Compute Express Link protocols are layered on top of PCIe. CXL core provides
> + * a set of helpers for CXL interactions which occur via PCIe.
> + */
> +
> +struct cxl_walk_context {
> +	struct pci_bus *bus;
> +	struct device *host;
> +	struct cxl_port *port;
> +	int type;
> +	int error;
> +	int count;
> +};
> +
> +static int match_add_dports(struct pci_dev *pdev, void *data)
> +{
> +	struct cxl_walk_context *ctx = data;
> +	struct cxl_port *port = ctx->port;
> +	struct device *host = ctx->host;
> +	struct pci_bus *bus = ctx->bus;
> +	int type = pci_pcie_type(pdev);
> +	struct cxl_register_map map;
> +	int match_type = ctx->type;
> +	struct cxl_dport *dport;
> +	u32 lnkcap, port_num;
> +	int rc;
> +
> +	if (pdev->bus != bus)
if (pdev->bus != ctx->bus) seems just as clear to me and the local
variable bus isn't used elsewhere.

> +		return 0;
> +	if (!pci_is_pcie(pdev))
> +		return 0;
> +	if (type != match_type)

	if (pci_pcie_type(pdev) != ctx->type) 

is probably easier to follow than with the local variables.
(note I've not read the rest of the series yet so this might make
sense if there are additional changes in here)

> +		return 0;
> +	if (pci_read_config_dword(pdev, pci_pcie_cap(pdev) + PCI_EXP_LNKCAP,
> +				  &lnkcap) != PCIBIOS_SUCCESSFUL)

We could take this opportunity to just compare with 0 as we do in lots
of other places.

> +		return 0;
> +
> +	rc = cxl_find_regblock(pdev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		dev_dbg(&port->dev, "failed to find component registers\n");
> +
> +	port_num = FIELD_GET(PCI_EXP_LNKCAP_PN, lnkcap);
> +	cxl_device_lock(&port->dev);
> +	dport = devm_cxl_add_dport(host, port, &pdev->dev, port_num,
> +				   cxl_regmap_to_base(pdev, &map));
> +	cxl_device_unlock(&port->dev);
> +	if (IS_ERR(dport)) {
> +		ctx->error = PTR_ERR(dport);
> +		return PTR_ERR(dport);
> +	}
> +	ctx->count++;
> +
> +	dev_dbg(&port->dev, "add dport%d: %s\n", port_num, dev_name(&pdev->dev));
> +
> +	return 0;
> +}
> +
> +/**
> + * devm_cxl_port_enumerate_dports - enumerate downstream ports of the upstream port
> + * @host: devm context
> + * @port: cxl_port whose ->uport is the upstream of dports to be enumerated
> + *
> + * Returns a positive number of dports enumerated or a negative error
> + * code.
> + */
> +int devm_cxl_port_enumerate_dports(struct device *host, struct cxl_port *port)
> +{
> +	struct pci_bus *bus = cxl_port_to_pci_bus(port);
> +	struct cxl_walk_context ctx;
> +	int type;
> +
> +	if (!bus)
> +		return -ENXIO;
> +
> +	if (pci_is_root_bus(bus))
> +		type = PCI_EXP_TYPE_ROOT_PORT;
> +	else
> +		type = PCI_EXP_TYPE_DOWNSTREAM;
> +
> +	ctx = (struct cxl_walk_context) {
> +		.host = host,
> +		.port = port,
> +		.bus = bus,
> +		.type = type,
> +	};
> +	pci_walk_bus(bus, match_add_dports, &ctx);
> +
> +	if (ctx.count == 0)
> +		return -ENODEV;
> +	if (ctx.error)
> +		return ctx.error;
> +	return ctx.count;
> +}
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_port_enumerate_dports, CXL);
> diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
> index c51a10154e29..777de6d91dde 100644
> --- a/drivers/cxl/core/port.c
> +++ b/drivers/cxl/core/port.c

...

>  
> @@ -529,51 +506,87 @@ static int add_dport(struct cxl_port *port, struct cxl_dport *new)
>  	return dup ? -EEXIST : 0;
>  }
>  
> +static void cxl_dport_remove(void *data)
> +{
> +	struct cxl_dport *dport = data;
> +	struct cxl_port *port = dport->port;
> +
> +	cxl_device_lock(&port->dev);
> +	list_del_init(&dport->list);

Why _init? 

> +	cxl_device_unlock(&port->dev);
> +	put_device(dport->dport);

For this unwinding, could we do the put_device(dport->dport)
before the rest.  I don't think we need to hold the reference
whilst doing the rest of this unwinding and it would more closely
'reverse' the setup order below.

> +}
> +
> +static void cxl_dport_unlink(void *data)
> +{
> +	struct cxl_dport *dport = data;
> +	struct cxl_port *port = dport->port;
> +	char link_name[CXL_TARGET_STRLEN];
> +
> +	sprintf(link_name, "dport%d", dport->port_id);
> +	sysfs_remove_link(&port->dev.kobj, link_name);
> +}
> +
>  /**
> - * cxl_add_dport - append downstream port data to a cxl_port
> + * devm_cxl_add_dport - append downstream port data to a cxl_port
> + * @host: devm context for allocations
>   * @port: the cxl_port that references this dport
>   * @dport_dev: firmware or PCI device representing the dport
>   * @port_id: identifier for this dport in a decoder's target list
>   * @component_reg_phys: optional location of CXL component registers
>   *
> - * Note that all allocations and links are undone by cxl_port deletion
> - * and release.
> + * Note that dports are appended to the devm release action's of the
> + * either the port's host (for root ports), or the port itself (for
> + * switch ports)
>   */
> -int cxl_add_dport(struct cxl_port *port, struct device *dport_dev, int port_id,
> -		  resource_size_t component_reg_phys)
> +struct cxl_dport *devm_cxl_add_dport(struct device *host, struct cxl_port *port,
> +				     struct device *dport_dev, int port_id,
> +				     resource_size_t component_reg_phys)
>  {
>  	char link_name[CXL_TARGET_STRLEN];
>  	struct cxl_dport *dport;
>  	int rc;
>  
> +	if (!host->driver) {
> +		dev_WARN_ONCE(&port->dev, 1, "dport:%s bad devm context\n",
> +			      dev_name(dport_dev));
> +		return ERR_PTR(-ENXIO);
> +	}
> +
>  	if (snprintf(link_name, CXL_TARGET_STRLEN, "dport%d", port_id) >=
>  	    CXL_TARGET_STRLEN)
> -		return -EINVAL;
> +		return ERR_PTR(-EINVAL);
>  
> -	dport = kzalloc(sizeof(*dport), GFP_KERNEL);
> +	dport = devm_kzalloc(host, sizeof(*dport), GFP_KERNEL);
>  	if (!dport)
> -		return -ENOMEM;
> +		return ERR_PTR(-ENOMEM);
>  
>  	INIT_LIST_HEAD(&dport->list);
> -	dport->dport = get_device(dport_dev);
> +	dport->dport = dport_dev;
>  	dport->port_id = port_id;
>  	dport->component_reg_phys = component_reg_phys;
>  	dport->port = port;
>  
>  	rc = add_dport(port, dport);
>  	if (rc)
> -		goto err;
> +		return ERR_PTR(rc);
> +
> +	get_device(dport_dev);
> +	rc = devm_add_action_or_reset(host, cxl_dport_remove, dport);
> +	if (rc)
> +		return ERR_PTR(rc);
>  
>  	rc = sysfs_create_link(&port->dev.kobj, &dport_dev->kobj, link_name);
>  	if (rc)
> -		goto err;
> +		return ERR_PTR(rc);
>  
> -	return 0;
> -err:
> -	cxl_dport_release(dport);
> -	return rc;
> +	rc = devm_add_action_or_reset(host, cxl_dport_unlink, dport);
> +	if (rc)
> +		return ERR_PTR(rc);
> +
> +	return dport;
>  }
> -EXPORT_SYMBOL_NS_GPL(cxl_add_dport, CXL);
> +EXPORT_SYMBOL_NS_GPL(devm_cxl_add_dport, CXL);
>  
>  static int decoder_populate_targets(struct cxl_decoder *cxld,
>  				    struct cxl_port *port, int *target_map)

