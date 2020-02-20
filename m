Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBEE166726
	for <lists+linux-pci@lfdr.de>; Thu, 20 Feb 2020 20:29:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728966AbgBTT3l (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Feb 2020 14:29:41 -0500
Received: from mga01.intel.com ([192.55.52.88]:16662 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728334AbgBTT3k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 20 Feb 2020 14:29:40 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 20 Feb 2020 11:29:39 -0800
X-IronPort-AV: E=Sophos;i="5.70,465,1574150400"; 
   d="scan'208";a="228993653"
Received: from ykim6-mobl1.amr.corp.intel.com (HELO arch-ashland-svkelley.intel.com) ([10.254.188.97])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 20 Feb 2020 11:29:39 -0800
From:   Sean V Kelley <sean.v.kelley@linux.intel.com>
To:     tglx@linutronix.de, bhelgaas@google.com, corbet@lwn.net,
        mingo@redhat.com, bp@alien8.de
Cc:     x86@kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kar.hin.ong@ni.com, sassmann@kpanic.de,
        Sean V Kelley <sean.v.kelley@linux.intel.com>
Subject: [PATCH v2 1/2] pci: Add boot interrupt quirk mechanism for Xeon chipsets
Date:   Thu, 20 Feb 2020 11:29:29 -0800
Message-Id: <20200220192930.64820-2-sean.v.kelley@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200220192930.64820-1-sean.v.kelley@linux.intel.com>
References: <20200220192930.64820-1-sean.v.kelley@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The following was observed by Kar Hin Ong with RT patchset:
Backtrace:
irq 19: nobody cared (try booting with the "irqpoll" option)
CPU: 0 PID: 3329 Comm: irq/34-nipalk Tainted:4.14.87-rt49 #1
Hardware name: National Instruments NI PXIe-8880/NI PXIe-8880,
         BIOS 2.1.5f1 01/09/2020
Call Trace:
<IRQ>
  ? dump_stack+0x46/0x5e
  ? __report_bad_irq+0x2e/0xb0
  ? note_interrupt+0x242/0x290
  ? nNIKAL100_memoryRead16+0x8/0x10 [nikal]
  ? handle_irq_event_percpu+0x55/0x70
  ? handle_irq_event+0x4f/0x80
  ? handle_fasteoi_irq+0x81/0x180
  ? handle_irq+0x1c/0x30
  ? do_IRQ+0x41/0xd0
  ? common_interrupt+0x84/0x84
</IRQ>
...
handlers:
[<ffffffffb3297200>] irq_default_primary_handler threaded
[<ffffffffb3669180>] usb_hcd_irq
Disabling IRQ #19

The problem being that this device is triggering boot interrupts
due to threaded interrupt handling and masking of the IO-APIC. These
boot interrupts are then forwarded on to the legacy PCH's PIRQ lines
where there is no handler present for the device.

Whenever a PCI device is firing interrupt (INTx) to Pin 20 of IOAPIC 2
(GSI 44); the kernel will receives 2 interrupts:
   1. Interrupt from Pin 20 of IOAPIC 2  -> Expected
   2. Interrupt from Pin 19 of IOAPIC 1  -> UNEXPECTED

Quirks for disabling boot interrupts (preferred) or rerouting the handler
exist but do not address these Xeon chipsets' mechanism:
https://lore.kernel.org/lkml/12131949181903-git-send-email-sassmann@suse.de/

This patch adds a new mechanism via PCI CFG for those chipsets supporting
CIPINTRC register's dis_intx_rout2ich bit.

Reported-by: Kar Hin Ong <kar.hin.ong@ni.com>
Tested-by: Kar Hin Ong <kar.hin.ong@ni.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sean V Kelley <sean.v.kelley@linux.intel.com>
---
 drivers/pci/quirks.c | 80 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 73 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 29f473ebf20f..b7347bc6a24d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -1970,26 +1970,92 @@ DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_80332_1,	quirk
 /*
  * IO-APIC1 on 6300ESB generates boot interrupts, see Intel order no
  * 300641-004US, section 5.7.3.
+ *
+ * Core IO on Xeon E5 1600/2600/4600, see Intel order no 326509-003.
+ * Core IO on Xeon E5 v2, see Intel order no 329188-003.
+ * Core IO on Xeon E7 v2, see Intel order no 329595-002.
+ * Core IO on Xeon E5 v3, see Intel order no 330784-003.
+ * Core IO on Xeon E7 v3, see Intel order no 332315-001US.
+ * Core IO on Xeon E5 v4, see Intel order no 333810-002US.
+ * Core IO on Xeon E7 v4, see Intel order no 332315-001US.
+ * Core IO on Xeon D-1500, see Intel order no 332051-001.
+ * Core IO on Xeon Scalable, see Intel order no 610950.
  */
-#define INTEL_6300_IOAPIC_ABAR		0x40
+#define INTEL_6300_IOAPIC_ABAR		0x40	/* Bus 0, Dev 29, Func 5 */
 #define INTEL_6300_DISABLE_BOOT_IRQ	(1<<14)
 
+#define INTEL_CIPINTRC_CFG_OFFSET	0x14C	/* Bus 0, Dev 5, Func 0 */
+#define INTEL_CIPINTRC_DIS_INTX_ICH	(1<<25)
+
 static void quirk_disable_intel_boot_interrupt(struct pci_dev *dev)
 {
 	u16 pci_config_word;
+	u32 pci_config_dword;
 
 	if (noioapicquirk)
 		return;
 
-	pci_read_config_word(dev, INTEL_6300_IOAPIC_ABAR, &pci_config_word);
-	pci_config_word |= INTEL_6300_DISABLE_BOOT_IRQ;
-	pci_write_config_word(dev, INTEL_6300_IOAPIC_ABAR, pci_config_word);
-
+	switch (dev->device) {
+	case PCI_DEVICE_ID_INTEL_ESB_10:
+		pci_read_config_word(dev, INTEL_6300_IOAPIC_ABAR,
+				     &pci_config_word);
+		pci_config_word |= INTEL_6300_DISABLE_BOOT_IRQ;
+		pci_write_config_word(dev, INTEL_6300_IOAPIC_ABAR,
+				      pci_config_word);
+		break;
+	case 0x3c28:	/* Xeon E5 1600/2600/4600	*/
+	case 0x0e28:	/* Xeon E5/E7 V2		*/
+	case 0x2f28:	/* Xeon E5/E7 V3,V4		*/
+	case 0x6f28:	/* Xeon D-1500			*/
+	case 0x2034:	/* Xeon Scalable Family		*/
+		pci_read_config_dword(dev, INTEL_CIPINTRC_CFG_OFFSET,
+				      &pci_config_dword);
+		pci_config_dword |= INTEL_CIPINTRC_DIS_INTX_ICH;
+		pci_write_config_dword(dev, INTEL_CIPINTRC_CFG_OFFSET,
+				       pci_config_dword);
+		break;
+	default:
+		return;
+	}
 	pci_info(dev, "disabled boot interrupts on device [%04x:%04x]\n",
 		 dev->vendor, dev->device);
 }
-DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_ESB_10,	quirk_disable_intel_boot_interrupt);
-DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,   PCI_DEVICE_ID_INTEL_ESB_10,	quirk_disable_intel_boot_interrupt);
+/*
+ * Device 29 Func 5 Device IDs of IO-APIC
+ * containing ABAR—APIC1 Alternate Base Address Register
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB_10,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	PCI_DEVICE_ID_INTEL_ESB_10,
+		quirk_disable_intel_boot_interrupt);
+
+/*
+ * Device 5 Func 0 Device IDs of Core IO modules/hubs
+ * containing Coherent Interface Protocol Interrupt Control
+ *
+ * Device IDs obtained from volume 2 datasheets of commented
+ * families above.
+ */
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x3c28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x0e28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2f28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x6f28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_FINAL(PCI_VENDOR_ID_INTEL,	0x2034,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x3c28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x0e28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x2f28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x6f28,
+		quirk_disable_intel_boot_interrupt);
+DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_INTEL,	0x2034,
+		quirk_disable_intel_boot_interrupt);
 
 /* Disable boot interrupts on HT-1000 */
 #define BC_HT1000_FEATURE_REG		0x64
-- 
2.25.1

