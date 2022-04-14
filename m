Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0524501CC6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:39:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346470AbiDNUfX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 16:35:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346385AbiDNUfS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 16:35:18 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331D8AFB16;
        Thu, 14 Apr 2022 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649968371; x=1681504371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/taNXiY+aQ4D317iUp/jYzAGsehZyFDStycleEwLH7g=;
  b=l2rfK0Eky0eFHkbZmIOiNdG+fBM8cUkdXGYEidxOozPBzwKmKqq8Wh0q
   9zJLlD/SJGb/My038kFvWSHb6/bU/xHKVCgwUUf9/xjvLVX6Pvd4nZ6u+
   ZltB4sXy86I1zuY+WuES3FBfmxnDVZbDAHS7OcIpAlc2l2HaCOZR+7dyN
   TQTFCPTu84yVPxQ098P31y51LkUDie+c8s46oT047TTSWEMR2tUgIDkVF
   JG9sp6XrQBaKQEWnyg0sFs4ryNP6ZiV7uYn+D5zBdkiKobPCooK7WuWlD
   yZzh49UXKjfE4VqLi0PRJ5tB2NAleLMdErvp163h+Wn9NJWvTzNZZu2s9
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="263202411"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="263202411"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="700807729"
Received: from aimeehax-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.113.132])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:50 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V8 09/10] cxl/mem: Retry reading CDAT on failure
Date:   Thu, 14 Apr 2022 13:32:36 -0700
Message-Id: <20220414203237.2198665-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414203237.2198665-1-ira.weiny@intel.com>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The CDAT read may fail for a number of reasons but mainly it is possible
to get different parts of a valid state.  The checksum in the CDAT table
protects against this.

Now that the cdat data is validated issue a retries if the CDAT read
fails.  For now 5 retries are implemented.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V6
	Move to pci.c
	Fix retries count
	Change to 5 retries

Changes from V5:
	New patch -- easy to push off or drop.
---
 drivers/cxl/pci.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index d7952156dd02..43cbc297079d 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -940,7 +940,7 @@ static void cxl_initialize_cdat_callbacks(struct cxl_dev_state *cxlds)
 	cxlds->cdat_read_table = cxl_cdat_read_table;
 }
 
-static int read_cdat_data(struct cxl_dev_state *cxlds)
+static int __read_cdat_data(struct cxl_dev_state *cxlds)
 {
 	struct device *dev = cxlds->dev;
 	size_t cdat_length;
@@ -962,6 +962,21 @@ static int read_cdat_data(struct cxl_dev_state *cxlds)
 	return ret;
 }
 
+static void read_cdat_data(struct cxl_dev_state *cxlds)
+{
+	int retries = 5;
+	int rc;
+
+	while (retries--) {
+		rc = __read_cdat_data(cxlds);
+		if (!rc)
+			break;
+		dev_err(cxlds->dev,
+			"CDAT data read error rc=%d (retries %d)\n",
+			rc, retries);
+	}
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -1035,9 +1050,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	cxl_initialize_cdat_callbacks(cxlds);
 
 	/* Cache the data early to ensure is_visible() works */
-	rc = read_cdat_data(cxlds);
-	if (rc)
-		dev_err(&pdev->dev, "CDAT data read error (%d)\n", rc);
+	read_cdat_data(cxlds);
 
 	cxl_dvsec_ranges(cxlds);
 
-- 
2.35.1

