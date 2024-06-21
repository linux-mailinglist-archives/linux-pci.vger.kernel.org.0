Return-Path: <linux-pci+bounces-9057-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F2089911BE9
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 08:37:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E9421F248FE
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 06:37:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53DC0156641;
	Fri, 21 Jun 2024 06:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ngn.tf header.i=@ngn.tf header.b="fNejmAth"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.ngn.tf (ngn.tf [193.106.196.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD9B7155CAC;
	Fri, 21 Jun 2024 06:36:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.106.196.85
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718951802; cv=none; b=lj/iDJslRs1utJKSHm76kjB2oSrn0LyTF45V6R94ThJpLizmMDt81fczwkHYCdLNfZutLrDnSAWE5Vkiefryx3NjR5IuZjmgN4tFQRRTmmwX7fi7KzPTM5IIA+LtcP1+DRWXRpiL3k1DCLQaep/xvt7/+15dqFCbcMpOIxiEQsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718951802; c=relaxed/simple;
	bh=gdPe/cZTFIj/WZley7sty4cWNKh/akFFobRCadNluOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iz1XCr7lFrZ4wbENVHnr498mx68RGs8edQve/qz1qubQx3h6rsBR1a9/0tqL6ZLLsvkhhRmyuUwXvwpDaYkiq5+1AXg8m9OWZzEifpZIGNrrtTT2gpAxrkNyI1W64xhq83qoE6EQM826wSj726mJ2j4VGAygQYaHsAb00V1GMU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ngn.tf; spf=pass smtp.mailfrom=ngn.tf; dkim=pass (2048-bit key) header.d=ngn.tf header.i=@ngn.tf header.b=fNejmAth; arc=none smtp.client-ip=193.106.196.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ngn.tf
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ngn.tf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ngn.tf; s=mail;
	t=1718951797; bh=gdPe/cZTFIj/WZley7sty4cWNKh/akFFobRCadNluOc=;
	h=From:To:Cc:Subject:In-Reply-To:References;
	b=fNejmAth1zEB8425q7XUOlZePNs93jeTsa7zSJAWFa0n6/sG2/oZ5OtROiPdGjmTb
	 lFg1tQZWNMp1FUVOSu5WrS90RyAdhHbwNfw9Iyvcm0O+SU7DyVbKyavyvlhkhWyRbc
	 M2wiFQmAMGQvb4qucM8jtcvlwodkAl4EQW5QsN1s8oFpKxbi3SHoH+IsvNPNw3w6xe
	 PoMLVfleyOErZhV0c2CmDSQi9NhYjL5UHMHqqd32SfN/yKXaYt/mONoFoO9Q9rljYm
	 8TTee8t36lVoFUNlL5nDskm5cI4XyFBTlZiYh1I0Y4F7iqZJlGhmZXE1emrB+EAiCa
	 p1dhWrcrVfWbw==
From: ngn <ngn@ngn.tf>
To: Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ngn <ngn@ngn.tf>
Subject: [PATCH 2/2] PCI: shpchp: Follow kernel coding style
Date: Fri, 21 Jun 2024 09:35:01 +0300
Message-ID: <bad71d39d1a72fceac548a91a3e5df61df2b1c05.1718949042.git.ngn@ngn.tf>
In-Reply-To: <cover.1718949042.git.ngn@ngn.tf>
References: <cover.1718949042.git.ngn@ngn.tf>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

fixing checkpatch warnings

Signed-off-by: ngn <ngn@ngn.tf>
---
 drivers/pci/hotplug/shpchp_hpc.c   | 91 +++++++++++++++---------------
 drivers/pci/hotplug/shpchp_sysfs.c |  7 +--
 2 files changed, 47 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/hotplug/shpchp_hpc.c b/drivers/pci/hotplug/shpchp_hpc.c
index 012b9e3fe5b0..dd30e7e611a7 100644
--- a/drivers/pci/hotplug/shpchp_hpc.c
+++ b/drivers/pci/hotplug/shpchp_hpc.c
@@ -47,24 +47,24 @@
 /*
  * Interrupt Locator Register definitions
  */
-#define CMD_INTR_PENDING	(1 << 0)
-#define SLOT_INTR_PENDING(i)	(1 << (i + 1))
+#define CMD_INTR_PENDING	BIT(0)
+#define SLOT_INTR_PENDING(i)	BIT((i) + 1)
 
 /*
  * Controller SERR-INT Register
  */
-#define GLOBAL_INTR_MASK	(1 << 0)
-#define GLOBAL_SERR_MASK	(1 << 1)
-#define COMMAND_INTR_MASK	(1 << 2)
-#define ARBITER_SERR_MASK	(1 << 3)
-#define COMMAND_DETECTED	(1 << 16)
-#define ARBITER_DETECTED	(1 << 17)
+#define GLOBAL_INTR_MASK	BIT(0)
+#define GLOBAL_SERR_MASK	BIT(1)
+#define COMMAND_INTR_MASK	BIT(2)
+#define ARBITER_SERR_MASK	BIT(3)
+#define COMMAND_DETECTED	BIT(16)
+#define ARBITER_DETECTED	BIT(17)
 #define SERR_INTR_RSVDZ_MASK	0xfffc0000
 
 /*
  * Logical Slot Register definitions
  */
-#define SLOT_REG(i)		(SLOT1 + (4 * i))
+#define SLOT_REG(i)		(SLOT1 + (4 * (i)))
 
 #define SLOT_STATE_SHIFT	(0)
 #define SLOT_STATE_MASK		(3 << 0)
@@ -78,27 +78,27 @@
 #define ATN_LED_STATE_ON	(1)
 #define ATN_LED_STATE_BLINK	(2)
 #define ATN_LED_STATE_OFF	(3)
-#define POWER_FAULT		(1 << 6)
-#define ATN_BUTTON		(1 << 7)
-#define MRL_SENSOR		(1 << 8)
-#define MHZ66_CAP		(1 << 9)
+#define POWER_FAULT		BIT(6)
+#define ATN_BUTTON		BIT(7)
+#define MRL_SENSOR		BIT(8)
+#define MHZ66_CAP		BIT(9)
 #define PRSNT_SHIFT		(10)
 #define PRSNT_MASK		(3 << 10)
 #define PCIX_CAP_SHIFT		(12)
 #define PCIX_CAP_MASK_PI1	(3 << 12)
 #define PCIX_CAP_MASK_PI2	(7 << 12)
-#define PRSNT_CHANGE_DETECTED	(1 << 16)
-#define ISO_PFAULT_DETECTED	(1 << 17)
-#define BUTTON_PRESS_DETECTED	(1 << 18)
-#define MRL_CHANGE_DETECTED	(1 << 19)
-#define CON_PFAULT_DETECTED	(1 << 20)
-#define PRSNT_CHANGE_INTR_MASK	(1 << 24)
-#define ISO_PFAULT_INTR_MASK	(1 << 25)
-#define BUTTON_PRESS_INTR_MASK	(1 << 26)
-#define MRL_CHANGE_INTR_MASK	(1 << 27)
-#define CON_PFAULT_INTR_MASK	(1 << 28)
-#define MRL_CHANGE_SERR_MASK	(1 << 29)
-#define CON_PFAULT_SERR_MASK	(1 << 30)
+#define PRSNT_CHANGE_DETECTED	BIT(16)
+#define ISO_PFAULT_DETECTED	BIT(17)
+#define BUTTON_PRESS_DETECTED	BIT(18)
+#define MRL_CHANGE_DETECTED	BIT(19)
+#define CON_PFAULT_DETECTED	BIT(20)
+#define PRSNT_CHANGE_INTR_MASK	BIT(24)
+#define ISO_PFAULT_INTR_MASK	BIT(25)
+#define BUTTON_PRESS_INTR_MASK	BIT(26)
+#define MRL_CHANGE_INTR_MASK	BIT(27)
+#define CON_PFAULT_INTR_MASK	BIT(28)
+#define MRL_CHANGE_SERR_MASK	BIT(29)
+#define CON_PFAULT_SERR_MASK	BIT(30)
 #define SLOT_REG_RSVDZ_MASK	((1 << 15) | (7 << 21))
 
 /*
@@ -228,7 +228,7 @@ static void int_poll_timeout(struct timer_list *t)
 static void start_int_poll_timer(struct controller *ctrl, int sec)
 {
 	/* Clamp to sane value */
-	if ((sec <= 0) || (sec > 60))
+	if (sec <= 0 || sec > 60)
 		sec = 2;
 
 	ctrl->poll_timer.expires = jiffies + sec * HZ;
@@ -238,6 +238,7 @@ static void start_int_poll_timer(struct controller *ctrl, int sec)
 static inline int is_ctrl_busy(struct controller *ctrl)
 {
 	u16 cmd_status = shpc_readw(ctrl, CMD_STATUS);
+
 	return cmd_status & 0x1;
 }
 
@@ -272,7 +273,7 @@ static inline int shpc_wait_cmd(struct controller *ctrl)
 		rc = shpc_poll_ctrl_busy(ctrl);
 	else
 		rc = wait_event_interruptible_timeout(ctrl->queue,
-						!is_ctrl_busy(ctrl), timeout);
+						      !is_ctrl_busy(ctrl), timeout);
 	if (!rc && is_ctrl_busy(ctrl)) {
 		retval = -EIO;
 		ctrl_err(ctrl, "Command not completed in 1000 msec\n");
@@ -355,7 +356,6 @@ int shpchp_check_cmd_status(struct controller *ctrl)
 	return retval;
 }
 
-
 int shpchp_get_attention_status(struct slot *slot, u8 *status)
 {
 	struct controller *ctrl = slot->ctrl;
@@ -404,7 +404,6 @@ int shpchp_get_power_status(struct slot *slot, u8 *status)
 	return 0;
 }
 
-
 int shpchp_get_latch_status(struct slot *slot, u8 *status)
 {
 	struct controller *ctrl = slot->ctrl;
@@ -502,23 +501,22 @@ int shpchp_set_attention_status(struct slot *slot, u8 value)
 	u8 slot_cmd = 0;
 
 	switch (value) {
-		case 0:
-			slot_cmd = SET_ATTN_OFF;	/* OFF */
-			break;
-		case 1:
-			slot_cmd = SET_ATTN_ON;		/* ON */
-			break;
-		case 2:
-			slot_cmd = SET_ATTN_BLINK;	/* BLINK */
-			break;
-		default:
-			return -1;
+	case 0:
+		slot_cmd = SET_ATTN_OFF;	/* OFF */
+		break;
+	case 1:
+		slot_cmd = SET_ATTN_ON;		/* ON */
+		break;
+	case 2:
+		slot_cmd = SET_ATTN_BLINK;	/* BLINK */
+		break;
+	default:
+		return -1;
 	}
 
 	return shpc_write_cmd(slot, slot->hp_slot, slot_cmd);
 }
 
-
 void shpchp_green_led_on(struct slot *slot)
 {
 	shpc_write_cmd(slot, slot->hp_slot, SET_PWR_ON);
@@ -563,9 +561,9 @@ void shpchp_release_ctlr(struct controller *ctrl)
 	serr_int &= ~SERR_INTR_RSVDZ_MASK;
 	shpc_writel(ctrl, SERR_INTR_ENABLE, serr_int);
 
-	if (shpchp_poll_mode)
+	if (shpchp_poll_mode) {
 		del_timer(&ctrl->poll_timer);
-	else {
+	} else {
 		free_irq(ctrl->pci_dev->irq, ctrl);
 		pci_disable_msi(ctrl->pci_dev);
 	}
@@ -591,7 +589,7 @@ int shpchp_slot_enable(struct slot *slot)
 
 	/* Slot - Enable, Power Indicator - Blink, Attention Indicator - Off */
 	retval = shpc_write_cmd(slot, slot->hp_slot,
-			SET_SLOT_ENABLE | SET_PWR_BLINK | SET_ATTN_OFF);
+				SET_SLOT_ENABLE | SET_PWR_BLINK | SET_ATTN_OFF);
 	if (retval)
 		ctrl_err(slot->ctrl, "%s: Write command failed!\n", __func__);
 
@@ -620,7 +618,7 @@ static int shpc_get_cur_bus_speed(struct controller *ctrl)
 	u8 pi = shpc_readb(ctrl, PROG_INTERFACE);
 	u8 speed_mode = (pi == 2) ? (sec_bus_reg & 0xF) : (sec_bus_reg & 0x7);
 
-	if ((pi == 1) && (speed_mode > 4)) {
+	if (pi == 1 && speed_mode > 4) {
 		retval = -ENODEV;
 		goto out;
 	}
@@ -679,7 +677,6 @@ static int shpc_get_cur_bus_speed(struct controller *ctrl)
 	return retval;
 }
 
-
 int shpchp_set_bus_speed_mode(struct slot *slot, enum pci_bus_speed value)
 {
 	int retval;
@@ -687,7 +684,7 @@ int shpchp_set_bus_speed_mode(struct slot *slot, enum pci_bus_speed value)
 	u8 pi, cmd;
 
 	pi = shpc_readb(ctrl, PROG_INTERFACE);
-	if ((pi == 1) && (value > PCI_SPEED_133MHz_PCIX))
+	if (pi == 1 && value > PCI_SPEED_133MHz_PCIX)
 		return -EINVAL;
 
 	switch (value) {
diff --git a/drivers/pci/hotplug/shpchp_sysfs.c b/drivers/pci/hotplug/shpchp_sysfs.c
index 01d47a42da04..06c928cfbc81 100644
--- a/drivers/pci/hotplug/shpchp_sysfs.c
+++ b/drivers/pci/hotplug/shpchp_sysfs.c
@@ -18,7 +18,6 @@
 #include <linux/pci.h>
 #include "shpchp.h"
 
-
 /* A few routines that create sysfs entries for the hot plug controller */
 
 static ssize_t show_ctrl(struct device *dev, struct device_attribute *attr, char *buf)
@@ -35,7 +34,7 @@ static ssize_t show_ctrl(struct device *dev, struct device_attribute *attr, char
 	len += sysfs_emit_at(buf, len, "Free resources: memory\n");
 	pci_bus_for_each_resource(bus, res) {
 		if (res && (res->flags & IORESOURCE_MEM) &&
-				!(res->flags & IORESOURCE_PREFETCH)) {
+		    !(res->flags & IORESOURCE_PREFETCH)) {
 			len += sysfs_emit_at(buf, len,
 					     "start = %8.8llx, length = %8.8llx\n",
 					     (unsigned long long)res->start,
@@ -45,7 +44,7 @@ static ssize_t show_ctrl(struct device *dev, struct device_attribute *attr, char
 	len += sysfs_emit_at(buf, len, "Free resources: prefetchable memory\n");
 	pci_bus_for_each_resource(bus, res) {
 		if (res && (res->flags & IORESOURCE_MEM) &&
-			       (res->flags & IORESOURCE_PREFETCH)) {
+		    (res->flags & IORESOURCE_PREFETCH)) {
 			len += sysfs_emit_at(buf, len,
 					     "start = %8.8llx, length = %8.8llx\n",
 					     (unsigned long long)res->start,
@@ -73,7 +72,7 @@ static ssize_t show_ctrl(struct device *dev, struct device_attribute *attr, char
 
 	return len;
 }
-static DEVICE_ATTR(ctrl, S_IRUGO, show_ctrl, NULL);
+static DEVICE_ATTR(ctrl, 0444, show_ctrl, NULL);
 
 int shpchp_create_ctrl_files(struct controller *ctrl)
 {
-- 
2.45.1


