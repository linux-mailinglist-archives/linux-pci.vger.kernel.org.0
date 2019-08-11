Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7623C89380
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 22:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726548AbfHKUAr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 16:00:47 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:41989 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHKUAq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 16:00:46 -0400
Received: by mail-pg1-f171.google.com with SMTP id t132so48418164pgb.9;
        Sun, 11 Aug 2019 13:00:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Y4XP7JAJyaimCnaOAIX3TqTCdrib5Ua49eEV4fQoIw=;
        b=iRghUUsUlooUioOUKK6nhun4hMVS0nvwiJkFHGsIgYDGA1wsXBVIOqgrZbUqX9k5l/
         xSbaEy7n/23xQKrwEaCEVjsB8WdXyuFm2uqTwZPZZNA/Vlvo+yDw/kcfKdyd4lS2Nsh4
         0Vy1aH5h/qo6+zA/cualIs2euOudB/VGef+1KmzUI8fjjuxBdZbV1Vws+/KWK5aYWBGw
         Ld4M8wPbC+foh4s9maXxBFlxMNd5gCJW8sYo7leYJ8Eoi1P/KJiBtV3tUNHLNgevfbjt
         hZeAk79lh/ESD+Pf7KtKwf2PFiSTDrwlhDVA9K8/d/wvsWz9UtaTEmyFoPDgbrtgb2xQ
         GQTg==
X-Gm-Message-State: APjAAAU7WJ2rh80DT6OhPKaui46/X9dhN1dDwsq5o2SOyx830ZHr9mHH
        Gu0oAmCgPGtdckYNmfnuXsRTd6Dx6C4=
X-Google-Smtp-Source: APXvYqy/2kOV9B5u3mzwwHoCnwEcO+tMQABwTQADTaADEBVlWhzWIUDDsz8x9YCzgiGkGmKVoLs5cQ==
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr19918219pjn.136.1565553646158;
        Sun, 11 Aug 2019 13:00:46 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id a3sm106119167pfc.70.2019.08.11.13.00.43
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 13:00:45 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Denis Efremov <efremov@linux.com>
Subject: [PATCH v2 4/4] PCI: pciehp: Replace pciehp_green_led_{on,off,blink}()
Date:   Sun, 11 Aug 2019 22:59:44 +0300
Message-Id: <20190811195944.23765-5-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811195944.23765-1-efremov@linux.com>
References: <20190811195944.23765-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch replaces pciehp_green_led_{on,off,blink}() with
pciehp_set_indicators().

Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp.h     | 12 ++++++++---
 drivers/pci/hotplug/pciehp_hpc.c | 36 --------------------------------
 2 files changed, 9 insertions(+), 39 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 9a2a2d0db9d2..6cdcb1ca561f 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -183,9 +183,6 @@ void pciehp_set_indicators(struct controller *ctrl,
 			   enum pciehp_indicator attn);
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
-void pciehp_green_led_on(struct controller *ctrl);
-void pciehp_green_led_off(struct controller *ctrl);
-void pciehp_green_led_blink(struct controller *ctrl);
 bool pciehp_card_present(struct controller *ctrl);
 bool pciehp_card_present_or_link_active(struct controller *ctrl);
 int pciehp_check_link_status(struct controller *ctrl);
@@ -202,6 +199,15 @@ int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 #define pciehp_set_attention_status(ctrl, status) \
 	pciehp_set_indicators(ctrl, PWR_NONE, (status == 0 ? ATTN_OFF : status))
 
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
index fb4bea16063a..8362d24405fd 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -456,42 +456,6 @@ void pciehp_set_indicators(struct controller *ctrl,
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

