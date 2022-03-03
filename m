Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47294CBF64
	for <lists+linux-pci@lfdr.de>; Thu,  3 Mar 2022 15:02:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiCCODF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 09:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiCCOCs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 09:02:48 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F1B188A08;
        Thu,  3 Mar 2022 06:02:00 -0800 (PST)
Received: from fraeml713-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4K8Xgz1fv0z67btc;
        Thu,  3 Mar 2022 22:00:47 +0800 (CST)
Received: from lhreml710-chm.china.huawei.com (10.201.108.61) by
 fraeml713-chm.china.huawei.com (10.206.15.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 15:01:58 +0100
Received: from SecurePC-101-06.china.huawei.com (10.122.247.231) by
 lhreml710-chm.china.huawei.com (10.201.108.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.21; Thu, 3 Mar 2022 14:01:58 +0000
From:   Jonathan Cameron <Jonathan.Cameron@huawei.com>
To:     <linux-cxl@vger.kernel.org>, <linux-pci@vger.kernel.org>
CC:     <linuxarm@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Chris Browy <cbrowy@avery-design.com>,
        <keyrings@vger.kernel.org>, "Bjorn Helgaas" <bjorn@helgaas.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        <dan.j.williams@intel.com>
Subject: [RFC PATCH v2 06/14] cxl/pci: Find the DOE mailbox which supports CDAT
Date:   Thu, 3 Mar 2022 13:58:57 +0000
Message-ID: <20220303135905.10420-7-Jonathan.Cameron@huawei.com>
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

Memory devices need the CDAT data from the device.  This data is read
from a DOE mailbox which supports the CDAT protocol.

Search the DOE auxiliary devices for the one which supports the CDAT
protocol.  Cache that device to be used for future queries.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/cxl/cxl.h    |  3 +++
 drivers/cxl/cxlmem.h |  2 ++
 drivers/cxl/pci.c    | 43 ++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index a5a0be3f088b..a5a071056dac 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -75,6 +75,9 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
+#define CXL_DOE_PROTOCOL_COMPLIANCE 0
+#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 8d96d009ad90..176228d8c66d 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -97,6 +97,7 @@ struct cxl_mbox_cmd {
  * Currently only memory devices are represented.
  *
  * @dev: The device associated with this CXL state
+ * @cdat_doe: Auxiliary DOE device capabile of reading CDAT
  * @regs: Parsed register blocks
  * @payload_size: Size of space for payload
  *                (CXL 2.0 8.2.8.4.3 Mailbox Capabilities Register)
@@ -124,6 +125,7 @@ struct cxl_mbox_cmd {
 struct cxl_dev_state {
 	struct device *dev;
 
+	struct pci_doe_dev *cdat_doe;
 	struct cxl_regs regs;
 
 	size_t payload_size;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0adc7798e0cf..adcabc0bcb38 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -472,12 +472,53 @@ static int cxl_setup_regs(struct pci_dev *pdev, enum cxl_regloc_type type,
 	return rc;
 }
 
+static int cxl_match_cdat_doe_device(struct device *dev, const void *data)
+{
+	const struct cxl_dev_state *cxlds = data;
+	struct auxiliary_device *adev;
+	struct pci_doe_dev *doe_dev;
+
+	/* First determine if this auxiliary device belongs to the cxlds */
+	if (cxlds->dev != dev->parent)
+		return 0;
+
+	adev = to_auxiliary_dev(dev);
+	doe_dev = container_of(adev, struct pci_doe_dev, adev);
+
+	/* If it is one of ours check for the CDAT protocol */
+	if (pci_doe_supports_prot(doe_dev, PCI_DVSEC_VENDOR_ID_CXL,
+				  CXL_DOE_PROTOCOL_TABLE_ACCESS))
+		return 1;
+
+	return 0;
+}
+
 static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
 {
 	struct device *dev = cxlds->dev;
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct auxiliary_device *adev;
+	int rc;
 
-	return pci_doe_create_doe_devices(pdev);
+	rc = pci_doe_create_doe_devices(pdev);
+	if (rc)
+		return rc;
+
+	adev = auxiliary_find_device(NULL, cxlds, &cxl_match_cdat_doe_device);
+
+	if (adev) {
+		struct pci_doe_dev *doe_dev = container_of(adev,
+							   struct pci_doe_dev,
+							   adev);
+
+		/*
+		 * No reference need be taken.  The DOE device lifetime is
+		 * longer that the CXL device state lifetime
+		 */
+		cxlds->cdat_doe = doe_dev;
+	}
+
+	return 0;
 }
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.32.0

