Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C42A546E48
	for <lists+linux-pci@lfdr.de>; Fri, 10 Jun 2022 22:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350652AbiFJUXq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Jun 2022 16:23:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350650AbiFJUXM (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Jun 2022 16:23:12 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5735E2A97F;
        Fri, 10 Jun 2022 13:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654892591; x=1686428591;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=4p2mctKPaIflcK+x1MadV6MB5YwRUZ8n0NuOLocL9vY=;
  b=KidfmEIT8xIcM4WPl6MnN50D6ct3VQmw0VxDTyV/FR1FfPKWs7AWyqZj
   erbhH3p3uQp7QWL75Ze0Kaw4r4sDfQ4eRhx2KcDrK0/oFeDGaduPGOkVG
   XqS55JWxlJUn7WWclFxUiUSmsX8GAElq3mQdZAePKANkv4h0fs1Rpw+n5
   T3yU+EsQi+HJLeFSn+ZRlBrgRegUNoltY2QAnhK/XL86MoicsuCLLd/DK
   CaES8vb/KfAU+XcVp2kBEHXKxBWgajt6HIQ4EX/03kGHyecU6ODh7R0cG
   eERjuZnIooh291VhaOeLe3A0FQmHuk0bndni8tzlEQDxtRg8dyVHVZxqy
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="278871133"
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="278871133"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 13:23:10 -0700
X-IronPort-AV: E=Sophos;i="5.91,291,1647327600"; 
   d="scan'208";a="566990423"
Received: from pleung-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.33.34])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 13:23:09 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V11 7/8] cxl/port: Retry reading CDAT on failure
Date:   Fri, 10 Jun 2022 13:22:58 -0700
Message-Id: <20220610202259.3544623-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220610202259.3544623-1-ira.weiny@intel.com>
References: <20220610202259.3544623-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The CDAT read may fail for a number of reasons but mainly it is possible
to get different parts of a valid state.  The checksum in the CDAT table
protects against this.

Now that the cdat data is validated, issue a retry if the CDAT read
fails.  For now 5 retries are implemented.

Reviewed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V10
	Pick up review tag and fix commit message

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
 drivers/cxl/core/pci.c | 40 +++++++++++++++++++++++++++++++---------
 1 file changed, 31 insertions(+), 9 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index cb70287e2984..fd02bc7c0d97 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -617,19 +617,13 @@ static int cxl_cdat_read_table(struct device *dev,
 	return rc;
 }
 
-/**
- * read_cdat_data - Read the CDAT data on this port
- * @port: Port to read data from
- *
- * This call will sleep waiting for responses from the DOE mailbox.
- */
-void read_cdat_data(struct cxl_port *port)
+static int __read_cdat_data(struct cxl_port *port)
 {
 	static struct pci_doe_mb *cdat_mb;
 	struct device *dev = &port->dev;
 	struct device *uport = port->uport;
 	size_t cdat_length;
-	int ret;
+	int ret = 0;
 
 	/*
 	 * Ensure a reference on the underlying uport device which has the
@@ -640,17 +634,21 @@ void read_cdat_data(struct cxl_port *port)
 	cdat_mb = find_cdat_mb(uport);
 	if (!cdat_mb) {
 		dev_dbg(dev, "No CDAT mailbox\n");
+		ret = -EIO;
 		goto out;
 	}
 
 	if (cxl_cdat_get_length(dev, cdat_mb, &cdat_length)) {
 		dev_dbg(dev, "No CDAT length\n");
+		ret = -EIO;
 		goto out;
 	}
 
 	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
-	if (!port->cdat.table)
+	if (!port->cdat.table) {
+		ret = -ENOMEM;
 		goto out;
+	}
 
 	port->cdat.length = cdat_length;
 	ret = cxl_cdat_read_table(dev, cdat_mb, &port->cdat);
@@ -664,5 +662,29 @@ void read_cdat_data(struct cxl_port *port)
 
 out:
 	put_device(uport);
+	return ret;
+}
+
+/**
+ * read_cdat_data - Read the CDAT data on this port
+ * @port: Port to read data from
+ *
+ * This call will sleep waiting for responses from the DOE mailbox.
+ */
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

