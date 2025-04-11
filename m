Return-Path: <linux-pci+bounces-25661-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20ADCA857A7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 11:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8AC188DED7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 09:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74C861E9B1C;
	Fri, 11 Apr 2025 09:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="TfX6J4Yt"
X-Original-To: linux-pci@vger.kernel.org
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513C215D5B6;
	Fri, 11 Apr 2025 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744362743; cv=none; b=pmpREuW58uWfY90YP8bPcJT+u9ss9Q4zUgd6QQY4+xu+G4I2NthPeq8+wGtiJ0mpioguc/EmUIO8/bSmEPhHCb+8AQijCnLuBbe7q9XyQIfVu0uFkEZAweI7QOgg1sZw1b34WCTfbvLu4IXFLqFtYnM/VoB50d0xj8zXn1aRGWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744362743; c=relaxed/simple;
	bh=ijQzHD783gx5Qn/PbUArlv7WqVz5UysHgIFXr3fldy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GjioXw3l9w2WICcS5V4CVbiC5ixer8SoRncnmlKrARFyHBF06IGWUBnoO2fFNnb6ZCcX1eh5mZP+IZFa0SynJv26nYIDp0LFwXOTo3ZkMJeSE5jwlUxJB7NPKX9gKyVLMWcHTnzHOpbgaEIdQYP08lUjVgHzHyJJfOdC9fLOBZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=TfX6J4Yt; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1744362729; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=d2J8IBrpzQGta8ozASuOvWnbiBBSg/I7DPEmi9U9vjI=;
	b=TfX6J4YtIEIttwm3y/hFD06yikiKOqRkjA2cSSP38CeEsdnw3YCTAzhFkQSSQYg/4IgoZEwgeZPYYjMCYL8bRWBR3+rby84SlLM2osT26NmXblDfGw1cQuEQDdtDzOlPYygfWtxui7KR3bFe1gBv+3RSDYqJFSnve4R1CsuJ1D8=
Received: from MacBook-Pro.local(mailfrom:huweiwen@linux.alibaba.com fp:SMTPD_---0WWTH1Un_1744362727 cluster:ay36)
          by smtp.aliyun-inc.com;
          Fri, 11 Apr 2025 17:12:09 +0800
Date: Fri, 11 Apr 2025 17:12:07 +0800
From: Weiwen Hu <huweiwen@linux.alibaba.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] ACPI/PCI: deduplicate concurrent eject notify
Message-ID: <Z_i3-z4dODvYjaPN@MacBook-Pro.local>
References: <20250224070036.65573-1-huweiwen@linux.alibaba.com>
 <20250228171601.GA23123@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250228171601.GA23123@bhelgaas>

Hi Rafael, what's your opinion on this race condition in ACPI hotplug?

On Fri, Feb 28, 2025 at 11:16:01AM -0600, Bjorn Helgaas wrote:
> On Mon, Feb 24, 2025 at 03:00:34PM +0800, Weiwen Hu wrote:
> > Ignore the eject notification when the previous ejection is still in
> > progress to prevent multiple _EJ0 invocations when the ejection completes.
> > 
> > The first _EJ0 informs the platform to actually eject the device and frees
> > the slot for other devices. So the subsequent _EJ0 may accidentally eject
> > the new device that is just plugged into this slot. We need to avoid this.
> > 
> > For each acpi_device, this patch introduces a new field `ejecting`, which
> > is set before enqueuing the `kacpi_hotplug_wq` and reset before invoking
> > _EJ0.  Every notifications we received before invoking _EJ0 is targeted to
> > the old device. This ensures we don't miss any notifications for newly
> > plugged device.  And a new flag `should_dedup_eject` allows each driver to
> > implement this feature gradually. A driver should set this flag on
> > initialization if it will reset `ejecting`.
> 
> Which drivers do you have in mind when you say "each driver can
> implement this feature gradually"?  You set should_dedup_eject in
> acpiphp, so I guess you mean other ACPI hotplug drivers?  I see
> acpi_hotplug_context mentioned in libata-acpi.c, surface3-wmi.c; maybe
> those are the only other current ones?

Yes, I mean other ACPI hotplug drivers. I've searched for acpi_evaluate_ej0(),
because `ejecting` should be reset just before this. I got dock.c and scan.c.
All of them are called from acpi_device_hotplug(). So may be I can change all
of them at once.  Should we also consider out-of-tree drivers?

