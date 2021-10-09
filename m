Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F42A427C18
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231727AbhJIQqA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Oct 2021 12:46:00 -0400
Received: from mga04.intel.com ([192.55.52.120]:25894 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231698AbhJIQp7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Oct 2021 12:45:59 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="225447062"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="225447062"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 09:44:02 -0700
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="658138099"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 09:44:02 -0700
Subject: [PATCH v3 01/10] cxl/pci: Convert register block identifiers to an
 enum
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Date:   Sat, 09 Oct 2021 09:44:02 -0700
Message-ID: <163379784199.692348.4366131432595112771.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

In preparation for passing around the Register Block Indicator (RBI) as
a parameter, it is desirable to convert the type to an enum so that the
interface can use a well defined parameter.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
[djbw: changelog fixups ]
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.h |   14 ++++++++------
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

