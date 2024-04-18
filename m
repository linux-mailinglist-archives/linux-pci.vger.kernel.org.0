Return-Path: <linux-pci+bounces-6412-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A6628A97DC
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 12:53:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50D92282379
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 10:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBE0715DBA0;
	Thu, 18 Apr 2024 10:52:27 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D57A315D5C1
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 10:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437547; cv=none; b=Z5LtKmrZJTEctUY/pVU5tfyC9xJrzu5Cxihm/siZ0SbzbtNL0k8i7espj4lgdCNj9B77buc1HgP7xxccgw0LJ8nPE8/ZNLgcn5U5pkIhG8LV5O8Ax3vD98fsD4ntpwVgn2qsN2mjGHGrJ5g0gkwIKMfT4sqStvcBQqZGiSVq+es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437547; c=relaxed/simple;
	bh=AF5pNreT+z3H0VNDlDv63FSwzLWHUdCOAQcmeV7Io7k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TZTvce7zjimqeABnfRGUqdS0nX5x6TSdgLNB/gDSMBZhztmzzgj9uMR5RqGwg2yjkJ/HOAer4AxxbFoCV1knNUn+vpf9nymOKFhp768w5WNLCEtFgortcWrbMYbgfH8Zt5pOMA9b1saVAjFUhGhPrMWzMzPoxjskdiEVZcLpJXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com; spf=pass smtp.mailfrom=bakke.com; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bakke.com
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 2366B1A0F0B;
	Thu, 18 Apr 2024 10:42:28 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: dag@bakke.com) by omf12.hostedemail.com (Postfix) with ESMTPA id 4677817;
	Thu, 18 Apr 2024 10:42:26 +0000 (UTC)
Message-ID: <fa9245d6-ffb7-4bac-8740-219af7fcd02a@bakke.com>
Date: Thu, 18 Apr 2024 12:42:24 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCIE BAR resizing blocked by another BAR on same device?
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
References: <20240417151313.GA202307@bhelgaas>
 <d509c9e6-37be-44ab-8f47-6fe55397794e@amd.com>
Content-Language: en-US
From: Dag B <dag@bakke.com>
In-Reply-To: <d509c9e6-37be-44ab-8f47-6fe55397794e@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4677817
X-Stat-Signature: gaj4y4dhqxfj7gyzs7foy8z6stat9ccn
X-Rspamd-Server: rspamout05
X-Session-Marker: 6461674062616B6B652E636F6D
X-Session-ID: U2FsdGVkX1/SlrnKAiZ7MpxXE+UiziaycxnAuEVvkVo=
X-HE-Tag: 1713436946-931717
X-HE-Meta: U2FsdGVkX1/zHiV7DBXTpIhw1yMTnNShu1HOumU4gDjtcOBuM8r356qyMAUW83ja85IGzkItD8YE6PAvBpetLZlxxDCWM3cpSJuaXrsfCDubPvwVbA91d/7vCI9T4Awh8RqngdfpHn9fUAcbAOqy4JtKLaZt3rczQhO+Ksw2Wiwyjdjg9o8GPg0L2/mKBSAmYl2uPx5iiye8xSfkb0cGFBCm1qEXaYFfmNOjmIZWa35O6GdbUiyzEoUa8BTvnrTBLQZUrQPj9QZwVNssyzFJlrpaix/ifG5JaiFeDInmKkrRAoJmmnIQlSM+6XfDtR8DbN6Cok9zfmRx7C//qdBBsOyVOOOdiixv


