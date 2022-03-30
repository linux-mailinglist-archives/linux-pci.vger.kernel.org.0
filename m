Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82844ED08A
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 01:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351943AbiCaABZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 20:01:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351933AbiCaABS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 20:01:18 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4822665497;
        Wed, 30 Mar 2022 16:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648684772; x=1680220772;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3aXhpLXCvCCvNR3pAgcULgqkJ5JSx3pe9KBXPA5ttYQ=;
  b=fc1VGWIF3Cd9js/7ddjiJUyXypvCggIQevUvhTuyrud77G6mcC1euHpj
   8lsDS8GeiFG/8RPrHNK98+xk67g5lvwprjsvyiEcyfGPdhxJ2heuI33V3
   Wxd8dm+be8+xkB5KHEGtvwxEJOQ7d5JGtmBWABCOOm5mkS7TcnmG4Sj6w
   GVZEpW0JUyH+qiw0cIqZuxmRPCw7H4qI77RhR8mroyR3wX7ND6MUn1QXm
   Mkshp4wKuzb5lvNH5jXNd65qTVAq3OZ06PQkQzsYoBaOctqeaZqIOB+0O
   7STTKtcmrB9ZA2qbSU18MnODAR2sxpEx44Kgsuyn4hYaLym7mSCPKSRDC
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="258504755"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="258504755"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:32 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="788192195"
Received: from npeper-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.16.15])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:31 -0700
From:   ira.weiny@intel.com
To:     Dan Williams <dan.j.williams@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Ben Widawsky <ben.widawsky@intel.com>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH V7 08/10] cxl/cdat: Introduce cxl_cdat_valid()
Date:   Wed, 30 Mar 2022 16:59:18 -0700
Message-Id: <20220330235920.2800929-9-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330235920.2800929-1-ira.weiny@intel.com>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
index a1d500381438..ddd6b705fd67 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -762,6 +762,40 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
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
@@ -873,6 +907,8 @@ static int cxl_cdat_read_table(struct cxl_dev_state *cxlds,
 
 release_driver:
 	cxl_pci_doe_put_drv(doe_dev);
+	if (!rc && !cxl_cdat_valid(cxlds->dev, cdat))
+		return -EIO;
 	return rc;
 }
 
-- 
2.35.1

