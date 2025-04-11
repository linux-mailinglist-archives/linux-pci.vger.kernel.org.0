Return-Path: <linux-pci+bounces-25669-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7BA9A85A51
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 12:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335389C1FF4
	for <lists+linux-pci@lfdr.de>; Fri, 11 Apr 2025 10:39:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056A222128E;
	Fri, 11 Apr 2025 10:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzphyBZF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE1A9204581;
	Fri, 11 Apr 2025 10:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744367958; cv=none; b=FBhbc3f5NvvMTKpv9myx7SKw0/gnL5FKMgqrK2qjbwVA/lMaDxzWxhjUw6KRyNqqmXAPa2UddgF0b0Serl4E/6XHjPnC55dtZMVaUP+at1VHnOUuiPqWTPFuQvP2dfxFlBxwiyENeK4L+crDvc7IiPxECUZ0K5inXkAzVQ10Fs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744367958; c=relaxed/simple;
	bh=0iz0lwaWRTkOYGZ8xEBMXlIieHCysyQ6qCPwstPuDBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P9iG8CCG9RVztiSjWKqu/TaaeAfqyj/Ydb5wMIoR2zMWC03IegZmuXTBoeWg4rVNInkHysP+dRWQ+cEckCh7dlBZPRe8e0rLNf5pNQZjiczPiD15dFzeiZIU7S8pfoAM3zyi1yHVLTJKsb64/7rzSBs0QgZ3XcYdAjcW7XBktuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzphyBZF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D171C4CEEA;
	Fri, 11 Apr 2025 10:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744367957;
	bh=0iz0lwaWRTkOYGZ8xEBMXlIieHCysyQ6qCPwstPuDBQ=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=KzphyBZFx8pkWdgvrylTLX9Dw8LeOEfbb8Ipon5DqFPwhL9dfEEF+GPM8Y1MkWfZU
	 zJvxri2QqqnenWqBxC4/sSUb507L3FM5zX1wg5Fs1M6dB5pFFToZZpKf2KcMsEZbCA
	 wpF/8Pdo+dFHOuONX/ufsVEG2eUOZJMb9ZaSgeFQMFQSdTfjkJ1/6vPjSK92goOqMU
	 Bp6Msxsl769O5/9lzXOpoCe50JEfN507G7YYYMk7jtBm8EefBt5jNWAGsZq/4w4Iy3
	 ZhJ24jymnkc+uS29uWf5Bbj1vodMarZnR1/0PMUP4BjgjCsZyYKSpiVYHkpzE4wCJh
	 7MjQh1QYcIQaw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2cca475546fso837930fac.1;
        Fri, 11 Apr 2025 03:39:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJ2l8alAkaHwfJd7jUJdYUt2KLXrs7p0DPIrJcZYj6RSLuBToTj4X4TtnSiI6KC53Hqzey6Ql8HXdR@vger.kernel.org, AJvYcCXYOOdAbtBR6g7W4j/70HldLlUwxHzYOxIg+9DMwFdkJgJyIXxfsq4VwMcc4OBebmn8I9p++Iiv5krP@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8Au1Yd3mbxPW8rX9vDqTCl/oJ5G3k79uP0cvBeyLOWmwl1+fE
	Q0GA0scveU2deZJPUxEhQzlLdBgPExMkQWQ5c3h8gKVMnc5HdkTaNhEYgBPsFlql3eya8QEkYIx
	w6dF6VgYnKLvvvy1JJGbGKgPt41w=
X-Google-Smtp-Source: AGHT+IEFPt7Emuu3+sb0wM+n0ZAIaj7xXjMAcrbQhS3FxySdpGs+HGhij/aq1pT7jUNSohzl/10NVGJrL6Df/a9XEBU=
X-Received: by 2002:a05:6870:9c88:b0:2bc:76f2:44a8 with SMTP id
 586e51a60fabf-2d0d5ca8f60mr1109074fac.15.1744367956456; Fri, 11 Apr 2025
 03:39:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224070036.65573-1-huweiwen@linux.alibaba.com>
 <20250228171601.GA23123@bhelgaas> <Z_i3-z4dODvYjaPN@MacBook-Pro.local>
