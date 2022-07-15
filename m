Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F04AD57587E
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jul 2022 02:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241115AbiGOAF1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jul 2022 20:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241106AbiGOAFZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jul 2022 20:05:25 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AAB473902;
        Thu, 14 Jul 2022 17:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657843522; x=1689379522;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TgQ3wfpkvJiu1CZKehyIA3pvixwKsN+GwHLtVvvU30k=;
  b=dKS5NX8kj+lwq8uDdnJFB6avuNuSLs3bX0d9eyMU05WjOJMLe8e2/C3a
   9hgWibYVbsl8oR9JzwFT1WtFI7y73md15jpswDUQck2tHAW/zpWbCRrVB
   ev0nHHMDTkCYK9+F5fjnBi1KiP/gqCayomoKa7leLMXo9jqFX0YmM4j1t
   Tyyb30/uzynhUTE32YDrIT0fbF54iXfIcxwbWwo1mwyDT/RBxlUjX8gSN
   aP+TarlchlGUUAYISXIx+N+fBJ89SiFmqMjXXYAbc2Txjn82L5mR8GtGH
   ja4H1ljDE4RJrYeG3k2BLoVx7BBMw3exGjfn46GaZ6iQXZ3zIYJgcTReU
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10408"; a="371978415"
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="371978415"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:03:16 -0700
X-IronPort-AV: E=Sophos;i="5.92,272,1650956400"; 
   d="scan'208";a="571303156"
Received: from jlcone-mobl1.amr.corp.intel.com (HELO dwillia2-xfh.jf.intel.com) ([10.209.2.90])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2022 17:03:15 -0700
Subject: [PATCH v2 27/28] cxl/pmem: Fix offline_nvdimm_bus() to offline by
 bridge
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     hch@lst.de, nvdimm@lists.linux.dev, linux-pci@vger.kernel.org
Date:   Thu, 14 Jul 2022 17:03:15 -0700
Message-ID: <165784339569.1758207.1557084545278004577.stgit@dwillia2-xfh.jf.intel.com>
In-Reply-To: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
References: <165784324066.1758207.15025479284039479071.stgit@dwillia2-xfh.jf.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

Fixes: 21083f51521f ("cxl/pmem: Register 'pmem' / cxl_nvdimm devices")
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/cxl.h  |    1 +
 drivers/cxl/pmem.c |   21 +++++++++++++++++----
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 9aedd471193a..a32093602df9 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -418,6 +418,7 @@ struct cxl_nvdimm_bridge {
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

