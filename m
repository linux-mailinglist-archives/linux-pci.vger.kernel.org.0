Return-Path: <linux-pci+bounces-22152-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 40558A415BE
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 08:01:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FC47188F029
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 07:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4365F149DE8;
	Mon, 24 Feb 2025 07:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="USdbUZeG"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A844F2B9B7;
	Mon, 24 Feb 2025 07:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740380466; cv=none; b=UNSafOaVWJLQOEOwslVtbABL/ijnIFxWVvADG1HGyVoGVgAVjWVj1iOVEoSfz8i+MD4PwKD8wrRtCG/eOLfZpdFpbkv3rMj1eQ+WG2w11/2YraSZO2WSEbzt1tYypZ0vcDBOpyCk1ha3UejUqkEDYzGPXvlTjt6EAcdA2PLnMy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740380466; c=relaxed/simple;
	bh=7/XDWR5/GrR2Cr0wqwm+xTSefqTB0RinN3WKj+IVJzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m+a9WMGCON81b1D2FXd10LbImJcjydDxD8BNj10hFRaMpjCKWIXcMvq0PXm86o2x0fKDMcu+VvN+gm+CfkIBbApa68aaeW8ifzMfTCkUzZMeCf08EHuq/C+W9OPsNzUWYwqUxz81iAXtBUzVsuphAbPXakhZhwA4mJSnGRP/eHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=USdbUZeG; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1740380453; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=Vzfz41ri1D3SO7CKzO1Xonu6jzKN+0w8JqQQkq16aLM=;
	b=USdbUZeGe3Dfq3vYMyWiOILZfOT6XsMnxY7ax0c8ZvnJkyxQgk/qtKd5eHJ4YVi2gLtaTnNjRakxJboPQTKuUfVqqRSFkJHFEc0vL7OqayqmI5SU/MWOR5870Q3RCtOWaKxeRXkYMfdw/aSyKXDt6F/vENenGY3teVoD0mi9jEY=
Received: from localhost.localdomain(mailfrom:huweiwen@linux.alibaba.com fp:SMTPD_---0WQ3azED_1740380441 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 24 Feb 2025 15:00:52 +0800
From: Weiwen Hu <huweiwen@linux.alibaba.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: Weiwen Hu <huweiwen@linux.alibaba.com>,
	linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH] ACPI/PCI: deduplicate concurrent eject notify
Date: Mon, 24 Feb 2025 15:00:34 +0800
Message-ID: <20250224070036.65573-1-huweiwen@linux.alibaba.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ignore the eject notification when the previous ejection is still in
progress to prevent multiple _EJ0 invocations when the ejection completes.

The first _EJ0 informs the platform to actually eject the device and frees
the slot for other devices. So the subsequent _EJ0 may accidentally eject
the new device that is just plugged into this slot. We need to avoid this.

For each acpi_device, this patch introduces a new field `ejecting`, which
is set before enqueuing the `kacpi_hotplug_wq` and reset before invoking
_EJ0.  Every notifications we received before invoking _EJ0 is targeted to
the old device. This ensures we don't miss any notifications for newly
plugged device.  And a new flag `should_dedup_eject` allows each driver to
implement this feature gradually. A driver should set this flag on
initialization if it will reset `ejecting`.

This fix is not perfect. If we receive an eject notification just after
resetting `ejecting` but before _EJ0, we will still invoke _EJ0 twice.
However this seems to be the best solution available, and it strictly
improves the current situation.

Another potential fix is to add an `ejected` flag to each device and not
invoke _EJ0 for already ejected devices. However, this approach risks
losing synchronization with the platform if something else goes wrong,
potentially preventing the device from being ejected permanently.  And we
need to check with bus driver to make sure the device is really ejected
successfully. But this check is still racy. So we cannot ensure no extra
_EJ0 invocations either.

Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
---
 drivers/acpi/osl.c                 |  6 ++++++
 drivers/pci/hotplug/acpiphp_glue.c | 15 +++++++++++----
 include/acpi/acpi_bus.h            |  4 +++-
 3 files changed, 20 insertions(+), 5 deletions(-)

