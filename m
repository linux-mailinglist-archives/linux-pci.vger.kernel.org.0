Return-Path: <linux-pci+bounces-6744-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93D78B484F
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 23:18:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7475B281F47
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 21:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F2023A1D3;
	Sat, 27 Apr 2024 21:18:51 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2B01442F1
	for <linux-pci@vger.kernel.org>; Sat, 27 Apr 2024 21:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714252731; cv=none; b=IR8d3CCRYd3V0YSNd9w9AE94zybk1nHVTnVAJF6KEzJU+coSbCBJ3Ep4YceDpjcrK2wjZHzUMcpj3AVipFJC268W3rwdVaRMeANB0XByVaVzWX8ltkOxvMzCWaw+7ZbMj1LgComvTOrvSOqYMVU/otrVnHDEzuxCAFv320yMMeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714252731; c=relaxed/simple;
	bh=+qxDHwr+yDroKVYnh17Y803ltpwWe1pMN3HB2sg3AH8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=GZTPnckrqlzWvl4QtMLkEnSi0BIKq7EhPtcgsA8GgwXl5aC6CKpVd/M3RvV5U0gCeVVWeQDcEZehq9CrbHzc1BQgluBqPXs7EKMIaAjvLCAGuCiXY3nDGh00QUn7GGAGWKD/b+39ggYU2egs+pec9asruxjlT6U8oWM8E18wzX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com; spf=pass smtp.mailfrom=bakke.com; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bakke.com
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 91436C0A14;
	Sat, 27 Apr 2024 20:42:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: dag@bakke.com) by omf10.hostedemail.com (Postfix) with ESMTPA id 4E99532;
	Sat, 27 Apr 2024 20:41:59 +0000 (UTC)
Message-ID: <91ddf3e3-6203-4851-8007-9e9a24841e61@bakke.com>
Date: Sat, 27 Apr 2024 20:42:04 +0000
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Dag B <dag@bakke.com>
Subject: Re: PCIE BAR resizing blocked by another BAR on same device?
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <helgaas@kernel.org>, linux-pci@vger.kernel.org
References: <20240417151313.GA202307@bhelgaas>
 <d509c9e6-37be-44ab-8f47-6fe55397794e@amd.com>
 <fa9245d6-ffb7-4bac-8740-219af7fcd02a@bakke.com>
 <fbc9f2c1-2e5a-4611-801e-f055e6042897@amd.com>
 <ee971d86-5fe4-4e0e-9eb2-21272e793974@bakke.com>
 <815337f1-920f-b2ad-7f28-b1b366eb23f5@linux.intel.com>
 <71456a7b-8dbd-4108-ad15-ddd7c0811b0d@amd.com>
Content-Language: en-US
In-Reply-To: <71456a7b-8dbd-4108-ad15-ddd7c0811b0d@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4E99532
X-Rspamd-Server: rspamout08
X-Stat-Signature: j3zdu44kdqtinihzkmsjnd6hb44a7ybx
X-Session-Marker: 6461674062616B6B652E636F6D
X-Session-ID: U2FsdGVkX1/iJCEATg+6afDyJp193k+SnBe7klD3Ypc=
X-HE-Tag: 1714250519-497913
X-HE-Meta: U2FsdGVkX18/7fsIq9ftCr655XvRLpmMsa9obE144FbkxtfKRzC5v21YDVXgpYgJw38qFH7vEl5eb/wcBN1h02davFL7mauvl4BfJjMaraabr3ONh+wB2foTT9yfbipI4L2rW32mQ1VguiZCxlaCda/h8YdCFomFN0/XGDZZjYOYdD+5itg42B9m0gUgFewnOceAp0q7ZSklrJP3ZcCkfLIiwMZ14cCHr4DH2VXPskkVR1/XM4OMa9XW7+h+TIItPkI8vOuDKEF1Ns/+KduD52gIjxPMC4K/nf+Pd7gkvtDh7emRFeamcJghYGCTyJJHypiKcisa7ThVS9/KF6yXI6oss5IZvwtdh3PfG/9YCffQMc6iRXstzQ==

