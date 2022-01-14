Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7D048E178
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 01:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235600AbiANA2O (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 19:28:14 -0500
Received: from mga04.intel.com ([192.55.52.120]:24454 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238409AbiANA2N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jan 2022 19:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642120093; x=1673656093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gChLAsxaUfo34M70y3IYu5wvatIKFodsmuRuEKDfuLg=;
  b=FsFnL49Lhl0zy/uwRcluJuiLQPP1JEyNYrUUuWj18mhhBQ0YUohMUaOf
   G3W5c9LvM6EV1bYdxEHb0r/rc00tJh6Bs2r1p+oWaMLfq+6j/Q59fDyJa
   9AATWPe/19SgOPTeFN8orGelnKdLDd7/wUZVTF3Y83xFCeeZA+EEFJpHu
   6D9ibBJbPAcLU808OrwWgalrh1muudRmO4Gyn15KR/C8xVR/4StEYq2R6
   ue2M7oUJR7YLh47gBpywFfucgG1qIyoq/ooizxxI7U7gso1lTvOHjix67
   nim16AcB7yR0lLYtKlGv2makvBgzvo9C6xJ4fh2VmimmgpGDhYhrVIKzG
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="242964237"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="242964237"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 16:28:12 -0800
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="491317602"
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
Subject: [PATCH v5 2/5] x86/quirks: Stop using QFLAG_APPLY_ONCE in via_bugs()
Date:   Thu, 13 Jan 2022 16:28:40 -0800
Message-Id: <20220114002843.2083382-2-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220114002843.2083382-1-lucas.demarchi@intel.com>
References: <20220114002843.2083382-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adopt the same approach as in intel_graphics_quirks(), with a static
local variable, to control when the quirk has already been applied.
However, contrary to intel_graphics_quirks() here we always set it as
applied as soon as it's called to avoid changing the current behavior
that is not failing.

After converting other users, it will allow us to remove all the logic
handling the flags.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 arch/x86/kernel/early-quirks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index de9a76eb544e..59cc67aace93 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -57,6 +57,13 @@ static void __init fix_hypertransport_config(int num, int slot, int func)
 static void __init via_bugs(int  num, int slot, int func)
 {
 #ifdef CONFIG_GART_IOMMU
+	static bool quirk_applied __initdata;
+
+	if (quirk_applied)
+		return;
+
+	quirk_applied = true;
+
 	if ((max_pfn > MAX_DMA32_PFN ||  force_iommu) &&
 	    !gart_iommu_aperture_allowed) {
 		printk(KERN_INFO
@@ -697,7 +704,7 @@ static struct chipset early_qrk[] __initdata = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
 	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, QFLAG_APPLY_ONCE, nvidia_bugs },
 	{ PCI_VENDOR_ID_VIA, PCI_ANY_ID,
-	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, QFLAG_APPLY_ONCE, via_bugs },
+	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, 0, via_bugs },
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB,
 	  PCI_CLASS_BRIDGE_HOST, PCI_ANY_ID, 0, fix_hypertransport_config },
 	{ PCI_VENDOR_ID_ATI, PCI_DEVICE_ID_ATI_IXP400_SMBUS,
-- 
2.34.1