In-Reply-To: <Z_i3-z4dODvYjaPN@MacBook-Pro.local>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Fri, 11 Apr 2025 12:39:04 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0hSNbdqWqdM-2Yd3bRYq86e6EK=sDxnK0VJBSfVZ+XoWw@mail.gmail.com>
X-Gm-Features: ATxdqUE3Fp_m0hOYloEStQZsS42uIST3m8Tw052oj7inkWfQyMO0w5ustpRskDw
Message-ID: <CAJZ5v0hSNbdqWqdM-2Yd3bRYq86e6EK=sDxnK0VJBSfVZ+XoWw@mail.gmail.com>
Subject: Re: [PATCH] ACPI/PCI: deduplicate concurrent eject notify
To: Weiwen Hu <huweiwen@linux.alibaba.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 11, 2025 at 11:12=E2=80=AFAM Weiwen Hu <huweiwen@linux.alibaba.=
com> wrote:
>
> Hi Rafael, what's your opinion on this race condition in ACPI hotplug?

In the first place, the platform firmware should wait for an _OST
confirmation of an eject or failure.

I cannot spend more time on this today, though, I'll get to it next week.

> On Fri, Feb 28, 2025 at 11:16:01AM -0600, Bjorn Helgaas wrote:
> > On Mon, Feb 24, 2025 at 03:00:34PM +0800, Weiwen Hu wrote:
> > > Ignore the eject notification when the previous ejection is still in
> > > progress to prevent multiple _EJ0 invocations when the ejection compl=
etes.
> > >
> > > The first _EJ0 informs the platform to actually eject the device and =
frees
> > > the slot for other devices. So the subsequent _EJ0 may accidentally e=
ject
> > > the new device that is just plugged into this slot. We need to avoid =
this.
> > >
> > > For each acpi_device, this patch introduces a new field `ejecting`, w=
hich
> > > is set before enqueuing the `kacpi_hotplug_wq` and reset before invok=
ing
> > > _EJ0.  Every notifications we received before invoking _EJ0 is target=
ed to
> > > the old device. This ensures we don't miss any notifications for newl=
y
> > > plugged device.  And a new flag `should_dedup_eject` allows each driv=
er to
> > > implement this feature gradually. A driver should set this flag on
> > > initialization if it will reset `ejecting`.
> >
> > Which drivers do you have in mind when you say "each driver can
> > implement this feature gradually"?  You set should_dedup_eject in
> > acpiphp, so I guess you mean other ACPI hotplug drivers?  I see
> > acpi_hotplug_context mentioned in libata-acpi.c, surface3-wmi.c; maybe
> > those are the only other current ones?
>
> Yes, I mean other ACPI hotplug drivers. I've searched for acpi_evaluate_e=
j0(),
> because `ejecting` should be reset just before this. I got dock.c and sca=
n.c.
> All of them are called from acpi_device_hotplug(). So may be I can change=
 all
> of them at once.  Should we also consider out-of-tree drivers?
>
> As for surface3-wmi.c, its s3_wmi_hp_notify function seems only probing l=
id
> state, and does not support hot unplug actually.
>
> But ata_acpi_detach_device() seems not calling acpi_evaluate_ej0(), From
> f730ae183863 ("libata: remove functions now handed by ACPI dock driver"),=
 It
