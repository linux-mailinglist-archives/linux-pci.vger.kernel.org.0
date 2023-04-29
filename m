Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3B256F24DB
	for <lists+linux-pci@lfdr.de>; Sat, 29 Apr 2023 15:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbjD2Ndi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Apr 2023 09:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjD2Ndh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 29 Apr 2023 09:33:37 -0400
X-Greylist: delayed 391 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Apr 2023 06:33:33 PDT
Received: from mail-m11876.qiye.163.com (mail-m11876.qiye.163.com [115.236.118.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A750198A;
        Sat, 29 Apr 2023 06:33:33 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:3271:1d90:5cf2:8ef5:1dc9:a429])
        by mail-m11876.qiye.163.com (Hmail) with ESMTPA id AC06E3C0380;
        Sat, 29 Apr 2023 21:26:58 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     bhelgaas@google.com
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com,
        david.e.box@linux.intel.com, kai.heng.feng@canonical.com,
        michael.a.bottini@linux.intel.com, rajatja@google.com,
        qinzongquan@sangfor.com.cn, dinghui@sangfor.com.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/ASPM: fix UAF by removing cached downstream
Date:   Sat, 29 Apr 2023 21:26:04 +0800
Message-Id: <20230429132604.31853-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSE9LVkhIGkhMQhgfGBhKQlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTEpBSh9CS0FOGB1JQUMeHU5BSh8YQkEaT0lCWVdZFhoPEhUdFF
        lBWU9LSFVKSktISkxVSktLVUtZBg++
X-HM-Tid: 0a87cd3200ba2eb2kusnac06e3c0380
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAw6Chw4ND0JQ0w3M04ZKQsj
        HT4KCjVVSlVKTUNJTExPQ0pCTklCVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxKQUofQktBThgdSUFDHh1OQUofGEJBGk9JQllXWQgBWUFKS0NOSzcG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the function 0 of a multifunction device is removed, an freed
downstream pointer will be left in struct pcie_link_state, and then
when pcie_config_aspm_link() be invoked from any path, we will get a
KASAN use-after-free report.

Reproducer:

  [root@host ~]# cat repro.sh
  #!/bin/bash
  DEV_F0="0000:03:00.0"
  echo 1 > /sys/bus/pci/devices/$DEV_F0/remove
  echo powersave > /sys/module/pcie_aspm/parameters/policy

Result:

[  177.433490] ==================================================================
[  177.433814] BUG: KASAN: slab-use-after-free in pcie_config_aspm_link+0x42d/0x500
[  177.434114] Read of size 4 at addr ffff8881070c80a0 by task repro.sh/2056

[  177.434747] CPU: 3 PID: 2056 Comm: repro.sh Not tainted 6.3.0+ #15
[  177.435062] Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
[  177.435379] Call Trace:
[  177.435741]  <TASK>
[  177.436058]  dump_stack_lvl+0x33/0x50
[  177.436379]  print_address_description.constprop.0+0x27/0x310
[  177.436733]  print_report+0x3e/0x70
[  177.437067]  ? pcie_config_aspm_link+0x42d/0x500
[  177.437398]  kasan_report+0xae/0xe0
[  177.437753]  ? pcie_config_aspm_link+0x42d/0x500
[  177.438115]  pcie_config_aspm_link+0x42d/0x500
[  177.438447]  pcie_aspm_set_policy+0x8e/0x1a0
[  177.438862]  param_attr_store+0x162/0x2c0
[  177.439217]  ? __pfx_sysfs_kf_write+0x10/0x10
[  177.439571]  module_attr_store+0x3e/0x80
[  177.439898]  kernfs_fop_write_iter+0x2d5/0x460
[  177.440218]  vfs_write+0x72e/0xae0
[  177.440552]  ? __pfx_vfs_write+0x10/0x10
[  177.440866]  ? __count_memcg_events+0xea/0x1d0
[  177.441173]  ksys_write+0xed/0x1c0
[  177.441519]  ? __pfx_ksys_write+0x10/0x10
[  177.441874]  do_syscall_64+0x38/0x90
[  177.442202]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  177.442547] RIP: 0033:0x7f0829a622c7
[  177.442922] Code: 0e 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f 1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 48 89 54 24 18 48 89 74 24
[  177.443721] RSP: 002b:00007ffc6bb2d128 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  177.444151] RAX: ffffffffffffffda RBX: 000000000000000a RCX: 00007f0829a622c7
[  177.444572] RDX: 000000000000000a RSI: 000055b8e6b168f0 RDI: 0000000000000001
[  177.445049] RBP: 000055b8e6b168f0 R08: 00007f0829b12000 R09: 00007f0829b12080
[  177.445490] R10: 00007f0829b11f80 R11: 0000000000000246 R12: 000000000000000a
[  177.445984] R13: 00007f0829b535a0 R14: 000000000000000a R15: 00007f0829b53780
[  177.446443]  </TASK>

