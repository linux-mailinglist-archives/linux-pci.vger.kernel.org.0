Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A554A57A4
	for <lists+linux-pci@lfdr.de>; Tue,  1 Feb 2022 08:20:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234789AbiBAHUD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 1 Feb 2022 02:20:03 -0500
Received: from mga02.intel.com ([134.134.136.20]:44741 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234705AbiBAHUA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 1 Feb 2022 02:20:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643700000; x=1675236000;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PIFprQDV/7wNt+97cwXUz2TwP51ABrHXS1+ONa0OOb4=;
  b=GiDZQ0rLdbKwpSWqT5dDpChqKTVGRr1TFJVAuvpT+WrMGYGACTrMw75S
   Em58gpc1w4b/DFxtCDkf37rRaBvBeiSABasTauPeDHXfyeTmHI7Y6w5L0
   czQjj+/xqYddzQpWekA9emPxhRnvdwEF3iVZoWB7nqciCIW4tdZHmcHwe
   pKw7yNS0UFy81P4tJnP7+fRUYutMU9EeKZH4/6minabqY6VQF9Bt67g7+
   tUpnr1f/HLdMrQx2RxnufZ48rTnhPhaFX2LU4lFKCfXQ0lVWTpMjRtrbF
   CsQJylFkTUSc7/7r0VuRKQKzHVgfH+N543vwB/xIoLuSLRcJSz6HbaMrD
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="235028377"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="235028377"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:59 -0800
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="676000465"
Received: from iweiny-desk2.sc.intel.com (HELO localhost) ([10.3.52.147])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:19:59 -0800
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V6 08/10] cxl/cdat: Introduce cdat_hdr_valid()
Date:   Mon, 31 Jan 2022 23:19:50 -0800
Message-Id: <20220201071952.900068-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220201071952.900068-1-ira.weiny@intel.com>
References: <20220201071952.900068-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

The CDAT data is protected by a checksum which should be checked when
the CDAT is read to ensure it is valid.  In addition the lengths
specified should be checked.

Introduce cdat_hdr_valid() to check the checksum.  While at it check and
store the sequence number.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V5
	New patch, split out
	Update cdat_hdr_valid()
		Remove revision and cs field parsing
			There is no point in these
		Add seq check and debug print.
---
 drivers/cxl/cdat.h |  2 ++
 drivers/cxl/pci.c  | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 34 insertions(+)

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
index 28b973a9e29e..c362c75feed2 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -586,6 +586,35 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
 	return 0;
 }
 
+static bool cxl_cdat_hdr_valid(struct device *dev, struct cxl_cdat *cdat)
+{
+	u32 *table = cdat->table;
+	u8 *data8 = cdat->table;
+	u32 length, seq;
+	u8 check;
+	int i;
+
+	length = FIELD_GET(CDAT_HEADER_DW0_LENGTH, table[0]);
+	if (length < CDAT_HEADER_LENGTH_BYTES)
+		return false;
+
+	if (length > cdat->length)
+		return false;
+
+	seq = FIELD_GET(CDAT_HEADER_DW3_SEQUENCE, table[3]);
+
+	/* Store the sequence for now. */
+	if (cdat->seq != seq) {
+		dev_info(dev, "CDAT seq change %x -> %x\n", cdat->seq, seq);
+		cdat->seq = seq;
+	}
+
+	for (check = 0, i = 0; i < length; i++)
+		check += data8[i];
+
+	return check == 0;
+}
+
 #define CDAT_DOE_REQ(entry_handle)					\
 	(FIELD_PREP(CXL_DOE_TABLE_ACCESS_REQ_CODE,			\
 		    CXL_DOE_TABLE_ACCESS_REQ_CODE_READ) |		\
@@ -658,6 +687,9 @@ static int cxl_cdat_read_table(struct cxl_dev_state *cxlds,
 
 	} while (entry_handle != 0xFFFF);
 
+	if (!cxl_cdat_hdr_valid(cxlds->dev, cdat))
+		return -EIO;
+
 	return 0;
 }
 
-- 
2.31.1

