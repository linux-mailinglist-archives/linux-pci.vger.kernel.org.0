Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B86156737A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Jul 2022 17:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232959AbiGEPvp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 5 Jul 2022 11:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232195AbiGEPvG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 5 Jul 2022 11:51:06 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0911928E;
        Tue,  5 Jul 2022 08:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657036211; x=1688572211;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KHO4l4f5twVCRTpiTRrOo5KIdLqw6qldFhvobbtx6xE=;
  b=k3ZCWoDa/3qKtD26RyJvsOYpx7uY/j0eHN3kpSQ17jwQ659iFfbt6Czo
   DpFSGFhke3WpRE9jTBOHt5WTM5OSq9bsPc0J6fzwhnZjTonAq6kZZChV/
   9KhLPNy2cjMqWfBtB5DYB+jsIkPwZcjcuiCNP6rGMZubAu2A1zU9sSN2i
   utyrgbWy79HPZO5T+pZ6gAq1coePr+PwPJBlqebGnOiYwflWZj5yZxxcl
   fWIZyat7+yAZFjAjawgNnYXdXJVhz01mUMrGpfsD0azVDZnNmPohVb/WW
   mxlYQOW/0mUvDRDfRUYHVx0F2UlXVycDB8Bbv2SpWCd5xO/hK3RI/Z4S8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10398"; a="272169460"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="272169460"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:50:11 -0700
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="660600771"
Received: from amangla-mobl.amr.corp.intel.com (HELO localhost) ([10.255.0.184])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 08:50:08 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Alison Schofield <alison.schofield@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V13 8/9] cxl/port: Retry reading CDAT on failure
Date:   Tue,  5 Jul 2022 08:49:31 -0700
Message-Id: <20220705154932.2141021-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220705154932.2141021-1-ira.weiny@intel.com>
References: <20220705154932.2141021-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V12
	Jonathan:
		Standardize on 'rc' for return code
		Don't set rc unnecessarily

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
 drivers/cxl/core/pci.c | 39 +++++++++++++++++++++++++++++----------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 0a1620c302e1..0853885c5767 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -623,13 +623,7 @@ static int cxl_cdat_read_table(struct device *dev,
 	return 0;
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
@@ -640,19 +634,19 @@ void read_cdat_data(struct cxl_port *port)
 	cdat_mb = find_cdat_mb(uport);
 	if (!cdat_mb) {
 		dev_dbg(dev, "No CDAT mailbox\n");
-		return;
+		return -EIO;
 	}
 
 	port->cdat_sup = true;
 
 	if (cxl_cdat_get_length(dev, cdat_mb, &cdat_length)) {
 		dev_dbg(dev, "No CDAT length\n");
-		return;
+		return -EIO;
 	}
 
 	port->cdat.table = devm_kzalloc(dev, cdat_length, GFP_KERNEL);
 	if (!port->cdat.table)
-		return;
+		return -ENOMEM;
 
 	port->cdat.length = cdat_length;
 	rc = cxl_cdat_read_table(dev, cdat_mb, &port->cdat);
@@ -663,5 +657,30 @@ void read_cdat_data(struct cxl_port *port)
 		port->cdat.length = 0;
 		dev_err(dev, "CDAT data read error\n");
 	}
+
+	return rc;
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
2.35.3

