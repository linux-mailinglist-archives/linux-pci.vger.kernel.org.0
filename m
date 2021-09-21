Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33AE2413D45
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 00:05:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235899AbhIUWGf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 18:06:35 -0400
Received: from mga14.intel.com ([192.55.52.115]:40124 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235889AbhIUWGf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Sep 2021 18:06:35 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="223119121"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="223119121"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:05 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="557114665"
Received: from ksankar-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.132.1])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:04 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 2/7] cxl/pci: Remove dev_dbg for unknown register blocks
Date:   Tue, 21 Sep 2021 15:04:54 -0700
Message-Id: <20210921220459.2437386-3-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921220459.2437386-1-ben.widawsky@intel.com>
References: <20210921220459.2437386-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

While interesting to driver developers, the dev_dbg message doesn't do
much except clutter up logs. This information should be attainable
through sysfs, and someday lspci like utilities. This change
additionally helps reduce the LOC in a subsequent patch to refactor some
of cxl_pci register mapping.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 64180f46c895..ccc7c2573ddc 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -475,9 +475,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 		cxl_decode_register_block(reg_lo, reg_hi, &bar, &offset,
 					  &reg_type);
 
-		dev_dbg(dev, "Found register block in bar %u @ 0x%llx of type %u\n",
-			bar, offset, reg_type);
-
 		/* Ignore unknown register block types */
 		if (reg_type > CXL_REGLOC_RBI_MEMDEV)
 			continue;
-- 
2.33.0

