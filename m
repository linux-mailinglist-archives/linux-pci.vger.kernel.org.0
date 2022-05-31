Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5095393F8
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 17:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345695AbiEaP1I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 11:27:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345679AbiEaP1D (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 11:27:03 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24EB941338;
        Tue, 31 May 2022 08:27:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654010822; x=1685546822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=l6Ptm6qMXpyQPZSb/pJ6DCgdCa2Af4FyN5x310HyCKk=;
  b=BCp8aYArsmMQqFnNGxnbrNJsQW4vStzNmS+yiO4N17+/3O6EhiXfRwQI
   CLZku4peKdwI9kN8ZTGMJuqc1BOM2F8oTrBSAua01E51IXNxbuDR6qaOx
   qy8SxK7n9By1adao3k/VwaxIulu1FLT1V1oJcx00xilPlZlwP3s2hBdrZ
   iyBZzNgW2D5wxQdxqTfE2C7IhsCNcDcgiT7TuDYwO0GJmj+qNcS1Ry9xg
   RSoPTCXNOMD0ScaYTOLqjJZk3xqLC+MwVSgFN5uysZ14CM6ViS/TX8Kgr
   yNMjqE4kHPEdYKntLdcw6+IGnqfzS8AfLs/fbGJ7z2lhZPR8bR6yoORUP
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275374331"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="275374331"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:27:01 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="755078908"
Received: from mdossant-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.154.135])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:27:00 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V9 8/9] cxl/port: Retry reading CDAT on failure
Date:   Tue, 31 May 2022 08:26:31 -0700
Message-Id: <20220531152632.1397976-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220531152632.1397976-1-ira.weiny@intel.com>
References: <20220531152632.1397976-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
Changes from V8
	Move code to cxl/core/pci.c

Changes from V6
	Move to pci.c
	Fix retries count
	Change to 5 retries

Changes from V5:
	New patch -- easy to push off or drop.
---
 drivers/cxl/core/pci.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index bb370df1cb6c..7f7dac9030a6 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -620,20 +620,18 @@ static int cxl_cdat_read_table(struct cxl_port *port,
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
@@ -641,12 +639,24 @@ void read_cdat_data(struct cxl_port *port)
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
+			break;
+		dev_err(&port->dev,
+			"CDAT data read error rc=%d (retries %d)\n",
+			rc, retries);
+	}
 }
 EXPORT_SYMBOL_NS_GPL(read_cdat_data, CXL);
-- 
2.35.1