I have partial success!  And bits and pieces of an explanation for the 
lack of complete success.

I have a short question or two towards the end, for which the rest here 
is just setup.


On 19.04.2024 17:31, Christian König wrote:
> Am 19.04.24 um 17:19 schrieb Ilpo Järvinen:
>> On Thu, 18 Apr 2024, Dag B wrote:
>>> On 18.04.2024 14:24, Christian König wrote:
>>>> Am 18.04.24 um 12:42 schrieb Dag B:
>>>>> [SNIP]
>>>> Please provide the output of "sudo lspci -v" and "sudo lspci -tv" 
>>>> as file
>>>> attachment (*not* inline in a mail!).
>>>
>>>
>>> https://github.com/dagbdagb/p53
>>>
>>> If the m/l has mechanisms to archive attachments and replace them 
>>> with links,
>>> I'll redo the exercise in a follow-up email. I understand the value 
>>> of having
>>> the 'context' of the discussion readily available in one place.
>> The mem BAR & bridge window configuration is identical between
>> realloc=on/off.
>>
>> The error seems to relate to io BAR:
>>
>> [    2.782439] nvidia 0000:09:00.0: BAR 5 [io  0x0000-0x007f]: not 
>> claimed; can't enable device
>> [    2.783139] NVRM: pci_enable_device failed, aborting
>>
>> With realloc=on, the entire IO window is disabled for the bridges and 
>> for
>> some reason nvidia doesn't abort in that case.
>
> That actually makes a lot of sense.
>
> At least on AMD hardware the IO window is only used for VGA emulation 
> and I strongly suspect it's the same on the NVIDIA GPUs.
>
> So what basically happens is that the BIOS for some reason enables the 
> IO range on both GPUs while when Linux makes the re-alloc it disables 
> the ranges. Most likely because the Linux PCI code knows that they 
> should only be used if this device is the primary VGA device used 
> during boot.
>
> Now when pci_enable_device() is called the function checks if all 
> enabled BARs actually have resources and without realloc=on the I/O 
> BAR has nothing allocated and the function fails. While with 
> realloc=on the BAR is disabled.
>
Thank you for the explanation.


> Well, what a mess. @Dag I would just strongly suggest to see if you 
> can update the BIOS. What happens here is clearly incorrect.

Unlikely to be an option, I am afraid. Hardware too old.  :-/


> Regarding the resizing as far as I can see the BIOS allocates only a 
> single 1GiB window to the upstream bridge, that is most likely way to 
> small for anything than the default 256MiB BAR.
>
> Maybe try to force assign more address space to this bridge. IIRC one 
> of the kernel parameters could be used for that, but of hand I don't 
> remember the syntax.


Found and enabled said option. It works :-)   To reiterate:

- laptop with two TB3 ports.

- to each port, a TB3 eGPU dock with an Nvidia GPU. Currently, I get:

     Capabilities: [bb0 v1] Physical Resizable BAR
         BAR 0: current size: 16MB, supported: 16MB
         BAR 1: current size: 256MB, supported: 64MB 128MB 256MB 512MB 
1GB 2GB 4GB 8GB 16GB 32GB
         BAR 3: current size: 32MB, supported: 32MB

     Capabilities: [bb0 v1] Physical Resizable BAR
         BAR 0: current size: 16MB, supported: 16MB
         BAR 1: current size: 32GB, supported: 64MB 128MB 256MB 512MB 
1GB 2GB 4GB 8GB 16GB 32GB
         BAR 3: current size: 32MB, supported: 32MB

- Kernel command-line currently contains: 
pci=realloc=on,hpiosize=1024,hpmmioprefsize=64G      (more than 64G does 
not work)

In short, both eGPUs work. But only one has a big BAR.  Seeing how the 
GPUs are hanging off TB3, system bandwidth to these GPUs will be limited 
in any case. A big BAR is not going to change that at all. But at this 
point I'd like to understand what linux can and cannot do w.r.t. 
resource allocations.


