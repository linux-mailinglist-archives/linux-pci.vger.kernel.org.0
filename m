Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5A8A6721
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 13:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728883AbfICLKv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 07:10:51 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:42337 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbfICLKv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 07:10:51 -0400
Received: by mail-wr1-f67.google.com with SMTP id b16so16991381wrq.9;
        Tue, 03 Sep 2019 04:10:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uNN831oAcxJIf6qZK0bKvNkU4fX+CR0u9Z6WK9p3j/Y=;
        b=sq8N1Fha0022AHVDkqIwtk3foG4WLpFJSILS/jijJ4bzZ1+w8SL3D9TITuXQgJeWwu
         Cf7+Wyk1eFDEGDPYIc0uOQ3dQvdGiz0uOMq0BJ0lHhTIaEycBSZW5FHx6naHjNDUCFGE
         KP2dhDQhvRNoS75Zdm7Ee1lmCkKKP+iY9BQpGEnRPiVpwjKhyS7O2ZwwX4REYGi+3N5u
         qLfL0cxNvrUb3KV94DpNRplBSXiYf8TpYbx/Lo/MhPMBA0m9RiwIEufNNn3Fi8FleN2F
         0g6lNC01rTgYAKaXf25FISBMLCEem4Aa/2V06MC+kdqC6NMc4+eGt74orcwRwpDvrAgX
         zChg==
X-Gm-Message-State: APjAAAUdyhsK1NaxjjFpfdiSDfABYXobK4JgeVyPmwxr+tOlVbm18+7W
        eo5q+23K8vEsEM7BxtcwqBw=
X-Google-Smtp-Source: APXvYqzNyGzht6qwN8mEr0ZTZC6Gb/u9QgAk9j8A7nsnpaqmaiNK2LPY8hG+J+EtpYpFhNWCd2fLyQ==
X-Received: by 2002:adf:ee4a:: with SMTP id w10mr27197684wro.138.1567509049162;
        Tue, 03 Sep 2019 04:10:49 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id w12sm4363572wrg.47.2019.09.03.04.10.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:10:48 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 3/4] PCI: pciehp: Remove pciehp_set_attention_status()
Date:   Tue,  3 Sep 2019 14:10:20 +0300
Message-Id: <20190903111021.1559-4-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903111021.1559-1-efremov@linux.com>
References: <20190903111021.1559-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove pciehp_set_attention_status() and use pciehp_set_indicators()
instead, since the code is mostly the same.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp.h      |  1 -
 drivers/pci/hotplug/pciehp_core.c |  7 ++++++-
 drivers/pci/hotplug/pciehp_hpc.c  | 25 -------------------------
 include/uapi/linux/pci_regs.h     |  1 +
 4 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 0214e09e91a4..cf59f70a33cc 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -172,7 +172,6 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status);
 #define PCI_EXP_SLTCTL_PWR_IND_NONE  -1 /* Power Indicator noop */
 void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
 
-void pciehp_set_attention_status(struct controller *ctrl, u8 status);
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
 void pciehp_green_led_on(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 6ad0d86762cb..7a86ea90ed94 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -102,8 +102,13 @@ static int set_attention_status(struct hotplug_slot *hotplug_slot, u8 status)
 	struct controller *ctrl = to_ctrl(hotplug_slot);
 	struct pci_dev *pdev = ctrl->pcie->port;
 
+	if (status)
+		status <<= PCI_EXP_SLTCTL_ATTN_IND_SHIFT;
+	else
+		status = PCI_EXP_SLTCTL_ATTN_IND_OFF;
+
 	pci_config_pm_runtime_get(pdev);
-	pciehp_set_attention_status(ctrl, status);
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_NONE, status);
 	pci_config_pm_runtime_put(pdev);
 	return 0;
 }
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index d2c60d844d30..eeac2e704c75 100644
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
 void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
 {
 	u16 cmd = 0, mask = 0;
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f28e562d7ca8..de3e58afc564 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -591,6 +591,7 @@
 #define  PCI_EXP_SLTCTL_CCIE	0x0010	/* Command Completed Interrupt Enable */
 #define  PCI_EXP_SLTCTL_HPIE	0x0020	/* Hot-Plug Interrupt Enable */
 #define  PCI_EXP_SLTCTL_AIC	0x00c0	/* Attention Indicator Control */
+#define  PCI_EXP_SLTCTL_ATTN_IND_SHIFT 6      /* Attention Indicator shift */
 #define  PCI_EXP_SLTCTL_ATTN_IND_ON    0x0040 /* Attention Indicator on */
 #define  PCI_EXP_SLTCTL_ATTN_IND_BLINK 0x0080 /* Attention Indicator blinking */
 #define  PCI_EXP_SLTCTL_ATTN_IND_OFF   0x00c0 /* Attention Indicator off */
-- 
2.21.0

