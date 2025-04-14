Return-Path: <linux-pci+bounces-25838-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D11A8840C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 16:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4B32E7A52EE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 14:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3E532472B6;
	Mon, 14 Apr 2025 13:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="Xo+exckN"
X-Original-To: linux-pci@vger.kernel.org
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD92472AB;
	Mon, 14 Apr 2025 13:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744638208; cv=none; b=W5jKgNSa5d7HdJ1s7BUCj0B7Y2gMLnSqLFICSxB//zu9WbbgmOUaYJhdibIqj2hIDzC3a9zmE+nPv44/YVH+zNev6EgDrcNJjsT/D5gACe/bY7aUq+7wvrdL0jMUt1mn1FV7gQ+mJR1UNfkEjaahvq81AfRzl37qjmCWbC770d0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744638208; c=relaxed/simple;
	bh=bC1LTKgQufGAY+CTP8w+9VlNqz332hXZcljRgHU2eqI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PgbN2igHmQH1HODmC9PoioX1R5ZTkik8vQDO8vbdW6tYLM7fuvag3esWbrOMkmHjSOOteEKcvPphp2XEGxYJdipxmQiyDcW8LNZZ/+T7PYICFSKt6v5/HmvZpBhziHW27LKu9xcuOswRNDmQIbmLORFdUgUKolsHWiftVwZyBxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=Xo+exckN; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1744638203; bh=bC1LTKgQufGAY+CTP8w+9VlNqz332hXZcljRgHU2eqI=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=Xo+exckNNSlHgy5TqpQZgchCx+MbzaQHSwLmTw0PMgpmIZ/2B1tMA2xvt4xCRrQmS
	 soUB385/C/dT2TokXS2oArnfwVZd/3thWnRUstlmLXD6Gi8gg5fYGcaEYBG2qP755o
	 U8bAaXAsi6IN9UqtAubRCnikUARWz0xB7VUu1lQY=
Date: Mon, 14 Apr 2025 15:43:22 +0200
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: Guenter Roeck <linux@roeck-us.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Igor Mammedov <imammedo@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
Message-ID: <rndyvjlylykt7aj6czm5awh47ddi3j22zna45zfppq5iu4xdgd@tqvzfa524vd3>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>, Guenter Roeck <linux@roeck-us.net>, 
	Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org, 
	=?utf-8?Q?Micha=C5=82?= Winiarski <michal.winiarski@intel.com>, Igor Mammedov <imammedo@redhat.com>, 
	LKML <linux-kernel@vger.kernel.org>, Mika Westerberg <mika.westerberg@linux.intel.com>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
 <01eb7d40-f5b5-4ec5-b390-a5c042c30aff@roeck-us.net>
 <75f74b48-edd8-7d1c-d303-1222d12e3812@linux.intel.com>
 <6612c4d2-2533-98ef-7c89-f61d80c3e3e2@linux.intel.com>
 <5eb8fd42-b288-4ecb-ae0e-177904cc0a14@roeck-us.net>
 <c34c6dc2-5ab2-1a81-3ba4-b3bc2c016945@linux.intel.com>
 <nb4knp52jylojmj3jsvvgq2dsbn3srruxmkqfuto2k3hv3fnqs@6rkqgdved6gi>
 <9c9d5aed-ae10-f590-3e59-34234d4d8f7d@linux.intel.com>
 <tuhhms3jfcbgzzgmxt7ghvhp5zoh56ue2ikvge2kdhsudnpoon@elmy6yymd6bf>
 <a822896a-de7d-697c-2240-2afa95b318f3@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a822896a-de7d-697c-2240-2afa95b318f3@linux.intel.com>

