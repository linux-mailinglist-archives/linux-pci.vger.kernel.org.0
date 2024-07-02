Return-Path: <linux-pci+bounces-9548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA97F91ED02
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 04:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 042EE1C21101
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 02:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415131426F;
	Tue,  2 Jul 2024 02:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ClZtIJ7j"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129F4101E4;
	Tue,  2 Jul 2024 02:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719887907; cv=none; b=nGeVaYkPM+L0r1zmxDS6DPJLwaGMn23Rb3QFVcs6cNr6aX6AP+aC2f03xkcVH3gn8MGcfZb02XN//QRdvwoZkO7tXwyzvSPM4LpqrdVMBSDrQHhgaqD8IRpuHHbRiu4hGatXw83a8DE9fLGFVtS6F94G2pa1w3lnvl6IAxrhskA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719887907; c=relaxed/simple;
	bh=ONI3pMwbXon7wRjQV0ExkDsCkq0VkIK5LrIpgnRsjlI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umZZCyqMwULeRP2dGWrXJgZkoEukKtkK7l27MTEg2EVDe5tC63zKKXW3neqp/Z6Ib5JDbhJGPEZ9yLEoFcTlIZ4ilrQ9kjZgXaDpylPksSL4mmA4NqJF928eDr3mdDLijK1x5fQTtfXDLtm+MdhqWfeKs76vL//zlMMjRv/PkZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ClZtIJ7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF68C116B1;
	Tue,  2 Jul 2024 02:38:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719887906;
	bh=ONI3pMwbXon7wRjQV0ExkDsCkq0VkIK5LrIpgnRsjlI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ClZtIJ7jw98/M6mBjE47lQj1WuKTK4G0Z4+n54Oo3Ob1pJqj58Whlh/gOVITnbQIB
	 VwaDC6i+NvYg4lkPYZw9ol7M1bTQHgJCk0GyAvEv1Bv7ACObRHlQGCCmUENzzD5gaI
	 sbAB7FdzwUtLcOk9MUez+TLx5c39NdOQ3SNi65b74g5KD+UhJWW+dRZJxlh1/82UfB
	 Q8LEyZ2OZWzp8uU4MOdbFFVGns9qSuvpAV+1exCy+L8cfbAvRRIjDWds4DbKI4xXvQ
	 iH8dR7bUCXozpCV6NJXSGVEZJ2TZtnBQ0dD1AwMfFhp6AN0Ly+f15yj1wJaCGDYrtY
	 qdwAGRxIYSGcA==
Message-ID: <93bd907d-c298-497d-ada2-88706233232e@kernel.org>
Date: Tue, 2 Jul 2024 11:38:23 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] scsi: SATA devices missing after FLR is triggered
 during HBA suspended
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Yihang Li <liyihang9@huawei.com>, cassel@kernel.org,
 James.Bottomley@hansenpartnership.com, martin.petersen@oracle.com,
 john.g.garry@oracle.com, yanaijie@huawei.com, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxarm@huawei.com, chenxiang66@hisilicon.com,
 prime.zeng@huawei.com, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Alex Williamson <alex.williamson@redhat.com>
References: <20240701203903.GA16142@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240701203903.GA16142@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/2/24 05:39, Bjorn Helgaas wrote:
> [+cc Alex]
> 
> On Thu, Jun 27, 2024 at 09:56:02AM +0900, Damien Le Moal wrote:
>> On 6/27/24 00:15, Bjorn Helgaas wrote:
>>>>> Yes, I am talking about the PCI "Function Level Reset"
>>>>>
>>>>>> FLR and disk/controller suspend execution timing are unrelated.
>>>>>> FLR can be triggered at any time through sysfs. So please give
>>>>>> details here. Why is FLR done when the system is being
>>>>>> suspended ?
>>>>>
>>>>> Yes, it is because FLR can be triggered at any time that we are
>>>>> testing the reliability of executing FLR commands after
>>>>> disk/controller suspended.
>>>>
>>>> "can be triggered" ? FLR is not a random asynchronous event. It
>>>> is an action that is *issued* by a user with sys admin rights.
>>>> And such users can do a lot of things that can break a machine...
>>>>
>>>> I fail to see the point of doing a function reset while the
>>>> device is suspended. But granted, I guess the device should
>>>> comeback up in such case, though I would like to hear what the
>>>> PCI guys have to say about this.
>>>>
>>>> Bjorn,
>>>>
>>>> Is reseting a suspended PCI device something that should be/is
>>>> supported ?
>>>
>>> I doubt it.  The PCI core should be preserving all the generic PCI
>>> state across suspend/resume.  The driver should only need to
>>> save/restore device-specific things the PCI core doesn't know about.
>>>
>>> A reset will clear out most state, and the driver doesn't know the
>>> reset happened, so it will expect most device state to have been
>>> preserved.
>>
>> That is what I suspected. However, checking the code, reset_store() in
>> pci-sysfs.c does:
>>
>> 	pm_runtime_get_sync(dev);
>> 	result = pci_reset_function(pdev);
>> 	pm_runtime_put(dev);
>>
>> and pm_runtime_get_sync() calls __pm_runtime_resume() which will
>> resume a suspended device.
>>
>> So while I still think it is not a good idea to reset a suspended
>> device, things should still work as execpected and not cause any
>> problem with the device state, right ?
> 
> The reset will clear almost all state, including both the generic PCI
> part that pci_reset_function() saves/restores *and* any
> device-specific state the PCI core doesn't know about.
> 
> That device-specific state isn't saved and restored anywhere in the
> sysfs reset path, and the driver doesn't know this reset happened, so
> I think all bets are off and we shouldn't expect the driver to work
> afterwards.
> 
> A user-space reset might make sense if there's no driver bound to the
> device, but I don't think it does if there is a driver (except maybe a
> trivial stub driver that doesn't actually operate the device).

OK, makes sense.

I amstill looking into this though because I did find a nasty issue: if the HBA
is reset while all the drives connected to it are suspended (spun down), the
drives are never woken up and the drive re-scan trigerred by the PCI reset fails
with command timeouts. And even worse, I hit a deadlock when unloading the
driver after that happens.

All of that should not be happening: the HBA reset should simply result in
either all drives coming back or the drives (scsi devices) being dropped and
re-scan creating new ones. But that I think is not a PCI issue but rather a HBA
driver issue, or a problem with libsas/scsi/libata power management.

Thanks for the comments.

-- 
Damien Le Moal
Western Digital Research


