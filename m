Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D6BD416463
	for <lists+linux-pci@lfdr.de>; Thu, 23 Sep 2021 19:26:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242573AbhIWR23 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 23 Sep 2021 13:28:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:47626 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242565AbhIWR23 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 23 Sep 2021 13:28:29 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10116"; a="211144823"
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="211144823"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 10:26:57 -0700
X-IronPort-AV: E=Sophos;i="5.85,316,1624345200"; 
   d="scan'208";a="704832575"
Received: from unknown (HELO bad-guy.kumite) ([10.252.132.140])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2021 10:26:56 -0700
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     Ben Widawsky <ben.widawsky@intel.com>,
        linuxppc-dev@lists.ozlabs.org,
        Andrew Donnellan <ajd@linux.ibm.com>,
        Frederic Barrat <fbarrat@linux.ibm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        "David E. Box" <david.e.box@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
Subject: [PATCH v2 8/9] ocxl: Use pci core's DVSEC functionality
Date:   Thu, 23 Sep 2021 10:26:46 -0700
Message-Id: <20210923172647.72738-9-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210923172647.72738-1-ben.widawsky@intel.com>
References: <20210923172647.72738-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Reduce maintenance burden of DVSEC query implementation by using the
centralized PCI core implementation.

There are two obvious places to simply drop in the new core
implementation. There remains find_dvsec_from_pos() which would benefit
from using a core implementation. As that change is less trivial it is
reserved for later.

Cc: linuxppc-dev@lists.ozlabs.org
Cc: Andrew Donnellan <ajd@linux.ibm.com>
Acked-by: Frederic Barrat <fbarrat@linux.ibm.com> (v1)
Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 arch/powerpc/platforms/powernv/ocxl.c |  3 ++-
 drivers/misc/ocxl/config.c            | 13 +------------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/ocxl.c b/arch/powerpc/platforms/powernv/ocxl.c
index 9105efcf242a..28b009b46464 100644
--- a/arch/powerpc/platforms/powernv/ocxl.c
+++ b/arch/powerpc/platforms/powernv/ocxl.c
@@ -107,7 +107,8 @@ static int get_max_afu_index(struct pci_dev *dev, int *afu_idx)
 	int pos;
 	u32 val;
 
-	pos = find_dvsec_from_pos(dev, OCXL_DVSEC_FUNC_ID, 0);
+	pos = pci_find_dvsec_capability(dev, PCI_VENDOR_ID_IBM,
+					OCXL_DVSEC_FUNC_ID);
 	if (!pos)
 		return -ESRCH;
 
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

