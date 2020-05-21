Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 609DF1DD59B
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 20:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728113AbgEUSGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 14:06:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728216AbgEUSGU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 14:06:20 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5317520738;
        Thu, 21 May 2020 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590084379;
        bh=xU8t7TOsus2qpK/GQwes6Mta5oOa93+rCVYnaUU9y+U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fXQvywKRpPi9cifQ9VSkpCW1Xp3OPY3KXQrD9FAhrS1QtGl1Ete8T6VhS3UuxexNa
         bjNmzsvagVrnikN+HSkoepf45LekMKBy2yXv2H4a1BJBHPlhahwMPcZCUX2hPWCZ4I
         JMZX+rJIk5Wadupw1IS2Hh2JxlAUU4YYpeRzpYXs=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Klaus Doth <kdlnx@doth.eu>, Rui Feng <rui_feng@realsil.com.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 2/6] misc: rtsx: Removed unused dev_aspm_mode
Date:   Thu, 21 May 2020 13:05:41 -0500
Message-Id: <20200521180545.1159896-3-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200521180545.1159896-1-helgaas@kernel.org>
References: <20200521180545.1159896-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Bjorn Helgaas <bhelgaas@google.com>

The struct rtsx_cr_option.dev_aspm_mode member is never set to anything
other than DEV_ASPM_DYNAMIC (0).  Remove it and code that tests it.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cardreader/rts5249.c  | 19 ++++------------
 drivers/misc/cardreader/rts5260.c  | 18 ++++-----------
 drivers/misc/cardreader/rts5261.c  | 36 +++++-------------------------
 drivers/misc/cardreader/rtsx_pcr.c | 19 ++++------------
 include/linux/rtsx_pci.h           |  9 --------
 5 files changed, 18 insertions(+), 83 deletions(-)

diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index 1a81cda948c1..5171fdd92f3c 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -349,25 +349,15 @@ static int rtsx_base_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
 
 static void rts5249_set_aspm(struct rtsx_pcr *pcr, bool enable)
 {
-	struct rtsx_cr_option *option = &pcr->option;
 	u8 val = 0;
 
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	if (option->dev_aspm_mode == DEV_ASPM_DYNAMIC) {
-		if (enable)
-			val = pcr->aspm_en;
-		rtsx_pci_update_cfg_byte(pcr,
-			pcr->pcie_cap + PCI_EXP_LNKCTL,
-			ASPM_MASK_NEG, val);
-	} else if (option->dev_aspm_mode == DEV_ASPM_BACKDOOR) {
-		u8 mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0;
-
-		if (!enable)
-			val = FORCE_ASPM_CTL0;
-		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
-	}
+	if (enable)
+		val = pcr->aspm_en;
+	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
+				 ASPM_MASK_NEG, val);
 
 	pcr->aspm_enabled = enable;
 }
@@ -471,7 +461,6 @@ void rts5249_init_params(struct rtsx_pcr *pcr)
 	option->ltr_active_latency = LTR_ACTIVE_LATENCY_DEF;
 	option->ltr_idle_latency = LTR_IDLE_LATENCY_DEF;
 	option->ltr_l1off_latency = LTR_L1OFF_LATENCY_DEF;
-	option->dev_aspm_mode = DEV_ASPM_DYNAMIC;
 	option->l1_snooze_delay = L1_SNOOZE_DELAY_DEF;
 	option->ltr_l1off_sspwrgate = LTR_L1OFF_SSPWRGATE_5249_DEF;
 	option->ltr_l1off_snooze_sspwrgate =
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 711054ebad74..b4c1386382ea 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -572,24 +572,15 @@ static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 
 static void rts5260_set_aspm(struct rtsx_pcr *pcr, bool enable)
 {
-	struct rtsx_cr_option *option = &pcr->option;
 	u8 val = 0;
 
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	if (option->dev_aspm_mode == DEV_ASPM_DYNAMIC) {
-		if (enable)
-			val = pcr->aspm_en;
-		rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-					 ASPM_MASK_NEG, val);
-	} else if (option->dev_aspm_mode == DEV_ASPM_BACKDOOR) {
-		u8 mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0;
-
-		if (!enable)
-			val = FORCE_ASPM_CTL0;
-		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
-	}
+	if (enable)
+		val = pcr->aspm_en;
+	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
+				 ASPM_MASK_NEG, val);
 
 	pcr->aspm_enabled = enable;
 }
@@ -683,7 +674,6 @@ void rts5260_init_params(struct rtsx_pcr *pcr)
 	option->ltr_active_latency = LTR_ACTIVE_LATENCY_DEF;
 	option->ltr_idle_latency = LTR_IDLE_LATENCY_DEF;
 	option->ltr_l1off_latency = LTR_L1OFF_LATENCY_DEF;
-	option->dev_aspm_mode = DEV_ASPM_DYNAMIC;
 	option->l1_snooze_delay = L1_SNOOZE_DELAY_DEF;
 	option->ltr_l1off_sspwrgate = LTR_L1OFF_SSPWRGATE_5250_DEF;
 	option->ltr_l1off_snooze_sspwrgate =