> seems that ata relies on dock to call ej0 for it.
>
> > > This fix is not perfect. If we receive an eject notification just aft=
er
> > > resetting `ejecting` but before _EJ0, we will still invoke _EJ0 twice=
.
> > > However this seems to be the best solution available, and it strictly
> > > improves the current situation.
> > >
> > > Another potential fix is to add an `ejected` flag to each device and =
not
> > > invoke _EJ0 for already ejected devices. However, this approach risks
> > > losing synchronization with the platform if something else goes wrong=
,
> > > potentially preventing the device from being ejected permanently.  An=
d we
> > > need to check with bus driver to make sure the device is really eject=
ed
> > > successfully. But this check is still racy. So we cannot ensure no ex=
tra
> > > _EJ0 invocations either.
> >
> > I see the problem.  Thanks for the detailed explanation and details
> > about reproducing it and the trace.
> >
> > I'm not sure whether the platform should reissue the Bus Check
> > notification based on the fact that the OS hasn't invoked _EJ0 in some
> > arbitrary time.  That seems a little bit presumptuous because, for
> > example, the platform can't know how long it will take to write out
> > the dirty page cache.  The racyness of the workaround seems
> > troublesome to me.
> >
> > But this is all really an ACPI issue, not a PCI issue, so I'd like to
> > defer to the ACPI experts here.
> >
> > > Signed-off-by: Weiwen Hu <huweiwen@linux.alibaba.com>
> > > ---
> > >  drivers/acpi/osl.c                 |  6 ++++++
> > >  drivers/pci/hotplug/acpiphp_glue.c | 15 +++++++++++----
> > >  include/acpi/acpi_bus.h            |  4 +++-
> > >  3 files changed, 20 insertions(+), 5 deletions(-)
> > >
> > > We observed that umount can take extremely long time if there is a lo=
t of
> > > dirty page cache.  umount will take the s_umount semaphore, which wil=
l
> > > block the ejecting process:
> > >
> > >     __schedule+0x1e0/0x630
> > >     ? kernfs_put.part.0+0xd4/0x1a0
> > >     schedule+0x46/0xb0
> > >     rwsem_down_read_slowpath+0x16b/0x490
> > >     __get_super.part.0+0xc1/0xe0
> > >     fsync_bdev+0x11/0x60
> > >     invalidate_partition+0x5c/0xa0
> > >     del_gendisk+0x103/0x2e0
> > >     virtblk_remove+0x27/0xa0
> > >     virtio_dev_remove+0x36/0x90
> > >     __device_release_driver+0x172/0x260
> > >     device_release_driver+0x24/0x30
> > >     bus_remove_device+0xf6/0x170
> > >     device_del+0x19b/0x450
> > >     device_unregister+0x16/0x60
> > >     unregister_virtio_device+0x11/0x20
> > >     virtio_pci_remove+0x31/0x60
> > >     pci_device_remove+0x38/0xa0
> > >     __device_release_driver+0x172/0x260
> > >     device_release_driver+0x24/0x30
> > >     pci_stop_bus_device+0x6c/0x90
> > >     pci_stop_and_remove_bus_device+0xe/0x20
> > >     disable_slot+0x49/0x90
> > >     acpiphp_disable_and_eject_slot+0x15/0x90
> > >
> > > While OS is not invoking _EJ0 timely, the user (or hypervisor) may re=
try by
> > > issuing another notification, which will be queued in kacpi_hotplug_w=
q.
> > > After the umount is finally done, the _EJ0 will be invoked.  Then, if=
 there
