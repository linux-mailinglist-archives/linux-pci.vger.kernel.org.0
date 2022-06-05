Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 056F253D8F6
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jun 2022 02:52:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243051AbiFEAv5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jun 2022 20:51:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243074AbiFEAva (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jun 2022 20:51:30 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D084F44F;
        Sat,  4 Jun 2022 17:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654390280; x=1685926280;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dHK7ZpmCtuBOKUtE6EGqmpAzNTrWrN2Dm+7SaQy2iEI=;
  b=jxJ2nBtVfoXhRQTUqnsENXM8ab3nJnYvSssCnCVbfFVco5YILvDEMjK4
   dj3gcrN03W85mGeE3gW9jWO7LsGo6lv9TUcDdU2562PDjreNMWU0Ge72c
   M3NnFzRj7NFnSuNSyvrageWiTWRXuQb7DqShlF76Yo5jhJhS3y6jER+zl
   IRL83kKumwicur/TWOYH9C3nTNRoXL6GMAQ3Dwwpp2PHAm+fBisuobl6h
   yMHHgBQhmwa4heWcy9cNN5w/r0VW8xP1vKXp1uDLCkWe/qX1+teVUmfWf
   vLpzw2K7/1dFrpfanV3D0/f7J8GugC/yPgHvOw7wXMfe3D/4L4MY968lD
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="256970417"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="256970417"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:19 -0700
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="583102893"
Received: from aftome-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.107.207])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:18 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V10 8/9] cxl/port: Retry reading CDAT on failure
Date:   Sat,  4 Jun 2022 17:50:48 -0700
Message-Id: <20220605005049.2155874-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220605005049.2155874-1-ira.weiny@intel.com>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
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

From: Ira Weiny <ira.weiny@intel.com>

The CDAT read may fail for a number of reasons but mainly it is possible
to get different parts of a valid state.  The checksum in the CDAT table
protects against this.

Now that the cdat data is validated issue a retries if the CDAT read
fails.  For now 5 retries are implemented.

Cc: Alison Schofield <alison.schofield@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V9
	Alison Schofield/Davidlohr Bueso
		Print debug on each iteration and error only after failure

Changes from V8
	Move code to cxl/core/pci.c

Changes from V6
	Move to pci.c
	Fix retries count
	Change to 5 retries

Changes from V5:
	New patch -- easy to push off or drop.
---
 drivers/cxl/core/pci.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 73e28b82ffcf..e68f13e66fcf 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -631,20 +631,18 @@ static int cxl_cdat_read_table(struct cxl_port *port,
 	return rc;
 }
 
-void read_cdat_data(struct cxl_port *port)
+static int __read_cdat_data(struct cxl_port *port)
 {
 	struct device *dev = &port->dev;
 	size_t cdat_length;
 	int ret;
 
 	if (cxl_cdat_get_length(port, &cdat_length))
-		return;
+		return 0;
 
 	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
-	if (!port->cdat.table) {
-		ret = -ENOMEM;
-		goto error;
-	}
+	if (!port->cdat.table)
+		return -ENOMEM;
 
 	port->cdat.length = cdat_length;
 	ret = cxl_cdat_read_table(port, &port->cdat);
@@ -652,12 +650,26 @@ void read_cdat_data(struct cxl_port *port)
 		devm_kfree(dev, port->cdat.table);
 		port->cdat.table = NULL;
 		port->cdat.length = 0;
-		ret = -EIO;
-		goto error;
+		return -EIO;
 	}
 
-	return;
-error:
-	dev_err(dev, "CDAT data read error (%d)\n", ret);
+	return 0;
+}
+
+void read_cdat_data(struct cxl_port *port)
+{
+	int retries = 5;
+	int rc;
+
+	while (retries--) {
+		rc = __read_cdat_data(port);
+		if (!rc)
+			return;
+		dev_dbg(&port->dev,
+			"CDAT data read error rc=%d (retries %d)\n",
+			rc, retries);
+	}
+	dev_err(&port->dev, "CDAT data read failed after %d retries\n",
+		retries);
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
-- 
2.35.1

