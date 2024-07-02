Return-Path: <linux-pci+bounces-9585-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F49F923C47
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 13:20:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186BD1F24DBD
	for <lists+linux-pci@lfdr.de>; Tue,  2 Jul 2024 11:20:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2411015B0EE;
	Tue,  2 Jul 2024 11:20:16 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E228276F17;
	Tue,  2 Jul 2024 11:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719919216; cv=none; b=ehCIsXtIyMSxddkhRbFGCCxo8qwLBWDQOcaUdRFNw2QjX5z5H7NzHQoybcNHY6Hg06XR2sGiP9K6m1nAu19lKRSmeLLC7WOcqnTXY0olmTuJ4xDnc5wpjYltqO58AV2A4S0SuDQm8wN3/d9gLz7I9uXJNcTaI1T8WKZB/S+w5U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719919216; c=relaxed/simple;
	bh=up5dMVI+CcLW1poGQSUzbtN2tghPfjyvdIb1LegsMJA=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=r0yZ8AaLSrjjgfL8graclV7Dr4fS0mw3qO+5eLHAown3g9lpOjfQSrx+Am/gvKtIKrdABlGjJEF4Yws1Xiz3BNcYjewl7hcWCyQvjzDDuHf9hN/Ri0iPEtF4wFg4nwyOkMo08qjetZ93C7uf+xfS1WTst6OceGs0SwHwEn4h1r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WD0lV21WFzdflq;
	Tue,  2 Jul 2024 19:18:30 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id F04D014041B;
	Tue,  2 Jul 2024 19:20:06 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 2 Jul 2024 19:20:06 +0800
Subject: Re: [bug report] scsi: SATA devices missing after FLR is triggered
 during HBA suspended
To: Damien Le Moal <dlemoal@kernel.org>, <cassel@kernel.org>
References: <20240618132900.2731301-1-liyihang9@huawei.com>
 <0c5e14eb-5560-48cb-9086-6ad9c3970427@kernel.org>
 <f27d6fa7-3088-0e60-043e-e71232066b12@huawei.com>
 <b39b4a5b-07b7-483b-9c42-3ac80503120d@kernel.org>
 <0d9bce26-c45b-5ce1-93c0-ca8af50547ae@huawei.com>
 <85cebcb9-ce97-43f2-8da5-01c3a745fe2c@kernel.org>
CC: <James.Bottomley@HansenPartnership.com>, <martin.petersen@oracle.com>,
	<john.g.garry@oracle.com>, <yanaijie@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
	<linuxarm@huawei.com>, <chenxiang66@hisilicon.com>, <prime.zeng@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <alex.williamson@redhat.com>
From: Yihang Li <liyihang9@huawei.com>
Message-ID: <5f8598e8-b371-f6c3-7497-6226d17238f5@huawei.com>
Date: Tue, 2 Jul 2024 19:20:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <85cebcb9-ce97-43f2-8da5-01c3a745fe2c@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/7/1 11:03, Damien Le Moal wrote:
> On 6/24/24 21:10, Yihang Li wrote:
>>> Thank you for the explanation, but as Niklas said, it would be a lot easier for
>>> me to recreate the issue if you send the exact commands you execute to trigger
>>> the issue. E.g. "suspend all disks" in step a can have a lot of different
>>> meaning depending on which type os suspend you are using... So please send the
>>> exact commands you use.
>>> is what exactly ? autosuspend ? or something else ?
> 
> I am failing to recreate the exact same issue. I do see a lot of bad things
> happening though, but that is not looking like what you sent. I do endup with
> the 4 drives connected on my HBA being disabled by libata as revalidate/IDENTIFY
> fails. And even worse: I hit a deadlock on dev->mutex when I try to do "rmmod
> pm80xx" after running your test.
> 
> I am using a pm80xx adapter as that is the only libsas adapter I have.
> 
> I think your test just kicked a big can of worms... There seem to be a lot of
> wrong things going on, but I now need to sort out if the problems are with the
> pm80xx driver, libsas, libata or sd. Probably a combination of all.
> 
> ATA device suspend/resume has been a constant source of issues since scsi layer
> switched to doing PM operations asynchronouly. Your issue is latest one.
> This will take a while to debug.
> 
>> In step a, I suspend all disks by issuing the following command to all disks
>> attached to the SAS controller 0000:b4:02.0:
>> [root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:0/end_device-6:0/target6:0:0/6:0:0:0/power/control
>> [root@localhost ~]# echo 5000 > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:0/end_device-6:0/target6:0:0/6:0:0:0/power/autosuspend_delay_ms
>> ...
>> [root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:6/end_device-6:6/target6:0:6/6:0:6:0/power/control
>> [root@localhost ~]# echo 5000 > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:6/end_device-6:6/target6:0:6/6:0:6:0/power/autosuspend_delay_ms
> 
> This works as expected on my system and I see my drives going to sleep after 5s.
> 
>> Step b, Suspend the SAS controller:
>> [root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/power/control
> 
> This has no effect for me. Can you confirm that your controller is actually
> sleeping ? I.e., what do the following show ?
> 
> cat /sys/devices/pci0000:b4/0000:b4:02.0/power/runtime_active_kids
> cat /sys/devices/pci0000:b4/0000:b4:02.0/power/runtime_status

I don't have a sysfs node for runtime_active_kids in my system.
My controller runtime_status has changed to "suspended" after step b.

[root@localhost ~]# cat /sys/devices/pci0000:b4/0000:b4:02.0/power/runtime_status
suspended


> 
> ?
> 
>> At this point, the SAS controller is suspended. Next step c is trigger PCI FLR.
>> [root@localhost ~]# echo 1 > /sys/bus/pci/devices/0000:b4:02.0/reset
> 
> What does
> 
> cat /sys/bus/pci/devices/0000:b4:02.0/reset_method
> 
> is on your system ?
> 
> Mine is "bus" only.

The results in my system are as follows:

[root@localhost ~]# cat /sys/devices/pci0000:b4/0000:b4:02.0/reset_method
acpi flr pm


> 
>>>> The issue 2:
>>>> a. Suspend all disks on controller B.
>>>> b. Suspend controller B.
>>>> c. Resuming all disks on controller B.
>>>> d. Run the "lsmod" command to check the driver reference counting.
> 
> What is the reference count before you do step (a), after you run step (b) and
> at step (d) ?

Before step a, the hisi_sas driver reference count is 0.
After step b, the driver reference count is 0.
At step d, the reference count is 2405 (this value is not the same every time).

hisi_sas_v3_hw         77824  2405
hisi_sas_main          45056  1 hisi_sas_v3_hw
libsas                 98304  2 hisi_sas_v3_hw,hisi_sas_main


> 
> For my system using the pm80xx driver, I get:
> 
> pm80xx                352256  0
> libsas                155648  1 pm80xx
> 
> before and after, and that is all normal. But there is the difference that
> suspending the pm80xx controller does not seem to be supported and does nothing.
> 

