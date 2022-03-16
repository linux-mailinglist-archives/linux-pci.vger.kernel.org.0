Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E1E64DA937
	for <lists+linux-pci@lfdr.de>; Wed, 16 Mar 2022 05:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353501AbiCPEPk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Mar 2022 00:15:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353508AbiCPEPj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Mar 2022 00:15:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A35BB4B1D5;
        Tue, 15 Mar 2022 21:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647404065; x=1678940065;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XFiGcPS1f/T7+aDldvpmz0ApwwO2zws4MBb9vsb4Vi0=;
  b=cuqReaVvVMd1KCZLBxdCTUGW7ZgTySYn72pqcA9cem4/ENTa+ViqPBF8
   xTtOMR8wRO43UxAfznndVub4rbedjRTlwRXPOCDV4HMFshmDDcz03Be06
   b+glgDUsQPUw+bTzrfSF40kZyFa0Yntgp1sVuYAqBFgDpdIMw+Zq6Avcd
   n6N5u30hRGVuFad0WFADtlrUudhAQQlMwsG4Lzf5wXyzULVAn/EpKPyn/
   Rv05l0Ks06CiuqAM86psJWGxWZY2UncE1S/OAq4V3xBoaM+oyBE84l7Tq
   eh4uDF4W53EbNvHmxmiQbD+LwENwINwNAiiPr1RMQiQN6EJbbwHLyHbcW
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256678782"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="256678782"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:14:25 -0700
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="540739866"
Received: from dwillia2-desk3.jf.intel.com (HELO dwillia2-desk3.amr.corp.intel.com) ([10.54.39.25])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 21:14:24 -0700
Subject: [PATCH 8/8] cxl/pci: Add (hopeful) error handling support
From:   Dan Williams <dan.j.williams@intel.com>
To:     linux-cxl@vger.kernel.org
Cc:     ben.widawsky@intel.com, vishal.l.verma@intel.com,
        alison.schofield@intel.com, Jonathan.Cameron@huawei.com,
        ira.weiny@intel.com, linux-pci@vger.kernel.org
Date:   Tue, 15 Mar 2022 21:14:24 -0700
Message-ID: <164740406489.3912056.8334546166826246693.stgit@dwillia2-desk3.amr.corp.intel.com>
In-Reply-To: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
References: <164740402242.3912056.8303625392871313860.stgit@dwillia2-desk3.amr.corp.intel.com>
User-Agent: StGit/0.18-3-g996c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add nominal error handling that tears down CXL.mem in response to error
notifications that imply a device reset. Given some CXL.mem may be
operating as System RAM, there is a high likelihood that these error
events are fatal. However, if the system survives the notification the
expectation is that the driver behavior is equivalent to a hot-unplug
and re-plug of an endpoint.

Note that this does not change the mask values from the default. That
awaits CXL _OSC support to determine whether platform firmware is in
control of the mask registers.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---
 drivers/cxl/core/memdev.c |    1 
 drivers/cxl/cxlmem.h      |    2 +
 drivers/cxl/pci.c         |  109 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 112 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 1f76b28f9826..223d512790e1 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -341,6 +341,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	 * needed as this is ordered with cdev_add() publishing the device.
 	 */
 	cxlmd->cxlds = cxlds;
