Return-Path: <linux-pci+bounces-9493-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E97491D667
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 05:03:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39F1A1F2180C
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2024 03:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96AB8BFD;
	Mon,  1 Jul 2024 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DoD2p6q8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B162F4FA;
	Mon,  1 Jul 2024 03:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719802985; cv=none; b=LgsAZJ/SdFjXaOoAYzdfAxA7rDZlxP3syKolgBNToyecBwhzrKJDDtCy5aQ9nPN9iDXKRSbZPX9nTxu4EFp5TBIOQjsMfJ5bYgZGqTzb+W03ZlJUZQqD4i99/zNWiqGtICkPY81cokR8WJotktFnDpAwYMcysqv0YbSFiDOY1tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719802985; c=relaxed/simple;
	bh=nyhn01EuqHL8T1OWGhJk6ZNhVB/UOlqWw6s6S1sIt7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bE9ljtEm+ukjsPTc1wW2V4bZ0kNiiEcHpybL38vqpYwjF1ee0sDXIIRKsAdiImhQqSfC/3rphGxG83WY2A425oXJsAReMSlJoVEf9bXSZN8pTxL3P1L5CsKy8o+48Ljmu96wPaezChZlXnwh03h48Ncv313iVWoMFaq5gFiLMWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DoD2p6q8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79C41C4AF0B;
	Mon,  1 Jul 2024 03:03:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719802985;
	bh=nyhn01EuqHL8T1OWGhJk6ZNhVB/UOlqWw6s6S1sIt7s=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=DoD2p6q87Diq3qmQGCtzBvh8Pk01XRmjUxHhjbKQ3+xGfub058JAAe108/1Qdam/y
	 riyP4NQth2xXNLlleq01UfXc4RUrKWHIgEuARvAF8tnOfLAGXUYjd7UNc7rY9UI7fN
	 DNpdYybZFx1VY2lrr571LaYCe1TFOGuU52OlI6HXgt1NtBOjdR93O7G/LqhjJtmt4k
	 C+iHjyVEnwEe3uOaQI4OKJxPhiG7BhGBbFQhCtjtlnJ6hMw5YKQbAbrbAMq+LLDlDx
	 7CnxWQYotEjUPXWqO/2HmwXHiiqVmGNJMuBZh5KyKpSiaUo5JBk6TBzVMfgpY2mJct
	 KKwkhyBo4ZGaQ==
Message-ID: <85cebcb9-ce97-43f2-8da5-01c3a745fe2c@kernel.org>
Date: Mon, 1 Jul 2024 12:03:02 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] scsi: SATA devices missing after FLR is triggered
 during HBA suspended
To: Yihang Li <liyihang9@huawei.com>, cassel@kernel.org
Cc: James.Bottomley@HansenPartnership.com, martin.petersen@oracle.com,
 john.g.garry@oracle.com, yanaijie@huawei.com, linux-kernel@vger.kernel.org,
 linux-scsi@vger.kernel.org, linuxarm@huawei.com, chenxiang66@hisilicon.com,
 prime.zeng@huawei.com, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20240618132900.2731301-1-liyihang9@huawei.com>
 <0c5e14eb-5560-48cb-9086-6ad9c3970427@kernel.org>
 <f27d6fa7-3088-0e60-043e-e71232066b12@huawei.com>
 <b39b4a5b-07b7-483b-9c42-3ac80503120d@kernel.org>
 <0d9bce26-c45b-5ce1-93c0-ca8af50547ae@huawei.com>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <0d9bce26-c45b-5ce1-93c0-ca8af50547ae@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/24/24 21:10, Yihang Li wrote:
>> Thank you for the explanation, but as Niklas said, it would be a lot easier for
>> me to recreate the issue if you send the exact commands you execute to trigger
>> the issue. E.g. "suspend all disks" in step a can have a lot of different
>> meaning depending on which type os suspend you are using... So please send the
>> exact commands you use.
>> is what exactly ? autosuspend ? or something else ?

I am failing to recreate the exact same issue. I do see a lot of bad things
happening though, but that is not looking like what you sent. I do endup with
the 4 drives connected on my HBA being disabled by libata as revalidate/IDENTIFY
fails. And even worse: I hit a deadlock on dev->mutex when I try to do "rmmod
pm80xx" after running your test.

I am using a pm80xx adapter as that is the only libsas adapter I have.

I think your test just kicked a big can of worms... There seem to be a lot of
wrong things going on, but I now need to sort out if the problems are with the
pm80xx driver, libsas, libata or sd. Probably a combination of all.

ATA device suspend/resume has been a constant source of issues since scsi layer
switched to doing PM operations asynchronouly. Your issue is latest one.
This will take a while to debug.

> In step a, I suspend all disks by issuing the following command to all disks
> attached to the SAS controller 0000:b4:02.0:
> [root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:0/end_device-6:0/target6:0:0/6:0:0:0/power/control
> [root@localhost ~]# echo 5000 > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:0/end_device-6:0/target6:0:0/6:0:0:0/power/autosuspend_delay_ms
> ...
> [root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:6/end_device-6:6/target6:0:6/6:0:6:0/power/control
> [root@localhost ~]# echo 5000 > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:6/end_device-6:6/target6:0:6/6:0:6:0/power/autosuspend_delay_ms

This works as expected on my system and I see my drives going to sleep after 5s.

> Step b, Suspend the SAS controller:
> [root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/power/control

This has no effect for me. Can you confirm that your controller is actually
sleeping ? I.e., what do the following show ?

cat /sys/devices/pci0000:b4/0000:b4:02.0/power/runtime_active_kids
cat /sys/devices/pci0000:b4/0000:b4:02.0/power/runtime_status

?

> At this point, the SAS controller is suspended. Next step c is trigger PCI FLR.
> [root@localhost ~]# echo 1 > /sys/bus/pci/devices/0000:b4:02.0/reset

What does

cat /sys/bus/pci/devices/0000:b4:02.0/reset_method

is on your system ?

Mine is "bus" only.

>>> The issue 2:
>>> a. Suspend all disks on controller B.
>>> b. Suspend controller B.
>>> c. Resuming all disks on controller B.
>>> d. Run the "lsmod" command to check the driver reference counting.

What is the reference count before you do step (a), after you run step (b) and
at step (d) ?

For my system using the pm80xx driver, I get:

pm80xx                352256  0
libsas                155648  1 pm80xx

before and after, and that is all normal. But there is the difference that
suspending the pm80xx controller does not seem to be supported and does nothing.

-- 
Damien Le Moal
Western Digital Research


