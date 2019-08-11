Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D1FC88937E
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 22:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfHKUAl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 16:00:41 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:41390 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHKUAl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 16:00:41 -0400
Received: by mail-pf1-f174.google.com with SMTP id 196so1507427pfz.8;
        Sun, 11 Aug 2019 13:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5zwYEn0EGzt3ihkxPgMtY2Od6wvLZC2PAG88t/1eLAc=;
        b=D7LlZQNh+4MZhCONrQMAPloInd984ahOAboAGxmzKNSGN1Lb/cCV/2EfWS41kkZcOs
         IyuhdoNhhk+ZVBQoVo1PK1z1dSMK5GfacWn90xlxFK7dbN25K88DJFy1Amy/3YmwkhJ7
         DqeLzb3fn3/bIYwalqJXPBVy/mpS4gD0hMy7078PEHfVFG2ohuAM9XVCKHh4u0lE50O7
         26+K9A0iKCTL81jccdFkE+HOhcVog2pKCqpxMZNmpSFd5EfodsO927WPDPyy/DuenLVG
         P1qgk3RbCHZ+kr/yRUVUUflZBIvVc2Vdcg9FwyRbId7uGL92MZq7gq4rf4Fn+33K3oX9
         1K0Q==
X-Gm-Message-State: APjAAAVV6FaHDRNdkR/SZTEPTKRRA5f4TRGo77YzUJ36aSazQhSaiA3i
        zAcinEvpi7BIXN2b6IzZQ9gup5aTW5o=
X-Google-Smtp-Source: APXvYqyuBGml8pVT7eEjOB9MThSHpZaDW38yhInYfo3vi3m6W7OZTwZ2XxKmlsZmzk6CcWmbQkgwvg==
X-Received: by 2002:a65:514c:: with SMTP id g12mr27364662pgq.76.1565553640938;
        Sun, 11 Aug 2019 13:00:40 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id a3sm106119167pfc.70.2019.08.11.13.00.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 13:00:40 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Denis Efremov <efremov@linux.com>
Subject: [PATCH v2 3/4] PCI: pciehp: Replace pciehp_set_attention_status()
Date:   Sun, 11 Aug 2019 22:59:43 +0300
Message-Id: <20190811195944.23765-4-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811195944.23765-1-efremov@linux.com>
References: <20190811195944.23765-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch replaces pciehp_set_attention_status() with
pciehp_set_indicators().

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp.h     |  4 +++-
 drivers/pci/hotplug/pciehp_hpc.c | 25 -------------------------
 2 files changed, 3 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 17305a6f01f1..9a2a2d0db9d2 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -181,7 +181,6 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status);
 void pciehp_set_indicators(struct controller *ctrl,
 			   enum pciehp_indicator pwr,
 			   enum pciehp_indicator attn);
-void pciehp_set_attention_status(struct controller *ctrl, u8 status);
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
 void pciehp_green_led_on(struct controller *ctrl);
@@ -200,6 +199,9 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
+#define pciehp_set_attention_status(ctrl, status) \
+	pciehp_set_indicators(ctrl, PWR_NONE, (status == 0 ? ATTN_OFF : status))
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 68b880bc30db..fb4bea16063a 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -418,31 +418,6 @@ int pciehp_set_raw_indicator_status(struct hotplug_slot *hotplug_slot,
 	return 0;
 }
 
-void pciehp_set_attention_status(struct controller *ctrl, u8 value)
-{
-	u16 slot_cmd;
-
-	if (!ATTN_LED(ctrl))
-		return;
-
-	switch (value) {
-	case 0:		/* turn off */
-		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_OFF;
-		break;
-	case 1:		/* turn on */
-		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_ON;
-		break;
-	case 2:		/* turn blink */
-		slot_cmd = PCI_EXP_SLTCTL_ATTN_IND_BLINK;
-		break;
-	default:
-		return;
-	}
-	pcie_write_cmd_nowait(ctrl, slot_cmd, PCI_EXP_SLTCTL_AIC);
-	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
-		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
-}
-
 void pciehp_set_indicators(struct controller *ctrl,
 			   enum pciehp_indicator pwr,
 			   enum pciehp_indicator attn)
-- 
2.21.0

