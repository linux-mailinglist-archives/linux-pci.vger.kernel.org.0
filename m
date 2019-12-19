Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 613BB126DDD
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2019 20:20:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfLSTUS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Dec 2019 14:20:18 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:50754 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbfLSTUS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Dec 2019 14:20:18 -0500
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ii1LL-0005W2-Fe; Thu, 19 Dec 2019 19:20:16 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] PCI: Avoid ASMedia XHCI USB PME# from D0 defect
Date:   Fri, 20 Dec 2019 03:20:06 +0800
Message-Id: <20191219192006.16270-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The ASMedia USB XHCI Controller claims to support generating PME# while
in D0:

01:00.0 USB controller: ASMedia Technology Inc. Device 2142 (prog-if 30 [XHCI])
        Subsystem: SUNIX Co., Ltd. Device 312b
        Capabilities: [78] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=55mA PME(D0+,D1-,D2-,D3hot-,D3cold-)
                Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-

However PME# only gets asserted when plugging USB 2.0 or USB 1.1
devices, but not for USB 3.0 devices.

So remove PCI_PM_CAP_PME_D0 to avoid using PME under D0.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205919
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/quirks.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 79379b4c9d7a..24c71555dc77 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5436,3 +5436,14 @@ static void quirk_reset_lenovo_thinkpad_p50_nvgpu(struct pci_dev *pdev)
 DECLARE_PCI_FIXUP_CLASS_FINAL(PCI_VENDOR_ID_NVIDIA, 0x13b1,
 			      PCI_CLASS_DISPLAY_VGA, 8,
 			      quirk_reset_lenovo_thinkpad_p50_nvgpu);
+
+/*
+ * Device [1b21:2142]
+ * When in D0, PME# doesn't get asserted when plugging USB 3.0 device.
+ */
+static void pci_fixup_no_d0_pme(struct pci_dev *dev)
+{
+	pci_info(dev, "PME# does not work under D0, disabling it\n");
+	dev->pme_support &= ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
-- 
2.17.1

