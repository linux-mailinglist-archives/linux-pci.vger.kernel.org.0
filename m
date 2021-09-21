Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F978413D4B
	for <lists+linux-pci@lfdr.de>; Wed, 22 Sep 2021 00:05:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235916AbhIUWGh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Sep 2021 18:06:37 -0400
Received: from mga14.intel.com ([192.55.52.115]:40130 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235876AbhIUWGg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Sep 2021 18:06:36 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10114"; a="223119142"
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="223119142"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:07 -0700
X-IronPort-AV: E=Sophos;i="5.85,311,1624345200"; 
   d="scan'208";a="557114700"
Received: from ksankar-mobl2.amr.corp.intel.com (HELO bad-guy.kumite) ([10.252.132.1])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Sep 2021 15:05:07 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH 7/7] ocxl: Use pci core's DVSEC functionality
Date:   Tue, 21 Sep 2021 15:04:59 -0700
Message-Id: <20210921220459.2437386-8-ben.widawsky@intel.com>
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

Cc: linuxppc-dev@lists.ozlabs.org
Cc: Frederic Barrat <fbarrat@linux.ibm.com>
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/misc/ocxl/config.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/misc/ocxl/config.c b/drivers/misc/ocxl/config.c
index a68738f38252..e401a51596b9 100644
--- a/drivers/misc/ocxl/config.c
+++ b/drivers/misc/ocxl/config.c
@@ -33,18 +33,7 @@
 
 static int find_dvsec(struct pci_dev *dev, int dvsec_id)
 {
-	int vsec = 0;
-	u16 vendor, id;
-
-	while ((vsec = pci_find_next_ext_capability(dev, vsec,
-						    OCXL_EXT_CAP_ID_DVSEC))) {
-		pci_read_config_word(dev, vsec + OCXL_DVSEC_VENDOR_OFFSET,
-				&vendor);
-		pci_read_config_word(dev, vsec + OCXL_DVSEC_ID_OFFSET, &id);
-		if (vendor == PCI_VENDOR_ID_IBM && id == dvsec_id)
-			return vsec;
-	}
-	return 0;
+	return pci_find_dvsec_capability(dev, PCI_VENDOR_ID_IBM, dvsec_id);
 }
 
 static int find_dvsec_afu_ctrl(struct pci_dev *dev, u8 afu_idx)
-- 
2.33.0