We observed that umount can take extremely long time if there is a lot of
dirty page cache.  umount will take the s_umount semaphore, which will
block the ejecting process:

	__schedule+0x1e0/0x630
	? kernfs_put.part.0+0xd4/0x1a0
	schedule+0x46/0xb0
	rwsem_down_read_slowpath+0x16b/0x490
	__get_super.part.0+0xc1/0xe0
	fsync_bdev+0x11/0x60
	invalidate_partition+0x5c/0xa0
	del_gendisk+0x103/0x2e0
	virtblk_remove+0x27/0xa0
	virtio_dev_remove+0x36/0x90
	__device_release_driver+0x172/0x260
	device_release_driver+0x24/0x30
	bus_remove_device+0xf6/0x170
	device_del+0x19b/0x450
	device_unregister+0x16/0x60
	unregister_virtio_device+0x11/0x20
	virtio_pci_remove+0x31/0x60
	pci_device_remove+0x38/0xa0
	__device_release_driver+0x172/0x260
	device_release_driver+0x24/0x30
	pci_stop_bus_device+0x6c/0x90
	pci_stop_and_remove_bus_device+0xe/0x20
	disable_slot+0x49/0x90
	acpiphp_disable_and_eject_slot+0x15/0x90

While OS is not invoking _EJ0 timely, the user (or hypervisor) may retry by
issuing another notification, which will be queued in kacpi_hotplug_wq.
After the umount is finally done, the _EJ0 will be invoked.  Then, if there
are devices pending attach, the hypervisor may choose to attach it
immediately to the same slot.  The new device can be ejected by the queued
ejecting process unintentionally.

On Alibaba Cloud, we re-issue the notification around every 10s if the OS
does not respond.  (BTW, do you think platform is allowed to re-issue
the notification on timeout?)
We can easily reproduce this issue on Alibaba Cloud ECS:

	WRITE_SIZE=2300M  # tune this value so that the umount takes 20s
	# replace these disk serial numbers
	DISK_DETACH=bp142xxxxxxxxxxxxxxx  # pre-formatted
	DISK_ATTACH=bp109xxxxxxxxxxxxxxx  # any
	# start from these two disks detached

	INSTANCE_ID=$(curl -sS http://100.100.100.200/latest/meta-data/instance-id)
	echo "instance id: $INSTANCE_ID"
	DISK_PATH=/dev/disk/by-id/nvme-Alibaba_Cloud_Elastic_Block_Storage_

	echo "attaching disk d-$DISK_DETACH"
	aliyun ecs AttachDisk --DiskId "d-$DISK_DETACH" --InstanceId "$INSTANCE_ID"

	sleep 2
	mkdir -p /mnt/slow
	mount "$DISK_PATH$DISK_DETACH" /mnt/slow
	echo "mounted d-$DISK_DETACH to /mnt/slow"

	rm -f /mnt/slow/zero
	echo "populating dirty cache"
	head -c $WRITE_SIZE /dev/zero > /mnt/slow/zero;

	echo umounting
	(
		umount /mnt/slow
		echo umounted
	)&

	sleep 2
	echo "detaching disk d-$DISK_DETACH"
	aliyun ecs DetachDisk --DiskId "d-$DISK_DETACH" --InstanceId "$INSTANCE_ID"

	sleep 10
	echo "attaching disk d-$DISK_ATTACH"
	aliyun ecs AttachDisk --DiskId "d-$DISK_ATTACH" --InstanceId "$INSTANCE_ID"

	sleep 7
	wait
	for _ in {1..10}; do
		sleep 1
		if [ -e "$DISK_PATH$DISK_ATTACH" ]; then
			echo "disk d-$DISK_ATTACH attached, issue not reproduced"
			exit 0
		fi
		echo "disk d-$DISK_ATTACH not found yet"
	done

	echo "issue reproduced"
	exit 1

And here is the trace we got from `perf trace` while running the above script on an unpatched kernel:

	[starting detach]
	 48202.244 kworker/0:0-ev/5 probe:acpi_ev_queue_notify_request(__probe_ip: -1452149680, notify_value: 3)
	 48202.314 kworker/0:0-ev/5 probe:acpi_hotplug_schedule(__probe_ip: -1452297040, src: 3)
	 48203.690 kworker/u8:0-e/1946 probe:acpi_device_hotplug(__probe_ip: -1452251424, src: 3)
	[blocked, retrying detach]
	 58023.813 kworker/0:0-ev/5 probe:acpi_ev_queue_notify_request(__probe_ip: -1452149680, notify_value: 3)
	 58023.881 kworker/0:0-ev/5 probe:acpi_hotplug_schedule(__probe_ip: -1452297040, src: 3)
	[detach done]
	 62834.048 kworker/u8:0-e/1946 probe:acpi_evaluate_ej0(__probe_ip: -1452291632)
	[another device attaching]
	 62954.686 kworker/0:0-ev/5 probe:acpi_ev_queue_notify_request(__probe_ip: -1452149680, notify_value: 1)
	 62954.828 kworker/0:0-ev/5 probe:acpi_hotplug_schedule(__probe_ip: -1452297040, src: 1)
	 63042.506 kworker/u8:0-e/1946 probe:acpi_device_hotplug(__probe_ip: -1452251424, src: 3)
	[the new device is ejected unintentionally]
	 63042.520 kworker/u8:0-e/1946 probe:acpi_evaluate_ej0(__probe_ip: -1452291632)
	[the actual attach task, scanned the bus but got nothing]
	 63266.555 kworker/u8:0-e/1946 probe:acpi_device_hotplug(__probe_ip: -1452251424, src: 1)

With this patch, the acpi_hotplug_schedule at 58023.881 will be skipped to
suppress the acpi_evaluate_ej0 at 63042.520.

diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 5ff343096ece..f041c4db10f7 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -1193,6 +1193,12 @@ acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src)
 {
 	struct acpi_hp_work *hpw;
 
+	if (src == ACPI_NOTIFY_EJECT_REQUEST && adev->flags.should_dedup_eject
+			&& atomic_xchg(&adev->hp->ejecting, 1)) {
+		put_device(&adev->dev);
+		return AE_OK;
+	}
+
 	acpi_handle_debug(adev->handle,
 			  "Scheduling hotplug event %u for deferred handling\n",
 			   src);
diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
index 5b1f271c6034..3c50f2af1584 100644
--- a/drivers/pci/hotplug/acpiphp_glue.c
+++ b/drivers/pci/hotplug/acpiphp_glue.c
@@ -68,6 +68,7 @@ static struct acpiphp_context *acpiphp_init_context(struct acpi_device *adev)
 	context->hp.notify = acpiphp_hotplug_notify;
 	context->hp.fixup = acpiphp_post_dock_fixup;
 	acpi_set_hp_context(adev, &context->hp);
+	adev->flags.should_dedup_eject = true;
 	return context;
 }
 
