Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B27371F9A4D
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbgFOOdC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 10:33:02 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42921 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730197AbgFOOdB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 10:33:01 -0400
Received: from mail-qt1-f198.google.com ([209.85.160.198])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <ian.may@canonical.com>)
        id 1jkqAV-0002Ke-4M
        for linux-pci@vger.kernel.org; Mon, 15 Jun 2020 14:32:59 +0000
Received: by mail-qt1-f198.google.com with SMTP id n37so14112149qtf.18
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2020 07:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9AjKxWVfbOqQdi3XlIEGWselV/PxzTZqqz7FB93vxw=;
        b=UIiwYC5rdjZOgXtrjlBIq72eTIMRnvUupOvmBIF35E/F+SjZB8NwNnWNh8B0OLsm8V
         uKREqd0bmsMKjiKQisTSxFEpopUzNWOdavUUTOho2mUqNJniuB763HrwpqmOnbWftlRm
         YEOyZwt9GFfWm9tLeql4bq0fC35DBslzxMjs8M8KLtPMqx/otpmeX/7Y52kKQQAPQ3v0
         9Ja7I50qj+sZYOWd2m7g7TY57zOCrIRAgH1Dwg2Kaim27PLlZg4FzSEnC4iBPSJZZf45
         yRSnoz2S0HX1Vm0lQxs5jDTF88J9v+yM1gdyYDuFTW7gN/0tEmu6s1aWvfMKJI1znAlO
         szYw==
X-Gm-Message-State: AOAM530jL066H8Bubvtx8LcwpaLjjZ7/pxZbxWY0A2ciNQ8oVjSPoiQK
        iW7ZImkWNxyJ8dERLZ+u1WjrchsKVUZIVPfrN8jFzOb4TA/EZEvd61j/mBfb8btaw34/NF/6lOY
        /7SnGDq91zjMHa6NX7izGoOARYR1sPTf5oflK3A==
X-Received: by 2002:a05:620a:13c6:: with SMTP id g6mr15196045qkl.453.1592231577727;
        Mon, 15 Jun 2020 07:32:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxvvKF0VO3lFLPjk6ftmgrsdwJ7qH3kImhpMd2IihGs0BnHl/RhrW/bEkbiEzmwcLFz5zygTw==
X-Received: by 2002:a05:620a:13c6:: with SMTP id g6mr15196019qkl.453.1592231577433;
        Mon, 15 Jun 2020 07:32:57 -0700 (PDT)
Received: from localhost.localdomain ([2001:67c:1562:8007::aac:44bb])
        by smtp.gmail.com with ESMTPSA id u10sm12744675qth.32.2020.06.15.07.32.56
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:32:56 -0700 (PDT)
From:   Ian May <ian.may@canonical.com>
To:     linux-pci@vger.kernel.org
Subject: [PATCH 1/2] PCIe hotplug interrupt and AER deadlock with reset_lock and device_lock
Date:   Mon, 15 Jun 2020 09:32:49 -0500
Message-Id: <20200615143250.438252-2-ian.may@canonical.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200615143250.438252-1-ian.may@canonical.com>
References: <20200615143250.438252-1-ian.may@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Currently when a hotplug interrupt and AER recovery triggers simultaneously
the following deadlock can occur.

        Hotplug				       AER
----------------------------       ---------------------------
device_lock(&dev->dev)		   down_write(&ctrl->reset_lock)
down_read(&ctrl->reset_lock)       device_lock(&dev->dev)

This patch adds a reset_lock and reset_unlock hotplug_slot_op.  This would allow
the controller reset_lock/reset_unlock to be moved from pciehp_reset_slot to
pci_slot_reset function allowing the controller reset_lock to be acquired before
the device lock allowing for both hotplug and AER to grab the reset_lock
and device lock in proper order.

Signed-off-by: Ian May <ian.may@canonical.com>
---
 drivers/pci/hotplug/pciehp.h      |  2 ++
 drivers/pci/hotplug/pciehp_core.c |  2 ++
 drivers/pci/hotplug/pciehp_hpc.c  | 21 ++++++++++++++++++---
 drivers/pci/pci.c                 |  6 ++++++
 include/linux/pci_hotplug.h       |  2 ++
 5 files changed, 30 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp.h b/drivers/pci/hotplug/pciehp.h
