Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C3E718B7B
	for <lists+linux-pci@lfdr.de>; Thu,  9 May 2019 16:15:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727006AbfEIOPS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 May 2019 10:15:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:50236 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726986AbfEIOPN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 May 2019 10:15:13 -0400
Received: from localhost (50-81-63-4.client.mchsi.com [50.81.63.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F082D21479;
        Thu,  9 May 2019 14:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557411313;
        bh=JUIHOpOWl8G/bzkBQeOThiXiw1eqS3UO5cr6p0ZvWOA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mAK2mXWhGbuXKAzGUcsm0Cz7EXtcRGQ7bPsZOHrkInSXztIU+eb8JT5WRdL8/uhN7
         9MEL0mVRPvBnPT+ILschTnOaBZXEdUEGJHEt2Qtw4DkcXL9cv3zpqZOoTEOnVIsxXL
         +HzrSwWF7+f3OSohZiwUO1oCJcFII6lTyyp3d86g=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Frederick Lawler <fred@fredlawl.com>
Cc:     Mika Westerberg <mika.westerberg@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dongdong Liu <liudongdong3@huawei.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 05/10] PCI: pciehp: Remove pciehp_debug uses
Date:   Thu,  9 May 2019 09:14:51 -0500
Message-Id: <20190509141456.223614-6-helgaas@kernel.org>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
In-Reply-To: <20190509141456.223614-1-helgaas@kernel.org>
References: <20190509141456.223614-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

We're about to convert pciehp to the dyndbg mechanism, which means we can
eventually remove pciehp_debug.

Replace uses of pciehp_debug with dbg() and ctrl_dbg(), which check
pciehp_debug internally.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 6a2365cd794e..e121f1c06c21 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -232,8 +232,8 @@ static bool pci_bus_check_dev(struct pci_bus *bus, int devfn)
 		delay -= step;
 	} while (delay > 0);
 
-	if (count > 1 && pciehp_debug)
-		printk(KERN_DEBUG "pci %04x:%02x:%02x.%d id reading try %d times with interval %d ms to get %08x\n",
+	if (count > 1)
+		dbg("pci %04x:%02x:%02x.%d id reading try %d times with interval %d ms to get %08x\n",
 			pci_domain_nr(bus), bus->number, PCI_SLOT(devfn),
 			PCI_FUNC(devfn), count, step, l);
 
@@ -822,14 +822,11 @@ static inline void dbg_ctrl(struct controller *ctrl)
 	struct pci_dev *pdev = ctrl->pcie->port;
 	u16 reg16;
 
-	if (!pciehp_debug)
-		return;
-
-	ctrl_info(ctrl, "Slot Capabilities      : 0x%08x\n", ctrl->slot_cap);
+	ctrl_dbg(ctrl, "Slot Capabilities      : 0x%08x\n", ctrl->slot_cap);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTSTA, &reg16);
-	ctrl_info(ctrl, "Slot Status            : 0x%04x\n", reg16);
+	ctrl_dbg(ctrl, "Slot Status            : 0x%04x\n", reg16);
 	pcie_capability_read_word(pdev, PCI_EXP_SLTCTL, &reg16);
-	ctrl_info(ctrl, "Slot Control           : 0x%04x\n", reg16);
+	ctrl_dbg(ctrl, "Slot Control           : 0x%04x\n", reg16);
 }
 
 #define FLAG(x, y)	(((x) & (y)) ? '+' : '-')
-- 
2.21.0.1020.gf2820cf01a-goog

