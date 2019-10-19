Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97C27DD6FD
	for <lists+linux-pci@lfdr.de>; Sat, 19 Oct 2019 08:49:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbfJSGsk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 19 Oct 2019 02:48:40 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:53114 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726939AbfJSGsk (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 19 Oct 2019 02:48:40 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 32D2A64B5132D11857F5;
        Sat, 19 Oct 2019 14:48:37 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.439.0; Sat, 19 Oct 2019 14:48:34 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mhocko@kernel.org>, <peterz@infradead.org>,
        <robin.murphy@arm.com>, <geert@linux-m68k.org>,
        <gregkh@linuxfoundation.org>, <paul.burton@mips.com>
Subject: [PATCH] PCI: Warn about host bridge device when its numa node is NO_NODE
Date:   Sat, 19 Oct 2019 14:45:43 +0800
Message-ID: <1571467543-26125-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

As the disscusion in [1]:
A PCI device really _MUST_ have a node assigned. It is possible to
have a PCI bridge shared between two nodes, such that the PCI
devices have equidistance. But the moment you scale this out, you
either get devices that are 'local' to a package while having
multiple packages, or if you maintain a single bridge in a big
system, things become so slow it all doesn't matter anyway.
Assigning a node (one of the shared) is, in the generic ase of
multiple packages, the better solution over assigning all nodes.

As pci_device_add() will assign the pci device' node according to
the bus the device is on, which is decided by pcibus_to_node().
Currently different arch may implement the pcibus_to_node() based
on bus->sysdata or bus device' node, which has the same node as
the bridge device.

And for devices behind another bridge case, the child bus device
is setup with proper parent bus device and inherit its parent'
sysdata in pci_alloc_child_bus(), so the pcie device under the
child bus should have the same node as the parent bridge when
device_add() is called, which will set the node to its parent's
node when the child device' node is NUMA_NO_NODE.

So this patch only warns about the case when a host bridge device
is registered with a node of NO_NODE in pci_register_host_bridge().
And it only warns about that when there are more than one numa
nodes in the system.

[1] https://lore.kernel.org/lkml/1568724534-146242-1-git-send-email-linyunsheng@huawei.com/

Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
 drivers/pci/probe.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 3d5271a..22be96a 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -927,6 +927,9 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
 	list_add_tail(&bus->node, &pci_root_buses);
 	up_write(&pci_bus_sem);
 
+	if (nr_node_ids > 1 && dev_to_node(bus->bridge) == NUMA_NO_NODE)
+		dev_err(bus->bridge, FW_BUG "No node assigned on NUMA capable HW by BIOS. Please contact your vendor for updates.\n");
+
 	return 0;
 
 unregister:
-- 
2.8.1