As for surface3-wmi.c, its s3_wmi_hp_notify function seems only probing lid
state, and does not support hot unplug actually.

But ata_acpi_detach_device() seems not calling acpi_evaluate_ej0(), From
f730ae183863 ("libata: remove functions now handed by ACPI dock driver"), It
seems that ata relies on dock to call ej0 for it.

> > This fix is not perfect. If we receive an eject notification just after
> > resetting `ejecting` but before _EJ0, we will still invoke _EJ0 twice.
> > However this seems to be the best solution available, and it strictly
> > improves the current situation.
> > 
> > Another potential fix is to add an `ejected` flag to each device and not
> > invoke _EJ0 for already ejected devices. However, this approach risks
> > losing synchronization with the platform if something else goes wrong,
> > potentially preventing the device from being ejected permanently.  And we
> > need to check with bus driver to make sure the device is really ejected
> > successfully. But this check is still racy. So we cannot ensure no extra
> > _EJ0 invocations either.
> 
> I see the problem.  Thanks for the detailed explanation and details
> about reproducing it and the trace.
> 
> I'm not sure whether the platform should reissue the Bus Check
> notification based on the fact that the OS hasn't invoked _EJ0 in some
> arbitrary time.  That seems a little bit presumptuous because, for
> example, the platform can't know how long it will take to write out
> the dirty page cache.  The racyness of the workaround seems
> troublesome to me.
> 
> But this is all really an ACPI issue, not a PCI issue, so I'd like to
> defer to the ACPI experts here.
> 
> > Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
> > ---
> >  drivers/acpi/osl.c                 |  6 ++++++
> >  drivers/pci/hotplug/acpiphp_glue.c | 15 +++++++++++----
> >  include/acpi/acpi_bus.h            |  4 +++-
> >  3 files changed, 20 insertions(+), 5 deletions(-)
> > 
> > We observed that umount can take extremely long time if there is a lot of
> > dirty page cache.  umount will take the s_umount semaphore, which will
> > block the ejecting process:
> > 
> > 	__schedule+0x1e0/0x630
> > 	? kernfs_put.part.0+0xd4/0x1a0
> > 	schedule+0x46/0xb0
> > 	rwsem_down_read_slowpath+0x16b/0x490
> > 	__get_super.part.0+0xc1/0xe0
> > 	fsync_bdev+0x11/0x60
> > 	invalidate_partition+0x5c/0xa0
> > 	del_gendisk+0x103/0x2e0
> > 	virtblk_remove+0x27/0xa0
> > 	virtio_dev_remove+0x36/0x90
> > 	__device_release_driver+0x172/0x260
> > 	device_release_driver+0x24/0x30
> > 	bus_remove_device+0xf6/0x170
> > 	device_del+0x19b/0x450
> > 	device_unregister+0x16/0x60
> > 	unregister_virtio_device+0x11/0x20
> > 	virtio_pci_remove+0x31/0x60
> > 	pci_device_remove+0x38/0xa0
> > 	__device_release_driver+0x172/0x260
> > 	device_release_driver+0x24/0x30
> > 	pci_stop_bus_device+0x6c/0x90
> > 	pci_stop_and_remove_bus_device+0xe/0x20
> > 	disable_slot+0x49/0x90
> > 	acpiphp_disable_and_eject_slot+0x15/0x90
> > 
> > While OS is not invoking _EJ0 timely, the user (or hypervisor) may retry by
> > issuing another notification, which will be queued in kacpi_hotplug_wq.
> > After the umount is finally done, the _EJ0 will be invoked.  Then, if there
> > are devices pending attach, the hypervisor may choose to attach it
> > immediately to the same slot.  The new device can be ejected by the queued
> > ejecting process unintentionally.
> > 
> > On Alibaba Cloud, we re-issue the notification around every 10s if the OS
> > does not respond.  (BTW, do you think platform is allowed to re-issue
> > the notification on timeout?)
> > We can easily reproduce this issue on Alibaba Cloud ECS:
> > 
> > 	WRITE_SIZE=2300M  # tune this value so that the umount takes 20s
> > 	# replace these disk serial numbers
> > 	DISK_DETACH=bp142xxxxxxxxxxxxxxx  # pre-formatted
> > 	DISK_ATTACH=bp109xxxxxxxxxxxxxxx  # any
> > 	# start from these two disks detached
> > 
> > 	INSTANCE_ID=$(curl -sS http://100.100.100.200/latest/meta-data/instance-id)
> > 	echo "instance id: $INSTANCE_ID"
> > 	DISK_PATH=/dev/disk/by-id/nvme-Alibaba_Cloud_Elastic_Block_Storage_
> > 
> > 	echo "attaching disk d-$DISK_DETACH"
> > 	aliyun ecs AttachDisk --DiskId "d-$DISK_DETACH" --InstanceId "$INSTANCE_ID"
> > 
> > 	sleep 2
> > 	mkdir -p /mnt/slow
> > 	mount "$DISK_PATH$DISK_DETACH" /mnt/slow
> > 	echo "mounted d-$DISK_DETACH to /mnt/slow"
> > 
> > 	rm -f /mnt/slow/zero
> > 	echo "populating dirty cache"
> > 	head -c $WRITE_SIZE /dev/zero > /mnt/slow/zero;
> > 
> > 	echo umounting
> > 	(
> > 		umount /mnt/slow
> > 		echo umounted
> > 	)&
> > 
> > 	sleep 2
> > 	echo "detaching disk d-$DISK_DETACH"
> > 	aliyun ecs DetachDisk --DiskId "d-$DISK_DETACH" --InstanceId "$INSTANCE_ID"
> > 
> > 	sleep 10
> > 	echo "attaching disk d-$DISK_ATTACH"
> > 	aliyun ecs AttachDisk --DiskId "d-$DISK_ATTACH" --InstanceId "$INSTANCE_ID"
> > 
> > 	sleep 7
> > 	wait
> > 	for _ in {1..10}; do
> > 		sleep 1
> > 		if [ -e "$DISK_PATH$DISK_ATTACH" ]; then
> > 			echo "disk d-$DISK_ATTACH attached, issue not reproduced"
> > 			exit 0
> > 		fi
> > 		echo "disk d-$DISK_ATTACH not found yet"
> > 	done
> > 
> > 	echo "issue reproduced"
> > 	exit 1
> > 
> > And here is the trace we got from `perf trace` while running the above script on an unpatched kernel:
> > 
> > 	[starting detach]
> > 	 48202.244 kworker/0:0-ev/5 probe:acpi_ev_queue_notify_request(__probe_ip: -1452149680, notify_value: 3)
> > 	 48202.314 kworker/0:0-ev/5 probe:acpi_hotplug_schedule(__probe_ip: -1452297040, src: 3)
> > 	 48203.690 kworker/u8:0-e/1946 probe:acpi_device_hotplug(__probe_ip: -1452251424, src: 3)
> > 	[blocked, retrying detach]
> > 	 58023.813 kworker/0:0-ev/5 probe:acpi_ev_queue_notify_request(__probe_ip: -1452149680, notify_value: 3)
> > 	 58023.881 kworker/0:0-ev/5 probe:acpi_hotplug_schedule(__probe_ip: -1452297040, src: 3)
> > 	[detach done]
> > 	 62834.048 kworker/u8:0-e/1946 probe:acpi_evaluate_ej0(__probe_ip: -1452291632)
> > 	[another device attaching]
> > 	 62954.686 kworker/0:0-ev/5 probe:acpi_ev_queue_notify_request(__probe_ip: -1452149680, notify_value: 1)
> > 	 62954.828 kworker/0:0-ev/5 probe:acpi_hotplug_schedule(__probe_ip: -1452297040, src: 1)
> > 	 63042.506 kworker/u8:0-e/1946 probe:acpi_device_hotplug(__probe_ip: -1452251424, src: 3)
> > 	[the new device is ejected unintentionally]
> > 	 63042.520 kworker/u8:0-e/1946 probe:acpi_evaluate_ej0(__probe_ip: -1452291632)
> > 	[the actual attach task, scanned the bus but got nothing]
> > 	 63266.555 kworker/u8:0-e/1946 probe:acpi_device_hotplug(__probe_ip: -1452251424, src: 1)
> > 
> > With this patch, the acpi_hotplug_schedule at 58023.881 will be skipped to
> > suppress the acpi_evaluate_ej0 at 63042.520.
> > 
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index 5ff343096ece..f041c4db10f7 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -1193,6 +1193,12 @@ acpi_status acpi_hotplug_schedule(struct acpi_device *adev, u32 src)
> >  {
> >  	struct acpi_hp_work *hpw;
> >  
> > +	if (src == ACPI_NOTIFY_EJECT_REQUEST && adev->flags.should_dedup_eject
> > +			&& atomic_xchg(&adev->hp->ejecting, 1)) {
> > +		put_device(&adev->dev);
> > +		return AE_OK;
> > +	}
> > +
> >  	acpi_handle_debug(adev->handle,
> >  			  "Scheduling hotplug event %u for deferred handling\n",
> >  			   src);
> > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> > index 5b1f271c6034..3c50f2af1584 100644
> > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > @@ -68,6 +68,7 @@ static struct acpiphp_context *acpiphp_init_context(struct acpi_device *adev)
> >  	context->hp.notify = acpiphp_hotplug_notify;
> >  	context->hp.fixup = acpiphp_post_dock_fixup;
> >  	acpi_set_hp_context(adev, &context->hp);
> > +	adev->flags.should_dedup_eject = true;
> >  	return context;
> >  }
> >  
> > @@ -778,7 +779,8 @@ void acpiphp_check_host_bridge(struct acpi_device *adev)
> >  	}
> >  }
> >  
> > -static int acpiphp_disable_and_eject_slot(struct acpiphp_slot *slot);
> > +static int
> > +acpiphp_disable_and_eject_slot(struct acpi_hotplug_context *hp, struct acpiphp_slot *slot);
> >  
> >  static void hotplug_event(u32 type, struct acpiphp_context *context)
> >  {
> > @@ -825,7 +827,7 @@ static void hotplug_event(u32 type, struct acpiphp_context *context)
> >  	case ACPI_NOTIFY_EJECT_REQUEST:
> >  		/* request device eject */
> >  		acpi_handle_debug(handle, "Eject request in %s()\n", __func__);
> > -		acpiphp_disable_and_eject_slot(slot);
> > +		acpiphp_disable_and_eject_slot(&context->hp, slot);
> >  		break;
> >  	}
> >  
> > @@ -999,9 +1001,11 @@ int acpiphp_enable_slot(struct acpiphp_slot *slot)
> >  
> >  /**
> >   * acpiphp_disable_and_eject_slot - power off and eject slot
> > + * @hp: the context that received eject notification, can be NULL
> >   * @slot: ACPI PHP slot
> >   */
> > -static int acpiphp_disable_and_eject_slot(struct acpiphp_slot *slot)
> > +static int
> > +acpiphp_disable_and_eject_slot(struct acpi_hotplug_context *hp, struct acpiphp_slot *slot)
> >  {
> >  	struct acpiphp_func *func;
> >  
> > @@ -1011,6 +1015,9 @@ static int acpiphp_disable_and_eject_slot(struct acpiphp_slot *slot)
> >  	/* unconfigure all functions */
> >  	disable_slot(slot);
> >  
> > +	if (hp)
> > +		atomic_set(&hp->ejecting, 0);
> > +
> >  	list_for_each_entry(func, &slot->funcs, sibling)
> >  		if (func->flags & FUNC_HAS_EJ0) {
> >  			acpi_handle handle = func_to_handle(func);
> > @@ -1034,7 +1041,7 @@ int acpiphp_disable_slot(struct acpiphp_slot *slot)
> >  	 */
> >  	acpi_scan_lock_acquire();
> >  	pci_lock_rescan_remove();
> > -	ret = acpiphp_disable_and_eject_slot(slot);
> > +	ret = acpiphp_disable_and_eject_slot(NULL, slot);
> >  	pci_unlock_rescan_remove();
> >  	acpi_scan_lock_release();
> >  	return ret;
> > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > index aad1a95e6863..870c1ffe47c9 100644
> > --- a/include/acpi/acpi_bus.h
> > +++ b/include/acpi/acpi_bus.h
> > @@ -151,6 +151,7 @@ typedef void (*acpi_hp_fixup) (struct acpi_device *);
> >  
> >  struct acpi_hotplug_context {
> >  	struct acpi_device *self;
> > +	atomic_t ejecting;
> >  	acpi_hp_notify notify;
> >  	acpi_hp_uevent uevent;
> >  	acpi_hp_fixup fixup;
> > @@ -215,7 +216,8 @@ struct acpi_device_flags {
> >  	u32 cca_seen:1;
> >  	u32 enumeration_by_parent:1;
> >  	u32 honor_deps:1;
> > -	u32 reserved:18;
> > +	u32 should_dedup_eject:1;
> > +	u32 reserved:17;
> >  };
> >  
> >  /* File System */
> > -- 
> > 2.48.1
> > 

