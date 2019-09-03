Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36235A671F
	for <lists+linux-pci@lfdr.de>; Tue,  3 Sep 2019 13:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728933AbfICLLB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Sep 2019 07:11:01 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:52547 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728838AbfICLLA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Sep 2019 07:11:00 -0400
Received: by mail-wm1-f65.google.com with SMTP id t17so17682144wmi.2;
        Tue, 03 Sep 2019 04:10:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ePgnJvYxWrV7sbrqetU6IzX5b2sFn8WAvNr4Gv1qEEY=;
        b=eTEr/b6xMARK2Q0RJnEx0VVL5NpE+UXXxzu/3e4BWK5LJ5kHx1HstvSyAGklpZPTCS
         cOmQahq0vDY2GWzos6p9mtdvdwTbXCAkJGZ39v91EYwY3MDyORY44E1uU3JKUsOZbQ72
         KjsvEWmShjmQQbtyDxdpscVVaRtnZatfX1RU08lelAPaMRCtJ0o/v9QIp0PFUAvciMWD
         6F38Ya+pCnzT014tAP3jv4lsMilkiPlbXP4IG6aCM8X1SXeKME6dzyDNxlosV4wLZB33
         qZLFNhq4Ihy3GyLwM0AnRc72deMh/GYEm6ZwZlvREQE94/Ops7nEDpXvDhIcdJvGFhyL
         5DZQ==
X-Gm-Message-State: APjAAAVDVdzcTy5vao0/x0GiOt/C/bPaPKJO7aW7SoewG1VnDGldmJWE
        2L9disuboLDTJnmO4A+efdg=
X-Google-Smtp-Source: APXvYqyTBFtV0K2tErOWmuzozNDfw2iFPVwjisLK5ZPWLkUGePsJBVCM4L9CwkC4fG9ToooS8qvT6w==
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr44727496wmc.115.1567509059271;
        Tue, 03 Sep 2019 04:10:59 -0700 (PDT)
Received: from black.home (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id w12sm4363572wrg.47.2019.09.03.04.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2019 04:10:58 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Lukas Wunner <lukas@wunner.de>,
        linux-pci@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Oliver O'Halloran <oohall@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/4] PCI: pciehp: Remove pciehp_green_led_{on,off,blink}()
Date:   Tue,  3 Sep 2019 14:10:21 +0300
Message-Id: <20190903111021.1559-5-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190903111021.1559-1-efremov@linux.com>
References: <20190903111021.1559-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove pciehp_green_led_{on,off,blink}() and use pciehp_set_indicators()
instead, since the code is mostly the same.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp.h      |  6 +++---
 drivers/pci/hotplug/pciehp_ctrl.c |  7 +++---
 drivers/pci/hotplug/pciehp_hpc.c  | 36 -------------------------------
 3 files changed, 7 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index cf59f70a33cc..dcbf790b7508 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -174,9 +174,6 @@ void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
 
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
-void pciehp_green_led_on(struct controller *ctrl);
-void pciehp_green_led_off(struct controller *ctrl);
-void pciehp_green_led_blink(struct controller *ctrl);
 bool pciehp_card_present(struct controller *ctrl);
 bool pciehp_card_present_or_link_active(struct controller *ctrl);
 int pciehp_check_link_status(struct controller *ctrl);
@@ -190,6 +187,9 @@ int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
 int pciehp_get_raw_indicator_status(struct hotplug_slot *h_slot, u8 *status);
 
+#define set_power_indicator(ctrl, x) \
+	pciehp_set_indicators(ctrl, (x), PCI_EXP_SLTCTL_ATTN_IND_NONE)
+
 static inline const char *slot_name(struct controller *ctrl)
 {
 	return hotplug_slot_name(&ctrl->hotplug_slot);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 232f7bfcfce9..d0f55f695770 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -65,7 +65,7 @@ static int board_added(struct controller *ctrl)
 			return retval;
 	}
 
-	pciehp_green_led_blink(ctrl);
+	set_power_indicator(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK);
 
 	/* Check link training status */
 	retval = pciehp_check_link_status(ctrl);
@@ -124,7 +124,7 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
 	}
 
 	/* turn off Green LED */
-	pciehp_green_led_off(ctrl);
+	set_power_indicator(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF);
 }
 
 static int pciehp_enable_slot(struct controller *ctrl);
@@ -311,7 +311,8 @@ static int pciehp_enable_slot(struct controller *ctrl)
 	pm_runtime_get_sync(&ctrl->pcie->port->dev);
 	ret = __pciehp_enable_slot(ctrl);
 	if (ret && ATTN_BUTTN(ctrl))
-		pciehp_green_led_off(ctrl); /* may be blinking */
+		/* may be blinking */
+		set_power_indicator(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF);
 	pm_runtime_put(&ctrl->pcie->port->dev);
 
 	mutex_lock(&ctrl->state_lock);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index eeac2e704c75..9fd8f99132bb 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -439,42 +439,6 @@ void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
 	}
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

