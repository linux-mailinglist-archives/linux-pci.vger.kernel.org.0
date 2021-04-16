Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 297A83617B0
	for <lists+linux-pci@lfdr.de>; Fri, 16 Apr 2021 04:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236706AbhDPCtq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Apr 2021 22:49:46 -0400
Received: from mga05.intel.com ([192.55.52.43]:26635 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235482AbhDPCtp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Apr 2021 22:49:45 -0400
IronPort-SDR: IdhnRoKrA4+s8rjwOqrjHu8X0e5XdtPuFLvp0G11/beB8FbDkR3zxuuL/hRe+SSByZYnf7gdDM
 CVHeaq04r0qQ==
X-IronPort-AV: E=McAfee;i="6200,9189,9955"; a="280297464"
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="280297464"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 19:49:19 -0700
IronPort-SDR: BUVzbvU9lm2hj43qfQcctSAAtLewDloc2SP1LNuUf3TAlAQyd355weItuFvK2Rjocuunxb/aIQ
 ssJgKOnjtwaw==
X-IronPort-AV: E=Sophos;i="5.82,226,1613462400"; 
   d="scan'208";a="615834756"
Received: from skanuri-mobl.amr.corp.intel.com (HELO bwidawsk-mobl5.local) ([10.252.135.175])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2021 19:49:18 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        dan.j.williams@intel.com, linux-kernel@vger.kernel.org
Subject: [PATCH v2] cxl/mem: Fix register block offset calculation
Date:   Thu, 15 Apr 2021 19:49:12 -0700
Message-Id: <20210416024912.638180-1-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210415232610.603273-1-ben.widawsky@intel.com>
References: <20210415232610.603273-1-ben.widawsky@intel.com>
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

The "Register Offset Low" register of a "DVSEC Register Locator"
contains the 64K aligned offset for the registers along with the BAR
indicator and an ID. The implementation was treating the "Register Block
Offset Low" field a value rather than as a pre-aligned component of the
64-bit offset. So, just mask, don't mask and shift (FIELD_GET).

This wasn't found earlier because the primary development done in the
QEMU environment only uses 0 offsets

Fixes: 8adaf747c9f0 ("cxl/mem: Find device capabilities")
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

