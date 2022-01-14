Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D650D48E17A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Jan 2022 01:28:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiANA2N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 13 Jan 2022 19:28:13 -0500
Received: from mga04.intel.com ([192.55.52.120]:24454 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230491AbiANA2N (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 13 Jan 2022 19:28:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642120093; x=1673656093;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T53454V8nQ4gSGGOXNzK4CkJUyzEgeyk3LttBFKGHco=;
  b=MxvfG6B6KFAmmEhdFefFUERBOnvXOY3MGRL1t5uIYwgRJnBKebshuNNN
   m45y2K1pPDVtA7+vFAe/CbV7uTDmd4kUTQSvYEEQyRTJysK7Q96mrEuNw
   DCZXwUv/DlXthm2RkKB2k5OfJzIXjTJy25iqEr7SE7O8CiayZpsw1kal1
   s4ohVmsRNuA3XlWtKiF9YqUEtVYZtvvqNRvkfcN30XHAKH3j9F+Ze4NAL
   dcekFHNVYiMcBHugdbsiZlcKJtwBTA5CJNdcIlp1Qf6gS7c1aPNGyOuSO
   2RbzFVVaN00+iTI3EY15ee3D4XcftnC8akj31770seoHTsY3xll8VIbly
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10226"; a="242964240"
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="242964240"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2022 16:28:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,287,1635231600"; 
   d="scan'208";a="491317605"
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
Subject: [PATCH v5 3/5] x86/quirks: Stop using QFLAG_APPLY_ONCE in nvidia_bugs()
Date:   Thu, 13 Jan 2022 16:28:41 -0800
Message-Id: <20220114002843.2083382-3-lucas.demarchi@intel.com>
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
However, contrary to intel_graphics_quirks(), here we always set it as
applied as soon as it's called to avoid changing the current behavior
that is not failing.

This is the last user of the flags, so we can cleanup the early-quirks,
removing all the flags logic later.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---
 arch/x86/kernel/early-quirks.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index 59cc67aace93..7c70977737de 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -88,6 +88,13 @@ static void __init nvidia_bugs(int num, int slot, int func)
 {
 #ifdef CONFIG_ACPI
 #ifdef CONFIG_X86_IO_APIC
+	static bool quirk_applied __initdata;
+
+	if (quirk_applied)
+		return;
+
+	quirk_applied = true;
+
 	/*
 	 * Only applies to Nvidia root ports (bus 0) and not to
 	 * Nvidia graphics cards with PCI ports on secondary buses.
@@ -702,7 +709,7 @@ struct chipset {
 
 static struct chipset early_qrk[] __initdata = {
 	{ PCI_VENDOR_ID_NVIDIA, PCI_ANY_ID,
-	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, QFLAG_APPLY_ONCE, nvidia_bugs },
+	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, 0, nvidia_bugs },
 	{ PCI_VENDOR_ID_VIA, PCI_ANY_ID,
 	  PCI_CLASS_BRIDGE_PCI, PCI_ANY_ID, 0, via_bugs },
 	{ PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_K8_NB,
-- 
2.34.1

