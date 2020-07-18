Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84AD42248E4
	for <lists+linux-pci@lfdr.de>; Sat, 18 Jul 2020 07:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgGRFJb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Sat, 18 Jul 2020 01:09:31 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:2981 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725887AbgGRFJb (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 18 Jul 2020 01:09:31 -0400
Received: from dggemi404-hub.china.huawei.com (unknown [172.30.72.53])
        by Forcepoint Email with ESMTP id 6CC67F0EEEC0DF655046;
        Sat, 18 Jul 2020 13:09:27 +0800 (CST)
Received: from DGGEMI525-MBS.china.huawei.com ([169.254.6.52]) by
 dggemi404-hub.china.huawei.com ([10.3.17.142]) with mapi id 14.03.0487.000;
 Sat, 18 Jul 2020 13:09:17 +0800
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
Subject: RE: [PATCH v2 1/6] ACPI: Add out of bounds and numa_off protections
 to pxm_to_node
Thread-Topic: [PATCH v2 1/6] ACPI: Add out of bounds and numa_off
 protections to pxm_to_node
Thread-Index: AQHWXGREtKO5c5ALFUyDHE/x3auv/qkMybkQ
Date:   Sat, 18 Jul 2020 05:09:16 +0000
Message-ID: <B926444035E5E2439431908E3842AFD2593D39@DGGEMI525-MBS.china.huawei.com>
References: <20200717175959.899775-1-Jonathan.Cameron@huawei.com>
 <20200717175959.899775-2-Jonathan.Cameron@huawei.com>
In-Reply-To: <20200717175959.899775-2-Jonathan.Cameron@huawei.com>
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
> Subject: [PATCH v2 1/6] ACPI: Add out of bounds and numa_off protections to
> pxm_to_node
> 
> The function should check the validity of the pxm value before using
> it to index the pxm_to_node_map array.
> 
> Whilst hardening this code may be good in general, the main intent
> here is to enable following patches that use this function to replace
> acpi_map_pxm_to_node for non SRAT usecases which should return
> NO_NUMA_NODE for PXM entries not matching with those in SRAT.
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Barry Song <song.bao.hua@hisilicon.com>

> ---
>  drivers/acpi/numa/srat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 5be5a977da1b..8ef44ee0d76b 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -31,7 +31,7 @@ int acpi_numa __initdata;
> 
>  int pxm_to_node(int pxm)
>  {
> -	if (pxm < 0)
> +	if (pxm < 0 || pxm >= MAX_PXM_DOMAINS || numa_off)
>  		return NUMA_NO_NODE;
>  	return pxm_to_node_map[pxm];
>  }
> --
> 2.19.1

