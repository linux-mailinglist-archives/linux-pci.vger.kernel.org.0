Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6931DD5AA
	for <lists+linux-pci@lfdr.de>; Thu, 21 May 2020 20:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbgEUSHF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 21 May 2020 14:07:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:34326 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727883AbgEUSHE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 21 May 2020 14:07:04 -0400
Received: from localhost (mobile-166-175-190-200.mycingular.net [166.175.190.200])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1272207D3;
        Thu, 21 May 2020 18:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590084424;
        bh=teZtbZmdrWDP3PS3nLN++qQGlFNe0buLFWAQeiWZm6s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vFKWZSYhZBzvtcMgUQDcrinU/O7eVvrF6tkaeDLRNU9/5RRwYrADVdnn9e/ihCEFk
         99U/P1D3ZoZShISVY4nCkuvqO/4Xk7PBT+oeAGvhw8u6C2ByFHeH4xe8c2bWbX8bB7
         hC+4TudRnpptnrw5C3BI6AXjKbadNrOT2VDCFYO4=
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>
Cc:     Klaus Doth <kdlnx@doth.eu>, Rui Feng <rui_feng@realsil.com.cn>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH 6/6] misc: rtsx: Remove unnecessary rts5249_set_aspm(), rts5260_set_aspm()
Date:   Thu, 21 May 2020 13:05:45 -0500
Message-Id: <20200521180545.1159896-7-helgaas@kernel.org>
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

rts5249_set_aspm() and rts5260_set_aspm() do nothing more than the default
rtsx_comm_set_aspm() does, so remove them and use the default.  No
functional change intended.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/misc/cardreader/rts5249.c | 15 ---------------
 drivers/misc/cardreader/rts5260.c | 13 -------------
 2 files changed, 28 deletions(-)

diff --git a/drivers/misc/cardreader/rts5249.c b/drivers/misc/cardreader/rts5249.c
index d122608e9f79..6c6c9e95a29f 100644
--- a/drivers/misc/cardreader/rts5249.c
+++ b/drivers/misc/cardreader/rts5249.c
@@ -347,18 +347,6 @@ static int rtsx_base_switch_output_voltage(struct rtsx_pcr *pcr, u8 voltage)
 	return rtsx_pci_send_cmd(pcr, 100);
 }
 
-static void rts5249_set_aspm(struct rtsx_pcr *pcr, bool enable)
-{
-	if (pcr->aspm_enabled == enable)
-		return;
-
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC,
-					   enable ? pcr->aspm_en : 0);
-
-	pcr->aspm_enabled = enable;
-}
-
 static const struct pcr_ops rts5249_pcr_ops = {
 	.fetch_vendor_settings = rtsx_base_fetch_vendor_settings,
 	.extra_init_hw = rts5249_extra_init_hw,
@@ -371,7 +359,6 @@ static const struct pcr_ops rts5249_pcr_ops = {
 	.card_power_off = rtsx_base_card_power_off,
 	.switch_output_voltage = rtsx_base_switch_output_voltage,
 	.force_power_down = rtsx_base_force_power_down,
-	.set_aspm = rts5249_set_aspm,
 };
 
 /* SD Pull Control Enable:
@@ -598,7 +585,6 @@ static const struct pcr_ops rts524a_pcr_ops = {
 	.switch_output_voltage = rtsx_base_switch_output_voltage,
 	.force_power_down = rtsx_base_force_power_down,
 	.set_l1off_cfg_sub_d0 = rts5250_set_l1off_cfg_sub_d0,
-	.set_aspm = rts5249_set_aspm,
 };
 
 void rts524a_init_params(struct rtsx_pcr *pcr)
@@ -714,7 +700,6 @@ static const struct pcr_ops rts525a_pcr_ops = {
 	.switch_output_voltage = rts525a_switch_output_voltage,
 	.force_power_down = rtsx_base_force_power_down,
 	.set_l1off_cfg_sub_d0 = rts5250_set_l1off_cfg_sub_d0,
-	.set_aspm = rts5249_set_aspm,
 };
 
 void rts525a_init_params(struct rtsx_pcr *pcr)
diff --git a/drivers/misc/cardreader/rts5260.c b/drivers/misc/cardreader/rts5260.c
index 75fc67d78d7f..7a9dbb778e84 100644
--- a/drivers/misc/cardreader/rts5260.c
+++ b/drivers/misc/cardreader/rts5260.c
@@ -570,18 +570,6 @@ static int rts5260_extra_init_hw(struct rtsx_pcr *pcr)
 	return 0;
 }
 
-static void rts5260_set_aspm(struct rtsx_pcr *pcr, bool enable)
-{
-	if (pcr->aspm_enabled == enable)
-		return;
-
-	pcie_capability_clear_and_set_word(pcr->pci, PCI_EXP_LNKCTL,
-					   PCI_EXP_LNKCTL_ASPMC,
-					   enable ?  pcr->aspm : 0);
-
-	pcr->aspm_enabled = enable;
-}
-
 static void rts5260_set_l1off_cfg_sub_d0(struct rtsx_pcr *pcr, int active)
 {
 	struct rtsx_cr_option *option = &pcr->option;
@@ -627,7 +615,6 @@ static const struct pcr_ops rts5260_pcr_ops = {
 	.switch_output_voltage = rts5260_switch_output_voltage,
 	.force_power_down = rtsx_base_force_power_down,
 	.stop_cmd = rts5260_stop_cmd,
-	.set_aspm = rts5260_set_aspm,
 	.set_l1off_cfg_sub_d0 = rts5260_set_l1off_cfg_sub_d0,
 	.enable_ocp = rts5260_enable_ocp,
 	.disable_ocp = rts5260_disable_ocp,
-- 
2.25.1

