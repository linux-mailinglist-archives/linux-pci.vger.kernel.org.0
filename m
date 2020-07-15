Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4616221300
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jul 2020 18:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725885AbgGOQvO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-pci@lfdr.de>); Wed, 15 Jul 2020 12:51:14 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2483 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725838AbgGOQvN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 15 Jul 2020 12:51:13 -0400
Received: from lhreml710-chm.china.huawei.com (unknown [172.18.7.106])
        by Forcepoint Email with ESMTP id 6421477C2E7F3AAA5AAC;
        Wed, 15 Jul 2020 17:51:11 +0100 (IST)
Received: from localhost (10.52.120.134) by lhreml710-chm.china.huawei.com
 (10.201.108.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Wed, 15 Jul
 2020 17:51:10 +0100
Date:   Wed, 15 Jul 2020 17:49:58 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <linux-mm@kvack.org>, <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <x86@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <martin@geanix.com>, Ingo Molnar <mingo@redhat.com>,
        <linux-ia64@vger.kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, <linuxarm@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH] ACPI: Only create numa nodes from entries in SRAT or
 SRAT emulation.
Message-ID: <20200715174958.00001a1d@Huawei.com>
In-Reply-To: <20200714203641.GA411640@bjorn-Precision-5520>
References: <20200713151018.2267079-1-Jonathan.Cameron@huawei.com>
        <20200714203641.GA411640@bjorn-Precision-5520>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.52.120.134]
X-ClientProxiedBy: lhreml724-chm.china.huawei.com (10.201.108.75) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 14 Jul 2020 15:36:41 -0500
Bjorn Helgaas <helgaas@kernel.org> wrote:

Hi Bjorn,

Thanks for the review.

> The subject suggests that currently we create NUMA nodes from SRAT
> *and* other sources, and that this patch will remove the other
> sources.  Is that right?

Effectively yes.  

The actual problem in the kernel is we 'partly' create NUMA nodes from other
sources (_PXM and others), but not completely, leaving a bunch of cases
where normal use of them will cause problems (e.g. devm memory allocations).
So I would say we don't succeed in creating the nodes and the code doesn't
prevent us from doing part of the job.  If this problem didn't exist
there would be little point in making this change.

Given the ACPI spec says we should not create nodes unless they are defined in
SRAT, the easiest way to close this existing problem down is to stop
creating those nodes. Given anyone who does this today in their firmware
generally can't boot Linux (the exception being where Linux currently ignores
specified proximity nodes), we aren't making it any worse for anyone.

The side effect being that this allows us to enable _PXM for PCI device.
(follow up patch once we have a solution to this).

> 
> On Mon, Jul 13, 2020 at 11:10:18PM +0800, Jonathan Cameron wrote:
> > Here, I will use the term Proximity Domains for the ACPI description and
> > Numa Nodes for the in kernel representation.  
> 
> ACPI spells it "NUMA".  Maybe in subject line, too.
> 
> > Until ACPI 6.3 it was arguably possible to interpret the specification as
> > allowing _PXM in DSDT and similar to define additional Proximity Domains.  
> 
> I *think* you mean that the SRAT defines proximity domains (ACPI v6.3,
> sec 5.2.16) and the possible interpretation is that _PXM can define
> new proximity domains that were not mentioned in the SRAT.

I do.  I'll use something closer to your language.

> 
> > The reality was that was never the intent, and a 'clarification' was added
> > in ACPI 6.3 [1].  In practice I think the kernel has never allowed any other
> > interpretaion, except possibly on adhoc base within some out of tree driver
> > (using it very very carefully given potential to crash when using various
> > standard calls such as devm_kzalloc).  
> 
> Drop the "was never the intent" part; who knows what intent of the
> cabal that wrote the spec was, and it isn't really useful anyway.  I'd
> say the "Note" in 5.2.16 qualifies as a clarification and doesn't need
> scare quotes around it.

Sure.  We did ask those who drew up the original spec, hence allowing us to
get at close to what the intent was. Still I agree it doesn't need to be stated here
as is probably only of historical interest.

