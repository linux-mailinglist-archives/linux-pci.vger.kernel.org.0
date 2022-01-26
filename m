Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCB749C304
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jan 2022 06:24:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbiAZFYG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jan 2022 00:24:06 -0500
Received: from mga11.intel.com ([192.55.52.93]:26029 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232517AbiAZFYG (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jan 2022 00:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643174646; x=1674710646;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jikdn5aUxL1fQVhM2z1NpcZFt/8C4df5jyvo0XW+XDA=;
  b=Bf3Y1+FmdHwgisrDOEs55fkbkBvauK7KfXec0KBZFl/EwY6SUNiSQvqb
   UG9O0HwqL2LhrRAC4AZioqdiE5HuGF6RLop7+Qk+5I63hJR6AueTj/br6
   B4NljwH/dfPKa5LFgDSbXNOp97NIn23nh42b99iO64tpQ4DDuRNrNDJ+R
   6rz5E9uJYkXRDubXKZYjCI1JnlSf5De4FhEMrV2e+J7aNey3Z0yKFOPUX
   zmbdkhyA4FZCdWzAJJJ5ZJmt6Gb8xdv7PLbo5wdpIMk1W5D+xSXdSVA3M
   Mw2U7Isj9hk2p5WAf8Omg4k4lKBIANfwLRNGsFPo3Tu/+R+hcVFrYh8Rd
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10238"; a="244082433"
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="244082433"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 21:24:04 -0800
X-IronPort-AV: E=Sophos;i="5.88,316,1635231600"; 
   d="scan'208";a="563305708"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jan 2022 21:24:04 -0800
Subject: [PATCH 1/2] cxl/core/port: Fix / relax decoder target enumeration
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev,
        ben.widawsky@intel.com
Date:   Tue, 25 Jan 2022 21:24:04 -0800
Message-ID: <164317464406.3438644.6609329492458460242.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164317463887.3438644.4087819721493502301.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164317463887.3438644.4087819721493502301.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If the decoder is not presently active the target_list may not be
accurate. Perform a best effort mapping and assume that it will be fixed
up when the decoder is enabled.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |    2 +-
 drivers/cxl/core/port.c |    5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index df6691d0a6d0..f64d98bfcb3b 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -15,7 +15,7 @@
 
 static unsigned long cfmws_to_decoder_flags(int restrictions)
 {
-	unsigned long flags = 0;
+	unsigned long flags = CXL_DECODER_F_ENABLE;
 
 	if (restrictions & ACPI_CEDT_CFMWS_RESTRICT_TYPE2)
 		flags |= CXL_DECODER_F_TYPE2;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index 224a4853a33e..e75e0d4fb894 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -1263,8 +1263,11 @@ int cxl_decoder_add_locked(struct cxl_decoder *cxld, int *target_map)
 	port = to_cxl_port(cxld->dev.parent);
 	if (!is_endpoint_decoder(dev)) {
 		rc = decoder_populate_targets(cxld, port, target_map);
-		if (rc)
+		if (rc && (cxld->flags & CXL_DECODER_F_ENABLE)) {
+			dev_err(&port->dev,
+				"Failed to populate active decoder targets\n");
 			return rc;
+		}
 	}
 
 	rc = dev_set_name(dev, "decoder%d.%d", port->id, cxld->id);

