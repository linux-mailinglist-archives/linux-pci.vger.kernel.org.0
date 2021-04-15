Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36D9B361637
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 01:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237074AbhDOX2Q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 19:28:16 -0400
Received: from mga07.intel.com ([134.134.136.100]:63017 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236110AbhDOX2Q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 19:28:16 -0400
IronPort-SDR: e9RuKekVJzq/1/HPCBcamLsPb6oiFwLNqMBxsi2DAahuqo5hm+o+Qb85AvJZJdorMtB0DvhEaC
 eUwJsSgCedfg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="258921729"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="258921729"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:27:52 -0700
IronPort-SDR: O+onytXJdxoOEut7qKpviMqTHCGxcMAqXTitO+jqIckvLpLWMqG54fmDwZOdqAJAS/+96ZK4UU
 8XGdvONCaumw==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="461789830"
Received: from oamoninu-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.130.91])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:27:51 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cxl/mem: Demarcate vendor specific capability IDs
Date:   Thu, 15 Apr 2021 16:27:50 -0700
Message-Id: <20210415232750.604112-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415232610.603273-3-ben.widawsky@intel.com>
References: <20210415232610.603273-3-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Vendor capabilities occupy 0x8000 to 0xFFFF according to CXL 2.0 spec
8.2.8.2.1 CXL Device Capabilities. While they are not defined by the
spec, they are allowed and not "unknown". Call this detail out in the
logs to let users easily distinguish the difference.

v2: Should be greater than or equal to (Ben)

Fixes: 8adaf747c9f0b ("cxl/mem: Find device capabilities")
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c05617b0ba4b..28c7c29567b3 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -939,7 +939,10 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 			cxlm->memdev_regs = register_block;
 			break;
 		default:
-			dev_dbg(dev, "Unknown cap ID: %x (0x%x)\n", cap_id, offset);
+			if (cap_id >= 0x8000)
+				dev_dbg(dev, "Vendor cap ID: %x (0x%x)\n", cap_id, offset);
+			else
+				dev_dbg(dev, "Unknown cap ID: %x (0x%x)\n", cap_id, offset);
 			break;
 		}
 	}
-- 
2.31.1

