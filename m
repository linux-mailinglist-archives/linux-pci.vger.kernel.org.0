Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1ACC30ADAD
	for <lists+linux-pci@lfdr.de>; Mon,  1 Feb 2021 18:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbhBARWw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Feb 2021 12:22:52 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2469 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbhBARWu (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 1 Feb 2021 12:22:50 -0500
Received: from fraeml741-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4DTvjR6tjtz67jtQ;
        Tue,  2 Feb 2021 01:15:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml741-chm.china.huawei.com (10.206.15.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Mon, 1 Feb 2021 18:22:03 +0100
Received: from localhost (10.47.76.76) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2106.2; Mon, 1 Feb 2021
 17:22:02 +0000
Date:   Mon, 1 Feb 2021 17:21:18 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-acpi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-nvdimm@lists.01.org>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        "Chris Browy" <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        "Ira Weiny" <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        "Rafael Wysocki" <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        <daniel.lll@alibaba-inc.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: Re: [PATCH 01/14] cxl/mem: Introduce a driver for CXL-2.0-Type-3
 endpoints
Message-ID: <20210201172118.0000673f@Huawei.com>
In-Reply-To: <20210130002438.1872527-2-ben.widawsky@intel.com>
References: <20210130002438.1872527-1-ben.widawsky@intel.com>
        <20210130002438.1872527-2-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.76.76]
X-ClientProxiedBy: lhreml703-chm.china.huawei.com (10.201.108.52) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, 29 Jan 2021 16:24:25 -0800
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
> For now just land the initial driver boiler-plate and Documentation/
> infrastructure.
> 
> Link: https://www.computeexpresslink.org/download-the-specification
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Hi Ben,

One thing below about using defs from generic PCI headers where
they are not CXL specific.


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

include/uapi/linux/pci-regs.h includes equivalents of generic parts of
this already though PCI_DVSEC_HEADER1 isn't exactly informative naming.

> +
> +#define PCI_DVSEC_ID_CXL_REGLOC		0x8
> +
> +#endif /* __CXL_PCI_H__ */

