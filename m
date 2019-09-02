Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92993A59D3
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2019 16:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731011AbfIBOxA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Sep 2019 10:53:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:41506 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbfIBOxA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Sep 2019 10:53:00 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.76)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1i4nhR-0007wC-T9; Mon, 02 Sep 2019 14:52:58 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH] x86/PCI: Remove D0 PME capability on AMD FCH xHCI
Date:   Mon,  2 Sep 2019 22:52:52 +0800
Message-Id: <20190902145252.32111-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There's an xHCI device that doesn't wake when a USB 2.0 device gets
plugged to its USB 3.0 port. The driver's own runtime suspend callback
was called, PME# signaling was enabled, but it stays at PCI D0:

00:10.0 USB controller [0c03]: Advanced Micro Devices, Inc. [AMD] FCH USB XHCI Controller [1022:7914] (rev 20) (prog-if 30 [XHCI])
        Subsystem: Dell FCH USB XHCI Controller [1028:087e]
        Control: I/O- Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
        Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
        Interrupt: pin A routed to IRQ 18
        Region 0: Memory at f0b68000 (64-bit, non-prefetchable) [size=8K]
        Capabilities: [50] Power Management version 3
                Flags: PMEClk- DSI- D1- D2- AuxCurrent=0mA PME(D0+,D1-,D2-,D3hot+,D3cold+)
                Status: D0 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-

A PCI device can be runtime suspended while still stays at D0 when it
supports D0 PME# and its ACPI _S0W method reports D0. Though plugging
USB 3.0 devices can wakeup the xHCI, it doesn't respond to USB 2.0
devices.

So let's disable D0 PME capability on this device to avoid the issue.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=203673
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 arch/x86/pci/fixup.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 527e69b12002..0851a05d092f 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -588,6 +588,17 @@ static void pci_fixup_amd_ehci_pme(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x7808, pci_fixup_amd_ehci_pme);
 
+/*
+ * Device [1022:7914]
+ * D0 PME# doesn't get asserted when plugging USB 2.0 device.
+ */
+static void pci_fixup_amd_fch_xhci_pme(struct pci_dev *dev)
+{
+	dev_info(&dev->dev, "PME# does not work under D0, disabling it\n");
+	dev->pme_support &= ~(PCI_PM_CAP_PME_D0 >> PCI_PM_CAP_PME_SHIFT);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_AMD, 0x7914, pci_fixup_amd_fch_xhci_pme);
+
 /*
  * Apple MacBook Pro: Avoid [mem 0x7fa00000-0x7fbfffff]
  *
-- 
2.17.1

