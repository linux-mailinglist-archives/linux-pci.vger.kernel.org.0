Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8005DE0DA0
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2019 23:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732160AbfJVVEZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Oct 2019 17:04:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:44782 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725874AbfJVVEY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 22 Oct 2019 17:04:24 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E461720B7C;
        Tue, 22 Oct 2019 21:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1571778263;
        bh=WLy5g3MOjMOPK8irCkIp5jydSqdpsh998LqZ43NOmYE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=NgzQw/bJRQ2kRpQYL2X3+n5ZxmiWQkVGfqCuhf3H40IGH/BAzGtFfpm8cPv7oEAX5
         rqwBXV2TZxeywmjgkchR6sS6Zvk1K7Yu5AwaPfDOVU9W3M1n0T6B5adG9fPjihaANa
         cBlowmZv197efP+xUyWp0+vqbhma+FpBhp5LJ/i0=
Date:   Tue, 22 Oct 2019 16:04:20 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mhocko@kernel.org, peterz@infradead.org, robin.murphy@arm.com,
        geert@linux-m68k.org, gregkh@linuxfoundation.org,
        paul.burton@mips.com
Subject: Re: [PATCH] PCI: Warn about host bridge device when its numa node is
 NO_NODE
Message-ID: <20191022210420.GA17717@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1571467543-26125-1-git-send-email-linyunsheng@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Sat, Oct 19, 2019 at 02:45:43PM +0800, Yunsheng Lin wrote:
> As the disscusion in [1]:

We need to justify this patch right here in the commit log, not with a
pointer to a 50+ message email thread.

> A PCI device really _MUST_ have a node assigned. 

No, it's not really essential.  It's *nice* if we know the node
closest to a PCI device, but the system should function correctly even
if we don't.  The only problem is that it will be slower.

I think the underlying problem you're addressing is that:

  - NUMA_NO_NODE == -1,
  - dev_to_node(dev) may return NUMA_NO_NODE,
  - kmalloc(dev) relies on cpumask_of_node(dev_to_node(dev)), and
  - cpumask_of_node(NUMA_NO_NODE) makes an invalid array reference

For example, on arm64, mips loongson, s390, and x86,
cpumask_of_node(node) returns "node_to_cpumask_map[node]", and -1 is
an invalid array index.

That problem can't be solved by emitting a warning, of course.  I
assume some variation of your "numa: make node_to_cpumask_map()
NUMA_NO_NODE aware" patch [a] will solve that problem.

[a] https://lore.kernel.org/linux-mips/1568535656-158979-1-git-send-email-linyunsheng@huawei.com/T/#u

It is probably a good idea to emit a warning about the performance
issue.

When I run your patch on qemu, I see this:

  ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-ff])
  acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments MSI HPX-Type3]
  acpi PNP0A08:00: _OSC: platform does not support [LTR]
  acpi PNP0A08:00: _OSC: OS now controls [PME AER PCIeCapability]
  PCI host bridge to bus 0000:00
  pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
  pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
  pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
  pci_bus 0000:00: root bus resource [mem 0xc0000000-0xfebfffff window]
  pci_bus 0000:00: root bus resource [mem 0x100000000-0x8ffffffff window]
  pci_bus 0000:00: root bus resource [bus 00-ff]
   pci0000:00: [Firmware Bug]: No node assigned on NUMA capable HW by BIOS. Please contact your vendor for updates.

I didn't debug it to see what's wrong with the " pci0000:00" string.
Ideally it would be connected with "acpi PNP0A08:00" since that's the
place where BIOS would make a fix but I suppose "pci_bus 0000:00"
would be adequate.

> It is possible to
> have a PCI bridge shared between two nodes, such that the PCI
> devices have equidistance. But the moment you scale this out, you
> either get devices that are 'local' to a package while having
> multiple packages, or if you maintain a single bridge in a big
> system, things become so slow it all doesn't matter anyway.
> Assigning a node (one of the shared) is, in the generic ase of
> multiple packages, the better solution over assigning all nodes.
> 
> As pci_device_add() will assign the pci device' node according to
> the bus the device is on, which is decided by pcibus_to_node().
> Currently different arch may implement the pcibus_to_node() based
> on bus->sysdata or bus device' node, which has the same node as
> the bridge device.
>
> And for devices behind another bridge case, the child bus device
> is setup with proper parent bus device and inherit its parent'
> sysdata in pci_alloc_child_bus(), so the pcie device under the
> child bus should have the same node as the parent bridge when
> device_add() is called, which will set the node to its parent's
> node when the child device' node is NUMA_NO_NODE.
> 
> So this patch only warns about the case when a host bridge device
> is registered with a node of NO_NODE in pci_register_host_bridge().
> And it only warns about that when there are more than one numa
> nodes in the system.


> [1] https://lore.kernel.org/lkml/1568724534-146242-1-git-send-email-linyunsheng@huawei.com/
> 
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---
>  drivers/pci/probe.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 3d5271a..22be96a 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -927,6 +927,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	list_add_tail(&bus->node, &pci_root_buses);
>  	up_write(&pci_bus_sem);
>  
> +	if (nr_node_ids > 1 && dev_to_node(bus->bridge) == NUMA_NO_NODE)
> +		dev_err(bus->bridge, FW_BUG "No node assigned on NUMA capable HW by BIOS. Please contact your vendor for updates.\n");
> +
>  	return 0;
>  
>  unregister:
