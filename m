Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2450413D4A
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 00:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbhIUWGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 18:06:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:40124 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235889AbhIUWGg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Sep 2021 18:06:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="223119139"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="223119139"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:07 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="557114692"
Received: from ksankar-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.132.1])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:06 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 6/7] cxl/pci: Use pci core's DVSEC functionality
Date:   Tue, 21 Sep 2021 15:04:58 -0700
Message-Id: <20210921220459.2437386-7-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210921220459.2437386-1-ben.widawsky@intel.com>
References: <20210921220459.2437386-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reduce maintenance burden of DVSEC query implementation by using the
centralized PCI core implementation.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/pci.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 7c1d5d5aef6e..040379f727ad 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -340,25 +340,7 @@ static void cxl_pci_unmap_regblock(struct cxl_mem *cxlm, void __iomem *base)
 
 static int cxl_pci_dvsec(struct pci_dev *pdev, int dvsec)
 {
-	int pos;
-
-	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DVSEC);
-	if (!pos)
-		return 0;
-
-	while (pos) {
-		u16 vendor, id;
-
-		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER1, &vendor);
-		pci_read_config_word(pdev, pos + PCI_DVSEC_HEADER2, &id);
-		if (vendor == PCI_DVSEC_VENDOR_ID_CXL && dvsec == id)
-			return pos;
-
-		pos = pci_find_next_ext_capability(pdev, pos,
-						   PCI_EXT_CAP_ID_DVSEC);
-	}
-
-	return 0;
+	return pci_find_dvsec_capability(pdev, PCI_DVSEC_VENDOR_ID_CXL, dvsec);
 }
 
 static int cxl_probe_regs(struct cxl_mem *cxlm, void __iomem *base,
-- 
2.33.0

