Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8ED74ED087
	for <lists+linux-pci@lfdr.de>; Thu, 31 Mar 2022 01:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351951AbiCaABX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 30 Mar 2022 20:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351926AbiCaABR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 30 Mar 2022 20:01:17 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43C396620C;
        Wed, 30 Mar 2022 16:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648684770; x=1680220770;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UoHCR5fwRhG3qYCbTHrjpwBA/tAoJc+8meQHMnK+rLk=;
  b=dhiAB0yizV1OEPD0KaZLvsM1m4FsAV3T7QCIJ6zWQlVe4DNKl7veuWCC
   XOBlPWak7kPRfykSHVQbnTJ9GTGYBHm/Hj04MhVFvxxopRLOnjDXOYDE5
   Egfw8MpXQFZ3EsrZkor0l9QbLGlZm4eZBZLk5vAHWQrW10q3ys3fMtB+t
   vP9UlTMaNp64ip2mHKcaurJr2QRqJITdfXOTrfzMpSjKWgHyfEHUDsct9
   +zRxzK4dDRkrF/0LXOUZSI8wLDv18ZEvtZX9iuBo3H1I4M839EKKvs0bR
   l3f46I0OM7pq/FAAhW4O37+kORtEpVKJvKX7FZAqCNJ9BVPP4wtHrAGWW
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="241825503"
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="241825503"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:29 -0700
X-IronPort-AV: E=Sophos;i="5.90,223,1643702400"; 
   d="scan'208";a="605727027"
Received: from npeper-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.16.15])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2022 16:59:29 -0700
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
Subject: [PATCH V7 06/10] cxl/pci: Find the DOE mailbox which supports CDAT
Date:   Wed, 30 Mar 2022 16:59:16 -0700
Message-Id: <20220330235920.2800929-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220330235920.2800929-1-ira.weiny@intel.com>
References: <20220330235920.2800929-1-ira.weiny@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ira Weiny <ira.weiny@intel.com>

Each CXL device may have multiple DOE mailbox capabilities and each
mailbox may support multiple protocols.

Search the DOE auxiliary devices for one which supports the CDAT
protocol.  Cache that device to be used for future queries.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V6
	Adjust for aux devices being a CXL only concept
	Update commit msg.
	Ensure devices iterated by auxiliary_find_device() are checked
		to be DOE devices prior to checking for the CDAT
		protocol
	From Ben
		Ensure reference from auxiliary_find_device() is dropped
---
 drivers/cxl/cxl.h    |  2 ++
 drivers/cxl/cxlmem.h |  2 ++
 drivers/cxl/pci.c    | 68 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 71 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 70a12bfd71b5..80f462509b13 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -153,6 +153,8 @@ static inline bool cxl_is_interleave_granularity_valid(int ig)
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
+#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index d5c9a273d07d..33bf9ffd1323 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -119,6 +119,7 @@ struct cxl_endpoint_dvsec_info {
  * Currently only memory devices are represented.
  *
  * @dev: The device associated with this CXL state
+ * @cdat_doe: Auxiliary DOE device capabile of reading CDAT
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @payload_size: Size of space for payload
@@ -151,6 +152,7 @@ struct cxl_endpoint_dvsec_info {
 struct cxl_dev_state {
 	struct device *dev;
 
+	struct cxl_doe_dev *cdat_doe;
 	struct cxl_regs regs;
 	int cxl_dvsec;
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bc94811a8395..84ecb05b592f 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -687,12 +687,78 @@ int cxl_pci_create_doe_devices(struct pci_dev *pdev)
 	return 0;
 }
 
+bool cxl_doe_dev_supports_prot(struct cxl_doe_dev *doe_dev, u16 vid, u16 pid)
+{
+	struct cxl_doe_drv_state *doe_ds;
+	bool ret;
+
+	doe_ds = cxl_pci_doe_get_drv(doe_dev);
+	if (!doe_ds) {
+		cxl_pci_doe_put_drv(doe_dev);
+		return false;
+	}
+	ret = pci_doe_supports_prot(doe_ds->doe_mb, vid, pid);
+	cxl_pci_doe_put_drv(doe_dev);
+	return ret;
+}
+
+static int cxl_match_cdat_doe_device(struct device *dev, const void *data)
+{
+	const struct cxl_dev_state *cxlds = data;
+	struct auxiliary_device *adev = to_auxiliary_dev(dev);
+	struct cxl_doe_dev *doe_dev;
+
+	/* Ensure this is a DOE device */
+	if (strcmp(DOE_DEV_NAME, adev->name))
+		return 0;
+
+	/* Determine if this auxiliary device belongs to the cxlds */
+	if (cxlds->dev != dev->parent)
+		return 0;
+
+	doe_dev = container_of(adev, struct cxl_doe_dev, adev);
+
+	/* If it is one of ours check for the CDAT protocol */
+	if (!cxl_doe_dev_supports_prot(doe_dev, PCI_DVSEC_VENDOR_ID_CXL,
+				   CXL_DOE_PROTOCOL_TABLE_ACCESS))
+		return 0;
+
+	return 1;
+}
+
+static void drop_cdat_doe_ref(void *data)
+{
+	struct cxl_doe_dev *cdat_doe = data;
+
+	put_device(&cdat_doe->adev.dev);
+}
+
 static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
 {
 	struct device *dev = cxlds->dev;
 	struct pci_dev *pdev = to_pci_dev(dev);
+	struct auxiliary_device *adev;
+	int rc;
+
+	rc = cxl_pci_create_doe_devices(pdev);
+	if (rc)
+		return rc;
 
-	return cxl_pci_create_doe_devices(pdev);
+	adev = auxiliary_find_device(NULL, cxlds, &cxl_match_cdat_doe_device);
+
+	if (adev) {
+		struct cxl_doe_dev *doe_dev = container_of(adev,
+							   struct cxl_doe_dev,
+							   adev);
+
+		/* auxiliary_find_device() takes the reference */
+		rc = devm_add_action_or_reset(dev, drop_cdat_doe_ref, doe_dev);
+		if (rc)
+			return rc;
+		cxlds->cdat_doe = doe_dev;
+	}
+
+	return 0;
 }
 
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
-- 
2.35.1

