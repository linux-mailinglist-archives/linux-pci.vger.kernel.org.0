Return-Path: <linux-pci+bounces-750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6623580CB87
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 14:53:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9F05B213BF
	for <lists+linux-pci@lfdr.de>; Mon, 11 Dec 2023 13:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47A047A43;
	Mon, 11 Dec 2023 13:52:53 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE97A1BC0;
	Mon, 11 Dec 2023 05:52:47 -0800 (PST)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 512AF453EF;
	Mon, 11 Dec 2023 14:52:43 +0100 (CET)
Message-ID: <c6233df5-01d8-498f-8235-ce4b102a2e91@proxmox.com>
Date: Mon, 11 Dec 2023 14:52:42 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, bhelgaas@google.com, lenb@kernel.org,
 rafael@kernel.org, Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <9eb669c0-d8f2-431d-a700-6da13053ae54@proxmox.com>
 <20231207232815.GA771837@bhelgaas>
 <20231208164723.12828a96@imammedo.users.ipa.redhat.com>
 <20231211084604.25e209af@imammedo.users.ipa.redhat.com>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231211084604.25e209af@imammedo.users.ipa.redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 11.12.23 um 08:46 schrieb Igor Mammedov:
> On Fri, 8 Dec 2023 16:47:23 +0100
> Igor Mammedov <imammedo@redhat.com> wrote:
> 
>> On Thu, 7 Dec 2023 17:28:15 -0600
>> Bjorn Helgaas <helgaas@kernel.org> wrote:
>>
>>>
>>> What's the actual symptom that this is broken?  All these log
>>> fragments show the exact same assignments for BARs 0, 1, 4 and for the
>>> bridge windows.
>>>

The disk never shows up in /dev

>>> I assume 0000:01:02.0 is the hot-added SCSI HBA, and 00:05.0 is a
>>> bridge leading to it?
>>>
>>> Can you put the complete dmesg logs somewhere?  There's a lot of
>>> context missing here.
>>>

Is this still necessary with Igor being able to reproduce the issue?

>>> Do you have to revert both cc22522fd55e2 and 40613da52b13f to make it
>>> work reliably?  If we have to revert something, reverting one would be
>>> better than reverting both.  
>>

Just reverting cc22522fd55e2 is not enough (and cc22522fd55e2 fixes
40613da52b13f so I can't revert just 40613da52b13f).

> 
> Fiona,
> 
> Does it help if you use q35 machine with '-global ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off' option?
> 

Yes, it does :)

I added the following to my QEMU commandline (first line, because there
wouldn't be a "pci.0" otherwise):

> -device 'pci-bridge,id=pci.0,chassis_nr=4' \
> -machine 'q35' \
> -global 'ICH9-LPC.acpi-pci-hotplug-with-bridge-support=off' \

and while it takes a few seconds, the disk does show up successfully:

> Dec 11 13:07:32 hotplug kernel: shpchp 0000:01:05.0: Latch close on Slot(2-1)
> Dec 11 13:07:32 hotplug kernel: shpchp 0000:01:05.0: Button pressed on Slot(2-1)
> Dec 11 13:07:32 hotplug kernel: shpchp 0000:01:05.0: Card present on Slot(2-1)
> Dec 11 13:07:32 hotplug kernel: shpchp 0000:01:05.0: PCI slot #2-1 - powering on due to button press
> Dec 11 13:07:38 hotplug kernel: pci 0000:02:02.0: [1af4:1004] type 00 class 0x010000
> Dec 11 13:07:38 hotplug kernel: pci 0000:02:02.0: reg 0x10: [io  0x0000-0x003f]
> Dec 11 13:07:38 hotplug kernel: pci 0000:02:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> Dec 11 13:07:38 hotplug kernel: pci 0000:02:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> Dec 11 13:07:38 hotplug kernel: pci 0000:02:02.0: BAR 4: assigned [mem 0xc040004000-0xc040007fff 64bit pref]
> Dec 11 13:07:38 hotplug kernel: pci 0000:02:02.0: BAR 1: assigned [mem 0xc1401000-0xc1401fff]
> Dec 11 13:07:38 hotplug kernel: pci 0000:02:02.0: BAR 0: assigned [io  0x8040-0x807f]
> Dec 11 13:07:38 hotplug kernel: shpchp 0000:01:05.0: PCI bridge to [bus 02]
> Dec 11 13:07:38 hotplug kernel: shpchp 0000:01:05.0:   bridge window [io  0x8000-0x8fff]
> Dec 11 13:07:38 hotplug kernel: shpchp 0000:01:05.0:   bridge window [mem 0xc1400000-0xc15fffff]
> Dec 11 13:07:38 hotplug kernel: shpchp 0000:01:05.0:   bridge window [mem 0xc040000000-0xc05fffffff 64bit pref]
> Dec 11 13:07:38 hotplug kernel: virtio-pci 0000:02:02.0: enabling device (0000 -> 0003)
> Dec 11 13:07:38 hotplug kernel: scsi host7: Virtio SCSI HBA
> Dec 11 13:07:38 hotplug kernel: scsi 7:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> Dec 11 13:07:38 hotplug kernel: sd 7:0:0:1: Attached scsi generic sg1 type 0
> Dec 11 13:07:38 hotplug kernel: sd 7:0:0:1: Power-on or device reset occurred
> Dec 11 13:07:38 hotplug kernel: sd 7:0:0:1: [sdb] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> Dec 11 13:07:38 hotplug kernel: sd 7:0:0:1: [sdb] Write Protect is off
> Dec 11 13:07:38 hotplug kernel: sd 7:0:0:1: [sdb] Mode Sense: 63 00 00 08
> Dec 11 13:07:38 hotplug kernel: sd 7:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Dec 11 13:07:38 hotplug kernel: sd 7:0:0:1: [sdb] Attached SCSI disk

Best Regards,
Fiona


