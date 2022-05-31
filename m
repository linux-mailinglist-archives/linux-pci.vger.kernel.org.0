Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FFA55393F3
	for <lists+linux-pci@lfdr.de>; Tue, 31 May 2022 17:27:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345680AbiEaP1F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 31 May 2022 11:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345669AbiEaP1C (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 31 May 2022 11:27:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C1B3EAB0;
        Tue, 31 May 2022 08:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654010820; x=1685546820;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CRwHDt8aXJOkaw1hN2tb5kU85cFgebt1TiTvygZLCj8=;
  b=OGOVZouzQwVOljOeVHdaWrEtUn9AWsB9D6AdzyzXc6zQPxKBgIffLlmj
   +m5PByzDyBgwnAThgLhodS8m0GSx0ytLjjrAsS4kp7NuaLVmRstRyJh1g
   2bQBYFNZwBqHK9XBSd+9Gsm5z12jUGZhAPBGdp2OWd3McTujGywJjke7W
   zW3k4iALpN7pYTsnjCqdhW/mFVRfS5GJvP0TTzKkcYlBpivsgCy42BjFF
   +TeHdvqWPqYkWvSQhCU2swgiee5htM/4dbf4+FBQUxkN83vkyXoRA0xmX
   odBoEg3yqpVYksgFSG1EWmreg/cFNe3l6o2TD2MqFteyNkrlo4K3rFYPb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="275374326"
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="275374326"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 08:27:00 -0700
X-IronPort-AV: E=Sophos;i="5.91,265,1647327600"; 
   d="scan'208";a="755078902"
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
Subject: [PATCH V9 7/9] cxl/port: Introduce cxl_cdat_valid()
Date:   Tue, 31 May 2022 08:26:30 -0700
Message-Id: <20220531152632.1397976-8-ira.weiny@intel.com>
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
index 4c25a7d7abfd..bb370df1cb6c 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -534,6 +534,40 @@ static int cxl_cdat_get_length(struct cxl_port *port, size_t *length)
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
@@ -581,6 +615,8 @@ static int cxl_cdat_read_table(struct cxl_port *port,
 
 	} while (entry_handle != 0xFFFF);
 
+	if (!rc && !cxl_cdat_valid(&port->dev, cdat))
+		return -EIO;
 	return rc;
 }
 
-- 
2.35.1

