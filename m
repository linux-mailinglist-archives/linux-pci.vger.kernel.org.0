Return-Path: <linux-pci+bounces-36037-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7145DB55305
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 17:18:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 816EEAC3FF3
	for <lists+linux-pci@lfdr.de>; Fri, 12 Sep 2025 15:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DC231DD88;
	Fri, 12 Sep 2025 15:15:06 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904773148CD;
	Fri, 12 Sep 2025 15:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757690106; cv=none; b=I6dF08lz44lyreBUYsJSCZIK1Z8B1ORj90W2qRb1p9IbOuAInGdNT1MNX/9aWot/nwNhvJ7KLY7XnyYsUK31dH4+hsFe71xyMczfhq+0FuBw1Dvk3v9pJVfwSdgVmZBO3/rcuJyf7y3CVOPScHJDR8rr4hV83+ccuyPq0vy6l2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757690106; c=relaxed/simple;
	bh=h76DRWc/sfj+QFjeh+wSOipvyV+oy8XSGs8WY1Jd4n4=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PDIbUVlap/xCxRope3cWH3VLSe0IEqdG37kvqUE2zjtzC225ukkQZ9siTQD3OemgfCkdOfUXDbDVIyUG7KLZ0E2PVKrmaDIUbxJLQKd4Zw5S40nm3j+k3RaofJc5YKvVwKckriaFbF4y9pDIB2IKGgUVUhnMdyuRmouZdr8OYYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.216])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4cNdH94p7Zz6D8cl;
	Fri, 12 Sep 2025 23:13:41 +0800 (CST)
Received: from frapeml500008.china.huawei.com (unknown [7.182.85.71])
	by mail.maildlp.com (Postfix) with ESMTPS id 1ACDB1402EA;
	Fri, 12 Sep 2025 23:15:00 +0800 (CST)
