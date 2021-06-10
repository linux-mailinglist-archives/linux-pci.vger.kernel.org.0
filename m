Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 735763A2290
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jun 2021 05:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbhFJDGe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 23:06:34 -0400
Received: from mail-pl1-f174.google.com ([209.85.214.174]:42853 "EHLO
        mail-pl1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbhFJDGe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jun 2021 23:06:34 -0400
Received: by mail-pl1-f174.google.com with SMTP id v13so200809ple.9;
        Wed, 09 Jun 2021 20:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=B8Zbm8iJYmqDKfwYU3NvGqWfWb4jFMFKhBBsq+CtUJM=;
        b=eCidbGM6f18dRikxKXcQJXT10LVogp0ILgExD75Acn6KTckWhtlBTJkE79HiFQ/e0M
         4dkAuvFsa5S3rj+R0RBRjjtnQ5huQ2LlkyjNJrWF91KiDT5ISYgAlGcSfTZnH6/0/KzH
         Q3M4dxennOlopKvTXcEfdmebRz3yy3X6JKkka3/dUyZGw9l/X+ade52JrSzzft+mODRd
         sSw+gPwUkevxcdgQluwWxV8VtBsbdWgNHs9IRpkzy6oYW1HS4opOJW0c7P1vhXD49zdO
         0yQSFvpvUGytxjQJMvmJRnOPeBkZijA4KLT3ZIBJqjAEFoS79MTpGhZPOso1q3rwpksw
         Oh5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=B8Zbm8iJYmqDKfwYU3NvGqWfWb4jFMFKhBBsq+CtUJM=;
        b=SW0m82J2KHqiU488z+kK3hzPVNeGtHG61jwCbIenTE4GJDROm4qjbN5Dhc+akxuc9N
         kI0FwlG9NVJJuvyiPcDOhX33WONKSOqsKQxrgxvRn+ASFENN0CVS/qz/U4GsvgJEUCOh
         c9UG+jB9DswyEXRjNgdjuVwc5hf8s5Kvw/7Tb6RBZECQEwddS8kLkbMDMcLN3ohyjkne
         hkzDuRankUnuVTz9M0yvv61zCW9OMfuC/wNi81kzmBFqzbhK5lxtAIZ1NYWt41RwOzD3
         F76On79HblLFSjVRVmach/rFUqUq4bf7WE5XYP/UsIO+8DbMf+ckoMcEzrfFphQH1pje
         8y0g==
X-Gm-Message-State: AOAM533zdxIWmfxeuT26pIiRDWWXsv41MxNoUAD3GKKZFTa/k2KA9IZt
        G0LXsGYIO242lvHVrqdniw==
X-Google-Smtp-Source: ABdhPJyYKE6rMFqcOPXMVeLvY7aWkzHOeJcjBR2+G6vcpaUZu3Hb669Of0JjSVYIGBVFJ6N4D9fgKA==
X-Received: by 2002:a17:902:b594:b029:f8:fb4f:f8d3 with SMTP id a20-20020a170902b594b02900f8fb4ff8d3mr2832626pls.25.1623294207367;
        Wed, 09 Jun 2021 20:03:27 -0700 (PDT)
Received: from vultr.guest ([107.191.53.97])
        by smtp.gmail.com with ESMTPSA id 23sm852892pjw.28.2021.06.09.20.03.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 20:03:26 -0700 (PDT)
From:   Zheyu Ma <zheyuma97@gmail.com>
To:     scott@spiteful.org, bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Zheyu Ma <zheyuma97@gmail.com>
Subject: [PATCH] PCI: hotplug: set 'thread_finished' flag to be true by default
Date:   Thu, 10 Jun 2021 03:02:41 +0000
Message-Id: <1623294161-7917-1-git-send-email-zheyuma97@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In the process of probing the driver 'cpcihp_zt5550', function
'pci_get_device' may fail, at this time 'cpci_hp_unregister_controller'
will be called. Since the default value of 'thread_finished' is 0,
'cpci_stop_thread' will be executed, but at this time 'cpci_thread' has
not been allocated, which leads to a null pointer dereference.

Fix this by set 'thread_finished' to be true by default.

This log reveals it:

BUG: kernel NULL pointer dereference, address: 0000000000000028
PGD 0 P4D 0
Oops: 0002 [#1] PREEMPT SMP PTI
CPU: 5 PID: 1 Comm: swapper/0 Not tainted 5.12.4-g70e7f0549188-dirty #74
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:kthread_stop+0x51/0x380
Code: b5 4e 10 00 65 8b 05 46 da e1 7e 89 c0 48 0f a3 05 5c c1 ef 05 0f 82 68 01 00 00 e8 99 4e 10 00 4c 8d 6b 28 41 bc 01 00 00 00 <f0> 44 0f c1 63 28 45 85 e4 0f 84 af 02 00 00 e8 7b 4e 10 00 45 85
RSP: 0000:ffffc90000017ba8 EFLAGS: 00010293
RAX: ffff888100850000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff811f3b37 RDI: ffffffff86259ca6
RBP: ffffc90000017bc8 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 00000000ffffffff R12: 0000000000000001
R13: 0000000000000028 R14: ffff88810160a0c8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88817b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 0000000006a32000 CR4: 00000000000006e0
Call Trace:
 cpci_stop_thread+0x1a/0x30
 cpci_hp_unregister_controller+0x43/0xc0
 zt5550_hc_init_one+0x67d/0x720
 local_pci_probe+0x4f/0xb0
 pci_device_probe+0x169/0x230
 ? pci_device_remove+0x110/0x110
 really_probe+0x283/0x650
 driver_probe_device+0x89/0x1d0
 ? mutex_lock_nested+0x1b/0x20
 device_driver_attach+0x68/0x70
 __driver_attach+0x11c/0x1b0
 ? device_driver_attach+0x70/0x70
 bus_for_each_dev+0xbb/0x110
 ? rdinit_setup+0x45/0x45
 driver_attach+0x27/0x30
 bus_add_driver+0x1eb/0x2a0
 driver_register+0xa9/0x180
 __pci_register_driver+0x7c/0x90
 ? cpci_hotplug_init+0x1c/0x1c
 zt5550_init+0x66/0x91
 do_one_initcall+0x7f/0x3d0
 ? rdinit_setup+0x45/0x45
 ? rcu_read_lock_sched_held+0x4f/0x80
 kernel_init_freeable+0x2d7/0x329
 ? rest_init+0x2c0/0x2c0
 kernel_init+0x18/0x190
 ? rest_init+0x2c0/0x2c0
 ? rest_init+0x2c0/0x2c0
 ret_from_fork+0x1f/0x30
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
CR2: 0000000000000028
---[ end trace ef108f49fd26a20c ]---
RIP: 0010:kthread_stop+0x51/0x380
Code: b5 4e 10 00 65 8b 05 46 da e1 7e 89 c0 48 0f a3 05 5c c1 ef 05 0f 82 68 01 00 00 e8 99 4e 10 00 4c 8d 6b 28 41 bc 01 00 00 00 <f0> 44 0f c1 63 28 45 85 e4 0f 84 af 02 00 00 e8 7b 4e 10 00 45 85
RSP: 0000:ffffc90000017ba8 EFLAGS: 00010293
RAX: ffff888100850000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff811f3b37 RDI: ffffffff86259ca6
RBP: ffffc90000017bc8 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000001 R11: 00000000ffffffff R12: 0000000000000001
R13: 0000000000000028 R14: ffff88810160a0c8 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88817b200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000028 CR3: 0000000006a32000 CR4: 00000000000006e0
Kernel panic - not syncing: Fatal exception
Dumping ftrace buffer:
   (ftrace buffer empty)
Kernel Offset: disabled
Rebooting in 1 seconds..

Signed-off-by: Zheyu Ma <zheyuma97@gmail.com>
---
 drivers/pci/hotplug/cpci_hotplug_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/hotplug/cpci_hotplug_core.c b/drivers/pci/hotplug/cpci_hotplug_core.c
index d0559d2faf50..d527aae4cc60 100644
--- a/drivers/pci/hotplug/cpci_hotplug_core.c
+++ b/drivers/pci/hotplug/cpci_hotplug_core.c
@@ -47,7 +47,7 @@ static atomic_t extracting;
 int cpci_debug;
 static struct cpci_hp_controller *controller;
 static struct task_struct *cpci_thread;
-static int thread_finished;
+static int thread_finished = 1;
 
 static int enable_slot(struct hotplug_slot *slot);
 static int disable_slot(struct hotplug_slot *slot);
-- 
2.17.6

