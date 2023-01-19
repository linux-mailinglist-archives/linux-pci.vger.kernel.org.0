Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1035B672E49
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229968AbjASBek (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjASBaj (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:39 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A84B37F20;
        Wed, 18 Jan 2023 17:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091730; x=1705627730;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=92WpI/CMYfwGiXcsjcP/NI5y3TpYtmkZChXGGpFRbp8=;
  b=NZ6hYGX/bDPHMCNa6Y0TYUPAH9sltl7RFp1xTiX3yfeST5hNmphUh/PJ
   ScqsRoK6AHXMHPHaxSqZyzC/DOTzt+4Brcefp7CpT3Lh8qrk9qe74F6K5
   7+ImcGqQtCs1Ul70BAzSHhjKiyo0JoTDXuGnn9C9x25cKPd5nXOj0gN8w
   MqdliTxHmktLVtEqdcfnUPWPpwQ9dva61fLFuFDiNwmFj5VRtAkae84D1
   vUtj+DbEPNIBoFkAPYjo4OAFkjAIYeSR5E9wgKmpabzjDUspjhSlmNDat
   jFoMfJmPbKW3sjshoBS7kPSJn2+av4tmno3Q/algaoA5DX+Ms1gJhfoTt
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847566"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847566"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:28:49 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995682"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995682"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:28:44 -0800
From:   Tianfei Zhang <tianfei.zhang@intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-fpga@vger.kernel.org, lukas@wunner.de, kabel@kernel.org,
        mani@kernel.org, pali@kernel.org, mdf@kernel.org, hao.wu@intel.com,
        yilun.xu@intel.com, trix@redhat.com, jgg@ziepe.ca,
        ira.weiny@intel.com, andriy.shevchenko@linux.intel.com,
        dan.j.williams@intel.com, keescook@chromium.org, rafael@kernel.org,
        russell.h.weight@intel.com, corbet@lwn.net,
        linux-doc@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
        lee@kernel.org, gregkh@linuxfoundation.org,
        matthew.gerlach@linux.intel.com
Cc:     Tianfei Zhang <tianfei.zhang@intel.com>
Subject: [PATCH v1 08/12] fpga: m10bmc-sec: register BMC device into fpgahp driver
Date:   Wed, 18 Jan 2023 20:35:58 -0500
Message-Id: <20230119013602.607466-9-tianfei.zhang@intel.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20230119013602.607466-1-tianfei.zhang@intel.com>
References: <20230119013602.607466-1-tianfei.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add a registration of Intel M10 BMC security update device
into fpgahp driver by fpgahp_bmc_device_register() API.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/Kconfig                    |   1 +
 drivers/fpga/intel-m10-bmc-sec-update.c | 110 ++++++++++++++++++++++++
 2 files changed, 111 insertions(+)

diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
index 2188c5658e06..f83682d00a1b 100644
--- a/drivers/fpga/Kconfig
+++ b/drivers/fpga/Kconfig
@@ -248,6 +248,7 @@ config FPGA_MGR_VERSAL_FPGA
 config FPGA_M10_BMC_SEC_UPDATE
 	tristate "Intel MAX10 BMC Secure Update driver"
 	depends on MFD_INTEL_M10_BMC
+	depends on HOTPLUG_PCI_FPGA
 	select FW_LOADER
 	select FW_UPLOAD
 	help
diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 79d48852825e..647531094b3b 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -8,6 +8,7 @@
 #include <linux/bitfield.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/fpga/fpgahp_manager.h>
 #include <linux/mfd/intel-m10-bmc.h>
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
@@ -19,10 +20,21 @@ struct m10bmc_sec {
 	struct intel_m10bmc *m10bmc;
 	struct fw_upload *fwl;
 	char *fw_name;
+	struct image_load *image_load;
+	struct fpgahp_bmc_device *fpgahp_bmc;
 	u32 fw_name_id;
 	bool cancel_request;
 };
 
+struct image_load {
+	const char *name;
+	int (*load_image)(struct m10bmc_sec *sec);
+	u32 wait_time_msec;
+};
+
+/* default wait 10 seconds for FPGA/BMC image reload */
+#define RELOAD_DEFAULT_WAIT_MSECS  (10 * MSEC_PER_SEC)
+
 static DEFINE_XARRAY_ALLOC(fw_upload_xa);
 
 /* Root Entry Hash (REH) support */
@@ -137,6 +149,43 @@ DEVICE_ATTR_SEC_CSK_RO(pr, PR_PROG_ADDR + CSK_VEC_OFFSET);
 
 #define FLASH_COUNT_SIZE 4096	/* count stored as inverted bit vector */
 
+static ssize_t m10bmc_available_images(struct fpgahp_bmc_device *bmc, char *buf)
+{
+	struct m10bmc_sec *sec = bmc->priv;
+	const struct image_load *hndlr;
+	ssize_t count = 0;
+
+	for (hndlr = sec->image_load; hndlr->name; hndlr++)
+		count += scnprintf(buf + count, PAGE_SIZE - count, "%s ", hndlr->name);
+
+	buf[count - 1] = '\n';
+
+	return count;
+}
+
+static int m10bmc_image_trigger(struct fpgahp_bmc_device *bmc, const char *buf,
+				u32 *wait_time_msec)
+{
+	struct m10bmc_sec *sec = bmc->priv;
+	const struct image_load *hndlr;
+	int ret = -EINVAL;
+
+	for (hndlr = sec->image_load; hndlr->name; hndlr++) {
+		if (sysfs_streq(buf, hndlr->name)) {
+			ret = hndlr->load_image(sec);
+			*wait_time_msec = hndlr->wait_time_msec;
+			break;
+		}
+	}
+
+	return ret;
+}
+
+static const struct fpgahp_bmc_ops fpgahp_bmc_ops = {
+	.image_trigger = m10bmc_image_trigger,
+	.available_images = m10bmc_available_images,
+};
+
 static ssize_t flash_count_show(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
@@ -208,6 +257,54 @@ static void log_error_regs(struct m10bmc_sec *sec, u32 doorbell)
 		dev_err(sec->dev, "RSU auth result: 0x%08x\n", auth_result);
 }
 
+static int m10bmc_sec_bmc_image_load(struct m10bmc_sec *sec,
+				     unsigned int val)
+{
+	u32 doorbell;
+	int ret;
+
+	if (val > 1) {
+		dev_err(sec->dev, "invalid reload val = %u\n", val);
+		return -EINVAL;
+	}
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return ret;
+
+	if (doorbell & DRBL_REBOOT_DISABLED)
+		return -EBUSY;
+
+	return regmap_update_bits(sec->m10bmc->regmap,
+				  M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				  DRBL_CONFIG_SEL | DRBL_REBOOT_REQ,
+				  FIELD_PREP(DRBL_CONFIG_SEL, val) | DRBL_REBOOT_REQ);
+}
+
+static int m10bmc_sec_bmc_image_load_0(struct m10bmc_sec *sec)
+{
+	return m10bmc_sec_bmc_image_load(sec, 0);
+}
+
+static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec)
+{
+	return m10bmc_sec_bmc_image_load(sec, 1);
+}
+
+static struct image_load m10bmc_image_load_hndlrs[] = {
+	{
+		.name = "bmc_factory",
+		.load_image = m10bmc_sec_bmc_image_load_1,
+		.wait_time_msec = RELOAD_DEFAULT_WAIT_MSECS,
+	},
+	{
+		.name = "bmc_user",
+		.load_image = m10bmc_sec_bmc_image_load_0,
+		.wait_time_msec = RELOAD_DEFAULT_WAIT_MSECS,
+	},
+	{}
+};
+
 static enum fw_upload_err rsu_check_idle(struct m10bmc_sec *sec)
 {
 	u32 doorbell;
@@ -565,6 +662,7 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
 	sec->dev = &pdev->dev;
 	sec->m10bmc = dev_get_drvdata(pdev->dev.parent);
 	dev_set_drvdata(&pdev->dev, sec);
+	sec->image_load = m10bmc_image_load_hndlrs;
 
 	ret = xa_alloc(&fw_upload_xa, &sec->fw_name_id, sec,
 		       xa_limit_32b, GFP_KERNEL);
@@ -587,6 +685,16 @@ static int m10bmc_sec_probe(struct platform_device *pdev)
 	}
 
 	sec->fwl = fwl;
+
+	sec->fpgahp_bmc = fpgahp_bmc_device_register(&fpgahp_bmc_ops, sec->dev, sec);
+	if (IS_ERR(sec->fpgahp_bmc)) {
+		dev_err(sec->dev, "register hotplug bmc failed\n");
+		kfree(sec->fw_name);
+		xa_erase(&fw_upload_xa, sec->fw_name_id);
+		firmware_upload_unregister(sec->fwl);
+		return PTR_ERR(sec->fpgahp_bmc);
+	}
+
 	return 0;
 }
 
@@ -594,6 +702,7 @@ static int m10bmc_sec_remove(struct platform_device *pdev)
 {
 	struct m10bmc_sec *sec = dev_get_drvdata(&pdev->dev);
 
+	fpgahp_bmc_device_unregister(sec->fpgahp_bmc);
 	firmware_upload_unregister(sec->fwl);
 	kfree(sec->fw_name);
 	xa_erase(&fw_upload_xa, sec->fw_name_id);
@@ -626,3 +735,4 @@ module_platform_driver(intel_m10bmc_sec_driver);
 MODULE_AUTHOR("Intel Corporation");
 MODULE_DESCRIPTION("Intel MAX10 BMC Secure Update");
 MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS(FPGAHP);
-- 
2.38.1

