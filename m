Return-Path: <linux-pci+bounces-8567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0E14902EE4
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 05:05:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 682202867B9
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 03:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A077E782;
	Tue, 11 Jun 2024 03:05:44 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B6941A84
	for <linux-pci@vger.kernel.org>; Tue, 11 Jun 2024 03:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718075144; cv=none; b=frlJeMrvKUhsLOpuNOAWFcWeMXkHFzagiAnGLzyeRikyQMi7KFzGGmshwzC7z+/POdxaj2pcAbLTkz7edx24D+f6iA39CorICRw6rKUD90gMtAkhJCwSOKF/z8/RirXJZV6Ee3lsy0UBBJdi0POPClH6T4hVRlsiGYtuy6E6lZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718075144; c=relaxed/simple;
	bh=95hJrx3dajoFavyeCRBlJFU6iB1CmHmeseoxgTArd2k=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YbreVdppeFpouIvJ9WxXkPWt0FXNzC4awu5aeqxNpnDtYI6EYhbdouuPCwn8M4a4UR16nayoHulYDkyMIn14hElAcRjlrZIKFRsiWR1B+V/Lc19GoeGq//jiwI8xVkHIWW1VsIyHMUKdo85lN9dkRLwvCJE4WPK+7Q9ZrRF1bcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Vytkb6hngz1yt8w;
	Tue, 11 Jun 2024 11:02:15 +0800 (CST)
Received: from dggpemf200006.china.huawei.com (unknown [7.185.36.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 2400614022E;
	Tue, 11 Jun 2024 11:05:39 +0800 (CST)
Received: from [10.69.30.204] (10.69.30.204) by dggpemf200006.china.huawei.com
 (7.185.36.61) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 11 Jun
 2024 11:05:38 +0800
Subject: Re: Linux warns `Unknown NUMA node; performance will be reduced`
To: Paul Menzel <pmenzel@molgen.mpg.de>, Bjorn Helgaas <helgaas@kernel.org>
CC: Bjorn Helgaas <bhelgaas@google.com>, <linux-pci@vger.kernel.org>
References: <20240610194236.GA954050@bhelgaas>
 <4dcdc648-e09d-4f43-a53c-bcb4f54ef476@molgen.mpg.de>
From: Yunsheng Lin <linyunsheng@huawei.com>
Message-ID: <70cf7d8f-63f1-d54a-63f3-7564cdf46ede@huawei.com>
Date: Tue, 11 Jun 2024 11:05:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <4dcdc648-e09d-4f43-a53c-bcb4f54ef476@molgen.mpg.de>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpemf200006.china.huawei.com (7.185.36.61)

On 2024/6/11 4:27, Paul Menzel wrote:
> Dear Bjorn,
> 
> 
> Am 10.06.24 um 21:42 schrieb Bjorn Helgaas:
>> [+cc Yunsheng, thread at
>> https://lore.kernel.org/r/a154f694-c48b-4b3b-809f-4b74ec86a924@molgen.mpg.de]

Thanks for cc'ing.

>>
>> Thanks very much for this report!
> 
> Thank you for the quick reply.
> 
>> On Sun, Jun 09, 2024 at 10:31:05AM +0200, Paul Menzel wrote:
>>> On the servers below Linux warns:
>>>
>>>       Unknown NUMA node; performance will be reduced
>>
>> This warning was added by ad5086108b9f ("PCI: Warn if no host bridge
>> NUMA node info"), which appeared in v5.5, so I assume this isn't new.
>>
>> That commit log says:
>>
>>    In pci_call_probe(), we try to run driver probe functions on the node where
>>    the device is attached.  If we don't know which node the device is attached
>>    to, the driver will likely run on the wrong node.  This will still work,
>>    but performance will not be as good as it could be.
>>
>>    On NUMA systems, warn if we don't know which node a PCI host bridge is
>>    attached to.  This is likely an indication that ACPI didn't supply a _PXM
>>    method or the DT didn't supply a "numa-node-id" property.
>>
>> I assume these are all ACPI systems, so likely missing _PXM.  An
>> acpidump could confirm this.
> 
> I created an issue in the Linux Kernel Bugzilla [1] and attached the output of `acpidump` on a Dell PowerEdge T630 there. The DSDT contains:
> 
>         Device (PCI1)
>         {
>         […]
>             Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
>             {
>                 If ((CLOD == 0x00))
>                 {
>                     Return (0x01)
>                 }
>                 Else
>                 {
>                     Return (0x02)
>                 }
>             }
>         […]
>         }
> 
>> I think the devices on buses 7f and ff are Intel chipset devices, and
>> I doubt we have drivers for any of them.  They have vendor/device IDs
>> of 8086:6fXX, and I didn't see any reference to them:
>>
>>    $ git grep -i \<0x6f..\>
>>    $
> 
> Interesting. Any ideas, what these chipset devices do?
> 
>> If we *did* have drivers, they would certainly benefit from having
>> _PXM, but since there are no probe methods, I don't think it matters
>> that we don't know where they should run.
>>
>> Maybe the message should be downgraded from "dev_warn" to "dev_info"
>> since there's no functional problem, and the user can't really do
>> anything about it.
>>
>> We could also consider moving it to the actual probe path, so we don't
>> emit a message unless there is an affected driver.

The problem seems to be how we decide if there is an affected driver?
do we care about the out-of-tree driver? doesn't the out-of-tree driver
suffer from the similar problem if BIOS is not providing the correct
numa info?

The 'Unknown NUMA node; performance will be reduced' warning seems to
be added to give the vendor some pressure to fix the BIOS as fast as
possible, downgrading from "dev_warn" to "dev_info" or moving it to
the actual probe path does not seems to fix the problem, just alliviate
the pressure for vendor to fix the BIOS?


> 
> Both ideas sound good, but I do not know the code at all.
> 
>>> 1.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.13.0 05/14/2021
>>> 2.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.2.5 09/06/2016
>>> 3.  [    0.000000] DMI: Dell Inc. PowerEdge R730xd/0WCJNT, BIOS 2.3.4 11/08/2016
>>> 4.  [    0.000000] DMI: Dell Inc. PowerEdge R910/0KYD3D, BIOS 2.10.0 08/29/2013
>>> 5.  [    0.000000] DMI: Dell Inc. PowerEdge R930/0T55KM, BIOS 2.8.1 01/02/2020
>>> 6.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.5.4 08/17/2017
>>> 7.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 1.5.4 10/04/2015
>>> 8.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.11.0 12/23/2019
>>> 9.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.1.5 04/13/2016
>>> 10. [    0.000000] DMI: Supermicro Super Server/X13SAE, BIOS 2.0 10/17/2022
>>> ...
>>
>>> 7f:08.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f80] (rev 01)
>>> 7f:08.2 Performance counters [1101]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f32] (rev 01)
>>> ...
>>
>>> ff:08.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f80] (rev 01)
>>> ff:08.2 Performance counters [1101]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f32] (rev 01)
>>> ...
>>
>>
>>> [    0.000000] DMI: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.4.2 01/09/2017
>>> ...
>>> [    4.398627] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
>>> [    4.437865] pci_bus 0000:ff: Unknown NUMA node; performance will be reduced
>>> ...
>>> [    4.901021] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
>>> [    4.940865] pci_bus 0000:7f: Unknown NUMA node; performance will be reduced
> 
> 
> Kind regards,
> 
> Paul
> 
> 
> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=218951
> .
> 

