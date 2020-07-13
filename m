Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 288F021E0ED
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jul 2020 21:44:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgGMTow (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jul 2020 15:44:52 -0400
Received: from mga05.intel.com ([192.55.52.43]:1454 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgGMTow (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jul 2020 15:44:52 -0400
IronPort-SDR: t6Sl3++gpnEHHj1eQ4lWdQdp/CdCylJExKKpxQV50mS+32pIRe418aeOUkGSZ4V5IXjBJ45Iw9
 orIyou9y0Ndg==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="233561344"
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="233561344"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 12:44:41 -0700
IronPort-SDR: eAVmmHlMoZqsUPOoA0xyxO5wxxWmNHplvv1EgZePErq0DBBvTT3VGysTzZNkwkjRWJcivZ57/Y
 GlTajnG6kvfg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,348,1589266800"; 
   d="scan'208";a="316159779"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga008.jf.intel.com with ESMTP; 13 Jul 2020 12:44:39 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 36914F2; Mon, 13 Jul 2020 22:44:37 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-pci@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/2] x86/PCI: Get rid of custom x86 model comparison
Date:   Mon, 13 Jul 2020 22:44:36 +0300
Message-Id: <20200713194437.11325-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Switch the platform code to use x86_id_table and accompanying API
instead of custom comparison against x86 CPU model.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/pci/intel_mid_pci.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/arch/x86/pci/intel_mid_pci.c b/arch/x86/pci/intel_mid_pci.c
index 00c62115f39c..d8af4787e616 100644
--- a/arch/x86/pci/intel_mid_pci.c
+++ b/arch/x86/pci/intel_mid_pci.c
@@ -28,10 +28,12 @@
 #include <linux/io.h>
 #include <linux/smp.h>
 
+#include <asm/cpu_device_id.h>
 #include <asm/segment.h>
 #include <asm/pci_x86.h>
 #include <asm/hw_irq.h>
 #include <asm/io_apic.h>
+#include <asm/intel-family.h>
 #include <asm/intel-mid.h>
 
 #define PCIE_CAP_OFFSET	0x100
@@ -211,9 +213,16 @@ static int pci_write(struct pci_bus *bus, unsigned int devfn, int where,
 			       where, size, value);
 }
 
+static const struct x86_cpu_id intel_mid_cpu_ids[] = {
+	X86_MATCH_INTEL_FAM6_MODEL(ATOM_SILVERMONT_MID, NULL),
+	{}
+};
+
 static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 {
+	const struct x86_cpu_id *id;
 	struct irq_alloc_info info;
+	u16 model = 0;
 	int polarity;
 	int ret;
 	u8 gsi;
@@ -227,8 +236,12 @@ static int intel_mid_pci_irq_enable(struct pci_dev *dev)
 		return ret;
 	}
 
-	switch (intel_mid_identify_cpu()) {
-	case INTEL_MID_CPU_CHIP_TANGIER:
+	id = x86_match_cpu(intel_mid_cpu_ids);
+	if (id)
+		model = id->model;
+
+	switch (model) {
+	case INTEL_FAM6_ATOM_SILVERMONT_MID:
 		polarity = IOAPIC_POL_HIGH;
 
 		/* Special treatment for IRQ0 */
-- 
2.27.0

