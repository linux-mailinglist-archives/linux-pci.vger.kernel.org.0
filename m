Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5082125F757
	for <lists+linux-pci@lfdr.de>; Mon,  7 Sep 2020 12:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728580AbgIGKIZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Sep 2020 06:08:25 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:59352 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728317AbgIGKHp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Sep 2020 06:07:45 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 087A7NPR0026756, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 087A7NPR0026756
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Sep 2020 18:07:23 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Mon, 7 Sep 2020 18:07:23 +0800
Received: from localhost (172.22.88.222) by RTEXMB01.realtek.com.tw
 (172.21.6.94) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2044.4; Mon, 7 Sep 2020
 18:07:23 +0800
From:   <ricky_wu@realtek.com>
To:     <arnd@arndb.de>, <gregkh@linuxfoundation.org>,
        <ricky_wu@realtek.com>, <bhelgaas@google.com>,
        <ulf.hansson@linaro.org>, <rui_feng@realsil.com.cn>,
        <linux-kernel@vger.kernel.org>, <puranjay12@gmail.com>,
        <linux-pci@vger.kernel.org>, <vailbhavgupta40@gamail.com>
Subject: [PATCH v5 1/2] misc: rtsx: Fix power down flow
Date:   Mon, 7 Sep 2020 18:07:18 +0800
Message-ID: <20200907100718.7672-1-ricky_wu@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.22.88.222]
X-ClientProxiedBy: RTEXMB04.realtek.com.tw (172.21.6.97) To
 RTEXMB01.realtek.com.tw (172.21.6.94)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ricky Wu <ricky_wu@realtek.com>

Fix and sort out rtsx driver power down flow

Signed-off-by: Ricky Wu <ricky_wu@realtek.com>
---
 drivers/misc/cardreader/rts5227.c  | 15 ---------------
 drivers/misc/cardreader/rts5228.c  |  5 ++---
 drivers/misc/cardreader/rts5249.c  | 17 -----------------
 drivers/misc/cardreader/rts5260.c  | 16 ----------------
 drivers/misc/cardreader/rtsx_pcr.c | 16 ++++++++++++++++
 5 files changed, 18 insertions(+), 51 deletions(-)

diff --git a/drivers/misc/cardreader/rts5227.c b/drivers/misc/cardreader/rts5227.c
index f5f392ddf3d6..747391e3fb5d 100644
--- a/drivers/misc/cardreader/rts5227.c
+++ b/drivers/misc/cardreader/rts5227.c
@@ -77,19 +77,6 @@ static void rts5227_fetch_vendor_settings(struct rtsx_pcr *pcr)
 		pcr->flags |= PCR_REVERSE_SOCKET;
 }
 
