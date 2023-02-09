Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAEBC68FF89
	for <lists+linux-pci@lfdr.de>; Thu,  9 Feb 2023 05:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229685AbjBIEvr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Feb 2023 23:51:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjBIEvq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Feb 2023 23:51:46 -0500
Received: from smtp161.vfemail.net (smtp161.vfemail.net [146.59.185.161])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22C221701
        for <linux-pci@vger.kernel.org>; Wed,  8 Feb 2023 20:51:42 -0800 (PST)
Received: (qmail 22041 invoked from network); 9 Feb 2023 04:51:41 +0000
Received: from localhost (HELO nl101-3.vfemail.net) ()
  by smtpout.vfemail.net with ESMTPS (ECDHE-RSA-AES256-GCM-SHA384 encrypted); 9 Feb 2023 04:51:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=openmail.cc; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=2018; bh=yeEmSWQU6uXGDgUoCPD+Fx0jK
        kbuXwhfmyp6hIhwyDg=; b=IdJoXyglvjUOySTsJlP+XdY1VG29w5hxb9bsIZ/XJ
        H2puL17w7iP/fD4NDo9czqFcsrCPXDl5nxyZp99MJdbPhLgjB0iPLavaL/V89MCQ
        gDAVuoEfJp+8PktVlK4P32NlDjWBabSyDoEVsYX03mddMfqM3WXc7PsH/xMdD3/N
        T8=
Received: (qmail 88312 invoked from network); 9 Feb 2023 04:51:40 -0000
Received: by simscan 1.4.0 ppid: 87524, pid: 88278, t: 0.8102s
         scanners:none
Received: from unknown (HELO bmwxMDEudmZlbWFpbC5uZXQ=) (ZXF1dUBvcGVubWFpbC5jYw==@MTkyLjE2OC4xLjE5Mg==)
  by nl101.vfemail.net with ESMTPA; 9 Feb 2023 04:51:39 -0000
From:   equu@openmail.cc
To:     lpieralisi@kernel.org, toke@toke.dk, kvalo@kernel.org
Cc:     linux-pci@vger.kernel.org, robh@kernel.org,
        linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
        equu@openmail.cc, kernel test robot <lkp@intel.com>
Subject: [PATCH v6 3/3] wifi: ath10k: only load compatible DT cal data
Date:   Thu,  9 Feb 2023 12:50:27 +0800
Message-Id: <20230209045026.1806587-4-equu@openmail.cc>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
References: <ab8ff515-19ec-fe3f-0237-c30275e9744d@openmail.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Edward Chow <equu@openmail.cc>

ath10k might also be sensitive to the issue reported on
https://github.com/openwrt/openwrt/pull/11345 , loading calibration
data from a device tree node declared incompatible.

