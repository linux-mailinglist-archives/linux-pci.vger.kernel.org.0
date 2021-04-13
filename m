Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA2735E19C
	for <lists+linux-pci@lfdr.de>; Tue, 13 Apr 2021 16:33:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241119AbhDMOd6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Apr 2021 10:33:58 -0400
Received: from mga06.intel.com ([134.134.136.31]:58955 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1343824AbhDMOdh (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 13 Apr 2021 10:33:37 -0400
IronPort-SDR: ab/navwAl0RBZiGUZc7OwJn3pgVDRlHzzbmJV5WDgjAbQMLA3OPCkf+WO1yj2OIC1KES/K96Bv
 ON1y5Gi1OWcw==
X-IronPort-AV: E=McAfee;i="6200,9189,9953"; a="255744581"
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="255744581"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 07:32:53 -0700
IronPort-SDR: qxIHVA/iFiSeIjcOBRUEdggu0+r9rrF9/zHBHjMBmB8UWTYELRxZ2+Ob4rnbvhVtWm0uzuJvVQ
 Xbwst7Wd8HAQ==
X-IronPort-AV: E=Sophos;i="5.82,219,1613462400"; 
   d="scan'208";a="420811972"
Received: from damilitx-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.134.165])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2021 07:32:53 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH] cxl/mem: Clarify UAPI documentation
Date:   Tue, 13 Apr 2021 07:32:47 -0700
Message-Id: <20210413143247.546256-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 include/uapi/linux/cxl_mem.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/uapi/linux/cxl_mem.h b/include/uapi/linux/cxl_mem.h
index f6e8a005b113..8dd516ddb098 100644
--- a/include/uapi/linux/cxl_mem.h
+++ b/include/uapi/linux/cxl_mem.h
@@ -81,6 +81,13 @@ static const struct {
  *  - @size_in = -1
  *  - @size_out = 0
  *
+ * Commands which have a variable length input likely have a minimum length.
+ * This is not enforced by the UAPI, and therefore might look like the command
+ * succeeded when sending too small of an input payload. Caution should be taken
+ * by checking the @cxl_send_command.retval for such cases. For commands with a
+ * variable length output, the caller is free to consume as little or as much as
+ * they want.
+ *
  * See struct cxl_mem_query_commands.
  */
 struct cxl_command_info {
-- 
2.31.1

