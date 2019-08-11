Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7FA568937B
	for <lists+linux-pci@lfdr.de>; Sun, 11 Aug 2019 22:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbfHKUAa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 11 Aug 2019 16:00:30 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42171 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbfHKUAa (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 11 Aug 2019 16:00:30 -0400
Received: by mail-pl1-f194.google.com with SMTP id ay6so47114137plb.9;
        Sun, 11 Aug 2019 13:00:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LaIHh46yjXhfCVkLKVS3bPQlaeFndy0Zcw4KFCKa1iU=;
        b=Bz+YIOqAaYOrkb/3r7eTtEKFWEqvRJ3vTUSS714NuwgRWwPvn7qXn4kd2WAN82qwTv
         bi1wNeaPwSf7ZApu1s3d87908FR/0Ky6ruLnVcMex6hz9j+r0ZP6hbCA1kfYIPnPPk8R
         jx2ZDrA+lA0YM8/r993pVKY83kwlPDkuPEaNJOXzzO5Xz4+nJM38BQ3ODcidWZEgZPcp
         FMEFTHMTVxvp1qXvt6rZ+89s0cUE5l+cgzxaAPQf3k0y+TGonKVV+6bOqa9R1oax3tIm
         Rta5xdG7NZ26alKUpSdLAZP4CL2V/MmClAOoOUi0hKHUWvyUuR02weAMpq13ICAZwrCs
         QQFQ==
X-Gm-Message-State: APjAAAWoJpKkaAUzH8RCiW2+7wO1aKeTzzS7MQH8/S0fSdm4qsF/PUfB
        K7KAPvvUS+V0/h+3zIw9jV+BzkEBWa8=
X-Google-Smtp-Source: APXvYqxPjVz4NOLh+Qxw44GOKy7UZl/eZMA82WZab2BQPfq00c333jbggWy/UzGrHO7FdXBP6WRerQ==
X-Received: by 2002:a17:902:b212:: with SMTP id t18mr23071753plr.246.1565553629863;
        Sun, 11 Aug 2019 13:00:29 -0700 (PDT)
Received: from localhost.localdomain (broadband-188-32-48-208.ip.moscow.rt.ru. [188.32.48.208])
        by smtp.googlemail.com with ESMTPSA id a3sm106119167pfc.70.2019.08.11.13.00.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Aug 2019 13:00:29 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Lukas Wunner <lukas@wunner.de>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, Denis Efremov <efremov@linux.com>
Subject: [PATCH v2 2/4] PCI: pciehp: Switch LED indicators with a single write
Date:   Sun, 11 Aug 2019 22:59:42 +0300
Message-Id: <20190811195944.23765-3-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190811195944.23765-1-efremov@linux.com>
References: <20190811195944.23765-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch replaces all consecutive switches of power and attention
indicators with pciehp_set_indicators() call. Thus, performing only
single write to a register.

Reviewed-by: Lukas Wunner <lukas@wunner.de>
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
index 5a690b1579ec..68b880bc30db 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -676,8 +676,7 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
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

