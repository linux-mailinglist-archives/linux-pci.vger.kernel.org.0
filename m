Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420B2260C82
	for <lists+linux-pci@lfdr.de>; Tue,  8 Sep 2020 09:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729597AbgIHHxe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 8 Sep 2020 03:53:34 -0400
Received: from mga05.intel.com ([192.55.52.43]:24972 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729626AbgIHHxa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 8 Sep 2020 03:53:30 -0400
IronPort-SDR: 0YjoJs1hM9DwdiruAnPIvwo0WlEpJGiLNxpX8KGbpUJ3fcCfOzchnB9OBoOeDDWWYCg7s2LTUF
 6gehLUXyB5dg==
X-IronPort-AV: E=McAfee;i="6000,8403,9737"; a="242904894"
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="242904894"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 00:53:28 -0700
IronPort-SDR: BuFM1i5Y5AkbylUyRAM+bpBZfIGnMaYUAyO3gG00kQKKYBasWA45z0GI4xmsjLj4+SSm9G2t+4
 pNI/MXoVKXKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,405,1592895600"; 
   d="scan'208";a="479917057"
Received: from shskylake.sh.intel.com ([10.239.48.137])
  by orsmga005.jf.intel.com with ESMTP; 08 Sep 2020 00:53:21 -0700
From:   Ethan Zhao <haifeng.zhao@intel.com>
To:     axboe@kernel.dk, bhelgaas@google.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, mcgrof@kernel.org,
        ShanshanX.Zhang@intel.com, pei.p.jia@intel.com,
        Ethan Zhao <Haifeng.Zhao@intel.com>
Subject: [PATCH] Revert "block: revert back to synchronous request_queue removal"
Date:   Tue,  8 Sep 2020 03:50:48 -0400
Message-Id: <20200908075047.5140-1-haifeng.zhao@intel.com>
X-Mailer: git-send-email 2.18.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ethan Zhao <Haifeng.Zhao@intel.com>

'commit e8c7d14ac6c3 ("block: revert back to synchronous request_queue
removal")' introduced panic issue to NVMe hotplug as following(hit
after just 2 times NVMe SSD hotplug under stable 5.9-RC2):

BUG: sleeping function called from invalid context at block/genhd.c:1563
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 0, name: swapper/30
INFO: lockdep is turned off.
CPU: 30 PID: 0 Comm: swapper/30 Tainted: G S      W         5.9.0-RC2 #3
Hardware name: Intel Corporation xxxxxxxx
Call Trace:
<IRQ>
dump_stack+0x9d/0xe0
___might_sleep.cold.79+0x17f/0x1af
disk_release+0x26/0x200
device_release+0x6d/0x1c0
kobject_put+0x14d/0x430
hd_struct_free+0xfb/0x260
percpu_ref_switch_to_atomic_rcu+0x3d1/0x580
? rcu_nocb_unlock_irqrestore+0xb6/0xf0
? trace_hardirqs_on+0x20/0x1b5
? rcu_do_batch+0x3ff/0xb50
rcu_do_batch+0x47c/0xb50
? rcu_accelerate_cbs+0xa9/0x740
? rcu_spawn_one_nocb_kthread+0x3d0/0x3d0
rcu_core+0x945/0xd90
? __do_softirq+0x182/0xac0
__do_softirq+0x1ca/0xac0
asm_call_on_stack+0xf/0x20
</IRQ>
do_softirq_own_stack+0x7f/0x90
irq_exit_rcu+0x1e3/0x230
sysvec_apic_timer_interrupt+0x48/0xb0
asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:cpuidle_enter_state+0x116/0xe90
Code: 00 31 ff e8 ac c8 a4 fe 80 7c 24 10 00 74 12 9c 58 f6 c4 02
 0f 85 7e 08 00 00 31 ff e8 43 ca be fe e8 ae a3 d5 fe fb 45 85 ed
 <0f> 88 4e 05 00 00 4d 63 f5 49 83 fe 09 0f 87 29 0b 00 00 4b 8d 04
