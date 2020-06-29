Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 132CB20DE0D
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 23:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgF2UWO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 16:22:14 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2410 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388752AbgF2UWM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 16:22:12 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 06A27914418996DFDB83;
        Mon, 29 Jun 2020 17:36:31 +0100 (IST)
Received: from localhost (10.227.96.57) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 29 Jun
 2020 17:36:30 +0100
Date:   Mon, 29 Jun 2020 17:36:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin@geanix.com>, Ingo Molnar <mingo@redhat.com>,
        <linux-ia64@vger.kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>, <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>
Subject: Re: [RFC PATCH] ACPI: Only create numa nodes from entries in SRAT
 or SRAT emulation.
Message-ID: <20200629173629.000029eb@huawei.com>
In-Reply-To: <20200629161659.3006329-1-Jonathan.Cameron@huawei.com>
References: <20200629161659.3006329-1-Jonathan.Cameron@huawei.com>
Organization: Huawei tech. R&D (UK)  Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.227.96.57]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 30 Jun 2020 00:16:59 +0800
Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:

> Here, I will use the term Proximity Domains for the ACPI description
> and Numa Nodes for the in kernel representation.
> 
> Until ACPI 6.3 it was arguably possible to interpret the
> specification as allowing _PXM in DSDT and similar to define
> additional Proximity Domains.
> 
> The reality was that was never the intent, and a 'clarification' was
> added in ACPI 6.3 [1].  In practice I think the kernel has never
> allowed any other interpretaion, except possibly on adhoc base within
> some out of tree driver (using it very very carefully given potential
> to crash when using various standard calls such as devm_kzalloc).
> 
> Proximity Domains are always defined in SRAT.  In ACPI, there are
> methods defined in ACPI to allow their characteristics to be tweaked
> later but Proximity Domains have to be referenced in this table at
> boot, thus allowing Linux to instantiate relevant Numa Node data
> structures.
> 
> We ran into a problem when enabling _PXM handling for PCI devices and
> found there were boards out there advertising devices in proximity
> domains that didn't exist [2].
> 
> The fix suggested here is to modfiy the function acpi_map_pxm_to_node.
> This function is both used to create and lookup proximity domains.
> A parameter is added to specify whether it should create a new
> proximity domain when it encounters a Proximity Domain ID that it
> hasn't seen before.
> 
> Naturally there is a quirk.  For SRAT ITS entries on ARM64 the
> handling is done with an additional pass of SRAT, potentially later
> in the boot. We could modify that behaviour so we could identify the
> existence of Proximity Domains unique to the ITS structures, and
> handle them as a special case of a Genric Initiator (once support for
> those merges) however...
> 
> Currently (5.8-rc2) setting the Proximity Domain of an ITS to one
> that hasn't been instantiated by being specified in another type of
> SRAT resource entry results in:
> 
> ITS [mem 0x202100000-0x20211ffff]
> ITS@0x0000000202100000: Using ITS number 0
> Unable to handle kernel paging request at virtual address
> 0000000000001a08 Mem abort info:
> ESR = 0x96000004
> EC = 0x25: DABT (current EL), IL = 32 bits
> SET = 0, FnV = 0
> EA = 0, S1PTW = 0
> Data abort info:
> ISV = 0, ISS = 0x00000004
> CM = 0, WnR = 0
> [0000000000001a08] user address but active_mm is swapper
> Internal error: Oops: 96000004 [#1] PREEMPT SMP
> Modules linked in:
> CPU: 0 PID: 0 Comm: swapper/0 Tainted: G       A          5.8.0-rc2
> #483 pstate: 80000089 (Nzcv daIf -PAN -UAO BTYPE=--)
> pc : __alloc_pages_nodemask+0xe8/0x338
> lr : __alloc_pages_nodemask+0xc0/0x338
> sp : ffffa81540c139b0
> x29: ffffa81540c139b0 x28: 0000000000000001
> x27: 0000000000000100 x26: ffffa81540c1ad38
> x25: 0000000000000000 x24: 0000000000000000
> x23: ffffa81540c23c00 x22: 0000000000000004
> x21: 0000000000000002 x20: 0000000000001a00
> x19: 0000000000000100 x18: 0000000000000010
> x17: 000000000001f000 x16: 000000000000007f
> x15: ffffa81540c24070 x14: ffffffffffffffff
> x13: ffffa815c0c137d7 x12: ffffa81540c137e4
> x11: ffffa81540c3e000 x10: ffffa81540ecee68
> x9 : ffffa8153f0f61d8 x8 : ffffa81540ecf000
> x7 : 0000000000000141 x6 : ffffa81540ecf401
> x5 : 0000000000000000 x4 : 0000000000000000
> x3 : 0000000000000000 x2 : 0000000000000000
> x1 : 0000000000000081 x0 : 0000000000001a00
> Call trace:
>  __alloc_pages_nodemask+0xe8/0x338
>  alloc_pages_node.constprop.0+0x34/0x40
>  its_probe_one+0x2f8/0xb18
>  gic_acpi_parse_madt_its+0x108/0x150
>  acpi_table_parse_entries_array+0x17c/0x264
>  acpi_table_parse_entries+0x48/0x6c
>  acpi_table_parse_madt+0x30/0x3c
>  its_init+0x1c4/0x644
>  gic_init_bases+0x4b8/0x4ec
>  gic_acpi_init+0x134/0x264
>  acpi_match_madt+0x4c/0x84
>  acpi_table_parse_entries_array+0x17c/0x264
>  acpi_table_parse_entries+0x48/0x6c
>  acpi_table_parse_madt+0x30/0x3c
>  __acpi_probe_device_table+0x8c/0xe8
>  irqchip_init+0x3c/0x48
>  init_IRQ+0xcc/0x100
>  start_kernel+0x33c/0x548
> 
> As we die in this case in existing kernels, we can be fairly sure
> that no one actually has such a firmware in production.  As such this
> patch avoids the complexity that would be needed to handle this
> corner case, and simply does not allow the ITS entry parsing code to
> instantiate new Numa Nodes.  If one is encountered that does not
> already exist, then NO_NUMA_NODE is assigned and a warning printed
> just as if the value had been greater than allowed Numa Nodes.
> 
> "SRAT: Invalid NUMA node -1 in ITS affinity"
> 
> I have only tested this for now on our ARM64 Kunpeng920 servers.
> 
> Open questions:
> * should we warn about a broken firmware or insufficent value of
>   NUMA_NODES_SHIFT if we find a firmware trying to assign any device
>   to a non existent Proximity Domain.
> * previously an smmuv3 in IORT with a Proximity Domain set to a non
> existent value would have resulted in a failure to add the device.
> After this change it will be added to the default node.  Is that a
> problem?
> 
> [1] Note in ACPI Specification 6.3 5.2.16 System Resource Affinity
> Table (SRAT) [2] https://patchwork.kernel.org/patch/10597777/
> 
> Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Note this is very much an "RFC". I missed a call in
drivers/iommu/intel/dmar.c
for which the parameter should be false. If people are happy with
the general approach I'll tidy that up in the next version.

Sorry about that, I should have remembered to do build tests on x86 at
least :(

Jonathan


> ---
>  arch/arm64/kernel/acpi_numa.c    | 2 +-
>  arch/ia64/kernel/acpi.c          | 2 +-
>  arch/x86/mm/srat.c               | 4 ++--
>  drivers/acpi/arm64/iort.c        | 2 +-
>  drivers/acpi/nfit/core.c         | 2 +-
>  drivers/acpi/numa/hmat.c         | 2 +-
>  drivers/acpi/numa/srat.c         | 8 ++++----
>  drivers/irqchip/irq-gic-v3-its.c | 6 +++++-
>  include/acpi/acpi_numa.h         | 2 +-
>  include/linux/acpi.h             | 6 +++---
>  10 files changed, 20 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm64/kernel/acpi_numa.c
> b/arch/arm64/kernel/acpi_numa.c index 7ff800045434..6ed47b058d76
> 100644 --- a/arch/arm64/kernel/acpi_numa.c
> +++ b/arch/arm64/kernel/acpi_numa.c
> @@ -107,7 +107,7 @@ void __init acpi_numa_gicc_affinity_init(struct
> acpi_srat_gicc_affinity *pa) return;
>  
>  	pxm = pa->proximity_domain;
> -	node = acpi_map_pxm_to_node(pxm);
> +	node = acpi_map_pxm_to_node(pxm, true);
>  
>  	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
>  		pr_err("SRAT: Too many proximity domains %d\n", pxm);
> diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> index a5636524af76..760a468864b7 100644
> --- a/arch/ia64/kernel/acpi.c
> +++ b/arch/ia64/kernel/acpi.c
> @@ -456,7 +456,7 @@ void __init acpi_numa_fixup(void)
>  	nodes_clear(node_online_map);
>  	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
>  		if (pxm_bit_test(i)) {
> -			int nid = acpi_map_pxm_to_node(i);
> +			int nid = acpi_map_pxm_to_node(i, true);
>  			node_set_online(nid);
>  		}
>  	}
> diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
> index dac07e4f5834..6497d7c241ec 100644
> --- a/arch/x86/mm/srat.c
> +++ b/arch/x86/mm/srat.c
> @@ -45,7 +45,7 @@ acpi_numa_x2apic_affinity_init(struct
> acpi_srat_x2apic_cpu_affinity *pa) pxm, apic_id);
>  		return;
>  	}
> -	node = acpi_map_pxm_to_node(pxm);
> +	node = acpi_map_pxm_to_node(pxm, true);
>  	if (node < 0) {
>  		printk(KERN_ERR "SRAT: Too many proximity domains
> %x\n", pxm); bad_srat();
> @@ -80,7 +80,7 @@ acpi_numa_processor_affinity_init(struct
> acpi_srat_cpu_affinity *pa) pxm = pa->proximity_domain_lo;
>  	if (acpi_srat_revision >= 2)
>  		pxm |= *((unsigned int*)pa->proximity_domain_hi) <<
> 8;
> -	node = acpi_map_pxm_to_node(pxm);
> +	node = acpi_map_pxm_to_node(pxm, true);
>  	if (node < 0) {
>  		printk(KERN_ERR "SRAT: Too many proximity domains
> %x\n", pxm); bad_srat();
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index 28a6b387e80e..8133e7e6f9e3 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -1293,7 +1293,7 @@ static int  __init
> arm_smmu_v3_set_proximity(struct device *dev, 
>  	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
>  	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
> -		int dev_node = acpi_map_pxm_to_node(smmu->pxm);
> +		int dev_node = acpi_map_pxm_to_node(smmu->pxm,
> false); 
>  		if (dev_node != NUMA_NO_NODE &&
> !node_online(dev_node)) return -EINVAL;
> diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> index 7c138a4edc03..6cb44bbaa71f 100644
> --- a/drivers/acpi/nfit/core.c
> +++ b/drivers/acpi/nfit/core.c
> @@ -2948,7 +2948,7 @@ static int acpi_nfit_register_region(struct
> acpi_nfit_desc *acpi_desc, ndr_desc->numa_node =
> acpi_map_pxm_to_online_node( spa->proximity_domain);
>  		ndr_desc->target_node = acpi_map_pxm_to_node(
> -				spa->proximity_domain);
> +				spa->proximity_domain, false);
>  	} else {
>  		ndr_desc->numa_node = NUMA_NO_NODE;
>  		ndr_desc->target_node = NUMA_NO_NODE;
> diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> index 2c32cfb72370..3c0414816772 100644
> --- a/drivers/acpi/numa/hmat.c
> +++ b/drivers/acpi/numa/hmat.c
> @@ -666,7 +666,7 @@ static void hmat_register_target_device(struct
> memory_target *target, 
>  	pdev->dev.numa_node =
> acpi_map_pxm_to_online_node(target->memory_pxm); info = (struct
> memregion_info) {
> -		.target_node =
> acpi_map_pxm_to_node(target->memory_pxm),
> +		.target_node =
> acpi_map_pxm_to_node(target->memory_pxm, false), };
>  	rc = platform_device_add_data(pdev, &info, sizeof(info));
>  	if (rc < 0) {
> diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> index 5be5a977da1b..ed7d31795f4d 100644
> --- a/drivers/acpi/numa/srat.c
> +++ b/drivers/acpi/numa/srat.c
> @@ -52,7 +52,7 @@ static void __acpi_map_pxm_to_node(int pxm, int
> node) node_to_pxm_map[node] = pxm;
>  }
>  
> -int acpi_map_pxm_to_node(int pxm)
> +int acpi_map_pxm_to_node(int pxm, bool create)
>  {
>  	int node;
>  
> @@ -62,7 +62,7 @@ int acpi_map_pxm_to_node(int pxm)
>  	node = pxm_to_node_map[pxm];
>  
>  	if (node == NUMA_NO_NODE) {
> -		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
> +		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES ||
> !create) return NUMA_NO_NODE;
>  		node = first_unset_node(nodes_found_map);
>  		__acpi_map_pxm_to_node(pxm, node);
> @@ -229,7 +229,7 @@ acpi_numa_memory_affinity_init(struct
> acpi_srat_mem_affinity *ma) if (acpi_srat_revision <= 1)
>  		pxm &= 0xff;
>  
> -	node = acpi_map_pxm_to_node(pxm);
> +	node = acpi_map_pxm_to_node(pxm, true);
>  	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
>  		pr_err("SRAT: Too many proximity domains.\n");
>  		goto out_err_bad_srat;
> @@ -444,6 +444,6 @@ int acpi_get_node(acpi_handle handle)
>  
>  	pxm = acpi_get_pxm(handle);
>  
> -	return acpi_map_pxm_to_node(pxm);
> +	return acpi_map_pxm_to_node(pxm, false);
>  }
>  EXPORT_SYMBOL(acpi_get_node);
> diff --git a/drivers/irqchip/irq-gic-v3-its.c
> b/drivers/irqchip/irq-gic-v3-its.c index cd685f521c77..0b11876d0799
> 100644 --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -5248,7 +5248,11 @@ static int __init
> gic_acpi_parse_srat_its(union acpi_subtable_headers *header, return
> -EINVAL; }
>  
> -	node = acpi_map_pxm_to_node(its_affinity->proximity_domain);
> +	/*
> +	 * Note that in theory a new proximity node could be created
> by this
> +	 * entry as it is an SRAT resource allocation structure
> +	 */
> +	node = acpi_map_pxm_to_node(its_affinity->proximity_domain,
> false); 
>  	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
>  		pr_err("SRAT: Invalid NUMA node %d in ITS
> affinity\n", node); diff --git a/include/acpi/acpi_numa.h
> b/include/acpi/acpi_numa.h index fdebcfc6c8df..6935c7516262 100644
> --- a/include/acpi/acpi_numa.h
> +++ b/include/acpi/acpi_numa.h
> @@ -15,7 +15,7 @@
>  
>  extern int pxm_to_node(int);
>  extern int node_to_pxm(int);
> -extern int acpi_map_pxm_to_node(int);
> +extern int acpi_map_pxm_to_node(int, bool);
>  extern unsigned char acpi_srat_revision;
>  extern int acpi_numa __initdata;
>  
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index d661cd0ee64d..1414b7e0a486 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -416,7 +416,7 @@ extern void acpi_osi_setup(char *str);
>  extern bool acpi_osi_is_win8(void);
>  
>  #ifdef CONFIG_ACPI_NUMA
> -int acpi_map_pxm_to_node(int pxm);
> +int acpi_map_pxm_to_node(int pxm, bool create);
>  int acpi_get_node(acpi_handle handle);
>  
>  /**
> @@ -436,7 +436,7 @@ int acpi_get_node(acpi_handle handle);
>   */
>  static inline int acpi_map_pxm_to_online_node(int pxm)
>  {
> -	int node = acpi_map_pxm_to_node(pxm);
> +	int node = acpi_map_pxm_to_node(pxm, false);
>  
>  	return numa_map_to_online_node(node);
>  }
> @@ -445,7 +445,7 @@ static inline int acpi_map_pxm_to_online_node(int
> pxm) {
>  	return 0;
>  }
> -static inline int acpi_map_pxm_to_node(int pxm)
> +static inline int acpi_map_pxm_to_node(int pxm, bool create)
>  {
>  	return 0;
>  }

