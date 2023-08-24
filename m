Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 951CA7866DC
	for <lists+linux-pci@lfdr.de>; Thu, 24 Aug 2023 06:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239150AbjHXEsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Aug 2023 00:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239178AbjHXErs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Aug 2023 00:47:48 -0400
Received: from smtp-relay-canonical-0.canonical.com (smtp-relay-canonical-0.canonical.com [185.125.188.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552B810F0;
        Wed, 23 Aug 2023 21:47:45 -0700 (PDT)
Received: from localhost.localdomain (unknown [10.101.196.174])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id 528C6401C0;
        Thu, 24 Aug 2023 04:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1692852464;
        bh=gzh8CFjOP3xGUTmBskUbhLru7uSiTvUwnZrR616fQVw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=acNwiT+K3CAJqMILNvkz//RH7LxUzOHRB996jP69N1l3uflJPrHjRjQOjO0XK3D6q
         eQKbcLJBxZsYJDlfN3NBUIlru/zxfRIvwMKzSVDRrnGYhaqJLgWIE2VomepbQcYW3O
         h00GK0E2KDuc8TVpJMqQlslavRm2djPPBmdQgpPdwL7rDLrmOoDlX7dWzbCqsYwm40
         wBMWWYBlurTE7kLt+dZH1oZgO2eTgJH/vXXu2Afm6bzBDpjcW3snoWBWRKw+IJtEMG
         q/+or3+ZdhMi3L2WfyHs3qRmtPtL/Hx0P11qICmXSDHFXeHC+30GU44+j15jkSxI66
         LX06IKU95LZYg==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] PCI/DPC: Disable DPC service on suspend
Date:   Thu, 24 Aug 2023 12:46:45 +0800
Message-Id: <20230824044645.423378-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824044645.423378-1-kai.heng.feng@canonical.com>
References: <20230824044645.423378-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When the power rail gets cut off, the hardware can create some electric
noise on the link that triggers AER. If IRQ is shared between AER with
PME, such AER noise will cause a spurious wakeup on system suspend.

When the power rail gets back, the firmware of the device resets itself
and can create unexpected behavior like sending PTM messages. For this
case, the driver will always be too late to toggle off features should
be disabled.

As Per PCIe Base Spec 5.0, section 5.2, titled "Link State Power
Management", TLP and DLLP transmission are disabled for a Link in L2/L3
Ready (D3hot), L2 (D3cold with aux power) and L3 (D3cold) states. So if
the power will be turned off during suspend process, disable DPC service
and re-enable it during the resume process. This should not affect the
basic functionality.

Since DPC depends on AER to function, also disable DPC.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209149
Link: https://bugzilla.kernel.org/show_bug.cgi?id=216295

v7:
 - Wording.
 - Disable DPC completely (again) if power will be turned off

v6:
v5:
 - Wording.

v4:
v3:
 - No change.

v2:
 - Only disable DPC IRQ.
 - No more check on PME IRQ#.
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/dpc.c | 56 ++++++++++++++++++++++++++++++++++--------
 1 file changed, 46 insertions(+), 10 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3ceed8e3de41..73426addb2f1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -13,6 +13,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/suspend.h>
 
 #include "portdrv.h"
 #include "../pci.h"
@@ -347,13 +348,34 @@ void pci_dpc_init(struct pci_dev *pdev)
 	}
 }
 
+static void dpc_enable(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	u16 ctl;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+
+	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+}
+
+static void dpc_disable(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+	u16 ctl;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
+	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+}
+
 #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
 static int dpc_probe(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
 	struct device *device = &dev->device;
 	int status;
-	u16 ctl, cap;
+	u16 cap;
 
 	if (!pcie_aer_is_native(pdev) && !pcie_ports_dpc_native)
 		return -ENOTSUPP;
@@ -368,10 +390,7 @@ static int dpc_probe(struct pcie_device *dev)
 	}
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
-
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
-	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+	dpc_enable(dev);
 	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
 
 	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
@@ -384,14 +403,29 @@ static int dpc_probe(struct pcie_device *dev)
 	return status;
 }
 
-static void dpc_remove(struct pcie_device *dev)
+static int dpc_suspend(struct pcie_device *dev)
 {
 	struct pci_dev *pdev = dev->port;
-	u16 ctl;
 
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
-	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+	if (pci_ancestor_pr3_present(pdev) || pm_suspend_via_firmware())
+		dpc_disable(dev);
+
+	return 0;
+}
+
+static int dpc_resume(struct pcie_device *dev)
+{
+	struct pci_dev *pdev = dev->port;
+
+	if (pci_ancestor_pr3_present(pdev) || pm_resume_via_firmware())
+		dpc_enable(dev);
+
+	return 0;
+}
+
+static void dpc_remove(struct pcie_device *dev)
+{
+	dpc_disable(dev);
 }
 
 static struct pcie_port_service_driver dpcdriver = {
@@ -399,6 +433,8 @@ static struct pcie_port_service_driver dpcdriver = {
 	.port_type	= PCIE_ANY_PORT,
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
+	.suspend	= dpc_suspend,
+	.resume		= dpc_resume,
 	.remove		= dpc_remove,
 };
 
-- 
2.34.1

