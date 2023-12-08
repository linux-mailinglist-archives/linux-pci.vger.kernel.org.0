Return-Path: <linux-pci+bounces-689-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8141480A7CE
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 16:47:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9E1F21C208F4
	for <lists+linux-pci@lfdr.de>; Fri,  8 Dec 2023 15:47:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9B130327;
	Fri,  8 Dec 2023 15:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TOBk1UXd"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD5581723
	for <linux-pci@vger.kernel.org>; Fri,  8 Dec 2023 07:47:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702050450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnSFlC/zBOY0Wp1wxKdNslxmaFigAVsOLyWoBkCEP2I=;
	b=TOBk1UXdQsRGn3Lp491/UexHz+Uq43VR38OHhz46pR+Xkj7R62FqiCjCCtNjZMNwP37+Jp
	ZHB4B5koK3HYy0+cqcftsetelYqh1o0UVbIckESBpz5aEgUnRjQGiezCXqG56PXD6bUe4i
	Dnt71tBPtJmAMmjJJddAgfuqkoM+3Ps=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-RyZxy4rTMk69J0CgIc3pxA-1; Fri, 08 Dec 2023 10:47:27 -0500
X-MC-Unique: RyZxy4rTMk69J0CgIc3pxA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a1cc20d32dfso114024066b.1
        for <linux-pci@vger.kernel.org>; Fri, 08 Dec 2023 07:47:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702050446; x=1702655246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xnSFlC/zBOY0Wp1wxKdNslxmaFigAVsOLyWoBkCEP2I=;
        b=fEFtXM8wax1L3O62TgtwvgJQZJGZwhBdQvh6jt26tnOVZsFHEM+d/KEdElzrfJO+m9
         O4ZTD89L3fjmGL0ejPQAvSPD/tmhHw+nyuy2U/v9tSpfZAZayz+fakfuzCqSDrADvIw4
         IcTR65Mh4mx8zhyl0UDjfrHR5GuLT0tSM1n5rUJq/xnaK9sMiIL5VyJuioxczDlWG8D+
         T5nF5Uo7G47PFzx7p/AMknJWqH4r3HQdu/29STOFToSIz2wplMm/JTqA9Wy38LnY0M8C
         MJ3ejZAIQk01bps/PJ6969dkZH8k4y7JqSd88Rivy4MZ+OIPcVqrMimIVaPVFkMSiSJX
         wLyA==
X-Gm-Message-State: AOJu0YwBJjEFJeQa4haL8Uwrf7F3RP5sTDyItJqp2rifriBeZNtwQcN7
	EjRU2X5HHGaWX4pXQ6aDoGD6QGRUtVk4Aej9AbLsdAe+qbppKf84JOKsvpGZajTIdRtlh1l+3vP
	XmjQQURMErP2cWxqBd8ww
X-Received: by 2002:a17:906:2a84:b0:a1e:2c27:8916 with SMTP id l4-20020a1709062a8400b00a1e2c278916mr89941eje.97.1702050446746;
        Fri, 08 Dec 2023 07:47:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEu1CtX7w3L1Y91RfeO1h9prw/djM3VduGR6xxFoShmg0Y/So4y297AFZysBoAmCn3xElee5Q==
X-Received: by 2002:a17:906:2a84:b0:a1e:2c27:8916 with SMTP id l4-20020a1709062a8400b00a1e2c278916mr89930eje.97.1702050446338;
        Fri, 08 Dec 2023 07:47:26 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id ti4-20020a170907c20400b00a1e377ea78asm1142226ejc.50.2023.12.08.07.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 07:47:24 -0800 (PST)
Date: Fri, 8 Dec 2023 16:47:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Fiona Ebner <f.ebner@proxmox.com>, linux-pci@vger.kernel.org,
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org, Thomas Lamprecht
 <t.lamprecht@proxmox.com>
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Message-ID: <20231208164723.12828a96@imammedo.users.ipa.redhat.com>
In-Reply-To: <20231207232815.GA771837@bhelgaas>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
	<20231207232815.GA771837@bhelgaas>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 7 Dec 2023 17:28:15 -0600
Bjorn Helgaas <helgaas@kernel.org> wrote:

> On Wed, Nov 29, 2023 at 04:22:41PM +0100, Fiona Ebner wrote:
> > Hi,
> > it seems that hot-plugging SCSI disks for QEMU virtual machines booting
> > with UEFI and with guest kernels >= 6.5 might be broken. It's not
> > consistently broken, hinting there might be a race somewhere.
> > 
> > Reverting the following two commits seems to make it work reliably again:
> > 
> > cc22522fd55e2 ("PCI: acpiphp: Use
> > pci_assign_unassigned_bridge_resources() only for non-root bus")
> > 40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary"
> > 
> > Of course, they might only expose some pre-existing issue, but this is
> > my best lead. See below for some logs and details about an affected
> > virtual machine. Happy to provide more information and to debug/test
> > further.
> > ...  
> 
> > I've attached some logs for guest using kernel 6.7.0-rc3 where hotplug
> > works rarely and guest using kernel 6.7.0-rc3 with the previously
> > mentioned commits reverted where hotplug works reliably:
> > 
> > 6.7.0-rc3:
> >   
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> > > Nov 29 15:12:02 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> > > Nov 29 15:12:02 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > > Nov 29 15:12:02 hotplug kernel: scsi host3: Virtio SCSI HBA
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > Nov 29 15:12:02 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > Nov 29 15:12:02 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]   
> 
> What's the actual symptom that this is broken?  All these log
> fragments show the exact same assignments for BARs 0, 1, 4 and for the
> bridge windows.
> 
> I assume 0000:01:02.0 is the hot-added SCSI HBA, and 00:05.0 is a
> bridge leading to it?
> 
> Can you put the complete dmesg logs somewhere?  There's a lot of
> context missing here.
> 
> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
> work reliably?  If we have to revert something, reverting one would be
> better than reverting both.

