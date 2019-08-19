Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28ED694971
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 18:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727820AbfHSQH0 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 12:07:26 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33474 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbfHSQHZ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 12:07:25 -0400
Received: by mail-wm1-f65.google.com with SMTP id p77so364398wme.0;
        Mon, 19 Aug 2019 09:07:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6fBWOoTnMQEPZRIQlIOv38c83RVBeb0n7h4D/lIFHhY=;
        b=QUTxfzt1MvbfVJA8m2pLbG0PBLVn9Tmwy5QaYRW/smRvrCVMrYG8YZq9j7xODUKPfu
         nkIRZsBml0ss8OHpFt66a+mWXdOgeuor8KVdiNJ1JRmYCg1E3gZriesyawcz7UyWE/q7
         yeAwAAvDRhTtY0WLhYeI0nxbJOsuaCmDnGLDHYxxB/oYno5GB/z7Byq1iY+4N431WQ+z
         gC3Aq0UrvLMia9j65Uf0xYdCbnMEM6cmRy0IFE4qt2ptp/5Bl8p3+7bHpP0IM+KH9tfK
         DwWo6FtaijKzjjgyh30pamHXeALbISLtQCkomcNOVXaNjv5AUEmodw49OTE4fV9PSxqS
         3Gnw==
X-Gm-Message-State: APjAAAVR0k9ngHSkJV3vRCHdlpHDmo7Fu+kKAK1yMBWmplAAKLjOROtk
        l2TF/TcgQOyaFWZyAbaLxDUt+Bqd
X-Google-Smtp-Source: APXvYqyy3iunIi0iSV/oXYaYrEvGxgsax9NxRmtX3rcCpjL6tpqGEsS55kbdXozMOm+VfpzCBFzkCQ==
X-Received: by 2002:a1c:5402:: with SMTP id i2mr21261549wmb.41.1566230843726;
        Mon, 19 Aug 2019 09:07:23 -0700 (PDT)
Received: from green.intra.ispras.ru (bran.ispras.ru. [83.149.199.196])
        by smtp.googlemail.com with ESMTPSA id b136sm32442189wme.18.2019.08.19.09.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2019 09:07:23 -0700 (PDT)
From:   Denis Efremov <efremov@linux.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Denis Efremov <efremov@linux.com>, Lukas Wunner <lukas@wunner.de>,
        sathyanarayanan kuppuswamy 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] PCI: pciehp: Switch LED indicators with a single write
Date:   Mon, 19 Aug 2019 19:06:41 +0300
Message-Id: <20190819160643.27998-3-efremov@linux.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190819160643.27998-1-efremov@linux.com>
References: <20190819160643.27998-1-efremov@linux.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch replaces all consecutive switches of power and attention
indicators with pciehp_set_indicators() call. Thus, performing only
single write to a register.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Lukas Wunner <lukas@wunner.de>
Signed-off-by: Denis Efremov <efremov@linux.com>
---
 drivers/pci/hotplug/pciehp_ctrl.c | 19 ++++++++++---------
 drivers/pci/hotplug/pciehp_hpc.c  |  4 ++--
 2 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index 631ced0ab28a..232f7bfcfce9 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -42,8 +42,8 @@ static void set_slot_off(struct controller *ctrl)
 		msleep(1000);
 	}
 
-	pciehp_green_led_off(ctrl);
-	pciehp_set_attention_status(ctrl, 1);
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+			      PCI_EXP_SLTCTL_ATTN_IND_ON);
 }
 
 /**
@@ -90,8 +90,8 @@ static int board_added(struct controller *ctrl)
 		}
 	}
 
-	pciehp_green_led_on(ctrl);
-	pciehp_set_attention_status(ctrl, 0);
+	pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
+			      PCI_EXP_SLTCTL_ATTN_IND_OFF);
 	return 0;
 
 err_exit:
@@ -172,8 +172,8 @@ void pciehp_handle_button_press(struct controller *ctrl)
 				  slot_name(ctrl));
 		}
 		/* blink green LED and turn off amber */
-		pciehp_green_led_blink(ctrl);
-		pciehp_set_attention_status(ctrl, 0);
+		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_BLINK,
+				      PCI_EXP_SLTCTL_ATTN_IND_OFF);
 		schedule_delayed_work(&ctrl->button_work, 5 * HZ);
 		break;
 	case BLINKINGOFF_STATE:
@@ -187,12 +187,13 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		cancel_delayed_work(&ctrl->button_work);
 		if (ctrl->state == BLINKINGOFF_STATE) {
 			ctrl->state = ON_STATE;
-			pciehp_green_led_on(ctrl);
+			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_ON,
+					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
 		} else {
 			ctrl->state = OFF_STATE;
-			pciehp_green_led_off(ctrl);
+			pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+					      PCI_EXP_SLTCTL_ATTN_IND_OFF);
 		}
-		pciehp_set_attention_status(ctrl, 0);
 		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
 			  slot_name(ctrl));
 		break;
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 5474b9854a7f..aa4252d11be2 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -667,8 +667,8 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
 		ctrl->power_fault_detected = 1;
 		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
-		pciehp_set_attention_status(ctrl, 1);
-		pciehp_green_led_off(ctrl);
+		pciehp_set_indicators(ctrl, PCI_EXP_SLTCTL_PWR_IND_OFF,
+				      PCI_EXP_SLTCTL_ATTN_IND_ON);
 	}
 
 	/*
-- 
2.21.0

