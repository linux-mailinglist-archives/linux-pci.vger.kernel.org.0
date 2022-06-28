Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0293A55DA5C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jun 2022 15:23:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244029AbiF1EQT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Jun 2022 00:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244043AbiF1EQR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Jun 2022 00:16:17 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E823286FD;
        Mon, 27 Jun 2022 21:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656389770; x=1687925770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MX7pvt/iPHsLxax2LHZQi/s75Xhwxnuyri/LPfi4VxA=;
  b=eTyJ50WbvqoWa9t94b+09sQJp9y7pJxM/KLQKjTiYI2hdlF87VypRh7q
   zzPuYG2Qpu5Cb0MDFOQe4k5Gfy5MlCPpzBcZabAoQm8xOAHebUl7p3gIE
   5HAXfOgjyDsH5yOBCjn7p/AlrT4vua+JOV+xhqyIQ4l2F2pfR88pBpE7F
   ZU0rk8vCLzO6QU+UJ7mFqu7mesV7da3JXXc4IuCXU0yb6rS9qa/LfkdsM
   J00pHeZNckMoLSiuDIRNlc29ZzH7JyBc4wZRpNfxuuzN8sCNcFKl2QYMv
   gnyDS9pidO81DMoyqv42r2jidHgjjz+4J0ZoahwGU2mq2jQIuBuKAp0zu
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="367941401"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="367941401"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:16:10 -0700
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="657966132"
Received: from nakedgex-mobl.amr.corp.intel.com (HELO localhost) ([10.255.3.161])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 21:16:07 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Lukas Wunner <lukas@wunner.de>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V12 7/9] cxl/port: Introduce cxl_cdat_valid()
Date:   Mon, 27 Jun 2022 21:15:25 -0700
Message-Id: <20220628041527.742333-8-ira.weiny@intel.com>
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

The CDAT data is protected by a checksum and should be the proper
length.

Introduce cxl_cdat_valid() to validate the data.  While at it check and
store the sequence number.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V8
	Move code to cxl/core/pci.c

Changes from V6
	Change name to cxl_cdat_valid() as this validates all the CDAT
		data not just the header
	Add error and debug prints

Changes from V5
	New patch, split out
	Update cdat_hdr_valid()
		Remove revision and cs field parsing
			There is no point in these
		Add seq check and debug print.
---
 drivers/cxl/cdat.h     |  2 ++
 drivers/cxl/core/pci.c | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
index c6a48ab326bf..39eb561081f2 100644
--- a/drivers/cxl/cdat.h
+++ b/drivers/cxl/cdat.h
@@ -91,10 +91,12 @@
  *
  * @table: cache of CDAT table
  * @length: length of cached CDAT table
+ * @seq: Last read Sequence number of the CDAT table
  */
 struct cxl_cdat {
 	void *table;
 	size_t length;
+	u32 seq;
 };
 
 #endif /* !__CXL_CDAT_H__ */
diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 4bd479ec0253..6d775cc3dca1 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -532,6 +532,40 @@ static int cxl_cdat_get_length(struct device *dev,
 	return rc;
 }
 
+static bool cxl_cdat_valid(struct device *dev, struct cxl_cdat *cdat)
+{
+	u32 *table = cdat->table;
+	u8 *data8 = cdat->table;
+	u32 length, seq;
+	u8 check;
+	int i;
+
+	length = FIELD_GET(CDAT_HEADER_DW0_LENGTH, table[0]);
+	if ((length < CDAT_HEADER_LENGTH_BYTES) || (length > cdat->length)) {
+		dev_err(dev, "CDAT Invalid length %u (%zu-%zu)\n", length,
+			CDAT_HEADER_LENGTH_BYTES, cdat->length);
+		return false;
+	}
+
+	for (check = 0, i = 0; i < length; i++)
+		check += data8[i];
+
+	dev_dbg(dev, "CDAT length %u CS %u\n", length, check);
+	if (check != 0) {
+		dev_err(dev, "CDAT Invalid checksum %u\n", check);
+		return false;
+	}
+
+	seq = FIELD_GET(CDAT_HEADER_DW3_SEQUENCE, table[3]);
+	/* Store the sequence for now. */
+	if (cdat->seq != seq) {
+		dev_info(dev, "CDAT seq change %x -> %x\n", cdat->seq, seq);
+		cdat->seq = seq;
+	}
+
+	return true;
+}
+
 static int cxl_cdat_read_table(struct device *dev,
 			       struct pci_doe_mb *cdat_mb,
 			       struct cxl_cdat *cdat)
@@ -579,6 +613,8 @@ static int cxl_cdat_read_table(struct device *dev,
 
 	} while (entry_handle != CXL_DOE_TABLE_ACCESS_LAST_ENTRY);
 
+	if (!rc && !cxl_cdat_valid(dev, cdat))
+		return -EIO;
 	return rc;
 }
 
-- 
2.35.3