On 18.04.2024 09:51, Christian König wrote:
> Hi Dag and Bjorn,
>
> Am 17.04.24 um 17:13 schrieb Bjorn Helgaas:
>> [+to Christian, resizable BAR expert]
>>
>> On Wed, Apr 17, 2024 at 03:16:06PM +0200, Dag B wrote:
>>> Hi.
>>>
>>> In short, I have a GPU for which lspci reveals:
>>>
>>> Capabilities: [bb0 v1] Physical Resizable BAR
>>>
>>>          BAR 0: current size: 16MB, supported: 16MB
>>>          BAR 1: current size: 128MB, supported: 64MB 128MB 256MB 
>>> 512MB 1GB
>>> 2GB 4GB 8GB 16GB 32GB
>>>          BAR 3: current size: 32MB, supported: 32MB
>>>
>>> In dmesg I see:
>>>
>>> [    0.517191] pci 0000:08:00.0: BAR 1 [mem 
>>> 0x6000000000-0x600fffffff 64bit
>>> pref]: assigned
>>> [    0.517238] pci 0000:08:00.0: BAR 3 [mem 
>>> 0x6010000000-0x6011ffffff 64bit
>>> pref]: assigned
>>> [    0.517261] pci 0000:08:00.0: BAR 0 [mem 0xa4000000-0xa4ffffff]: 
>>> assigned
>>>
>>> I take it the location of BAR 3 right after BAR 1 explains why I get:
>>>
>>> p53 # echo 9 > resource1_resize
>>> -bash: echo: write error: No space left on device
>>>
>>> Shrinking it and increasing it to the orginal size works.
>>>
>>>
>>> Is there anything I can do with current kernel functionality to reserve
>>> memory address space for the full-fat BAR 1? Or relocate it?
>
> No, sorry. The BARs have to be released and re-assigned all at the 
> same time for this to work correctly.
>
> That's one of the reasons why we choose to do this in the driver 
> during the load process instead of the PCI subsystem.
>
> The sysfs functionality is more or less just for testing.
>
>>> If not, is this something which *can* be worked around in the 
>>> kernel? And if
>>> so, does it belong with the PCI subsystem? Or the devicedriver for the
>>> device in question?
>
> The device driver is the only place where you know all the hw specific 
> things necessary to release a device BAR and eventually move and 
> resize upstream bridges.

Noted.


>
>>>
>>> Is there a good ELI13 resource explaining how resizable BAR works in 
>>> Linux?
>>>
>>> My current kernel command-line contains: pci=assign-busses,realloc
>
> That's a really really bad idea. The "assign-busses" flag was 
> introduced to get 20year old laptops to see their cardbus PCI devices.

I threw a lot of mud at the wall to see what stuck. Removing it now did 
not make a big difference.

Removing realloc prevents the second TB3 GPU from being initialized, so 
keeping that for now.


>
>>> My GPU is attached via TB3 to a system for which resizable BAR is 
>>> and will
>>> remain a foreign concept in the BIOS.
>
> What happens if you hot remove and re-plug the TB3 after the system 
> has started?
>
Much the same as during initial boot. Both good and bad. See below.


Do any of the pci=hp* options have any significance/impact on what dmesg 
says below?

Is IO address space moveable? Relevant kernel config/options impacting 
this? Is it all in the hands of the device driver?

So, so many questions. And barely competent to ask them. Please forgive me.


Current kernel command-line snippet: 
pci=realloc,hpiosize=16K,hpmemsize=64M,pcie_scan_all,hpbussize=0x33


I very much appreciate your input. Will try to get the attention of the 
people responsible for the driver.


Thanks,


Dag B