-static void rts5227_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
-{
-	/* Set relink_time to 0 */
-	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, 0xFF, 0);
-	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, 0xFF, 0);
-	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3, 0x01, 0);
-
-	if (pm_state == HOST_ENTER_S3)
-		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3, 0x10, 0x10);
-
-	rtsx_pci_write_register(pcr, FPDCTL, 0x03, 0x03);
-}
-
 static int rts5227_extra_init_hw(struct rtsx_pcr *pcr)
 {
 	u16 cap;
@@ -239,7 +226,6 @@ static const struct pcr_ops rts5227_pcr_ops = {
 	.switch_output_voltage = rts5227_switch_output_voltage,
 	.cd_deglitch = NULL,
 	.conv_clk_and_div_n = NULL,
-	.force_power_down = rts5227_force_power_down,
 };
 
 /* SD Pull Control Enable:
@@ -389,7 +375,6 @@ static const struct pcr_ops rts522a_pcr_ops = {
 	.switch_output_voltage = rts522a_switch_output_voltage,
 	.cd_deglitch = NULL,
 	.conv_clk_and_div_n = NULL,
-	.force_power_down = rts5227_force_power_down,
 };
 
 void rts522a_init_params(struct rtsx_pcr *pcr)
diff --git a/drivers/misc/cardreader/rts5228.c b/drivers/misc/cardreader/rts5228.c
index 28feab1449ab..781a86def59a 100644
--- a/drivers/misc/cardreader/rts5228.c
+++ b/drivers/misc/cardreader/rts5228.c
@@ -99,9 +99,8 @@ static void rts5228_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
 	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
 				RELINK_TIME_MASK, 0);
 
-	if (pm_state == HOST_ENTER_S3)
-		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
-					D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
+	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
+			D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
 
 	rtsx_pci_write_register(pcr, FPDCTL,
 		SSC_POWER_DOWN, SSC_POWER_DOWN);
diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 941b3d77f1e9..719aa2d61919 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -78,20 +78,6 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 		pcr->flags |= PCR_REVERSE_SOCKET;
 }
 
-static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
-{
-	/* Set relink_time to 0 */
-	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, 0xFF, 0);
-	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, 0xFF, 0);
-	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3, 0x01, 0);
-
-	if (pm_state == HOST_ENTER_S3)
-		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
-			D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
-
-	rtsx_pci_write_register(pcr, FPDCTL, 0x03, 0x03);
-}
-
 static void rts5249_init_from_cfg(struct rtsx_pcr *pcr)
 {
 	struct pci_dev *pdev = pcr->pci;
@@ -360,7 +346,6 @@ static const struct pcr_ops rts5249_pcr_ops = {
 	.card_power_on = rtsx_base_card_power_on,
 	.card_power_off = rtsx_base_card_power_off,
 	.switch_output_voltage = rtsx_base_switch_output_voltage,
-	.force_power_down = rtsx_base_force_power_down,
 };
 
 /* SD Pull Control Enable:
@@ -585,7 +570,6 @@ static const struct pcr_ops rts524a_pcr_ops = {
 	.card_power_on = rtsx_base_card_power_on,
 	.card_power_off = rtsx_base_card_power_off,
 	.switch_output_voltage = rtsx_base_switch_output_voltage,
-	.force_power_down = rtsx_base_force_power_down,
 	.set_l1off_cfg_sub_d0 = rts5250_set_l1off_cfg_sub_d0,
 };
 
@@ -700,7 +684,6 @@ static const struct pcr_ops rts525a_pcr_ops = {
 	.card_power_on = rts525a_card_power_on,
 	.card_power_off = rtsx_base_card_power_off,
 	.switch_output_voltage = rts525a_switch_output_voltage,
-	.force_power_down = rtsx_base_force_power_down,
 	.set_l1off_cfg_sub_d0 = rts5250_set_l1off_cfg_sub_d0,
 };
 
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index b9f66b1384a6..897cfee350e7 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -87,21 +87,6 @@ static void rtsx_base_fetch_vendor_settings(struct rtsx_pcr *pcr)
 		pcr->flags |= PCR_REVERSE_SOCKET;
 }
 
-static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
-{
-	/* Set relink_time to 0 */
-	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
-	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, MASK_8_BIT_DEF, 0);
-	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
-				RELINK_TIME_MASK, 0);
-
-	if (pm_state == HOST_ENTER_S3)
-		rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
-					D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
-
-	rtsx_pci_write_register(pcr, FPDCTL, ALL_POWER_DOWN, ALL_POWER_DOWN);
-}
-
 static int rtsx_base_enable_auto_blink(struct rtsx_pcr *pcr)
 {
 	return rtsx_pci_write_register(pcr, OLT_LED_CTL,
@@ -620,7 +605,6 @@ static const struct pcr_ops rts5260_pcr_ops = {
 	.card_power_on = rts5260_card_power_on,
 	.card_power_off = rts5260_card_power_off,
 	.switch_output_voltage = rts5260_switch_output_voltage,
-	.force_power_down = rtsx_base_force_power_down,
 	.stop_cmd = rts5260_stop_cmd,
 	.set_l1off_cfg_sub_d0 = rts5260_set_l1off_cfg_sub_d0,
 	.enable_ocp = rts5260_enable_ocp,
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 37ccc67f4914..3f84b898bd9c 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -1096,6 +1096,20 @@ static void rtsx_pci_idle_work(struct work_struct *work)
 	mutex_unlock(&pcr->pcr_mutex);
 }
 
+static void rtsx_base_force_power_down(struct rtsx_pcr *pcr, u8 pm_state)
+{
+	/* Set relink_time to 0 */
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 1, MASK_8_BIT_DEF, 0);
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 2, MASK_8_BIT_DEF, 0);
+	rtsx_pci_write_register(pcr, AUTOLOAD_CFG_BASE + 3,
+			RELINK_TIME_MASK, 0);
+
+	rtsx_pci_write_register(pcr, pcr->reg_pm_ctrl3,
+			D3_DELINK_MODE_EN, D3_DELINK_MODE_EN);
+
+	rtsx_pci_write_register(pcr, FPDCTL, ALL_POWER_DOWN, ALL_POWER_DOWN);
+}
+
 static void __maybe_unused rtsx_pci_power_off(struct rtsx_pcr *pcr, u8 pm_state)
 {
 	if (pcr->ops->turn_off_led)
@@ -1109,6 +1123,8 @@ static void __maybe_unused rtsx_pci_power_off(struct rtsx_pcr *pcr, u8 pm_state)
 
 	if (pcr->ops->force_power_down)
 		pcr->ops->force_power_down(pcr, pm_state);
+	else
+		rtsx_base_force_power_down(pcr, pm_state);
 }
 
 void rtsx_pci_enable_ocp(struct rtsx_pcr *pcr)
-- 
2.17.1

