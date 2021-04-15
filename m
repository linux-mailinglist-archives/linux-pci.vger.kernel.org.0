Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86C24361628
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 01:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237768AbhDOX0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 19:26:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:7828 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237758AbhDOX0p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 19:26:45 -0400
IronPort-SDR: kgos/+aVUlEvwpcQwBUuR4ZLTHKFDLjz7pkzP1quqot6xGFC6yfAGt3QZJT0pWm1E6gU+5bM6E
 R9s23xmcJvTg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="280279116"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="280279116"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:26:20 -0700
IronPort-SDR: jmV1F1lTCchcfeqtPxoAsAoMWKCxgOr36x6JvwRMls9G4IEE1ovyl1WmdwK4D83gIa7Jj+ntGE
 eRPPl+QuflmA==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="522540092"
Received: from oamoninu-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.130.91])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:26:19 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] cxl/mem: Print unknown capability IDs as hex
Date:   Thu, 15 Apr 2021 16:26:09 -0700
Message-Id: <20210415232610.603273-2-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415232610.603273-1-ben.widawsky@intel.com>
References: <20210415232610.603273-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Trivial. The spec lists these as hex, so do the same here to make
debugging easier.

Fixes: 8adaf747c9f0b ("cxl/mem: Find device capabilities")
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index 1b5078311f7d..c05617b0ba4b 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -939,7 +939,7 @@ static int cxl_mem_setup_regs(struct cxl_mem *cxlm)
 			cxlm->memdev_regs = register_block;
 			break;
 		default:
-			dev_dbg(dev, "Unknown cap ID: %d (0x%x)\n", cap_id, offset);
+			dev_dbg(dev, "Unknown cap ID: %x (0x%x)\n", cap_id, offset);
 			break;
 		}
 	}
-- 
2.31.1

