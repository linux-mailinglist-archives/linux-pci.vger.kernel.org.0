Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96DF049767F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:29:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240579AbiAXA3Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:29:25 -0500
Received: from mga02.intel.com ([134.134.136.20]:35899 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240573AbiAXA3X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:29:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984163; x=1674520163;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=k0XhA7pSlOBp9D/wBrI3FsZj1B5eEzrI4kbiQ3pUgbA=;
  b=KGuM+0RxOHoXa3uUjLXcWMEFhmtAFz29ihTjdNP9MWcA149XESxs09eJ
   T542Fq2TLtp9WQBaRcbNEaH/ftbOv6YTqXchhDtpPq2ZOl1y5yUZu6Ige
   YzzycTjmBegjIpZ8t44fYEDBk13O/tIKPVc6uA4atb5lu/QWldP21ONSl
   GkuUH3s8D11NoWA3sOtp1GwjYTIxZIwwNBFY7iy3shQMyxI3JHC4+JqFD
   7WiGglw9RqyCa53ByAZB/ja7P9fHJlWs6qsqDNCcvw0jIaamqC+KwHz+N
   0UzyFCsv3MZFytYW6FKp44QdEx6WJ0QmvakjEUrdyMogA7D6qv/hHrt0C
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233292263"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233292263"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:21 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="519730715"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:29:21 -0800
Subject: [PATCH v3 08/40] cxl/core/port: Rename bus.c to port.c
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     linux-pci@vger.kernel.org, nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:29:21 -0800
Message-ID: <164298416136.3018233.15442880970000855425.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Given it is dominated by port infrastructure, and will only acquire
more, rename bus.c to port.c.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 Documentation/driver-api/cxl/memory-devices.rst |    4 ++--
 drivers/cxl/core/Makefile                       |    2 +-
 drivers/cxl/core/port.c                         |    0 
 tools/testing/cxl/Kbuild                        |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/cxl/core/{bus.c => port.c} (100%)

diff --git a/Documentation/driver-api/cxl/memory-devices.rst b/Documentation/driver-api/cxl/memory-devices.rst
index 3b8f41395f6b..c8f7a16cd0e3 100644
--- a/Documentation/driver-api/cxl/memory-devices.rst
+++ b/Documentation/driver-api/cxl/memory-devices.rst
@@ -36,10 +36,10 @@ CXL Core
 .. kernel-doc:: drivers/cxl/cxl.h
    :internal:
 
-.. kernel-doc:: drivers/cxl/core/bus.c
+.. kernel-doc:: drivers/cxl/core/port.c
    :doc: cxl core
 
-.. kernel-doc:: drivers/cxl/core/bus.c
+.. kernel-doc:: drivers/cxl/core/port.c
    :identifiers:
 
 .. kernel-doc:: drivers/cxl/core/pmem.c
diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
index 40ab50318daf..a90202ac88d2 100644
--- a/drivers/cxl/core/Makefile
+++ b/drivers/cxl/core/Makefile
@@ -2,7 +2,7 @@
 obj-$(CONFIG_CXL_BUS) += cxl_core.o
 
 ccflags-y += -I$(srctree)/drivers/cxl
-cxl_core-y := bus.o
+cxl_core-y := port.o
 cxl_core-y += pmem.o
 cxl_core-y += regs.o
 cxl_core-y += memdev.o
diff --git a/drivers/cxl/core/bus.c b/drivers/cxl/core/port.c
similarity index 100%
rename from drivers/cxl/core/bus.c
rename to drivers/cxl/core/port.c
diff --git a/tools/testing/cxl/Kbuild b/tools/testing/cxl/Kbuild
index 1acdf2fc31c5..3299fb0977b2 100644
--- a/tools/testing/cxl/Kbuild
+++ b/tools/testing/cxl/Kbuild
@@ -25,7 +25,7 @@ cxl_pmem-y += config_check.o
 
 obj-m += cxl_core.o
 
-cxl_core-y := $(CXL_CORE_SRC)/bus.o
+cxl_core-y := $(CXL_CORE_SRC)/port.o
 cxl_core-y += $(CXL_CORE_SRC)/pmem.o
 cxl_core-y += $(CXL_CORE_SRC)/regs.o
 cxl_core-y += $(CXL_CORE_SRC)/memdev.o

