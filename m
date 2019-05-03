Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E58211269D
	for <lists+linux-pci@lfdr.de>; Fri,  3 May 2019 06:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbfECEAj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 May 2019 00:00:39 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34807 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbfECEAi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 3 May 2019 00:00:38 -0400
Received: by mail-ot1-f67.google.com with SMTP id n15so4176000ota.1
        for <linux-pci@vger.kernel.org>; Thu, 02 May 2019 21:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fredlawl-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fQTfIhLtolzo7NGl6+w85L74CyrcJ2T1el+EJtuAO/g=;
        b=eNQUOsV3p1S5rw9tyuQYQJfwZEwUcT3UzHbe0jfAgqpyBxsmOezGdM7Yj+9eCWnEgj
         rKEehdR39u9F87bBjLDT7wqIvIA0lzKQ6h1hNmBDwfiqsRS0ixkExaXOAy+lVq5Xritg
         fFuNh/VgytsD7zz1nnXbms79n+Ha8NZmTdlCmUGGtry6tAVt5lY1V4xipyz4nc3EhJph
         5UVbmOsXQCuetOg66HUBJwf944d4osycnUtU39X0U60LsITcnE03kp7qUHx63QbBAo8P
         xp3V05HvAZZ5fHxZFDmp48OrnI36k1By6ommCwkG+GCzA9vl9048VzLS03x3okLRzqAT
         PmFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fQTfIhLtolzo7NGl6+w85L74CyrcJ2T1el+EJtuAO/g=;
        b=JyepWHlP7sqdMFA4TZEaRsjnDrmPJ/n8pwu+cD7plkEkgcawrem/sB7CA3haD9zm2z
         S7c/MKqjptyXrSsMpRy0SXK7dDb7cfbH6qGHOpOyZi4Pl0rR6/LncfPsIy0FoWei9kVP
         QVBYwZZXDhRam+22sILNjRidloC24r4wwokrBbH5HaraR4ancgHTUhEqBkOwlzOeh+fR
         jMWWVQ5/Lzi2Cm8sXFTYSRWtFskCjzUa88AObSfHYhWML3oj18C0pdEw+XfXuk4zuepE
         1XMt2wgFuV0+2Nq0SeGg4SH2tTRYDmiUa4h2yxloEBRpI2jC+B1p+HRznEBWd/WzZ3lh
         2zNw==
X-Gm-Message-State: APjAAAW+3pASkK2baak6wsv8+c/a2mcRdjC4V/dqtsmKxiATQ1yVOGGi
        HZReWose91nGNTt2AgBZGMUC+A==
X-Google-Smtp-Source: APXvYqyoZGrcpyztZBaHHgeAY4Ciqk3pTinXMmDdZpwdAJ2/iufAVMAvv38SM30cDZDYpZcDx+4v4g==
X-Received: by 2002:a9d:4ef:: with SMTP id 102mr5389441otm.302.1556856037677;
        Thu, 02 May 2019 21:00:37 -0700 (PDT)
Received: from linux.fredlawl.com ([2600:1700:18a0:11d0:5518:38b8:ef25:393a])
        by smtp.gmail.com with ESMTPSA id q82sm614742oif.28.2019.05.02.21.00.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 May 2019 21:00:36 -0700 (PDT)
From:   Frederick Lawler <fred@fredlawl.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        mika.westerberg@linux.intel.com, lukas@wunner.de,
        andriy.shevchenko@linux.intel.com, keith.busch@intel.com,
        mr.nuke.me@gmail.com, liudongdong3@huawei.com, thesven73@gmail.com,
        Frederick Lawler <fred@fredlawl.com>
Subject: [PATCH v2 9/9] PCI: hotplug: Prefix ctrl_*() dmesg logs with pciehp slot name
Date:   Thu,  2 May 2019 22:59:46 -0500
Message-Id: <20190503035946.23608-10-fred@fredlawl.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190503035946.23608-1-fred@fredlawl.com>
References: <20190503035946.23608-1-fred@fredlawl.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove current uses of "Slot(%s)" and then prefix ctrl_*() dmesg
with pciehp slot name to include the slot name for all uses of ctrl_*()
wrappers.

Signed-off-by: Frederick Lawler <fred@fredlawl.com>
---
 drivers/pci/hotplug/pciehp.h      | 12 ++++---
 drivers/pci/hotplug/pciehp_core.c |  9 +++--
 drivers/pci/hotplug/pciehp_ctrl.c | 58 ++++++++++++-------------------
 drivers/pci/hotplug/pciehp_hpc.c  |  5 ++-
 4 files changed, 38 insertions(+), 46 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index 06ff9d31405e..e1cdc3565c62 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -32,13 +32,17 @@ extern int pciehp_poll_time;
 extern bool pciehp_debug;
 
 #define ctrl_dbg(ctrl, format, arg...)					\