[  177.447402] Allocated by task 1:
[  177.447902]  kasan_save_stack+0x1e/0x40
[  177.448444]  kasan_set_track+0x21/0x30
[  177.448946]  __kasan_kmalloc+0x7b/0x90
[  177.449447]  pci_alloc_dev+0x44/0x260
[  177.449950]  pci_scan_single_device+0x132/0x280
[  177.450467]  pci_scan_slot+0x193/0x510
[  177.450986]  pci_scan_child_bus_extend+0x61/0x5d0
[  177.451528]  pci_scan_bridge_extend+0xc4c/0x10c0
[  177.452021]  pci_scan_child_bus_extend+0x332/0x5d0
[  177.452539]  acpi_pci_root_create+0x4ec/0x700
[  177.453015]  pci_acpi_scan_root+0x3ad/0x4e0
[  177.453495]  acpi_pci_root_add+0x3f2/0x910
[  177.453973]  acpi_bus_attach+0x38b/0x890
[  177.454415]  device_for_each_child+0xd8/0x150
[  177.454896]  acpi_dev_for_each_child+0x77/0xa0
[  177.455328]  acpi_bus_attach+0x19f/0x890
[  177.455785]  device_for_each_child+0xd8/0x150
[  177.456189]  acpi_dev_for_each_child+0x77/0xa0
[  177.456626]  acpi_bus_attach+0x19f/0x890
[  177.457077]  acpi_bus_scan+0x98/0x160
[  177.457481]  acpi_scan_init+0x1e3/0x3f0
[  177.457905]  acpi_init+0xff/0x2c0
[  177.458300]  do_one_initcall+0x87/0x300
[  177.458694]  do_initcalls+0x127/0x260
[  177.459113]  kernel_init_freeable+0x811/0xc80
[  177.459517]  kernel_init+0x1b/0x1e0
[  177.459915]  ret_from_fork+0x29/0x50

[  177.460724] Freed by task 2011:
[  177.461119]  kasan_save_stack+0x1e/0x40
[  177.461556]  kasan_set_track+0x21/0x30
[  177.461939]  kasan_save_free_info+0x2a/0x50
[  177.462320]  __kasan_slab_free+0x106/0x190
[  177.462737]  __kmem_cache_free+0x133/0x270
[  177.463115]  device_release+0x98/0x210
[  177.463492]  kobject_cleanup+0x101/0x360
[  177.463952]  pci_stop_and_remove_bus_device_locked+0xdb/0x110
[  177.464341]  remove_store+0xcf/0xe0
[  177.464746]  kernfs_fop_write_iter+0x2d5/0x460
[  177.465112]  vfs_write+0x72e/0xae0
[  177.465493]  ksys_write+0xed/0x1c0
[  177.465834]  do_syscall_64+0x38/0x90
[  177.466174]  entry_SYSCALL_64_after_hwframe+0x72/0xdc

This patch is based on original RFC by Bolarinwa O. Saheed in 2021 [1],
which using pci_function_0() to obtain child instead of cached
downstream pointer in struct pcie_link_state.

In addition, I added the condition about child to avoid dereference
null pointer, in case the device is removed without rescan back.

[1] https://lore.kernel.org/lkml/20211106175503.27178-5-refactormyself@gmail.com/

--------

The commit log of original patch:

