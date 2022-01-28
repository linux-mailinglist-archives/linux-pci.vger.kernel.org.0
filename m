Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC07949EFBE
	for <lists+linux-pci@lfdr.de>; Fri, 28 Jan 2022 01:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344764AbiA1A3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Jan 2022 19:29:20 -0500
Received: from mga18.intel.com ([134.134.136.126]:64728 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229812AbiA1A3M (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Jan 2022 19:29:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643329751; x=1674865751;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=I2mDMGeUO3hX56XamEiDwM3Cha4aTFhKrdNK7gj9sTo=;
  b=djHx0RLjM6jmiJpKoRNJyxL+MzPvGSkCE4cuFbjk/PO5priMrAZ31O5N
   KnY4weoxsUDpz0Wa3hHsjl9SVlS/evzkrc9YUYyWyfjE4aeNrn+mbaaxB
   KXpSz4D85+wvO8gKQx1HtSL0CJTrxJgUXj2cg1NRs7eG3FiXb061dN0mH
   NT5N4IDMcO8fx4ZHYAo1w/d5rHFCRvsSEWxR/CYUYE5saaSLKl4NAE4+P
   EIzZh2js781sDxdGf3duPDa6Srrq196kb5I3xyisPFSUhl+zVJkFb2Q6I
   Ei9D3GyO6hGOMpWMt0QGYDlQ7pTkFDj1uPsh4T4rPraadGHDtlayFOGzU
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230580029"
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="230580029"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:30 -0800
X-IronPort-AV: E=Sophos;i="5.88,322,1635231600"; 
   d="scan'208";a="674909660"
Received: from vrao2-mobl1.gar.corp.intel.com (HELO localhost.localdomain) ([10.252.129.6])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 16:27:29 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     patches@lists.linux.dev, Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Bjorn Helgaas <helgaas@kernel.org>, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Subject: [PATCH v3 13/14] cxl/pmem: Convert nvdimm bridge API to use dev
Date:   Thu, 27 Jan 2022 16:27:06 -0800
Message-Id: <20220128002707.391076-14-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220128002707.391076-1-ben.widawsky@intel.com>
References: <20220128002707.391076-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The cxl_pmem driver specific cxl_nvdimm structure isn't a suitable
parameter for an exported API that can be used by other drivers.
Instead, use a dev structure, which should be woven into any caller
using this API. This will allow for either the nvdimm's dev, or the
memdev's dev to be used.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
Changes since v2:
- Added kdoc to cxl_find_nvdimm_bridge()
---
 drivers/cxl/core/pmem.c | 12 +++++++++---
 drivers/cxl/cxl.h       |  2 +-
 drivers/cxl/pmem.c      |  2 +-
 3 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index 8de240c4d96b..7e431667ade1 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -62,10 +62,16 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 	return is_cxl_nvdimm_bridge(dev);
 }
 
-struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd)
+/**
+ * cxl_find_nvdimm_bridge() - Find an nvdimm bridge for a given device
+ * @dev: The device to find a bridge for. This device must be in the part of the
+ *	 CXL topology which is being bridged.
+ *
+ * Return: bridge device that hosts cxl_nvdimm objects if found, else NULL.
+ */
+struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct device *dev)
 {
-	struct cxl_port *port = find_cxl_root(&cxl_nvd->dev);
-	struct device *dev;
+	struct cxl_port *port = find_cxl_root(dev);
 
 	if (!port)
 		return NULL;
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index f9dab312ed26..062654204eca 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -479,7 +479,7 @@ struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm_bridge(struct device *dev);
 int devm_cxl_add_nvdimm(struct device *host, struct cxl_memdev *cxlmd);
-struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd);
+struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct device *dev);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 15ad666ab03e..fabdb0c6dbf2 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -39,7 +39,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 	struct nvdimm *nvdimm;
 	int rc;
 
-	cxl_nvb = cxl_find_nvdimm_bridge(cxl_nvd);
+	cxl_nvb = cxl_find_nvdimm_bridge(&cxl_nvd->dev);
 	if (!cxl_nvb)
 		return -ENXIO;
 
-- 
2.35.0

