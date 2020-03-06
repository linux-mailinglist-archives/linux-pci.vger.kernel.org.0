Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7981917BA22
	for <lists+linux-pci@lfdr.de>; Fri,  6 Mar 2020 11:23:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726212AbgCFKXt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 6 Mar 2020 05:23:49 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:11599 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726070AbgCFKXt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 6 Mar 2020 05:23:49 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6A76D6FB8B7BB7F7983D;
        Fri,  6 Mar 2020 18:23:47 +0800 (CST)
Received: from localhost.localdomain (10.67.165.24) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.439.0; Fri, 6 Mar 2020 18:23:33 +0800
From:   Yicong Yang <yangyicong@hisilicon.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
CC:     <f.fangjian@huawei.com>, <huangdaode@huawei.com>
Subject: [PATCH] PCI: Change lock order in pci_dev_lock() to avoid potential deadlock
Date:   Fri, 6 Mar 2020 18:19:57 +0800
Message-ID: <1583489997-17156-1-git-send-email-yangyicong@hisilicon.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.67.165.24]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In pci_dev_lock(), we hold pci_lock for configuration access first,
then is device_lock. But in sriov enable routine, we hold device_lock
first and pci_lock subsequently. The inconsistent lock order  will have
potential deadlock problem.

In pci_dev_lock():
pci_dev_lock()
	pci_cfg_access_lock()
	device_lock()

When adding VF by sysfs:
sriov_numvfs_store()
	device_lock()
		...
		sriov_enable()
			pci_cfg_access_lock()

Adjust the lock order in pci_dev_lock(), pci_dev_trylock() and
pci_dev_unlock() to avoid potential deadlock condition.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---

I split this patch from the series sent in Jan as I reproduced the deadlock
contidion, by enable VFs of the function while perform flr through sysfs
interface.

The calltrace is like:
NFO: task kworker/0:2:404 blocked for more than 120 seconds.
[ 3517.118941] INFO: task kworker/0:2:404 blocked for more than 120 seconds.
[ 3517.125703]       Tainted: G           O      5.5.0-rc4-gda2956a #1
[ 3517.131946] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3517.139745] kworker/0:2     D    0   404      2 0x00000028
[ 3517.145216] Workqueue: events work_for_cpu_fn
[ 3517.149558] Call trace:
[ 3517.152004]  __switch_to+0xb4/0x200
[ 3517.155484]  __schedule+0x2e4/0x620
[ 3517.158963]  schedule+0x80/0x120
[ 3517.162178]  pci_wait_cfg+0x8c/0xd8
[ 3517.165654]  pci_cfg_access_lock+0x34/0x58
[ 3517.169736]  sriov_enable+0x1e4/0x430
[ 3517.173386]  pci_enable_sriov+0x30/0x48
[ 3517.177215]  hisi_qm_sriov_enable+0x60/0xf0 [hisi_qm]
[ 3517.182251]  sec_probe+0x278/0x5f8 [hisi_sec2]
[ 3517.186680]  local_pci_probe+0x44/0x98
[ 3517.190416]  work_for_cpu_fn+0x20/0x30
[ 3517.194153]  process_one_work+0x158/0x4b8
[ 3517.198149]  worker_thread+0x21c/0x498
[ 3517.201885]  kthread+0xfc/0x128
[ 3517.205016]  ret_from_fork+0x10/0x1c
[ 3517.208708] INFO: task bash:7025 blocked for more than 120 seconds.
[ 3517.214951]       Tainted: G           O      5.5.0-rc4-gda2956a #1
[ 3517.221192] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
[ 3517.228989] bash            D    0  7025   5082 0x00000200
[ 3517.234455] Call trace:
[ 3517.236897]  __switch_to+0xb4/0x200
[ 3517.240373]  __schedule+0x2e4/0x620
[ 3517.243850]  schedule+0x80/0x120
[ 3517.247068]  schedule_preempt_disabled+0x28/0x40
[ 3517.251668]  __mutex_lock.isra.9+0x24c/0x560
[ 3517.255927]  __mutex_lock_slowpath+0x24/0x30
[ 3517.260182]  mutex_lock+0x5c/0x68
[ 3517.263487]  pci_reset_function+0x38/0x80
[ 3517.267483]  reset_store+0x70/0xc0
[ 3517.270870]  dev_attr_store+0x44/0x60
[ 3517.274521]  sysfs_kf_write+0x5c/0x78
[ 3517.278171]  kernfs_fop_write+0x104/0x210
[ 3517.282168]  __vfs_write+0x48/0x90
[ 3517.285560]  vfs_write+0xbc/0x1c8
[ 3517.288864]  ksys_write+0x74/0x100
[ 3517.292256]  __arm64_sys_write+0x24/0x30
[ 3517.296167]  el0_svc_common.constprop.3+0x110/0x200
[ 3517.301029]  el0_svc_handler+0x34/0xa0
[ 3517.304765]  el0_svc+0x14/0x40
[ 3517.307810]  el0_sync_handler+0xb0/0x28c
[ 3517.311720]  el0_sync+0x140/0x180

 drivers/pci/pci.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d828ca8..4abfbad 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4880,18 +4880,19 @@ static int pci_dev_reset_slot_function(struct pci_dev *dev, int probe)

 static void pci_dev_lock(struct pci_dev *dev)
 {
-	pci_cfg_access_lock(dev);
 	/* block PM suspend, driver probe, etc. */
 	device_lock(&dev->dev);
+
+	pci_cfg_access_lock(dev);
 }

 /* Return 1 on successful lock, 0 on contention */
 static int pci_dev_trylock(struct pci_dev *dev)
 {
-	if (pci_cfg_access_trylock(dev)) {
-		if (device_trylock(&dev->dev))
+	if (device_trylock(&dev->dev)) {
+		if (pci_cfg_access_trylock(dev))
 			return 1;
-		pci_cfg_access_unlock(dev);
+		device_unlock(&dev->dev);
 	}

 	return 0;
@@ -4899,8 +4900,8 @@ static int pci_dev_trylock(struct pci_dev *dev)

 static void pci_dev_unlock(struct pci_dev *dev)
 {
-	device_unlock(&dev->dev);
 	pci_cfg_access_unlock(dev);
+	device_unlock(&dev->dev);
 }

 static void pci_dev_save_and_disable(struct pci_dev *dev)
--
2.8.1

