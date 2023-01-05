Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BE265F3EB
	for <lists+linux-pci@lfdr.de>; Thu,  5 Jan 2023 19:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234735AbjAESow (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Jan 2023 13:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234467AbjAESov (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 5 Jan 2023 13:44:51 -0500
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206162BFC
        for <linux-pci@vger.kernel.org>; Thu,  5 Jan 2023 10:44:50 -0800 (PST)
Received: by mail-qt1-x832.google.com with SMTP id a16so30655021qtw.10
        for <linux-pci@vger.kernel.org>; Thu, 05 Jan 2023 10:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wDGw99ShhAk4BTfbiq/HSg4iz18los6PguJhzuGnQnY=;
        b=XgEpbxNVDAvvOf6J3A2TwDGJnpHNkX/AZYYLf7z49hyrdmaG/1mrQnxKw/RxWIBFpT
         F4LyDyZaVWujnLPvV/7auLtQsSznaTE/bSs/QIheK6GEJi3veeMn0Au4cQo5dxjp5Qss
         Lx37aTtxAJUJcgWRDw5f3CFfykpkJk0cSgaQPagcHwLupQj7vtx0/4F9k4e3tbySMCs9
         Q4yCnMX2WaA+Y89X+hofBZKBvVtju/cGCHdIHUGv1L0aRQ13ntPZdyfRjlhkUgORqdeC
         efKOd5r2jsLWnunpJ+5gSFqRTzVnWmkqbES0S05EYZvCg+7zklnXznXiwQjgStSXalTW
         Qb7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wDGw99ShhAk4BTfbiq/HSg4iz18los6PguJhzuGnQnY=;
        b=N3OBzWAmQ8EcyJiMXIycQ2r10l1+55BQY3vXEEAnSPnuI5TZxpqPDk5Kpd071whYnP
         95DrvvwXDmCtpi0yS2xxB/Wvt0snAy6aw64vX7stP8NJ6468SLSWi9YbDza94lKynO3g
         NE57r1ch+/f9nP3P9GJwEyV0Q+HiEgLMDovtVnsara6dUpggRtROSCz8sXvl47pUt6nj
         fFZ3ZqIQOj+OubYpQJ3X/Yg+wfJGboyqu/aDHbFviShUjmTchfXkwo7rmTcXqymm9Ofj
         Rynrs6VBIDVMRsc6wSFcNy6qj9H3SJ8WGg0qISO9ctkFII19Enf1kCr4iYW3y1GPQ6SU
         GgWA==
X-Gm-Message-State: AFqh2kpLnL42vvx5tC+UAAoyev9niyuYt9NT1edzX7HR0SU5tgFN9fR1
        A6ATkY+Gru8QCoQk4p6UObO+ylaSwTY+6NEC
X-Google-Smtp-Source: AMrXdXsCBao5sj2mA3pCbmn7CVNG8OxdS3ux1KK5fPjIVNoASvx47cX20cWWXXrs9FUsPa7nYbB/uA==
X-Received: by 2002:ac8:5392:0:b0:3a5:1dcb:d231 with SMTP id x18-20020ac85392000000b003a51dcbd231mr74028496qtp.59.1672944289119;
        Thu, 05 Jan 2023 10:44:49 -0800 (PST)
Received: from smtp.xilinx.com (atlvpn.amd.com. [165.204.84.11])
        by smtp.gmail.com with ESMTPSA id h24-20020ac87458000000b003a7ef7a758dsm21956801qtr.59.2023.01.05.10.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jan 2023 10:44:48 -0800 (PST)
From:   Anatoli Antonovitch <a.antonovitch@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     bhelgaas@google.com, lukas@wunner.de, Alexander.Deucher@amd.com,
        christian.koenig@amd.com,
        Anatoli Antonovitch <anatoli.antonovitch@amd.com>
Subject: [PATCH] PCI/hotplug: Replaced down_write_nested with hotplug_slot_rwsem if ctrl->depth > 0 when taking the ctrl->reset_lock.
Date:   Thu,  5 Jan 2023 13:43:55 -0500
Message-Id: <20230105184355.9829-1-a.antonovitch@gmail.com>
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
Need to do some more testing to see if it is still necessary.

To fix the race between pciehp and AER reported in https://bugzilla.kernel.org/show_bug.cgi?id=215590

INFO: task irq/26-aerdrv:104 blocked for more than 120 seconds.
Tainted: G        W          6.1.0-rc5-custom-master-nov14+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:irq/26-aerdrv   state:D stack:0     pid:104   ppid:2      flags:0x00004000
Call Trace:
<TASK>
__schedule+0x39c/0xe90
? rcu_read_lock_sched_held+0x25/0x80
schedule+0x6b/0xf0
rwsem_down_write_slowpath+0x3b2/0x9c0
down_write_nested+0x16b/0x210
pciehp_reset_slot+0x63/0x160
pci_reset_hotplug_slot+0x44/0x70
pci_slot_reset+0x10d/0x190
pci_bus_error_reset+0xb2/0xe0
aer_root_reset+0x144/0x190
pcie_do_recovery+0x15a/0x270
? aer_dev_correctable_show+0xc0/0xc0
aer_process_err_devices+0xcf/0xea
aer_isr.cold+0x52/0xa1
? __kmem_cache_free+0x36a/0x3b0
? irq_thread+0xb0/0x1e0
? irq_thread+0xb0/0x1e0
irq_thread_fn+0x28/0x70
irq_thread+0x106/0x1e0
? irq_forced_thread_fn+0xb0/0xb0
? wake_threads_waitq+0x40/0x40
? irq_thread_check_affinity+0xf0/0xf0
kthread+0x10a/0x130
? kthread_complete_and_exit+0x20/0x20
ret_from_fork+0x22/0x30
</TASK>

INFO: task irq/26-pciehp:105 blocked for more than 120 seconds.
Tainted: G        W          6.1.0-rc5-custom-master-nov14+ #2
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:irq/26-pciehp   state:D stack:0     pid:105   ppid:2      flags:0x00004000
Call Trace:
<TASK>
__schedule+0x39c/0xe90
schedule+0x6b/0xf0
schedule_preempt_disabled+0x18/0x30
__mutex_lock+0x685/0xf60
? rcu_read_lock_sched_held+0x25/0x80
? lock_release+0x24d/0x410
? __device_driver_lock+0x2d/0x50
mutex_lock_nested+0x1b/0x30
? mutex_lock_nested+0x1b/0x30
__device_driver_lock+0x2d/0x50
device_release_driver_internal+0x1f/0x170
device_release_driver+0x12/0x20
pci_stop_bus_device+0x74/0xa0
pci_stop_bus_device+0x30/0xa0
pci_stop_and_remove_bus_device+0x13/0x30
pciehp_unconfigure_device+0x80/0x140
pciehp_disable_slot+0x6e/0x110
pciehp_handle_presence_or_link_change+0xf1/0x310
pciehp_ist+0x1a0/0x1b0
? irq_thread+0xb0/0x1e0
irq_thread_fn+0x28/0x70
irq_thread+0x106/0x1e0
? irq_forced_thread_fn+0xb0/0xb0
? wake_threads_waitq+0x40/0x40
? irq_thread_check_affinity+0xf0/0xf0
kthread+0x10a/0x130
? kthread_complete_and_exit+0x20/0x20
ret_from_fork+0x22/0x30
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

