Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C77497696
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jan 2022 01:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240603AbiAXAa0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jan 2022 19:30:26 -0500
Received: from mga02.intel.com ([134.134.136.20]:35989 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235274AbiAXAa0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 23 Jan 2022 19:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642984226; x=1674520226;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TKw70AgVSmJbbUvZiEhzBMjVlCr5iAywMIryPYGbqI4=;
  b=hFZI2NPNIRHu/uJNSnISuA0jZpEHbZIwqg40NusUCcduisPLo1CkAW1r
   or1JthnxaJ1v6MXia9p+6p7fzn3Dij7GNnk/iA6xs4aBU9i4nJteyGasZ
   fDWWIOcsML/j1VvpUeBib+aXR2UNVLkxWlbJdUzcM3KpAjZiRRhQNqGAX
   4bxWJSINGz/uJZzBG+DfPxZvWhEMl0KgJo74OdvgqYmZFEFXQFTrQJVV+
   6rwc4I2IETHPTRft98u6QUemiuK5alIyTt6LlqZYQWfRY7B9PjayzvGxJ
   Hkg44CFMwjtWBfnJ2SS6KrvLevitxs99I86yYezk0NKh7hGLCmLbDqQH2
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10236"; a="233292415"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="233292415"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:25 -0800
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="623902792"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 16:30:25 -0800
Subject: [PATCH v3 20/40] cxl/pci: Rename pci.h to cxlpci.h
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     kernel test robot <lkp@intel.com>, linux-pci@vger.kernel.org,
        nvdimm@lists.linux.dev
Date:   Sun, 23 Jan 2022 16:30:25 -0800
Message-ID: <164298422510.3018233.14693126572756675563.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164298411792.3018233.7493009997525360044.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Similar to the mem.h rename, if the core wants to reuse definitions from
drivers/cxl/pci.h it is unable to use <pci.h> as that collides with
archs that have an arch/$arch/include/asm/pci.h, like MIPS.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/acpi.c      |    2 +-
 drivers/cxl/core/regs.c |    2 +-
 drivers/cxl/cxlpci.h    |    1 +
 drivers/cxl/pci.c       |    2 +-
 4 files changed, 4 insertions(+), 3 deletions(-)
 rename drivers/cxl/{pci.h => cxlpci.h} (99%)

diff --git a/drivers/cxl/acpi.c b/drivers/cxl/acpi.c
index e596dc375267..3485ae9d3baf 100644
--- a/drivers/cxl/acpi.c
+++ b/drivers/cxl/acpi.c
@@ -6,8 +6,8 @@
 #include <linux/kernel.h>
 #include <linux/acpi.h>
 #include <linux/pci.h>
+#include "cxlpci.h"
 #include "cxl.h"
-#include "pci.h"
 
 /* Encode defined in CXL 2.0 8.2.5.12.7 HDM Decoder Control Register */
 #define CFMWS_INTERLEAVE_WAYS(x)	(1 << (x)->interleave_ways)
diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 12a6cbddf110..65d7f5880671 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -5,7 +5,7 @@
 #include <linux/slab.h>
 #include <linux/pci.h>
 #include <cxlmem.h>
-#include <pci.h>
+#include <cxlpci.h>
 
 /**
  * DOC: cxl registers
diff --git a/drivers/cxl/pci.h b/drivers/cxl/cxlpci.h
similarity index 99%
rename from drivers/cxl/pci.h
rename to drivers/cxl/cxlpci.h
index 0623bb85f30a..eb00f597a157 100644
--- a/drivers/cxl/pci.h
+++ b/drivers/cxl/cxlpci.h
@@ -2,6 +2,7 @@
 /* Copyright(c) 2020 Intel Corporation. All rights reserved. */
 #ifndef __CXL_PCI_H__
 #define __CXL_PCI_H__
+#include "cxl.h"
 
 #define CXL_MEMORY_PROGIF	0x10
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bdfeb92ed028..c29d50660c21 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -10,7 +10,7 @@
 #include <linux/pci.h>
 #include <linux/io.h>
 #include "cxlmem.h"
-#include "pci.h"
+#include "cxlpci.h"
 #include "cxl.h"
 
 /**