@@ -778,7 +779,8 @@ void acpiphp_check_host_bridge(struct acpi_device *adev)
 	}
 }
 
-static int acpiphp_disable_and_eject_slot(struct acpiphp_slot *slot);
+static int
+acpiphp_disable_and_eject_slot(struct acpi_hotplug_context *hp, struct acpiphp_slot *slot);
 
 static void hotplug_event(u32 type, struct acpiphp_context *context)
 {
@@ -825,7 +827,7 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
 	case ACPI_NOTIFY_EJECT_REQUEST:
 		/* request device eject */
 		acpi_handle_debug(handle, "Eject request in %s()\n", __func__);
-		acpiphp_disable_and_eject_slot(slot);
+		acpiphp_disable_and_eject_slot(&context->hp, slot);
 		break;
 	}
 
@@ -999,9 +1001,11 @@ int acpiphp_enable_slot(struct acpiphp_slot *slot)
 
 /**
  * acpiphp_disable_and_eject_slot - power off and eject slot
+ * @hp: the context that received eject notification, can be NULL
  * @slot: ACPI PHP slot
  */
-static int acpiphp_disable_and_eject_slot(struct acpiphp_slot *slot)
+static int
+acpiphp_disable_and_eject_slot(struct acpi_hotplug_context *hp, struct acpiphp_slot *slot)
 {
 	struct acpiphp_func *func;
 
@@ -1011,6 +1015,9 @@ static int acpiphp_disable_and_eject_slot(struct acpiphp_slot *slot)
 	/* unconfigure all functions */
 	disable_slot(slot);
 
+	if (hp)
+		atomic_set(&hp->ejecting, 0);
+
 	list_for_each_entry(func, &slot->funcs, sibling)
 		if (func->flags & FUNC_HAS_EJ0) {
 			acpi_handle handle = func_to_handle(func);
@@ -1034,7 +1041,7 @@ int acpiphp_disable_slot(struct acpiphp_slot *slot)
 	 */
 	acpi_scan_lock_acquire();
 	pci_lock_rescan_remove();
-	ret = acpiphp_disable_and_eject_slot(slot);
+	ret = acpiphp_disable_and_eject_slot(NULL, slot);
 	pci_unlock_rescan_remove();
 	acpi_scan_lock_release();
 	return ret;
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index aad1a95e6863..870c1ffe47c9 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -151,6 +151,7 @@ typedef void (*acpi_hp_fixup) (struct acpi_device *);
 
 struct acpi_hotplug_context {
 	struct acpi_device *self;
+	atomic_t ejecting;
 	acpi_hp_notify notify;
 	acpi_hp_uevent uevent;
 	acpi_hp_fixup fixup;
@@ -215,7 +216,8 @@ struct acpi_device_flags {
 	u32 cca_seen:1;
 	u32 enumeration_by_parent:1;
 	u32 honor_deps:1;
-	u32 reserved:18;
+	u32 should_dedup_eject:1;
+	u32 reserved:17;
 };
 
 /* File System */
-- 
2.48.1