+	cxlds->cxlmd = cxlmd;
 
 	cdev = &cxlmd->cdev;
 	rc = cdev_device_add(cdev, dev);
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 5d33ce24fe09..f58e16951414 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -117,6 +117,7 @@ struct cxl_endpoint_dvsec_info {
  * Currently only memory devices are represented.
  *
  * @dev: The device associated with this CXL state
+ * @cxlmd: The device representing the CXL.mem capabilities of @dev
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @payload_size: Size of space for payload
@@ -148,6 +149,7 @@ struct cxl_endpoint_dvsec_info {
  */
 struct cxl_dev_state {
 	struct device *dev;
+	struct cxl_memdev *cxlmd;
 
 	struct cxl_regs regs;
 	int cxl_dvsec;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index bde8929450f0..823cbfa093fa 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -8,6 +8,7 @@
 #include <linux/mutex.h>
 #include <linux/list.h>
 #include <linux/pci.h>
+#include <linux/aer.h>
 #include <linux/io.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
@@ -533,6 +534,11 @@ static void cxl_dvsec_ranges(struct cxl_dev_state *cxlds)
 	info->ranges = __cxl_dvsec_ranges(cxlds, info);
 }
 
+static void disable_aer(void *pdev)
+{
+	pci_disable_pcie_error_reporting(pdev);
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -554,6 +560,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	cxlds = cxl_dev_state_create(&pdev->dev);
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
+	pci_set_drvdata(pdev, cxlds);
 
 	cxlds->serial = pci_get_dsn(pdev);
 	cxlds->cxl_dvsec = pci_find_dvsec_capability(
@@ -610,6 +617,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (IS_ERR(cxlmd))
 		return PTR_ERR(cxlmd);
 
+	if (cxlds->regs.ras) {
+		pci_enable_pcie_error_reporting(pdev);
+		rc = devm_add_action_or_reset(&pdev->dev, disable_aer, pdev);
+		if (rc)
+			return rc;
+	}
+	pci_save_state(pdev);
+
 	if (range_len(&cxlds->pmem_range) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
 
@@ -623,10 +638,104 @@ static const struct pci_device_id cxl_mem_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
 
+/*
+ * Log the state of the RAS status registers and prepare them to log the
+ * next error status.
+ */
+static void cxl_report_and_clear(struct cxl_dev_state *cxlds)
+{
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+	void __iomem *addr;
+	u32 status;
+
+	if (!cxlds->regs.ras)
+		return;
+
+	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
+	status = readl(addr);
+	if (status & CXL_RAS_UNCORRECTABLE_STATUS_MASK) {
+		dev_warn(cxlds->dev, "%s: uncorrectable status: %#08x\n",
+			 dev_name(dev), status);
+		writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
+	}
+
+	addr = cxlds->regs.ras + CXL_RAS_CORRECTABLE_STATUS_OFFSET;
+	status = readl(addr);
+	if (status & CXL_RAS_CORRECTABLE_STATUS_MASK) {
+		dev_warn(cxlds->dev, "%s: correctable status: %#08x\n",
+			 dev_name(dev), status);
+		writel(status & CXL_RAS_CORRECTABLE_STATUS_MASK, addr);
+	}
+}
+
+static pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
+					   pci_channel_state_t state)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+
+	/*
+	 * A frozen channel indicates an impending reset which is fatal to
+	 * CXL.mem operation, and will likely crash the system. On the off
+	 * chance the situation is recoverable dump the status of the RAS
+	 * capability registers and bounce the active state of the memdev.
+	 */
+	cxl_report_and_clear(cxlds);
+
+	switch (state) {
+	case pci_channel_io_normal:
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	case pci_channel_io_frozen:
+		dev_warn(&pdev->dev,
+			 "%s: frozen state error detected, disable CXL.mem\n",
+			 dev_name(dev));
+		device_release_driver(dev);
+		return PCI_ERS_RESULT_NEED_RESET;
+	case pci_channel_io_perm_failure:
+		dev_warn(&pdev->dev,
+			 "failure state error detected, request disconnect\n");
+		return PCI_ERS_RESULT_DISCONNECT;
+	}
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+
+static pci_ers_result_t cxl_slot_reset(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+
+	dev_info(&pdev->dev, "%s: restart CXL.mem after slot reset\n",
+		 dev_name(dev));
+	pci_restore_state(pdev);
+	if (device_attach(dev) <= 0)
+		return PCI_ERS_RESULT_DISCONNECT;
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void cxl_error_resume(struct pci_dev *pdev)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+
+	dev_info(&pdev->dev, "%s: error resume %s\n", dev_name(dev),
+		 dev->driver ? "successful" : "failed");
+}
+
+static const struct pci_error_handlers cxl_error_handlers = {
+	.error_detected	= cxl_error_detected,
+	.slot_reset	= cxl_slot_reset,
+	.resume		= cxl_error_resume,
+};
+
 static struct pci_driver cxl_pci_driver = {
 	.name			= KBUILD_MODNAME,
 	.id_table		= cxl_mem_pci_tbl,
 	.probe			= cxl_pci_probe,
+	.err_handler		= &cxl_error_handlers,
 	.driver	= {
 		.probe_type	= PROBE_PREFER_ASYNCHRONOUS,
 	},