On Mon, Apr 14, 2025 at 04:15:01PM +0300, Ilpo Järvinen wrote:
> On Mon, 14 Apr 2025, Ondřej Jirman wrote:
> > On Mon, Apr 14, 2025 at 12:52:15PM +0300, Ilpo Järvinen wrote:
> > > On Fri, 11 Apr 2025, Ondřej Jirman wrote:
> > > 
> > > > Hello Ilpo,
> > > > 
> > > > On Tue, Apr 01, 2025 at 08:38:48PM +0300, Ilpo Järvinen wrote:
> > > > > That log wasn't taken from a bad case but it doesn't matter anymore as I 
> > > > > could test this with qemu myself, thanks for providing enough to make it 
> > > > > easy to reproduce & test it locally :-).
> > > > > 
> > > > > The problem is caused by assign+release cycle being destructive on start 
> > > > > aligned resources because successful assigment overwrites the start field. 
> > > > > I'll send a patch to fix the problem once I've given it a bit more thought
> > > > > as this resource fitting code is somewhat complex.
> > > > 
> > > > BTW, same thing here on a different SoC:
> > > > 
> > > > https://lore.kernel.org/lkml/hrcsm2bo4ysqj2ggejndlou32cdc7yiknnm5nrlcoz4d64wall@7te4dfqsoe3y/T/#u
> > > > 
> > > > There are kernel logs there, too, although I don't have dynamic debug enabled
> > > > in the kernel.
> > > > 
> > > > Interestingly, bisect pointed me initially to a different commit. Reverting
> > > > it helped, but just on one board (QuartzPro64).
> > > 
> > > Hi,
> > > 
> > > Since you didn't mention it, I guess you haven't tried the fix:
> > > 
> > > https://patchwork.kernel.org/project/linux-pci/patch/20250403093137.1481-1-ilpo.jarvinen@linux.intel.com/
> > 
> > This patch works. Thank you.
> 
> Thanks for testing. If you feel confident enough, please send your 
> Tested-by tag to its thread (not this one).
> 
> > One difference compared to 6.14 that I'm noticing
> > in the kernel log is that "save config" sequences now are printed twice for
> > unpopulated port. Not sure if it's related to your patches. Previously it was
> > printed just once.
> 
> I don't think it is related. The resource fitting/assignment changes 
> should not impact PCI save/restore AFAIK (except by preventing device from 
> working in the first place if necessary resources do not get assigned).
> 
> PCI state saving has always seemed like that in most logs I've seen with 
> dyndbg enabled, that is, the state is seemingly saved multiple times, 
> often right after the previous save too. So TBH, I'm not convinced it's 
> even something new. If you have backtraces to show those places that 
> invoke pci_save_state() I can take a look but I don't expect much to 
> come out of that.

You're right. It's unrelated. The traces:

