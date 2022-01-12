Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2202948CF50
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jan 2022 00:48:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235701AbiALXsl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jan 2022 18:48:41 -0500
Received: from mga04.intel.com ([192.55.52.120]:13997 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235691AbiALXsU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 12 Jan 2022 18:48:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642031300; x=1673567300;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=NGhTlz6K842nSSifnB2cI703CM5Bl7Bq3y/bzctyC5Y=;
  b=nl+Iy8M0DyP3lbv1crmwqe6ph7rgsXQHtXUPea2Z0iDfYCgCHSRFuBKg
   n6+zD+8Rfaq0hBa9vCGW84hDh0Vbo2k2htFWsamcUPL9ZA+HfClen9jmV
   3t8fzFAT8Z0pxQxp3qMseWnf3U243fpmPS96sBZMcjyJyf/kLGTsquToI
   PbvwRH8Neg/KpxCdKcbJWqgXKP9gRLLW4/yS/N0HXY/svtMTwGbr6WWgK
   dHjkPyaIYmPrn7jiR8vAYOhyY2djhUvLLPU21tRJ5lP5Ynd07ANiO7E48
   Lz+2sBrqHZJ6ZJow80cEWELfx6vwLo53p7VXz6aiNylGUGNByp2lBaMVR
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10225"; a="242695368"
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="242695368"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:13 -0800
X-IronPort-AV: E=Sophos;i="5.88,284,1635231600"; 
   d="scan'208";a="670324219"
Received: from jmaclean-mobl1.amr.corp.intel.com (HELO localhost.localdomain) ([10.252.136.131])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2022 15:48:12 -0800
From:   Ben Widawsky <ben.widawsky@intel.com>
To:     linux-cxl@vger.kernel.org, nvdimm@lists.linux.dev,
        linux-pci@vger.kernel.org
Cc:     patches@lists.linux.dev, Bjorn Helgaas <helgaas@kernel.org>,
        Ben Widawsky <ben.widawsky@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Vishal Verma <vishal.l.verma@intel.com>
Subject: [PATCH v2 14/15] cxl/pmem: Convert nvdimm bridge API to use memdev
Date:   Wed, 12 Jan 2022 15:47:48 -0800
Message-Id: <20220112234749.1965960-15-ben.widawsky@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220112234749.1965960-1-ben.widawsky@intel.com>
References: <20220112234749.1965960-1-ben.widawsky@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The cxl_pmem driver specific cxl_nvdimm structure isn't a suitable
parameter for an exported API that can be used by other drivers.
Instead, use a memdev structure, which should be woven into any caller
using this API.

Signed-off-by: Ben Widawsky <ben.widawsky@intel.com>
---
 drivers/cxl/core/pmem.c | 3 +--
 drivers/cxl/cxl.h       | 2 +-
 drivers/cxl/pmem.c      | 2 +-
 3 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/core/pmem.c b/drivers/cxl/core/pmem.c
index f21e5ce9619a..bfcf51fbda5d 100644
--- a/drivers/cxl/core/pmem.c
+++ b/drivers/cxl/core/pmem.c
@@ -62,9 +62,8 @@ static int match_nvdimm_bridge(struct device *dev, void *data)
 	return is_cxl_nvdimm_bridge(dev);
 }
 
-struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd)
+struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd)
 {
-	struct cxl_memdev *cxlmd = cxl_nvd->cxlmd;
 	struct cxl_port *port;
 	struct device *dev;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 1130165dfc8d..6f9cabb77c08 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -433,7 +433,7 @@ struct cxl_nvdimm *to_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm(struct device *dev);
 bool is_cxl_nvdimm_bridge(struct device *dev);
 int devm_cxl_add_nvdimm(struct device *host, struct cxl_memdev *cxlmd);
-struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_nvdimm *cxl_nvd);
+struct cxl_nvdimm_bridge *cxl_find_nvdimm_bridge(struct cxl_memdev *cxlmd);
 
 /*
  * Unit test builds overrides this to __weak, find the 'strong' version
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index b65a272a2d6d..420ace433a01 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -39,7 +39,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 	struct nvdimm *nvdimm;
 	int rc;
 
-	cxl_nvb = cxl_find_nvdimm_bridge(cxl_nvd);
+	cxl_nvb = cxl_find_nvdimm_bridge(cxl_nvd->cxlmd);
 	if (!cxl_nvb)
 		return -ENXIO;
 
-- 
2.34.1

