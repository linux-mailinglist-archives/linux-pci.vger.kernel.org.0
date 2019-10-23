Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6B6D8E2173
	for <lists+linux-pci@lfdr.de>; Wed, 23 Oct 2019 19:10:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726620AbfJWRKm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 23 Oct 2019 13:10:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:38336 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726589AbfJWRKm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 23 Oct 2019 13:10:42 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A403E2086D;
        Wed, 23 Oct 2019 17:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571850640;
        bh=6VlhDLDQ6Z3w9QbsBW1qts+NF31RU0o3S2U2reNH0jw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=0apF5PPqM/gOAU+pWEKp3CM+5ENSrgaRJlot9DsNkNE9N6hxdPG1w6+k5zrvyDUH2
         8164s2Rgbaw9d6FFjq3pzUcwRHba55me0SYX548JFTQvyjlzkEcFvOkBghbH1hF2nx
         TYYjeUpEw1on1dStHFylaFRqzjouge3u3A6FeaIs=
Date:   Wed, 23 Oct 2019 12:10:39 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, peterz@infradead.org, robin.murphy@arm.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        paul.burton@mips.com
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
Message-ID: <20191023171039.GA173290@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76d37d5b-49bd-e45c-d42c-415235504893@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Oct 23, 2019 at 04:22:43PM +0800, Yunsheng Lin wrote:
> On 2019/10/23 5:04, Bjorn Helgaas wrote:
> > On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:

> > I think the underlying problem you're addressing is that:
> > 
> >   - NUMA_NO_NODE == -1,
> >   - dev_to_node(dev) may return NUMA_NO_NODE,
> >   - kmalloc(dev) relies on cpumask_of_node(dev_to_node(dev)), and
> >   - cpumask_of_node(NUMA_NO_NODE) makes an invalid array reference
> > 
> > For example, on arm64, mips loongson, s390, and x86,
> > cpumask_of_node(node) returns "node_to_cpumask_map[node]", and -1 is
> > an invalid array index.
> 
> The invalid array index of -1 is the underlying problem here when
> cpumask_of_node(dev_to_node(dev)) is called and cpumask_of_node()
> is not NUMA_NO_NODE aware yet.
> 
> In the "numa: make node_to_cpumask_map() NUMA_NO_NODE aware" thread
> disscusion, it is requested that it is better to warn about the pcie
> device without a node assigned by the firmware before making the
> cpumask_of_node() NUMA_NO_NODE aware, so that the system with pci
> devices of "NUMA_NO_NODE" node can be fixed by their vendor.
> 
> See: https://lore.kernel.org/lkml/20191011111539.GX2311@hirez.programming.kicks-ass.net/

Right.  We should warn if the NUMA node number would help us but DT or
the firmware didn't give us one.

But we can do that independently of any cpumask_of_node() changes.
There's no need to do one patch before the other.  Even if you make
cpumask_of_node() tolerate NUMA_NO_NODE, we'll still get the warning
because we're not actually changing any node assignments.

> So maybe change the warning to below:
> 
> if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
> 	dev_err(&bus->dev, FW_BUG "No node assigned on NUMA capable HW. Please contact your vendor for updates.\n");

I think this is perfect and I don't see the need for the refinement
below:

> And it seems a pci device's parent will always set to the bridge
> device in pci_setup_device(), and device_add() which will set the
> node to its parent's when the child device' node is NUMA_NO_NODE,
> maybe we can add the bridge device' node checking to make sure
> the pci device really does not have a node assigned, as below:
> 
> if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE &&
>     dev_to_node(bus->bridge) == NUMA_NO_NODE)
> 	dev_err(&bus->dev, FW_BUG "No node assigned on NUMA capable HW. Please contact your vendor for updates.\n");

Anyway, would the attached patch work for you?  I have it tentatively
queued up on pci/enumeration for v5.5.

> >> It is possible to
> >> have a PCI bridge shared between two nodes, such that the PCI
> >> devices have equidistance. But the moment you scale this out, you
> >> either get devices that are 'local' to a package while having
> >> multiple packages, or if you maintain a single bridge in a big
> >> system, things become so slow it all doesn't matter anyway.
> >> Assigning a node (one of the shared) is, in the generic ase of
> >> multiple packages, the better solution over assigning all nodes.
> >>
> >> As pci_device_add() will assign the pci device' node according to
> >> the bus the device is on, which is decided by pcibus_to_node().
> >> Currently different arch may implement the pcibus_to_node() based
> >> on bus->sysdata or bus device' node, which has the same node as
> >> the bridge device.
> >>
> >> And for devices behind another bridge case, the child bus device
> >> is setup with proper parent bus device and inherit its parent'
> >> sysdata in pci_alloc_child_bus(), so the pcie device under the
> >> child bus should have the same node as the parent bridge when
> >> device_add() is called, which will set the node to its parent's
> >> node when the child device' node is NUMA_NO_NODE.
> >>
> >> So this patch only warns about the case when a host bridge device
> >> is registered with a node of NO_NODE in pci_register_host_bridge().
> >> And it only warns about that when there are more than one numa
> >> nodes in the system.
> > 
> > 
> >> [1] https://lore.kernel.org/lkml/1568724534-146242-1-git-send-email-linyunsheng@huawei.com/
> >>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >> ---
> >>  drivers/pci/probe.c | 3 +++
> >>  1 file changed, 3 insertions(+)
> >>
> >> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> >> index 3d5271a..22be96a 100644
> >> --- a/drivers/pci/probe.c
> >> +++ b/drivers/pci/probe.c
> >> @@ -927,6 +927,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
> >>  	list_add_tail(&bus->node, &pci_root_buses);
> >>  	up_write(&pci_bus_sem);
> >>  
> >> +	if (nr_node_ids > 1 && dev_to_node(bus->bridge) == NUMA_NO_NODE)
> >> +		dev_err(bus->bridge, FW_BUG "No node assigned on NUMA capable HW by BIOS. Please contact your vendor for updates.\n");
> >> +
> >>  	return 0;
> >>  
> >>  unregister:

commit 8f8cf239c4f1
Author: Yunsheng Lin <linyunsheng@huawei.com>
Date:   Sat Oct 19 14:45:43 2019 +0800

    PCI: Warn if no host bridge NUMA node info
    
    In pci_call_probe(), we try to run driver probe functions on the node where
    the device is attached.  If we don't know which node the device is attached
    to, the driver will likely run on the wrong node.  This will still work,
    but performance will not be as good as it could be.
    
    On NUMA systems, warn if we don't know which node a PCI host bridge is
    attached to.  This is likely an indication that ACPI didn't supply a _PXM
    method or the DT didn't supply a "numa-node-id" property.
    
    [bhelgaas: commit log, check bus node]
    Link: https://lore.kernel.org/r/1571467543-26125-1-git-send-email-linyunsheng@huawei.com
    Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
    Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3d5271a7a849..40259c38d66a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -897,6 +897,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	else
 		pr_info("PCI host bridge to bus %s\n", name);
 
+	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
+		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
+
 	/* Add initial resources to the bus */
 	resource_list_for_each_entry_safe(window, n, &resources) {
 		list_move_tail(&window->node, &bridge->windows);
