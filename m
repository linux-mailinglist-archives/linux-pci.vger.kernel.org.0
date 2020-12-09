Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2538D2D37D1
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 01:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731769AbgLIAZK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Dec 2020 19:25:10 -0500
Received: from mga09.intel.com ([134.134.136.24]:16959 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731757AbgLIAZD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Dec 2020 19:25:03 -0500
IronPort-SDR: bhUgg94QhgXeOTVRDoZFvmXIos5+/PgJ536s9QjXYeSG7/LoWaqUyuBBss4uiho18lvUNqJJPq
 m8rqIRZCWadA==
X-IronPort-AV: E=McAfee;i="6000,8403,9829"; a="174142063"
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="174142063"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:21 -0800
IronPort-SDR: Eehe0MGhWXN6iNP/dru4+cXgM/7QW+wcNxFgnXNxXt6wBD/j7WgO49HfilXkIIBFHowHMraVzU
 qEAxGts9mx7A==
X-IronPort-AV: E=Sophos;i="5.78,404,1599548400"; 
   d="scan'208";a="407838449"
Received: from mlubyani-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.137.9])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2020 16:24:20 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>
Subject: [RFC PATCH v2 01/14] docs: cxl: Add basic documentation
Date:   Tue,  8 Dec 2020 16:24:05 -0800
Message-Id: <20201209002418.1976362-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209002418.1976362-1-ben.widawsky@intel.com>
References: <20201209002418.1976362-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This starts a new cxl directory because CXL is a new bus and it is
expected that the documentation will grow large over time. Currently
only memory devices are documented as they are all that's supported.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 Documentation/cxl/index.rst          | 12 ++++++++++++
 Documentation/cxl/memory-devices.rst | 15 +++++++++++++++
 Documentation/index.rst              |  1 +
 3 files changed, 28 insertions(+)
 create mode 100644 Documentation/cxl/index.rst
 create mode 100644 Documentation/cxl/memory-devices.rst

diff --git a/Documentation/cxl/index.rst b/Documentation/cxl/index.rst
new file mode 100644
index 000000000000..036e49553542
--- /dev/null
+++ b/Documentation/cxl/index.rst
@@ -0,0 +1,12 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+====================
+Compute Express Link
+====================
+
+.. toctree::
+   :maxdepth: 1
+
+   memory-devices
+
+.. only::  subproject and html
diff --git a/Documentation/cxl/memory-devices.rst b/Documentation/cxl/memory-devices.rst
new file mode 100644
index 000000000000..aa4262280c67
--- /dev/null
+++ b/Documentation/cxl/memory-devices.rst
@@ -0,0 +1,15 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. include:: <isonum.txt>
+
+===================================
+Compute Express Link Memory Devices
+===================================
+
+A Compute Express Link Memory Device is a CXL component that implements the
+CXL.mem protocol. It contains some amount of volatile memory, persistent memory,
+or both.
+
+Driver Infrastructure
+=====================
+
+This sections covers the driver infrastructure for a CXL memory device.
diff --git a/Documentation/index.rst b/Documentation/index.rst
index 57719744774c..38678f6c5676 100644
--- a/Documentation/index.rst
+++ b/Documentation/index.rst
@@ -137,6 +137,7 @@ needed).
    misc-devices/index
    scheduler/index
    mhi/index
+   cxl/index
 
 Architecture-agnostic documentation
 -----------------------------------
-- 
2.29.2

