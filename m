Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD52455CDDA
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:04:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244112AbiF1EQb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 00:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243998AbiF1EQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 00:16:17 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4C82A952;
        Mon, 27 Jun 2022 21:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656389775; x=1687925775;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7XFdr+eznIKY5BISdchDRGbsYZc1KvPxuDwi55+7zKg=;
  b=jiRVRQXb6N9Pu2+IGsaD2hrofFEGtlCMnG5Khwy9a2V4jZpbsEmY+N9f
   5lhGt7taQPAqLo8Mpa4O27H2vllLvaEDxypcNuJlno94ulNBTi8hh8TlR
   3MYCGJgTqmfi20YZx/Fy46gk5Gu/cEV6bqeaIOpWVaCO/Ju3j2FjjThbN
   aTope/0pybkvc5UmkjtDL3jU0wBh8lNrncYufmfVIgEXbSrHzvaPOnAKu
   7SoH2P/p6W31HCNTOWt4cdcnXI8wiwD6NYqhWUBxpvr97puYc/nJ9oRUq
   kQEbWPVW9Gb6bXspDFUnbhsOji7Y+TRBsNf/3GiR+x3wCLyjTV3yKnb6l
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="345627092"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="345627092"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:16:14 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="646727887"
Received: from nakedgex-mobl.amr.corp.intel.com (HELO localhost) ([10.255.3.161])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:16:11 -0700
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
Subject: [PATCH V12 8/9] cxl/port: Retry reading CDAT on failure
Date:   Mon, 27 Jun 2022 21:15:26 -0700
Message-Id: <20220628041527.742333-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220628041527.742333-1-ira.weiny@intel.com>
References: <20220628041527.742333-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

Now that the cdat data is validated, issue a retry if the CDAT read
fails.  For now 5 retries are implemented.

Reviewed-by: Ben Widawsky <bwidawsk@kernel.org>
Reviewed-by: Alison Schofield <alison.schofield@intel.com>
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
 drivers/cxl/core/pci.c | 41 ++++++++++++++++++++++++++++++-----------
 1 file changed, 30 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 6d775cc3dca1..d7c2a415cc5f 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -618,36 +618,30 @@ static int cxl_cdat_read_table(struct device *dev,
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
 	ret = cxl_cdat_read_table(dev, cdat_mb, &port->cdat);
@@ -658,5 +652,30 @@ void read_cdat_data(struct cxl_port *port)
 		port->cdat.length = 0;
 		dev_err(dev, "CDAT data read error\n");
 	}
+
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
2.35.3

