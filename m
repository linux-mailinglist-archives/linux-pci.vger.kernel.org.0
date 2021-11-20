Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B294579E5
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbhKTAGN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:06:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:5726 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232763AbhKTAGJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:06:09 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="214542401"
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="214542401"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:56 -0800
X-IronPort-AV: E=Sophos;i="5.87,248,1631602800"; 
   d="scan'208";a="496088357"
Received: from jfaistl-mobl1.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.139.58])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 16:02:56 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 07/23] cxl/pci: Add new DVSEC definitions
Date:   Fri, 19 Nov 2021 16:02:34 -0800
Message-Id: <20211120000250.1663391-8-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211120000250.1663391-1-ben.widawsky@intel.com>
References: <20211120000250.1663391-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While the new definitions are yet necessary at this point, they are
introduced at this point to help solidify the newly minted schema for
naming registers.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>

---
This was split from
https://lore.kernel.org/linux-cxl/20211103170552.55ae5u7uvurkync6@intel.com/T/#u
per Dan's request.
---
 drivers/cxl/pci.h | 15 +++++++++++++++
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
-- 
2.34.0

