Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B81E35483
	for <lists+linux-pci@lfdr.de>; Wed,  5 Jun 2019 01:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726354AbfFDXrS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 4 Jun 2019 19:47:18 -0400
Received: from gate.crashing.org ([63.228.1.57]:40263 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726269AbfFDXrR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 4 Jun 2019 19:47:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x54Nl3in020903;
        Tue, 4 Jun 2019 18:47:03 -0500
Message-ID: <a1c90cfb9ce4062b4823c6647d7709baf1c5534f.camel@kernel.crashing.org>
Subject: Re: Bug report: AER driver deadlock
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Sinan Kaya <Okaya@kernel.org>,
        "Fangjian (Turing)" <f.fangjian@huawei.com>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Date:   Wed, 05 Jun 2019 09:47:02 +1000
In-Reply-To: <CAK9iUCPREGruU7zGqnkS9w_x8Q7iE8twveEp2dn8ArupTTQyHA@mail.gmail.com>
References: <a7dcc378-6101-ac08-ec8e-be7d5c183b49@huawei.com>
         <CAK9iUCPREGruU7zGqnkS9w_x8Q7iE8twveEp2dn8ArupTTQyHA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 2019-06-04 at 10:34 -0400, Sinan Kaya wrote:
> On 6/3/19, Fangjian (Turing) <f.fangjian@huawei.com> wrote:
> > Hi, We met a deadlock triggered by a NONFATAL AER event during a sysfs
> > "sriov_numvfs" operation. Any suggestion to fix such deadlock ?
> > 
> >   enable one VF
> >   # echo 1 > /sys/devices/pci0000:74/0000:74:00.0/0000:75:00.0/sriov_numvfs
> > 
> >   The sysfs "sriov_numvfs" side is:
> > 
> >     sriov_numvfs_store
> >       device_lock                               # hold the device_lock
> >         ...
> >         pci_enable_sriov
> >           sriov_enable
> >             ...
> >             pci_device_add
> >               down_write(&pci_bus_sem) 	        # wait for
> > up_read(&pci_bus_sem)
> > 
> >   The AER side is:
> > 
> >     pcie_do_recovery
> >       pci_walk_bus
> >         down_read(&pci_bus_sem)                 # hold the rw_semaphore
> >         report_resume
> 
> Should we replace these device lock with try lock loop with some sleep
> statements. This could solve the immediate deadlock issues until
> someone implements granular locking in pci.

That won't necessarily solve this AB->BA problem. I think the issue
here is that sriov shouldn't device_lock before doing something that
can take the pci_bus_sem.

Ben.


> >           device_lock                           # wait for device_unlock()
> > 
> > The calltrace is as below:
> > 
> > [  258.411464] INFO: task kworker/0:1:13 blocked for more than 120 seconds.
> > [  258.418139]       Tainted: G         C O      5.1.0-rc1-ge2e3ca0 #1
> > [  258.424379] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this message.
> > [  258.432172] kworker/0:1     D    0    13      2 0x00000028
> > [  258.437640] Workqueue: events aer_recover_work_func
> > [  258.442496] Call trace:
> > [  258.444933]  __switch_to+0xb4/0x1b8
> > [  258.448409]  __schedule+0x1ec/0x720
> > [  258.451884]  schedule+0x38/0x90
> > [  258.455012]  schedule_preempt_disabled+0x20/0x38
> > [  258.459610]  __mutex_lock.isra.1+0x150/0x518
> > [  258.463861]  __mutex_lock_slowpath+0x10/0x18
> > [  258.468112]  mutex_lock+0x34/0x40
> > [  258.471413]  report_resume+0x1c/0x78
> > [  258.474973]  pci_walk_bus+0x58/0xb0
> > [  258.478451]  pcie_do_recovery+0x18c/0x248
> > [  258.482445]  aer_recover_work_func+0xe0/0x118
> > [  258.486783]  process_one_work+0x1e4/0x468
> > [  258.490776]  worker_thread+0x40/0x450
> > [  258.494424]  kthread+0x128/0x130
> > [  258.497639]  ret_from_fork+0x10/0x1c
> > [  258.501329] INFO: task flr.sh:4534 blocked for more than 120 seconds.
> > [  258.507742]       Tainted: G         C O      5.1.0-rc1-ge2e3ca0 #1
> > [  258.513980] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this message.
> > [  258.521774] flr.sh          D    0  4534   4504 0x00000000
> > [  258.527235] Call trace:
> > [  258.529671]  __switch_to+0xb4/0x1b8
> > [  258.533146]  __schedule+0x1ec/0x720
> > [  258.536619]  schedule+0x38/0x90
> > [  258.539749]  rwsem_down_write_failed+0x14c/0x210
> > [  258.544347]  down_write+0x48/0x60
> > [  258.547648]  pci_device_add+0x1a0/0x290
> > [  258.551469]  pci_iov_add_virtfn+0x190/0x358
> > [  258.555633]  sriov_enable+0x24c/0x480
> > [  258.559279]  pci_enable_sriov+0x14/0x28
> > [  258.563101]  hisi_zip_sriov_configure+0x64/0x100 [hisi_zip]
> > [  258.568649]  sriov_numvfs_store+0xc4/0x190
> > [  258.572728]  dev_attr_store+0x18/0x28
> > [  258.576375]  sysfs_kf_write+0x3c/0x50
> > [  258.580024]  kernfs_fop_write+0x114/0x1d8
> > [  258.584018]  __vfs_write+0x18/0x38
> > [  258.587404]  vfs_write+0xa4/0x1b0
> > [  258.590705]  ksys_write+0x60/0xd8
> > [  258.594007]  __arm64_sys_write+0x18/0x20
> > [  258.597914]  el0_svc_common+0x5c/0x100
> > [  258.601646]  el0_svc_handler+0x2c/0x80
> > [  258.605381]  el0_svc+0x8/0xc
> > [  379.243461] INFO: task kworker/0:1:13 blocked for more than 241 seconds.
> > [  379.250134]       Tainted: G         C O      5.1.0-rc1-ge2e3ca0 #1
> > [  379.256373] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables
> > this message.
> > 
> > 
> > Thank you,
> > Jay
> > 
> > 

