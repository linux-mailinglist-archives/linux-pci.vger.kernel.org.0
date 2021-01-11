Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 190DF2F23A6
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 01:33:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728747AbhALAZ4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Jan 2021 19:25:56 -0500
Received: from mga17.intel.com ([192.55.52.151]:11217 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390784AbhAKWwL (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 Jan 2021 17:52:11 -0500
IronPort-SDR: mteFqK2adw5DDWHEVDaTyTg25YPCoh/cHtydNs6Fi1okviNqW5WKVe1bdVGUOLuaQT3L6eckJ1
 JjROMKiBgGtw==
X-IronPort-AV: E=McAfee;i="6000,8403,9861"; a="157726528"
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="157726528"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:29 -0800
IronPort-SDR: uTBBEhhmSLxLFQjal18IP880OYmMe3m1/FkDWbicM7mn24Bg5Ws/jIhIbhdm17N83GifCnxLzF
 ABFNGsGA//qw==
X-IronPort-AV: E=Sophos;i="5.79,339,1602572400"; 
   d="scan'208";a="352777928"
Received: from yyang31-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.142.71])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2021 14:51:28 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        "linux-acpi@vger.kernel.org, Ira Weiny" <ira.weiny@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Jon Masters <jcm@jonmasters.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@infradead.org>,
        daniel.lll@alibaba-inc.com
Subject: [RFC PATCH v3 01/16] docs: cxl: Add basic documentation
Date:   Mon, 11 Jan 2021 14:51:05 -0800
Message-Id: <20210111225121.820014-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210111225121.820014-1-ben.widawsky@intel.com>
References: <20210111225121.820014-1-ben.widawsky@intel.com>
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
index 5888e8a7272f..7e5ab77264e9 100644
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
2.30.0

