Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F016D31A7C4
	for <lists+linux-pci@lfdr.de>; Fri, 12 Feb 2021 23:41:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbhBLWdu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Feb 2021 17:33:50 -0500
Received: from mga03.intel.com ([134.134.136.65]:60252 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232297AbhBLWbs (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Feb 2021 17:31:48 -0500
IronPort-SDR: O1IcydUjBTRwTsjYuKdMfk+thdguKAS6ws8K5VhP7pufzA2IBwGXfmyE5qLrDdxktOgo4zyBQB
 /a8O9PealkjA==
X-IronPort-AV: E=McAfee;i="6000,8403,9893"; a="182555605"
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="182555605"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:25:58 -0800
IronPort-SDR: r6YZYqlYIvTty3eB86Tikw6LVEBlc0F4Xyl9ql4Ojc9awVKYH45lxFwkZ9J4lMXXmvybRrHcyb
 VJiJekJ3ko7A==
X-IronPort-AV: E=Sophos;i="5.81,174,1610438400"; 
   d="scan'208";a="587605404"
Received: from smandal1-mobl2.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.133.121])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2021 14:25:57 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Chris Browy <cbrowy@avery-design.com>,
        Christoph Hellwig <hch@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jon Masters <jcm@jonmasters.org>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "John Groves (jgroves)" <jgroves@micron.com>,
        "Kelley, Sean V" <sean.v.kelley@intel.com>
Subject: [RFC PATCH 9/9] cxl/mem: Add payload dumping for debug
Date:   Fri, 12 Feb 2021 14:25:41 -0800
Message-Id: <20210212222541.2123505-10-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20210212222541.2123505-1-ben.widawsky@intel.com>
References: <20210212222541.2123505-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

It's often useful in debug scenarios to see what the hardware has dumped
out. As it stands today, any device error will result in the payload not
being copied out, so there is no way to triage commands which weren't
expected to fail (and sometimes the payload may have that information).

The functionality is protected by normal kernel security mechanisms as
well as a CONFIG option in the CXL driver.

This was extracted from the original version of the CXL enabling patch
series.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/Kconfig | 13 +++++++++++++
 drivers/cxl/mem.c   |  8 ++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
index 97dc4d751651..3eec9276e586 100644
--- a/drivers/cxl/Kconfig
+++ b/drivers/cxl/Kconfig
@@ -50,4 +50,17 @@ config CXL_MEM_RAW_COMMANDS
 	  potential impact to memory currently in use by the kernel.
 
 	  If developing CXL hardware or the driver say Y, otherwise say N.
+
+config CXL_MEM_INSECURE_DEBUG
+	bool "CXL.mem debugging"
+	depends on CXL_MEM
+	help
+	  Enable debug of all CXL command payloads.
+
+	  Some CXL devices and controllers support encryption and other
+	  security features. The payloads for the commands that enable
+	  those features may contain sensitive clear-text security
+	  material. Disable debug of those command payloads by default.
+	  If you are a kernel developer actively working on CXL
+	  security enabling say Y, otherwise say N.
 endif
diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 3bca8451348a..09c11935b824 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -341,6 +341,14 @@ static int __cxl_mem_mbox_send_cmd(struct cxl_mem *cxlm,
 
 	/* #5 */
 	rc = cxl_mem_wait_for_doorbell(cxlm);
+
+	if (!cxl_is_security_command(mbox_cmd->opcode) ||
+	    IS_ENABLED(CONFIG_CXL_MEM_INSECURE_DEBUG)) {
+		print_hex_dump_debug("Payload ", DUMP_PREFIX_OFFSET, 16, 1,
+				     mbox_cmd->payload_in, mbox_cmd->size_in,
+				     true);
+	}
+
 	if (rc == -ETIMEDOUT) {
 		cxl_mem_mbox_timeout(cxlm, mbox_cmd);
 		return rc;
-- 
2.30.0