> 
> s/interpretaion/interpretation/
> s/adhoc/ad hoc/
> s/base/basis/ (I guess?)
> 
> Personally I don't see the point of mentioning out-of-tree drivers
> that might be doing something wrong unless it helps us maintain
> *in-tree* stuff.

OK.  This was added to address an earlier point you made that it was
possible that some driver was using _PXM to partly initialize a node,
for more sophisticated allocation decisions, rather than directly
using standard node allocations etc. Whilst that is complex it could
in theory have been done.  Now the driver can do that by directly
evaluating _PXM.  Given I am fairly sure no in tree drivers do this,
I'm certainly happy to drop it.

> 
> > Proximity Domains are always defined in SRAT.  In ACPI, there are methods
> > defined in ACPI to allow their characteristics to be tweaked later but
> > Proximity Domains have to be referenced in this table at boot, thus
> > allowing Linux to instantiate relevant Numa Node data structures.  
> 
> s/In ACPI, there/There/
> 
> > We ran into a problem when enabling _PXM handling for PCI devices and found
> > there were boards out there advertising devices in proximity domains that
> > didn't exist [2].
> > 
> > The fix suggested here is to modfiy the function acpi_map_pxm_to_node.
> > This function is both used to create and lookup proximity domains.
> > A parameter is added to specify whether it should create a new
> > proximity domain when it encounters a Proximity Domain ID that it
> > hasn't seen before.  
> 
> s/modfiy/modify/
> 
> > Naturally there is a quirk.  For SRAT ITS entries on ARM64 the handling is
> > done with an additional pass of SRAT, potentially later in the boot. We
> > could modify that behaviour so we could identify the existence of Proximity
> > Domains unique to the ITS structures, and handle them as a special case
> > of a Genric Initiator (once support for those merges) however...  
> 
> s/ITS/Interrupt Translation Service (ITS)/ (first time)
> s/Genric/Generic/ (or maybe "generic initiator" as used in ACPI spec)
> 
> > Currently (5.8-rc2) setting the Proximity Domain of an ITS to one that hasn't
> > been instantiated by being specified in another type of SRAT resource entry
> > results in:  
> 
> Are you saying the _PXM of an ITS mentions a proximity domain that
> wasn't mentioned in the SRAT?

No
 
> Or are you saying an SRAT ITS entry mentions a proximity domain that
> wasn't mentioned in a different type of SRAT entry?  I *think* this is
> what you're saying, but I don't see anything in the spec about which
> entry types are allowed to define proximity domains.

Yes. That is why I am explicitly calling out this exception to the
specification.  As things currently stand this is broken. Hence no existing
platform is doing this because they wouldn't boot.

The current patch closes down the hole, preventing this crash.  It does
it by defaulting to NO_NUMA_NODE. As you observe that is not in line with
the ACPI specification. It will not break any platforms because we know
no one is doing this (as it crashes currently).

I am more than happy to look at relaxing that restriction but it is a
separate (and currently theoretical) issue.

