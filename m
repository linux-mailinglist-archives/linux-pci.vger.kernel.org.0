Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8756407B68
	for <lists+linux-pci@lfdr.de>; Sun, 12 Sep 2021 05:43:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbhILDoF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 11 Sep 2021 23:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhILDoE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 11 Sep 2021 23:44:04 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FB62C061757;
        Sat, 11 Sep 2021 20:42:51 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id l16-20020a9d6a90000000b0053b71f7dc83so8286497otq.7;
        Sat, 11 Sep 2021 20:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdy2uRN+ySiJADBhhVTnv6/9K6Wu1MSGFAceAe8ll6c=;
        b=k7xC9enuxpsmtj2/rWSqBvfoZzhRIAuAuzREIyn+n9AH7qlsM+WLyRWyJWC3sXtvT7
         9B36QeHXYYBZF9udvTgn8LlcYHuTqV+XJi3GVqUJlzaxa2IkOHCpnj35UwWM1tNViMPV
         0qZMAivjP447GpAFIVG4J4qCO/Y5O4OZcYaulNye9HIsu9ywCBbeha9jEgjcKA/nTCK3
         y5NE5CA0BrmLI1ixLi3tI9gkJF+SjWl07zuVKbWsA7EEncKPDmcJLgp78ywYQ92v49wM
         +ZuoZ54hTd+JGUPcwA8URUZ13qghf8hM5caXXcqGiQFNLalKAvywhbamzIzFev6RoM/t
         crcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kdy2uRN+ySiJADBhhVTnv6/9K6Wu1MSGFAceAe8ll6c=;
        b=AQBCD7+l/hUUNWubGCWM/6lFl1MAiThZiebeMBnHFhb3SoDjbQEEztxavoeDwq+uov
         5tNxr/ds36ifS4hCPZCGqrHtgHinhAlR2BBe45d0YcON7lBHk9pGzlFEp6qdkzldUDT0
         JJYpUpk6YmfnZGW1YxwZz7L3kcC1bOao23pzVLKjF8J73FsnzdcgHSlIl0xhLnMpwfty
         OGKC9pCLgnwzivB+193qz6dwj6xvW+v4zM9jMG5w4ma871awp6gUzI3Jj9UqeOp6Xn5/
         g1QwdHKm8BLB59s96oTC4DSBsSAPku/nJLBUQfaUBlVuVmVvisxudnPdWOu+LEXkKUoY
         3S1Q==
X-Gm-Message-State: AOAM530demK/U6P+6HA+0CwlrB/y5suOg4iz07WQtfKf+V/TPqFc76pm
        NuUhBlhpXBseyNt2Dh2nhtI/bURZsd55Lw==
X-Google-Smtp-Source: ABdhPJzMj3wXVdWaCCF5y2xNvIYQT1e3Wuzk+MLN5E2KVJlux4bP62rzYveDOw7Zif6EyTaUPRIJoQ==
X-Received: by 2002:a05:6830:788:: with SMTP id w8mr4686812ots.235.1631418170324;
        Sat, 11 Sep 2021 20:42:50 -0700 (PDT)
Received: from vaslot-XPS-8930 (2603-8081-2340-02f5-3e74-ebea-a386-a29e.res6.spectrum.com. [2603:8081:2340:2f5:3e74:ebea:a386:a29e])
        by smtp.gmail.com with ESMTPSA id t21sm858588otl.67.2021.09.11.20.42.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Sep 2021 20:42:50 -0700 (PDT)
From:   Vishal Aslot <os.vaslot@gmail.com>
To:     bhelgaas@google.com, lukas@wunner.de
Cc:     os.vaslot@gmail.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] PCI:ibmphp: Eliminate unnecessary stack copies of struct slot
Date:   Sat, 11 Sep 2021 22:42:29 -0500
Message-Id: <20210912034229.1615885-1-os.vaslot@gmail.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Implementations of the following hotplug_slot_ops callbacks in ibmphp_core.c
create a copy of the struct slot with memcpy() on the stack. It is determined
that this overhead is unnecessary, because the only purpose of the stack copy
is to get the status back from ibmphp_hpc_readslot(). The status only needs
to be a "u8" variable. Therefore, this patch deletes the struct slot stack
variables and the related memcpy() calls from the following routines:

1. get_power_status()
2. get_attention_status()
3. get_latch_status()
4. get_adapter_status()

This patch also renames get_adapter_present() to get_adapter_status() in order
to match the hotplug_slot_ops name as well as the names of other status
routines.

Signed-off-by: Vishal Aslot <os.vaslot@gmail.com>
---

Why am I fixing this?
I found this issue in drivers/pci/hotplug/TODO, lines [21-24] and
decided to fix it.

 drivers/pci/hotplug/ibmphp_core.c | 40 +++++++++++++------------------
 1 file changed, 16 insertions(+), 24 deletions(-)

