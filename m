Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE13891D7
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 15:30:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfHKNaI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 09:30:08 -0400
Received: from mail-wr1-f43.google.com ([209.85.221.43]:38434 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbfHKNaI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 09:30:08 -0400
Received: by mail-wr1-f43.google.com with SMTP id g17so102289072wrr.5;
        Sun, 11 Aug 2019 06:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hNVysyJxaR9B9NBma6aE1tC35JgmHy+mk3/bCgcCQws=;
        b=sa2Yys+RsMyS4Sifw4vBL6psj3wsAbF+YDzBELMLTrxhD4/fD2VQPU94qdcKCHWtQJ
         IveEmMU55WBeZHRMWFNksKoYBCRIpAeNJ8XjqksnzrYBMFN56laRlaLSGBaFxz0ubU/h
         5tQUntKEdGUsVIgB890ajZeTMboF5thCumvTAdUFZmsfWE63ExxrfROsGe96JQ2VpoNc
         +J5HKlUrQXQ0rwg7sLlSHHacwuCSuM8nbZjOaByLAsSK5YgomSYs2ApnaObKtBh63uJD
         89PCllLwolezQboSFCQ9pu8a/MTp+7S+56kxa80D/etj0j3tnXAhxfC2ltD77mMk++XS
         ZvTg==
X-Gm-Message-State: APjAAAUmZly4SdNoD/yZxB1RHU7LyDg1WRPOPKo9PMo79O37lGngWzAZ
        SaqZGIDOkESNL5WMhgF6GAU=
X-Google-Smtp-Source: APXvYqzInfGwNUDqfhxDZTIU84GdSNcPLZfAHujuGjCNOLziKaT3z0MjjDExGTpUYLn2OS25HK/mlw==
X-Received: by 2002:adf:f206:: with SMTP id p6mr36660595wro.216.1565530205528;
        Sun, 11 Aug 2019 06:30:05 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id o16sm13781463wrp.23.2019.08.11.06.30.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 06:30:05 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 4/4] PCI: pciehp: Replace pciehp_green_led_{on,off,blink}()
Date:   Sun, 11 Aug 2019 16:29:45 +0300
Message-Id: <20190811132945.12426-5-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811132945.12426-1-efremov@linux.com>
References: <20190811132945.12426-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch replaces pciehp_green_led_{on,off,blink}() with
pciehp_set_indicators().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp.h     | 12 ++++++++---
 drivers/pci/hotplug/pciehp_hpc.c | 36 --------------------------------
 2 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 01ea095aa533..7ae16ad1a8a7 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -184,9 +184,6 @@ void pciehp_set_indicators(struct controller *ctrl,
 			   enum pciehp_indicator attn);
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
-void pciehp_green_led_on(struct controller *ctrl);
-void pciehp_green_led_off(struct controller *ctrl);
-void pciehp_green_led_blink(struct controller *ctrl);
 bool pciehp_card_present(struct controller *ctrl);
 bool pciehp_card_present_or_link_active(struct controller *ctrl);
 int pciehp_check_link_status(struct controller *ctrl);
@@ -203,6 +200,15 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 #define pciehp_set_attention_status(crtl, status) \
 	pciehp_set_indicators(ctrl, PWR_NONE, status)
 
+#define pciehp_green_led_on(ctrl) \
+	pciehp_set_indicators(ctrl, PWR_ON, ATTN_NONE)
+
+#define pciehp_green_led_off(ctrl) \
+	pciehp_set_indicators(ctrl, PWR_OFF, ATTN_NONE)
+
+#define pciehp_green_led_blink(ctrl) \
+	pciehp_set_indicators(ctrl, PWR_BLINK, ATTN_NONE)
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index beff1120afef..13cc417493f8 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -467,42 +467,6 @@ void pciehp_set_indicators(struct controller *ctrl,
 		 cmd);
 }
 
-void pciehp_green_led_on(struct controller *ctrl)
-{
-	if (!PWR_LED(ctrl))
-		return;
-
-	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
-			      PCI_EXP_SLTCTL_PIC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-		 PCI_EXP_SLTCTL_PWR_IND_ON);
-}
-
-void pciehp_green_led_off(struct controller *ctrl)
-{
-	if (!PWR_LED(ctrl))
-		return;
-
-	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
-			      PCI_EXP_SLTCTL_PIC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-		 PCI_EXP_SLTCTL_PWR_IND_OFF);
-}
-
-void pciehp_green_led_blink(struct controller *ctrl)
-{
-	if (!PWR_LED(ctrl))
-		return;
-
-	pcie_write_cmd_nowait(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
-			      PCI_EXP_SLTCTL_PIC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
-		 PCI_EXP_SLTCTL_PWR_IND_BLINK);
-}
-
 int pciehp_power_on_slot(struct controller *ctrl)
 {
 	struct pci_dev *pdev = ctrl_dev(ctrl);
-- 
2.21.0

