Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C585048E179
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 01:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238409AbiANA2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 19:28:15 -0500
Received: from mga04.intel.com ([192.55.52.120]:24454 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbiANA2N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jan 2022 19:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642120093; x=1673656093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IQ2QQ/cS+ncHjNfC6BsTxJSLJNhPyLYfEjqhOLdZvlw=;
  b=H8PagfavtSHIQ90UqgOdV9aHCEIfLJt6Ijk6GhsnnivFo24F7ih2Oqlx
   fjZIneSCjOz3lcnqyNBlvkHpEQUeUm7HhC4D5A8GZKlQfTGcyuSBu+srj
   drp6dvzi02+iETZVaVXnf7xBnQ2vlt5U2Z5riglPNMrabzbKNig6Gh91M
   VOs2hBLjqbIyzEWTF6CSUlHNtBaHbJzSEOCLYCVAYmtJLsBWTbxUpKYX8
   c+yjmBM8IgNpEzOdtEhR0GhlsHn23IGbMVOPDTouMRXbZKzUUCk7aYKU2
   kKZt8FOx23HAjwSQjoCJYOrV682T6yApfUbE5PMAAog4RchW1qheZJtnb
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="242964243"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="242964243"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 16:28:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="491317608"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 16:28:12 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v5 4/5] x86/quirks: Remove unused logic for flags
Date:   Thu, 13 Jan 2022 16:28:42 -0800
Message-Id: <20220114002843.2083382-4-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114002843.2083382-1-lucas.demarchi@intel.com>
References: <20220114002843.2083382-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The flags were only used to mark the quirk as applied when it was
requested to be called only once. Now all the users were converted to
use a static local variable, so this logic can be removed.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 arch/x86/kernel/early-quirks.c | 35 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 7c70977737de..1db4d92f8a85 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -695,37 +695,33 @@ static void __init apple_airport_reset(int bus, int slot, int func)
 	early_iounmap(mmio, BCM4331_MMIO_SIZE);
 }
 
-#define QFLAG_APPLY_ONCE 	0x1
-#define QFLAG_APPLIED		0x2
-#define QFLAG_DONE		(QFLAG_APPLY_ONCE|QFLAG_APPLIED)
 struct chipset {
 	u32 vendor;
 	u32 device;
 	u32 class;
 	u32 class_mask;
-	u32 flags;
 	void (*f)(int num, int slot, int func);
 };
 
 static struct chipset early_qrk[] __initdata = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, 0, nvidia_bugs },
+	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, nvidia_bugs },
 	{ PCI_VENDOR_ID_VIA, PCI_ANY_ID,
-	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, 0, via_bugs },
+	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, via_bugs },
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB,
-	  PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, fix_hypertransport_config },
+	  PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, fix_hypertransport_config },
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS,
-	  PCI_CLASS_SERIAL_SMBUS, PCI_ANY_ID, 0, ati_bugs },
+	  PCI_CLASS_SERIAL_SMBUS, PCI_ANY_ID, ati_bugs },
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_SBX00_SMBUS,
-	  PCI_CLASS_SERIAL_SMBUS, PCI_ANY_ID, 0, ati_bugs_contd },
+	  PCI_CLASS_SERIAL_SMBUS, PCI_ANY_ID, ati_bugs_contd },
 	{ PCI_VENDOR_ID_INTEL, 0x3403, PCI_CLASS_BRIDGE_HOST,
-	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
+	  PCI_BASE_CLASS_BRIDGE, intel_remapping_check },
 	{ PCI_VENDOR_ID_INTEL, 0x3405, PCI_CLASS_BRIDGE_HOST,
-	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
+	  PCI_BASE_CLASS_BRIDGE, intel_remapping_check },
 	{ PCI_VENDOR_ID_INTEL, 0x3406, PCI_CLASS_BRIDGE_HOST,
-	  PCI_BASE_CLASS_BRIDGE, 0, intel_remapping_check },
+	  PCI_BASE_CLASS_BRIDGE, intel_remapping_check },
 	{ PCI_VENDOR_ID_INTEL, PCI_ANY_ID, PCI_CLASS_DISPLAY_VGA, PCI_ANY_ID,
-	  0, intel_graphics_quirks },
+	  intel_graphics_quirks },
 	/*
 	 * HPET on the current version of the Baytrail platform has accuracy
 	 * problems: it will halt in deep idle state - so we disable it.
@@ -735,9 +731,9 @@ static struct chipset early_qrk[] __initdata = {
 	 *    http://www.intel.com/content/dam/www/public/us/en/documents/datasheets/atom-z8000-datasheet-vol-1.pdf
 	 */
 	{ PCI_VENDOR_ID_INTEL, 0x0f00,
-		PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, force_disable_hpet},
+	  PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, force_disable_hpet},
 	{ PCI_VENDOR_ID_BROADCOM, 0x4331,
-	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, 0, apple_airport_reset},
+	  PCI_CLASS_NETWORK_OTHER, PCI_ANY_ID, apple_airport_reset},
 	{}
 };
 
@@ -778,12 +774,9 @@ static int __init check_dev_quirk(int num, int slot, int func)
 			((early_qrk[i].device == PCI_ANY_ID) ||
 			(early_qrk[i].device == device)) &&
 			(!((early_qrk[i].class ^ class) &
-			    early_qrk[i].class_mask))) {
-				if ((early_qrk[i].flags &
-				     QFLAG_DONE) != QFLAG_DONE)
-					early_qrk[i].f(num, slot, func);
-				early_qrk[i].flags |= QFLAG_APPLIED;
-			}
+			    early_qrk[i].class_mask)))
+				early_qrk[i].f(num, slot, func);
+
 	}
 
 	type = read_pci_config_byte(num, slot, func,
-- 
2.34.1

