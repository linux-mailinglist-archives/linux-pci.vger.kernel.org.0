Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5494E672E46
	for <lists+linux-pci@lfdr.de>; Thu, 19 Jan 2023 02:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229901AbjASBeh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 18 Jan 2023 20:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjASBak (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 18 Jan 2023 20:30:40 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9B5AB76;
        Wed, 18 Jan 2023 17:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674091747; x=1705627747;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=8i69sD1dc8EqIXhwoHYyaLvbsgr6RGeo037UG511anQ=;
  b=SSxwFZq4uBFKu8kQZvgrngxkHfHkXif4lEh8zG/60minPevtOUJ3k1V1
   bHTh6TV057zQL/J101xkHIkexDxMerEMgfXA+RVCbLBy4i8YwswbPhDLC
   4BzJUMu9nUZuP5jNwd6tbfuAwg/QFW4YvmJiqlxTPyoe4B6lNZHYuDxT9
   I22B96f3+ViuUyxLS+p/yVJaSjKiy/qPlEcukctfNJJE9b/lkbFK8b/o2
   ptFSOr2m8ICpyduAyF6EgayiX6Ybj2d3Qu8C7186NIU/RhWEvnzFosQak
   L3s7KVr+JoABfcW5DGvWEQ1KHkd6BEjzN1KuWbGqLkThRZfGXrSKjyp+C
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="322847623"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="322847623"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2023 17:29:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10594"; a="767995709"
X-IronPort-AV: E=Sophos;i="5.97,226,1669104000"; 
   d="scan'208";a="767995709"
Received: from unknown (HELO fedora.sh.intel.com) ([10.238.175.104])
  by fmsmga002.fm.intel.com with ESMTP; 18 Jan 2023 17:29:01 -0800
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
Subject: [PATCH v1 11/12] fpga: m10bmc-sec: add m10bmc_sec_retimer_load callback
Date:   Wed, 18 Jan 2023 20:36:01 -0500
Message-Id: <20230119013602.607466-12-tianfei.zhang@intel.com>
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

Create m10bmc_sec_retimer_load() callback function to provide
a trigger to update a new retimer (Intel C827 Ethernet
transceiver) firmware on Intel PAC N3000 Card.

Signed-off-by: Russ Weight <russell.h.weight@intel.com>
Signed-off-by: Tianfei Zhang <tianfei.zhang@intel.com>
---
 drivers/fpga/intel-m10-bmc-sec-update.c | 136 ++++++++++++++++++++++++
 include/linux/mfd/intel-m10-bmc.h       |  31 ++++++
 2 files changed, 167 insertions(+)

diff --git a/drivers/fpga/intel-m10-bmc-sec-update.c b/drivers/fpga/intel-m10-bmc-sec-update.c
index 647531094b3b..053be33713c5 100644
--- a/drivers/fpga/intel-m10-bmc-sec-update.c
+++ b/drivers/fpga/intel-m10-bmc-sec-update.c
@@ -291,6 +291,137 @@ static int m10bmc_sec_bmc_image_load_1(struct m10bmc_sec *sec)
 	return m10bmc_sec_bmc_image_load(sec, 1);
 }
 
