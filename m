Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC5C61C3345
	for <lists+linux-pci@lfdr.de>; Mon,  4 May 2020 09:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgEDHDI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 4 May 2020 03:03:08 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:55251 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726410AbgEDHDI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 4 May 2020 03:03:08 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jVV85-0002cB-SL; Mon, 04 May 2020 07:03:06 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] PCI: Enable ASPM L1 on TI PCIe-to-PCI bridge
Date:   Mon,  4 May 2020 15:02:59 +0800
Message-Id: <20200504070259.6034-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The TI PCIe-to-PCI bridge prevents the Intel SoC from entering power
state deeper than PC3, consumes lots of unnecessary power.

On Windows ASPM L1 is enabled on the device and its upstream bridge,
so it can make the Intel SoC reach PC8 or PC10 to save lots of power.

So enable ASPM L1 like Windows does, to save additional power.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=207571
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/quirks.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ca9ed5774eb1..ac7eccf34f87 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -2330,6 +2330,27 @@ DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f1, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x10f4, quirk_disable_aspm_l0s);
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL, 0x1508, quirk_disable_aspm_l0s);
 
+static void quirk_enable_aspm_l1(struct pci_dev *dev)
+{
+	struct pci_dev *bridge = pci_upstream_bridge(dev);
+	u16 lnkctl;
+
+	pci_info(dev, "Enabling L1\n");
+	pcie_capability_read_word(dev, PCI_EXP_LNKCTL, &lnkctl);
+	if (!(lnkctl & PCI_EXP_LNKCTL_ASPM_L1))
+		pcie_capability_write_word(dev, PCI_EXP_LNKCTL,
+					   lnkctl | PCI_EXP_LNKCTL_ASPM_L1);
+
+	if (!bridge)
+		return;
+
+	pcie_capability_read_word(bridge, PCI_EXP_LNKCTL, &lnkctl);
+	if (!(lnkctl & PCI_EXP_LNKCTL_ASPM_L1))
+		pcie_capability_write_word(bridge, PCI_EXP_LNKCTL,
+					   lnkctl | PCI_EXP_LNKCTL_ASPM_L1);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_TI, 0x8240, quirk_enable_aspm_l1);
+
 /*
  * Some Pericom PCIe-to-PCI bridges in reverse mode need the PCIe Retrain
  * Link bit cleared after starting the link retrain process to allow this
-- 
2.17.1