> > > are devices pending attach, the hypervisor may choose to attach it
> > > immediately to the same slot.  The new device can be ejected by the q=
ueued
> > > ejecting process unintentionally.
> > >
> > > On Alibaba Cloud, we re-issue the notification around every 10s if th=
e OS
> > > does not respond.  (BTW, do you think platform is allowed to re-issue
> > > the notification on timeout?)
> > > We can easily reproduce this issue on Alibaba Cloud ECS:
> > >
> > >     WRITE_SIZE=3D2300M  # tune this value so that the umount takes 20=
s
> > >     # replace these disk serial numbers
> > >     DISK_DETACH=3Dbp142xxxxxxxxxxxxxxx  # pre-formatted
> > >     DISK_ATTACH=3Dbp109xxxxxxxxxxxxxxx  # any
> > >     # start from these two disks detached
> > >
> > >     INSTANCE_ID=3D$(curl -sS http://100.100.100.200/latest/meta-data/=
instance-id)
> > >     echo "instance id: $INSTANCE_ID"
> > >     DISK_PATH=3D/dev/disk/by-id/nvme-Alibaba_Cloud_Elastic_Block_Stor=
age_
> > >
> > >     echo "attaching disk d-$DISK_DETACH"
> > >     aliyun ecs AttachDisk --DiskId "d-$DISK_DETACH" --InstanceId "$IN=
STANCE_ID"
> > >
> > >     sleep 2
> > >     mkdir -p /mnt/slow
> > >     mount "$DISK_PATH$DISK_DETACH" /mnt/slow
> > >     echo "mounted d-$DISK_DETACH to /mnt/slow"
> > >
> > >     rm -f /mnt/slow/zero
> > >     echo "populating dirty cache"
> > >     head -c $WRITE_SIZE /dev/zero > /mnt/slow/zero;
> > >
> > >     echo umounting
> > >     (
> > >             umount /mnt/slow
> > >             echo umounted
> > >     )&
> > >
> > >     sleep 2
> > >     echo "detaching disk d-$DISK_DETACH"
> > >     aliyun ecs DetachDisk --DiskId "d-$DISK_DETACH" --InstanceId "$IN=
STANCE_ID"
> > >
> > >     sleep 10
> > >     echo "attaching disk d-$DISK_ATTACH"
> > >     aliyun ecs AttachDisk --DiskId "d-$DISK_ATTACH" --InstanceId "$IN=
STANCE_ID"
> > >
> > >     sleep 7
> > >     wait
> > >     for _ in {1..10}; do
> > >             sleep 1
> > >             if [ -e "$DISK_PATH$DISK_ATTACH" ]; then
> > >                     echo "disk d-$DISK_ATTACH attached, issue not rep=
roduced"
> > >                     exit 0
> > >             fi
> > >             echo "disk d-$DISK_ATTACH not found yet"
> > >     done
> > >
> > >     echo "issue reproduced"
> > >     exit 1
> > >
> > > And here is the trace we got from `perf trace` while running the abov=
e script on an unpatched kernel:
> > >
> > >     [starting detach]
> > >      48202.244 kworker/0:0-ev/5 probe:acpi_ev_queue_notify_request(__=
probe_ip: -1452149680, notify_value: 3)
> > >      48202.314 kworker/0:0-ev/5 probe:acpi_hotplug_schedule(__probe_i=
p: -1452297040, src: 3)
> > >      48203.690 kworker/u8:0-e/1946 probe:acpi_device_hotplug(__probe_=
ip: -1452251424, src: 3)
> > >     [blocked, retrying detach]
> > >      58023.813 kworker/0:0-ev/5 probe:acpi_ev_queue_notify_request(__=
probe_ip: -1452149680, notify_value: 3)
> > >      58023.881 kworker/0:0-ev/5 probe:acpi_hotplug_schedule(__probe_i=
p: -1452297040, src: 3)
> > >     [detach done]
> > >      62834.048 kworker/u8:0-e/1946 probe:acpi_evaluate_ej0(__probe_ip=
: -1452291632)
> > >     [another device attaching]
> > >      62954.686 kworker/0:0-ev/5 probe:acpi_ev_queue_notify_request(__=
probe_ip: -1452149680, notify_value: 1)
> > >      62954.828 kworker/0:0-ev/5 probe:acpi_hotplug_schedule(__probe_i=
p: -1452297040, src: 1)
> > >      63042.506 kworker/u8:0-e/1946 probe:acpi_device_hotplug(__probe_=
ip: -1452251424, src: 3)
> > >     [the new device is ejected unintentionally]
> > >      63042.520 kworker/u8:0-e/1946 probe:acpi_evaluate_ej0(__probe_ip=
: -1452291632)
> > >     [the actual attach task, scanned the bus but got nothing]
> > >      63266.555 kworker/u8:0-e/1946 probe:acpi_device_hotplug(__probe_=
ip: -1452251424, src: 1)
> > >
> > > With this patch, the acpi_hotplug_schedule at 58023.881 will be skipp=
ed to
> > > suppress the acpi_evaluate_ej0 at 63042.520.
> > >
> > > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > > index 5ff343096ece..f041c4db10f7 100644
> > > --- a/drivers/acpi/osl.c
> > > +++ b/drivers/acpi/osl.c
> > > @@ -1193,6 +1193,12 @@ acpi_status acpi_hotplug_schedule(struct acpi_=
device *adev, u32 src)
> > >  {
> > >     struct acpi_hp_work *hpw;
> > >
> > > +   if (src =3D=3D ACPI_NOTIFY_EJECT_REQUEST && adev->flags.should_de=
dup_eject
> > > +                   && atomic_xchg(&adev->hp->ejecting, 1)) {
> > > +           put_device(&adev->dev);
> > > +           return AE_OK;
> > > +   }
> > > +
> > >     acpi_handle_debug(adev->handle,
> > >                       "Scheduling hotplug event %u for deferred handl=
ing\n",
> > >                        src);
> > > diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug=
/acpiphp_glue.c
> > > index 5b1f271c6034..3c50f2af1584 100644
> > > --- a/drivers/pci/hotplug/acpiphp_glue.c
> > > +++ b/drivers/pci/hotplug/acpiphp_glue.c
> > > @@ -68,6 +68,7 @@ static struct acpiphp_context *acpiphp_init_context=
(struct acpi_device *adev)
> > >     context->hp.notify =3D acpiphp_hotplug_notify;
> > >     context->hp.fixup =3D acpiphp_post_dock_fixup;
> > >     acpi_set_hp_context(adev, &context->hp);
> > > +   adev->flags.should_dedup_eject =3D true;
> > >     return context;
> > >  }
> > >
> > > @@ -778,7 +779,8 @@ void acpiphp_check_host_bridge(struct acpi_device=
 *adev)