TB3 ports in lspci:

04:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge 
[Titan Ridge 4C 2018] (rev 06)
05:00.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge 
[Titan Ridge 4C 2018] (rev 06)
05:01.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge 
[Titan Ridge 4C 2018] (rev 06)
05:02.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge 
[Titan Ridge 4C 2018] (rev 06)
05:04.0 PCI bridge: Intel Corporation JHL7540 Thunderbolt 3 Bridge 
[Titan Ridge 4C 2018] (rev 06)


TB3 eGPU docks, as seen from boltctl:

  ● Razer Core X Chroma
    ├─ type:          peripheral
    ├─ name:          Core X Chroma
  ● Razer Core X Chroma #2
    ├─ type:          peripheral
    ├─ name:          Core X Chroma
  ● Razer Core X
    ├─ type:          peripheral
    ├─ name:          Core X

Yes, the first dock appears as two devices. It is part of the problem, 
it appears. lspci illustrates this as follows:

06:00.0 System peripheral: Intel Corporation JHL7540 Thunderbolt 3 NHI 
[Titan Ridge 4C 2018] (rev 06)
07:00.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016] (rev 02)
08:01.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016] (rev 02)
08:04.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016] (rev 02)
09:00.0 VGA compatible controller: NVIDIA Corporation GA102 [GeForce RTX 
3090] (rev a1)
0a:00.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016] (rev 02)
0b:00.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016] (rev 02)
0b:01.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016] (rev 02)
0b:02.0 PCI bridge: Intel Corporation JHL6540 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 4C 2016] (rev 02)
0c:00.0 USB controller: ASMedia Technology Inc. ASM1142 USB 3.1 Host 
Controller
0d:00.0 USB controller: ASMedia Technology Inc. ASM1142 USB 3.1 Host 
Controller
0e:00.0 USB controller: ASMedia Technology Inc. ASM1142 USB 3.1 Host 
Controller
2c:00.0 USB controller: Intel Corporation JHL7540 Thunderbolt 3 USB 
Controller [Titan Ridge 4C 2018] (rev 06)
2d:00.0 PCI bridge: Intel Corporation JHL6340 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 2C 2016] (rev 02)
2e:01.0 PCI bridge: Intel Corporation JHL6340 Thunderbolt 3 Bridge (C 
step) [Alpine Ridge 2C 2016] (rev 02)
2f:00.0 VGA compatible controller: NVIDIA Corporation GA102 [GeForce RTX 
3090] (rev a1)

or as a tree:

00:1c.0 root_port, slot 0, device present, speed 8GT/s, width x4
  └─04:00.0 upstream_port, Intel Corporation (8086) JHL7540 Thunderbolt 
3 Bridge [Titan Ridge 4C 2018] (15ea)
     ├─05:00.0 downstream_port, slot 0, device present, speed 2.5GT/s, 
width x4
     │  └─06:00.0 endpoint, Intel Corporation (8086) JHL7540 Thunderbolt 
3 NHI [Titan Ridge 4C 2018] (15eb)
     ├─05:01.0 downstream_port, slot 1, device present, speed 2.5GT/s, 
width x4
     │  └─07:00.0 upstream_port, Intel Corporation (8086) JHL6540 
Thunderbolt 3 Bridge (C step) [Alpine Ridge 4C 2016] (15d3)
     │     ├─08:01.0 downstream_port, slot 0, device present, speed 
2.5GT/s, width x4
     │     │  └─09:00.0 legacy_endpoint
     │     └─08:04.0 downstream_port, slot 4, device present, speed 
2.5GT/s, width x4
     │        └─0a:00.0 upstream_port, Intel Corporation (8086) JHL6540 
Thunderbolt 3 Bridge (C step) [Alpine Ridge 4C 2016] (15d3)
     │           ├─0b:00.0 downstream_port, slot 0, device present, 