index e28b4fffd84d..1e98604cec83 100644
--- a/drivers/pci/hotplug/pciehp.h
+++ b/drivers/pci/hotplug/pciehp.h
@@ -183,6 +183,8 @@ void pciehp_release_ctrl(struct controller *ctrl);
 
 int pciehp_sysfs_enable_slot(struct hotplug_slot *hotplug_slot);
 int pciehp_sysfs_disable_slot(struct hotplug_slot *hotplug_slot);
+int pciehp_reset_lock(struct hotplug_slot *hotplug_slot);
+int pciehp_reset_unlock(struct hotplug_slot *hotplug_slot);
 int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe);
 int pciehp_get_attention_status(struct hotplug_slot *hotplug_slot, u8 *status);
 int pciehp_set_raw_indicator_status(struct hotplug_slot *h_slot, u8 status);
diff --git a/drivers/pci/hotplug/pciehp_core.c b/drivers/pci/hotplug/pciehp_core.c
index 4c032d75c874..a8da3e6a59b8 100644
--- a/drivers/pci/hotplug/pciehp_core.c
+++ b/drivers/pci/hotplug/pciehp_core.c
@@ -63,6 +63,8 @@ static int init_slot(struct controller *ctrl)
 	ops->get_power_status = get_power_status;
 	ops->get_adapter_status = get_adapter_status;
 	ops->reset_slot = pciehp_reset_slot;
+	ops->reset_lock = pciehp_reset_lock;
+	ops->reset_unlock = pciehp_reset_unlock;
 	if (MRL_SENS(ctrl))
 		ops->get_latch_status = get_latch_status;
 	if (ATTN_LED(ctrl)) {
diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 81b23f07719e..185ec9d1b0d0 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -798,6 +798,24 @@ void pcie_disable_interrupt(struct controller *ctrl)
 	pcie_write_cmd(ctrl, 0, mask);
 }
 
+int pciehp_reset_lock(struct hotplug_slot *hotplug_slot)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+
+	down_write(&ctrl->reset_lock);
+
+	return 0;
+}
+
+int pciehp_reset_unlock(struct hotplug_slot *hotplug_slot)
+{
+	struct controller *ctrl = to_ctrl(hotplug_slot);
+
+	up_write(&ctrl->reset_lock);
+
+	return 0;
+}
+
 /*
  * pciehp has a 1:1 bus:slot relationship so we ultimately want a secondary
  * bus reset of the bridge, but at the same time we want to ensure that it is
@@ -816,8 +834,6 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 	if (probe)
 		return 0;
 
-	down_write(&ctrl->reset_lock);
-
 	if (!ATTN_BUTTN(ctrl)) {
 		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
 		stat_mask |= PCI_EXP_SLTSTA_PDC;
@@ -836,7 +852,6 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, int probe)
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
 
-	up_write(&ctrl->reset_lock);
 	return rc;
 }
 
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index da21293f1111..e32c5a1a706e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5228,14 +5228,20 @@ static int pci_slot_reset(struct pci_slot *slot, int probe)
 		return -ENOTTY;
 
 	if (!probe)
+	{
+		slot->hotplug->ops->reset_lock(slot->hotplug);
 		pci_slot_lock(slot);
+	}
 
 	might_sleep();
 
 	rc = pci_reset_hotplug_slot(slot->hotplug, probe);
 
 	if (!probe)
+	{
 		pci_slot_unlock(slot);
+		slot->hotplug->ops->reset_unlock(slot->hotplug);
+	}
 
 	return rc;
 }
diff --git a/include/linux/pci_hotplug.h b/include/linux/pci_hotplug.h
index f694eb2ca978..fce5ad979346 100644
--- a/include/linux/pci_hotplug.h
+++ b/include/linux/pci_hotplug.h
@@ -45,6 +45,8 @@ struct hotplug_slot_ops {
 	int (*get_latch_status)		(struct hotplug_slot *slot, u8 *value);
 	int (*get_adapter_status)	(struct hotplug_slot *slot, u8 *value);
 	int (*reset_slot)		(struct hotplug_slot *slot, int probe);
+	int (*reset_lock)               (struct hotplug_slot *slot);
+	int (*reset_unlock)             (struct hotplug_slot *slot);
 };
 
 /**
-- 
2.25.1

