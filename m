Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FEF427C1A
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231927AbhJIQqG (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Oct 2021 12:46:06 -0400
Received: from mga09.intel.com ([134.134.136.24]:13397 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231761AbhJIQqF (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Oct 2021 12:46:05 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="226571993"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="226571993"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 09:44:08 -0700
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="561641361"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 09:44:07 -0700
Subject: [PATCH v3 02/10] cxl/pci: Remove dev_dbg for unknown register blocks
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Date:   Sat, 09 Oct 2021 09:44:07 -0700
Message-ID: <163379784717.692348.3478221381958300790.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <163379783658.692348.16064992154261275220.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ben Widawsky <ben.widawsky@intel.com>

While interesting to driver developers, the dev_dbg message doesn't do
much except clutter up logs. This information should be attainable
through sysfs, and someday lspci like utilities. This change
additionally helps reduce the LOC in a subsequent patch to refactor some
of cxl_pci register mapping.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |    3 ---
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