+static int trigger_retimer_eeprom_load(struct m10bmc_sec *sec)
+{
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
+	unsigned int val;
+	int ret;
+
+	ret = regmap_update_bits(m10bmc->regmap, M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				 DRBL_PKVL_EEPROM_LOAD_SEC, DRBL_PKVL_EEPROM_LOAD_SEC);
+	if (ret)
+		return ret;
+
+	/*
+	 * If the current NIOS FW supports this retimer update feature, then
+	 * it will clear the same PKVL_EEPROM_LOAD bit in 2 seconds. Otherwise
+	 * the driver needs to clear the PKVL_EEPROM_LOAD bit manually and
+	 * return an error code.
+	 */
+	ret = regmap_read_poll_timeout(m10bmc->regmap, M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       val, !(val & DRBL_PKVL_EEPROM_LOAD_SEC),
+				       M10BMC_PKVL_LOAD_INTERVAL_US, M10BMC_PKVL_LOAD_TIMEOUT_US);
+	if (ret == -ETIMEDOUT) {
+		dev_err(sec->dev, "PKVL_EEPROM_LOAD clear timeout\n");
+		regmap_update_bits(m10bmc->regmap, M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				   DRBL_PKVL_EEPROM_LOAD_SEC, 0);
+	} else if (ret) {
+		dev_err(sec->dev, "EEPROM_LOAD poll error %d\n", ret);
+	}
+
+	return ret;
+}
+
+static int poll_retimer_eeprom_load_done(struct m10bmc_sec *sec)
+{
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
+	unsigned int doorbell;
+	int ret;
+
+	/*
+	 * RSU_STAT_PKVL_REJECT indicates that the current image is
+	 * already programmed. RSU_PROG_PKVL_PROM_DONE that the firmware
+	 * update process has finished, but does not necessarily indicate
+	 * a successful update.
+	 */
+	ret = regmap_read_poll_timeout(m10bmc->regmap, M10BMC_SYS_BASE + M10BMC_DOORBELL,
+				       doorbell, (rsu_prog(doorbell) == RSU_PROG_PKVL_PROM_DONE) ||
+				       (rsu_stat(doorbell) == RSU_STAT_PKVL_REJECT),
+				       M10BMC_PKVL_PRELOAD_INTERVAL_US,
+				       M10BMC_PKVL_PRELOAD_TIMEOUT_US);
+	if (ret) {
+		if (ret == -ETIMEDOUT)
+			dev_err(sec->dev,
+				"Doorbell check timeout, last value 0x%08x\n", doorbell);
+		else
+			dev_err(sec->dev, "Doorbell poll error\n");
+		return ret;
+	}
+
+	if (rsu_stat(doorbell) == RSU_STAT_PKVL_REJECT) {
+		dev_err(sec->dev, "Duplicate image rejected\n");
+		return -EEXIST;
+	}
+
+	return 0;
+}
+
+static int poll_retimer_preload_done(struct m10bmc_sec *sec)
+{
+	struct intel_m10bmc *m10bmc = sec->m10bmc;
+	unsigned int val;
+	int ret;
+
+	/*
+	 * Wait for the updated firmware to be loaded by the PKVL device
+	 * and confirm that the updated firmware is operational
+	 */
+	ret = regmap_read_poll_timeout(m10bmc->regmap,
+				       M10BMC_SYS_BASE + M10BMC_PKVL_POLL_CTRL, val,
+				       (val & M10BMC_PKVL_PRELOAD) == M10BMC_PKVL_PRELOAD,
+				       M10BMC_PKVL_PRELOAD_INTERVAL_US,
+				       M10BMC_PKVL_PRELOAD_TIMEOUT_US);
+	if (ret) {
+		dev_err(sec->dev, "M10BMC_PKVL_PRELOAD poll error %d\n", ret);
+		return ret;
+	}
+
+	if ((val & M10BMC_PKVL_UPG_STATUS_MASK) != M10BMC_PKVL_UPG_STATUS_GOOD) {
+		dev_err(sec->dev, "Error detected during upgrade\n");
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static int retimer_check_idle(struct m10bmc_sec *sec)
+{
+	u32 doorbell;
+	int ret;
+
+	ret = m10bmc_sys_read(sec->m10bmc, M10BMC_DOORBELL, &doorbell);
+	if (ret)
+		return -EIO;
+
+	if (rsu_prog(doorbell) != RSU_PROG_IDLE &&
+	    rsu_prog(doorbell) != RSU_PROG_RSU_DONE &&
+	    rsu_prog(doorbell) != RSU_PROG_PKVL_PROM_DONE) {
+		log_error_regs(sec, doorbell);
+		return -EBUSY;
+	}
+
+	return 0;
+}
+
+static int m10bmc_sec_retimer_eeprom_load(struct m10bmc_sec *sec)
+{
+	int ret;
+
+	ret = retimer_check_idle(sec);
+	if (ret)
+		return ret;
+
+	ret = trigger_retimer_eeprom_load(sec);
+	if (ret)
+		return ret;
+
+	ret = poll_retimer_eeprom_load_done(sec);
+	if (ret)
+		return ret;
+
+	return poll_retimer_preload_done(sec);
+}
+
 static struct image_load m10bmc_image_load_hndlrs[] = {
 	{
 		.name = "bmc_factory",
@@ -302,6 +433,11 @@ static struct image_load m10bmc_image_load_hndlrs[] = {
 		.load_image = m10bmc_sec_bmc_image_load_0,
 		.wait_time_msec = RELOAD_DEFAULT_WAIT_MSECS,
 	},
+	{
+		.name = "retimer_fw",
+		.load_image = m10bmc_sec_retimer_eeprom_load,
+		.wait_time_msec = 2 * RELOAD_DEFAULT_WAIT_MSECS,
+	},
 	{}
 };
 
diff --git a/include/linux/mfd/intel-m10-bmc.h b/include/linux/mfd/intel-m10-bmc.h
index f0044b14136e..35ce0c35138b 100644
--- a/include/linux/mfd/intel-m10-bmc.h
+++ b/include/linux/mfd/intel-m10-bmc.h
@@ -36,6 +36,37 @@
 #define M10BMC_VER_PCB_INFO_MSK		GENMASK(31, 24)
 #define M10BMC_VER_LEGACY_INVALID	0xffffffff
 
+/* Retimer related registers, in system register region */
+#define M10BMC_PKVL_POLL_CTRL		0x80
+#define M10BMC_PKVL_A_PRELOAD		BIT(16)
+#define M10BMC_PKVL_A_PRELOAD_TO	BIT(17)
+#define M10BMC_PKVL_A_DATA_TOO_BIG	BIT(18)
+#define M10BMC_PKVL_A_HDR_CKSUM	BIT(20)
+#define M10BMC_PKVL_B_PRELOAD		BIT(24)
+#define M10BMC_PKVL_B_PRELOAD_TO	BIT(25)
+#define M10BMC_PKVL_B_DATA_TOO_BIG	BIT(26)
+#define M10BMC_PKVL_B_HDR_CKSUM	BIT(28)
+
+#define M10BMC_PKVL_PRELOAD		(M10BMC_PKVL_A_PRELOAD | M10BMC_PKVL_B_PRELOAD)
+#define M10BMC_PKVL_PRELOAD_TIMEOUT	(M10BMC_PKVL_A_PRELOAD_TO | M10BMC_PKVL_B_PRELOAD_TO)
+#define M10BMC_PKVL_DATA_TOO_BIG	(M10BMC_PKVL_A_DATA_TOO_BIG | M10BMC_PKVL_B_DATA_TOO_BIG)
+#define M10BMC_PKVL_HDR_CHECKSUM	(M10BMC_PKVL_A_HDR_CKSUM | M10BMC_PKVL_B_HDR_CKSUM)
+
+#define M10BMC_PKVL_UPG_STATUS_MASK \
+	(M10BMC_PKVL_PRELOAD | \
+	M10BMC_PKVL_PRELOAD_TIMEOUT | \
+	M10BMC_PKVL_DATA_TOO_BIG | \
+	M10BMC_PKVL_HDR_CHECKSUM)
+#define M10BMC_PKVL_UPG_STATUS_GOOD	(M10BMC_PKVL_PRELOAD | M10BMC_PKVL_HDR_CHECKSUM)
+
+/* interval 100ms and timeout 2s */
+#define M10BMC_PKVL_LOAD_INTERVAL_US	(100 * USEC_PER_MSEC)
+#define M10BMC_PKVL_LOAD_TIMEOUT_US	(2 * USEC_PER_SEC)
+
+/* interval 100ms and timeout 30s */
+#define M10BMC_PKVL_PRELOAD_INTERVAL_US (100 * USEC_PER_MSEC)
+#define M10BMC_PKVL_PRELOAD_TIMEOUT_US  (30 * USEC_PER_SEC)
+
 /* Secure update doorbell register, in system register region */
 #define M10BMC_DOORBELL			0x400
 
-- 
2.38.1