> > >     }
> > >  }
> > >
> > > -static int acpiphp_disable_and_eject_slot(struct acpiphp_slot *slot)=
;
> > > +static int
> > > +acpiphp_disable_and_eject_slot(struct acpi_hotplug_context *hp, stru=
ct acpiphp_slot *slot);
> > >
> > >  static void hotplug_event(u32 type, struct acpiphp_context *context)
> > >  {
> > > @@ -825,7 +827,7 @@ static void hotplug_event(u32 type, struct acpiph=
p_context *context)
> > >     case ACPI_NOTIFY_EJECT_REQUEST:
> > >             /* request device eject */
> > >             acpi_handle_debug(handle, "Eject request in %s()\n", __fu=
nc__);
> > > -           acpiphp_disable_and_eject_slot(slot);
> > > +           acpiphp_disable_and_eject_slot(&context->hp, slot);
> > >             break;
> > >     }
> > >
> > > @@ -999,9 +1001,11 @@ int acpiphp_enable_slot(struct acpiphp_slot *sl=
ot)
> > >
> > >  /**
> > >   * acpiphp_disable_and_eject_slot - power off and eject slot
> > > + * @hp: the context that received eject notification, can be NULL
> > >   * @slot: ACPI PHP slot
> > >   */
> > > -static int acpiphp_disable_and_eject_slot(struct acpiphp_slot *slot)
> > > +static int
> > > +acpiphp_disable_and_eject_slot(struct acpi_hotplug_context *hp, stru=
ct acpiphp_slot *slot)
> > >  {
> > >     struct acpiphp_func *func;
> > >
> > > @@ -1011,6 +1015,9 @@ static int acpiphp_disable_and_eject_slot(struc=
t acpiphp_slot *slot)
> > >     /* unconfigure all functions */
> > >     disable_slot(slot);
> > >
> > > +   if (hp)
> > > +           atomic_set(&hp->ejecting, 0);
> > > +
> > >     list_for_each_entry(func, &slot->funcs, sibling)
> > >             if (func->flags & FUNC_HAS_EJ0) {
> > >                     acpi_handle handle =3D func_to_handle(func);
> > > @@ -1034,7 +1041,7 @@ int acpiphp_disable_slot(struct acpiphp_slot *s=
lot)
> > >      */
> > >     acpi_scan_lock_acquire();
> > >     pci_lock_rescan_remove();
> > > -   ret =3D acpiphp_disable_and_eject_slot(slot);
> > > +   ret =3D acpiphp_disable_and_eject_slot(NULL, slot);
> > >     pci_unlock_rescan_remove();
> > >     acpi_scan_lock_release();
> > >     return ret;
> > > diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
> > > index aad1a95e6863..870c1ffe47c9 100644
> > > --- a/include/acpi/acpi_bus.h
> > > +++ b/include/acpi/acpi_bus.h
> > > @@ -151,6 +151,7 @@ typedef void (*acpi_hp_fixup) (struct acpi_device=
 *);
> > >
> > >  struct acpi_hotplug_context {
> > >     struct acpi_device *self;
> > > +   atomic_t ejecting;
> > >     acpi_hp_notify notify;
> > >     acpi_hp_uevent uevent;
> > >     acpi_hp_fixup fixup;
> > > @@ -215,7 +216,8 @@ struct acpi_device_flags {
> > >     u32 cca_seen:1;
> > >     u32 enumeration_by_parent:1;
> > >     u32 honor_deps:1;
> > > -   u32 reserved:18;
> > > +   u32 should_dedup_eject:1;
> > > +   u32 reserved:17;
> > >  };
> > >
> > >  /* File System */
> > > --
> > > 2.48.1
> > >
>

