Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C36D24D5F21
	for <lists+linux-pci@lfdr.de>; Fri, 11 Mar 2022 11:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345416AbiCKKIK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 05:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347753AbiCKKH4 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 05:07:56 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCE101BE4E9
        for <linux-pci@vger.kernel.org>; Fri, 11 Mar 2022 02:06:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646993213; x=1678529213;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=hGdzBQspiIW+290EEsn33TDuZWp7ZpdyjMsUCgHyjG8=;
  b=NjrK2WT/Aohh0YPBAMfcSZyH3f7x+blC1IYo+XkCocy0NRjpduMyFyrg
   XUduyPoVgAFETeCfcvAg+FjZctG9F1glPZELRhOvDZ82frzffRfXJkc/k
   5F6N4HtTDeNdBl/U/bdRpBPQH0tAMMPqP2mJ16L6NplMePMsu3GsOphMc
   NcvXwHNNnn9YjPCG/vz+wCOASu/Rzb9zix5/zj5dT79D3WIDzpBxtbnJe
   MK48qbsr3pNtL3P1WbONMYElPfhUiXghMoAdydHxUC6GdDdYoJRzsG7Da
   Or0LworBIkY+lLHMDGw8lTmEuTTsz8dDviQT9jNUR0QjJFJEKdLg2gTz4
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10282"; a="280287487"
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="280287487"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 02:06:53 -0800
X-IronPort-AV: E=Sophos;i="5.90,173,1643702400"; 
   d="scan'208";a="538949814"
Received: from cchitora-mobl.ger.corp.intel.com (HELO localhost) ([10.252.46.187])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2022 02:06:51 -0800
From:   Jani Nikula <jani.nikula@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        x86@kernel.org, jani.nikula@intel.com
Subject: [PATCH 2/2] drm/i915: include uapi/drm/i915_drm.h directly where needed
Date:   Fri, 11 Mar 2022 12:06:39 +0200
Message-Id: <20220311100639.114685-2-jani.nikula@intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220311100639.114685-1-jani.nikula@intel.com>
References: <20220311100639.114685-1-jani.nikula@intel.com>
MIME-Version: 1.0
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove the uapi/drm/i915_drm.h include from drm/i915_drm.h, and stop
being a proxy for uapi/drm/i915_drm.h. Include uapi/drm/i915_drm.h and
drm/i915_drm.h only where needed.

Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_lmem.c     | 2 ++
 drivers/gpu/drm/i915/gem/i915_gem_region.c   | 2 ++
 drivers/gpu/drm/i915/intel_memory_region.c   | 2 ++
 drivers/gpu/drm/i915/intel_memory_region.h   | 2 +-
 drivers/gpu/drm/i915/pxp/intel_pxp_session.c | 2 --
 include/drm/i915_drm.h                       | 2 +-
 6 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_lmem.c b/drivers/gpu/drm/i915/gem/i915_gem_lmem.c
index 444f8268b9c5..ede084f36ca9 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_lmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_lmem.c
@@ -3,6 +3,8 @@
  * Copyright © 2019 Intel Corporation
  */
 
+#include <uapi/drm/i915_drm.h>
+
 #include "intel_memory_region.h"
 #include "gem/i915_gem_region.h"
 #include "gem/i915_gem_lmem.h"
diff --git a/drivers/gpu/drm/i915/gem/i915_gem_region.c b/drivers/gpu/drm/i915/gem/i915_gem_region.c
index c9b2e8b91053..f4fbae2f9dcc 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_region.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_region.c
@@ -3,6 +3,8 @@
  * Copyright © 2019 Intel Corporation
  */
 
+#include <uapi/drm/i915_drm.h>
+
 #include "intel_memory_region.h"
 #include "i915_gem_region.h"
 #include "i915_drv.h"
diff --git a/drivers/gpu/drm/i915/intel_memory_region.c b/drivers/gpu/drm/i915/intel_memory_region.c
index 1c841f68169a..ded78b83e0b5 100644
--- a/drivers/gpu/drm/i915/intel_memory_region.c
+++ b/drivers/gpu/drm/i915/intel_memory_region.c
@@ -5,6 +5,8 @@
 
 #include <linux/prandom.h>
 
+#include <uapi/drm/i915_drm.h>
+
 #include "intel_memory_region.h"
 #include "i915_drv.h"
 #include "i915_ttm_buddy_manager.h"
diff --git a/drivers/gpu/drm/i915/intel_memory_region.h b/drivers/gpu/drm/i915/intel_memory_region.h
index 21dcbd620758..bbc35ec5c090 100644
--- a/drivers/gpu/drm/i915/intel_memory_region.h
+++ b/drivers/gpu/drm/i915/intel_memory_region.h
@@ -10,7 +10,7 @@
 #include <linux/mutex.h>
 #include <linux/io-mapping.h>
 #include <drm/drm_mm.h>
-#include <drm/i915_drm.h>
+#include <uapi/drm/i915_drm.h>
 
 struct drm_i915_private;
 struct drm_i915_gem_object;
diff --git a/drivers/gpu/drm/i915/pxp/intel_pxp_session.c b/drivers/gpu/drm/i915/pxp/intel_pxp_session.c
index 598840b73dfa..92b00b4de240 100644
--- a/drivers/gpu/drm/i915/pxp/intel_pxp_session.c
+++ b/drivers/gpu/drm/i915/pxp/intel_pxp_session.c
@@ -3,8 +3,6 @@
  * Copyright(c) 2020, Intel Corporation. All rights reserved.
  */
 
-#include <drm/i915_drm.h>
-
 #include "i915_drv.h"
 
 #include "intel_pxp.h"
diff --git a/include/drm/i915_drm.h b/include/drm/i915_drm.h
index afbf3ef5643e..7adce327c1c2 100644
--- a/include/drm/i915_drm.h
+++ b/include/drm/i915_drm.h
@@ -26,7 +26,7 @@
 #ifndef _I915_DRM_H_
 #define _I915_DRM_H_
 
-#include <uapi/drm/i915_drm.h>
+#include <linux/types.h>
 
 /* For use by IPS driver */
 unsigned long i915_read_mch_val(void);
-- 
2.30.2

