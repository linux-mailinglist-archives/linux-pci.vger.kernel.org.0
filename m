Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 810C84D5F1E
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 11:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiCKKIJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 05:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347571AbiCKKHv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 05:07:51 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C72431BF910
        for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2022 02:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646993208; x=1678529208;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tcb0awIFqKevEQXb7Bu45BtCNoGl1aqkIfpE0YCMK60=;
  b=W7FVYzhik+drYNHVQ6kpGCFfneYMhMs4rOKoJcWqtdBSv9QWA4UOuY54
   8sySEq346EBurSgIDQxl/SBtvkyEDdjxPh97ZMTnXBJIfOfWaWHuZ6gie
   BgF0CxQgUHYxSkzk11wGYf56J680okXuJv6GVygQuYfy7imphfu6Gg9oB
   Ri0jFw1ejpHyDNlCrCYbA1kKfiX6eSk2gvQpV/RChvc7dDZ1516HwnP75
   FTbkQkkLGgtQa7Cy0+++AuHA5ecZ9ov7sB1eoemgFaCAFN7wGL2rEmbRt
   5x+I8QF1cqZwToJ2PEG3ZlC7lcAU0z0GAHxQfltLe52Io16cGzxEhBG4k
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="253107516"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="253107516"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 02:06:48 -0800
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="555245657"
Received: from cchitora-mobl.ger.corp.intel.com (HELO localhost) ([10.252.46.187])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 02:06:46 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, jani.nikula@intel.com
Subject: [PATCH 1/2] x86/gpu: include drm/i915_pciids.h directly in early quirks
Date:   Fri, 11 Mar 2022 12:06:38 +0200
Message-Id: <20220311100639.114685-1-jani.nikula@intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

early-quirks.c is the only user of drm/i915_drm.h that also needs
drm/i915_pciids.h. Include the masses of PCI ID macros only where
needed.

Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org
Cc: x86@kernel.org
Signed-off-by: Jani Nikula <jani.nikula@intel.com>

---

I'm hoping to merge this via drm-intel with the other patch.
---
 arch/x86/kernel/early-quirks.c | 1 +
 include/drm/i915_drm.h         | 1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/early-quirks.c b/arch/x86/kernel/early-quirks.c
index bd6dad83c65b..805596736e20 100644
--- a/arch/x86/kernel/early-quirks.c
+++ b/arch/x86/kernel/early-quirks.c
@@ -18,6 +18,7 @@
 #include <linux/bcma/bcma_regs.h>
 #include <linux/platform_data/x86/apple.h>
 #include <drm/i915_drm.h>
+#include <drm/i915_pciids.h>
 #include <asm/pci-direct.h>
 #include <asm/dma.h>
 #include <asm/io_apic.h>
diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
index 6722005884db..afbf3ef5643e 100644
--- a/include/drm/i915_drm.h
+++ b/include/drm/i915_drm.h
@@ -26,7 +26,6 @@
 #ifndef _I915_DRM_H_
 #define _I915_DRM_H_
 
-#include <drm/i915_pciids.h>
 #include <uapi/drm/i915_drm.h>
 
 /* For use by IPS driver */
-- 
2.30.2

