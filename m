Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04C9501CBC
	for <lists+linux-pci@lfdr.de>; Thu, 14 Apr 2022 22:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346358AbiDNUfZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Apr 2022 16:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346376AbiDNUfO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Apr 2022 16:35:14 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94CAAFACE;
        Thu, 14 Apr 2022 13:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649968368; x=1681504368;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=esZFHOlUtVB8Mxgv4vakb9fRAVpIFIVpO6bWYPlosDk=;
  b=GFg28qfurQbjF95iMAxvH3oLZI7q9GY0t1OOXyQeSBUBjF2Dzf9iTVm0
   BO8W8VGJPwlNJaUIwFRl8hzW1ZLC88m0+ctC3pguIJH7BTqhyaQ9Naodr
   7wHzJn/gt/RrUsXn2Avku7uyZvbIs6risxS3SSy5RQ43jZCLU2d0FHcXr
   Cdy4fPQoa/k8nxnUqqMq3vO5n7fp3ScTR3/sIBQArVOnl5lgN56nmK0cT
   P41nCNykFyzEjKyBIRut5Szns4LGTIHRFY50Pry+w9GENamTnud3Ehxn9
   oaV4XuqRciZQE2bKxZHnfjMCmEK6MPmHT9KL9j0JYV3nxyojteFzjgROs
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="261869991"
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="261869991"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:48 -0700
X-IronPort-AV: E=Sophos;i="5.90,260,1643702400"; 
   d="scan'208";a="508546755"
Received: from aimeehax-mobl1.amr.corp.intel.com (HELO localhost) ([10.212.113.132])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Apr 2022 13:32:47 -0700
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
Subject: [PATCH V8 06/10] cxl/pci: Find the DOE mailbox which supports CDAT
Date:   Thu, 14 Apr 2022 13:32:33 -0700
Message-Id: <20220414203237.2198665-7-ira.weiny@intel.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414203237.2198665-1-ira.weiny@intel.com>
References: <20220414203237.2198665-1-ira.weiny@intel.com>
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

Each CXL device may have multiple DOE mailbox capabilities and each
mailbox may support multiple protocols.

Search the DOE auxiliary devices for one which supports the CDAT
protocol.  Cache that device to be used for future queries.

Signed-off-by: Ira Weiny <ira.weiny@intel.com>

---
Changes from V7
	Minor code clean ups

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
 drivers/cxl/pci.c    | 76 +++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 990b6670222e..50817fd2c912 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -90,6 +90,8 @@ static inline int cxl_hdm_decoder_count(u32 cap_hdr)
 #define CXLDEV_MBOX_BG_CMD_STATUS_OFFSET 0x18
 #define CXLDEV_MBOX_PAYLOAD_OFFSET 0x20
 
+#define CXL_DOE_PROTOCOL_TABLE_ACCESS 2
+
 /*
  * Using struct_group() allows for per register-block-type helper routines,
  * without requiring block-type agnostic code to include the prefix.
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 7235d2f976e5..0dc6988afb30 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -168,6 +168,7 @@ struct cxl_endpoint_dvsec_info {
  * Currently only memory devices are represented.
  *
  * @dev: The device associated with this CXL state
+ * @cdat_doe: Auxiliary DOE device capabile of reading CDAT
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @payload_size: Size of space for payload
@@ -200,6 +201,7 @@ struct cxl_endpoint_dvsec_info {
 struct cxl_dev_state {
 	struct device *dev;
 
+	struct cxl_doe_dev *cdat_doe;
 	struct cxl_regs regs;
 	int cxl_dvsec;
 
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0dec1f1a3f38..622cac925262 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -706,6 +706,80 @@ static int cxl_pci_create_doe_devices(struct pci_dev *pdev)
 	return 0;
 }
 
+static bool cxl_doe_dev_supports_prot(struct cxl_doe_dev *doe_dev, u16 vid, u16 pid)
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
+static int cxl_setup_doe_devices(struct cxl_dev_state *cxlds)
+{
+	struct device *dev = cxlds->dev;
+	struct pci_dev *pdev = to_pci_dev(dev);
+	struct auxiliary_device *adev;
+	int rc;
+
+	rc = cxl_pci_create_doe_devices(pdev);
+	if (rc)
+		return rc;
+
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
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -772,7 +846,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 
-	rc = cxl_pci_create_doe_devices(pdev);
+	rc = cxl_setup_doe_devices(cxlds);
 	if (rc)
 		return rc;
 
-- 
2.35.1

