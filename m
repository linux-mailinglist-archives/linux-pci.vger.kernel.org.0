Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9C487DF9
	for <lists+linux-pci@lfdr.de>; Fri,  7 Jan 2022 22:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229695AbiAGVFM (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 7 Jan 2022 16:05:12 -0500
Received: from mga11.intel.com ([192.55.52.93]:64400 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229712AbiAGVFL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 7 Jan 2022 16:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641589511; x=1673125511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BGkQZ9wJjtm6Ly24SCm04Vr1byx/zgNEgihwQDGEf9k=;
  b=S4eo3903rALxYm3/ehF6XcM4FVYnz2NLYZ0UED4SqOTIzo8HcoKlLHLs
   pQenFHnpE5gtTksv+Eml1Q4omYLhqVCwSWRy6dKLVOXp8rVxdwWv15itg
   QyQR90BE6/ERhgH5O4JSRfoAqLvDgzVyQOCdPcR5IiXVS/l/SuI5V6sy5
   R33BoAaNuem5xcApAyLErJOvgagJPhMpOgLlRiys2M+9MkJkX6n9AMa5L
   OtTSRhYsUD+oX9fXNJoGSgUjvQ3bUz8XACza+/MgJJ0J1BewNwVCfvg/e
   4OW/w0EsTvtS5o0Fluw+kjpx8lSKeInHB2P0o5S8U1CXE2InqrszIs58l
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10220"; a="240493450"
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="240493450"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 13:04:51 -0800
X-IronPort-AV: E=Sophos;i="5.88,271,1635231600"; 
   d="scan'208";a="527506817"
Received: from lucas-s2600cw.jf.intel.com ([10.165.21.202])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2022 13:04:51 -0800
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     x86@kernel.org
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= 
        <ville.syrjala@linux.intel.com>,
        Matt Roper <matthew.d.roper@intel.com>
Subject: [PATCH v3 3/3] x86/quirks: Fix stolen detection with integrated + discrete GPU
Date:   Fri,  7 Jan 2022 13:05:16 -0800
Message-Id: <20220107210516.907834-3-lucas.demarchi@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220107210516.907834-1-lucas.demarchi@intel.com>
References: <20220107210516.907834-1-lucas.demarchi@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

early_pci_scan_bus() does a depth-first traversal, possibly calling
the quirk functions for each device based on vendor, device and class
from early_qrk table. intel_graphics_quirks() however uses PCI_ANY_ID
and does additional filtering in the quirk.

If there is an Intel integrated + discrete GPU the quirk may be called
first for the discrete GPU based on the PCI topology. Then we will fail
to reserve the system stolen memory for the integrated GPU, because we
will already have marked the quirk as "applied".

This was reproduced in a setup with Alderlake-P (integrated) + DG2
(discrete), with the following PCI topology:

	- 00:01.0 Bridge
	  `- 03:00.0 DG2
	- 00:02.0 Integrated GPU

Move the setting of quirk_applied in intel_graphics_quirks() so it's
mark as applied only when we find the integrated GPU based on the
intel_early_ids table.

Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
---

v3: now that we do the refactor before the fix, we can do a single line
change to fix intel_graphics_quirks(). Also, we don't change
intel_graphics_stolen() anymore as we did in v2: we don't have to check
other devices anymore if there was a previous match causing
intel_graphics_stolen() to be called (there can only be one integrated
GPU reserving the stolen memory).

 arch/x86/kernel/early-quirks.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index df34963e23bf..932f9087c324 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -609,8 +609,6 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
 	if (quirk_applied)
 		return;
 
-	quirk_applied = true;
-
 	device = read_pci_config_16(num, slot, func, PCI_DEVICE_ID);
 
 	for (i = 0; i < ARRAY_SIZE(intel_early_ids); i++) {
@@ -623,6 +621,8 @@ static void __init intel_graphics_quirks(int num, int slot, int func)
 
 		intel_graphics_stolen(num, slot, func, early_ops);
 
+		quirk_applied = true;
+
 		return;
 	}
 }
-- 
2.34.1

