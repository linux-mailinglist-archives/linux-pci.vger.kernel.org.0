Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1B65540A7
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jun 2022 04:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355930AbiFVCui (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jun 2022 22:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232424AbiFVCuh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 21 Jun 2022 22:50:37 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 185942DA85;
        Tue, 21 Jun 2022 19:50:35 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="5.92,211,1650898800"; 
   d="scan'208";a="125228420"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 22 Jun 2022 11:50:35 +0900
Received: from localhost.localdomain (unknown [10.166.15.32])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id 2FDAB4199DAE;
        Wed, 22 Jun 2022 11:50:35 +0900 (JST)
From:   Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
To:     kishon@ti.com, lpieralisi@kernel.org, kw@linux.com,
        bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Subject: [PATCH v2] PCI: endpoint: Fix WARN() when an endpoint driver is removed
Date:   Wed, 22 Jun 2022 11:50:31 +0900
Message-Id: <20220622025031.51812-1-yoshihiro.shimoda.uh@renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        KHOP_HELO_FCRDNS,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_epc_release() for epc->dev.release and move kfree(epc)
to the release function. Otherwise, WARN() happened when a PCIe
endpoint driver is removed.

 Device 'e65d0000.pcie-ep' does not have a release() function, it is broken and must be fixed. See Documentation/core-api/kobject.rst.
 WARNING: CPU: 0 PID: 139 at drivers/base/core.c:2232 device_release+0x78/0x8c

Signed-off-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
---
 Changes from v1:
 - Move kfree(epc) to the release function.
 - Revised the commit description.
 https://lore.kernel.org/all/20220621121147.3971001-1-yoshihiro.shimoda.uh@renesas.com/

 drivers/pci/endpoint/pci-epc-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index 3bc9273d0a08..2542196e8c3d 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -724,7 +724,6 @@ void pci_epc_destroy(struct pci_epc *epc)
 {
 	pci_ep_cfs_remove_epc_group(epc->group);
 	device_unregister(&epc->dev);
-	kfree(epc);
 }
 EXPORT_SYMBOL_GPL(pci_epc_destroy);
 
@@ -746,6 +745,11 @@ void devm_pci_epc_destroy(struct device *dev, struct pci_epc *epc)
 }
 EXPORT_SYMBOL_GPL(devm_pci_epc_destroy);
 
+static void pci_epc_release(struct device *dev)
+{
+	kfree(to_pci_epc(dev));
+}
+
 /**
  * __pci_epc_create() - create a new endpoint controller (EPC) device
  * @dev: device that is creating the new EPC
@@ -779,6 +783,7 @@ __pci_epc_create(struct device *dev, const struct pci_epc_ops *ops,
 	device_initialize(&epc->dev);
 	epc->dev.class = pci_epc_class;
 	epc->dev.parent = dev;
+	epc->dev.release = pci_epc_release;
 	epc->ops = ops;
 
 	ret = dev_set_name(&epc->dev, "%s", dev_name(dev));
-- 
2.25.1

