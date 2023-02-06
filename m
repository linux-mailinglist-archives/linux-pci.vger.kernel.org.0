Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8218D68C806
	for <lists+linux-pci@lfdr.de>; Mon,  6 Feb 2023 21:51:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbjBFUvf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 6 Feb 2023 15:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjBFUve (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 6 Feb 2023 15:51:34 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D8E1DBB8;
        Mon,  6 Feb 2023 12:51:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675716691; x=1707252691;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uQRUC8QEU+C+pD79WhvBKGvAFobEMV5CpOt5lEMC6XE=;
  b=TWv2Ml5pc/B1KK6PJ9q/w0wT+BP/o/v1oYxmM/HxwTexFlQcFzkrTR9S
   Qk4vNihB7ZQq+vOKprUokQDMhIcCcEmNTK8wtahIDMUX74NdPDMO+VfRZ
   1xHzd8w/Oe+m+t/RJ1cqbi5skslKXM0QN/1wl1O87Bs4fdbv37uvM2sLq
   dVTNXYRfikoue7fc8pW09wkdEF9lLhrHY57ec1WrCJufNiTl6teY3GXoZ
   gPgpyDzyAh6lKMDL1Zm/gGUeqzb/74L+X7lPAAqJ5WDzvnTQsvjMhk0bk
   gABLIlx8a6W3fWDmDdp/7KQFczMkpogkD5rvn1LiztuE1nk+jPZ/dONaJ
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="308958787"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="308958787"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:30 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10613"; a="735280218"
X-IronPort-AV: E=Sophos;i="5.97,276,1669104000"; 
   d="scan'208";a="735280218"
Received: from djiang5-mobl3.amr.corp.intel.com (HELO djiang5-mobl3.local) ([10.212.111.195])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2023 12:51:30 -0800
Subject: [PATCH 14/18] cxl: Wait Memory_Info_Valid before access memory
 related info
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-acpi@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        rafael@kernel.org, bhelgaas@google.com, robert.moore@intel.com
Date:   Mon, 06 Feb 2023 13:51:28 -0700
Message-ID: <167571668726.587790.16814881883553586342.stgit@djiang5-mobl3.local>
In-Reply-To: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
References: <167571650007.587790.10040913293130712882.stgit@djiang5-mobl3.local>
User-Agent: StGit/1.5
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

CXL rev3.0 8.1.3.8.2 Memory_Info_valid field

The Memory_Info_Valid bit indicates that the CXL Range Size High and Size
Low registers are valid. The bit must be set within 1 second of reset
deassertion to the device. Check valid bit before we check the
Memory_Active bit when waiting for cxl_await_media_ready() to ensure that
the memory info is valid for consumption.

Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/pci.c |   25 +++++++++++++++++++++++--
 drivers/cxl/port.c     |   20 ++++++++++----------
 2 files changed, 33 insertions(+), 12 deletions(-)

diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
index 54ac6f8825ff..79a1348e7b98 100644
--- a/drivers/cxl/core/pci.c
+++ b/drivers/cxl/core/pci.c
@@ -111,11 +111,32 @@ int cxl_await_media_ready(struct cxl_dev_state *cxlds)
 	int d = cxlds->cxl_dvsec;
 	bool active = false;
 	u64 md_status;
+	u32 temp;
 	int rc, i;
 
-	for (i = media_ready_timeout; i; i--) {
-		u32 temp;
+	/* Check MEM INFO VALID bit first, give up after 1s */
+	i = 1;
+	do {
+		rc = pci_read_config_dword(pdev,
+					   d + CXL_DVSEC_RANGE_SIZE_LOW(0),
+					   &temp);
+		if (rc)
+			return rc;
 
+		active = FIELD_GET(CXL_DVSEC_MEM_INFO_VALID, temp);
+		if (active)
+			break;
+		msleep(1000);
+	} while (i--);
+
+	if (!active) {
+		dev_err(&pdev->dev,
+			"timeout awaiting memory valid after 1 second.\n");
+		return -ETIMEDOUT;
+	}
+
+	/* Check MEM ACTIVE bit, up to 60s timeout by default */
+	for (i = media_ready_timeout; i; i--) {
 		rc = pci_read_config_dword(
 			pdev, d + CXL_DVSEC_RANGE_SIZE_LOW(0), &temp);
 		if (rc)
diff --git a/drivers/cxl/port.c b/drivers/cxl/port.c
index d72e38f9ae44..03380c18fc52 100644
--- a/drivers/cxl/port.c
+++ b/drivers/cxl/port.c
@@ -99,6 +99,16 @@ static int cxl_port_probe(struct device *dev)
 		if (rc)
 			return rc;
 
+		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
+		if (rc)
+			return rc;
+
+		rc = cxl_await_media_ready(cxlds);
+		if (rc) {
+			dev_err(dev, "Media not active (%d)\n", rc);
+			return rc;
+		}
+
 		if (port->cdat.table) {
 			rc = cdat_table_parse_dsmas(port->cdat.table,
 						    cxl_dsmas_parse_entry,
@@ -117,16 +127,6 @@ static int cxl_port_probe(struct device *dev)
 			if (rc)
 				dev_dbg(dev, "Failed to do QoS calculations\n");
 		}
-
-		rc = cxl_hdm_decode_init(cxlds, cxlhdm);
-		if (rc)
-			return rc;
-
-		rc = cxl_await_media_ready(cxlds);
-		if (rc) {
-			dev_err(dev, "Media not active (%d)\n", rc);
-			return rc;
-		}
 	}
 
 	rc = devm_cxl_enumerate_decoders(cxlhdm);