Received: from localhost (10.203.177.15) by frapeml500008.china.huawei.com
 (7.182.85.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Fri, 12 Sep
 2025 17:14:59 +0200
Date: Fri, 12 Sep 2025 16:14:58 +0100
From: Jonathan Cameron <jonathan.cameron@huawei.com>
To: Ben Cheatham <Benjamin.Cheatham@amd.com>
CC: <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>,
	<linux-acpi@vger.kernel.org>
Subject: Re: [PATCH 03/16] PCI: PCIe portdrv: Add CXL Isolation service
 driver
Message-ID: <20250912161458.00002d16@huawei.com>
In-Reply-To: <20250730214718.10679-4-Benjamin.Cheatham@amd.com>
References: <20250730214718.10679-1-Benjamin.Cheatham@amd.com>
	<20250730214718.10679-4-Benjamin.Cheatham@amd.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500008.china.huawei.com (7.182.85.71)

On Wed, 30 Jul 2025 16:47:05 -0500
Ben Cheatham <Benjamin.Cheatham@amd.com> wrote:

> Add the CXL isolation service, which will provide the necessary
> information to the PCIe portdrv and CXL drivers to map, setup, and
> handle CXL isolation interrupts.
> 
> Add functions to get the CXL isolation MSI/-X interrupt vector
> from the PCIe portdrv.
> 
> Signed-off-by: Ben Cheatham <Benjamin.Cheatham@amd.com>

Hmm. I feel a bit guilty I haven't gotten back to a rework of the
portdrv.  To potentially make that easier (when I or someone else
get the time), would it work for you if this only did MSI-X?
That would let us handle this in a somewhat 'pluggable' way without
having to deal with the limitations of MSI wrt to dynamic interrupt
allocation.

> ---
>  drivers/cxl/Kconfig              | 14 +++++
>  drivers/cxl/cxl.h                |  4 ++
>  drivers/pci/pcie/Makefile        |  1 +
>  drivers/pci/pcie/cxl_isolation.c | 87 ++++++++++++++++++++++++++++++++
>  drivers/pci/pcie/portdrv.c       |  1 +
>  drivers/pci/pcie/portdrv.h       | 18 ++++++-
>  6 files changed, 124 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/pci/pcie/cxl_isolation.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 57274de54a45..537e1e8e13da 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -247,4 +247,18 @@ config CXL_NATIVE_RAS
>  	  If unsure, or if this kernel is meant for production environments,
>  	  say Y.
>  
> +config CXL_ISOLATION
> +	bool "CXL.mem Isolation Support"
> +	depends on PCIEPORTBUS
> +	depends on CXL_BUS=PCIEPORTBUS
> +	help
> +	  Enables the CXL.mem isolation PCIe port bus service driver. This
> +	  driver, in combination with the CXL driver core, is responsible
> +	  for managing CXL-capable PCIe root ports that undergo CXL.mem
> +	  error isolation due to either a CXL.mem transaction timeout or
> +	  link down condition. Without error isolation, either of these
> +	  conditions will trigger a system reset.
> +
> +	  If unsure say 'y'
I'd drop this last line or say something more about when it makes sense to enable.


> diff --git a/drivers/pci/pcie/cxl_isolation.c b/drivers/pci/pcie/cxl_isolation.c
> new file mode 100644
> index 000000000000..550f16271d1c
> --- /dev/null
> +++ b/drivers/pci/pcie/cxl_isolation.c
> @@ -0,0 +1,87 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The CXL Isolation PCIe port service driver provides functions to allocate
> + * and set up CXL Timeout & Isolation interrupts (CXL 3.2 12.3). This driver
> + * does no actual interrupt handling, it only provides the information for
> + * the CXL driver to set up its own handling because the CXL driver is better
> + * equipped to handle isolation interrupts.
> + *
> + * Copyright (C) 2025, Advanced Micro Devices, Inc.
> + * All Rights Reserved.
> + *
> + * Author: Ben Cheatham <Benjamin.Cheatham@amd.com>
> + */
> +
> +#include <linux/pci.h>
> +
> +#include "../../cxl/cxlpci.h"
> +#include "portdrv.h"
> +
> +static int get_isolation_intr_vec(u32 cap)
> +{
> +	if (!FIELD_GET(CXL_ISOLATION_CAP_INTR_SUPP, cap) ||
> +	    !FIELD_GET(CXL_ISOLATION_CAP_MEM_ISO_SUPP, cap))
> +		return -ENXIO;
> +
> +	return FIELD_GET(CXL_ISOLATION_CAP_INTR_MASK, cap);
> +}
> +
> +int pcie_cxliso_get_intr_vec(struct pci_dev *dev, int *vec)
> +{
> +	struct cxl_component_regs regs;
> +	struct cxl_register_map map;
> +	u32 cap;
> +	int rc;
> +
> +	rc = cxl_find_regblock(dev, CXL_REGLOC_RBI_COMPONENT, &map);
> +	if (rc)
> +		return rc;
> +
> +	rc = cxl_setup_regs(&map);
> +	if (rc)
> +		return rc;
> +
> +	if (!map.component_map.isolation.valid)
> +		return -ENXIO;
> +

Add some comments here on why we go through this dance of temporary mapping.
(I have similar for the CPMU code I never finished upstreaming).

> +	rc = cxl_map_component_regs(&map, &regs,
> +				    BIT(CXL_CM_CAP_CAP_ID_ISOLATION));
> +	if (rc)
> +		return rc;
> +
> +	cap = readl(regs.isolation + CXL_ISOLATION_CAPABILITY_OFFSET);
> +	rc = get_isolation_intr_vec(cap);
> +	if (rc < 0) {

Probably use a goto given common shared stuff to do on exit.

> +		cxl_unmap_component_regs(&map, &regs,
> +					 BIT(CXL_CM_CAP_CAP_ID_ISOLATION));
> +		return rc;
> +	}
> +
> +	if (vec)
> +		*vec = rc;
> +
> +	cxl_unmap_component_regs(&map, &regs, BIT(CXL_CM_CAP_CAP_ID_ISOLATION));
> +	return 0;
> +
> +}
> +
> +static int cxl_isolation_probe(struct pcie_device *dev)
> +{
> +	if (!pcie_is_cxl(dev->port) || pcie_cxliso_get_intr_vec(dev->port, NULL))
The second call has rich error codes so better not to eat them.

	if (!pcie_is_cxl(dev->port))
		return -ENXIO;

	rc = pcie_cxl_iso_get_intr_vec();
	if (rc)
		return rc;

> +		return -ENXIO;
> +
> +	pci_info(dev->port, "CXLISO: Signaling with IRQ %d\n", dev->irq);
I guess there is history of this for other portdrv services, but to me too noisy
for a normal boot and should be trivial to get from /proc/interrupts

> +	return 0;
> +}