-	pci_dbg(ctrl->pcie->port, format, ## arg)
+	pci_dbg(ctrl->pcie->port, "Slot(%s): " format,			\
+		slot_name(ctrl), ## arg)
 #define ctrl_err(ctrl, format, arg...)					\
-	pci_err(ctrl->pcie->port, format, ## arg)
+	pci_err(ctrl->pcie->port, "Slot(%s): " format,			\
+		slot_name(ctrl), ## arg)
 #define ctrl_info(ctrl, format, arg...)					\
-	pci_info(ctrl->pcie->port, format, ## arg)
+	pci_info(ctrl->pcie->port, "Slot(%s): " format,			\
+		 slot_name(ctrl), ## arg)
 #define ctrl_warn(ctrl, format, arg...)					\
-	pci_warn(ctrl->pcie->port, format, ## arg)
+	pci_warn(ctrl->pcie->port, "Slot(%s): " format,			\
+		 slot_name(ctrl), ## arg)
 
 #define SLOT_NAME_SIZE 10
 
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 67d024b7f476..ddaa45475572 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -85,7 +85,8 @@ static int init_slot(struct controller *ctrl)
 	retval = pci_hp_initialize(&ctrl->hotplug_slot,
 				   ctrl->pcie->port->subordinate, 0, name);
 	if (retval) {
-		ctrl_err(ctrl, "pci_hp_initialize failed: error %d\n", retval);
+		pci_err(ctrl->pcie->port,
+			"pci_hp_initialize failed: error %d\n", retval);
 		kfree(ops);
 	}
 	return retval;
@@ -201,9 +202,11 @@ static int pciehp_probe(struct pcie_device *dev)
 	rc = init_slot(ctrl);
 	if (rc) {
 		if (rc == -EBUSY)
-			ctrl_warn(ctrl, "Slot already registered by another hotplug driver\n");
+			pci_warn(ctrl->pcie->port,
+				 "Slot already registered by another hotplug driver\n");
 		else
-			ctrl_err(ctrl, "Slot initialization failed (%d)\n", rc);
+			pci_err(ctrl->pcie->port,
+				"Slot initialization failed (%d)\n", rc);
 		goto err_out_release_ctlr;
 	}
 
diff --git a/drivers/pci/hotplug/pciehp_ctrl.c b/drivers/pci/hotplug/pciehp_ctrl.c
index bf81f977a751..046ec4d52159 100644
--- a/drivers/pci/hotplug/pciehp_ctrl.c
+++ b/drivers/pci/hotplug/pciehp_ctrl.c
@@ -76,7 +76,7 @@ static int board_added(struct controller *ctrl)
 
 	/* Check for a power fault */
 	if (ctrl->power_fault_detected || pciehp_query_power_fault(ctrl)) {
-		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
+		ctrl_err(ctrl, "Power fault\n");
 		retval = -EIO;
 		goto err_exit;
 	}
@@ -160,12 +160,10 @@ void pciehp_handle_button_press(struct controller *ctrl)
 	case ON_STATE:
 		if (ctrl->state == ON_STATE) {
 			ctrl->state = BLINKINGOFF_STATE;
-			ctrl_info(ctrl, "Slot(%s): Powering off due to button press\n",
-				  slot_name(ctrl));
+			ctrl_info(ctrl, "Powering off due to button press\n");
 		} else {
 			ctrl->state = BLINKINGON_STATE;
-			ctrl_info(ctrl, "Slot(%s) Powering on due to button press\n",
-				  slot_name(ctrl));
+			ctrl_info(ctrl, "Powering on due to button press\n");
 		}
 		/* blink green LED and turn off amber */
 		pciehp_green_led_blink(ctrl);
@@ -179,7 +177,7 @@ void pciehp_handle_button_press(struct controller *ctrl)
 		 * press the attention again before the 5 sec. limit
 		 * expires to cancel hot-add or hot-remove
 		 */
-		ctrl_info(ctrl, "Slot(%s): Button cancel\n", slot_name(ctrl));
+		ctrl_info(ctrl, "Button cancel\n");
 		cancel_delayed_work(&ctrl->button_work);
 		if (ctrl->state == BLINKINGOFF_STATE) {
 			ctrl->state = ON_STATE;
@@ -189,12 +187,11 @@ void pciehp_handle_button_press(struct controller *ctrl)
 			pciehp_green_led_off(ctrl);
 		}
 		pciehp_set_attention_status(ctrl, 0);
-		ctrl_info(ctrl, "Slot(%s): Action canceled due to button press\n",
-			  slot_name(ctrl));
+		ctrl_info(ctrl, "Action canceled due to button press\n");
 		break;
 	default:
-		ctrl_err(ctrl, "Slot(%s): Ignoring invalid state %#x\n",
-			 slot_name(ctrl), ctrl->state);
+		ctrl_err(ctrl, "Ignoring invalid state %#x\n",
+			 ctrl->state);
 		break;
 	}
 	mutex_unlock(&ctrl->state_lock);
@@ -232,11 +229,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		ctrl->state = POWEROFF_STATE;
 		mutex_unlock(&ctrl->state_lock);
 		if (events & PCI_EXP_SLTSTA_DLLSC)
-			ctrl_info(ctrl, "Slot(%s): Link Down\n",
-				  slot_name(ctrl));
+			ctrl_info(ctrl, "Link Down\n");
 		if (events & PCI_EXP_SLTSTA_PDC)
-			ctrl_info(ctrl, "Slot(%s): Card not present\n",
-				  slot_name(ctrl));
+			ctrl_info(ctrl, "Card not present\n");
 		pciehp_disable_slot(ctrl, SURPRISE_REMOVAL);
 		break;
 	default:
@@ -261,11 +256,9 @@ void pciehp_handle_presence_or_link_change(struct controller *ctrl, u32 events)
 		ctrl->state = POWERON_STATE;
 		mutex_unlock(&ctrl->state_lock);
 		if (present)
-			ctrl_info(ctrl, "Slot(%s): Card present\n",
-				  slot_name(ctrl));
+			ctrl_info(ctrl, "Card present\n");
 		if (link_active)
-			ctrl_info(ctrl, "Slot(%s): Link Up\n",
-				  slot_name(ctrl));
+			ctrl_info(ctrl, "Link Up\n");
 		ctrl->request_result = pciehp_enable_slot(ctrl);
 		break;
 	default:
@@ -281,8 +274,7 @@ static int __pciehp_enable_slot(struct controller *ctrl)
 	if (MRL_SENS(ctrl)) {
 		pciehp_get_latch_status(ctrl, &getstatus);
 		if (getstatus) {
-			ctrl_info(ctrl, "Slot(%s): Latch open\n",
-				  slot_name(ctrl));
+			ctrl_info(ctrl, "Latch open\n");
 			return -ENODEV;
 		}
 	}
@@ -290,8 +282,7 @@ static int __pciehp_enable_slot(struct controller *ctrl)
 	if (POWER_CTRL(ctrl)) {
 		pciehp_get_power_status(ctrl, &getstatus);
 		if (getstatus) {
-			ctrl_info(ctrl, "Slot(%s): Already enabled\n",
-				  slot_name(ctrl));
+			ctrl_info(ctrl, "Already enabled\n");
 			return 0;
 		}
 	}
@@ -323,8 +314,7 @@ static int __pciehp_disable_slot(struct controller *ctrl, bool safe_removal)
 	if (POWER_CTRL(ctrl)) {
 		pciehp_get_power_status(ctrl, &getstatus);
 		if (!getstatus) {
-			ctrl_info(ctrl, "Slot(%s): Already disabled\n",
-				  slot_name(ctrl));
+			ctrl_info(ctrl, "Already disabled\n");
 			return -EINVAL;
 		}
 	}
@@ -367,18 +357,16 @@ int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot)
 			   !atomic_read(&ctrl->pending_events));
 		return ctrl->request_result;
 	case POWERON_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already in powering on state\n",
-			  slot_name(ctrl));
+		ctrl_info(ctrl, "Already in powering on state\n");
 		break;
 	case BLINKINGOFF_STATE:
 	case ON_STATE:
 	case POWEROFF_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already enabled\n",
-			  slot_name(ctrl));
+		ctrl_info(ctrl, "Already enabled\n");
 		break;
 	default:
-		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
-			 slot_name(ctrl), ctrl->state);
+		ctrl_err(ctrl, "Invalid state %#x\n",
+			 ctrl->state);
 		break;
 	}
 	mutex_unlock(&ctrl->state_lock);
@@ -400,18 +388,16 @@ int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot)
 			   !atomic_read(&ctrl->pending_events));
 		return ctrl->request_result;
 	case POWEROFF_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already in powering off state\n",
