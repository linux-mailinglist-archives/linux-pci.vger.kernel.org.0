Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 701FC49C421
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 08:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237692AbiAZHTM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 02:19:12 -0500
Received: from smtp-relay-canonical-0.canonical.com ([185.125.188.120]:46850
        "EHLO smtp-relay-canonical-0.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237685AbiAZHTM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 26 Jan 2022 02:19:12 -0500
Received: from HP-EliteBook-840-G7.. (36-229-235-192.dynamic-ip.hinet.net [36.229.235.192])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-canonical-0.canonical.com (Postfix) with ESMTPSA id D5A2A4198F;
        Wed, 26 Jan 2022 07:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643181549;
        bh=v0HBY9QuURUB5f1ClOwDSwh7i2HZDyxqJs55MspAO5M=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=at6gkeRE6nzZB4khhXUX9gevAhB41zEY3pgGk7aMkjn4vmmnVOj5uHkd0Lge+TsiO
         IGnJGSSTdzwf52QcJwPqYW8C0S/sl1QDHREyATwS1R/CxgLHpSwdMLoMB9dst8yFcq
         Qd2RCzd5ZaTOt+6QeNg1V6QiaS4o1N6v4Rr97sM8z7dQ9WEflWUbmv9uTjzD0yN/MY
         R8PcPgfLlz20owCh6JRilk1VeCh0+rRL/PhVa4AFpP+TpWEf6yn0lbFHfQb4h6E/no
         YdFslQF5+W3AKDwiKEr3lyvveD5mdpYGCcP+bTFxvCgxUB5Zu6v8CWqZuSu733Sttq
         t49VQhwSnVSAw==
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     mika.westerberg@linux.intel.com, koba.ko@canonical.com,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Russell Currey <ruscur@russell.cc>,
        "Oliver O'Halloran" <oohall@gmail.com>,
        linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] PCI/DPC: Disable DPC when link is in L2/L3 ready, L2 and L3 state
Date:   Wed, 26 Jan 2022 15:18:52 +0800
Message-Id: <20220126071853.1940111-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220126071853.1940111-1-kai.heng.feng@canonical.com>
References: <20220126071853.1940111-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since TLP and DLLP transmission is disabled for a Link in L2/L3 Ready,
L2 and L3, and DPC depends on AER, so also disable DPC here.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pcie/dpc.c | 61 +++++++++++++++++++++++++++++++-----------
 1 file changed, 45 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3e9afee02e8d1..9585c10b7c577 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -343,13 +343,34 @@ void pci_dpc_init(struct pci_dev *pdev)
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
@@ -364,10 +385,7 @@ static int dpc_probe(struct pcie_device *dev)
 	}
 
 	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CAP, &cap);
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
-
-	ctl = (ctl & 0xfff4) | PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN;
-	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+	dpc_enable(dev);
 	pci_info(pdev, "enabled with IRQ %d\n", dev->irq);
 
 	pci_info(pdev, "error containment capabilities: Int Msg #%d, RPExt%c PoisonedTLP%c SwTrigger%c RP PIO Log %d, DL_ActiveErr%c\n",
@@ -380,22 +398,33 @@ static int dpc_probe(struct pcie_device *dev)
 	return status;
 }
 
-static void dpc_remove(struct pcie_device *dev)
+static int dpc_suspend(struct pcie_device *dev)
 {
-	struct pci_dev *pdev = dev->port;
-	u16 ctl;
+	dpc_disable(dev);
+	return 0;
+}
 
-	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, &ctl);
-	ctl &= ~(PCI_EXP_DPC_CTL_EN_FATAL | PCI_EXP_DPC_CTL_INT_EN);
-	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_CTL, ctl);
+static int dpc_resume(struct pcie_device *dev)
+{
+	dpc_enable(dev);
+	return 0;
+}
+
+static void dpc_remove(struct pcie_device *dev)
+{
+	dpc_disable(dev);
 }
 
 static struct pcie_port_service_driver dpcdriver = {
-	.name		= "dpc",
-	.port_type	= PCIE_ANY_PORT,
-	.service	= PCIE_PORT_SERVICE_DPC,
-	.probe		= dpc_probe,
-	.remove		= dpc_remove,
+	.name			= "dpc",
+	.port_type		= PCIE_ANY_PORT,
+	.service		= PCIE_PORT_SERVICE_DPC,
+	.probe			= dpc_probe,
+	.suspend		= dpc_suspend,
+	.resume			= dpc_resume,
+	.runtime_suspend	= dpc_suspend,
+	.runtime_resume		= dpc_resume,
+	.remove			= dpc_remove,
 };
 
 int __init pcie_dpc_init(void)
-- 
2.33.1

