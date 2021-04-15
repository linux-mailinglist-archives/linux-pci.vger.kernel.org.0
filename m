Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DA56361627
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 01:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237762AbhDOX0q (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 19:26:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:7826 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237756AbhDOX0p (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 19:26:45 -0400
IronPort-SDR: IxQPiblq7NKmtC7U4nMp7rxv24m5zhkX3PU6biTdMPRRn3eQf+iZQ8lAvxGYBkMXXMTnkTLSBi
 sWaAescTqjXg==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="280279113"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="280279113"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:26:19 -0700
IronPort-SDR: 00aMwu4UlW9fnUV8MBvABkj1YdCXaV6Rg3y8GVTloR8Z3+GSonkXvtCHK2E0IKCgdb6D8NnMjw
 gMatbJHw+QzQ==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="522540082"
Received: from oamoninu-mobl1.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.130.91])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 16:26:18 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] cxl/mem: Fix register block offset calculation
Date:   Thu, 15 Apr 2021 16:26:08 -0700
Message-Id: <20210415232610.603273-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The offset for the register block should be a 64K aligned value, and
therefore FIELD_GET (which will shift) is not correct for the
calculation.

From 8.1.9.1 of the CXL 2.0 spec:
  A[31:16] of offset from the address contained by one of the Function's
  Base Address Registers to point to the base of the Register Block.
  Register Block Offset is 64K aligned. Hence A[15:0] is zero

Fix this by simply using a mask.

This wasn't found earlier because the primary development done in the
QEMU environment only uses 0 offsets

Fixes: 8adaf747c9f0b ("cxl/mem: Find device capabilities")
Reported-by: Vishal Verma <vishal.l.verma@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/mem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cxl/mem.c b/drivers/cxl/mem.c
index e3003f49b329..1b5078311f7d 100644
--- a/drivers/cxl/mem.c
+++ b/drivers/cxl/mem.c
@@ -998,7 +998,7 @@ static struct cxl_mem *cxl_mem_create(struct pci_dev *pdev, u32 reg_lo,
 		return NULL;
 	}
 
-	offset = ((u64)reg_hi << 32) | FIELD_GET(CXL_REGLOC_ADDR_MASK, reg_lo);
+	offset = ((u64)reg_hi << 32) | (reg_lo & CXL_REGLOC_ADDR_MASK);
 	bar = FIELD_GET(CXL_REGLOC_BIR_MASK, reg_lo);
 
 	/* Basic sanity check that BAR is big enough */
-- 
2.31.1

