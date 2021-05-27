Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F14F39386E
	for <lists+linux-pci@lfdr.de>; Thu, 27 May 2021 23:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235028AbhE0Vyw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 17:54:52 -0400
Received: from yyz.mikelr.com ([170.75.163.43]:33776 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229822AbhE0Vyv (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 17:54:51 -0400
X-Greylist: delayed 440 seconds by postgrey-1.27 at vger.kernel.org; Thu, 27 May 2021 17:54:50 EDT
Received: from glidewell.ykf.mikelr.com (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id 57D2F4EA21;
        Thu, 27 May 2021 17:45:26 -0400 (EDT)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Cc:     Mikel Rychliski <mikel@mikelr.com>
Subject: [PATCH] PCI: Add quirk for 64-bit DMA on RS690 chipset
Date:   Thu, 27 May 2021 17:45:21 -0400
Message-Id: <20210527214521.23923-1-mikel@mikelr.com>
X-Mailer: git-send-email 2.13.7
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Although the AMD RS690 chipset has 64-bit DMA support, BIOS implementations
sometimes fail to configure the memory limit registers correctly.
Currently, the ahci driver has quirks to enable or disable 64-bit DMA
depending on the BIOS version (see ahci_sb600_enable_64bit() in ahci.c).
snd_hda_intel always disables 64-bit DMA with the paired SB600 chipset.

The Acer F690GVM mainboard uses this chipset and a Marvell 88E8056 NIC. The
sky2 driver attempts to use 64-bit DMA the NIC, which will not work:

	sky2 0000:02:00.0: error interrupt status=0x8
	sky2 0000:02:00.0 eth0: tx timeout
	sky2 0000:02:00.0 eth0: transmit ring 0 .. 22 report=0 done=0

Avoid the issue by configuring the memory limit registers correctly if the
BIOS failed to. If the kernel is aware of physical memory above 4GB, but
the BIOS never configured the PCI host with this information, update the
register with our value.

Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
---
 drivers/pci/quirks.c    | 44 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |  1 +
 2 files changed, 45 insertions(+)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index dcb229de1acb..cd98a01de908 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5601,3 +5601,47 @@ static void apex_pci_fixup_class(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_CLASS_HEADER(0x1ac1, 0x089a,
 			       PCI_CLASS_NOT_DEFINED, 8, apex_pci_fixup_class);
+
+#define RS690_LOWER_TOP_OF_DRAM2	0x30
+#define RS690_LOWER_TOP_OF_DRAM2_VALID	0x1
+#define RS690_UPPER_TOP_OF_DRAM2	0x31
+#define RS690_HTIU_NB_INDEX		0xA8
+#define RS690_HTIU_NB_INDEX_WR_ENABLE	0x100
+#define RS690_HTIU_NB_DATA		0xAC
+
+/*
+ * Some BIOS implementations support RAM above 4GB, but do not configure the
+ * PCI host to respond to bus master accesses for these addresses. These
+ * implementations set the TOP_OF_DRAM_SLOT1 register correctly, so PCI DMA
+ * works as expected for addresses below 4GB.
+ *
+ * Reference: "AMD RS690 ASIC Family Register Reference Guide" (public)
+ */
+static void rs690_fix_64bit_dma(struct pci_dev *pdev)
+{
+	u32 val = 0;
+	phys_addr_t top_of_dram = __pa(high_memory - 1) + 1;
+
+	if (top_of_dram <= (1ULL << 32))
+		return;
+
+	pci_write_config_dword(pdev, RS690_HTIU_NB_INDEX,
+				RS690_LOWER_TOP_OF_DRAM2);
+	pci_read_config_dword(pdev, RS690_HTIU_NB_DATA, &val);
+
+	if (val)
+		return;
+
+	pci_info(pdev, "Adjusting top of DRAM to support 64-bit DMA\n");
+
+	pci_write_config_dword(pdev, RS690_HTIU_NB_INDEX,
+		RS690_UPPER_TOP_OF_DRAM2 | RS690_HTIU_NB_INDEX_WR_ENABLE);
+	pci_write_config_dword(pdev, RS690_HTIU_NB_DATA, top_of_dram >> 32);
+
+	pci_write_config_dword(pdev, RS690_HTIU_NB_INDEX,
+		RS690_LOWER_TOP_OF_DRAM2 | RS690_HTIU_NB_INDEX_WR_ENABLE);
+	pci_write_config_dword(pdev, RS690_HTIU_NB_DATA,
+		top_of_dram | RS690_LOWER_TOP_OF_DRAM2_VALID);
+}
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_RS690,
+			rs690_fix_64bit_dma);
diff --git a/include/linux/pci_ids.h b/include/linux/pci_ids.h
index 4c3fa5293d76..0a7fe2ed520b 100644
--- a/include/linux/pci_ids.h
+++ b/include/linux/pci_ids.h
@@ -381,6 +381,7 @@
 #define PCI_DEVICE_ID_ATI_RS400_166     0x5a32
 #define PCI_DEVICE_ID_ATI_RS400_200     0x5a33
 #define PCI_DEVICE_ID_ATI_RS480         0x5950
+#define PCI_DEVICE_ID_ATI_RS690         0x7910
 /* ATI IXP Chipset */
 #define PCI_DEVICE_ID_ATI_IXP200_IDE	0x4349
 #define PCI_DEVICE_ID_ATI_IXP200_SMBUS	0x4353
-- 
2.13.7