p53 ~ # dmesg | grep 09:00.0
[    0.471780] pci 0000:09:00.0: [10de:2204] type 00 class 0x030000 PCIe 
Legacy Endpoint
[    0.471816] pci 0000:09:00.0: BAR 0 [mem 0x00000000-0x00ffffff]
[    0.471844] pci 0000:09:00.0: BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[    0.471873] pci 0000:09:00.0: BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[    0.471890] pci 0000:09:00.0: BAR 5 [io  0x0000-0x007f]
[    0.471907] pci 0000:09:00.0: ROM [mem 0x00000000-0x0007ffff pref]
[    0.472133] pci 0000:09:00.0: PME# supported from D0 D3hot
[    0.472382] pci 0000:09:00.0: 8.000 Gb/s available PCIe bandwidth, 
limited by 2.5 GT/s PCIe x4 link at 0000:05:01.0 (capable of 252.048 
Gb/s with 16.0 GT/s PCIe x16 link)
[    0.491866] pci 0000:09:00.0: vgaarb: bridge control possible
[    0.491866] pci 0000:09:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[    0.491866] pnp 00:03: disabling [io  0x002e-0x002f] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:03: disabling [io  0x004e-0x004f] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:03: disabling [io  0x0061] because it overlaps 
0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:03: disabling [io  0x0063] because it overlaps 
0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:03: disabling [io  0x0065] because it overlaps 
0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:03: disabling [io  0x0067] because it overlaps 
0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:03: disabling [io  0x0070] because it overlaps 
0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:08: disabling [io  0x0010-0x001f] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:08: disabling [io  0x0024-0x0025] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:08: disabling [io  0x0028-0x0029] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:08: disabling [io  0x002c-0x002d] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:08: disabling [io  0x0030-0x0031] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:08: disabling [io  0x0034-0x0035] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:08: disabling [io  0x0038-0x0039] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:08: disabling [io  0x003c-0x003d] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:08: disabling [io  0x0050-0x0053] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.491866] pnp 00:08: disabling [io  0x0072-0x0077] because it 
overlaps 0000:09:00.0 BAR 5 [io  0x0000-0x007f]
[    0.493216] pnp 00:0b: disabling [mem 0x00000000-0x0009ffff] because 
it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
[    0.493220] pnp 00:0b: disabling [mem 0x000c0000-0x000c3fff disabled] 
because it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
[    0.493225] pnp 00:0b: disabling [mem 0x000c8000-0x000cbfff disabled] 
because it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
[    0.493230] pnp 00:0b: disabling [mem 0x000d0000-0x000d3fff disabled] 
because it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
[    0.493234] pnp 00:0b: disabling [mem 0x000d8000-0x000dbfff disabled] 
because it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
[    0.493238] pnp 00:0b: disabling [mem 0x000e0000-0x000e3fff] because 
it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
[    0.493242] pnp 00:0b: disabling [mem 0x000e8000-0x000ebfff] because 
it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
[    0.493247] pnp 00:0b: disabling [mem 0x000f0000-0x000fffff] because 
it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
[    0.493251] pnp 00:0b: disabling [mem 0x00100000-0x8f7fffff] because 
it overlaps 0000:09:00.0 BAR 0 [mem 0x00000000-0x00ffffff]
[    0.493255] pnp 00:0b: disabling [mem 0x00000000-0x0009ffff disabled] 
because it overlaps 0000:09:00.0 BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[    0.493260] pnp 00:0b: disabling [mem 0x000c0000-0x000c3fff disabled] 
because it overlaps 0000:09:00.0 BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[    0.493265] pnp 00:0b: disabling [mem 0x000c8000-0x000cbfff disabled] 
because it overlaps 0000:09:00.0 BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[    0.493270] pnp 00:0b: disabling [mem 0x000d0000-0x000d3fff disabled] 
because it overlaps 0000:09:00.0 BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[    0.493274] pnp 00:0b: disabling [mem 0x000d8000-0x000dbfff disabled] 
because it overlaps 0000:09:00.0 BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[    0.493279] pnp 00:0b: disabling [mem 0x000e0000-0x000e3fff disabled] 
because it overlaps 0000:09:00.0 BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[    0.493283] pnp 00:0b: disabling [mem 0x000e8000-0x000ebfff disabled] 
because it overlaps 0000:09:00.0 BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[    0.493288] pnp 00:0b: disabling [mem 0x000f0000-0x000fffff disabled] 
because it overlaps 0000:09:00.0 BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[    0.493292] pnp 00:0b: disabling [mem 0x00100000-0x8f7fffff disabled] 
because it overlaps 0000:09:00.0 BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[    0.493297] pnp 00:0b: disabling [mem 0x00000000-0x0009ffff disabled] 
because it overlaps 0000:09:00.0 BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[    0.493302] pnp 00:0b: disabling [mem 0x000c0000-0x000c3fff disabled] 
because it overlaps 0000:09:00.0 BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[    0.493306] pnp 00:0b: disabling [mem 0x000c8000-0x000cbfff disabled] 
because it overlaps 0000:09:00.0 BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[    0.493311] pnp 00:0b: disabling [mem 0x000d0000-0x000d3fff disabled] 
because it overlaps 0000:09:00.0 BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[    0.493315] pnp 00:0b: disabling [mem 0x000d8000-0x000dbfff disabled] 
because it overlaps 0000:09:00.0 BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[    0.493320] pnp 00:0b: disabling [mem 0x000e0000-0x000e3fff disabled] 
because it overlaps 0000:09:00.0 BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[    0.493324] pnp 00:0b: disabling [mem 0x000e8000-0x000ebfff disabled] 
because it overlaps 0000:09:00.0 BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[    0.493329] pnp 00:0b: disabling [mem 0x000f0000-0x000fffff disabled] 
because it overlaps 0000:09:00.0 BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[    0.493333] pnp 00:0b: disabling [mem 0x00100000-0x8f7fffff disabled] 
because it overlaps 0000:09:00.0 BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[    0.503894] pci 0000:09:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 
64bit pref]: assigned
[    0.503940] pci 0000:09:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 
64bit pref]: assigned
[    0.503963] pci 0000:09:00.0: BAR 0 [mem 0xa4000000-0xa4ffffff]: assigned
[    0.503972] pci 0000:09:00.0: ROM [mem 0xa5000000-0xa507ffff pref]: 
assigned
[    0.503984] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[    0.503987] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to assign
[    0.504331] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[    0.504334] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to assign
[    0.504704] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[    0.504707] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to assign
[    0.505073] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[    0.505076] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to assign
[    0.505441] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[    0.505444] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to assign
[    0.505810] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[    0.505813] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to assign
[    0.507057] pci 0000:09:00.1: D0 power state depends on 0000:09:00.0
[    0.509437] pci 0000:09:00.0: Adding to iommu group 23
[    2.833427] nvidia 0000:09:00.0: enabling device (0000 -> 0002)
[    2.833519] nvidia 0000:09:00.0: vgaarb: VGA decodes changed: 
olddecodes=io+mem,decodes=none:owns=none
[    4.954613] [drm] Initialized nvidia-drm 0.0.0 20160202 for 
0000:09:00.0 on minor 2
[  228.414765] NVRM: GPU 0000:09:00.0: GPU has fallen off the bus.
[  228.445633] pci 0000:09:00.0: Unable to change power state from 
unknown to D0, device inaccessible
[  233.991103] pci 0000:09:00.0: [10de:2204] type 00 class 0x030000 PCIe 
Legacy Endpoint
[  233.993053] pci 0000:09:00.0: BAR 0 [mem 0x00000000-0x00ffffff]
[  233.994986] pci 0000:09:00.0: BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[  233.996854] pci 0000:09:00.0: BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[  233.998727] pci 0000:09:00.0: BAR 5 [io  0x0000-0x007f]
[  234.000585] pci 0000:09:00.0: ROM [mem 0x00000000-0x0007ffff pref]
[  234.002720] pci 0000:09:00.0: PME# supported from D0 D3hot
[  234.004889] pci 0000:09:00.0: 8.000 Gb/s available PCIe bandwidth, 
limited by 2.5 GT/s PCIe x4 link at 0000:05:01.0 (capable of 252.048 
Gb/s with 16.0 GT/s PCIe x16 link)
[  234.007000] pci 0000:09:00.0: Adding to iommu group 23
[  234.008925] pci 0000:09:00.0: vgaarb: bridge control possible
[  234.010828] pci 0000:09:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[  234.087850] pci 0000:09:00.0: BAR 1 [mem 0x6000000000-0x600fffffff 
64bit pref]: assigned
[  234.089631] pci 0000:09:00.0: BAR 3 [mem 0x6010000000-0x6011ffffff 
64bit pref]: assigned
[  234.091492] pci 0000:09:00.0: BAR 0 [mem 0xa4000000-0xa4ffffff]: assigned
[  234.093241] pci 0000:09:00.0: ROM [mem 0xa5000000-0xa507ffff pref]: 
assigned
[  234.096831] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[  234.098652] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to assign
[  234.155043] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[  234.156615] pci 0000:09:00.0: BAR 5 [io  size 0x0080]: failed to assign
[  234.183809] nvidia 0000:09:00.0: enabling device (0000 -> 0002)
[  234.185579] nvidia 0000:09:00.0: vgaarb: VGA decodes changed: 
olddecodes=io+mem,decodes=none:owns=none
[  234.310173] pci 0000:09:00.1: D0 power state depends on 0000:09:00.0



