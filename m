Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 258111CA493
	for <lists+linux-pci@lfdr.de>; Fri,  8 May 2020 08:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726083AbgEHGxz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 8 May 2020 02:53:55 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:58485 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725971AbgEHGxy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 8 May 2020 02:53:54 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jWwtL-0004ZC-VT; Fri, 08 May 2020 06:53:52 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     bhelgaas@google.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] PCI: Prevent Pericom USB controller OHCI/EHCI PME# defect
Date:   Fri,  8 May 2020 14:53:41 +0800
Message-Id: <20200508065343.32751-2-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200508065343.32751-1-kai.heng.feng@canonical.com>
References: <20200508065343.32751-1-kai.heng.feng@canonical.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Both Pericom OHCI and EHCI devices support PME# from all power states:
06:00.0 USB controller [0c03]: Pericom Semiconductor PI7C9X442SL USB OHCI Controller [12d8:400e] (rev 01) (prog-if 10 [OHCI])
	Subsystem: Pericom Semiconductor PI7C9X442SL USB OHCI Controller [12d8:400e]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin A routed to IRQ 17
	Region 0: Memory at a5502000 (32-bit, non-prefetchable) [size=4K]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-

06:00.2 USB controller [0c03]: Pericom Semiconductor PI7C9X442SL USB EHCI Controller [12d8:400f] (rev 01) (prog-if 20 [EHCI])
	Subsystem: Pericom Semiconductor PI7C9X442SL USB EHCI Controller [12d8:400f]
	Control: I/O+ Mem+ BusMaster- SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR+ FastB2B- DisINTx-
	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
	Interrupt: pin C routed to IRQ 19
	Region 0: Memory at a5500000 (32-bit, non-prefetchable) [size=256]
	Capabilities: [80] Power Management version 3
		Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA PME(D0+,D1+,D2+,D3hot+,D3cold+)
		Status: D3 NoSoftRst+ PME-Enable+ DSel=0 DScale=0 PME-

Though my original approach [1] appears to work, further testing shows
that there is a 20% chance PME# won't be asserted when USB device is
plugged.

So remove the PME support for both devices to make USB plugging works.

[1] https://lore.kernel.org/lkml/20191227092405.29588-1-kai.heng.feng@canonical.com/
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=205981

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/quirks.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index ca9ed5774eb1..db2590243f0d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5568,6 +5568,18 @@ static void pci_fixup_no_d0_pme(struct pci_dev *dev)
 }
 DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ASMEDIA, 0x2142, pci_fixup_no_d0_pme);
 
+/*
+ * Device [12d8:0x400e] and [12d8:0x400f]
+ * PME# doesn't always get asserted on all power states claim to support PME#
+ */
+static void pci_fixup_no_pme(struct pci_dev *dev)
+{
+	pci_info(dev, "PME# isn't reliable, disabling it\n");
+	dev->pme_support = 0;
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400e, pci_fixup_no_pme);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_PERICOM, 0x400f, pci_fixup_no_pme);
+
 static void apex_pci_fixup_class(struct pci_dev *pdev)
 {
 	pdev->class = (PCI_CLASS_SYSTEM_OTHER << 8) | pdev->class;
-- 
2.17.1

