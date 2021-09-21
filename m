Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D973A413D44
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 00:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235887AbhIUWGf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 18:06:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:40124 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234138AbhIUWGe (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Sep 2021 18:06:34 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="223119120"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="223119120"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:04 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="557114660"
Received: from ksankar-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.132.1])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:04 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 1/7] cxl: Convert "RBI" to enum
Date:   Tue, 21 Sep 2021 15:04:53 -0700
Message-Id: <20210921220459.2437386-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921220459.2437386-1-ben.widawsky@intel.com>
References: <20210921220459.2437386-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for passing around the Register Block Indicator (RBI) as
a parameter, it is desirable to convert the type to an enum so that the
interface can use a well defined type checked parameter.

As a result of this change, should future versions of the spec add
sparsely defined identifiers, it could become a problem if checking for
invalid identifiers since the code currently checks for the max
identifier. This is not an issue with current spec, and the algorithm to
obtain the register blocks will change before those possible additions
are made.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.h | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/drivers/cxl/pci.h b/drivers/cxl/pci.h
index 8c1a58813816..7d3e4bf06b45 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/pci.h
@@ -20,13 +20,15 @@
 #define CXL_REGLOC_BIR_MASK GENMASK(2, 0)
 
 /* Register Block Identifier (RBI) */
-#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
-#define CXL_REGLOC_RBI_EMPTY 0
-#define CXL_REGLOC_RBI_COMPONENT 1
-#define CXL_REGLOC_RBI_VIRT 2
-#define CXL_REGLOC_RBI_MEMDEV 3
-#define CXL_REGLOC_RBI_TYPES CXL_REGLOC_RBI_MEMDEV + 1
+enum cxl_regloc_type {
+	CXL_REGLOC_RBI_EMPTY = 0,
+	CXL_REGLOC_RBI_COMPONENT,
+	CXL_REGLOC_RBI_VIRT,
+	CXL_REGLOC_RBI_MEMDEV,
+	CXL_REGLOC_RBI_TYPES
+};
 
+#define CXL_REGLOC_RBI_MASK GENMASK(15, 8)
 #define CXL_REGLOC_ADDR_MASK GENMASK(31, 16)
 
 #endif /* __CXL_PCI_H__ */
-- 
2.33.0

