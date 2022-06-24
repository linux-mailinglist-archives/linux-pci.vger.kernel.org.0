Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4150C558FA5
	for <lists+linux-pci@lfdr.de>; Fri, 24 Jun 2022 06:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbiFXEU3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 24 Jun 2022 00:20:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiFXEUS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 24 Jun 2022 00:20:18 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0CA54F99;
        Thu, 23 Jun 2022 21:20:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656044416; x=1687580416;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YRGxWHwlR2WZVbAJ2E0KYhXzmo8P1xJMN8Lfvbu4eD0=;
  b=mbasr8c9w9GJioPCd1GSSQFqsHOE9jYWs7uvKOoVrCw8WvSXQkamHfTJ
   5vrIZQjSAw3W/vVa2n4wswXw/wcMUcWtuBn3jM/LTg069jTAdzyOJletB
   ZrVohCr6nXC26iAtTWAn9QVuGgBC2PmAMACk4Ia5Zc/a/tTdcIPVmkayV
   swVoIozL5srWJTTv8H04iECA2tyA5x2mVPRRUx13/6g6abuSVP1PGR4yL
   +B8Z9iIQU+WZKUl42ILfa9kfXl7NCNe+tbR+QScQuzLtvAibqoedVQdjI
   Kg/TekvbhWGw/0mgMW26W5O3gor116+sjrlWqtVz2hywH7fAyDB/0x3iY
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10387"; a="367238055"
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="367238055"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:15 -0700
X-IronPort-AV: E=Sophos;i="5.92,218,1650956400"; 
   d="scan'208";a="645092962"
Received: from daharell-mobl2.amr.corp.intel.com (HELO dwillia2-xfh.intel.com) ([10.209.66.176])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 21:20:15 -0700
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     nvdimm@lists.linux.dev, linux-pci@vger.kernel.org,
        patches@lists.linux.dev, hch@lst.de,
        Dan Williams <dan.j.williams@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>
Subject: [PATCH 43/46] cxl/region: Add region driver boiler plate
Date:   Thu, 23 Jun 2022 21:19:47 -0700
Message-Id: <20220624041950.559155-18-dan.j.williams@intel.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
References: <165603869943.551046.3498980330327696732.stgit@dwillia2-xfh>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The CXL region driver is responsible for routing fully formed CXL
regions to one of libnvdimm, for persistent memory regions, device-dax
for volatile memory regions, or just act as an enumeration placeholder
if the region was setup and configuration locked by platform firmware.
In the platform-firmware-setup case the expectation is that region is
already accounted in the system memory map, i.e. already enabled as
"System RAM".

For now, just attach to CXL regions in the CXL_CONFIG_COMMIT state, and
take no further action.

Given this driver is just a small / simple router, include it in the
core rather than its own module.

Co-developed-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Ben Widawsky <bwidawsk@kernel.org>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/core.h   | 12 +++++++++++
 drivers/cxl/core/port.c   |  9 ++++++++
 drivers/cxl/core/region.c | 45 ++++++++++++++++++++++++++++++++++++++-
 drivers/cxl/cxl.h         |  1 +
 4 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/cxl/core/core.h b/drivers/cxl/core/core.h
index 6f5c4fb85879..be5198ab8f3b 100644
--- a/drivers/cxl/core/core.h
+++ b/drivers/cxl/core/core.h
@@ -13,17 +13,29 @@ extern struct attribute_group cxl_base_attribute_group;
 extern struct device_attribute dev_attr_create_pmem_region;
 extern struct device_attribute dev_attr_delete_region;
 extern struct device_attribute dev_attr_region;
+extern const struct device_type cxl_region_type;
 void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled);
+int cxl_region_init(void);
+void cxl_region_exit(void);
 /*
  * Note must be used at the end of an attribute list, since it
  * terminates the list in the CONFIG_CXL_REGION=n case.
  */
 #define CXL_REGION_ATTR(x) (&dev_attr_##x.attr)
+#define CXL_REGION_TYPE(x) (&cxl_region_type)
 #else
 static inline void cxl_decoder_kill_region(struct cxl_endpoint_decoder *cxled)
 {
 }
