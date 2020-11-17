Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0142B686B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Nov 2020 16:16:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728546AbgKQPPb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Nov 2020 10:15:31 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56]:2119 "EHLO
        frasgout.his.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgKQPPa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Nov 2020 10:15:30 -0500
Received: from fraeml736-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Cb8bl3L3bz67FF8;
        Tue, 17 Nov 2020 23:13:55 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml736-chm.china.huawei.com (10.206.15.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1913.5; Tue, 17 Nov 2020 16:15:28 +0100
Received: from localhost (10.47.31.177) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 17 Nov
 2020 15:15:27 +0000
Date:   Tue, 17 Nov 2020 15:15:19 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Ben Widawsky <ben.widawsky@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-acpi@vger.kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [RFC PATCH 5/9] cxl/mem: Find device capabilities
Message-ID: <20201117151519.000069d2@Huawei.com>
In-Reply-To: <20201111054356.793390-6-ben.widawsky@intel.com>
References: <20201111054356.793390-1-ben.widawsky@intel.com>
        <20201111054356.793390-6-ben.widawsky@intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.31.177]
X-ClientProxiedBy: lhreml736-chm.china.huawei.com (10.201.108.87) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 10 Nov 2020 21:43:52 -0800
Ben Widawsky <ben.widawsky@intel.com> wrote:

> CXL devices contain an array of capabilities that describe the
> interactions software can interact with the device, or firmware running
> on the device. A CXL compliant device must implement the device status
> and the mailbox capability. A CXL compliant memory device must implement
> the memory device capability.
> 
> Each of the capabilities can [will] provide an offset within the MMIO
> region for interacting with the CXL device.
> 
> Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

A few really minor things in this one.

Jonathan

> ---
>  drivers/cxl/cxl.h | 89 +++++++++++++++++++++++++++++++++++++++++++++++
>  drivers/cxl/mem.c | 58 +++++++++++++++++++++++++++---
>  2 files changed, 143 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/cxl/cxl.h
> 
> diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
> new file mode 100644
> index 000000000000..02858ae63d6d
> --- /dev/null
> +++ b/drivers/cxl/cxl.h
> @@ -0,0 +1,89 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +// Copyright(c) 2020 Intel Corporation. All rights reserved.
> +
> +#ifndef __CXL_H__
> +#define __CXL_H__
> +
> +/* Device */
> +#define CXLDEV_CAP_ARRAY_REG 0x0
> +#define CXLDEV_CAP_ARRAY_CAP_ID 0
> +#define CXLDEV_CAP_ARRAY_ID(x) ((x) & 0xffff)
> +#define CXLDEV_CAP_ARRAY_COUNT(x) (((x) >> 32) & 0xffff)
> +
> +#define CXL_CAPABILITIES_CAP_ID_DEVICE_STATUS 1

I'm not sure what you can do about consistent naming, but
perhaps this really does need to be 
CXLDEV_CAP_CAP_ID_x  however silly that looks.

It's a funny exercise I've only seen done once in a spec, but
I wish everyone would try working out what their fully expanded
field names will end up as and make sure the long form naming shortens
to something sensible.  It definitely helps with clarity!

> +#define CXL_CAPABILITIES_CAP_ID_PRIMARY_MAILBOX 2
> +#define CXL_CAPABILITIES_CAP_ID_SECONDARY_MAILBOX 3
> +#define CXL_CAPABILITIES_CAP_ID_MEMDEV 0x4000
> +
> +/* Mailbox */
> +#define CXLDEV_MB_CAPS 0x00

Elsewhere you've used _OFFSET postfix. That's useful so I'd do it here
as well.  Cross references to the spec section always appreciated as well!

> +#define   CXLDEV_MB_CAP_PAYLOAD_SIZE(cap) ((cap) & 0x1F)
> +#define CXLDEV_MB_CTRL 0x04
> +#define CXLDEV_MB_CMD 0x08
> +#define CXLDEV_MB_STATUS 0x10
> +#define CXLDEV_MB_BG_CMD_STATUS 0x18
> +
> +struct cxl_mem {
> +	struct pci_dev *pdev;
> +	void __iomem *regs;
> +
> +	/* Cap 0000h */

What are the numbers here?  These capabilities have too
many indexes associated with them in different ways for it
to be obvious, so perhaps more detail in the comments?

> +	struct {
> +		void __iomem *regs;
> +	} status;
> +
> +	/* Cap 0002h */
> +	struct {
> +		void __iomem *regs;
> +		size_t payload_size;
> +	} mbox;
> +
> +	/* Cap 0040h */
> +	struct {
> +		void __iomem *regs;
> +	} mem;
> +};