Information on the downstream component is cached in
struct pcie_link_state.downstream it obtained within
alloc_pcie_link_state() by calling pci_function_0()

 - remove *downstream* from the struct pcie_link_state.
 - replaces references to pcie_link_state.downstream with
   a call to pci_function_0(pdev->subordinate).

Originally-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
Fixes: b5a0a9b59c81 ("PCI/ASPM: Read and set up L1 substate capabilities")
Debugged-by: Zongquan Qin <qinzongquan@sangfor.com.cn>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/pci/pcie/aspm.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 66d7514ca111..bca3f52009fe 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -44,7 +44,6 @@
 
 struct pcie_link_state {
 	struct pci_dev *pdev;		/* Upstream component of the Link */
-	struct pci_dev *downstream;	/* Downstream component, function 0 */
 	struct pcie_link_state *root;	/* pointer to the root port link */
 	struct pcie_link_state *parent;	/* pointer to the parent Link state */
 	struct list_head sibling;	/* node in link_list */
@@ -474,7 +473,8 @@ static void pci_clear_and_set_dword(struct pci_dev *pdev, int pos,
 static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 				u32 parent_l1ss_cap, u32 child_l1ss_cap)
 {
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	u32 val1, val2, scale1, scale2;
 	u32 t_common_mode, t_power_on, l1_2_threshold, scale, value;
 	u32 ctl1 = 0, ctl2 = 0;
@@ -484,6 +484,9 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 	if (!(link->aspm_support & ASPM_STATE_L1_2_MASK))
 		return;
 
+	if (!child)
+		return;
+
 	/* Choose the greater of the two Port Common_Mode_Restore_Times */
 	val1 = (parent_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
 	val2 = (child_l1ss_cap & PCI_L1SS_CAP_CM_RESTORE_TIME) >> 8;
@@ -565,11 +568,12 @@ static void aspm_calc_l1ss_info(struct pcie_link_state *link,
 
 static void aspm_l1ss_init(struct pcie_link_state *link)
 {
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	u32 parent_l1ss_cap, child_l1ss_cap;
 	u32 parent_l1ss_ctl1 = 0, child_l1ss_ctl1 = 0;
 
-	if (!parent->l1ss || !child->l1ss)
+	if (!parent->l1ss || !child || !child->l1ss)
 		return;
 
 	/* Setup L1 substate */
@@ -622,7 +626,8 @@ static void aspm_l1ss_init(struct pcie_link_state *link)
 
 static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 {
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	u32 parent_lnkcap, child_lnkcap;
 	u16 parent_lnkctl, child_lnkctl;
 	struct pci_bus *linkbus = parent->subordinate;
@@ -634,6 +639,9 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 		return;
 	}
 
+	if (!child)
+		return;
+
 	/*
 	 * If ASPM not supported, don't mess with the clocks and link,
 	 * bail out now.
@@ -701,7 +709,11 @@ static void pcie_aspm_cap_init(struct pcie_link_state *link, int blacklist)
 static void pcie_config_aspm_l1ss(struct pcie_link_state *link, u32 state)
 {
 	u32 val, enable_req;
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
+
+	if (!child)
+		return;
 
 	enable_req = (link->aspm_enabled ^ state) & state;
 
@@ -760,9 +772,13 @@ static void pcie_config_aspm_dev(struct pci_dev *pdev, u32 val)
 static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
 {
 	u32 upstream = 0, dwstream = 0;
-	struct pci_dev *child = link->downstream, *parent = link->pdev;
+	struct pci_dev *parent = link->pdev;
+	struct pci_dev *child = pci_function_0(link->pdev->subordinate);
 	struct pci_bus *linkbus = parent->subordinate;
 
+	if (!child)
+		return;
+
 	/* Enable only the states that were not explicitly disabled */
 	state &= (link->aspm_capable & ~link->aspm_disable);
 
@@ -867,7 +883,6 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
 
 	INIT_LIST_HEAD(&link->sibling);
 	link->pdev = pdev;
-	link->downstream = pci_function_0(pdev->subordinate);
 
 	/*
 	 * Root Ports and PCI/PCI-X to PCIe Bridges are roots of PCIe
-- 
2.17.1