ath10k will first check whether the device tree node is compatible
with it, using the functionality introduced with the first patch of
this series, ("PCI: of: Match pci devices or drivers against OF DT
nodes") and only proceed loading calibration data from compatible node.

Signed-off-by: Edward Chow <equu@openmail.cc>
Reported-by: kernel test robot <lkp@intel.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 31 ++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/hw.h   |  4 ++++
 drivers/net/wireless/ath/ath10k/pci.c  | 18 ++++++++++++++-
 drivers/net/wireless/ath/ath10k/pci.h  |  2 ++
 4 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 5eb131ab916f..4c9e8140aeff 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -13,6 +13,8 @@
 #include <linux/ctype.h>
 #include <linux/pm_qos.h>
 #include <linux/nvmem-consumer.h>
+#include <linux/of_pci.h>
+#include <linux/pci.h>
 #include <asm/byteorder.h>
 
 #include "core.h"
@@ -26,6 +28,7 @@
 #include "testmode.h"
 #include "wmi-ops.h"
 #include "coredump.h"
+#include "pci.h"
 
 unsigned int ath10k_debug_mask;
 EXPORT_SYMBOL(ath10k_debug_mask);
@@ -1958,6 +1961,34 @@ static int ath10k_download_cal_nvmem(struct ath10k *ar, const char *cell_name)
 	size_t len;
 	int ret;
 
+	/* devm_nvmem_cell_get() will get a cell first from the OF
+	 * DT node representing the given device with nvmem-cell-name
+	 * "calibration", and from the global lookup table as a fallback,
+	 * and an ath10k device could be either a pci one or a platform one.
+	 *
+	 * If the OF DT node is not compatible with the real device, the
+	 * calibration data got from the node should not be applied.
+	 *
+	 * dev_is_pci(ar->dev) && ( no OF node || caldata not from node
+	 * || not compatible ) -> do not use caldata .
+	 *
+	 * !dev_is_pci(ar->dev) -> always use caldata .
+	 *
+	 * The judgement for compatibility differs with ath9k for many
+	 * DT using "qcom,ath10k" as compatibility string.
+	 */
+	if (dev_is_pci(ar->dev) &&
+	    (!ar->dev->of_node ||
+	     (of_property_match_string(ar->dev->of_node,
+				       "nvmem-cell-names",
+				       cell_name) < 0) ||
+	     !of_device_get_match_data(ar->dev) ||
+	     !(((const struct ath10k_hw_misc_flags *)
+		of_device_get_match_data(ar->dev))->need_calibration) ||
+	     !of_pci_node_match_driver(ar->dev->of_node,
+				       &ath10k_pci_driver)))
+		return -ENOENT;
+
 	cell = devm_nvmem_cell_get(ar->dev, cell_name);
 	if (IS_ERR(cell)) {
 		ret = PTR_ERR(cell);
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 9643031a4427..8e19fa637905 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -384,6 +384,10 @@ struct ath10k_hw_values {
 	bool rfkill_on_level;
 };
 
+struct ath10k_hw_misc_flags {
+	bool need_calibration;
+};
+
 extern const struct ath10k_hw_values qca988x_values;
 extern const struct ath10k_hw_values qca6174_values;
 extern const struct ath10k_hw_values qca99x0_values;
diff --git a/drivers/net/wireless/ath/ath10k/pci.c b/drivers/net/wireless/ath/ath10k/pci.c
index 728d607289c3..b6ea40631e1b 100644
--- a/drivers/net/wireless/ath/ath10k/pci.c
+++ b/drivers/net/wireless/ath/ath10k/pci.c
@@ -97,6 +97,22 @@ static const struct ath10k_pci_supp_chip ath10k_pci_supp_chips[] = {
 	{ QCA9887_1_0_DEVICE_ID, QCA9887_HW_1_0_CHIP_ID_REV },
 };
 
+static const struct ath10k_hw_misc_flags ath10k_pci_of_flag = {
+	.need_calibration = true,
+}
+
+static const struct of_device_id ath10k_pci_of_match[] = {
+	/* OF DT nodes for a generic ath10k pci devices
+	 * usually use this compatibility string.
+	 */
+	{ .compatible = "qcom,ath10k",
+	  .data = &ath10k_pci_of_flag
+	},
+	{ }
+};
+
+MODULE_DEVICE_TABLE(of, ath10k_pci_of_match);
+
 static void ath10k_pci_buffer_cleanup(struct ath10k *ar);
 static int ath10k_pci_cold_reset(struct ath10k *ar);
 static int ath10k_pci_safe_chip_reset(struct ath10k *ar);
@@ -3780,7 +3796,7 @@ static SIMPLE_DEV_PM_OPS(ath10k_pci_pm_ops,
 			 ath10k_pci_pm_suspend,
 			 ath10k_pci_pm_resume);
 
-static struct pci_driver ath10k_pci_driver = {
+struct pci_driver ath10k_pci_driver = {
 	.name = "ath10k_pci",
 	.id_table = ath10k_pci_id_table,
 	.probe = ath10k_pci_probe,
diff --git a/drivers/net/wireless/ath/ath10k/pci.h b/drivers/net/wireless/ath/ath10k/pci.h
index 480cd97ab739..de676797b736 100644
--- a/drivers/net/wireless/ath/ath10k/pci.h
+++ b/drivers/net/wireless/ath/ath10k/pci.h
@@ -209,6 +209,8 @@ static inline struct ath10k_pci *ath10k_pci_priv(struct ath10k *ar)
 #define DIAG_ACCESS_CE_TIMEOUT_US 10000 /* 10 ms */
 #define DIAG_ACCESS_CE_WAIT_US	50
 
+extern struct pci_driver ath10k_pci_driver;
+
 void ath10k_pci_write32(struct ath10k *ar, u32 offset, u32 value);
 void ath10k_pci_soc_write32(struct ath10k *ar, u32 addr, u32 val);
 void ath10k_pci_reg_write32(struct ath10k *ar, u32 addr, u32 val);
-- 
2.39.1

