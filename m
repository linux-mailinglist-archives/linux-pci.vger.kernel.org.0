Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67151669EFE
	for <lists+linux-pci@lfdr.de>; Fri, 13 Jan 2023 18:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjAMRCj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 13 Jan 2023 12:02:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjAMRCi (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 13 Jan 2023 12:02:38 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8155F5792F
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 09:02:37 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id h10so15166194qvq.7
        for <linux-pci@vger.kernel.org>; Fri, 13 Jan 2023 09:02:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mtm4pvPjWMYrozLxNwOe/qUwVMP4EPvQdbHa6k655vM=;
        b=OFC4DPMCXWmfDYQpcLka7Es9nd7nQ37mQnH0PgM+j+NdHtz2dSvvVg6zCRe/1W87xF
         oP2vYuC+UtO8v5SpgB0l84LWymJ3xZDJtkqgSmRSsM1KcH4q1Pqs7qjegqtsmItaRfOm
         BzMWhzq1GrLlFoUEyGMUhfr40QkFXwBsylOMdkHycRaZDYN6hzXgqoQ2ZrYGodLK9PXj
         dafYULgl1Cg5iISym1Sb9IH7IUSwJAVH9me89azyTCq/+LevuCjT+yeARSwDkypjMrl2
         iUV0XUP4l+MdNOCjCn7Qh56GM49ztu2qsdORvmykjIUcImwFh6XKoU+R6eDEnZiyqdPT
         bNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtm4pvPjWMYrozLxNwOe/qUwVMP4EPvQdbHa6k655vM=;
        b=QE1EehHai6Z3QBBbk1ORCeUk33t5DXCKKougkKSqcTub66abBBzQaPZsIFB1o2uqjG
         Ym22+9shpnjsnYbvc0Uw5yTiF+vEXN3VhKnVzYXqdvtw4dOAqMgNOsMfP0iWz90edAhY
         oVxPs7Ngy0m55/OqVDwkzVdIQYZKBnOEnSaNYNclHcFcTFCcZyQSoeEw3blLl7oghTWu
         1CQAfB7Znx8aGa88a2FOwgzOzUBTs2z7rTixyTItyzt+PNKNLsmlV712+Bc3d6JHkizJ
         T2f7XHpvAq3TBa6jl/GlPfhRcognzuv3Ch6Qfjm/snnLElawSV1rZ7MHZnTRi24kljrX
         2O0A==
X-Gm-Message-State: AFqh2kqvkUlxTxpihBS9U8N/1GCLGrjCP9IL4HATWPxSm2gNzIhjQHJ/
        eHpA2WqOUvQBLnG6HKlJcKz8TLY4qLzuV/Il
X-Google-Smtp-Source: AMrXdXvpEMqxqZnyYwJjA2Wsk0U+UFnZxwFXqNXzBsxQUAnIV5QVOBZC1hnbueLh3hPx5pTQRrK0Pg==
X-Received: by 2002:a0c:ab1b:0:b0:534:86f1:bcb5 with SMTP id h27-20020a0cab1b000000b0053486f1bcb5mr3324781qvb.41.1673629356285;
        Fri, 13 Jan 2023 09:02:36 -0800 (PST)
Received: from localhost.localdomain (76-10-173-44.dsl.teksavvy.com. [76.10.173.44])
        by smtp.gmail.com with ESMTPSA id v9-20020a05620a440900b006fc6529abaesm13094955qkp.101.2023.01.13.09.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jan 2023 09:02:35 -0800 (PST)
From:   Anatoli Antonovitch <a.antonovitch@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, lukas@wunner.de, Alexander.Deucher@amd.com,
        christian.koenig@amd.com,
        Anatoli Antonovitch <anatoli.antonovitch@amd.com>
Subject: [PATCH] PCI/hotplug: Replaced down_write_nested with hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Date:   Fri, 13 Jan 2023 12:01:31 -0500
Message-Id: <20230113170131.5086-1-a.antonovitch@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Anatoli Antonovitch <anatoli.antonovitch@amd.com>

It is to avoid any potential issues when S3 resume but at the same time we want to hot-unplug.

To fix the race between pciehp and AER reported in https://bugzilla.kernel.org/show_bug.cgi?id=215590

INFO: task irq/26-aerdrv:95 blocked for more than 120 seconds.
Tainted: G        W          6.2.0-rc3-custom-norework-jan11+ #29
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:irq/26-aerdrv   state:D stack:0     pid:95    ppid:2      flags:0x00004000
Call Trace:
<TASK>
__schedule+0x3df/0xec0
? rcu_read_lock_held_common+0x12/0x60
schedule+0x6b/0x100
rwsem_down_write_slowpath+0x3b2/0x9c0
down_write_nested+0x16b/0x220
pciehp_reset_slot+0x63/0x160
pci_reset_hotplug_slot+0x44/0x80
pci_slot_reset+0x10d/0x1a0
pci_bus_error_reset+0xb2/0xe0
aer_root_reset+0x144/0x1a0
pcie_do_recovery+0x15a/0x280
? __pfx_aer_root_reset+0x20/0x20
aer_process_err_devices+0xfa/0x115
aer_isr.cold+0x52/0xa1
? __kmem_cache_free+0x36a/0x3c0
? irq_thread+0xb0/0x1e0
? irq_thread+0xb0/0x1e0
irq_thread_fn+0x28/0x80
irq_thread+0x106/0x1e0
? __pfx_irq_thread_fn+0x20/0x20
? __pfx_irq_thread_dtor+0x20/0x20
? __pfx_irq_thread+0x20/0x20
kthread+0x10a/0x140
? __pfx_kthread+0x20/0x20
ret_from_fork+0x35/0x60
</TASK>

INFO: task irq/26-pciehp:96 blocked for more than 120 seconds.
Tainted: G        W          6.2.0-rc3-custom-norework-jan11+ #29
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:irq/26-pciehp   state:D stack:0     pid:96    ppid:2      flags:0x00004000
Call Trace:
<TASK>
__schedule+0x3df/0xec0
? rcu_read_lock_sched_held+0x25/0x80
schedule+0x6b/0x100
schedule_preempt_disabled+0x18/0x40
__mutex_lock+0x685/0xf60
? rcu_read_lock_sched_held+0x25/0x80
? rcu_read_lock_held_common+0x12/0x60
? pci_dev_set_disconnected+0x1b/0x80
mutex_lock_nested+0x1b/0x40
? mutex_lock_nested+0x1b/0x40
pci_dev_set_disconnected+0x1b/0x80
? __pfx_pci_dev_set_disconnected+0x20/0x20
pci_walk_bus+0x48/0xa0
pciehp_unconfigure_device+0x129/0x140
pciehp_disable_slot+0x6e/0x120
pciehp_handle_presence_or_link_change+0xf1/0x320
pciehp_ist+0x1a0/0x1c0
? irq_thread+0xb0/0x1e0
irq_thread_fn+0x28/0x80
irq_thread+0x106/0x1e0
? __pfx_irq_thread_fn+0x20/0x20
? __pfx_irq_thread_dtor+0x20/0x20
? __pfx_irq_thread+0x20/0x20
kthread+0x10a/0x140
? __pfx_kthread+0x20/0x20
ret_from_fork+0x35/0x60
</TASK>

Signed-off-by: Anatoli Antonovitch <anatoli.antonovitch@amd.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index 10e9670eea0b..b1084e67f798 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -27,6 +27,8 @@
 #include "../pci.h"
 #include "pciehp.h"
 
+static DECLARE_RWSEM(hotplug_slot_rwsem);
+
 static const struct dmi_system_id inband_presence_disabled_dmi_table[] = {
 	/*
 	 * Match all Dell systems, as some Dell systems have inband
@@ -911,7 +913,10 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
 	if (probe)
 		return 0;
 
-	down_write_nested(&ctrl->reset_lock, ctrl->depth);
+	if (ctrl->depth > 0)
+		down_write_nested(&ctrl->reset_lock, ctrl->depth);
+	else
+		down_write(&hotplug_slot_rwsem);
 
 	if (!ATTN_BUTTN(ctrl)) {
 		ctrl_mask |= PCI_EXP_SLTCTL_PDCE;
@@ -931,7 +936,11 @@ int pciehp_reset_slot(struct hotplug_slot *hotplug_slot, bool probe)
 	ctrl_dbg(ctrl, "%s: SLOTCTRL %x write cmd %x\n", __func__,
 		 pci_pcie_cap(ctrl->pcie->port) + PCI_EXP_SLTCTL, ctrl_mask);
 
-	up_write(&ctrl->reset_lock);
+	if (ctrl->depth > 0)
+		up_write(&ctrl->reset_lock);
+	else
+		up_write(&hotplug_slot_rwsem);
+
 	return rc;
 }
 
-- 
2.25.1