And doing the same for the 2nd GPU:

p53 ~ # dmesg | grep 2f:00.0
[    1.215862] pci 0000:2f:00.0: [10de:2204] type 00 class 0x030000 PCIe 
Legacy Endpoint
[    1.215893] pci 0000:2f:00.0: BAR 0 [mem 0x00000000-0x00ffffff]
[    1.215918] pci 0000:2f:00.0: BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[    1.215942] pci 0000:2f:00.0: BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[    1.215956] pci 0000:2f:00.0: BAR 5 [io  0x0000-0x007f]
[    1.215970] pci 0000:2f:00.0: ROM [mem 0x00000000-0x0007ffff pref]
[    1.216765] pci 0000:2f:00.0: PME# supported from D0 D3hot
[    1.217000] pci 0000:2f:00.0: 8.000 Gb/s available PCIe bandwidth, 
limited by 2.5 GT/s PCIe x4 link at 0000:05:04.0 (capable of 252.048 
Gb/s with 16.0 GT/s PCIe x16 link)
[    1.217226] pci 0000:2f:00.0: Adding to iommu group 29
[    1.217237] pci 0000:2f:00.0: vgaarb: bridge control possible
[    1.217238] pci 0000:2f:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[    1.218458] pci 0000:2f:00.0: BAR 1 [mem 0x6020000000-0x602fffffff 
64bit pref]: assigned
[    1.218481] pci 0000:2f:00.0: BAR 3 [mem 0x6030000000-0x6031ffffff 
64bit pref]: assigned
[    1.218501] pci 0000:2f:00.0: BAR 0 [mem 0xb1000000-0xb1ffffff]: assigned
[    1.218507] pci 0000:2f:00.0: ROM [mem 0xb0800000-0xb087ffff pref]: 
assigned
[    1.218514] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[    1.218514] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: failed to assign
[    1.218579] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[    1.218580] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: failed to assign
[    1.219748] pci 0000:2f:00.1: D0 power state depends on 0000:2f:00.0
[    2.883186] nvidia 0000:2f:00.0: enabling device (0000 -> 0002)
[    2.883945] nvidia 0000:2f:00.0: vgaarb: VGA decodes changed: 
olddecodes=io+mem,decodes=none:owns=none
[    6.367931] [drm] Initialized nvidia-drm 0.0.0 20160202 for 
0000:2f:00.0 on minor 3
[  485.913085] NVRM: GPU 0000:2f:00.0: GPU has fallen off the bus.
[  485.913727] NVRM: GPU 0000:2f:00.0: GPU serial number is PKWUQ0B9VFK0SG.
[  485.938963] pci 0000:2f:00.0: Unable to change power state from 
unknown to D0, device inaccessible
[  489.941767] pci 0000:2f:00.0: [10de:2204] type 00 class 0x030000 PCIe 
Legacy Endpoint
[  489.944551] pci 0000:2f:00.0: BAR 0 [mem 0x00000000-0x00ffffff]
[  489.947287] pci 0000:2f:00.0: BAR 1 [mem 0x00000000-0x0fffffff 64bit 
pref]
[  489.950056] pci 0000:2f:00.0: BAR 3 [mem 0x00000000-0x01ffffff 64bit 
pref]
[  489.952835] pci 0000:2f:00.0: BAR 5 [io  0x0000-0x007f]
[  489.955655] pci 0000:2f:00.0: ROM [mem 0x00000000-0x0007ffff pref]
[  489.958721] pci 0000:2f:00.0: PME# supported from D0 D3hot
[  489.961746] pci 0000:2f:00.0: 8.000 Gb/s available PCIe bandwidth, 
limited by 2.5 GT/s PCIe x4 link at 0000:05:04.0 (capable of 252.048 
Gb/s with 16.0 GT/s PCIe x16 link)
[  489.964859] pci 0000:2f:00.0: Adding to iommu group 29
[  489.967703] pci 0000:2f:00.0: vgaarb: bridge control possible
[  489.970506] pci 0000:2f:00.0: vgaarb: VGA device added: 
decodes=io+mem,owns=none,locks=none
[  490.025678] pci 0000:2f:00.0: BAR 1 [mem 0x6020000000-0x602fffffff 
64bit pref]: assigned
[  490.027887] pci 0000:2f:00.0: BAR 3 [mem 0x6030000000-0x6031ffffff 
64bit pref]: assigned
[  490.029918] pci 0000:2f:00.0: BAR 0 [mem 0xb1000000-0xb1ffffff]: assigned
[  490.031940] pci 0000:2f:00.0: ROM [mem 0xb0800000-0xb087ffff pref]: 
assigned
[  490.036008] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[  490.038096] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: failed to assign
[  490.075208] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: can't assign; 
no space
[  490.077005] pci 0000:2f:00.0: BAR 5 [io  size 0x0080]: failed to assign
[  490.099288] nvidia 0000:2f:00.0: enabling device (0000 -> 0002)
[  490.101217] nvidia 0000:2f:00.0: vgaarb: VGA decodes changed: 
olddecodes=io+mem,decodes=none:owns=none
[  490.265952] pci 0000:2f:00.1: D0 power state depends on 0000:2f:00.0


BAR 5 is missing in the lspci output. Same for both.

lspci specifies 'Physical Resizable'. Is that implied for all BARs?

     Capabilities: [bb0 v1] Physical Resizable BAR
         BAR 0: current size: 16MB, supported: 16MB
         BAR 1: current size: 256MB, supported: 64MB 128MB 256MB 512MB 
1GB 2GB 4GB 8GB 16GB 32GB
         BAR 3: current size: 32MB, supported: 32MB



