Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 509814ED085
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 01:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351937AbiCaABX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 20:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351935AbiCaABS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 20:01:18 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86931652EB;
        Wed, 30 Mar 2022 16:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648684772; x=1680220772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=g4q2mXTnI7027E/tCPAJH+r3uvyVXQPZPmn4ZIJzKpU=;
  b=YVmPKxVuLcmaElkhsVAH0A7QgOUbkHPHzhpN3gka3KD4COwa2wHdAZ7P
   8vZlHY1oaJc6o1z8ltngHYzAkxycYtWo9gIU5+b8lb1jHHfs4f5E+KJaT
   tOKDtHQ0x+IU4lNUWSSHQYn8fWdWMG+J96QNtSIefeIFq+/gc7RdH2f9x
   KqRmfojO1b50gcbL90VkwiqGCpL9AizFEYhyoYyXlqvDSFu9PDvBBUrA/
   zOqtSO7VlblXyw+1rtem0AN3kBCmagrVcubKRvjwztKPL4lx6fR8NzR7W
   gwLkbKOV3Uv4h7UNCDApTS1skLOmBXs3O8b3gtQG/0ewjM9/fPZUG74DU
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="259647272"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="259647272"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="586194648"
Received: from npeper-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.16.15])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:31 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V7 09/10] cxl/mem: Retry reading CDAT on failure
Date:   Wed, 30 Mar 2022 16:59:19 -0700
Message-Id: <20220330235920.2800929-10-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330235920.2800929-1-ira.weiny@intel.com>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
index ddd6b705fd67..6205f4eba729 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -921,7 +921,7 @@ static void cxl_initialize_cdat_callbacks(struct cxl_dev_state *cxlds)
 	cxlds->cdat_read_table = cxl_cdat_read_table;
 }
 
-static int read_cdat_data(struct cxl_dev_state *cxlds)
+static int __read_cdat_data(struct cxl_dev_state *cxlds)
 {
 	struct device *dev = cxlds->dev;
 	size_t cdat_length;
@@ -943,6 +943,21 @@ static int read_cdat_data(struct cxl_dev_state *cxlds)
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
@@ -1016,9 +1031,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	cxl_initialize_cdat_callbacks(cxlds);
 
 	/* Cache the data early to ensure is_visible() works */
-	rc = read_cdat_data(cxlds);
-	if (rc)
-		dev_err(&pdev->dev, "CDAT data read error (%d)\n", rc);
+	read_cdat_data(cxlds);
 
 	rc = cxl_dvsec_ranges(cxlds);
 	if (rc)
-- 
2.35.1

