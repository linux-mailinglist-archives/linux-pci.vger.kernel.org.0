Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAAA6F96BB
	for <lists+linux-pci@lfdr.de>; Sun,  7 May 2023 05:41:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229551AbjEGDlo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 6 May 2023 23:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjEGDlm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 6 May 2023 23:41:42 -0400
Received: from mail-m127104.qiye.163.com (mail-m127104.qiye.163.com [115.236.127.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BE9132BE;
        Sat,  6 May 2023 20:41:39 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:3277:3e50:d9d7:3dc:49c3:c0bf])
        by mail-m127104.qiye.163.com (Hmail) with ESMTPA id A44EFA40198;
        Sun,  7 May 2023 11:41:34 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     bhelgaas@google.com
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com,
        david.e.box@linux.intel.com, kai.heng.feng@canonical.com,
        michael.a.bottini@linux.intel.com, rajatja@google.com,
        refactormyself@gmail.com, qinzongquan@sangfor.com.cn,
        dinghui@sangfor.com.cn, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/ASPM: Fix UAF by disabling ASPM for link when child function is removed
Date:   Sun,  7 May 2023 11:40:57 +0800
Message-Id: <20230507034057.20970-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSE5LVktLH0IfSkpDHUMeS1UTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTExBSB5OS0EfQh9MQUgfGEFPQhhIQRhLGR1ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tVS1kG
X-HM-Tid: 0a87f44cee36b282kuuua44efa40198
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46Vhw5Hj0OTjJJGD0ZKA4L
        HUwaFFFVSlVKTUNIT0hLQ0JOTUpIVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUxMQUgeTktBH0IfTEFIHxhBT0IYSEEYSxkdWVdZCAFZQU9NTU43Bg++
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the Function 0 of a Multi-Function device is software removed,
a freed downstream pointer will be left in struct pcie_link_state,
and then when pcie_config_aspm_link() be invoked from any path,
we will trigger use-after-free, e.g.:

Reproducer:

  [root@host ~]# cat repro.sh
  #!/bin/bash
  DEV_F0="0000:03:00.0"
  echo 1 > /sys/bus/pci/devices/$DEV_F0/remove
  echo powersave > /sys/module/pcie_aspm/parameters/policy

Result:

  ==================================================================
  BUG: KASAN: slab-use-after-free in pcie_config_aspm_link+0x42d/0x500
  Read of size 4 at addr ffff8881070c80a0 by task repro.sh/2056
  CPU: 3 PID: 2056 Comm: repro.sh Not tainted 6.3.0+ #15
  Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
  Call Trace:
   <TASK>
   dump_stack_lvl+0x33/0x50
   print_address_description.constprop.0+0x27/0x310
   print_report+0x3e/0x70
   kasan_report+0xae/0xe0
   pcie_config_aspm_link+0x42d/0x500
   pcie_aspm_set_policy+0x8e/0x1a0
   param_attr_store+0x162/0x2c0
   module_attr_store+0x3e/0x80
   kernfs_fop_write_iter+0x2d5/0x460
   vfs_write+0x72e/0xae0
   ksys_write+0xed/0x1c0
   do_syscall_64+0x38/0x90
   entry_SYSCALL_64_after_hwframe+0x72/0xdc

As per PCIe spec r6.0, sec 7.5.3.7, it is recommended that software
program the same value in all Functions for Multi-Function Devices
(including ARI Devices). For ARI Devices, ASPM Control is determined
solely by the setting in Function 0.

So we can just disable ASPM of the whole component if any child
function is removed, the downstream pointer will be avoided from
use-after-free, that will also avoid other potential corner cases.

Fixes: b5a0a9b59c81 ("PCI/ASPM: Read and set up L1 substate capabilities")
Debugged-by: Zongquan Qin <qinzongquan@sangfor.com.cn>
Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
v2:
  - better commit title and message
  - update comment
  - add reproduction steps

v1: https://lore.kernel.org/lkml/20230504123418.4438-1-dinghui@sangfor.com.cn/

Link: https://lore.kernel.org/lkml/20230429132604.31853-1-dinghui@sangfor.com.cn/

---
 drivers/pci/pcie/aspm.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 66d7514ca111..06152cc39fea 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1010,18 +1010,15 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
 	down_read(&pci_bus_sem);
 	mutex_lock(&aspm_lock);
-	/*
-	 * All PCIe functions are in one slot, remove one function will remove
-	 * the whole slot, so just wait until we are the last function left.
-	 */
-	if (!list_empty(&parent->subordinate->devices))
-		goto out;
 
 	link = parent->link_state;
 	root = link->root;
 	parent_link = link->parent;
 
-	/* All functions are removed, so just disable ASPM for the link */
+	/*
+	 * For any function removed, disable ASPM for the link. See PCIe r6.0,
+	 * sec 7.7.3.7 for details.
+	 */
 	pcie_config_aspm_link(link, 0);
 	list_del(&link->sibling);
 	/* Clock PM is for endpoint device */
@@ -1032,7 +1029,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 		pcie_update_aspm_capable(root);
 		pcie_config_aspm_path(parent_link);
 	}
-out:
+
 	mutex_unlock(&aspm_lock);
 	up_read(&pci_bus_sem);
 }
-- 
2.17.1

