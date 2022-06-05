Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EE0953D8F9
	for <lists+linux-pci@lfdr.de>; Sun,  5 Jun 2022 02:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243325AbiFEAvx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 4 Jun 2022 20:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243036AbiFEAva (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 4 Jun 2022 20:51:30 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 405D14EF51;
        Sat,  4 Jun 2022 17:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654390278; x=1685926278;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VRL/XFXNrqR7uC0H5iPJQehHz22+6gbF5kAjyw/QfW0=;
  b=d9Sf9aqEi1z8Li6wDGUpI0rdxEuQJFF+/hz6oB+1EozLQuoBgOJV1Ajw
   DBqC9Xg0hG30VmcKrGEzAHEnMWpHcUR7EOvcjALIC/NQVr5Z0NVIw+eTe
   GMcEEU+IbDUidXq7e5RW8Pp/KER9eVW3Krvp7eGA3PF37SNGYE7f6CeRu
   2UwZgUj4o0IjNM+9ClEAy3sjla91t8imRcKz/AuN6OuhYKz70NLDMl5cE
   sH0zAXvhEAg57u21szc5bcVcHXUbbhNzfr9EFLPHy6b+CCIQtmXIiHFer
   s1lz/g06kGJmVkcwLyzb1JmMf5POvUucqwWpDETgU81ctgr5W4XL8yuQv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10368"; a="258587695"
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="258587695"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:17 -0700
X-IronPort-AV: E=Sophos;i="5.91,278,1647327600"; 
   d="scan'208";a="578572879"
Received: from aftome-mobl2.amr.corp.intel.com (HELO localhost) ([10.209.107.207])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jun 2022 17:51:17 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Ira Weiny <ira.weiny@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Ben Widawsky <ben@bwidawsk.net>, linux-kernel@vger.kernel.org,
        linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH V10 7/9] cxl/port: Introduce cxl_cdat_valid()
Date:   Sat,  4 Jun 2022 17:50:47 -0700
Message-Id: <20220605005049.2155874-8-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220605005049.2155874-1-ira.weiny@intel.com>
References: <20220605005049.2155874-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
index f5193a6a51fe..3d8945612511 100644
--- a/drivers/cxl/cdat.h
+++ b/drivers/cxl/cdat.h
@@ -90,10 +90,12 @@
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
index 76fa8382b3c7..73e28b82ffcf 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -543,6 +543,40 @@ static int cxl_cdat_get_length(struct cxl_port *port, size_t *length)
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
+		dev_err(dev, "Invalid length %u (%zu-%zu)\n", length,
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
 static int cxl_cdat_read_table(struct cxl_port *port,
 			       struct cxl_cdat *cdat)
 {
@@ -592,6 +626,8 @@ static int cxl_cdat_read_table(struct cxl_port *port,
 
 	} while (entry_handle != 0xFFFF);
 
+	if (!rc && !cxl_cdat_valid(&port->dev, cdat))
+		return -EIO;
 	return rc;
 }
 
-- 
2.35.1

