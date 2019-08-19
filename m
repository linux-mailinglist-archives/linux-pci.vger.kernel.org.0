Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2572594975
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 18:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfHSQHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 12:07:33 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43394 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727865AbfHSQH3 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 12:07:29 -0400
Received: by mail-wr1-f65.google.com with SMTP id y8so9283962wrn.10;
        Mon, 19 Aug 2019 09:07:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J6GaCUg1JsCqoVd2udtQCNNU0NqEG0Fb+1qaGVREJyo=;
        b=LRCU/hIqszhr6EsL6Urrdq95c1haUOd4X8p+Xnry9Fjn3xVnHKvp4uQiZ6hRGjHO2L
         Uzgq08TzjwmEFCozs5IFFD0mzipQYZZHDVLYIKSU7NC6HGXW8LZv6Et4RMAi4BsXk3MH
         CiawXsYuKo19Nl0RmWQZsh73s3Z2g/cvPmGkuBD4UzXcgPlKeDIZXbp3Wp75sOdRqyjz
         YTqSh9gslENP1ituEhufEl07GFFhAAPmSR8zbO8E/TbsbkEgVSCsgNMVMRerdzpCBxOL
         mQQSykhsNJKC3CqpKBz5yvb97Qv8FGpbfuc6wYIhp+EIOxmRgZY3u6+/UqzMIONS5QBB
         g1SQ==
X-Gm-Message-State: APjAAAVPJjBrVLPFN1BBHLzzk0gdXYQwDL21e8PJxjuDz6J/vZp9qau2
        v4DQ9OOypL+1PQdYQMg53OU=
X-Google-Smtp-Source: APXvYqxxA9WgM8LziEo1y//g/56kvEfbFae6gbGgxCszx/RG7LMfuEvwuvK8rlniYbHxTAco8T5Mvw==
X-Received: by 2002:adf:ce8d:: with SMTP id r13mr20854901wrn.37.1566230847978;
        Mon, 19 Aug 2019 09:07:27 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id b136sm32442189wme.18.2019.08.19.09.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 09:07:27 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Lukas Wunner <lukas@wunner.de>,
        sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] PCI: pciehp: Remove pciehp_green_led_{on,off,blink}()
Date:   Mon, 19 Aug 2019 19:06:43 +0300
Message-Id: <20190819160643.27998-5-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819160643.27998-1-efremov@linux.com>
References: <20190819160643.27998-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove pciehp_green_led_{on,off,blink}() and use pciehp_set_indicators()
instead, since the code is mostly the same.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp.h      |  3 ---
 drivers/pci/hotplug/pciehp_ctrl.c | 12 ++++++++---
 drivers/pci/hotplug/pciehp_hpc.c  | 36 -------------------------------
 3 files changed, 9 insertions(+), 42 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index acda513f37d7..da429345cf70 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -170,9 +170,6 @@ void pciehp_get_power_status(struct controller *ctrl, u8 *status);
 void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn);
 void pciehp_get_latch_status(struct controller *ctrl, u8 *status);
 int pciehp_query_power_fault(struct controller *ctrl);
-void pciehp_green_led_on(struct controller *ctrl);
-void pciehp_green_led_off(struct controller *ctrl);
-void pciehp_green_led_blink(struct controller *ctrl);
 bool pciehp_card_present(struct controller *ctrl);
 bool pciehp_card_present_or_link_active(struct controller *ctrl);
 int pciehp_check_link_status(struct controller *ctrl);
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 232f7bfcfce9..862fe86e87cc 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -65,7 +65,9 @@ static int board_added(struct controller *ctrl)
 			return retval;
 	}
 
-	pciehp_green_led_blink(ctrl);
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
+			      PCI_EXP_SLTCTL_ATTN_IND_NONE);
+
 
 	/* Check link training status */
 	retval = pciehp_check_link_status(ctrl);
@@ -124,7 +126,9 @@ static void remove_board(struct controller *ctrl, bool safe_removal)
 	}
 
 	/* turn off Green LED */
-	pciehp_green_led_off(ctrl);
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+			      PCI_EXP_SLTCTL_ATTN_IND_NONE);
+
 }
 
 static int pciehp_enable_slot(struct controller *ctrl);
@@ -311,7 +315,9 @@ static int pciehp_enable_slot(struct controller *ctrl)
 	pm_runtime_get_sync(&ctrl->pcie->port->dev);
 	ret = __pciehp_enable_slot(ctrl);
 	if (ret && ATTN_BUTTN(ctrl))
-		pciehp_green_led_off(ctrl); /* may be blinking */
+		/* may be blinking */
+		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+				      PCI_EXP_SLTCTL_ATTN_IND_NONE);
 	pm_runtime_put(&ctrl->pcie->port->dev);
 
 	mutex_lock(&ctrl->state_lock);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 8f894fd5cd27..9dc1ecd703b9 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -447,42 +447,6 @@ void pciehp_set_indicators(struct controller *ctrl, int pwr, int attn)
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

