Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18B3F3A4AC1
	for <lists+linux-pci@lfdr.de>; Fri, 11 Jun 2021 23:48:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbhFKVu3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Jun 2021 17:50:29 -0400
Received: from yyz.mikelr.com ([170.75.163.43]:33888 "EHLO yyz.mikelr.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229777AbhFKVu3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 11 Jun 2021 17:50:29 -0400
Received: from glidewell.ykf.mikelr.com (198-84-194-208.cpe.teksavvy.com [198.84.194.208])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client did not present a certificate)
        by yyz.mikelr.com (Postfix) with ESMTPSA id BB55F4F393;
        Fri, 11 Jun 2021 17:48:29 -0400 (EDT)
From:   Mikel Rychliski <mikel@mikelr.com>
To:     mikel@mikelr.com
Cc:     bhelgaas@google.com, helgaas@kernel.org, linux-pci@vger.kernel.org,
        x86@kernel.org
Subject: [PATCH v2] PCI: Add quirk for 64-bit DMA on RS690 chipset
Date:   Fri, 11 Jun 2021 17:48:23 -0400
Message-Id: <20210611214823.4898-1-mikel@mikelr.com>
X-Mailer: git-send-email 2.13.7
In-Reply-To: <2233170.O0C0KFXLZ4@glidewell>
References: <2233170.O0C0KFXLZ4@glidewell>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Although the AMD RS690 chipset has 64-bit DMA support, BIOS implementations
sometimes fail to configure the memory limit registers correctly.

The Acer F690GVM mainboard uses this chipset and a Marvell 88E8056 NIC. The
sky2 driver programs the NIC to use 64-bit DMA, which will not work:

	sky2 0000:02:00.0: error interrupt status=0x8
	sky2 0000:02:00.0 eth0: tx timeout
	sky2 0000:02:00.0 eth0: transmit ring 0 .. 22 report=0 done=0

Other drivers required by this mainboard either don't support 64-bit DMA,
or have it disabled using driver specific quirks. For example, the ahci
driver has quirks to enable or disable 64-bit DMA depending on the BIOS
version (see ahci_sb600_enable_64bit() in ahci.c). This ahci quirk matches
against the SB600 SATA controller, but the real issue is almost certainly
with the RS690 PCI host that it was commonly attached to.

To avoid this issue in all drivers with 64-bit DMA support, fix the
configuration of the PCI host. If the kernel is aware of physical memory
above 4GB, but the BIOS never configured the PCI host with this
information, update the registers with our values.

Signed-off-by: Mikel Rychliski <mikel@mikelr.com>
---
 arch/x86/pci/fixup.c    | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci_ids.h |  1 +
 2 files changed, 46 insertions(+)

diff --git a/arch/x86/pci/fixup.c b/arch/x86/pci/fixup.c
index 02dc64625e64..4cc479f332ba 100644
--- a/arch/x86/pci/fixup.c
+++ b/arch/x86/pci/fixup.c
@@ -779,4 +779,49 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1571, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x15b1, pci_amd_enable_64bit_bar);
 DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_AMD, 0x1601, pci_amd_enable_64bit_bar);
 
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
+ * Reference: "AMD RS690 ASIC Family Register Reference Guide" (pg. 2-57)
+ * https://www.amd.com/system/files/TechDocs/43372_rs690_rrg_3.00o.pdf
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
+	pci_info(pdev, "Adjusting top of DRAM to %pa for 64-bit DMA support\n", &top_of_dram);
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
+
 #endif
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

