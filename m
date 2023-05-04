Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51756F6C6D
	for <lists+linux-pci@lfdr.de>; Thu,  4 May 2023 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbjEDMx6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 4 May 2023 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbjEDMx5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 4 May 2023 08:53:57 -0400
X-Greylist: delayed 600 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 05:53:40 PDT
Received: from mail-m127104.qiye.163.com (mail-m127104.qiye.163.com [115.236.127.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79E24ED4
        for <linux-pci@vger.kernel.org>; Thu,  4 May 2023 05:53:40 -0700 (PDT)
Received: from localhost.localdomain (unknown [IPV6:240e:3b7:327f:5c30:f10d:e185:a86d:3be7])
        by mail-m127104.qiye.163.com (Hmail) with ESMTPA id CD3D5A4050F;
        Thu,  4 May 2023 20:35:03 +0800 (CST)
From:   Ding Hui <dinghui@sangfor.com.cn>
To:     bhelgaas@google.com
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, vidyas@nvidia.com,
        david.e.box@linux.intel.com, kai.heng.feng@canonical.com,
        michael.a.bottini@linux.intel.com, rajatja@google.com,
        qinzongquan@sangfor.com.cn, dinghui@sangfor.com.cn,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/ASPM: fix UAF by disable ASPM for link when child function is removed
Date:   Thu,  4 May 2023 20:34:18 +0800
Message-Id: <20230504123418.4438-1-dinghui@sangfor.com.cn>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
        tZV1koWUFITzdXWS1ZQUlXWQ8JGhUIEh9ZQVkZSkoaVh4dH05MTx0dTkIeGlUTARMWGhIXJBQOD1
        lXWRgSC1lBWUlPSx5BSBlMQUhJTB1BThhIS0EdSksfQR5KQ05BGkNNH0FIGR5MWVdZFhoPEhUdFF
        lBWU9LSFVKSktISkNVSktLVUtZBg++
X-HM-Tid: 0a87e6c2455cb282kuuucd3d5a4050f
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Kxg6SBw6PT0cAT8yCFYYIVY1
        NzEwCQhVSlVKTUNISUtITEtPTUpDVTMWGhIXVR8SFRwTDhI7CBoVHB0UCVUYFBZVGBVFWVdZEgtZ
        QVlJT0seQUgZTEFISUwdQU4YSEtBHUpLH0EeSkNOQRpDTR9BSBkeTFlXWQgBWUFIT0pNNwY+
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the Function 0 of a Multi-Function device is software removed,
a freed downstream pointer will be left in struct pcie_link_state,
and then when pcie_config_aspm_link() be invoked from any path,
we will trigger use-after-free.

Based on the PCIe spec about ASPM Control (PCIe r6.0, sec 7.5.3.7),
for Multi-Function Devices (including ARI Devices), it is recommended
that software program the same value in all Functions. For ARI
Devices, ASPM Control is determined solely by the setting in Function 0.

So we can just disable ASPM of the whole component if any child
function is removed, the downstream pointer will be avoided from
use-after-free, that will also avoid other potential corner cases.

Fixes: b5a0a9b59c81 ("PCI/ASPM: Read and set up L1 substate capabilities")
Debugged-by: Zongquan Qin <qinzongquan@sangfor.com.cn>
Suggestion-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
---
 drivers/pci/pcie/aspm.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 66d7514ca111..1bf8306141aa 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1010,18 +1010,17 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
 
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
+	 * Any function is removed (including software removing), just
+	 * disable ASPM for the link, in case we can not configure the same
+	 * setting for all functions.
+	 * See PCIe r6.0, sec 7.5.3.7.
+	 */
 	pcie_config_aspm_link(link, 0);
 	list_del(&link->sibling);
 	/* Clock PM is for endpoint device */
@@ -1032,7 +1031,7 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
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