here is simplified reproducer:
./qemu-system-x86_64 -enable-kvm -m 4G -smp 4 -cpu host                        \
    /dev/lvmpool/fedora-rawhide                                                \
    -device pci-bridge,id=pci.3,chassis_nr=3,bus=pci.0,addr=0x5                \
    -device virtio-scsi-pci,id=virtioscsi0,bus=pci.3,addr=0x1                  \
    -blockdev raw,file.driver=file,file.filename=Fedora-Server-dvd-x86_64-Rawhide-20231127.n.0.iso,node-name=drive-scsi1 \
    -monitor stdio -serial file:/tmp/console_log

then once booted at monitor prompt:

(qemu) device_add virtio-scsi-pci,bus=pci.3,addr=2,id=virtioscsi1
(qemu) device_add scsi-hd,id=scsi1,drive=drive-scsi1,bus=virtioscsi1.0

with distro shipped 6.7.0-0.rc2.20231125git0f5cc96c367f.26.fc40.x86_64 kernel
hotplugged HBA is visible but a disk hotplugged into it is not (like Fiona has reported).

Problem happens when hotpluged virtio-scsi-pci is the 2nd HBA on the same bridge,
an attempt to rescan HBA (any on the bridge) causes guest hang.


However with the same 0f5cc96c367f commit, upstream kernel (without initrd and some minimal config):

 -kernel ./linux-2.6/arch/x86_64/boot/bzImage -append 'root=/dev/sda3 console=ttyS0 console=tty0'

works as expected (aka disk is visible after hotplug)

[   75.636170] pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
[   75.636178] pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
[   75.637193] pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
[   75.638441] pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
[   75.647035] pci 0000:01:02.0: BAR 4: assigned [mem 0x380800004000-0x380800007fff 64bit pref]
[   75.649461] pci 0000:01:02.0: BAR 1: assigned [mem 0xfe801000-0xfe801fff]
[   75.650793] pci 0000:01:02.0: BAR 0: assigned [io  0xc040-0xc07f]
[   75.652109] pci 0000:00:05.0: PCI bridge to [bus 01]
[   75.653181] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
[   75.656971] pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[   75.659970] pci 0000:00:05.0:   bridge window [mem 0x380800000000-0x380fffffffff 64bit pref]
[   75.664990] virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
[   75.695505] scsi host3: Virtio SCSI HBA
[   75.698099] pci 0000:00:05.0: PCI bridge to [bus 01]
[   75.735840] pci 0000:00:05.0:   bridge window [io  0xc000-0xcfff]
[   75.740361] pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
[   75.744088] pci 0000:00:05.0:   bridge window [mem 0x380800000000-0x380fffffffff 64bit pref]


So, I'm still looking at where/why it goes wrong


> Bjorn
> 
> > Reboot
> >   
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> > > Nov 29 15:12:52 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> > > Nov 29 15:12:52 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > > Nov 29 15:12:52 hotplug kernel: scsi host3: Virtio SCSI HBA
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > Nov 29 15:12:52 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> > > Nov 29 15:12:52 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]  
> > 
> > RebootThe one time it did work. Note that the line with "QEMU HARDDISK"
> > comes after all lines with "bridge window":
> >   
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> > > Nov 29 15:13:51 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> > > Nov 29 15:13:51 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > > Nov 29 15:13:51 hotplug kernel: scsi host3: Virtio SCSI HBA
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> > > Nov 29 15:13:51 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xc000000000-0xc01fffffff 64bit pref]
> > > Nov 29 15:13:51 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: Attached scsi generic sg1 type 0
> > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: Power-on or device reset occurred
> > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Write Protect is off
> > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Mode Sense: 63 00 00 08
> > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > > Nov 29 15:13:51 hotplug kernel: sd 3:0:0:1: [sdb] Attached SCSI disk
> > > Nov 29 15:14:08 hotplug systemd[1]: systemd-fsckd.service: Deactivated successfully.  
> > 
> > 6.7.0-rc3 with the following reverted:
> > cc22522fd55e2 ("PCI: acpiphp: Use
> > pci_assign_unassigned_bridge_resources() only for non-root bus")
> > 40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary")
> >   
> > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xc000004000-0xc000007fff 64bit pref]
> > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> > > Nov 29 15:15:37 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> > > Nov 29 15:15:37 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> > > Nov 29 15:15:37 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> > > Nov 29 15:15:37 hotplug kernel: scsi host3: Virtio SCSI HBA
> > > Nov 29 15:15:37 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: Attached scsi generic sg1 type 0
> > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: Power-on or device reset occurred
> > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Write Protect is off
> > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Mode Sense: 63 00 00 08
> > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> > > Nov 29 15:15:37 hotplug kernel: sd 3:0:0:1: [sdb] Attached SCSI disk
> > > Nov 29 15:15:38 hotplug systemd[1]: systemd-fsckd.service: Deactivated successfully.  
> >   
> 


