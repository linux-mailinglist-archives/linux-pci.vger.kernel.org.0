Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCC15497679
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:29:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240575AbiAXA3G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:29:06 -0500
Received: from mga04.intel.com ([192.55.52.120]:41976 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240573AbiAXA3G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:29:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984146; x=1674520146;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MB2ZlF2aFSyfgNxgC0TuBkMRoRB/3utmmeKBUVvXP34=;
  b=GJkoBnCH+bdGaR4rV/mTHDTH0/rpN+w00SRBBhUc0wZwURKRSOdYAIn+
   GXLkmCUxOfA2nDraNejU+5ElQq1N113psbx/FLhcbHx1IM+J7l2Ty+uYh
   RO8gE1Pp0wD2Gu415TZWNWBVYqgWk4zo9tZPckQ1Hr9wRgs6eg58l4kI9
   anVSheRuoT8hcv5pxhekAXF7XjiiQifHVIpz55gYwT15mB0byLUpsUnFV
   nN/2HiJQMe1iRp0awRhT0PjabA6jgJ5FQtiU9oiY5qLQmk7YmudbQcH5V
   JBjf0jkHahvO7SWEU7mgH5DbX50oUWhV3FYwG5PEEHURfjFn4Yqrmwj07
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="244766484"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="244766484"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:06 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="533999595"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:05 -0800
Subject: [PATCH v3 05/40] cxl/pci: Add new DVSEC definitions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Jonathan Cameron <Jonathan.Cameron@huwei.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:29:05 -0800
Message-ID: <164298414567.3018233.12005290051592771878.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

In preparation for properly supporting memory active timeout, and later
on, other attributes obtained from DVSEC fields, add the full list of
DVSEC identifiers from the CXL 2.0 specification.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huwei.com> (v1)
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.h |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 29b8eaef3a0a..8ae2b4adc59d 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -16,6 +16,21 @@
 /* CXL 2.0 8.1.3: PCIe DVSEC for CXL Device */
 #define CXL_DVSEC_PCIE_DEVICE					0
 
+/* CXL 2.0 8.1.4: Non-CXL Function Map DVSEC */
+#define CXL_DVSEC_FUNCTION_MAP					2
+
+/* CXL 2.0 8.1.5: CXL 2.0 Extensions DVSEC for Ports */
+#define CXL_DVSEC_PORT_EXTENSIONS				3
+
+/* CXL 2.0 8.1.6: GPF DVSEC for CXL Port */
+#define CXL_DVSEC_PORT_GPF					4
+
+/* CXL 2.0 8.1.7: GPF DVSEC for CXL Device */
+#define CXL_DVSEC_DEVICE_GPF					5
+
+/* CXL 2.0 8.1.8: PCIe DVSEC for Flex Bus Port */
+#define CXL_DVSEC_PCIE_FLEXBUS_PORT				7
+
 /* CXL 2.0 8.1.9: Register Locator DVSEC */
 #define CXL_DVSEC_REG_LOCATOR					8
 #define   CXL_DVSEC_REG_LOCATOR_BLOCK1_OFFSET			0xC