speed 8GT/s, width x1
     │           │  └─0c:00.0 endpoint, ASMedia Technology Inc. (1b21) 
ASM1142 USB 3.1 Host Controller (1242)
     │           ├─0b:01.0 downstream_port, slot 0, device present, 
speed 8GT/s, width x1
     │           │  └─0d:00.0 endpoint, ASMedia Technology Inc. (1b21) 
ASM1142 USB 3.1 Host Controller (1242)
     │           └─0b:02.0 downstream_port, slot 0, device present, 
speed 8GT/s, width x1
     │              └─0e:00.0 endpoint, ASMedia Technology Inc. (1b21) 
ASM1142 USB 3.1 Host Controller (1242)
     ├─05:02.0 downstream_port, slot 0, device present, speed 2.5GT/s, 
width x4
     │  └─2c:00.0 endpoint, Intel Corporation (8086) JHL7540 Thunderbolt 
3 USB Controller [Titan Ridge 4C 2018] (15ec)
     └─05:04.0 downstream_port, slot 4, device present, speed 2.5GT/s, 
width x4
        └─2d:00.0 upstream_port, Intel Corporation (8086) JHL6340 
Thunderbolt 3 Bridge (C step) [Alpine Ridge 2C 2016] (15da)
           └─2e:01.0 downstream_port, slot 0, device present, speed 
2.5GT/s, width x4
              └─2f:00.0 legacy_endpoint


/proc/iomem looks like this:

4000000000-7fffffffff : PCI Bus 0000:00
   4000000000-400fffffff : 0000:00:02.0
   4010000000-6027ffffff : PCI Bus 0000:04
     4010000000-6027ffffff : PCI Bus 0000:05
       4010000000-5027ffffff : PCI Bus 0000:07
         4010000000-5027ffffff : PCI Bus 0000:08
           4010000000-4027ffffff : PCI Bus 0000:09
           4010000000-401fffffff : 0000:09:00.0
           4020000000-4021ffffff : 0000:09:00.0
           4028000000-5027ffffff : PCI Bus 0000:0a
           4028000000-5027ffffff : PCI Bus 0000:0b
           4028000000-457d4fffff : PCI Bus 0000:0c
           457d500000-4ad29fffff : PCI Bus 0000:0d
           4ad2a00000-5027efffff : PCI Bus 0000:0e
       5400000000-5fffffffff : PCI Bus 0000:2d
         5400000000-5fffffffff : PCI Bus 0000:2e
           5400000000-5fffffffff : PCI Bus 0000:2f
           5400000000-5401ffffff : 0000:2f:00.0
           5800000000-5fffffffff : 0000:2f:00.0

I read this as the stuff downstream of the laptop TB3 controller has the 
range 4010000000-6027ffffff.

The GPU assigned bus id 2f gets all of 5400000000-5fffffffff

The GPU assigned bus id 09  (hanging off 08.01) has to share 
4010000000-5027ffffff with stuff hanging off 08:04 (0a-0e).

0c, 0d and 0e are some USB ports and a (USB-attached) ethernet 
interface, on a separate card in (only) one of the TB3 docks. I can 
physically pull the card with the ports from the dock, but /proc/iomem 
will list the address allocation for 0c-0e *even if they now are missing 
from the lspci output*.


Unbinding 08.4 (and everything below it) and rebinding it to the 
pci-stub driver does not change how /proc/iomem looks either. Nor with a 
pci rescan.


So, the question(s):

Does linux, in this case, have a mechanism for shutting down 08:04 (and 
everything downstream) *and* freeing the reserved resources, such that 
09:00 gets to pick whatever it wants from 4010000000-5027ffffff ?

Or to pre-allocate resources for a particular pci id (08:01), such that 
08:04 simply fails? Which does not require writing actual C-code?

Getting a 'simpler' dock may be the easier way out. I may have crossed 
the line for simple solutions some time ago.    :-)


Thanks,

Dag B