[    1.878732]  show_stack+0x28/0x80 (C)
[    1.878751]  dump_stack_lvl+0x58/0x74
[    1.878762]  dump_stack+0x14/0x1c
[    1.878772]  pci_save_state+0x34/0x1e8
[    1.878783]  pcie_portdrv_probe+0x330/0x6a8
[    1.878794]  local_pci_probe+0x3c/0xa0
[    1.878804]  pci_device_probe+0xac/0x194
[    1.878813]  really_probe+0xbc/0x388
[    1.878825]  __driver_probe_device+0x78/0x144
[    1.878837]  driver_probe_device+0x38/0x110
[    1.878850]  __device_attach_driver+0xb0/0x150
[    1.878862]  bus_for_each_drv+0x6c/0xb0
[    1.878873]  __device_attach+0x98/0x1a0
[    1.878886]  device_attach+0x10/0x20
[    1.878897]  pci_bus_add_device+0x84/0x12c
[    1.878911]  pci_bus_add_devices+0x40/0x90
[    1.878924]  pci_host_probe+0x88/0xe4
[    1.878933]  dw_pcie_host_init+0x258/0x714
[    1.878945]  rockchip_pcie_probe+0x2f0/0x3f8
[    1.878956]  platform_probe+0x64/0xcc
[    1.878965]  really_probe+0xbc/0x388
[    1.878977]  __driver_probe_device+0x78/0x144
[    1.878989]  driver_probe_device+0x38/0x110
[    1.879001]  __device_attach_driver+0xb0/0x150
[    1.879014]  bus_for_each_drv+0x6c/0xb0
[    1.879025]  __device_attach+0x98/0x1a0
[    1.879037]  device_initial_probe+0x10/0x20
[    1.879049]  bus_probe_device+0xa8/0xb8
[    1.879061]  deferred_probe_work_func+0xa4/0xf0
[    1.879072]  process_one_work+0x13c/0x2bc
[    1.879084]  worker_thread+0x284/0x460
[    1.879094]  kthread+0xe4/0x1a0
[    1.879107]  ret_from_fork+0x10/0x20
[    1.879121] pcieport 0002:20:00.0: save config 0x00: 0x35881d87
[    1.879158] pcieport 0002:20:00.0: save config 0x04: 0x00100507
[    1.879168] pcieport 0002:20:00.0: save config 0x08: 0x06040001
[    1.879177] pcieport 0002:20:00.0: save config 0x0c: 0x00010000
[    1.879221] pcieport 0002:20:00.0: save config 0x10: 0x00000000
[    1.879232] pcieport 0002:20:00.0: save config 0x14: 0x00000000
[    1.879242] pcieport 0002:20:00.0: save config 0x18: 0x00212120
[    1.879251] pcieport 0002:20:00.0: save config 0x1c: 0x000000f0
[    1.879260] pcieport 0002:20:00.0: save config 0x20: 0x0000fff0
[    1.879270] pcieport 0002:20:00.0: save config 0x24: 0x0001fff1
[    1.879279] pcieport 0002:20:00.0: save config 0x28: 0x00000000
[    1.879289] pcieport 0002:20:00.0: save config 0x2c: 0x00000000
[    1.879298] pcieport 0002:20:00.0: save config 0x30: 0x00000000
[    1.879307] pcieport 0002:20:00.0: save config 0x34: 0x00000040
[    1.879316] pcieport 0002:20:00.0: save config 0x38: 0x00000000
[    1.879325] pcieport 0002:20:00.0: save config 0x3c: 0x00020194               
[    1.879376] pcieport 0002:20:00.0: vgaarb: pci_notify

second time it's from:

[    2.004478] Workqueue: pm pm_runtime_work
[    2.004488] Call trace:
[    2.004491]  show_stack+0x28/0x80 (C)
[    2.004500]  dump_stack_lvl+0x58/0x74
[    2.004506]  dump_stack+0x14/0x1c
[    2.004511]  pci_save_state+0x34/0x1e8
[    2.004516]  pci_pm_runtime_suspend+0xa8/0x1e0
[    2.004521]  __rpm_callback+0x3c/0x220
[    2.004527]  rpm_callback+0x6c/0x80
[    2.004532]  rpm_suspend+0xec/0x674
[    2.004537]  pm_runtime_work+0x104/0x114
[    2.004542]  process_one_work+0x13c/0x2bc
[    2.004548]  worker_thread+0x284/0x460
[    2.004552]  kthread+0xe4/0x1a0
[    2.004559]  ret_from_fork+0x10/0x20
[    2.004567] pcieport 0002:20:00.0: save config 0x00: 0x35881d87
[    2.004578] pcieport 0002:20:00.0: save config 0x04: 0x00100507
[    2.004583] pcieport 0002:20:00.0: save config 0x08: 0x06040001
[    2.004587] pcieport 0002:20:00.0: save config 0x0c: 0x00010000
[    2.004591] pcieport 0002:20:00.0: save config 0x10: 0x00000000
[    2.004596] pcieport 0002:20:00.0: save config 0x14: 0x00000000
[    2.004600] pcieport 0002:20:00.0: save config 0x18: 0x00212120
[    2.004604] pcieport 0002:20:00.0: save config 0x1c: 0x000000f0
[    2.004608] pcieport 0002:20:00.0: save config 0x20: 0x0000fff0
[    2.004613] pcieport 0002:20:00.0: save config 0x24: 0x0001fff1
[    2.004617] pcieport 0002:20:00.0: save config 0x28: 0x00000000
[    2.004621] pcieport 0002:20:00.0: save config 0x2c: 0x00000000
[    2.004625] pcieport 0002:20:00.0: save config 0x30: 0x00000000
[    2.004629] pcieport 0002:20:00.0: save config 0x34: 0x00000040
[    2.004633] pcieport 0002:20:00.0: save config 0x38: 0x00000000
[    2.004638] pcieport 0002:20:00.0: save config 0x3c: 0x00020194
[    2.004662] pcieport 0002:20:00.0: PME# enabled

