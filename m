Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C66A138C16
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 07:56:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726976AbgAMG4G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 01:56:06 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:8703 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725954AbgAMG4G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 01:56:06 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id D7879CAE519F964D4FCA;
        Mon, 13 Jan 2020 14:56:04 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS401-HUB.china.huawei.com (10.3.19.201) with Microsoft SMTP Server id
 14.3.439.0; Mon, 13 Jan 2020 14:55:55 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <bhelgaas@google.com>, <lukas@wunner.de>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guohanjun@huawei.com>, <huawei.libin@huawei.com>,
        <lvying6@huawei.com>, <wangxiongfeng2@huawei.com>
Subject: [PATCH] PCI: get 'pci_ops' from the host bridge when we alloc new bus
Date:   Mon, 13 Jan 2020 14:51:11 +0800
Message-ID: <1578898271-46060-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When I test 'aer-inject' with the following procedures:
1. inject a fatal error into a upstream PCI bridge
2. remove the upstream bridge by sysfs
3. rescan the PCI tree by 'echo 1 > /sys/bus/pci/rescan'
4. execute command 'rmmod aer-inject'
5. remove the upstream bridge by sysfs again

I came across the following Oops.

[  799.713238] Internal error: Oops: 96000007 [#1] SMP
[  799.718099] Process bash (pid: 10683, stack limit = 0x00000000125a3b1b)
[  799.724686] CPU: 108 PID: 10683 Comm: bash Kdump: loaded Not tainted 4.19.36 #2
[  799.731962] Hardware name: Huawei TaiShan 2280 V2/BC82AMDD, BIOS 1.05 09/18/2019
[  799.739325] pstate: 40400009 (nZcv daif +PAN -UAO)
[  799.744104] pc : pci_remove_bus+0xc0/0x1c0
[  799.748182] lr : pci_remove_bus+0x94/0x1c0
[  799.752260] sp : ffffa02e335df940
[  799.755560] x29: ffffa02e335df940 x28: ffff2000088216a8
[  799.760849] x27: 1ffff405c66bbfbc x26: ffff20000a9518c0
[  799.766139] x25: ffffa02dea6ec418 x24: 1ffff405bd4dd883
[  799.771427] x23: ffffa02e72576628 x22: 1ffff405ce4aecc0
[  799.776715] x21: ffffa02e72576608 x20: ffff200002e75080
[  799.782003] x19: ffffa02e72576600 x18: 0000000000000000
[  799.787291] x17: 0000000000000000 x16: 0000000000000000
[  799.792578] x15: 0000000000000001 x14: dfff200000000000
[  799.797866] x13: ffff20000a6dfaf0 x12: 0000000000000000
[  799.803154] x11: 1fffe4000159b217 x10: ffff04000159b217
[  799.808442] x9 : dfff200000000000 x8 : ffff20000acd90bf
[  799.813730] x7 : 0000000000000000 x6 : 0000000000000000
[  799.819017] x5 : 0000000000000001 x4 : 0000000000000000
[  799.824306] x3 : 1ffff405dbe62603 x2 : 1fffe400005cea11
[  799.829593] x1 : dfff200000000000 x0 : ffff200002e75088
[  799.834882] Call trace:
[  799.837323]  pci_remove_bus+0xc0/0x1c0
[  799.841056]  pci_remove_bus_device+0xd0/0x2f0
[  799.845392]  pci_stop_and_remove_bus_device_locked+0x2c/0x40
[  799.851028]  remove_store+0x1b8/0x1d0
[  799.854679]  dev_attr_store+0x60/0x80
[  799.858330]  sysfs_kf_write+0x104/0x170
[  799.862149]  kernfs_fop_write+0x23c/0x430
[  799.866143]  __vfs_write+0xec/0x4e0
[  799.869615]  vfs_write+0x12c/0x3d0
[  799.873001]  ksys_write+0xd0/0x190
[  799.876389]  __arm64_sys_write+0x70/0xa0
[  799.880298]  el0_svc_common+0xfc/0x278
[  799.884030]  el0_svc_handler+0x50/0xc0
[  799.887764]  el0_svc+0x8/0xc
[  799.890634] Code: d2c40001 f2fbffe1 91002280 d343fc02 (38e16841)
[  799.896700] kernel fault(0x1) notification starting on CPU 108

It is because when we alloc a new bus in rescanning process, the
'pci_ops' of the newly allocced 'pci_bus' is inherited from its parent
pci bus. Whereas, the 'pci_ops' of the parent bus may be changed to
'aer_inj_pci_ops' in 'aer_inject()'. When we unload the module
'aer_inject', we only restore the 'pci_ops' for the pci bus of the
error-injected device and the root port in 'aer_inject_exit'. After we
have unloaded the module, the 'pci_ops' of the newly allocced pci bus is
still 'aer_inj_pci_ops'. When we access it, an Oops happened.

This patch modify the code to get the 'pci_ops' from the host bridge
rather than the parent pci bus when we alloc a new pci bus.

Signed-off-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
---
 drivers/pci/probe.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 512cb43..b0021f9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -985,7 +985,8 @@ static bool pci_bridge_child_ext_cfg_accessible(struct pci_dev *bridge)
 static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 					   struct pci_dev *bridge, int busnr)
 {
-	struct pci_bus *child;
+	struct pci_bus *child, *root_bus;
+	struct pci_host_bridge *host_bridge;
 	int i;
 	int ret;
 
@@ -994,8 +995,17 @@ static struct pci_bus *pci_alloc_child_bus(struct pci_bus *parent,
 	if (!child)
 		return NULL;
 
+	/*
+	 * get 'pci_ops' from the host bridge, because 'parent->ops' may be
+	 * modified in 'aer_inject'.
+	 */
+	root_bus = parent;
+	while (root_bus->parent)
+		root_bus = root_bus->parent;
+	host_bridge = to_pci_host_bridge(root_bus->bridge);
+	child->ops = host_bridge->ops;
+
 	child->parent = parent;
-	child->ops = parent->ops;
 	child->msi = parent->msi;
 	child->sysdata = parent->sysdata;
 	child->bus_flags = parent->bus_flags;
-- 
1.7.12.4

