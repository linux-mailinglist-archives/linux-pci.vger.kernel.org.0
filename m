Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E50A36162C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 01:26:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbhDOX0r (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 19:26:47 -0400
Received: from mga05.intel.com ([192.55.52.43]:7828 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236674AbhDOX0q (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 19:26:46 -0400
IronPort-SDR: 6w+CmnceWvY+qgU9OHYOP2QMyKEbKJwuDXs1s3m0jGb2s0cJgVEsUqSlek/Ss9Boh9fNbqljCG
 c4zCY3oajL1g==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="280279117"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="280279117"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:26:20 -0700
IronPort-SDR: vBd27/QSGH/VbkxNXnXmPcAJGrONBrIKlgbJfWxWtHiuaMGq0QBrc2L7/v2PwkHCyEKGjueFDo
 wcL47sPimiPA==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="522540100"
Received: from oamoninu-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.130.91])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:26:20 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] cxl/mem: Demarcate vendor specific capability IDs
Date:   Thu, 15 Apr 2021 16:26:10 -0700
Message-Id: <20210415232610.603273-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415232610.603273-1-ben.widawsky@intel.com>
References: <20210415232610.603273-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Vendor capabilities occupy 0x8000 to 0xFFFF according to CXL 2.0 spec
8.2.8.2.1 CXL Device Capabilities. While they are not defined by the
spec, they are allowed and not "unknown". Call this detail out in the
logs to let users easily distinguish the difference.

Fixes: 8adaf747c9f0b ("cxl/mem: Find device capabilities")
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index c05617b0ba4b..0909f73db994 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -939,7 +939,10 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 			cxlm->memdev_regs = register_block;
 			break;
 		default:
-			dev_dbg(dev, "Unknown cap ID: %x (0x%x)\n", cap_id, offset);
+			if (cap_id > 0x8000)
+				dev_dbg(dev, "Vendor cap ID: %x (0x%x)\n", cap_id, offset);
+			else
+				dev_dbg(dev, "Unknown cap ID: %x (0x%x)\n", cap_id, offset);
 			break;
 		}
 	}
-- 
2.31.1