on 6.15-rc:

cat /sys/class/pci_bus/0002:20/device/0002:20:00.0/power/runtime_status                                                                                                                                                      OK
suspended

on 6.14:

cat /sys/class/pci_bus/0002:20/device/0002:20:00.0/power/runtime_status                                                                                                                                                      OK
active

So some other unrelated change in 6.15-rc just enabled RPM to suspend the unused
port.

Thnak you,
	o.


> -- 
>  i.
> 
> > Kind regards,
> > 	o.
> > 
> > rockchip-dw-pcie a40800000.pcie: PCI host bridge to bus 0002:20
> > pci_bus 0002:20: root bus resource [bus 20-2f]
> > pci_bus 0002:20: root bus resource [io  0x300000-0x3fffff] (bus address [0xf2100000-0xf21fffff])
> > pci_bus 0002:20: root bus resource [mem 0xf2200000-0xf2ffffff]
> > pci_bus 0002:20: root bus resource [mem 0x980000000-0x9bfffffff] (bus address [0x40000000-0x7fffffff])
> > pci_bus 0002:20: scanning bus
> > pci 0002:20:00.0: [1d87:3588] type 01 class 0x060400 PCIe Root Port
> > pci 0002:20:00.0: ROM [mem 0x00000000-0x0000ffff pref]
> > pci 0002:20:00.0: PCI bridge to [bus 01-ff]
> > pci 0002:20:00.0:   bridge window [io  0x0000-0x0fff]
> > pci 0002:20:00.0:   bridge window [mem 0x00000000-0x000fffff]
> > pci 0002:20:00.0:   bridge window [mem 0x00000000-0x000fffff 64bit pref]
> > pci 0002:20:00.0: supports D1 D2
> > pci 0002:20:00.0: PME# supported from D0 D1 D3hot
> > pci 0002:20:00.0: PME# disabled
> > pci 0002:20:00.0: Adding to iommu group 9
> > pci 0002:20:00.0: vgaarb: pci_notify
> > pci_bus 0002:20: fixups for bus
> > pci 0002:20:00.0: scanning [bus 01-ff] behind bridge, pass 0
> > pci 0002:20:00.0: Primary bus is hard wired to 0
> > pci 0002:20:00.0: bridge configuration invalid ([bus 01-ff]), reconfiguring
> > pci 0002:20:00.0: scanning [bus 00-00] behind bridge, pass 1
> > pci_bus 0002:20: bus scan returning with max=21
> > pci 0002:20:00.0: ROM [mem 0xf2200000-0xf220ffff pref]: assigned
> > pci 0002:20:00.0: PCI bridge to [bus 21]
> > pci_bus 0002:20: resource 4 [io  0x300000-0x3fffff]
> > pci_bus 0002:20: resource 5 [mem 0xf2200000-0xf2ffffff]
> > pci_bus 0002:20: resource 6 [mem 0x980000000-0x9bfffffff]
> > pcieport 0002:20:00.0: vgaarb: pci_notify
> > pcieport 0002:20:00.0: assign IRQ: got 148
> > pcieport 0002:20:00.0: PME: Signaling with IRQ 157
> > pcieport 0002:20:00.0: AER: enabled with IRQ 158
> > pcieport 0002:20:00.0: bwctrl: enabled with IRQ 157
> > pcieport 0002:20:00.0: save config 0x00: 0x35881d87
> > pcieport 0002:20:00.0: save config 0x04: 0x00100507
> > pcieport 0002:20:00.0: save config 0x08: 0x06040001
> > pcieport 0002:20:00.0: save config 0x0c: 0x00010000
> > pcieport 0002:20:00.0: save config 0x10: 0x00000000
> > pcieport 0002:20:00.0: save config 0x14: 0x00000000
> > pcieport 0002:20:00.0: save config 0x18: 0x00212120
> > pcieport 0002:20:00.0: save config 0x1c: 0x000000f0
> > pcieport 0002:20:00.0: save config 0x20: 0x0000fff0
> > pcieport 0002:20:00.0: save config 0x24: 0x0001fff1
> > pcieport 0002:20:00.0: save config 0x28: 0x00000000
> > pcieport 0002:20:00.0: save config 0x2c: 0x00000000
> > pcieport 0002:20:00.0: save config 0x30: 0x00000000
> > pcieport 0002:20:00.0: save config 0x34: 0x00000040
> > pcieport 0002:20:00.0: save config 0x38: 0x00000000
> > pcieport 0002:20:00.0: save config 0x3c: 0x00020194
> > pcieport 0002:20:00.0: vgaarb: pci_notify
> > pcieport 0002:20:00.0: save config 0x00: 0x35881d87
> > pcieport 0002:20:00.0: save config 0x04: 0x00100507
> > pcieport 0002:20:00.0: save config 0x08: 0x06040001
> > pcieport 0002:20:00.0: save config 0x0c: 0x00010000
> > pcieport 0002:20:00.0: save config 0x10: 0x00000000
> > pcieport 0002:20:00.0: save config 0x14: 0x00000000
> > pcieport 0002:20:00.0: save config 0x18: 0x00212120
> > pcieport 0002:20:00.0: save config 0x1c: 0x000000f0
> > pcieport 0002:20:00.0: save config 0x20: 0x0000fff0
> > pcieport 0002:20:00.0: save config 0x24: 0x0001fff1
> > pcieport 0002:20:00.0: save config 0x28: 0x00000000
> > pcieport 0002:20:00.0: save config 0x2c: 0x00000000
> > pcieport 0002:20:00.0: save config 0x30: 0x00000000
> > pcieport 0002:20:00.0: save config 0x34: 0x00000040
> > pcieport 0002:20:00.0: save config 0x38: 0x00000000
> > pcieport 0002:20:00.0: save config 0x3c: 0x00020194
> > pcieport 0002:20:00.0: PME# enabled
> > 
> > 
> > > -- 
> > >  i.
> > > 
> > > > And this is iomem:
> > > > 
> > > > 0010f000-0010f0ff : 10f000.sram sram@10f000
> > > > 00200000-e2bbffff : System RAM
> > > >   02010000-0474ffff : Kernel code
> > > >   04750000-0498ffff : reserved
> > > >   04990000-0508ffff : Kernel data
> > > >   daa00000-e29fffff : reserved
> > > > e2bc0000-ecbbffff : reserved
> > > >   e2bc0000-ecbbffff : reserved
> > > > ecbc0000-efffffff : System RAM
> > > >   ecbc7000-ecbdffff : reserved
> > > > f0000000-f00fffff : a40000000.pcie config
> > > > f0200000-f0ffffff : pcie@fe150000
> > > >   f0200000-f020ffff : 0000:00:00.0
> > > >   f0300000-f03fffff : PCI Bus 0000:01
> > > >     f0300000-f0303fff : 0000:01:00.0
> > > >       f0300000-f0303fff : nvme
> > > >     f0304000-f03040ff : 0000:01:00.0
> > > >       f0304000-f03040ff : nvme
> > > > f2000000-f20fffff : a40800000.pcie config
> > > > f2200000-f2ffffff : pcie@fe170000
> > > >   f2200000-f27fffff : PCI Bus 0002:21
> > > >     f2200000-f220ffff : 0002:21:00.0
> > > >     f2400000-f27fffff : 0002:21:00.0
> > > >   f2800000-f280ffff : 0002:20:00.0
> > > > f3000000-f30fffff : a40c00000.pcie config
> > > > f3200000-f3ffffff : pcie@fe180000
> > > >   f3200000-f320ffff : 0003:30:00.0
> > > >   f3300000-f33fffff : PCI Bus 0003:31
> > > >     f3300000-f3303fff : 0003:31:00.0
> > > >     f3304000-f3304fff : 0003:31:00.0
> > > >       f3304000-f3304fff : r8169
> > > > fb000000-fb1fffff : fb000000.gpu gpu@fb000000
> > > > fc00c100-fc3fffff : fc000000.usb usb@fc000000
> > > > fc400000-fc407fff : usb@fc400000
> > > >   fc400000-fc407fff : xhci-hcd.10.auto usb@fc400000
> > > > fc40c100-fc7fffff : fc400000.usb usb@fc400000
> > > > fc800000-fc83ffff : fc800000.usb usb@fc800000
> > > > fc840000-fc87ffff : fc840000.usb usb@fc840000
> > > > fc880000-fc8bffff : fc880000.usb usb@fc880000
> > > > fc8c0000-fc8fffff : fc8c0000.usb usb@fc8c0000
> > > > fc900000-fc900dff : fc900000.iommu
> > > > fc910000-fc910dff : fc900000.iommu
> > > > fd600000-fd6fffff : fd600000.sram sram@fd600000
> > > > fd8a0000-fd8a00ff : fd8a0000.gpio gpio@fd8a0000
> > > > fdb50000-fdb507ff : fdb50000.video-codec video-codec@fdb50000
> > > > fdb50800-fdb5083f : fdb50800.iommu iommu@fdb50800
> > > > fdb80000-fdb8017f : fdb80000.rga rga@fdb80000
> > > > fdba0000-fdba07ff : fdba0000.video-codec video-codec@fdba0000
> > > > fdba0800-fdba083f : fdba0800.iommu iommu@fdba0800
> > > > fdba4800-fdba483f : fdba4800.iommu iommu@fdba4800
> > > > fdba8800-fdba883f : fdba8800.iommu iommu@fdba8800
> > > > fdbac800-fdbac83f : fdbac800.iommu iommu@fdbac800
> > > > fdc70000-fdc707ff : fdc70000.video-codec video-codec@fdc70000
> > > > fdd90000-fdd941ff : fdd90000.vop vop
> > > > fdd95000-fdd95fff : fdd90000.vop gamma-lut
> > > > fdd97e00-fdd97eff : fdd97e00.iommu iommu@fdd97e00
> > > > fdd97f00-fdd97fff : fdd97e00.iommu iommu@fdd97e00
> > > > fddf0000-fddf0fff : fddf0000.i2s i2s@fddf0000
> > > > fddf4000-fddf4fff : fddf4000.i2s i2s@fddf4000
> > > > fde80000-fde9ffff : fde80000.hdmi hdmi@fde80000
> > > > fdea0000-fdebffff : fdea0000.hdmi hdmi@fdea0000
> > > > fdee0000-fdee5fff : fdee0000.hdmi_receiver hdmi_receiver@fdee0000
> > > > fe060000-fe06ffff : fe060000.dfi dfi@fe060000
> > > > fe150000-fe15ffff : a40000000.pcie apb
> > > > fe170000-fe17ffff : a40800000.pcie apb
> > > > fe180000-fe18ffff : a40c00000.pcie apb
> > > > fe1b0000-fe1bffff : fe1b0000.ethernet ethernet@fe1b0000
> > > > fe210000-fe210fff : fe210000.sata sata@fe210000
> > > > fe2c0000-fe2c3fff : fe2c0000.mmc mmc@fe2c0000
> > > > fe2e0000-fe2effff : fe2e0000.mmc mmc@fe2e0000
> > > > fe470000-fe470fff : fe470000.i2s i2s@fe470000
> > > > fe600000-fe60ffff : GICD
> > > > fe680000-fe77ffff : GICR
> > > > fea10000-fea13fff : dma-controller@fea10000
> > > >   fea10000-fea13fff : fea10000.dma-controller dma-controller@fea10000
> > > > fea30000-fea33fff : dma-controller@fea30000
> > > >   fea30000-fea33fff : fea30000.dma-controller dma-controller@fea30000
> > > > feaa0000-feaa0fff : feaa0000.i2c i2c@feaa0000
> > > > feaf0000-feaf00ff : feaf0000.watchdog watchdog@feaf0000
> > > > feb20000-feb20fff : feb20000.spi spi@feb20000
> > > > feb50000-feb500ff : serial
> > > > fec00000-fec003ff : fec00000.tsadc tsadc@fec00000
> > > > fec10000-fec1ffff : fec10000.adc adc@fec10000
> > > > fec20000-fec200ff : fec20000.gpio gpio@fec20000
> > > > fec30000-fec300ff : fec30000.gpio gpio@fec30000
> > > > fec40000-fec400ff : fec40000.gpio gpio@fec40000
> > > > fec50000-fec500ff : fec50000.gpio gpio@fec50000
> > > > fec90000-fec90fff : fec90000.i2c i2c@fec90000
> > > > fed10000-fed13fff : dma-controller@fed10000
> > > >   fed10000-fed13fff : fed10000.dma-controller dma-controller@fed10000
> > > > fed60000-fed61fff : fed60000.phy phy@fed60000
> > > > fed70000-fed71fff : fed70000.phy phy@fed70000
> > > > fed80000-fed8ffff : fed80000.phy phy@fed80000
> > > > fed90000-fed9ffff : fed90000.phy phy@fed90000
> > > > fee00000-fee000ff : fee00000.phy phy@fee00000
> > > > fee10000-fee100ff : fee10000.phy phy@fee10000
> > > > fee20000-fee200ff : fee20000.phy phy@fee20000
> > > > fee80000-fee9ffff : fee80000.phy phy@fee80000
> > > > ff001000-ff0effff : ff001000.sram sram@ff001000
> > > > 100000000-3fbffffff : System RAM
> > > >   3ec000000-3fbffffff : reserved
> > > > 3fc500000-3ffefffff : System RAM
> > > > 4f0000000-4ffffffff : System RAM
> > > >   4fc611000-4fc6d0fff : reserved
> > > >   4fc6d1000-4fded1fff : reserved
> > > >   4fded2000-4fdf91fff : reserved
> > > >   4fdf93000-4fdf96fff : reserved
> > > >   4fdf97000-4fdfabfff : reserved
> > > >   4fdfac000-4fe051fff : reserved
> > > >   4fe052000-4ffffffff : reserved
> > > > 900000000-93fffffff : pcie@fe150000
> > > >   900000000-93fffffff : 0000:00:00.0
> > > > 980000000-9bfffffff : pcie@fe170000
> > > > 9c0000000-9ffffffff : pcie@fe180000
> > > > a40000000-a403fffff : a40000000.pcie dbi
> > > > a40800000-a40bfffff : a40800000.pcie dbi
> > > > a40c00000-a40ffffff : a40c00000.pcie dbi
> > > > 
> > > > Thank you,
> > > > 	o.
> > > > 
> > > > > -- 
> > > > >  i.
> > > > 
> > 


