Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D641F9A4C
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jun 2020 16:33:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730230AbgFOOdA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 15 Jun 2020 10:33:00 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:42920 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729962AbgFOOdA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 15 Jun 2020 10:33:00 -0400
Received: from mail-qt1-f197.google.com ([209.85.160.197])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <ian.may@canonical.com>)
        id 1jkqAU-0002KY-2e
        for linux-pci@vger.kernel.org; Mon, 15 Jun 2020 14:32:58 +0000
Received: by mail-qt1-f197.google.com with SMTP id l26so14161735qtr.14
        for <linux-pci@vger.kernel.org>; Mon, 15 Jun 2020 07:32:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gb0UUOLXLFZJds410qPnvr26vjFCoE513Vz1hWXwAAQ=;
        b=QOw5qfTQ600qykAeVGtvECle+fqYU1VoHln0jxG6vOcjizjC7/Yk5or3ZQzrj1f7+J
         otyKe2jRNFgpGkWl+Z3cYYhwHwMWGt+ALJpBc3rn+fBnqGh7NmoM9Gzzg1ewoBWGxzLd
         5v6pbzgdtSKT1wBjCgSiBaFLuy51vNVcSLN5M6JFTOAUZwKN5t6eFslEtNPCrfQVzS2D
         pOAu61Vn0rlj08Tbm/hTfp8AW9lwKu2//VYfbpex2mD0QlGJQc9GckIf/M0+T6Edap71
         E78GroVtHI3q4Btpb+/GJqdiSJlCFBetvefZ4daXie9AUOHPZ/OhSrLGx2lwAUF/FS+i
         JUbQ==
X-Gm-Message-State: AOAM531btAuSXhyNj4axdiHYuHuCW0RL0DlsEALGKM3+8xtWmJlrr64P
        gwTkPs8e+uI+9J6LKHh1WJvoMoGsqu1peKk4ATGIanHqgCsfLn5L/p87ZpJd2wub4+4RbLmq/tk
        61/7dl877qshLiAlqJvUqeNGqFtYqCcy4WjWMzg==
X-Received: by 2002:a37:e16:: with SMTP id 22mr15615095qko.391.1592231576652;
        Mon, 15 Jun 2020 07:32:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyyue9PfAKSGhfMDC/Fp+k5qRlr1yIBm/J9EIkI2pNyRPJLxntsPjv3jdo1llMCxYQfhDfhhQ==
X-Received: by 2002:a37:e16:: with SMTP id 22mr15615061qko.391.1592231576240;
        Mon, 15 Jun 2020 07:32:56 -0700 (PDT)
Received: from localhost.localdomain ([2001:67c:1562:8007::aac:44bb])
        by smtp.gmail.com with ESMTPSA id u10sm12744675qth.32.2020.06.15.07.32.54
        for <linux-pci@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2020 07:32:55 -0700 (PDT)
From:   Ian May <ian.may@canonical.com>
To:     linux-pci@vger.kernel.org
Subject: [PATCH 0/2] Hotplug interrupt and AER recovery deadlocks
Date:   Mon, 15 Jun 2020 09:32:48 -0500
Message-Id: <20200615143250.438252-1-ian.may@canonical.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

We've encountered two deadlocks when the hotplug interrupt and AER
recovery trigger simultaneously on the same device.  The first
deadlock is with:

       Hotplug                                AER
----------------------------       ---------------------------
device_lock(&dev->dev)             down_write(&ctrl->reset_lock)
down_read(&ctrl->reset_lock)       device_lock(&dev->dev)

//Hotplug
[  637.084657] Call Trace:
[  637.084669]  __schedule+0x2a8/0x670
[  637.084670]  schedule+0x33/0xa0
[  637.084672]  schedule_preempt_disabled+0xe/0x10
[  637.084673]  __mutex_lock.isra.9+0x26d/0x4e0
[  637.084674]  __mutex_lock_slowpath+0x13/0x20
[  637.084675]  ? __mutex_lock_slowpath+0x13/0x20
[  637.084675]  mutex_lock+0x2f/0x40                 <---mutex_lock(&dev->mutex);
[  637.084678]  __device_driver_lock+0x2b/0x50
[  637.084679]  device_release_driver_internal+0x1f/0x1b0
[  637.084680]  device_release_driver+0x12/0x20
[  637.084680]  bus_remove_device+0xe1/0x150
[  637.084682]  device_del+0x16a/0x3a0
[  637.084687]  pci_remove_bus_device+0x7e/0x100
[  637.084690]  pci_stop_and_remove_bus_device+0x1a/0x20
[  637.084691]  pciehp_unconfigure_device+0x80/0x130
[  637.084692]  pciehp_disable_slot+0x6e/0x120
[  637.084694]  pciehp_handle_presence_or_link_change+0x76/0x470
[  637.084696]  pciehp_ist+0x14a/0x1e0               <---down_read(&ctrl->reset_lock);