diff --git a/drivers/pci/hotplug/ibmphp_core.c b/drivers/pci/hotplug/ibmphp_core.c
index 17124254d897..9c4209185f07 100644
--- a/drivers/pci/hotplug/ibmphp_core.c
+++ b/drivers/pci/hotplug/ibmphp_core.c
@@ -263,7 +263,8 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
-	struct slot myslot;
+	u8 attention;
+	u8 ext_attention;
 
 	debug("get_attention_status - Entry hotplug_slot[%lx] pvalue[%lx]\n",
 					(ulong) hotplug_slot, (ulong) value);
@@ -271,14 +272,12 @@ static int get_attention_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	ibmphp_lock_operations();
 	if (hotplug_slot) {
 		pslot = to_slot(hotplug_slot);
-		memcpy(&myslot, pslot, sizeof(struct slot));
-		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
-					 &myslot.status);
+		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &attention);
 		if (!rc)
 			rc = ibmphp_hpc_readslot(pslot, READ_EXTSLOTSTATUS,
-						 &myslot.ext_status);
+						 &ext_attention);
 		if (!rc)
-			*value = SLOT_ATTN(myslot.status, myslot.ext_status);
+			*value = SLOT_ATTN(attention, ext_attention);
 	}
 
 	ibmphp_unlock_operations();
@@ -290,18 +289,16 @@ static int get_latch_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
-	struct slot myslot;
+	u8 latch;
 
 	debug("get_latch_status - Entry hotplug_slot[%lx] pvalue[%lx]\n",
 					(ulong) hotplug_slot, (ulong) value);
 	ibmphp_lock_operations();
 	if (hotplug_slot) {
 		pslot = to_slot(hotplug_slot);
-		memcpy(&myslot, pslot, sizeof(struct slot));
-		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
-					 &myslot.status);
+		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &latch);
 		if (!rc)
-			*value = SLOT_LATCH(myslot.status);
+			*value = SLOT_LATCH(latch);
 	}
 
 	ibmphp_unlock_operations();
@@ -315,18 +312,16 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
-	struct slot myslot;
+	u8 power;
 
 	debug("get_power_status - Entry hotplug_slot[%lx] pvalue[%lx]\n",
 					(ulong) hotplug_slot, (ulong) value);
 	ibmphp_lock_operations();
 	if (hotplug_slot) {
 		pslot = to_slot(hotplug_slot);
-		memcpy(&myslot, pslot, sizeof(struct slot));
-		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
-					 &myslot.status);
+		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &power);
 		if (!rc)
-			*value = SLOT_PWRGD(myslot.status);
+			*value = SLOT_PWRGD(power);
 	}
 
 	ibmphp_unlock_operations();
@@ -335,23 +330,20 @@ static int get_power_status(struct hotplug_slot *hotplug_slot, u8 *value)
 	return rc;
 }
 
-static int get_adapter_present(struct hotplug_slot *hotplug_slot, u8 *value)
+static int get_adapter_status(struct hotplug_slot *hotplug_slot, u8 *value)
 {
 	int rc = -ENODEV;
 	struct slot *pslot;
 	u8 present;
-	struct slot myslot;
 
 	debug("get_adapter_status - Entry hotplug_slot[%lx] pvalue[%lx]\n",
 					(ulong) hotplug_slot, (ulong) value);
 	ibmphp_lock_operations();
 	if (hotplug_slot) {
 		pslot = to_slot(hotplug_slot);
-		memcpy(&myslot, pslot, sizeof(struct slot));
-		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS,
-					 &myslot.status);
+		rc = ibmphp_hpc_readslot(pslot, READ_SLOTSTATUS, &present);
 		if (!rc) {
-			present = SLOT_PRESENT(myslot.status);
+			present = SLOT_PRESENT(present);
 			if (present == HPC_SLOT_EMPTY)
 				*value = 0;
 			else
@@ -360,7 +352,7 @@ static int get_adapter_present(struct hotplug_slot *hotplug_slot, u8 *value)
 	}
 
 	ibmphp_unlock_operations();
-	debug("get_adapter_present - Exit rc[%d] value[%x]\n", rc, *value);
+	debug("get_adapter_status - Exit rc[%d] value[%x]\n", rc, *value);
 	return rc;
 }
 
@@ -1230,7 +1222,7 @@ const struct hotplug_slot_ops ibmphp_hotplug_slot_ops = {
 	.get_power_status =		get_power_status,
 	.get_attention_status =		get_attention_status,
 	.get_latch_status =		get_latch_status,
-	.get_adapter_status =		get_adapter_present,
+	.get_adapter_status =		get_adapter_status,
 /*	.get_max_adapter_speed =	get_max_adapter_speed,
 	.get_bus_name_status =		get_bus_name,
 */
-- 
2.27.0