+static inline int cxl_region_init(void)
+{
+	return 0;
+}
+static inline void cxl_region_exit(void)
+{
+}
 #define CXL_REGION_ATTR(x) NULL
+#define CXL_REGION_TYPE(x) NULL
 #endif
 
 struct cxl_send_command;
diff --git a/drivers/cxl/core/port.c b/drivers/cxl/core/port.c
index eee1615d2319..00add9e0b192 100644
--- a/drivers/cxl/core/port.c
+++ b/drivers/cxl/core/port.c
@@ -51,6 +51,8 @@ static int cxl_device_id(struct device *dev)
 	}
 	if (is_cxl_memdev(dev))
 		return CXL_DEVICE_MEMORY_EXPANDER;
+	if (dev->type == CXL_REGION_TYPE())
+		return CXL_DEVICE_REGION;
 	return 0;
 }
 
@@ -1867,8 +1869,14 @@ static __init int cxl_core_init(void)
 	if (rc)
 		goto err_bus;
 
+	rc = cxl_region_init();
+	if (rc)
+		goto err_region;
+
 	return 0;
 
+err_region:
+	bus_unregister(&cxl_bus_type);
 err_bus:
 	destroy_workqueue(cxl_bus_wq);
 err_wq:
@@ -1878,6 +1886,7 @@ static __init int cxl_core_init(void)
 
 static void cxl_core_exit(void)
 {
+	cxl_region_exit();
 	bus_unregister(&cxl_bus_type);
 	destroy_workqueue(cxl_bus_wq);
 	cxl_memdev_exit();
diff --git a/drivers/cxl/core/region.c b/drivers/cxl/core/region.c
index b90160c4f975..cd1848d4c8fe 100644
--- a/drivers/cxl/core/region.c
+++ b/drivers/cxl/core/region.c
@@ -1416,7 +1416,7 @@ static void cxl_region_release(struct device *dev)
 	kfree(cxlr);
 }
 
-static const struct device_type cxl_region_type = {
+const struct device_type cxl_region_type = {
 	.name = "cxl_region",
 	.release = cxl_region_release,
 	.groups = region_groups
@@ -1614,4 +1614,47 @@ static ssize_t delete_region_store(struct device *dev,
 }
 DEVICE_ATTR_WO(delete_region);
 
+static int cxl_region_probe(struct device *dev)
+{
+	struct cxl_region *cxlr = to_cxl_region(dev);
+	struct cxl_region_params *p = &cxlr->params;
+	int rc;
+
+	rc = down_read_interruptible(&cxl_region_rwsem);
+	if (rc) {
+		dev_dbg(&cxlr->dev, "probe interrupted\n");
+		return rc;
+	}
+
+	if (p->state < CXL_CONFIG_COMMIT) {
+		dev_dbg(&cxlr->dev, "config state: %d\n", p->state);
+		rc = -ENXIO;
+	}
+
+	/*
+	 * From this point on any path that changes the region's state away from
+	 * CXL_CONFIG_COMMIT is also responsible for releasing the driver.
+	 */
+	up_read(&cxl_region_rwsem);
+
+	return rc;
+}
+
+static struct cxl_driver cxl_region_driver = {
+	.name = "cxl_region",
+	.probe = cxl_region_probe,
+	.id = CXL_DEVICE_REGION,
+};
+
+int cxl_region_init(void)
+{
+	return cxl_driver_register(&cxl_region_driver);
+}
+
+void cxl_region_exit(void)
+{
+	cxl_driver_unregister(&cxl_region_driver);
+}
+
 MODULE_IMPORT_NS(CXL);
+MODULE_ALIAS_CXL(CXL_DEVICE_REGION);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index fc14f6805f2c..734b4479feb2 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -586,6 +586,7 @@ void cxl_driver_unregister(struct cxl_driver *cxl_drv);
 #define CXL_DEVICE_PORT			3
 #define CXL_DEVICE_ROOT			4
 #define CXL_DEVICE_MEMORY_EXPANDER	5
+#define CXL_DEVICE_REGION		6
 
 #define MODULE_ALIAS_CXL(type) MODULE_ALIAS("cxl:t" __stringify(type) "*")
 #define CXL_MODALIAS_FMT "cxl:t%d"
-- 
2.36.1

