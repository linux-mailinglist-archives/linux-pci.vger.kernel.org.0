Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1ABE427C1F
	for <lists+linux-pci@lfdr.de>; Sat,  9 Oct 2021 18:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbhJIQqQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 9 Oct 2021 12:46:16 -0400
Received: from mga17.intel.com ([192.55.52.151]:64740 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232102AbhJIQqQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 9 Oct 2021 12:46:16 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10132"; a="207482164"
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="207482164"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 09:44:19 -0700
X-IronPort-AV: E=Sophos;i="5.85,360,1624345200"; 
   d="scan'208";a="658138142"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2021 09:44:18 -0700
Subject: [PATCH v3 04/10] cxl/pci: Remove pci request/release regions
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de
Date:   Sat, 09 Oct 2021 09:44:18 -0700
Message-ID: <163379785872.692348.8981679111988251260.stgit@dwillia2-desk3.amr.corp.intel.com>
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

Quoting Dan, "... the request + release regions should probably just be
dropped. It's not like any of the register enumeration would collide
with someone else who already has the registers mapped. The collision
only comes when the registers are mapped for their final usage, and that
will have more precision in the request."

Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/pci.c |    5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 9c178002d49e..21dd10a77eb3 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -453,9 +453,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 		return -ENXIO;
 	}
 
-	if (pci_request_mem_regions(pdev, pci_name(pdev)))
-		return -ENODEV;
-
 	/* Get the size of the Register Locator DVSEC */
 	pci_read_config_dword(pdev, regloc + PCI_DVSEC_HEADER1, &regloc_size);
 	regloc_size = FIELD_GET(PCI_DVSEC_HEADER1_LENGTH_MASK, regloc_size);
@@ -499,8 +496,6 @@ static int cxl_pci_setup_regs(struct cxl_mem *cxlm)
 		n_maps++;
 	}
 
-	pci_release_mem_regions(pdev);
-
 	for (i = 0; i < n_maps; i++) {
 		ret = cxl_map_regs(cxlm, &maps[i]);
 		if (ret)

