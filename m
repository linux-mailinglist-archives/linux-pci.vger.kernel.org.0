Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE8334317B
	for <lists+linux-pci@lfdr.de>; Sun, 21 Mar 2021 06:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230006AbhCUFwK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Mar 2021 01:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbhCUFvr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Mar 2021 01:51:47 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69C60C061574;
        Sat, 20 Mar 2021 22:51:47 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l13so10005412qtu.9;
        Sat, 20 Mar 2021 22:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6awWR6J01S3VvaFl3l226JcCIWl910GFIDAp2HokN38=;
        b=QfSc/Hmcj8RYWcukNSs5oJtHP2rBqciQFojqJRMh6+2MmKoJQXWQQezTv1iIdaoa+H
         9dHDCJBi0i8woUgns9Pdq/K3BaAghbaojHycO3qsOshhmP3dL577Z1zgRl2CfjwziExu
         4ANF1fR45LA8yeESbxi1l9ZbSk3hnoIoc4kW/5qwFiBJcyF+pdG98Pa6p0EYiS6+0mR8
         hZNYVMiaHG2FE4XhrD6ClFUaOCmLDEvHFnS51q8zK3jLHvctMUSwFRfovmnRVDy9D13p
         55l2fY1IteMLVTDSs8KM7oarbwFxjOFuWrfSw1Pht4AfdV8N2ybkwL6K3/QryNVijTAi
         ggXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=6awWR6J01S3VvaFl3l226JcCIWl910GFIDAp2HokN38=;
        b=M3LL2qvBPW33t7mzQK5HLsPik4ckL9EtXmgLpOb7PXSlISzMh5fOvAM5ZoZjd9przk
         jZCwgkSQVEX+TypgKPNOOIQ6SRbGvVQM8vU9yDJQMeFuVHpeeLQqV8TwN/eoPRgc5AEF
         73DYqp4mvAxjW5w6aoOCU914wrMaoCoIuSDG00pR4ArGfWWOJ5w4IxIx2ZJ3d8K2PaFQ
         aOyU/bdmaZpUB1KKuhSv/pmeR+Oq1mNIX/qar+qw9+KPGDsmqIbYHmsqq8KAW6qbF9ti
         H5h38VAJKRS4rKhTQa2bM4NYNb9olY3dK/IudtiHVVGmi3FZW/lfsKoeP8x007Sgl5Ft
         WFJA==
X-Gm-Message-State: AOAM533H9bKykexhgd9v1UU2GlpqlkJ2L1I/brbt7RO9LwtnQqjU557R
        BWSGdccs2VWR/bzX4I3bshw=
X-Google-Smtp-Source: ABdhPJySkkAFeiAd27mDgmoUE9tw3W94rJaHOLPZBbRrst+ymaFnUzDlKMhjico51M13z2959Urs6g==
X-Received: by 2002:a05:622a:293:: with SMTP id z19mr4905508qtw.309.1616305906600;
        Sat, 20 Mar 2021 22:51:46 -0700 (PDT)
Received: from tong-desktop.local ([2601:5c0:c200:27c6:f925:bb4b:54d2:533])
        by smtp.googlemail.com with ESMTPSA id n77sm8359502qkn.128.2021.03.20.22.51.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 22:51:46 -0700 (PDT)
From:   Tong Zhang <ztong0001@gmail.com>
To:     Scott Murray <scott@spiteful.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Tong Zhang <ztong0001@gmail.com>
Subject: [PATCH] PCI: hotplug: fix null-ptr-dereferencd in cpcihp error path
Date:   Sun, 21 Mar 2021 01:51:08 -0400
Message-Id: <20210321055109.322496-1-ztong0001@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is an issue in the error path, which cpci_thread may remain NULL.
Calling kthread_stop(cpci_thread) will trigger a BUG().
It is better to check whether the thread is really created and started
before stop it.

[    1.292859] BUG: kernel NULL pointer dereference, address: 0000000000000028
[    1.293252] #PF: supervisor write access in kernel mode
[    1.293533] #PF: error_code(0x0002) - not-present page
[    1.295163] RIP: 0010:kthread_stop+0x22/0x170
[    1.300491] Call Trace:
[    1.300628]  cpci_hp_unregister_controller+0xf6/0x130
[    1.300906]  zt5550_hc_init_one+0x27a/0x27f [cpcihp_zt5550]

Signed-off-by: Tong Zhang <ztong0001@gmail.com>
---
 drivers/pci/hotplug/cpci_hotplug_core.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index d0559d2faf50..b44da397d631 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -47,7 +47,7 @@ static atomic_t extracting;
 int cpci_debug;
 static struct cpci_hp_controller *controller;
 static struct task_struct *cpci_thread;
-static int thread_finished;
+static int thread_started;
 
 static int enable_slot(struct hotplug_slot *slot);
 static int disable_slot(struct hotplug_slot *slot);
@@ -447,7 +447,7 @@ event_thread(void *data)
 				msleep(500);
 			} else if (rc < 0) {
 				dbg("%s - error checking slots", __func__);
-				thread_finished = 1;
+				thread_started = 0;
 				goto out;
 			}
 		} while (atomic_read(&extracting) && !kthread_should_stop());
@@ -479,7 +479,7 @@ poll_thread(void *data)
 					msleep(500);
 				} else if (rc < 0) {
 					dbg("%s - error checking slots", __func__);
-					thread_finished = 1;
+					thread_started = 0;
 					goto out;
 				}
 			} while (atomic_read(&extracting) && !kthread_should_stop());
@@ -501,7 +501,7 @@ cpci_start_thread(void)
 		err("Can't start up our thread");
 		return PTR_ERR(cpci_thread);
 	}
-	thread_finished = 0;
+	thread_started = 1;
 	return 0;
 }
 
@@ -509,7 +509,7 @@ static void
 cpci_stop_thread(void)
 {
 	kthread_stop(cpci_thread);
-	thread_finished = 1;
+	thread_started = 0;
 }
 
 int
@@ -571,7 +571,7 @@ cpci_hp_unregister_controller(struct cpci_hp_controller *old_controller)
 	int status = 0;
 
 	if (controller) {
-		if (!thread_finished)
+		if (thread_started)
 			cpci_stop_thread();
 		if (controller->irq)
 			free_irq(controller->irq, controller->dev_id);
-- 
2.25.1

