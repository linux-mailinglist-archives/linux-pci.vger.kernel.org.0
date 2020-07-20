Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD7A22255BA
	for <lists+linux-pci@lfdr.de>; Mon, 20 Jul 2020 04:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgGTCC5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 19 Jul 2020 22:02:57 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:51734 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726225AbgGTCC4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 19 Jul 2020 22:02:56 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id C24A7AB957D3D94B7215;
        Mon, 20 Jul 2020 10:02:53 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.487.0; Mon, 20 Jul 2020
 10:02:43 +0800
Subject: Re: [PATCH v2 0/6] ACPI: Only create NUMA nodes from entries in SRAT
 or SRAT emulation.
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <martin@geanix.com>,
        "Ingo Molnar" <mingo@redhat.com>, <linux-ia64@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Song Bao Hua <song.bao.hua@hisilicon.com>
References: <20200717175959.899775-1-Jonathan.Cameron@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <9b679614-083b-cec4-e0de-34e1a66b103a@huawei.com>
Date:   Mon, 20 Jul 2020 10:02:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200717175959.899775-1-Jonathan.Cameron@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2020/7/18 1:59, Jonathan Cameron wrote:
> Here, I will use the term Proximity Domains for the ACPI description and
> NUMA Nodes for the in kernel representation.
> 
> ACPI 6.3 included a clarification that only Static Resource Allocation
> Structures in SRAT may define the existence of proximity domains
> (sec 5.2.16). This clarification closed a possible interpretation that
> other parts of ACPI (e.g. DSDT _PXM, NFIT etc) could define new proximity
> domains that were not also mentioned in SRAT structures.
> 
> In practice the kernel has never allowed this alternative interpretation as
> such nodes are only partially initialized. This is architecture specific
> but to take an example, on x86 alloc_node_data has not been called.
> Any use of them for node specific allocation, will result in a crash as the
> infrastructure to fallback to a node with memory is not setup.
> 
> We ran into a problem when enabling _PXM handling for PCI devices and found
> there were boards out there advertising devices in proximity domains that
> didn't exist [2].
> 
> The fix suggested in this series is to replace instances that should not
> 'create' new nodes with pxm_to_node.  This function needs a some additional
> hardening against invalid inputs to make sure it is safe for use in these
> new callers.
> 
> Patch 1 Hardens pxm_to_node() against numa_off, and pxm entry being too large.
> 
> Patch 2-4 change the various callers not related to SRAT entries so that they
> set this parameter to false, so do not attempt to initialize a new NUMA node
> if the relevant one does not already exist.
> 
> Patch 5 is a function rename to reflect change in functionality of
> acpi_map_pxm_to_online_node() as it no longer creates a new map, but just does a
> lookup of existing maps.
> 
> Patch 6 covers the one place we do not allow the full flexibility defined
> in the ACPI spec.  For SRAT GIC Interrupt Translation Service (ITS) Affinity
> Structures, on ARM64, the driver currently makes an additional pass of SRAT
> later in the boot than the one used to identify NUMA domains.
> Note, this currently means that an ITS placed in a proximity domain that is
> not defined by another SRAT structure will result in the a crash.
> 
> To avoid this crash with minimal changes we do not create new NUMA nodes based
> on this particular entry type.  Any current platform trying to do this will not
> boot, so this is an improvement, if perhaps not a perfect solution.

Make sense to me,

Reviewed-by: Hanjun Guo <guohanjun@huawei.com>

