Return-Path: <linux-pci+bounces-322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DB90A8006C9
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 10:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18D0A1C20A44
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B831CF91;
	Fri,  1 Dec 2023 09:25:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C50C171B;
	Fri,  1 Dec 2023 01:24:53 -0800 (PST)
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id A8F5643546;
	Fri,  1 Dec 2023 10:24:51 +0100 (CET)
Message-ID: <4dbc72ba-8edb-4ff5-b95d-b601189e4415@proxmox.com>
Date: Fri, 1 Dec 2023 10:24:41 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SCSI hotplug issues with UEFI VM with guest kernel >= 6.5
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-acpi@vger.kernel.org,
 Igor Mammedov <imammedo@redhat.com>, linux-kernel@vger.kernel.org,
 bhelgaas@google.com, lenb@kernel.org, rafael@kernel.org,
 Thomas Lamprecht <t.lamprecht@proxmox.com>
References: <20231130231802.GA498017@bhelgaas>
Content-Language: en-US
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <20231130231802.GA498017@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Am 01.12.23 um 00:18 schrieb Bjorn Helgaas:
> On Wed, Nov 29, 2023 at 04:22:41PM +0100, Fiona Ebner wrote:
>> Hi,
>> it seems that hot-plugging SCSI disks for QEMU virtual machines booting
>> with UEFI and with guest kernels >= 6.5 might be broken. It's not
>> consistently broken, hinting there might be a race somewhere.
>>
>> Reverting the following two commits seems to make it work reliably again:
>>
>> cc22522fd55e2 ("PCI: acpiphp: Use
>> pci_assign_unassigned_bridge_resources() only for non-root bus")
>> 40613da52b13f ("PCI: acpiphp: Reassign resources on bridge if necessary"
>>
>> Of course, they might only expose some pre-existing issue, but this is
>> my best lead. See below for some logs and details about an affected
>> virtual machine. Happy to provide more information and to debug/test
>> further.
> 
> Shoot.  Thanks very much for the report and your debugging.  I'm
> hoping Igor will chime in with some ideas.
> 
> Both of those commits appeard in v6.5 and fixed legit issues, so I
> hate to revert them, but this does appear to be a regression.
> 
> #regzbot introduced: cc22522fd55e2 ^
> #regzbot introduced: 40613da52b13f ^
> 
>> Host kernel: 6.5.11-4-pve which is based on the one from Ubuntu
>> Guest kernel: 6.7.0-rc3 and 6.7.0-rc3 with above commits reverted
>> QEMU version: v8.1.0 built from source
>> EDK2 version: submodule in the QEMU v8.1 repository: edk2-stable202302
>>

I should mention that I haven't run into the issue when booting the VM
with SeaBIOS yet.

Log for 6.7.0-rc3 + SeaBIOS (bundled with QEMU 8.1):

> Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: [1af4:1004] type 00 class 0x010000
> Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x10: [io  0x0000-0x003f]
> Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x14: [mem 0x00000000-0x00000fff]
> Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: reg 0x20: [mem 0x00000000-0x00003fff 64bit pref]
> Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 4: assigned [mem 0xfd404000-0xfd407fff 64bit pref]
> Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 1: assigned [mem 0xfe801000-0xfe801fff]
> Dec 01 10:08:08 hotplug kernel: pci 0000:01:02.0: BAR 0: assigned [io  0xe040-0xe07f]
> Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
> Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfd400000-0xfd5fffff 64bit pref]
> Dec 01 10:08:08 hotplug kernel: virtio-pci 0000:01:02.0: enabling device (0000 -> 0003)
> Dec 01 10:08:08 hotplug kernel: ACPI: \_SB_.LNKC: Enabled at IRQ 11
> Dec 01 10:08:08 hotplug kernel: scsi host3: Virtio SCSI HBA
> Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0: PCI bridge to [bus 01]
> Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [io  0xe000-0xefff]
> Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfe800000-0xfe9fffff]
> Dec 01 10:08:08 hotplug kernel: scsi 3:0:0:1: Direct-Access     QEMU     QEMU HARDDISK    2.5+ PQ: 0 ANSI: 5
> Dec 01 10:08:08 hotplug kernel: pci 0000:00:05.0:   bridge window [mem 0xfd400000-0xfd5fffff 64bit pref]
> Dec 01 10:08:08 hotplug kernel: scsi 3:0:0:1: Attached scsi generic sg1 type 0
> Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: Power-on or device reset occurred
> Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] 2048 512-byte logical blocks: (1.05 MB/1.00 MiB)
> Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Write Protect is off
> Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Mode Sense: 63 00 00 08
> Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Write cache: enabled, read cache: enabled, doesn't support DPO or FUA
> Dec 01 10:08:08 hotplug kernel: sd 3:0:0:1: [sdb] Attached SCSI disk

Interestingly, the line with "QEMU HARDDISK" does not come after all
lines with "bridge window" like was the case for the one time it did
work with UEFI. So maybe that was just a red herring.

Best Regards,
Fiona


