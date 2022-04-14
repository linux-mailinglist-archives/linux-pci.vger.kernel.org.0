Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29179501CCA
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346406AbiDNUfV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 16:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346392AbiDNUfT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 16:35:19 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DBA8B0A67;
        Thu, 14 Apr 2022 13:32:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649968371; x=1681504371;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wLJPKq/0myZKFPW0t2HMcu+LNF19JthPW2lDc3HdwCc=;
  b=JGlBA/LYIWOfLp6VB9ZuapI7SuNebjEj9jzfMk1HnLW98Gc5dPtIn0Xh
   WaTPHMX50iDBC56RP0+YktAMFyd6tLINcSEx4W0BsnqOCWFhVcQTwL4+j
   wxdE/a/OG1qSL5BHzEhp7a+lEQGDab+eQfBizWgLGLVyXeb2BsJTOOLlj
   Jq47tCL62YjQGXcNFgct8cIgGJ8R/B3QKxiqbsB+DT+7B2QXU/2nbQG3T
   K/B3sE4H5E84MJ4yALaEcohzDVBMdJekV+6Au2L4seggZN4CXvnHASKEI
   wN+f7oQt5vTq8AI+R1263shJkAjZ2Q0fY6FYyZtzt26eh2C/e9/x33Qlg
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="262779238"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="262779238"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:50 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="661507146"
Received: from aimeehax-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.113.132])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:49 -0700
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
Subject: [PATCH V8 08/10] cxl/cdat: Introduce cxl_cdat_valid()
Date:   Thu, 14 Apr 2022 13:32:35 -0700
Message-Id: <20220414203237.2198665-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414203237.2198665-1-ira.weiny@intel.com>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
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

The CDAT data is protected by a checksum and should be the proper
length.

Introduce cxl_cdat_valid() to validate the data.  While at it check and
store the sequence number.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
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
 drivers/cxl/cdat.h |  2 ++
 drivers/cxl/pci.c  | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 38 insertions(+)

diff --git a/drivers/cxl/cdat.h b/drivers/cxl/cdat.h
index 4722b6bbbaf0..a7725d26f2d2 100644
--- a/drivers/cxl/cdat.h
+++ b/drivers/cxl/cdat.h
@@ -88,10 +88,12 @@
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
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index aecb327911a0..d7952156dd02 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -781,6 +781,40 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
 	return 0;
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
+		dev_err(dev, "Invalid length %u (%lu-%lu)\n", length,
+			CDAT_HEADER_LENGTH_BYTES, cdat->length);
+		return false;
+	}
+
+	for (check = 0, i = 0; i < length; i++)
+		check += data8[i];
+
+	dev_dbg(dev, "CDAT length %u CS %u\n", length, check);
+	if (check != 0) {
+		dev_err(dev, "Invalid checksum %u\n", check);
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
 #define CDAT_DOE_REQ(entry_handle)					\
 	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
 		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
@@ -892,6 +926,8 @@ static int cxl_cdat_read_table(struct cxl_dev_state *cxlds,
 
 release_driver:
 	cxl_pci_doe_put_drv(doe_dev);
+	if (!rc && !cxl_cdat_valid(cxlds->dev, cdat))
+		return -EIO;
 	return rc;
 }
 
-- 
2.35.1

