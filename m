Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E96B39CD93
	for <lists+linux-pci@lfdr.de>; Sun,  6 Jun 2021 08:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230085AbhFFGGt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 6 Jun 2021 02:06:49 -0400
Received: from mga18.intel.com ([134.134.136.126]:52064 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229504AbhFFGGt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 6 Jun 2021 02:06:49 -0400
IronPort-SDR: D/zLAztrEN6+FlB+ItdmL8OtR+/F1IZJ9QIcE+MJd+7OZLJCCUm4X8YHUhUpYA5hsqrv2AvxdX
 Qav83OU7JdaA==
X-IronPort-AV: E=McAfee;i="6200,9189,10006"; a="191813136"
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="191813136"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:04:59 -0700
IronPort-SDR: NNOWA6qAGorn2+jrRSJasOY2vXxooiEZ67MDiZDX/zyEkWltKd5Sh26kocbjIyINkqmbouH/xM
 J4zWQytKhMjg==
X-IronPort-AV: E=Sophos;i="5.83,252,1616482800"; 
   d="scan'208";a="412759165"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jun 2021 23:04:59 -0700
Subject: [PATCH v5 1/6] cxl/acpi: Local definition of ACPICA infrastructure
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Alison Schofield <alison.schofield@intel.com>,
        Erik Kaneda <erik.kaneda@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Date:   Sat, 05 Jun 2021 23:04:58 -0700
Message-ID: <162295949886.1109360.17423894188288323907.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <162295949351.1109360.10329014558746500142.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The recently released CXL specification change (ECN) for the CXL Fixed
Memory Window Structure (CFMWS) extension to the CXL Early Discovery
Table (CEDT) enables a large amount of functionality. It defines the
root of a CXL memory topology and is needed for all OS flows for CXL
provisioning CXL memory expanders. For ease of merging and tree
management add the new ACPI definition locally (drivers/cxl/acpi.h) in
such a way that they will not collide with the eventual arrival of the
definitions through the ACPICA project to their final location
(drivers/acpi/actbl1.h).

The definitions in drivers/cxl/acpi.h can be dropped post -rc1.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Co-developed-by: Alison Schofield <alison.schofield@intel.com>
Co-developed-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Erik Kaneda <erik.kaneda@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.h |   48 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 drivers/cxl/acpi.h

diff --git a/drivers/cxl/acpi.h b/drivers/cxl/acpi.h
new file mode 100644
index 000000000000..1482c19e7227
--- /dev/null
+++ b/drivers/cxl/acpi.h
@@ -0,0 +1,48 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/* Copyright(c) 2021 Intel Corporation. */
+#ifndef __CXL_ACPI_H__
+#define __CXL_ACPI_H__
+
+#ifndef ACPI_CEDT_CHBS_VERSION_CXL20
+/*
+ * NOTE: These definitions are temporary and to be deleted in v5.14-rc1
+ * when the identical definitions become available from
+ * include/acpi/actbl1.h.
+ */
+
+#define ACPI_CEDT_TYPE_CFMWS 1
+#define ACPI_CEDT_TYPE_RESERVED 2
+
+#define ACPI_CEDT_CHBS_VERSION_CXL11 (0)
+#define ACPI_CEDT_CHBS_VERSION_CXL20 (1)
+
+#define ACPI_CEDT_CHBS_LENGTH_CXL11 (0x2000)
+#define ACPI_CEDT_CHBS_LENGTH_CXL20 (0x10000)
+
+struct acpi_cedt_cfmws {
+	struct acpi_cedt_header header;
+	u32 reserved1;
+	u64 base_hpa;
+	u64 window_size;
+	u8 interleave_ways;
+	u8 interleave_arithmetic;
+	u16 reserved2;
+	u32 granularity;
+	u16 restrictions;
+	u16 qtg_id;
+	u32 interleave_targets[];
+};
+
+/* Values for Interleave Arithmetic field above */
+
+#define ACPI_CEDT_CFMWS_ARITHMETIC_MODULO (0)
+
+/* Values for Restrictions field above */
+
+#define ACPI_CEDT_CFMWS_RESTRICT_TYPE2 (1)
+#define ACPI_CEDT_CFMWS_RESTRICT_TYPE3 (1 << 1)
+#define ACPI_CEDT_CFMWS_RESTRICT_VOLATILE (1 << 2)
+#define ACPI_CEDT_CFMWS_RESTRICT_PMEM (1 << 3)
+#define ACPI_CEDT_CFMWS_RESTRICT_FIXED (1 << 4)
+#endif /* ACPI_CEDT_CHBS_VERSION_CXL20 */
+#endif /* __CXL_ACPI_H__ */

