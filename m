Return-Path: <linux-pci+bounces-1619-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCE5822A9A
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 10:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2771C230F4
	for <lists+linux-pci@lfdr.de>; Wed,  3 Jan 2024 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6535318634;
	Wed,  3 Jan 2024 09:53:00 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from proxmox-new.maurer-it.com (proxmox-new.maurer-it.com [94.136.29.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A1BA1862A;
	Wed,  3 Jan 2024 09:52:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proxmox.com
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
	by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 15E4745133;
	Wed,  3 Jan 2024 10:46:55 +0100 (CET)
Message-ID: <45a1df73-c6c1-4d36-b84d-93bb4ec9f861@proxmox.com>
Date: Wed, 3 Jan 2024 10:46:47 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Qemu KVM thread spins at 100% CPU usage on scsi hot-unplug
 (kernel 6.6.8 guest)
Content-Language: en-US
To: Steven Haigh <netwiz@crc.id.au>, Lukas Wunner <lukas@wunner.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
References: <3a7656ab-df4c-4d57-8866-661beffcddd7@crc.id.au>
 <20231228131802.GA21994@wunner.de>
 <5f4dfc03-bdfc-41d1-8c5a-1e767e472a96@crc.id.au>
From: Fiona Ebner <f.ebner@proxmox.com>
In-Reply-To: <5f4dfc03-bdfc-41d1-8c5a-1e767e472a96@crc.id.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

Am 29.12.23 um 06:46 schrieb Steven Haigh:
> On 29/12/23 00:18, Lukas Wunner wrote:
>> On Thu, Dec 28, 2023 at 01:03:10PM +1100, Steven Haigh wrote:
>>> At some point in kernel 6.6.x, SCSI hotplug in qemu VMs broke. This was
>>> mostly fixed in the following commit to release 6.6.8:
>>>     commit 5cc8d88a1b94b900fd74abda744c29ff5845430b
>>>     Author: Bjorn Helgaas <bhelgaas@google.com>
>>>     Date:   Thu Dec 14 09:08:56 2023 -0600
>>>     Revert "PCI: acpiphp: Reassign resources on bridge if necessary"
>>>
>>> After this commit, the SCSI block device is hotplugged correctly, and
>>> a device node as /dev/sdX appears within the qemu VM.
>>>
>>> New problem:
>>>
>>> When the same SCSI block device is hot-unplugged, the QEMU KVM
>>> process will
>>> spin at 100% CPU usage. The guest shows no CPU being used via top,
>>> but the
>>> host will continue to spin in the KVM thread until the VM is rebooted.
>>
>> Find out the PID of the qemu process on the host, then cat
>> /proc/$PID/stack
>> to see where the CPU time is spent.
> 
> Thanks for the tip - I'll certainly do that.
> 
> Annoyingly, since I posted this report originally, then adding in a new
> report to the kernel.org lists in this, I have been unable to reproduce
> this problem. I have successfully done ~22 scsi hotplug / remove cycles
> and none resulted in reproducing the issue.
> 
> Kernel versions are still the same on both proxmox host and the Fedora
> guest - however I see an update on the host of the qemu-kvm packages in
> Proxmox. The proxmox host hasn't even been rebooted in this time.
> 
> I wonder if the initial revert included in 6.6.8 fixed the main problem,
> and the later update to qemu-kvm packages on the proxmox host followed
> by the last reboot of the VM with the new KVM package sorted the second
> issue.
> 
> Seeing as I can no longer reproduce this reliably - whereas it was 100%
> reproducible prior, maybe I'm now chasing ghosts.
> 

That sounds likely. Version pve-qemu-kvm=8.1.2-5 had a regression where
an IO thread in QEMU could start spinning after a drain (which happens
during hotplug on the QEMU side). It was introduced by an attempted fix
for a much rarer problem [0] and was reverted in pve-qemu-kvm=8.1.2-6
[1]. A proper fix is still being worked on [2].

[0]:
https://git.proxmox.com/?p=pve-qemu.git;a=commit;h=6b7c1815e1c89cb66ff48fbba6da69fe6d254630
[1]:
https://git.proxmox.com/?p=pve-qemu.git;a=commit;h=2a49e667bae33f2a5c6ba6b59a0cd26387f73a27
[2]: https://lists.nongnu.org/archive/html/qemu-devel/2023-12/msg01900.html

Best Regards,
Fiona

> I'll still continue to monitor - as I normally do this SCSI hotplug ~3
> times per week doing backups to different external HDDs - so if I do
> observe it again, I'll grab the stack and reply to this thread again
> with what I can find.
> 
> Until then, I don't want to waste other peoples time also chasing ghosts :)
> 



