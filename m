Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66266891DA
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 15:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfHKNaD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 09:30:03 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:35787 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfHKNaD (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 09:30:03 -0400
Received: by mail-wr1-f67.google.com with SMTP id k2so16451854wrq.2;
        Sun, 11 Aug 2019 06:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G7RJjZKxRQxu4CimQzXCh68b+FLqre0DDDhafOZHiPs=;
        b=L2R4Vy4amndPV5w5qdiaTxE4lgNiT32vGto98AsuciwyPUx8m2pI7Sa3kDidzXaKBP
         XC0ZFtvChEkMnA5eQGdbQKjXugJE8hH0GfGEczDmCf4qt7WPonJ3+KZ7MFaQxg5BdZM/
         YnJnfysQAPl3QGEkqaDqjPR8gdSYX07xwMJa+hiMgiaF7hNnclh4zKllCmkCJUjn/Qp0
         g2xyQ2SHc0FFKCohZjzwMtmHDEABJhiAUp5Wmac5oWxue+ChsXB3x7C/IS6co5g4+5Tp
         ViWsWP70q7/3xJSwCG740dWVcpeFHEb1tvQH+3Ze2z5B7wG7eAYKdL87e4eRePzQSCMY
         IK0w==
X-Gm-Message-State: APjAAAUmAtbZhjuA9zPC2asRlVFu4Afr8QuOQmbuVzakV4Ejyhl0P6jL
        E8tSfxRh/RfKWiyV46mQ608PnxBc
X-Google-Smtp-Source: APXvYqz/IB6kwmeqzNMf2TlZgBeUQeqVzzT5hh8T5VV/UUob8b0rIYCl2J88EdKM1vYHPO7aj3JS8Q==
X-Received: by 2002:a5d:4284:: with SMTP id k4mr31260226wrq.6.1565530201178;
        Sun, 11 Aug 2019 06:30:01 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id o16sm13781463wrp.23.2019.08.11.06.30.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 06:30:00 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Denis Efremov <efremov@linux.com>
Subject: [PATCH 2/4] PCI: pciehp: Switch LED indicators with a single write
Date:   Sun, 11 Aug 2019 16:29:43 +0300
Message-Id: <20190811132945.12426-3-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811132945.12426-1-efremov@linux.com>
References: <20190811132945.12426-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch replaces all consecutive switches of power and attention
indicators with pciehp_set_indicators() call. Thus, performing only
single write to a register.

Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 14 +++++---------
 drivers/pci/hotplug/pciehp_hpc.c  |  3 +--
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 631ced0ab28a..258a4060466d 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -42,8 +42,7 @@ static void set_slot_off(struct controller *ctrl)
 		msleep(1000);
 	}
 
-	pciehp_green_led_off(ctrl);
-	pciehp_set_attention_status(ctrl, 1);
+	pciehp_set_indicators(ctrl, PWR_OFF, ATTN_ON);
 }
 
 /**
@@ -90,8 +89,7 @@ static int board_added(struct controller *ctrl)
 		}
 	}
 
-	pciehp_green_led_on(ctrl);
-	pciehp_set_attention_status(ctrl, 0);
+	pciehp_set_indicators(ctrl, PWR_ON, ATTN_OFF);
 	return 0;
 
 err_exit:
@@ -172,8 +170,7 @@ void pciehp_handle_button_press(struct controller *ctrl)
 				  slot_name(ctrl));
 		}
 		/* blink green LED and turn off amber */
-		pciehp_green_led_blink(ctrl);
-		pciehp_set_attention_status(ctrl, 0);
+		pciehp_set_indicators(ctrl, PWR_BLINK, ATTN_OFF);
 		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
 		break;
 	case BLINKINGOFF_STATE:
@@ -187,12 +184,11 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		cancel_delayed_work(&ctrl->button_work);
 		if (ctrl->state == BLINKINGOFF_STATE) {
 			ctrl->state = ON_STATE;
-			pciehp_green_led_on(ctrl);
+			pciehp_set_indicators(ctrl, PWR_ON, ATTN_OFF);
 		} else {
 			ctrl->state = OFF_STATE;
-			pciehp_green_led_off(ctrl);
+			pciehp_set_indicators(ctrl, PWR_OFF, ATTN_OFF);
 		}
-		pciehp_set_attention_status(ctrl, 0);
 		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
 			  slot_name(ctrl));
 		break;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 027e3864f632..e90cb2152e8f 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -687,8 +687,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
 		ctrl->power_fault_detected = 1;
 		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
-		pciehp_set_attention_status(ctrl, 1);
-		pciehp_green_led_off(ctrl);
+		pciehp_set_indicators(ctrl, PWR_OFF, ATTN_ON);
 	}
 
 	/*
-- 
2.21.0

