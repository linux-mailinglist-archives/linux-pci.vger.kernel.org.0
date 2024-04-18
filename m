Return-Path: <linux-pci+bounces-6464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB38AA58C
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 00:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9268B1C20FD0
	for <lists+linux-pci@lfdr.de>; Thu, 18 Apr 2024 22:55:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC7839855;
	Thu, 18 Apr 2024 22:55:13 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D5636AFB
	for <linux-pci@vger.kernel.org>; Thu, 18 Apr 2024 22:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713480913; cv=none; b=QfjZYk38F44j5CvvkgVXimk0zdPfHTuRtLYsarDkLa8kpSrI+D0roAPvHedgkbG8a9gp93kBdKkzWl6LsL7FXCZLPkwV8ie1vt/shP28oxiHpfZkhfKZfbSz+/+V4WoMuPDfSaVIr+f3X8i2G3eV1kOfMOwtAOhXjI84XW0Vxf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713480913; c=relaxed/simple;
	bh=FPyQi8xtGim3ALBlbQFm3PzffOGoDpOYcz/Oa9P27KM=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=YNW6ujq1TcIaRI9Ux1I7DBbn0sCGI3pXo0pUcJPVZerqWl+dtfS3fbk867xJQIjmWvs5OMQ8sivxIgn1L/j9ENbiYPcatynCa6Tidg4KiNUKKDIR06POT3kbLp1kYIq+NeMDskF/PF8/3K8v5ovNLwT9zW5mNca0TGRCRyX0bF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com; spf=pass smtp.mailfrom=bakke.com; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bakke.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bakke.com
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 4CA01120191;
	Thu, 18 Apr 2024 22:55:04 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: dag@bakke.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 88A8E60009;
	Thu, 18 Apr 2024 22:55:01 +0000 (UTC)
Message-ID: <8b6832cc-059a-4a9b-bc0c-af641ca3d487@bakke.com>
Date: Fri, 19 Apr 2024 00:54:59 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: PCIE BAR resizing blocked by another BAR on same device?
From: Dag B <dag@bakke.com>
To: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <helgaas@kernel.org>
Cc: linux-pci@vger.kernel.org
References: <20240417151313.GA202307@bhelgaas>
 <d509c9e6-37be-44ab-8f47-6fe55397794e@amd.com>
 <fa9245d6-ffb7-4bac-8740-219af7fcd02a@bakke.com>
 <fbc9f2c1-2e5a-4611-801e-f055e6042897@amd.com>
 <ee971d86-5fe4-4e0e-9eb2-21272e793974@bakke.com>
Content-Language: en-US
In-Reply-To: <ee971d86-5fe4-4e0e-9eb2-21272e793974@bakke.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout06
X-Rspamd-Queue-Id: 88A8E60009
X-Stat-Signature: 7ub63owsgwarhqdh4rp4gyedzfnwuch4
X-Session-Marker: 6461674062616B6B652E636F6D
X-Session-ID: U2FsdGVkX19LIiVP+FA9FUV+3NVlKTuUUqc3ZzHF+Pc=
X-HE-Tag: 1713480901-187019
X-HE-Meta: U2FsdGVkX18Y9ENhSIqekPSBTSlEGeCyGIqBruwQFvLFUv/UsACOYJvo8BLMaXEX6gW2n1WeZ/izVA+AtNceWUA1U/+rXbF6hbjjPqOUV5tpmCXCrHJYv8ppb2cc7T5X8JLwnbnYharfUp4amartlOobMafSLNQK0rZpLorBPgYHyhZkUmt+GZ/yRrhfHguhsSABpE1E6Z0Q68ZLLZZjNgQU/Uti+o7AxOQnrRuY302Pk5sqHXOchz3tMWRHcJapIK16blWoDgClu9mWkC3h5fGaDf3P0BWYcjeM7nkmy5Sc1pkn6lwdu12FryY7NqU06hrIYeqlrUi7aICKEHp3756J8RwZ1cTaN8FoFFe2K7zyzEgmSvkVQQ==


On 18.04.2024 15:13, Dag B wrote:
>
> On 18.04.2024 14:24, Christian König wrote:
>> Am 18.04.24 um 12:42 schrieb Dag B:
>>>
>>> [SNIP]
>>>>
>>>>>>
>>>>>> Is there a good ELI13 resource explaining how resizable BAR works 
>>>>>> in Linux?
>>>>>>
>>>>>> My current kernel command-line contains: pci=assign-busses,realloc
>>>>
>>>> That's a really really bad idea. The "assign-busses" flag was 
>>>> introduced to get 20year old laptops to see their cardbus PCI devices.
>>>
>>> I threw a lot of mud at the wall to see what stuck. Removing it now 
>>> did not make a big difference.
>>>
>>> Removing realloc prevents the second TB3 GPU from being initialized, 
>>> so keeping that for now.
>>
>> That's really interesting. Why does it fail without that?
>>
>> It basically means that your BIOS is somehow broken and only the 
>> Linux PCI subsystem is able to assign resources correctly.
>>
>> Please provide the output of "sudo lspci -v" and "sudo lspci -tv" as 
>> file attachment (*not* inline in a mail!).
>
>
> In case I have expressed myself awkwardly, the realloc=off case 
> appears to make the device driver have issues with the second GPU.
>
>
> I have attached both outputs, for realloc=off.
>
> Not knowing what is considered acceptable message sizes on this m/l, I 
> uploaded the same for realloc=on, as well as output from dmesg for 
> both cases to:
>
> https://github.com/dagbdagb/p53
>
> If the m/l has mechanisms to archive attachments and replace them with 
> links, I'll redo the exercise in a follow-up email. I understand the 
> value of having the 'context' of the discussion readily available in 
> one place.
>
>
> Dag B


I now have one GPU enabled with the full-fat BAR. The other has issues 
assigning address space for the BARs with this config, and cannot be 
initialized.

pci=realloc=on,hpiosize=64K,hpmemsize=64M,hpmmioprefsize=64G,pcie_scan_all,hpbussize=0x33 


..results in:

     Capabilities: [bb0 v1] Physical Resizable BAR
         BAR 0: current size: 16MB, supported: 16MB
         BAR 1: current size: 32GB, supported: 64MB 128MB 256MB 512MB 
1GB 2GB 4GB 8GB 16GB 32GB
         BAR 3: current size: 32MB, supported: 32MB

Still mostly throwing mud at the wall, but the hp* options do appear to 
make a difference. Would love to understand these options better.,

Dag B