//AER
[  637.110208] Call Trace:
[  637.110209]  __schedule+0x2a8/0x670
[  637.110213]  ? sched_clock+0x9/0x10
[  637.110222]  schedule+0x33/0xa0
[  637.110230]  rwsem_down_write_slowpath+0x233/0x4a0
[  637.110237]  ? __schedule+0x2b0/0x670
[  637.110239]  down_write+0x3d/0x40
[  637.110241]  ? down_write+0x3d/0x40               <---down_write(&ctrl->reset_lock)
[  637.110245]  pciehp_reset_slot+0x58/0x150
[  637.110250]  pci_reset_hotplug_slot+0x43/0x70
[  637.110256]  pci_slot_reset+0x12f/0x170           <---mutex_lock(&dev->mutex);
[  637.110264]  pci_bus_error_reset+0xac/0xd0
[  637.110266]  pcie_do_recovery+0x255/0x2c0
[  637.110267]  aer_recover_work_func+0xd2/0x100
[  637.110270]  process_one_work+0x1fd/0x3f0
[  637.110279]  worker_thread+0x34/0x410
[  637.110287]  kthread+0x121/0x140
[  637.110288]  ? process_one_work+0x3f0/0x3f0
[  637.110289]  ? kthread_park+0xb0/0xb0
[  637.110290]  ret_from_fork+0x22/0x40

Applying the first patch then exposes the following 2nd deadlock:

           Hotplug                                AER
----------------------------       ---------------------------
down_read(&ctrl->reset_lock)       mutex_lock(&pci_slot_mutex)
mutex_lock(&pci_slot_mutex)        down_write(&ctrl->reset_lock)

//Hotplug
[  391.250990] INFO: task irq/42-pciehp:1960 blocked for more than 120 seconds.
[  391.259086]       Tainted: P           OE     5.3.0-51-generic #44~18.04.2
[  391.266982] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  391.275977] irq/42-pciehp   D    0  1960      2 0x80004000
[  391.275979] Call Trace:
[  391.275986]  __schedule+0x2b9/0x6c0
[  391.275987]  ? __switch_to_asm+0x34/0x70
[  391.275989]  schedule+0x42/0xb0
[  391.275992]  schedule_preempt_disabled+0xe/0x10
[  391.275997]  __mutex_lock.isra.0+0x182/0x4f0
[  391.276003]  ? raw_pci_read+0x29/0x40
[  391.276005]  ? pci_read+0x2c/0x30
[  391.276010]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  391.276015]  __mutex_lock_slowpath+0x13/0x20
[  391.276017]  mutex_lock+0x2e/0x40                    <---pci_slot_mutex
[  391.276021]  pci_dev_assign_slot+0x19/0x5f
[  391.276025]  pci_setup_device+0xc1/0x150
[  391.276029]  ? online_show+0x20/0x70
[  391.276034]  ? irq_finalize_oneshot.part.0+0xf0/0xf0
[  391.276035]  pci_scan_single_device+0x95/0xd0
[  391.276041]  pci_scan_slot+0x4a/0x110
[  391.276042]  pciehp_configure_device+0x40/0x120
[  391.276044]  pciehp_handle_presence_or_link_change+0x184/0x290
[  391.276049]  pciehp_ist+0x141/0x150                  <---ctrl->reset_lock
[  391.276055]  irq_thread_fn+0x28/0x60
[  391.276056]  irq_thread+0xda/0x170
[  391.276057]  ? irq_forced_thread_fn+0x80/0x80
[  391.276059]  kthread+0x104/0x140
[  391.276060]  ? irq_thread_check_affinity+0xf0/0xf0
[  391.276061]  ? kthread_park+0x80/0x80
[  391.276062]  ret_from_fork+0x22/0x40

//AER
[  391.225984] INFO: task kworker/39:1:1593 blocked for more than 120 seconds.
[  391.233989]       Tainted: P           OE     5.3.0-51-generic #44~18.04.2
[  391.241887] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[  391.250882] kworker/39:1    D    0  1593      2 0x80004000
[  391.250890] Workqueue: events aer_recover_work_func
[  391.250893] Call Trace:
[  391.250899]  __schedule+0x2b9/0x6c0
[  391.250902]  ? sched_clock+0x9/0x10
[  391.250903]  schedule+0x42/0xb0
[  391.250906]  rwsem_down_write_slowpath+0x23a/0x4c0
[  391.250908]  down_write+0x41/0x50
[  391.250909]  pciehp_reset_lock+0x12/0x20
[  391.250911]  pci_slot_reset+0xa1/0x170              <---ctrl->reset_lock
[  391.250912]  pci_bus_error_reset+0xfb/0x130         <---pci_slot_mutex
[  391.250914]  pcie_do_recovery+0x238/0x264
[  391.250917]  aer_recover_work_func.cold+0x9a/0xa0
[  391.250919]  process_one_work+0x1da/0x390
[  391.250920]  worker_thread+0x4d/0x400
[  391.250923]  kthread+0x104/0x140
[  391.250924]  ? process_one_work+0x390/0x390
[  391.250925]  ? kthread_park+0x80/0x80
[  391.250927]  ret_from_fork+0x22/0x40

The 2nd patch is unlocking and locking the pci_slot mutex in the AER path around
the controller reset call.  This allows for both the Hotplug and AER execution 
to complete.

Ian May (2):
  PCIe hotplug interrupt and AER deadlock with reset_lock and
    device_lock
  PCIe hotplug interrupt and AER pci_slot_mutex deadlock

 drivers/pci/hotplug/pciehp.h      |  2 ++
 drivers/pci/hotplug/pciehp_core.c |  2 ++
 drivers/pci/hotplug/pciehp_hpc.c  | 21 ++++++++++++++++++---
 drivers/pci/pci.c                 |  8 ++++++++
 include/linux/pci_hotplug.h       |  2 ++
 5 files changed, 32 insertions(+), 3 deletions(-)

-- 
2.25.1

