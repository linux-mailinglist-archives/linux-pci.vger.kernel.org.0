Return-Path: <linux-pci+bounces-8558-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0639029F1
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 22:28:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68197286016
	for <lists+linux-pci@lfdr.de>; Mon, 10 Jun 2024 20:28:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0035A47F60;
	Mon, 10 Jun 2024 20:28:10 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2BE4D8A8
	for <linux-pci@vger.kernel.org>; Mon, 10 Jun 2024 20:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718051289; cv=none; b=A9BierGBMOkVFXar+dYUtRUKzUtkwNhpJvNorFLgI5IE60tTZ2zSYIsywIYHcvxyFSh5RkBvN5s98qtRlaNOSsazc9gi4sgjp5g8CUBGKnOGWqb0Ld+Z6BPe9UevKcFlHNRjtVB7gK/v02RHI34fdvFYWaETRO9z3pv8ll4rDew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718051289; c=relaxed/simple;
	bh=dSDu6GdtPWQeNNLOXuMegRdjPc4bPVdWRIUsb1P9ZFM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Rncz4gGrxbp1TVaEfhv7JMBby0v9YJBcjWvAebAuMsAMHReIe9kyKz/5pTCuW38B/Yo9ZlAM58f7SO9CKocvUO/Sq4IqA6+q7SxoUl8CX2sluxpxE/kDtrGcJtT66eBjFwmsL4EpmuZrQRnRVZ3s7/Dfsjm6t6pmxnkAGFZN1jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [192.168.0.2] (ip5f5af29f.dynamic.kabel-deutschland.de [95.90.242.159])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7219661E646D5;
	Mon, 10 Jun 2024 22:27:39 +0200 (CEST)
Message-ID: <4dcdc648-e09d-4f43-a53c-bcb4f54ef476@molgen.mpg.de>
Date: Mon, 10 Jun 2024 22:27:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Linux warns `Unknown NUMA node; performance will be reduced`
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 Yunsheng Lin <linyunsheng@huawei.com>
References: <20240610194236.GA954050@bhelgaas>
Content-Language: en-US
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20240610194236.GA954050@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Bjorn,


Am 10.06.24 um 21:42 schrieb Bjorn Helgaas:
> [+cc Yunsheng, thread at
> https://lore.kernel.org/r/a154f694-c48b-4b3b-809f-4b74ec86a924@molgen.mpg.de]
> 
> Thanks very much for this report!

Thank you for the quick reply.

> On Sun, Jun 09, 2024 at 10:31:05AM +0200, Paul Menzel wrote:
>> On the servers below Linux warns:
>>
>>       Unknown NUMA node; performance will be reduced
> 
> This warning was added by ad5086108b9f ("PCI: Warn if no host bridge
> NUMA node info"), which appeared in v5.5, so I assume this isn't new.
> 
> That commit log says:
> 
>    In pci_call_probe(), we try to run driver probe functions on the node where
>    the device is attached.  If we don't know which node the device is attached
>    to, the driver will likely run on the wrong node.  This will still work,
>    but performance will not be as good as it could be.
> 
>    On NUMA systems, warn if we don't know which node a PCI host bridge is
>    attached to.  This is likely an indication that ACPI didn't supply a _PXM
>    method or the DT didn't supply a "numa-node-id" property.
> 
> I assume these are all ACPI systems, so likely missing _PXM.  An
> acpidump could confirm this.

I created an issue in the Linux Kernel Bugzilla [1] and attached the 
output of `acpidump` on a Dell PowerEdge T630 there. The DSDT contains:

         Device (PCI1)
         {
         […]
             Method (_PXM, 0, NotSerialized)  // _PXM: Device Proximity
             {
                 If ((CLOD == 0x00))
                 {
                     Return (0x01)
                 }
                 Else
                 {
                     Return (0x02)
                 }
             }
         […]
         }

> I think the devices on buses 7f and ff are Intel chipset devices, and
> I doubt we have drivers for any of them.  They have vendor/device IDs
> of 8086:6fXX, and I didn't see any reference to them:
> 
>    $ git grep -i \<0x6f..\>
>    $

Interesting. Any ideas, what these chipset devices do?

> If we *did* have drivers, they would certainly benefit from having
> _PXM, but since there are no probe methods, I don't think it matters
> that we don't know where they should run.
> 
> Maybe the message should be downgraded from "dev_warn" to "dev_info"
> since there's no functional problem, and the user can't really do
> anything about it.
> 
> We could also consider moving it to the actual probe path, so we don't
> emit a message unless there is an affected driver.

Both ideas sound good, but I do not know the code at all.

>> 1.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.13.0 05/14/2021
>> 2.  [    0.000000] DMI: Dell Inc. PowerEdge R730/0H21J3, BIOS 2.2.5 09/06/2016
>> 3.  [    0.000000] DMI: Dell Inc. PowerEdge R730xd/0WCJNT, BIOS 2.3.4 11/08/2016
>> 4.  [    0.000000] DMI: Dell Inc. PowerEdge R910/0KYD3D, BIOS 2.10.0 08/29/2013
>> 5.  [    0.000000] DMI: Dell Inc. PowerEdge R930/0T55KM, BIOS 2.8.1 01/02/2020
>> 6.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.5.4 08/17/2017
>> 7.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 1.5.4 10/04/2015
>> 8.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.11.0 12/23/2019
>> 9.  [    0.000000] DMI: Dell Inc. PowerEdge T630/0W9WXC, BIOS 2.1.5 04/13/2016
>> 10. [    0.000000] DMI: Supermicro Super Server/X13SAE, BIOS 2.0 10/17/2022
>> ...
> 
>> 7f:08.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f80] (rev 01)
>> 7f:08.2 Performance counters [1101]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f32] (rev 01)
>> ...
> 
>> ff:08.0 System peripheral [0880]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f80] (rev 01)
>> ff:08.2 Performance counters [1101]: Intel Corporation Xeon E7 v4/Xeon E5 v4/Xeon E3 v4/Xeon D QPI Link 0 [8086:6f32] (rev 01)
>> ...
> 
> 
>> [    0.000000] DMI: Dell Inc. PowerEdge T630/0NT78X, BIOS 2.4.2 01/09/2017
>> ...
>> [    4.398627] ACPI: PCI Root Bridge [UNC1] (domain 0000 [bus ff])
>> [    4.437865] pci_bus 0000:ff: Unknown NUMA node; performance will be reduced
>> ...
>> [    4.901021] ACPI: PCI Root Bridge [UNC0] (domain 0000 [bus 7f])
>> [    4.940865] pci_bus 0000:7f: Unknown NUMA node; performance will be reduced


Kind regards,

Paul


[1]: https://bugzilla.kernel.org/show_bug.cgi?id=218951