-			  slot_name(ctrl));
+		ctrl_info(ctrl, "Already in powering off state\n");
 		break;
 	case BLINKINGON_STATE:
 	case OFF_STATE:
 	case POWERON_STATE:
-		ctrl_info(ctrl, "Slot(%s): Already disabled\n",
-			  slot_name(ctrl));
+		ctrl_info(ctrl, "Already disabled\n");
 		break;
 	default:
-		ctrl_err(ctrl, "Slot(%s): Invalid state %#x\n",
-			 slot_name(ctrl), ctrl->state);
+		ctrl_err(ctrl, "Invalid state %#x\n",
+			 ctrl->state);
 		break;
 	}
 	mutex_unlock(&ctrl->state_lock);
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 1713b0b08a5e..2cb85433736d 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -629,15 +629,14 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 
 	/* Check Attention Button Pressed */
 	if (events & PCI_EXP_SLTSTA_ABP) {
-		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
-			  slot_name(ctrl));
+		ctrl_info(ctrl, "Attention button pressed\n");
 		pciehp_handle_button_press(ctrl);
 	}
 
 	/* Check Power Fault Detected */
 	if ((events & PCI_EXP_SLTSTA_PFD) && !ctrl->power_fault_detected) {
 		ctrl->power_fault_detected = 1;
-		ctrl_err(ctrl, "Slot(%s): Power fault\n", slot_name(ctrl));
+		ctrl_err(ctrl, "Power fault\n");
 		pciehp_set_attention_status(ctrl, 1);
 		pciehp_green_led_off(ctrl);
 	}
-- 
2.17.1