RSP: 0018:ff110001040dfd78 EFLAGS: 00000206
RAX: 0000000000000007 RBX: ffd1fff7b1a01e00 RCX: 000000000000001f
RDX: 0000000000000000 RSI: 0000000040000000 RDI: ffffffffb7c5c0f2
RBP: ffffffffb9a416a0 R08: 0000000000000000 R09: 0000000000000000
R10: ff110001040d0007 R11: ffe21c002081a000 R12: 0000000000000003
R13: 0000000000000003 R14: 0000000000000138
... ...
BUG: kernel NULL pointer dereference, address: 0000000000000000
PGD 0
Oops: 0010 [#1] SMP KASAN NOPTI
CPU: 30 PID: 500 Comm: irq/124-pciehp Tainted: G S  W  5.9.0-RC2 #3
Hardware name: Intel Corporation xxxxxxxx
RIP: 0010:0x0
Code: Bad RIP value.
RSP: 0018:ff110007d5ba75e8 EFLAGS: 00010096
RAX: 0000000000000000 RBX: ff110001040d0000 RCX: ff110007d5ba7668
RDX: 0000000000000009 RSI: ff110001040d0000 RDI: ff110008119f59c0
RBP: ff110008119f59c0 R08: fffffbfff73f7b4d R09: fffffbfff73f7b4d
R10: ffffffffb9fbda67 R11: fffffbfff73f7b4c R12: 0000000000000000
R13: ff110007d5ba7668 R14: ff110001040d0000 R15: ff110008119f59c0
FS:  0000000000000000(0000) GS:ff11000811800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffffffffffd6 CR3: 00000007cea16002 CR4: 0000000000771ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
ttwu_do_activate+0xd3/0x160
try_to_wake_up+0x652/0x1850
? migrate_swap_stop+0xad0/0xad0
? lock_contended+0xd70/0xd70
? rcu_read_unlock+0x50/0x50
? rcu_do_batch+0x3ff/0xb50
swake_up_locked+0x85/0x1c0
complete+0x4d/0x70
rcu_do_batch+0x47c/0xb50
? rcu_spawn_one_nocb_kthread+0x3d0/0x3d0
rcu_core+0x945/0xd90
? __do_softirq+0x182/0xac0
__do_softirq+0x1ca/0xac0
irq_exit_rcu+0x1e3/0x230
sysvec_apic_timer_interrupt+0x48/0xb0
asm_sysvec_apic_timer_interrupt+0x12/0x20
RIP: 0010:_raw_spin_unlock_irqrestore+0x40/0x50
Code: e8 35 ad 36 fe 48 89 ef e8 cd ce 37 fe f6 c7 02 75 11 53 9d
 e8 91 1f 5c fe 65 ff 0d ba af c2 47 5b 5d c3 e8 d2 22 5c fe 53 9d
 <eb> ed 0f 1f 40 00 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 53
RSP: 0018:ff110007d5ba79d0 EFLAGS: 00000293
RAX: 0000000000000007 RBX: 0000000000000293 RCX: ffffffffb67710d4
RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffffffffb83f41ce
RBP: ffffffffbb77e740 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffbb77e743 R11: fffffbfff76efce8 R12: 000000000000198e
R13: ff11001031d7a0b0 R14: ffffffffbb77e740 R15: ffffffffbb77e788
? do_raw_spin_unlock+0x54/0x230
? _raw_spin_unlock_irqrestore+0x3e/0x50
dma_debug_device_change+0x150/0x5e0
notifier_call_chain+0x90/0x160
__blocking_notifier_call_chain+0x6d/0xa0
device_release_driver_internal+0x37d/0x490
pci_stop_bus_device+0x123/0x190
pci_stop_and_remove_bus_device+0xe/0x20
pciehp_unconfigure_device+0x17e/0x330
? pciehp_configure_device+0x3e0/0x3e0
? trace_hardirqs_on+0x20/0x1b5
pciehp_disable_slot+0x101/0x360
? pme_is_native.cold.2+0x29/0x29
pciehp_handle_presence_or_link_change+0x1ac/0xee0
? pciehp_handle_disable_request+0x110/0x110
pciehp_ist.cold.11+0x39/0x54
? pciehp_set_indicators+0x190/0x190
? alloc_desc+0x510/0xa30
? irq_set_affinity_notifier+0x380/0x380
? pciehp_set_indicators+0x190/0x190
? irq_thread+0x137/0x420
irq_thread_fn+0x86/0x150
irq_thread+0x21f/0x420
? irq_forced_thread_fn+0x170/0x170
? irq_thread_check_affinity+0x210/0x210
? __kthread_parkme+0x52/0x1a0
? lockdep_hardirqs_on_prepare+0x33e/0x4e0
? _raw_spin_unlock_irqrestore+0x3e/0x50
? trace_hardirqs_on+0x20/0x1b5
? wake_threads_waitq+0x40/0x40
? __kthread_parkme+0xd1/0x1a0
? irq_thread_check_affinity+0x210/0x210
kthread+0x36a/0x430
? kthread_create_worker_on_cpu+0xc0/0xc0
ret_from_fork+0x1f/0x30
... ...
CR2: 0000000000000000
---[ end trace cedc4047ef91d2ec ]---

Seems scheduling happened within hardware interrupt context, after
reverted this patch, stable 5.9-RC4 build was tested with more than 20
times NVMe SSD hotplug, no panic found.

This reverts commit e8c7d14ac6c37c173ec606907d38802b00302988.

Tested-by: Shanshan Zhang <ShanshanX.Zhang@intel.com>
Signed-off-by: Ethan Zhao <Haifeng.Zhao@intel.com>
---
 block/blk-core.c       |  8 --------
 block/blk-sysfs.c      | 43 +++++++++++++++++++++---------------------
 block/genhd.c          | 17 -----------------
 include/linux/blkdev.h |  2 ++
 4 files changed, 23 insertions(+), 47 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 10c08ac50697..1b18a0ef5db1 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -325,9 +325,6 @@ EXPORT_SYMBOL_GPL(blk_clear_pm_only);
  *
  * Decrements the refcount of the request_queue kobject. When this reaches 0
  * we'll have blk_release_queue() called.
- *
- * Context: Any context, but the last reference must not be dropped from
- *          atomic context.
  */
 void blk_put_queue(struct request_queue *q)
 {
@@ -360,14 +357,9 @@ EXPORT_SYMBOL_GPL(blk_set_queue_dying);
  *
  * Mark @q DYING, drain all pending requests, mark @q DEAD, destroy and
  * put it.  All future requests will be failed immediately with -ENODEV.
- *
- * Context: can sleep
  */
 void blk_cleanup_queue(struct request_queue *q)
 {
-	/* cannot be called from atomic context */
-	might_sleep();
-
 	WARN_ON_ONCE(blk_queue_registered(q));
 
 	/* mark @q DYING, no new request or merges will be allowed afterwards */
diff --git a/block/blk-sysfs.c b/block/blk-sysfs.c
index 7dda709f3ccb..eb347cbe0f93 100644
--- a/block/blk-sysfs.c
+++ b/block/blk-sysfs.c
@@ -901,32 +901,22 @@ static void blk_exit_queue(struct request_queue *q)
 	bdi_put(q->backing_dev_info);
 }
 
+
 /**
- * blk_release_queue - releases all allocated resources of the request_queue
- * @kobj: pointer to a kobject, whose container is a request_queue
- *
- * This function releases all allocated resources of the request queue.
- *
- * The struct request_queue refcount is incremented with blk_get_queue() and
- * decremented with blk_put_queue(). Once the refcount reaches 0 this function
- * is called.
- *
- * For drivers that have a request_queue on a gendisk and added with
- * __device_add_disk() the refcount to request_queue will reach 0 with
- * the last put_disk() called by the driver. For drivers which don't use
- * __device_add_disk() this happens with blk_cleanup_queue().
+ * __blk_release_queue - release a request queue
+ * @work: pointer to the release_work member of the request queue to be released
  *
- * Drivers exist which depend on the release of the request_queue to be
- * synchronous, it should not be deferred.
- *
- * Context: can sleep
+ * Description:
+ *     This function is called when a block device is being unregistered. The
+ *     process of releasing a request queue starts with blk_cleanup_queue, which
+ *     set the appropriate flags and then calls blk_put_queue, that decrements
+ *     the reference counter of the request queue. Once the reference counter
+ *     of the request queue reaches zero, blk_release_queue is called to release
+ *     all allocated resources of the request queue.
  */
-static void blk_release_queue(struct kobject *kobj)
+static void __blk_release_queue(struct work_struct *work)
 {
-	struct request_queue *q =
-		container_of(kobj, struct request_queue, kobj);
-
-	might_sleep();
+	struct request_queue *q = container_of(work, typeof(*q), release_work);
 
 	if (test_bit(QUEUE_FLAG_POLL_STATS, &q->queue_flags))
 		blk_stat_remove_callback(q, q->poll_cb);
@@ -958,6 +948,15 @@ static void blk_release_queue(struct kobject *kobj)
 	call_rcu(&q->rcu_head, blk_free_queue_rcu);
 }
 
+static void blk_release_queue(struct kobject *kobj)
+{
+	struct request_queue *q =
+		container_of(kobj, struct request_queue, kobj);
+
+	INIT_WORK(&q->release_work, __blk_release_queue);
+	schedule_work(&q->release_work);
+}
+
 static const struct sysfs_ops queue_sysfs_ops = {
 	.show	= queue_attr_show,
 	.store	= queue_attr_store,
diff --git a/block/genhd.c b/block/genhd.c
index 99c64641c314..7e2edf388c8a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -887,19 +887,12 @@ static void invalidate_partition(struct gendisk *disk, int partno)
  * The final removal of the struct gendisk happens when its refcount reaches 0
  * with put_disk(), which should be called after del_gendisk(), if
  * __device_add_disk() was used.
- *
- * Drivers exist which depend on the release of the gendisk to be synchronous,
- * it should not be deferred.
- *
- * Context: can sleep
  */
 void del_gendisk(struct gendisk *disk)
 {
 	struct disk_part_iter piter;
 	struct hd_struct *part;
 
-	might_sleep();
-
 	blk_integrity_del(disk);
 	disk_del_events(disk);
 
@@ -1553,15 +1546,11 @@ int disk_expand_part_tbl(struct gendisk *disk, int partno)
  * drivers we also call blk_put_queue() for them, and we expect the
  * request_queue refcount to reach 0 at this point, and so the request_queue
  * will also be freed prior to the disk.
- *
- * Context: can sleep
  */
 static void disk_release(struct device *dev)
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	might_sleep();
-
 	blk_free_devt(dev->devt);
 	disk_release_events(disk);
 	kfree(disk->random);
@@ -1806,9 +1795,6 @@ EXPORT_SYMBOL(get_disk_and_module);
  *
  * This decrements the refcount for the struct gendisk. When this reaches 0
  * we'll have disk_release() called.
- *
- * Context: Any context, but the last reference must not be dropped from
- *          atomic context.
  */
 void put_disk(struct gendisk *disk)
 {
@@ -1823,9 +1809,6 @@ EXPORT_SYMBOL(put_disk);
  *
  * This is a counterpart of get_disk_and_module() and thus also of
  * get_gendisk().
- *
- * Context: Any context, but the last reference must not be dropped from
- *          atomic context.
  */
 void put_disk_and_module(struct gendisk *disk)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bb5636cc17b9..59fe9de342e0 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -583,6 +583,8 @@ struct request_queue {
 
 	size_t			cmd_size;
 
+	struct work_struct	release_work;
+
 #define BLK_MAX_WRITE_HINTS	5
 	u64			write_hints[BLK_MAX_WRITE_HINTS];
 };
-- 
2.18.4

