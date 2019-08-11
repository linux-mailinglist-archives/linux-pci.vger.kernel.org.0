Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F52389379
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 22:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfHKUAW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 16:00:22 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33094 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHKUAW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 16:00:22 -0400
Received: by mail-pg1-f195.google.com with SMTP id n190so7611704pgn.0;
        Sun, 11 Aug 2019 13:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DEOH8uNw8KONdKDvi8Ngr/ONfB9Xs89RwTe8hFQNqvU=;
        b=pU7yyIPTuFUVuvCg1SOtUJsfORkS9JxdoHkqEYHNMscPkcC2o2ZmqMCiBu6RCXn+YZ
         81XQz4V8NpPuKAFMKI+DMGlC3CUKDlgo9wAciDj41GWiIwCP+gCkcP0vXvh/ZoqlZ54l
         JwhwRzeQ9Zmk4HvCOCs5QGah/pDXKgYl+NsJfRxG/LVNWvZkGUodj8II+g+Fehg8sSJz
         9QTgLo5jMPh0AL1VzoY0v/KJNJF5jpUoeftfQ2Hv3CWDDySr05k5E4WnCASOc4w/jMsd
         iu/ONGMeGaC/Bcgz1WFrrDakw9bGMJbf7U2rcGDZm578g+n8m7dXt50cwXsexwc7Fu2x
         2U5Q==
X-Gm-Message-State: APjAAAWreiVgNCsx6rzMZyDsCtzLr+WwkwoAMyTYovZQX2c6GhfS+mCi
        xR+DAxKkXfvjmwNfj2doHAk=
X-Google-Smtp-Source: APXvYqzco74I4qFZOTePjWYhTdcpMFGA/ix5uvj8pCG8UgmR6wgLubXkXNhuG/GoofPTLHNJ2CGkhA==
X-Received: by 2002:a65:4243:: with SMTP id d3mr15454210pgq.119.1565553621358;
        Sun, 11 Aug 2019 13:00:21 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id a3sm106119167pfc.70.2019.08.11.13.00.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 13:00:20 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Denis Efremov <efremov@linux.com>
Subject: [PATCH v2 1/4] PCI: pciehp: Add pciehp_set_indicators() to jointly set LED indicators
Date:   Sun, 11 Aug 2019 22:59:41 +0300
Message-Id: <20190811195944.23765-2-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811195944.23765-1-efremov@linux.com>
References: <20190811195944.23765-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pciehp_set_indicators() to set power and attention indicators with a
single register write. Thus, avoiding waiting twice for Command Complete.
enum pciehp_indicator introduced to switch between the indicators statuses.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp.h     | 14 ++++++++++++
 drivers/pci/hotplug/pciehp_hpc.c | 38 ++++++++++++++++++++++++++++++++
 include/uapi/linux/pci_regs.h    |  2 ++
 3 files changed, 54 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 8c51a04b8083..17305a6f01f1 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -150,6 +150,17 @@ struct controller {
 #define NO_CMD_CMPL(ctrl)	((ctrl)->slot_cap & PCI_EXP_SLTCAP_NCCS)
 #define PSN(ctrl)		(((ctrl)->slot_cap & PCI_EXP_SLTCAP_PSN) >> 19)
 
+enum pciehp_indicator {
+	ATTN_NONE  = -1,
+	ATTN_ON    =  1,
+	ATTN_BLINK =  2,
+	ATTN_OFF   =  3,
+	PWR_NONE   = -1,
+	PWR_ON     =  1,
+	PWR_BLINK  =  2,
+	PWR_OFF    =  3,
+};
+
 void pciehp_request(struct controller *ctrl, int action);
 void pciehp_handle_button_press(struct controller *ctrl);
 void pciehp_handle_disable_request(struct controller *ctrl);
@@ -167,6 +178,9 @@ int pciehp_power_on_slot(struct controller *ctrl);
 void pciehp_power_off_slot(struct controller *ctrl);
 void pciehp_get_power_status(struct controller *ctrl, u8 *status);
 
+void pciehp_set_indicators(struct controller *ctrl,
+			   enum pciehp_indicator pwr,
+			   enum pciehp_indicator attn);
 void pciehp_set_attention_status(struct controller *ctrl, u8 status);
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index bd990e3371e3..5a690b1579ec 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -443,6 +443,44 @@ void pciehp_set_attention_status(struct controller *ctrl, u8 value)
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, slot_cmd);
 }
 
+void pciehp_set_indicators(struct controller *ctrl,
+			   enum pciehp_indicator pwr,
+			   enum pciehp_indicator attn)
+{
+	u16 cmd = 0, mask = 0;
+
+	if ((!PWR_LED(ctrl)  || pwr  == PWR_NONE) &&
+	    (!ATTN_LED(ctrl) || attn == ATTN_NONE))
+		return;
+
+	switch (pwr) {
+	case PWR_ON:
+	case PWR_BLINK:
+	case PWR_OFF:
+		cmd = pwr << PCI_EXP_SLTCTL_PWR_IND_OFFSET;
+		mask = PCI_EXP_SLTCTL_PIC;
+		break;
+	default:
+		break;
+	}
+
+	switch (attn) {
+	case ATTN_ON:
+	case ATTN_BLINK:
+	case ATTN_OFF:
+		cmd |= attn << PCI_EXP_SLTCTL_ATTN_IND_OFFSET;
+		mask |= PCI_EXP_SLTCTL_AIC;
+		break;
+	default:
+		break;
+	}
+
+	pcie_write_cmd_nowait(ctrl, cmd, mask);
+	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
+		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL,
+		 cmd);
+}
+
 void pciehp_green_led_on(struct controller *ctrl)
 {
 	if (!PWR_LED(ctrl))
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index f28e562d7ca8..18722d1f54a0 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -591,10 +591,12 @@
 #define  PCI_EXP_SLTCTL_CCIE	0x0010	/* Command Completed Interrupt Enable */
 #define  PCI_EXP_SLTCTL_HPIE	0x0020	/* Hot-Plug Interrupt Enable */
 #define  PCI_EXP_SLTCTL_AIC	0x00c0	/* Attention Indicator Control */
+#define  PCI_EXP_SLTCTL_ATTN_IND_OFFSET 0x6   /* Attention Indicator Offset */
 #define  PCI_EXP_SLTCTL_ATTN_IND_ON    0x0040 /* Attention Indicator on */
 #define  PCI_EXP_SLTCTL_ATTN_IND_BLINK 0x0080 /* Attention Indicator blinking */
 #define  PCI_EXP_SLTCTL_ATTN_IND_OFF   0x00c0 /* Attention Indicator off */
 #define  PCI_EXP_SLTCTL_PIC	0x0300	/* Power Indicator Control */
+#define  PCI_EXP_SLTCTL_PWR_IND_OFFSET 0x8    /* Power Indicator Offset */
 #define  PCI_EXP_SLTCTL_PWR_IND_ON     0x0100 /* Power Indicator on */
 #define  PCI_EXP_SLTCTL_PWR_IND_BLINK  0x0200 /* Power Indicator blinking */
 #define  PCI_EXP_SLTCTL_PWR_IND_OFF    0x0300 /* Power Indicator off */
-- 
2.21.0