> 
> > ITS [mem 0x202100000-0x20211ffff]
> > ITS@0x0000000202100000: Using ITS number 0
> > Unable to handle kernel paging request at virtual address 0000000000001a08
> > Mem abort info:
> > ESR = 0x96000004
> > EC = 0x25: DABT (current EL), IL = 32 bits
> > SET = 0, FnV = 0
> > EA = 0, S1PTW = 0
> > Data abort info:
> > ISV = 0, ISS = 0x00000004
> > CM = 0, WnR = 0
> > [0000000000001a08] user address but active_mm is swapper
> > Internal error: Oops: 96000004 [#1] PREEMPT SMP
> > Modules linked in:
> > CPU: 0 PID: 0 Comm: swapper/0 Tainted: G       A          5.8.0-rc2 #483
> > pstate: 80000089 (Nzcv daIf -PAN -UAO BTYPE=--)
> > pc : __alloc_pages_nodemask+0xe8/0x338
> > lr : __alloc_pages_nodemask+0xc0/0x338
> > sp : ffffa81540c139b0
> > x29: ffffa81540c139b0 x28: 0000000000000001
> > x27: 0000000000000100 x26: ffffa81540c1ad38
> > x25: 0000000000000000 x24: 0000000000000000
> > x23: ffffa81540c23c00 x22: 0000000000000004
> > x21: 0000000000000002 x20: 0000000000001a00
> > x19: 0000000000000100 x18: 0000000000000010
> > x17: 000000000001f000 x16: 000000000000007f
> > x15: ffffa81540c24070 x14: ffffffffffffffff
> > x13: ffffa815c0c137d7 x12: ffffa81540c137e4
> > x11: ffffa81540c3e000 x10: ffffa81540ecee68
> > x9 : ffffa8153f0f61d8 x8 : ffffa81540ecf000
> > x7 : 0000000000000141 x6 : ffffa81540ecf401
> > x5 : 0000000000000000 x4 : 0000000000000000
> > x3 : 0000000000000000 x2 : 0000000000000000
> > x1 : 0000000000000081 x0 : 0000000000001a00  
> 
> Some of this is not really relevant to the commit log.  The ITS info,
> page fault, some of the backtrace might help people google for this,
> but I think the register dump is overkill.

I'll prune that down.

> 
> > Call trace:
> >  __alloc_pages_nodemask+0xe8/0x338
> >  alloc_pages_node.constprop.0+0x34/0x40
> >  its_probe_one+0x2f8/0xb18
> >  gic_acpi_parse_madt_its+0x108/0x150
> >  acpi_table_parse_entries_array+0x17c/0x264
> >  acpi_table_parse_entries+0x48/0x6c
> >  acpi_table_parse_madt+0x30/0x3c
> >  its_init+0x1c4/0x644
> >  gic_init_bases+0x4b8/0x4ec
> >  gic_acpi_init+0x134/0x264
> >  acpi_match_madt+0x4c/0x84
> >  acpi_table_parse_entries_array+0x17c/0x264
> >  acpi_table_parse_entries+0x48/0x6c
> >  acpi_table_parse_madt+0x30/0x3c
> >  __acpi_probe_device_table+0x8c/0xe8
> >  irqchip_init+0x3c/0x48
> >  init_IRQ+0xcc/0x100
> >  start_kernel+0x33c/0x548
> > 
> > As we die in this case in existing kernels, we can be fairly sure that no one
> > actually has such a firmware in production.  As such this patch avoids the
> > complexity that would be needed to handle this corner case, and simply does
> > not allow the ITS entry parsing code to instantiate new Numa Nodes.  If one
> > is encountered that does not already exist, then NO_NUMA_NODE is assigned
> > and a warning printed just as if the value had been greater than allowed
> > Numa Nodes.  
> 
> Are you saying we won't create a NUMA node based on an SRAT ITS entry?
> Is there something about that in the spec?

Yes to: won't do it.  No to: there being something in the spec.
Right now we crash.  This is a step in a better direction.

From a Linux point of view, the easiest method may be to treat an ITS as a
Generic Initiator.   I think the requirements are the same
(need a memoryless and processor less NUMA domain).

> 
> > "SRAT: Invalid NUMA node -1 in ITS affinity"
> > 
> > I have only tested this for now on our ARM64 Kunpeng920 servers and
> > a range of qemu x86 and arm64 configurations.
> > 
> > Note minor merge issue with Dan William's series [3].  Merge fixes should be
> > straight forward.  
> 
> It's a little hard to figure out what's going on here.  It might help
> if you made a preliminary patch that added your new parameter but
> preserved all existing behavior, then follow up with a second patch
> that makes the real change you need.

Will do.  It may also make sense to do the ITS change as a third patch
as we can then have the information about the crash etc tightly coupled
to the exact change.  I may break it up further to make it easier
to add detail on different cases.

Thanks

Jonathan

> 
> > [1] Note in ACPI Specification 6.3 5.2.16 System Resource Affinity Table (SRAT)
> > [2] https://patchwork.kernel.org/patch/10597777/
> > [3] https://lore.kernel.org/patchwork/cover/1271398/
> > 
> > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > ---
> > 
> > Possible open questions:
> > * should we warn about a broken firmware trying to assign any device
> >   to a non existent Proximity Domain?
> > * previously an smmuv3 in IORT with a Proximity Domain set to a non existent
> >   value would have resulted in a failure to add the device. After this change
> >   it will be added to the default node.  Is that a problem?
> > * for the smmuv3 we print that we have successfully mapped to a node even if
> >   we have not.  Would making this clear be useful?
> >   Perhaps this is a topic for a separate patch.
> > 
> >  Changes since RFC
> >  * Fixed missing parameter in dmar.c
> >  * Tested on some Qemu x86 models so confident enough to drop the RFC.
> > 
> >  arch/arm64/kernel/acpi_numa.c    | 2 +-
> >  arch/ia64/kernel/acpi.c          | 2 +-
> >  arch/x86/mm/srat.c               | 4 ++--
> >  drivers/acpi/arm64/iort.c        | 2 +-
> >  drivers/acpi/nfit/core.c         | 2 +-
> >  drivers/acpi/numa/hmat.c         | 2 +-
> >  drivers/acpi/numa/srat.c         | 8 ++++----
> >  drivers/iommu/intel/dmar.c       | 2 +-
> >  drivers/irqchip/irq-gic-v3-its.c | 7 ++++++-
> >  include/acpi/acpi_numa.h         | 2 +-
> >  include/linux/acpi.h             | 6 +++---
> >  11 files changed, 22 insertions(+), 17 deletions(-)
> > 
> > diff --git a/arch/arm64/kernel/acpi_numa.c b/arch/arm64/kernel/acpi_numa.c
> > index 7ff800045434..6ed47b058d76 100644
> > --- a/arch/arm64/kernel/acpi_numa.c
> > +++ b/arch/arm64/kernel/acpi_numa.c
> > @@ -107,7 +107,7 @@ void __init acpi_numa_gicc_affinity_init(struct acpi_srat_gicc_affinity *pa)
> >  		return;
> >  
> >  	pxm = pa->proximity_domain;
> > -	node = acpi_map_pxm_to_node(pxm);
> > +	node = acpi_map_pxm_to_node(pxm, true);
> >  
> >  	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
> >  		pr_err("SRAT: Too many proximity domains %d\n", pxm);
> > diff --git a/arch/ia64/kernel/acpi.c b/arch/ia64/kernel/acpi.c
> > index a5636524af76..760a468864b7 100644
> > --- a/arch/ia64/kernel/acpi.c
> > +++ b/arch/ia64/kernel/acpi.c
> > @@ -456,7 +456,7 @@ void __init acpi_numa_fixup(void)
> >  	nodes_clear(node_online_map);
> >  	for (i = 0; i < MAX_PXM_DOMAINS; i++) {
> >  		if (pxm_bit_test(i)) {
> > -			int nid = acpi_map_pxm_to_node(i);
> > +			int nid = acpi_map_pxm_to_node(i, true);
> >  			node_set_online(nid);
> >  		}
> >  	}
> > diff --git a/arch/x86/mm/srat.c b/arch/x86/mm/srat.c
> > index dac07e4f5834..6497d7c241ec 100644
> > --- a/arch/x86/mm/srat.c
> > +++ b/arch/x86/mm/srat.c
> > @@ -45,7 +45,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
> >  			 pxm, apic_id);
> >  		return;
> >  	}
> > -	node = acpi_map_pxm_to_node(pxm);
> > +	node = acpi_map_pxm_to_node(pxm, true);
> >  	if (node < 0) {
> >  		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
> >  		bad_srat();
> > @@ -80,7 +80,7 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
> >  	pxm = pa->proximity_domain_lo;
> >  	if (acpi_srat_revision >= 2)
> >  		pxm |= *((unsigned int*)pa->proximity_domain_hi) << 8;
> > -	node = acpi_map_pxm_to_node(pxm);
> > +	node = acpi_map_pxm_to_node(pxm, true);
> >  	if (node < 0) {
> >  		printk(KERN_ERR "SRAT: Too many proximity domains %x\n", pxm);
> >  		bad_srat();
> > diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> > index 28a6b387e80e..8133e7e6f9e3 100644
> > --- a/drivers/acpi/arm64/iort.c
> > +++ b/drivers/acpi/arm64/iort.c
> > @@ -1293,7 +1293,7 @@ static int  __init arm_smmu_v3_set_proximity(struct device *dev,
> >  
> >  	smmu = (struct acpi_iort_smmu_v3 *)node->node_data;
> >  	if (smmu->flags & ACPI_IORT_SMMU_V3_PXM_VALID) {
> > -		int dev_node = acpi_map_pxm_to_node(smmu->pxm);
> > +		int dev_node = acpi_map_pxm_to_node(smmu->pxm, false);
> >  
> >  		if (dev_node != NUMA_NO_NODE && !node_online(dev_node))
> >  			return -EINVAL;
> > diff --git a/drivers/acpi/nfit/core.c b/drivers/acpi/nfit/core.c
> > index 7c138a4edc03..6cb44bbaa71f 100644
> > --- a/drivers/acpi/nfit/core.c
> > +++ b/drivers/acpi/nfit/core.c
> > @@ -2948,7 +2948,7 @@ static int acpi_nfit_register_region(struct acpi_nfit_desc *acpi_desc,
> >  		ndr_desc->numa_node = acpi_map_pxm_to_online_node(
> >  						spa->proximity_domain);
> >  		ndr_desc->target_node = acpi_map_pxm_to_node(
> > -				spa->proximity_domain);
> > +				spa->proximity_domain, false);
> >  	} else {
> >  		ndr_desc->numa_node = NUMA_NO_NODE;
> >  		ndr_desc->target_node = NUMA_NO_NODE;
> > diff --git a/drivers/acpi/numa/hmat.c b/drivers/acpi/numa/hmat.c
> > index 2c32cfb72370..3c0414816772 100644
> > --- a/drivers/acpi/numa/hmat.c
> > +++ b/drivers/acpi/numa/hmat.c
> > @@ -666,7 +666,7 @@ static void hmat_register_target_device(struct memory_target *target,
> >  
> >  	pdev->dev.numa_node = acpi_map_pxm_to_online_node(target->memory_pxm);
> >  	info = (struct memregion_info) {
> > -		.target_node = acpi_map_pxm_to_node(target->memory_pxm),
> > +		.target_node = acpi_map_pxm_to_node(target->memory_pxm, false),
> >  	};
> >  	rc = platform_device_add_data(pdev, &info, sizeof(info));
> >  	if (rc < 0) {
> > diff --git a/drivers/acpi/numa/srat.c b/drivers/acpi/numa/srat.c
> > index 5be5a977da1b..ed7d31795f4d 100644
> > --- a/drivers/acpi/numa/srat.c
> > +++ b/drivers/acpi/numa/srat.c
> > @@ -52,7 +52,7 @@ static void __acpi_map_pxm_to_node(int pxm, int node)
> >  		node_to_pxm_map[node] = pxm;
> >  }
> >  
> > -int acpi_map_pxm_to_node(int pxm)
> > +int acpi_map_pxm_to_node(int pxm, bool create)
> >  {
> >  	int node;
> >  
> > @@ -62,7 +62,7 @@ int acpi_map_pxm_to_node(int pxm)
> >  	node = pxm_to_node_map[pxm];
> >  
> >  	if (node == NUMA_NO_NODE) {
> > -		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES)
> > +		if (nodes_weight(nodes_found_map) >= MAX_NUMNODES || !create)
> >  			return NUMA_NO_NODE;
> >  		node = first_unset_node(nodes_found_map);
> >  		__acpi_map_pxm_to_node(pxm, node);
> > @@ -229,7 +229,7 @@ acpi_numa_memory_affinity_init(struct acpi_srat_mem_affinity *ma)
> >  	if (acpi_srat_revision <= 1)
> >  		pxm &= 0xff;
> >  
> > -	node = acpi_map_pxm_to_node(pxm);
> > +	node = acpi_map_pxm_to_node(pxm, true);
> >  	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
> >  		pr_err("SRAT: Too many proximity domains.\n");
> >  		goto out_err_bad_srat;
> > @@ -444,6 +444,6 @@ int acpi_get_node(acpi_handle handle)
> >  
> >  	pxm = acpi_get_pxm(handle);
> >  
> > -	return acpi_map_pxm_to_node(pxm);
> > +	return acpi_map_pxm_to_node(pxm, false);
> >  }
> >  EXPORT_SYMBOL(acpi_get_node);
> > diff --git a/drivers/iommu/intel/dmar.c b/drivers/iommu/intel/dmar.c
> > index 683b812c5c47..fec90800381e 100644
> > --- a/drivers/iommu/intel/dmar.c
> > +++ b/drivers/iommu/intel/dmar.c
> > @@ -473,7 +473,7 @@ static int dmar_parse_one_rhsa(struct acpi_dmar_header *header, void *arg)
> >  	rhsa = (struct acpi_dmar_rhsa *)header;
> >  	for_each_drhd_unit(drhd) {
> >  		if (drhd->reg_base_addr == rhsa->base_address) {
> > -			int node = acpi_map_pxm_to_node(rhsa->proximity_domain);
> > +			int node = acpi_map_pxm_to_node(rhsa->proximity_domain, false);
> >  
> >  			if (!node_online(node))
> >  				node = NUMA_NO_NODE;
> > diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> > index 6a5a87fc4601..44cb53fa6afe 100644
> > --- a/drivers/irqchip/irq-gic-v3-its.c
> > +++ b/drivers/irqchip/irq-gic-v3-its.c
> > @@ -5248,7 +5248,12 @@ static int __init gic_acpi_parse_srat_its(union acpi_subtable_headers *header,
> >  		return -EINVAL;
> >  	}
> >  
> > -	node = acpi_map_pxm_to_node(its_affinity->proximity_domain);
> > +	/*
> > +	 * Note that in theory a new proximity node could be created by this
> > +	 * entry as it is an SRAT resource allocation structure.
> > +	 * We do not currently support doing so.
> > +	 */
> > +	node = acpi_map_pxm_to_node(its_affinity->proximity_domain, false);
> >  
> >  	if (node == NUMA_NO_NODE || node >= MAX_NUMNODES) {
> >  		pr_err("SRAT: Invalid NUMA node %d in ITS affinity\n", node);
> > diff --git a/include/acpi/acpi_numa.h b/include/acpi/acpi_numa.h
> > index fdebcfc6c8df..6935c7516262 100644
> > --- a/include/acpi/acpi_numa.h
> > +++ b/include/acpi/acpi_numa.h
> > @@ -15,7 +15,7 @@
> >  
> >  extern int pxm_to_node(int);
> >  extern int node_to_pxm(int);
> > -extern int acpi_map_pxm_to_node(int);
> > +extern int acpi_map_pxm_to_node(int, bool);
> >  extern unsigned char acpi_srat_revision;
> >  extern int acpi_numa __initdata;
> >  
> > diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> > index d661cd0ee64d..1414b7e0a486 100644
> > --- a/include/linux/acpi.h
> > +++ b/include/linux/acpi.h
> > @@ -416,7 +416,7 @@ extern void acpi_osi_setup(char *str);
> >  extern bool acpi_osi_is_win8(void);
> >  
> >  #ifdef CONFIG_ACPI_NUMA
> > -int acpi_map_pxm_to_node(int pxm);
> > +int acpi_map_pxm_to_node(int pxm, bool create);
> >  int acpi_get_node(acpi_handle handle);
> >  
> >  /**
> > @@ -436,7 +436,7 @@ int acpi_get_node(acpi_handle handle);
> >   */
> >  static inline int acpi_map_pxm_to_online_node(int pxm)
> >  {
> > -	int node = acpi_map_pxm_to_node(pxm);
> > +	int node = acpi_map_pxm_to_node(pxm, false);
> >  
> >  	return numa_map_to_online_node(node);
> >  }
> > @@ -445,7 +445,7 @@ static inline int acpi_map_pxm_to_online_node(int pxm)
> >  {
> >  	return 0;
> >  }
> > -static inline int acpi_map_pxm_to_node(int pxm)
> > +static inline int acpi_map_pxm_to_node(int pxm, bool create)
> >  {
> >  	return 0;
> >  }
> > -- 
> > 2.19.1
> >   
> 


