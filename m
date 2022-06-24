Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C691558FA3
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiFXEUe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231329AbiFXEUT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:19 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EF95639B;
        Thu, 23 Jun 2022 21:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044417; x=1687580417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gavlelRZmhRVxfC9YWBfVgcdtFPtB4GEpy8NZudDjyI=;
  b=fgkzINNqIU+/NwWD/MmACtLUEVcDkjzNUie4b5zNQiivJXJeNi5oy7rD
   ETDd1EvoHhnh6ZG0qqIwm4NC+pjTBlJTd4E9mQQ4STkHbDrkzm23OenxO
   fQFhmqRbmWvQMphlmOi87yjZpTxYBiMtVtzdLT2keXR9aMa+FCa5Q3f3e
   DYLK3CalxkOcIm5aEssIlAm5YTaoX9/tsOhu8JSZvKSm6hA6R2oKKL0BQ
   iScjFA424pGAreB6pTCo2QTxdLMzBrqch/o+BsBLUQ7WqBmdFmqlivgiV
   NBt+1NSebz6oVxGkWxkwt4wd/9HeSQscnK1IXjhotZXsHMUKL7WvI+FD4
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367238060"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367238060"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092968"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:16 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 45/46] cxl/pmem: Fix offline_nvdimm_bus() to offline by bridge
Date:   Thu, 23 Jun 2022 21:19:49 -0700
Message-Id: <20220624041950.559155-20-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Be careful to only disable cxl_pmem objects related to a given
cxl_nvdimm_bridge. Otherwise, offline_nvdimm_bus() reaches across CXL
domains and disables more than is expected.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h  |  1 +
 drivers/cxl/pmem.c | 21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index d6ff6337aa49..95f486bc1b41 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -411,6 +411,7 @@ struct cxl_nvdimm_bridge {
 struct cxl_nvdimm {
 	struct device dev;
 	struct cxl_memdev *cxlmd;
+	struct cxl_nvdimm_bridge *bridge;
 };
 
 /**
diff --git a/drivers/cxl/pmem.c b/drivers/cxl/pmem.c
index 0aaa70b4e0f7..b271f6e90b91 100644
--- a/drivers/cxl/pmem.c
+++ b/drivers/cxl/pmem.c
@@ -26,7 +26,10 @@ static void clear_exclusive(void *cxlds)
 
 static void unregister_nvdimm(void *nvdimm)
 {
+	struct cxl_nvdimm *cxl_nvd = nvdimm_provider_data(nvdimm);
+
 	nvdimm_delete(nvdimm);
+	cxl_nvd->bridge = NULL;
 }
 
 static int cxl_nvdimm_probe(struct device *dev)
@@ -66,6 +69,7 @@ static int cxl_nvdimm_probe(struct device *dev)
 	}
 
 	dev_set_drvdata(dev, nvdimm);
+	cxl_nvd->bridge = cxl_nvb;
 	rc = devm_add_action_or_reset(dev, unregister_nvdimm, nvdimm);
 out:
 	device_unlock(&cxl_nvb->dev);
@@ -204,15 +208,23 @@ static bool online_nvdimm_bus(struct cxl_nvdimm_bridge *cxl_nvb)
 	return cxl_nvb->nvdimm_bus != NULL;
 }
 
-static int cxl_nvdimm_release_driver(struct device *dev, void *data)
+static int cxl_nvdimm_release_driver(struct device *dev, void *cxl_nvb)
 {
+	struct cxl_nvdimm *cxl_nvd;
+
 	if (!is_cxl_nvdimm(dev))
 		return 0;
+
+	cxl_nvd = to_cxl_nvdimm(dev);
+	if (cxl_nvd->bridge != cxl_nvb)
+		return 0;
+
 	device_release_driver(dev);
 	return 0;
 }
 
-static void offline_nvdimm_bus(struct nvdimm_bus *nvdimm_bus)
+static void offline_nvdimm_bus(struct cxl_nvdimm_bridge *cxl_nvb,
+			       struct nvdimm_bus *nvdimm_bus)
 {
 	if (!nvdimm_bus)
 		return;
@@ -222,7 +234,8 @@ static void offline_nvdimm_bus(struct nvdimm_bus *nvdimm_bus)
 	 * nvdimm_bus_unregister() rips the nvdimm objects out from
 	 * underneath them.
 	 */
-	bus_for_each_dev(&cxl_bus_type, NULL, NULL, cxl_nvdimm_release_driver);
+	bus_for_each_dev(&cxl_bus_type, NULL, cxl_nvb,
+			 cxl_nvdimm_release_driver);
 	nvdimm_bus_unregister(nvdimm_bus);
 }
 
@@ -260,7 +273,7 @@ static void cxl_nvb_update_state(struct work_struct *work)
 
 		dev_dbg(&cxl_nvb->dev, "rescan: %d\n", rc);
 	}
-	offline_nvdimm_bus(victim_bus);
+	offline_nvdimm_bus(cxl_nvb, victim_bus);
 
 	put_device(&cxl_nvb->dev);
 }
-- 
2.36.1

