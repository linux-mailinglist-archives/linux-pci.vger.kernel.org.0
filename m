Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C7834152CA
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 23:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238042AbhIVVbl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 Sep 2021 17:31:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:45002 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237852AbhIVVbj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 Sep 2021 17:31:39 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10115"; a="203202709"
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="203202709"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2021 14:30:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.85,315,1624345200"; 
   d="scan'208";a="435588456"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 22 Sep 2021 14:30:08 -0700
Received: from debox1-server.jf.intel.com (debox1-server.jf.intel.com [10.54.39.121])
        by linux.intel.com (Postfix) with ESMTP id EBE1E580C8B;
        Wed, 22 Sep 2021 14:30:07 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, bhelgaas@google.com,
        andy.shevchenko@gmail.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        mgross@linux.intel.com, srinivas.pandruvada@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 5/5] MFD: intel_extended_cap: Add support for Intel SDSi
Date:   Wed, 22 Sep 2021 14:30:07 -0700
Message-Id: <20210922213007.2738388-6-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210922213007.2738388-1-david.e.box@linux.intel.com>
References: <20210922213007.2738388-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Adds platform device support for the Intel Software Defined Silicon (SDSi)
device.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V3:	New patch

 drivers/mfd/intel_pmt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mfd/intel_pmt.c b/drivers/mfd/intel_pmt.c
index a6fe50f65479..5d9adcfa67db 100644
--- a/drivers/mfd/intel_pmt.c
+++ b/drivers/mfd/intel_pmt.c
@@ -30,6 +30,7 @@
 #define INTEL_EXT_CAP_ID_TELEMETRY	2
 #define INTEL_EXT_CAP_ID_WATCHER	3
 #define INTEL_EXT_CAP_ID_CRASHLOG	4
+#define INTEL_EXT_CAP_ID_SDSI		65
 
 #define INTEL_EXT_CAP_PREFIX		"intel_extnd_cap"
 #define FEATURE_ID_NAME_LENGTH		25
@@ -38,6 +39,7 @@ static int intel_ext_cap_allow_list[] = {
 	INTEL_EXT_CAP_ID_TELEMETRY,
 	INTEL_EXT_CAP_ID_WATCHER,
 	INTEL_EXT_CAP_ID_CRASHLOG,
+	INTEL_EXT_CAP_ID_SDSI,
 };
 
 struct intel_ext_cap_header {
-- 
2.25.1

