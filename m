Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C2124CBF72
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 15:03:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiCCODs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 09:03:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbiCCODs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 09:03:48 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51AF427CF;
        Thu,  3 Mar 2022 06:03:02 -0800 (PST)
Received: from fraeml712-chm.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8Xj55DSmz67x9g;
        Thu,  3 Mar 2022 22:01:45 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml712-chm.china.huawei.com (10.206.15.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 15:03:00 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:02:59 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <keyrings@vger.kernel.org>, "Bjorn Helgaas" <bjorn@helgaas.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        <dan.j.williams@intel.com>
Subject: [RFC PATCH v2 08/14] cxl/cdat: Introduce cdat_hdr_valid()
Date:   Thu, 3 Mar 2022 13:58:59 +0000
Message-ID: <20220303135905.10420-9-Jonathan.Cameron@huawei.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
References: <20220303135905.10420-1-Jonathan.Cameron@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.122.247.231]
X-ClientProxiedBy: lhreml706-chm.china.huawei.com (10.201.108.55) To
 lhreml710-chm.china.huawei.com (10.201.108.61)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
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
index ebd98a8a310f..ed94a6bef2de 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -522,6 +522,35 @@ static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
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
@@ -594,6 +623,9 @@ static int cxl_cdat_read_table(struct cxl_dev_state *cxlds,
 
 	} while (entry_handle != 0xFFFF);
 
+	if (!cxl_cdat_hdr_valid(cxlds->dev, cdat))
+		return -EIO;
+
 	return 0;
 }
 
-- 
2.32.0

