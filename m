Return-Path: <linux-pci+bounces-9344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1159919C7A
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 02:59:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD72C286499
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 00:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FB741B813;
	Thu, 27 Jun 2024 00:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UGkpfnYb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B811B285;
	Thu, 27 Jun 2024 00:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719449766; cv=none; b=mtWHYxqtA2PeawfhSVWrARmYS7FuaFCuusuNkw8ZHLjMz+833xX1aDXY8qEvgZMWV6vT34I0PKgIfMrYq4efccVwYfjQbDP8og+n2q8QKuffjhYXTpOAesd5zTZT1uJGp2y7sq16AZWeG8ThJLHpRM7tu+k4ju87lhSPdnf7xsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719449766; c=relaxed/simple;
	bh=UICLH5sFImH9tQWSBxG/F2lJcuSf9UKpImB+14UEmmM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hBAfgM+9043NPlcmXyulkqZV0Kpo3onaLnuDRgs33RcohQAtuhdN89l17WPs6oCjbDZkb6OArWWYKHE7aay4ldap8pk9Z2PgSSO6WjoJDr7tRvIt61GqaI04R+1SJkK/muGUGoV5KiEQxKfOh/htYVwjS2LL2x0LKLBRnDwT688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UGkpfnYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1953C32789;
	Thu, 27 Jun 2024 00:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719449765;
	bh=UICLH5sFImH9tQWSBxG/F2lJcuSf9UKpImB+14UEmmM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UGkpfnYb4m8b1F2BuycZ2ME4nffdEqQZ5k2uZ7jefztUKUYLrJ40QDJ2WM8rctQCX
	 teSmfprKPS/EqpvqB2MYF63GLWb72O/IrpNeFlUx+qygdDybyX/DlwJfgnW/M3BiJl
	 QpECoDwvpy1V1gVmcWZJ2zGGdMV/i87YDoYugtBsemVPw7hdfTCH/TSTUVt01nu8Tg
	 jY7w6xssV2ZIzcBMLOA5qip9NOuFrEzcdLDWb4FG2M8ZpzrD04lZKvLARXJMriVoFy
	 jaHvxh+LoV1Ns194aNkz+VEBKNg9Vrt9lOVduTMJLhDU6EEZV314C7sCP/Al3xCwDi
	 FFm6Yhn7/YHmQ==
Message-ID: <a6e86954-4ab7-4bb0-b78d-56f44556318e@kernel.org>
Date: Thu, 27 Jun 2024 09:56:02 +0900
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
 <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
References: <20240626151546.GA1466906@bhelgaas>
From: Damien Le Moal <dlemoal@kernel.org>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20240626151546.GA1466906@bhelgaas>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/27/24 00:15, Bjorn Helgaas wrote:
>>> Yes, I am talking about the PCI "Function Level Reset"
>>>
>>>> FLR and disk/controller suspend execution timing are unrelated. FLR can be
>>>> triggered at any time through sysfs. So please give details here. Why is FLR
>>>> done when the system is being suspended ?
>>>
>>> Yes, it is because FLR can be triggered at any time that we are testing the
>>> reliability of executing FLR commands after disk/controller suspended.
>>
>> "can be triggered" ? FLR is not a random asynchronous event. It is an action
>> that is *issued* by a user with sys admin rights. And such users can do a lot
>> of things that can break a machine...
>>
>> I fail to see the point of doing a function reset while the device is
>> suspended. But granted, I guess the device should comeback up in such case,
>> though I would like to hear what the PCI guys have to say about this.
>>
>> Bjorn,
>>
>> Is reseting a suspended PCI device something that should be/is supported ?
> 
> I doubt it.  The PCI core should be preserving all the generic PCI
> state across suspend/resume.  The driver should only need to
> save/restore device-specific things the PCI core doesn't know about.
> 
> A reset will clear out most state, and the driver doesn't know the
> reset happened, so it will expect most device state to have been
> preserved.

That is what I suspected. However, checking the code, reset_store() in
pci-sysfs.c does:

	pm_runtime_get_sync(dev);
	result = pci_reset_function(pdev);
	pm_runtime_put(dev);

and pm_runtime_get_sync() calls __pm_runtime_resume() which will resume a
suspended device.

So while I still think it is not a good idea to reset a suspended device, things
should still work as execpected and not cause any problem with the device state,
right ?

Yihang,

I think that the issue at hand here is that once the reset finishes, the
controller goes back to suspended state, and I suspect that is because of the
"auto" setting for its power/control. That triggers because the FLR is done
after the controller resumed but *before* the revalidation of the drives
connected to it completes. So FLR makes the revalidation fail (scsi
scan/revalidation is asynchronous...).

This seems to me to be the expected behavior for what you are doing and I fail
to see how that ever worked correctly, even before 0c76106cb975 and 626b13f015e0.

Could you try this: add a call to msleep(30000) at the end of _resume_v3_hw(). I.e.:

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index feda9b54b443..54224568d749 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -5104,6 +5104,8 @@ static int _resume_v3_hw(struct device *device)

        dev_warn(dev, "end of resuming controller\n");

+       msleep(30000);
+
        return 0;
 }

To see if it makes any difference to actually wait for the connected disks to
resume correctly before doing the FLR.	

-- 
Damien Le Moal
Western Digital Research


