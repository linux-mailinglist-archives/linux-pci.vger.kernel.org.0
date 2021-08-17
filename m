Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3074E3EF5DA
	for <lists+linux-pci@lfdr.de>; Wed, 18 Aug 2021 00:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234828AbhHQWnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Aug 2021 18:43:23 -0400
Received: from mga14.intel.com ([192.55.52.115]:15594 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236063AbhHQWnV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 17 Aug 2021 18:43:21 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10079"; a="215940914"
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="215940914"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2021 15:42:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.84,330,1620716400"; 
   d="scan'208";a="573066699"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 17 Aug 2021 15:42:46 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id AF018580975;
        Tue, 17 Aug 2021 15:42:46 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     lee.jones@linaro.org, hdegoede@redhat.com, mgross@linux.intel.com,
        bhelgaas@google.com, srinivas.pandruvada@intel.com,
        andy.shevchenko@gmail.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v2 4/5] platform/x86: intel_pmt_telemetry: Ignore zero sized entries
Date:   Tue, 17 Aug 2021 15:40:17 -0700
Message-Id: <20210817224018.1013192-5-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210817224018.1013192-1-david.e.box@linux.intel.com>
References: <20210817224018.1013192-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some devices may expose non-functioning entries that are reserved for
future use. These entries have zero size. Ignore them during probe.

Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---

V2:	New patch

 drivers/platform/x86/intel/pmt/telemetry.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/platform/x86/intel/pmt/telemetry.c b/drivers/platform/x86/intel/pmt/telemetry.c
index 3559f6e7b388..d93d02672679 100644
--- a/drivers/platform/x86/intel/pmt/telemetry.c
+++ b/drivers/platform/x86/intel/pmt/telemetry.c
@@ -61,6 +61,14 @@ static int pmt_telem_header_decode(struct intel_pmt_entry *entry,
 	/* Size is measured in DWORDS, but accessor returns bytes */
 	header->size = TELEM_SIZE(readl(disc_table));
 
+	/*
+	 * Some devices may expose non-functioning entries that are
+	 * reserved for future use. They have zero size. Do not fail
+	 * probe for these. Just ignore them.
+	 */
+	if (header->size == 0)
+		return 1;
+
 	return 0;
 }
 
-- 
2.25.1

