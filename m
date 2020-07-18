Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC6352248EE
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jul 2020 07:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726249AbgGRFRl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sat, 18 Jul 2020 01:17:41 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:2581 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726087AbgGRFRl (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Jul 2020 01:17:41 -0400
Received: from dggemi402-hub.china.huawei.com (unknown [172.30.72.55])
        by Forcepoint Email with ESMTP id 82573EA0382B11CA0321;
        Sat, 18 Jul 2020 13:17:35 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.52]) by
 dggemi402-hub.china.huawei.com ([10.3.17.135]) with mapi id 14.03.0487.000;
 Sat, 18 Jul 2020 13:17:28 +0800
From:   "Song Bao Hua (Barry Song)" <song.bao.hua@hisilicon.com>
To:     Jonathan Cameron <jonathan.cameron@huawei.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "x86@kernel.org" <x86@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "martin@geanix.com" <martin@geanix.com>,
        "Ingo Molnar" <mingo@redhat.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linuxarm <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH v2 5/6] ACPI: Remove side effect of partly creating a
 node in acpi_get_node
Thread-Topic: [PATCH v2 5/6] ACPI: Remove side effect of partly creating a
 node in acpi_get_node
Thread-Index: AQHWXGSNF+e0kQICqE2z4MI85n/Qt6kMy9pQ
Date:   Sat, 18 Jul 2020 05:17:27 +0000
Message-ID: <B926444035E5E2439431908E3842AFD2593D5E@DGGEMI525-MBS.china.huawei.com>
References: <20200717175959.899775-1-Jonathan.Cameron@huawei.com>
 <20200717175959.899775-6-Jonathan.Cameron@huawei.com>
In-Reply-To: <20200717175959.899775-6-Jonathan.Cameron@huawei.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.126.200.103]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



> -----Original Message-----
> From: Jonathan Cameron
> Sent: Saturday, July 18, 2020 6:00 AM
> To: linux-mm@kvack.org; linux-acpi@vger.kernel.org;
> linux-arm-kernel@lists.infradead.org; x86@kernel.org
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>; Bjorn Helgaas
> <bhelgaas@google.com>; linux-pci@vger.kernel.org; martin@geanix.com; Ingo
> Molnar <mingo@redhat.com>; linux-ia64@vger.kernel.org; Tony Luck
> <tony.luck@intel.com>; Fenghua Yu <fenghua.yu@intel.com>; Thomas
> Gleixner <tglx@linutronix.de>; Linuxarm <linuxarm@huawei.com>; Dan
> Williams <dan.j.williams@intel.com>; Song Bao Hua (Barry Song)
> <song.bao.hua@hisilicon.com>; Jonathan Cameron
> <jonathan.cameron@huawei.com>
> Subject: [PATCH v2 5/6] ACPI: Remove side effect of partly creating a node in
> acpi_get_node
> 
> acpi_get_node calls acpi_get_pxm to evaluate the _PXM AML method for
> entries found in DSDT/SSDT. ACPI 6.3 sec 6.2.14 states
> "_PXM evaluates to an integer that identifies a device as belonging to
>  a Proximity Domain defined in the System Resource Affinity Table (SRAT)."
> 
> Hence a _PXM method should not result in creation of a new NUMA node.
> Before this patch, _PXM could result in partial instantiation of
> NUMA node, missing elements such as zone lists.  A call to devm_kzalloc
> for example results in a null pointer dereference.
> 
> This patch therefore replaces the acpi_map_pxm_to_node with a call
> to pxm_to_node.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  drivers/acpi/numa/srat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 8ef44ee0d76b..697a5c9e2eb5 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -444,6 +444,6 @@ int acpi_get_node(acpi_handle handle)
> 
>  	pxm = acpi_get_pxm(handle);
> 
> -	return acpi_map_pxm_to_node(pxm);
> +	return pxm_to_node(pxm);
>  }
>  EXPORT_SYMBOL(acpi_get_node);
> --
> 2.19.1