diff --git a/drivers/misc/cardreader/rts5261.c b/drivers/misc/cardreader/rts5261.c
index 78c3b1d424c3..807ffbd9c06d 100644
--- a/drivers/misc/cardreader/rts5261.c
+++ b/drivers/misc/cardreader/rts5261.c
@@ -518,51 +518,28 @@ static int rts5261_extra_init_hw(struct rtsx_pcr *pcr)
 
 static void rts5261_enable_aspm(struct rtsx_pcr *pcr, bool enable)
 {
-	struct rtsx_cr_option *option = &pcr->option;
 	u8 val = 0;
 
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	if (option->dev_aspm_mode == DEV_ASPM_DYNAMIC) {
-		val = pcr->aspm_en;
-		rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-					 ASPM_MASK_NEG, val);
-	} else if (option->dev_aspm_mode == DEV_ASPM_BACKDOOR) {
-		u8 mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0;
-
-		val = FORCE_ASPM_CTL0;
-		val |= (pcr->aspm_en & 0x02);
-		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
-		val = pcr->aspm_en;
-		rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-					 ASPM_MASK_NEG, val);
-	}
+	val = pcr->aspm_en;
+	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
+				 ASPM_MASK_NEG, val);
 	pcr->aspm_enabled = enable;
 
 }
 
 static void rts5261_disable_aspm(struct rtsx_pcr *pcr, bool enable)
 {
-	struct rtsx_cr_option *option = &pcr->option;
 	u8 val = 0;
 
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	if (option->dev_aspm_mode == DEV_ASPM_DYNAMIC) {
-		val = 0;
-		rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-					 ASPM_MASK_NEG, val);
-	} else if (option->dev_aspm_mode == DEV_ASPM_BACKDOOR) {
-		u8 mask = FORCE_ASPM_VAL_MASK | FORCE_ASPM_CTL0;
-
-		val = 0;
-		rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
-					 ASPM_MASK_NEG, val);
-		val = FORCE_ASPM_CTL0;
-		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL, mask, val);
-	}
+	val = 0;
+	rtsx_pci_update_cfg_byte(pcr, pcr->pcie_cap + PCI_EXP_LNKCTL,
+				 ASPM_MASK_NEG, val);
 	rtsx_pci_write_register(pcr, SD_CFG1, SD_ASYNC_FIFO_NOT_RST, 0);
 	udelay(10);
 	pcr->aspm_enabled = enable;
@@ -784,7 +761,6 @@ void rts5261_init_params(struct rtsx_pcr *pcr)
 	option->l1_snooze_delay = L1_SNOOZE_DELAY_DEF;
 	option->ltr_l1off_sspwrgate = 0x7F;
 	option->ltr_l1off_snooze_sspwrgate = 0x78;
-	option->dev_aspm_mode = DEV_ASPM_DYNAMIC;
 
 	option->ocp_en = 1;
 	hw_param->interrupt_en |= SD_OC_INT_EN;
diff --git a/drivers/misc/cardreader/rtsx_pcr.c b/drivers/misc/cardreader/rtsx_pcr.c
index 7145de2504c2..ce3919e59719 100644
--- a/drivers/misc/cardreader/rtsx_pcr.c
+++ b/drivers/misc/cardreader/rtsx_pcr.c
@@ -90,24 +90,13 @@ int rtsx_set_ltr_latency(struct rtsx_pcr *pcr, u32 latency)
 
 static void rtsx_comm_set_aspm(struct rtsx_pcr *pcr, bool enable)
 {
-	struct rtsx_cr_option *option = &pcr->option;
-
 	if (pcr->aspm_enabled == enable)
 		return;
 
-	if (option->dev_aspm_mode == DEV_ASPM_DYNAMIC) {
-		if (enable)
-			rtsx_pci_enable_aspm(pcr);
-		else
-			rtsx_pci_disable_aspm(pcr);
-	} else if (option->dev_aspm_mode == DEV_ASPM_BACKDOOR) {
-		u8 mask = FORCE_ASPM_VAL_MASK;
-		u8 val = 0;
-
-		if (enable)
-			val = pcr->aspm_en;
-		rtsx_pci_write_register(pcr, ASPM_FORCE_CTL,  mask, val);
-	}
+	if (enable)
+		rtsx_pci_enable_aspm(pcr);
+	else
+		rtsx_pci_disable_aspm(pcr);
 
 	pcr->aspm_enabled = enable;
 }
diff --git a/include/linux/rtsx_pci.h b/include/linux/rtsx_pci.h
index df86afb2b4fe..a75132a0cf8f 100644
--- a/include/linux/rtsx_pci.h
+++ b/include/linux/rtsx_pci.h
@@ -1104,13 +1104,6 @@ enum PDEV_STAT  {PDEV_STAT_IDLE, PDEV_STAT_RUN};
 #define L1_SNOOZE_TEST_EN		BIT(5)
 #define LTR_L1SS_PWR_GATE_CHECK_CARD_EN	BIT(6)
 
-enum dev_aspm_mode {
-	DEV_ASPM_DYNAMIC,
-	DEV_ASPM_BACKDOOR,
-	DEV_ASPM_STATIC,
-	DEV_ASPM_DISABLE,
-};
-
 /*
  * struct rtsx_cr_option  - card reader option
  * @dev_flags: device flags
@@ -1121,7 +1114,6 @@ enum dev_aspm_mode {
  * @ltr_active_latency: ltr mode active latency
  * @ltr_idle_latency: ltr mode idle latency
  * @ltr_l1off_latency: ltr mode l1off latency
- * @dev_aspm_mode: device aspm mode
  * @l1_snooze_delay: l1 snooze delay
  * @ltr_l1off_sspwrgate: ltr l1off sspwrgate
  * @ltr_l1off_snooze_sspwrgate: ltr l1off snooze sspwrgate
@@ -1138,7 +1130,6 @@ struct rtsx_cr_option {
 	u32 ltr_active_latency;
 	u32 ltr_idle_latency;
 	u32 ltr_l1off_latency;
-	enum dev_aspm_mode dev_aspm_mode;
 	u32 l1_snooze_delay;
 	u8 ltr_l1off_sspwrgate;
 	u8 ltr_l1off_snooze_sspwrgate;
-- 
2.25.1

