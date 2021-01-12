Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 168812F395C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 20:02:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392213AbhALTC1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 14:02:27 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2325 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391614AbhALTC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 14:02:27 -0500
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DFfxK4h7Hz67Zjg;
        Wed, 13 Jan 2021 02:58:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2106.2; Tue, 12 Jan 2021 20:01:42 +0100
Received: from localhost (10.47.65.219) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 12 Jan
 2021 19:01:41 +0000
Date:   Tue, 12 Jan 2021 19:01:03 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "Christoph Hellwig" <hch@infradead.org>,
        <daniel.lll@alibaba-inc.com>
Subject: Re: [RFC PATCH v3 04/16] cxl/mem: Introduce a driver for
 CXL-2.0-Type-3 endpoints
Message-ID: <20210112190103.00004644@Huawei.com>
In-Reply-To: <20210111225121.820014-5-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
        <20210111225121.820014-5-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.65.219]
X-ClientProxiedBy: lhreml752-chm.china.huawei.com (10.201.108.202) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 11 Jan 2021 14:51:08 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> From: Dan Williams <dan.j.williams@intel.com>
> 
> The CXL.mem protocol allows a device to act as a provider of "System
> RAM" and/or "Persistent Memory" that is fully coherent as if the memory
> was attached to the typical CPU memory controller.
> 
> With the CXL-2.0 specification a PCI endpoint can implement a "Type-3"
> device interface and give the operating system control over "Host
> Managed Device Memory". See section 2.3 Type 3 CXL Device.
> 
> The memory range exported by the device may optionally be described by
> the platform firmware memory map, or by infrastructure like LIBNVDIMM to
> provision persistent memory capacity from one, or more, CXL.mem devices.
> 
> A pre-requisite for Linux-managed memory-capacity provisioning is this
> cxl_mem driver that can speak the mailbox protocol defined in section
> 8.2.8.4 Mailbox Registers.
> 
> For now just land the driver boiler-plate and fill it in with
> functionality in subsequent commits.
> 
> Link: https://www.computeexpresslink.org/download-the-specification
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

Just one passing comment inline.

> diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
> new file mode 100644
> index 000000000000..005404888942
> --- /dev/null
> +++ b/drivers/cxl/mem.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#include <linux/module.h>
> +#include <linux/pci.h>
> +#include <linux/io.h>
> +#include "acpi.h"
> +#include "pci.h"
> +
> +static int cxl_mem_dvsec(struct pci_dev *pdev, int dvsec)

Is it worth pulling this out to a utility library now as we are going
to keep needing this for CXL devices?
Arguably, with a vendor_id parameter it might make sense to have
it as a utility function for pci rather than CXL alone.

> +{
> +	int pos;
> +
> +	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
> +	if (!pos)
> +		return 0;
> +
> +	while (pos) {
> +		u16 vendor, id;
> +
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_VENDOR_ID_OFFSET,
> +				     &vendor);
> +		pci_read_config_word(pdev, pos + PCI_DVSEC_ID_OFFSET, &id);
> +		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
> +			return pos;
> +
> +		pos = pci_find_next_ext_capability(pdev, pos,
> +						   PCI_EXT_CAP_ID_DVSEC);
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_probe(struct pci_dev *pdev, const struct pci_device_id *id)
> +{
> +	struct device *dev = &pdev->dev;
> +	int rc, regloc;
> +
> +	rc = cxl_bus_acquire(pdev);
> +	if (rc != 0) {
> +		dev_err(dev, "failed to acquire interface\n");
> +		return rc;
> +	}
> +
> +	regloc = cxl_mem_dvsec(pdev, PCI_DVSEC_ID_CXL_REGLOC);
> +	if (!regloc) {
> +		dev_err(dev, "register location dvsec not found\n");
> +		return -ENXIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct pci_device_id cxl_mem_pci_tbl[] = {
> +	/* PCI class code for CXL.mem Type-3 Devices */
> +	{ PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID, PCI_ANY_ID,
> +	  PCI_CLASS_MEMORY_CXL, 0xffffff, 0 },
> +	{ /* terminate list */ },
> +};
> +MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
> +
> +static struct pci_driver cxl_mem_driver = {
> +	.name			= KBUILD_MODNAME,
> +	.id_table		= cxl_mem_pci_tbl,
> +	.probe			= cxl_mem_probe,
> +};
> +
> +MODULE_LICENSE("GPL v2");
> +module_pci_driver(cxl_mem_driver);
> +MODULE_IMPORT_NS(CXL);
> diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
> new file mode 100644
> index 000000000000..a8a9935fa90b
> --- /dev/null
> +++ b/drivers/cxl/pci.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright(c) 2020 Intel Corporation. All rights reserved. */
> +#ifndef __CXL_PCI_H__
> +#define __CXL_PCI_H__
> +
> +#define PCI_CLASS_MEMORY_CXL	0x050210
> +
> +/*
> + * See section 8.1 Configuration Space Registers in the CXL 2.0
> + * Specification
> + */
> +#define PCI_EXT_CAP_ID_DVSEC		0x23
> +#define PCI_DVSEC_VENDOR_ID_CXL		0x1E98
> +#define PCI_DVSEC_VENDOR_ID_OFFSET	0x4
> +#define PCI_DVSEC_ID_CXL		0x0
> +#define PCI_DVSEC_ID_OFFSET		0x8
> +
> +#define PCI_DVSEC_ID_CXL_REGLOC		0x8
> +
> +#endif /* __CXL_PCI_H__ */

