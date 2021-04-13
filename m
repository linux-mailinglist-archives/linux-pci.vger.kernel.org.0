Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C104E35E0FA
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 16:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbhDMOJx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 10:09:53 -0400
Received: from mga14.intel.com ([192.55.52.115]:6188 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhDMOJt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 10:09:49 -0400
IronPort-SDR: Mn+8/BqSEp97mazIEevCbscL/LVS2xueP6LnANHMUFothPlNZizhSxkuL5Z2cpx8sMIYOMzFaz
 k58yud7QxmXg==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="193982586"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="193982586"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 07:09:24 -0700
IronPort-SDR: pXMK/UrgOtexN5LuGm7CrPTdSnHOV6i827NOH9aPx0juJi99JXRmCm+HQvnbA5K+RjSlwiUfVg
 dsJsrlu8mK6g==
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="600359213"
Received: from damilitx-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.165])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 07:09:23 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/mem: Add media provisioning required commands
Date:   Tue, 13 Apr 2021 07:09:07 -0700
Message-Id: <20210413140907.534404-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some of the commands have already been defined for the support of RAW
commands (to be blocked). Unlike their usage in the RAW interface, when
used through the supported interface, they will be coordinated and
marshalled along with other commands being issued by userspace and the
driver itself. That coordination will be added later.

The list of commands was determined based on the learnings from
libnvdimm and this list is provided directly from Dan.

Recommended-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c            | 19 +++++++++++++++++++
 include/uapi/linux/cxl_mem.h | 12 ++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index e915e3743b76..e3306aa560cf 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -50,7 +50,14 @@ enum opcode {
 	CXL_MBOX_OP_GET_LSA		= 0x4102,
 	CXL_MBOX_OP_SET_LSA		= 0x4103,
 	CXL_MBOX_OP_GET_HEALTH_INFO	= 0x4200,
+	CXL_MBOX_OP_GET_ALERT_CONFIG	= 0x4201,
+	CXL_MBOX_OP_SET_ALERT_CONFIG	= 0x4202,
+	CXL_MBOX_OP_GET_SHUTDOWN_STATE	= 0x4203,
 	CXL_MBOX_OP_SET_SHUTDOWN_STATE	= 0x4204,
+	CXL_MBOX_OP_GET_POISON		= 0x4300,
+	CXL_MBOX_OP_INJECT_POISON	= 0x4301,
+	CXL_MBOX_OP_CLEAR_POISON	= 0x4302,
+	CXL_MBOX_OP_GET_SCAN_MEDIA_CAPS	= 0x4303,
 	CXL_MBOX_OP_SCAN_MEDIA		= 0x4304,
 	CXL_MBOX_OP_GET_SCAN_MEDIA	= 0x4305,
 	CXL_MBOX_OP_MAX			= 0x10000
@@ -158,6 +165,18 @@ static struct cxl_mem_command mem_commands[CXL_MEM_COMMAND_ID_MAX] = {
 	CXL_CMD(GET_LSA, 0x8, ~0, 0),
 	CXL_CMD(GET_HEALTH_INFO, 0, 0x12, 0),
 	CXL_CMD(GET_LOG, 0x18, ~0, CXL_CMD_FLAG_FORCE_ENABLE),
+	CXL_CMD(SET_PARTITION_INFO, 0x0a, 0, 0),
+	CXL_CMD(SET_LSA, ~0, 0, 0),
+	CXL_CMD(GET_ALERT_CONFIG, 0, 0x10, 0),
+	CXL_CMD(SET_ALERT_CONFIG, 0xc, 0, 0),
+	CXL_CMD(GET_SHUTDOWN_STATE, 0, 0x1, 0),
+	CXL_CMD(SET_SHUTDOWN_STATE, 0x1, 0, 0),
+	CXL_CMD(GET_POISON, 0x10, ~0, 0),
+	CXL_CMD(INJECT_POISON, 0x8, 0, 0),
+	CXL_CMD(CLEAR_POISON, 0x48, 0, 0),
+	CXL_CMD(GET_SCAN_MEDIA_CAPS, 0x10, 0x4, 0),
+	CXL_CMD(SCAN_MEDIA, 0x11, 0, 0),
+	CXL_CMD(GET_SCAN_MEDIA, 0, ~0, 0),
 };
 
 /*
diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index 3155382dfc9b..f6e8a005b113 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -29,6 +29,18 @@
 	___C(GET_LSA, "Get Label Storage Area"),                          \
 	___C(GET_HEALTH_INFO, "Get Health Info"),                         \
 	___C(GET_LOG, "Get Log"),                                         \
+	___C(SET_PARTITION_INFO, "Set Partition Information"),            \
+	___C(SET_LSA, "Set Label Storage Area"),                          \
+	___C(GET_ALERT_CONFIG, "Get Alert Configuration"),                \
+	___C(SET_ALERT_CONFIG, "Set Alert Configuration"),                \
+	___C(GET_SHUTDOWN_STATE, "Get Shutdown State"),                   \
+	___C(SET_SHUTDOWN_STATE, "Set Shutdown State"),                   \
+	___C(GET_POISON, "Get Poison List"),                              \
+	___C(INJECT_POISON, "Inject Poison"),                             \
+	___C(CLEAR_POISON, "Clear Poison"),                               \
+	___C(GET_SCAN_MEDIA_CAPS, "Get Scan Media Capabilities"),         \
+	___C(SCAN_MEDIA, "Scan Media"),                                   \
+	___C(GET_SCAN_MEDIA, "Get Scan Media Results"),                   \
 	___C(MAX, "invalid / last command")
 
 #define ___C(a, b) CXL_MEM_COMMAND_ID_##a
-- 
2.31.1

