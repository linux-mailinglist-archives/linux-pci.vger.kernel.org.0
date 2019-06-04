Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1F1F34A7F
	for <lists+linux-pci@lfdr.de>; Tue,  4 Jun 2019 16:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727204AbfFDOeR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 10:34:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:49582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727169AbfFDOeR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jun 2019 10:34:17 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6AB0824A3B
        for <linux-pci@vger.kernel.org>; Tue,  4 Jun 2019 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1559658856;
        bh=UntfhH8l0ccgDRl9YHHwrJYIlaIvptT94h07xeG7854=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ayZZ5lYqIdOerA/6UnZ8DZorQv/VVWoyqlkqdHfgqUppS6vVEZGOSprDoVLIUMhnG
         c63MitrWmcN6aPBJ4ld4HOK6DPHXoraR1Jj9Y2907ywCKwtZ4qbn5jN5E3znU2qSw/
         yeu2tFVVUimoTHG6LFIroBcCtxVCfAMzQHA+qwZw=
Received: by mail-oi1-f175.google.com with SMTP id b21so11774369oic.8
        for <linux-pci@vger.kernel.org>; Tue, 04 Jun 2019 07:34:16 -0700 (PDT)
X-Gm-Message-State: APjAAAUqcKj4lo54kVw9tDOFNpU5QRVVyaywYc31NjvVcAj24hsJDyRQ
        OWQG1MCrQ7MQthmqR7uU1QPxtto1gGinBtHLQYY=
X-Google-Smtp-Source: APXvYqxBIodGF9yl/ISpoOd5z/HUiarTpPQv1JQAUQ62/1K9/gjw5YcPBBHx4QsSOk/N0e06FOrCtoA3suzDF5piBr8=
X-Received: by 2002:aca:3942:: with SMTP id g63mr4261579oia.48.1559658855636;
 Tue, 04 Jun 2019 07:34:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:9d45:0:0:0:0:0 with HTTP; Tue, 4 Jun 2019 07:34:15 -0700 (PDT)
In-Reply-To: <a7dcc378-6101-ac08-ec8e-be7d5c183b49@huawei.com>
References: <a7dcc378-6101-ac08-ec8e-be7d5c183b49@huawei.com>
From:   Sinan Kaya <Okaya@kernel.org>
Date:   Tue, 4 Jun 2019 10:34:15 -0400
X-Gmail-Original-Message-ID: <CAK9iUCPREGruU7zGqnkS9w_x8Q7iE8twveEp2dn8ArupTTQyHA@mail.gmail.com>
Message-ID: <CAK9iUCPREGruU7zGqnkS9w_x8Q7iE8twveEp2dn8ArupTTQyHA@mail.gmail.com>
Subject: Re: Bug report: AER driver deadlock
To:     "Fangjian (Turing)" <f.fangjian@huawei.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 6/3/19, Fangjian (Turing) <f.fangjian@huawei.com> wrote:
> Hi, We met a deadlock triggered by a NONFATAL AER event during a sysfs
> "sriov_numvfs" operation. Any suggestion to fix such deadlock ?
>
>   enable one VF
>   # echo 1 > /sys/devices/pci0000:74/0000:74:00.0/0000:75:00.0/sriov_numvfs
>
>   The sysfs "sriov_numvfs" side is:
>
>     sriov_numvfs_store
>       device_lock                               # hold the device_lock
>         ...
>         pci_enable_sriov
>           sriov_enable
>             ...
>             pci_device_add
>               down_write(&pci_bus_sem) 	        # wait for
> up_read(&pci_bus_sem)
>
>   The AER side is:
>
>     pcie_do_recovery
>       pci_walk_bus
>         down_read(&pci_bus_sem)                 # hold the rw_semaphore
>         report_resume

Should we replace these device lock with try lock loop with some sleep
statements. This could solve the immediate deadlock issues until
someone implements granular locking in pci.

>           device_lock                           # wait for device_unlock()
>
> The calltrace is as below:
>
> [  258.411464] INFO: task kworker/0:1:13 blocked for more than 120 seconds.
> [  258.418139]       Tainted: G         C O      5.1.0-rc1-ge2e3ca0 #1
> [  258.424379] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> [  258.432172] kworker/0:1     D    0    13      2 0x00000028
> [  258.437640] Workqueue: events aer_recover_work_func
> [  258.442496] Call trace:
> [  258.444933]  __switch_to+0xb4/0x1b8
> [  258.448409]  __schedule+0x1ec/0x720
> [  258.451884]  schedule+0x38/0x90
> [  258.455012]  schedule_preempt_disabled+0x20/0x38
> [  258.459610]  __mutex_lock.isra.1+0x150/0x518
> [  258.463861]  __mutex_lock_slowpath+0x10/0x18
> [  258.468112]  mutex_lock+0x34/0x40
> [  258.471413]  report_resume+0x1c/0x78
> [  258.474973]  pci_walk_bus+0x58/0xb0
> [  258.478451]  pcie_do_recovery+0x18c/0x248
> [  258.482445]  aer_recover_work_func+0xe0/0x118
> [  258.486783]  process_one_work+0x1e4/0x468
> [  258.490776]  worker_thread+0x40/0x450
> [  258.494424]  kthread+0x128/0x130
> [  258.497639]  ret_from_fork+0x10/0x1c
> [  258.501329] INFO: task flr.sh:4534 blocked for more than 120 seconds.
> [  258.507742]       Tainted: G         C O      5.1.0-rc1-ge2e3ca0 #1
> [  258.513980] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
> [  258.521774] flr.sh          D    0  4534   4504 0x00000000
> [  258.527235] Call trace:
> [  258.529671]  __switch_to+0xb4/0x1b8
> [  258.533146]  __schedule+0x1ec/0x720
> [  258.536619]  schedule+0x38/0x90
> [  258.539749]  rwsem_down_write_failed+0x14c/0x210
> [  258.544347]  down_write+0x48/0x60
> [  258.547648]  pci_device_add+0x1a0/0x290
> [  258.551469]  pci_iov_add_virtfn+0x190/0x358
> [  258.555633]  sriov_enable+0x24c/0x480
> [  258.559279]  pci_enable_sriov+0x14/0x28
> [  258.563101]  hisi_zip_sriov_configure+0x64/0x100 [hisi_zip]
> [  258.568649]  sriov_numvfs_store+0xc4/0x190
> [  258.572728]  dev_attr_store+0x18/0x28
> [  258.576375]  sysfs_kf_write+0x3c/0x50
> [  258.580024]  kernfs_fop_write+0x114/0x1d8
> [  258.584018]  __vfs_write+0x18/0x38
> [  258.587404]  vfs_write+0xa4/0x1b0
> [  258.590705]  ksys_write+0x60/0xd8
> [  258.594007]  __arm64_sys_write+0x18/0x20
> [  258.597914]  el0_svc_common+0x5c/0x100
> [  258.601646]  el0_svc_handler+0x2c/0x80
> [  258.605381]  el0_svc+0x8/0xc
> [  379.243461] INFO: task kworker/0:1:13 blocked for more than 241 seconds.
> [  379.250134]       Tainted: G         C O      5.1.0-rc1-ge2e3ca0 #1
> [  379.256373] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> this message.
>
>
> Thank you,
> Jay
>
>
