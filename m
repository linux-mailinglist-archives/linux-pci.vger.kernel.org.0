Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE69D63C6F3
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 19:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230410AbiK2SB0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 13:01:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiK2SB0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 13:01:26 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4004A6B389;
        Tue, 29 Nov 2022 10:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744885; x=1701280885;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QmF5FfaJ/S2y6cErJixUHr2KJoo87IHjihqaSCcnrcM=;
  b=a6XXcqsDvKNaEc1fHlI5t4KMtY36jejyMwoCGAbuhVciXSEWoxRNt2cv
   q5PL4C3v5VPUnGbVnslZSggVI6tkniJX3zaVKDWwbWkJLJp3iiDmERjnb
   1WIlVsDlHVUBJqg/mhD5VZ6eKieiRhu4wgnI1yeQyQfIqNcIDV2Y3fmqm
   tR5c1lFQjjIZuZJ8rIB7gO8l2vPKTnHCKMBzlRGtsazDCWEQzMrMgp10N
   X0JaywT8pS8YZ1iPyhJoK2FB9MP3Uf0ZSsvZ9EhTntetrOKDy/5gxGUG6
   G3cdNZfCQrBaafLRuSna4oeyVlt3g+0EcnYpYMCUyN5qpQ7Z6MH5fFh15
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="379467681"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="379467681"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:49 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="621554740"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="621554740"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:48:48 -0800
Subject: [PATCH v4 07/11] cxl/pci: Find and map the RAS Capability Structure
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
Date:   Tue, 29 Nov 2022 10:48:48 -0700
Message-ID: <166974412803.1608150.7096566580400947001.stgit@djiang5-desk3.ch.intel.com>
In-Reply-To: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
References: <166974401763.1608150.5424589924034481387.stgit@djiang5-desk3.ch.intel.com>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

The RAS Capability Structure has some ancillary information that may be
relevant with respect to AER events, link and protcol error status
registers. Map the RAS Capability Registers in support of defining a
'struct pci_error_handlers' instance for the cxl_pci driver.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/regs.c |    7 +++++++
 drivers/cxl/cxl.h       |   19 +++++++++++++++++++
 drivers/cxl/pci.c       |    8 ++++++++
 3 files changed, 34 insertions(+)

diff --git a/drivers/cxl/core/regs.c b/drivers/cxl/core/regs.c
index 0efb76658e66..7bfda01ffdb5 100644
--- a/drivers/cxl/core/regs.c
+++ b/drivers/cxl/core/regs.c
@@ -85,6 +85,12 @@ void cxl_probe_component_regs(struct device *dev, void __iomem *base,
 			rmap = &map->hdm_decoder;
 			break;
 		}
+		case CXL_CM_CAP_CAP_ID_RAS:
+			dev_dbg(dev, "found RAS capability (0x%x)\n",
+				offset);
+			length = CXL_RAS_CAPABILITY_LENGTH;
+			rmap = &map->ras;
+			break;
 		default:
 			dev_dbg(dev, "Unknown CM cap ID: %d (0x%x)\n", cap_id,
 				offset);
@@ -201,6 +207,7 @@ int cxl_map_component_regs(struct device *dev, struct cxl_component_regs *regs,
 		void __iomem **addr;
 	} mapinfo[] = {
 		{ &map->component_map.hdm_decoder, &regs->hdm_decoder },
+		{ &map->component_map.ras, &regs->ras },
 	};
 	int i;
 
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index b3fa0c6525af..455ad656166b 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -33,6 +33,7 @@
 #define   CXL_CM_CAP_HDR_ARRAY_SIZE_MASK GENMASK(31, 24)
 #define CXL_CM_CAP_PTR_MASK GENMASK(31, 20)
 
+#define   CXL_CM_CAP_CAP_ID_RAS 0x2
 #define   CXL_CM_CAP_CAP_ID_HDM 0x5
 #define   CXL_CM_CAP_CAP_HDM_VERSION 1
 
@@ -123,6 +124,21 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
 	return 0;
 }
 
+/* RAS Registers CXL 2.0 8.2.5.9 CXL RAS Capability Structure */
+#define CXL_RAS_UNCORRECTABLE_STATUS_OFFSET 0x0
+#define   CXL_RAS_UNCORRECTABLE_STATUS_MASK (GENMASK(16, 14) | GENMASK(11, 0))
+#define CXL_RAS_UNCORRECTABLE_MASK_OFFSET 0x4
+#define   CXL_RAS_UNCORRECTABLE_MASK_MASK (GENMASK(16, 14) | GENMASK(11, 0))
+#define CXL_RAS_UNCORRECTABLE_SEVERITY_OFFSET 0x8
+#define   CXL_RAS_UNCORRECTABLE_SEVERITY_MASK (GENMASK(16, 14) | GENMASK(11, 0))
+#define CXL_RAS_CORRECTABLE_STATUS_OFFSET 0xC
+#define   CXL_RAS_CORRECTABLE_STATUS_MASK GENMASK(6, 0)
+#define CXL_RAS_CORRECTABLE_MASK_OFFSET 0x10
+#define   CXL_RAS_CORRECTABLE_MASK_MASK GENMASK(6, 0)
+#define CXL_RAS_CAP_CONTROL_OFFSET 0x14
+#define CXL_RAS_HEADER_LOG_OFFSET 0x18
+#define CXL_RAS_CAPABILITY_LENGTH 0x58
+
 /* CXL 2.0 8.2.8.1 Device Capabilities Array Register */
 #define CXLDEV_CAP_ARRAY_OFFSET 0x0
 #define   CXLDEV_CAP_ARRAY_CAP_ID 0
@@ -157,9 +173,11 @@ struct cxl_regs {
 	/*
 	 * Common set of CXL Component register block base pointers
 	 * @hdm_decoder: CXL 2.0 8.2.5.12 CXL HDM Decoder Capability Structure
+	 * @ras: CXL 2.0 8.2.5.9 CXL RAS Capability Structure
 	 */
 	struct_group_tagged(cxl_component_regs, component,
 		void __iomem *hdm_decoder;
+		void __iomem *ras;
 	);
 	/*
 	 * Common set of CXL Device register block base pointers
@@ -181,6 +199,7 @@ struct cxl_reg_map {
 
 struct cxl_component_reg_map {
 	struct cxl_reg_map hdm_decoder;
+	struct cxl_reg_map ras;
 };
 
 struct cxl_device_reg_map {
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 8cad9d5fd49a..9428f3e0d99b 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -311,6 +311,9 @@ static int cxl_probe_regs(struct pci_dev *pdev, struct cxl_register_map *map)
 			return -ENXIO;
 		}
 
+		if (!comp_map->ras.valid)
+			dev_dbg(dev, "RAS registers not found\n");
+
 		dev_dbg(dev, "Set up component registers\n");
 		break;
 	case CXL_REGLOC_RBI_MEMDEV:
@@ -449,6 +452,11 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	devm_cxl_pci_create_doe(cxlds);
 
+	rc = cxl_map_component_regs(&pdev->dev, &cxlds->regs.component,
+				    &map, BIT(CXL_CM_CAP_CAP_ID_RAS));
+	if (rc)
+		dev_dbg(&pdev->dev, "Failed to map RAS capability.\n");
+
 	rc = cxl_pci_setup_mailbox(cxlds);
 	if (rc)
 		return rc;


