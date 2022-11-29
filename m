Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAB5863C6D9
	for <lists+linux-pci@lfdr.de>; Tue, 29 Nov 2022 18:54:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236550AbiK2Ryc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Nov 2022 12:54:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236460AbiK2Ryb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 29 Nov 2022 12:54:31 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F827140;
        Tue, 29 Nov 2022 09:54:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1669744470; x=1701280470;
  h=subject:from:to:cc:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iFT0jjASPi5WJ/CkaGxuySi8Y4bfpndhLasXp0NOdRE=;
  b=ml7wfXXG2kWqFHDrLWeN276Gc9YQPqYId9wwdopOr6NzrwLSp1PwCb0t
   Brq1xMs2Zen09tTW7cLpkVc0K+/Osre2bDrwrY/MQTqU2t2zgicAE7K8J
   SiHl7ISxAvinkrNmTgA2GvtyY/M85Kq77i3aOxwdWaIM85Kez2oGvqrpG
   Y246uHb+5itOoPWU3nvoVpw4nJnf6N4rfOrjdW0e4WRH3MlhdZ338LYO5
   FF+P1CSnC/V8uQEpjFPTBrxqBRxZaBd9ZgDXJzgcCeWnnvi3/KnHL3Pup
   ftqtsWBg/SjQ0bOgqXQhSQWOq5zAZZVnK6G23XEwZGILQQ2+PwkgGPMJN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="317038184"
X-IronPort-AV: E=Sophos;i="5.96,204,1665471600"; 
   d="scan'208";a="317038184"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:49:00 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10546"; a="749957238"
X-IronPort-AV: E=Sophos;i="5.96,203,1665471600"; 
   d="scan'208";a="749957238"
Received: from djiang5-desk3.ch.intel.com ([143.182.136.137])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2022 09:49:00 -0800
Subject: [PATCH v4 09/11] cxl/pci: Add (hopeful) error handling support
From:   Dave Jiang <dave.jiang@intel.com>
To:     linux-cxl@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     dan.j.williams@intel.com, ira.weiny@intel.com,
        vishal.l.verma@intel.com, alison.schofield@intel.com,
        Jonathan.Cameron@huawei.com, rostedt@goodmis.org,
        terry.bowman@amd.com, bhelgaas@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, shiju.jose@huawei.com
Date:   Tue, 29 Nov 2022 10:48:59 -0700
Message-ID: <166974413966.1608150.15522782911404473932.stgit@djiang5-desk3.ch.intel.com>
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

Add nominal error handling that tears down CXL.mem in response to error
notifications that imply a device reset. Given some CXL.mem may be
operating as System RAM, there is a high likelihood that these error
events are fatal. However, if the system survives the notification the
expectation is that the driver behavior is equivalent to a hot-unplug
and re-plug of an endpoint.

Note that this does not change the mask values from the default. That
awaits CXL _OSC support to determine whether platform firmware is in
control of the mask registers.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Dave Jiang <dave.jiang@intel.com>
---
 drivers/cxl/core/memdev.c |    1 
 drivers/cxl/cxl.h         |    1 
 drivers/cxl/cxlmem.h      |    2 +
 drivers/cxl/pci.c         |  137 +++++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 141 insertions(+)

diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
index 20ce488a7754..a74a93310d26 100644
--- a/drivers/cxl/core/memdev.c
+++ b/drivers/cxl/core/memdev.c
@@ -344,6 +344,7 @@ struct cxl_memdev *devm_cxl_add_memdev(struct cxl_dev_state *cxlds)
 	 * needed as this is ordered with cdev_add() publishing the device.
 	 */
 	cxlmd->cxlds = cxlds;
+	cxlds->cxlmd = cxlmd;
 
 	cdev = &cxlmd->cdev;
 	rc = cdev_device_add(cdev, dev);
diff --git a/drivers/cxl/cxl.h b/drivers/cxl/cxl.h
index 455ad656166b..8ac9ce02a97c 100644
--- a/drivers/cxl/cxl.h
+++ b/drivers/cxl/cxl.h
@@ -136,6 +136,7 @@ static inline int ways_to_cxl(unsigned int ways, u8 *iw)
 #define CXL_RAS_CORRECTABLE_MASK_OFFSET 0x10
 #define   CXL_RAS_CORRECTABLE_MASK_MASK GENMASK(6, 0)
 #define CXL_RAS_CAP_CONTROL_OFFSET 0x14
+#define CXL_RAS_CAP_CONTROL_FE_MASK GENMASK(5, 0)
 #define CXL_RAS_HEADER_LOG_OFFSET 0x18
 #define CXL_RAS_CAPABILITY_LENGTH 0x58
 
diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
index 88e3a8e54b6a..b3117fd67f42 100644
--- a/drivers/cxl/cxlmem.h
+++ b/drivers/cxl/cxlmem.h
@@ -186,6 +186,7 @@ struct cxl_endpoint_dvsec_info {
  * Currently only memory devices are represented.
  *
  * @dev: The device associated with this CXL state
+ * @cxlmd: The device representing the CXL.mem capabilities of @dev
  * @regs: Parsed register blocks
  * @cxl_dvsec: Offset to the PCIe device DVSEC
  * @payload_size: Size of space for payload
@@ -218,6 +219,7 @@ struct cxl_endpoint_dvsec_info {
  */
 struct cxl_dev_state {
 	struct device *dev;
+	struct cxl_memdev *cxlmd;
 
 	struct cxl_regs regs;
 	int cxl_dvsec;
diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
index 0f36a5861a7b..11f842df9807 100644
--- a/drivers/cxl/pci.c
+++ b/drivers/cxl/pci.c
@@ -9,6 +9,7 @@
 #include <linux/list.h>
 #include <linux/pci.h>
 #include <linux/pci-doe.h>
+#include <linux/aer.h>
 #include <linux/io.h>
 #include "cxlmem.h"
 #include "cxlpci.h"
@@ -404,6 +405,11 @@ static void devm_cxl_pci_create_doe(struct cxl_dev_state *cxlds)
 	}
 }
 
+static void disable_aer(void *pdev)
+{
+	pci_disable_pcie_error_reporting(pdev);
+}
+
 static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	struct cxl_register_map map;
@@ -425,6 +431,7 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	cxlds = cxl_dev_state_create(&pdev->dev);
 	if (IS_ERR(cxlds))
 		return PTR_ERR(cxlds);
+	pci_set_drvdata(pdev, cxlds);
 
 	cxlds->serial = pci_get_dsn(pdev);
 	cxlds->cxl_dvsec = pci_find_dvsec_capability(
@@ -479,6 +486,14 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
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
 	if (resource_size(&cxlds->pmem_res) && IS_ENABLED(CONFIG_CXL_PMEM))
 		rc = devm_cxl_add_nvdimm(&pdev->dev, cxlmd);
 
@@ -492,10 +507,132 @@ static const struct pci_device_id cxl_mem_pci_tbl[] = {
 };
 MODULE_DEVICE_TABLE(pci, cxl_mem_pci_tbl);
 
+/* CXL spec rev3.0 8.2.4.16.1 */
+static void header_log_copy(struct cxl_dev_state *cxlds, u32 *log)
+{
+	void __iomem *addr;
+	u32 *log_addr;
+	int i, log_u32_size = CXL_HEADERLOG_SIZE / sizeof(u32);
+
+	addr = cxlds->regs.ras + CXL_RAS_HEADER_LOG_OFFSET;
+	log_addr = log;
+
+	for (i = 0; i < log_u32_size; i++) {
+		*log_addr = readl(addr);
+		log_addr++;
+		addr += sizeof(u32);
+	}
+}
+
+/*
+ * Log the state of the RAS status registers and prepare them to log the
+ * next error status. Return 1 if reset needed.
+ */
+static bool cxl_report_and_clear(struct cxl_dev_state *cxlds)
+{
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+	u32 hl[CXL_HEADERLOG_SIZE_U32];
+	void __iomem *addr;
+	u32 status;
+	u32 fe;
+
+	if (!cxlds->regs.ras)
+		return false;
+
+	addr = cxlds->regs.ras + CXL_RAS_UNCORRECTABLE_STATUS_OFFSET;
+	status = le32_to_cpu((__force __le32)readl(addr));
+	if (!(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK))
+		return false;
+
+	/* If multiple errors, log header points to first error from ctrl reg */
+	if (hweight32(status) > 1) {
+		addr = cxlds->regs.ras + CXL_RAS_CAP_CONTROL_OFFSET;
+		fe = BIT(le32_to_cpu((__force __le32)readl(addr)) &
+				     CXL_RAS_CAP_CONTROL_FE_MASK);
+	} else {
+		fe = status;
+	}
+
+	header_log_copy(cxlds, hl);
+	trace_cxl_aer_uncorrectable_error(dev_name(dev), status, fe, hl);
+	writel(status & CXL_RAS_UNCORRECTABLE_STATUS_MASK, addr);
+
+	return true;
+}
+
+static pci_ers_result_t cxl_error_detected(struct pci_dev *pdev,
+					   pci_channel_state_t state)
+{
+	struct cxl_dev_state *cxlds = pci_get_drvdata(pdev);
+	struct cxl_memdev *cxlmd = cxlds->cxlmd;
+	struct device *dev = &cxlmd->dev;
+	bool ue;
+
+	/*
+	 * A frozen channel indicates an impending reset which is fatal to
+	 * CXL.mem operation, and will likely crash the system. On the off
+	 * chance the situation is recoverable dump the status of the RAS
+	 * capability registers and bounce the active state of the memdev.
+	 */
+	ue = cxl_report_and_clear(cxlds);
+
+	switch (state) {
+	case pci_channel_io_normal:
+		if (ue) {
+			device_release_driver(dev);
+			return PCI_ERS_RESULT_NEED_RESET;
+		}
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


