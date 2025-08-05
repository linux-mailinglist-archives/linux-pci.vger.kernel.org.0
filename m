Return-Path: <linux-pci+bounces-33447-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2B1B1BBD3
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 23:39:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78965623D3F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Aug 2025 21:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A85E12264B8;
	Tue,  5 Aug 2025 21:39:41 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C3C257AC1
	for <linux-pci@vger.kernel.org>; Tue,  5 Aug 2025 21:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754429981; cv=none; b=Sdovw2FIqfla9hWD2GBQNbAWGww5/G7RwR1TUL/sq3yloQJ8hikzfa6rLRh+Yle+DFSQl60qZJDCoDqMfinwixaDKqgqYiWXv75nT8p72xO888JrQQ3/Cdu70ZFrf9UfpTBJbqeHZEhATrRVLQFbMtyVuwKq4XPgC42M9Glh72s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754429981; c=relaxed/simple;
	bh=rPR1PVkfDne0GGPMuqPGamL6tAItLkLDblGLytMUTx0=;
	h=Message-ID:Date:MIME-Version:Subject:Cc:References:From:To:
	 In-Reply-To:Content-Type; b=l7i9pWQNVwriNNCsHPeDyHXzPr2reAHwGeNAU3hOFvvtf6S6kzJ2wZzNh9SyPBVCi2nu2g3MhnVLDREAHp+s1vDmYEf9sXTQeWDv4Kzj9obue7CiEb6nPJFFDug7r9C6tmwnVo/qxyPZ06NojVU6QVcDSg8unpzsndG3sQqq97g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.192] (ip5f5af7fe.dynamic.kabel-deutschland.de [95.90.247.254])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 324FD61E64852;
	Tue, 05 Aug 2025 23:39:07 +0200 (CEST)
Message-ID: <5dfadd2d-fec7-4353-bf80-c8397d798324@molgen.mpg.de>
Date: Tue, 5 Aug 2025 23:39:06 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux warns `Unknown NUMA node; performance will be reduced`
Cc: Bjorn Helgaas <helgaas@kernel.org>, Yunsheng Lin
 <linyunsheng@huawei.com>, Bjorn Helgaas <bhelgaas@google.com>,
 linux-pci@vger.kernel.org
References: <20240611223125.GA1004778@bhelgaas>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
To: fwts-devel@lists.ubuntu.com
In-Reply-To: <20240611223125.GA1004778@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear fwts folks,


I am looping you in to a discussion from last year. The thread is at

https://lore.kernel.org/r/a154f694-c48b-4b3b-809f-4b74ec86a924@molgen.mpg.de

Am 12.06.24 um 00:31 schrieb Bjorn Helgaas:
> On Tue, Jun 11, 2024 at 11:05:31AM +0800, Yunsheng Lin wrote:
>> On 2024/6/11 4:27, Paul Menzel wrote:
>>> Am 10.06.24 um 21:42 schrieb Bjorn Helgaas:
>>>> [+cc Yunsheng, thread at
>>>> https://lore.kernel.org/r/a154f694-c48b-4b3b-809f-4b74ec86a924@molgen.mpg.de]
>>>> On Sun, Jun 09, 2024 at 10:31:05AM +0200, Paul Menzel wrote:
>>>>> On the servers below Linux warns:
>>>>>
>>>>>        Unknown NUMA node; performance will be reduced
>>>>
>>>> This warning was added by ad5086108b9f ("PCI: Warn if no host bridge
>>>> NUMA node info"), which appeared in v5.5, so I assume this isn't new.
>>>>
>>>> That commit log says:
>>>>
>>>>     In pci_call_probe(), we try to run driver probe functions on the node where
>>>>     the device is attached.  If we don't know which node the device is attached
>>>>     to, the driver will likely run on the wrong node.  This will still work,
>>>>     but performance will not be as good as it could be.
>>>>
>>>>     On NUMA systems, warn if we don't know which node a PCI host bridge is
>>>>     attached to.  This is likely an indication that ACPI didn't supply a _PXM
>>>>     method or the DT didn't supply a "numa-node-id" property.
>>>>
>>>> I assume these are all ACPI systems, so likely missing _PXM.
>>>> An acpidump could confirm this.
>>> 
>>> I created an issue in the Linux Kernel Bugzilla [1] and attached
>>> the output of `acpidump` on a Dell PowerEdge T630 there. The
>>> DSDT contains:
>>>
>>>          Device (PCI1)
>>>          {
>>>          […]
>>>              Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
>>>              {
>>>                  If ((CLOD == 0x00))
>>>                  {
>>>                      Return (0x01)
>>>                  }
>>>                  Else
>>>                  {
>>>                      Return (0x02)
>>>                  }
>>>              }
>>>          […]
>>>          }
>>>
>>>> I think the devices on buses 7f and ff are Intel chipset devices, and
>>>> I doubt we have drivers for any of them.  They have vendor/device IDs
>>>> of 8086:6fXX, and I didn't see any reference to them:
>>>>
>>>>     $ git grep -i \<0x6f..\>
>>>>     $
>>>
>>> Interesting. Any ideas, what these chipset devices do?
>>>
>>>> If we *did* have drivers, they would certainly benefit from having
>>>> _PXM, but since there are no probe methods, I don't think it matters
>>>> that we don't know where they should run.
>>>>
>>>> Maybe the message should be downgraded from "dev_warn" to "dev_info"
>>>> since there's no functional problem, and the user can't really do
>>>> anything about it.
>>>>
>>>> We could also consider moving it to the actual probe path, so we don't
>>>> emit a message unless there is an affected driver.
>>
>> The problem seems to be how we decide if there is an affected driver?
>> do we care about the out-of-tree driver? doesn't the out-of-tree driver
>> suffer from the similar problem if BIOS is not providing the correct
>> numa info?
> 
> I don't care about out-of-tree drivers at all.  This message is only a
> hint about maybe not getting the absolute best possible performance
> anyway.
> 
>> The 'Unknown NUMA node; performance will be reduced' warning seems to
>> be added to give the vendor some pressure to fix the BIOS as fast as
>> possible, downgrading from "dev_warn" to "dev_info" or moving it to
>> the actual probe path does not seems to fix the problem, just alliviate
>> the pressure for vendor to fix the BIOS?
> 
> True, BIOS vendors *might* care about fixing a warning, and likely
> wouldn't even notice a dev_info.
> 
> It's possible somebody could add a test case to the firmware test
> suite (https://github.com/fwts/fwts.git).  Not sure if vendors care
> about that either.

Would it be possible that fwts checks for this in the ACPI tables. I 
think fwts already highlights everything more severe than or equal to 
warnings, doesn’t it. Maybe some explanation could be added? Especially, 
as it’s not clear, that it’s most likely a firmware issue.

> I suspect Linux users might care about the dev_warn because I suspect
> it breaks the pretty graphical boot sequence.
> 
> As far as the Linux kernel, I think making it dev_info is enough.

Kind regards,

Paul

