Return-Path: <linux-pci+bounces-9161-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28DE1913F59
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 02:10:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8D4F1F20F76
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 00:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFEA9621;
	Mon, 24 Jun 2024 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jPfr056U"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2527376;
	Mon, 24 Jun 2024 00:10:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719187845; cv=none; b=RZjuB4Ro3xlQdn8r3Dw1HjDkbZpm4mrsi1lYy3Lf9Ez61FzdRk2SyO4pDMZOmVOxoN0qKHmGk2ODdkAwRdY6ys1AY/wH8bgVwmNPVi5N0YWL9Ltykbvx4PenDJTHR+pO1CVcGBURs8ubIfjTzehhr7j6PRRQ5fdj4yGf254eRDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719187845; c=relaxed/simple;
	bh=uL3PJ7KBAAZ9aIO4lfK996y9XsgpTRBRVdBGE+oCmuw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Twcr3aSvM1NkcP/H93aZ8A1zcPuUUCOg8BAxU177L3J4E5KP1/yfHsl7/WpJ5mdCesT4cen1QbACIS2gbt+6rwHzWMFEA3pCS4tnh8WZU7RwE9YaOQzayRFiS0hsoEDfyYR2ObV/grUG+BVjhUJvYbPSRaXekGQu815NfZwgjLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jPfr056U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39EDC2BD10;
	Mon, 24 Jun 2024 00:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719187845;
	bh=uL3PJ7KBAAZ9aIO4lfK996y9XsgpTRBRVdBGE+oCmuw=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=jPfr056U78oZ/CNjFM1c9XDqxk2tvW9w21CPLvfiGjsctSelYL/9I1htYyKoeU5PC
	 PTGOgfs4jZjFOzaupZKF7BH53Mfm3iGsSneTkFPULM2AqybSXBedl1ezBVEW1A9h/O
	 foJt/w+ur8mZCBOQWijMx/NSZJIV/w+YqJAsan3OE9+pCAL9iIU0/8g5leF2wRc4WX
	 /h6RM6pe2TpYa06hwJe4UUH/a+6f6NSVS/5EvKUZeqhTsj86hRNn7mPKkHeTYP+n4c
	 uhu2aB7Qbl3zx+ikc4ZZwguYWCkvI7ZVqYc3rOY8koRatgzLv/mbLUmuyDJITQUTCn
	 6IOR0X3jgNZkA==
Message-ID: <b39b4a5b-07b7-483b-9c42-3ac80503120d@kernel.org>
Date: Mon, 24 Jun 2024 09:10:41 +0900
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [bug report] scsi: SATA devices missing after FLR is triggered
 during HBA suspended
To: Yihang Li <liyihang9@huawei.com>
Cc: cassel@kernel.org, James.Bottomley@HansenPartnership.com,
 martin.petersen@oracle.com, john.g.garry@oracle.com, yanaijie@huawei.com,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
 linuxarm@huawei.com, chenxiang66@hisilicon.com, prime.zeng@huawei.com,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>
References: <20240618132900.2731301-1-liyihang9@huawei.com>
 <0c5e14eb-5560-48cb-9086-6ad9c3970427@kernel.org>
 <f27d6fa7-3088-0e60-043e-e71232066b12@huawei.com>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <f27d6fa7-3088-0e60-043e-e71232066b12@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 6/22/24 12:31 PM, Yihang Li wrote:
> Hi Damien,
> 
> Thanks for your reply.
> 
> On 2024/6/19 7:11, Damien Le Moal wrote:
>> On 6/18/24 22:29, Yihang Li wrote:
>>> Hi Damien,
>>>
>>> I found out that two issues is caused by commit 0c76106cb975 ("scsi: sd:
>>> Fix TCG OPAL unlock on system resume") and 626b13f015e0 ("scsi: Do not
>>> rescan devices with a suspended queue").
>>>
>>> The two issues as follows for the situation that there are ATA disks
>>> connected with SAS controller:
>>
>> Which controller ? What is the driver ?
> 
> I'm using the hisi_sas_v3_hw driver and it supports HiSilicon's SAS controller.

I do not have access to this HBA, but I have one that uses libsas/pm8001 driver
so I will try to test with that.

>>> (1) FLR is triggered after all disks and controller are suspended. As a
>>> result, the number of disks is abnormal.
>>
>> I am assuming here that FLR means PCI "Function Level Reset" ?
> 
> Yes, I am talking about the PCI "Function Level Reset"
> 
>> FLR and disk/controller suspend execution timing are unrelated. FLR can be
>> triggered at any time through sysfs. So please give details here. Why is FLR
>> done when the system is being suspended ?
> 
> Yes, it is because FLR can be triggered at any time that we are testing the
> reliability of executing FLR commands after disk/controller suspended.

"can be triggered" ? FLR is not a random asynchronous event. It is an action
that is *issued* by a user with sys admin rights. And such users can do a lot
of things that can break a machine...

I fail to see the point of doing a function reset while the device is
suspended. But granted, I guess the device should comeback up in such case,
though I would like to hear what the PCI guys have to say about this.

Bjorn,

Is reseting a suspended PCI device something that should be/is supported ?

> Also, the system does not suspended because we have multiple controllers and
> we only suspend one of them and the attached disk devices while the system is
> running in the other controller.
> 
>>
>>> (2) After all disks and controller are suspended, and resuming all disks
>>> again, the driver reference counting is not 0 (The value of "Used" in the
>>> lsmod command output is not 0).
>>
>> Resuming all disks again ? So you mean system resume ?
>> Are we talking about system suspend to ram ? Hybernation ? or something else ?
>> (e.g. a controller reset through PCI FLR ?)
> 
> As mentioned earlier, we have multiple controllers, only suspend one of them and
> the attached data disks, and then resuming the disks again.
> 
>>
>> Please clarify exactly what your adapter is and the full procedure you do to
>> trigger the issue so that we can try to recreate it.
> 
> The system has two HiSilicon's SAS controllers. Controller A is connected to the
> system disk, and controller B is connected to multiple SATA disks.
> 
> The issue 1:
> a. Suspend all disks on controller B.
> b. Suspend controller B.
> c. Trigger the PCI FLR on controller B through sysfs.
> d. The SATA disks connected to controller B is disabled by libata layer.

Thank you for the explanation, but as Niklas said, it would be a lot easier for
me to recreate the issue if you send the exact commands you execute to trigger
the issue. E.g. "suspend all disks" in step a can have a lot of different
meaning depending on which type os suspend you are using... So please send the
exact commands you use.
is what exactly ? autosuspend ? or something else ?

> 
> kernel message is as follows:
> [root@localhost]# echo 1 > /sys/bus/pci/devices/0000:b4:02.0/reset		------> trigger PCI FLR
> [  270.479991] hisi_sas_v3_hw 0000:b4:02.0: resuming from operating state [D0]	------> resuming SAS controller
> [  271.819775] hisi_sas_v3_hw 0000:b4:02.0: waiting up to 25 seconds for 7 phys to resume
> [  271.820324] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy7 link_rate=10(sata)
> [  271.835183] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy0 link_rate=10(sata)
> [  271.835199] hisi_sas_v3_hw 0000:b4:02.0: dev[8:5] found
> [  271.835786] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy5 link_rate=10(sata)
> [  271.835791] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy6 link_rate=10(sata)
> [  271.846911] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy4 link_rate=10(sata)
> [  271.851676] hisi_sas_v3_hw 0000:b4:02.0: dev[9:5] found
> [  271.851688] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
> [  271.851702] sas: ata5: end_device-6:0: dev error handler
> [  271.851708] sas: ata6: end_device-6:1: dev error handler
> [  271.851710] sas: ata7: end_device-6:2: dev error handler
> [  271.851716] sas: ata8: end_device-6:3: dev error handler
> [  271.851717] sas: ata9: end_device-6:4: dev error handler
> [  271.851718] sas: ata10: end_device-6:5: dev error handler
> [  271.855161] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy1 link_rate=10(sata)
> [  271.855547] hisi_sas_v3_hw 0000:b4:02.0: dev[10:5] found
> [  271.855760] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy7 phy_state=0x73
> [  271.855763] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy7 down
> [  271.899322] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy3 link_rate=11
> [  271.902737] hisi_sas_v3_hw 0000:b4:02.0: dev[11:5] found
> [  271.950079] hisi_sas_v3_hw 0000:b4:02.0: dev[12:5] found
> [  271.955569] hisi_sas_v3_hw 0000:b4:02.0: dev[13:5] found
> [  271.961037] hisi_sas_v3_hw 0000:b4:02.0: dev[14:1] found
> [  271.961052] hisi_sas_v3_hw 0000:b4:02.0: end of resuming controller	------> end of resuming controller
> [  271.973073] hisi_sas_v3_hw 0000:b4:02.0: FLR prepare			------> PCI FLR start
> [  272.032623] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy7 link_rate=10(sata)
> [  272.039656] sas: sas_form_port: phy7 belongs to port0 already(1)!
> [  272.201518] ata5.00: configured for UDMA/133
> [  272.207713] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
> [  272.217777] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
> [  272.227672] sas: ata5: end_device-6:0: dev error handler
> [  272.227676] sas: ata6: end_device-6:1: dev error handler
> [  272.227682] sas: ata7: end_device-6:2: dev error handler
> [  272.227688] sas: ata8: end_device-6:3: dev error handler
> [  272.227695] sas: ata10: end_device-6:5: dev error handler
> [  272.227694] sas: ata9: end_device-6:4: dev error handler
> [  274.888594] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy7 link_rate=10(sata)
> [  274.895614] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy5 link_rate=10(sata)
> [  274.895616] sas: sas_form_port: phy7 belongs to port0 already(1)!
> [  274.900251] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy0 link_rate=10(sata)
> [  274.902647] sas: sas_form_port: phy5 belongs to port1 already(1)!
> [  274.902833] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy6 link_rate=10(sata)
> [  274.903023] sas: sas_form_port: phy0 belongs to port2 already(1)!
> [  274.914529] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy1 link_rate=10(sata)
> [  274.916099] sas: sas_form_port: phy6 belongs to port3 already(1)!
> [  274.916259] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy4 link_rate=10(sata)
> [  274.916439] sas: sas_form_port: phy1 belongs to port5 already(1)!
> [  274.961013] sas: sas_form_port: phy4 belongs to port4 already(1)!
> [  274.967338] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy3 link_rate=11
> [  274.983663] sas: sas_form_port: phy3 belongs to port6 already(1)!
> [  275.037230] hisi_sas_v3_hw 0000:b4:02.0: FLR done			------> PCI FLR done
> [  275.037232] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy0 phy_state=0xfa
> [  275.049223] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy0 down
> [  275.204142] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy0 link_rate=10(sata)
> [  275.211001] sas: sas_form_port: phy0 belongs to port2 already(1)!
> [  278.223079] hisi_sas_v3_hw 0000:b4:02.0: entering suspend state	------> the controller suspend again
> [  280.527655] ata7.00: qc timeout after 5000 msecs (cmd 0x27)		------> revalidate ATA devices
> [  280.535667] sas: sas_ata_internal_abort: Task 00000000682de2e7 already finished.
> [  280.543483] ata7.00: failed to read native max address (err_mask=0x4)
> [  280.551671] ata7.00: HPA support seems broken, skipping HPA handling
> [  280.558317] ata7.00: revalidation failed (errno=-5)
> [  280.563437] sas: Executing internal abort failed 5000000000000600 (-22)
> [  280.571670] hisi_sas_v3_hw 0000:b4:02.0: I_T nexus reset: internal abort (-22)
> [  280.579338] sas: ata7: end_device-6:2: Unable to reset ata device?
> [  280.751675] sas: lldd_execute_task returned: -22
> [  280.759664] ata7.00: failed to IDENTIFY (I/O error, err_mask=0x40)
> [  280.766063] ata7.00: revalidation failed (errno=-5)
> [  285.911663] sas: Executing internal abort failed 5000000000000600 (-22)
> [  285.919667] hisi_sas_v3_hw 0000:b4:02.0: I_T nexus reset: internal abort (-22)
> [  285.927353] sas: ata7: end_device-6:2: Unable to reset ata device?
> [  286.095677] sas: lldd_execute_task returned: -22
> [  286.103666] ata7.00: failed to IDENTIFY (I/O error, err_mask=0x40)
> [  286.110078] ata7.00: revalidation failed (errno=-5)			------> revalidation failed due to the controller is suspend state
> [  286.119424] ata7.00: disable device					------> disable device due to revalidation failed
> [  286.123185] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
> [  286.133236] sas: sas_resume_sata: for direct-attached device 5000000000000600 returned -19
> ...
> 
> The issue 2:
> a. Suspend all disks on controller B.
> b. Suspend controller B.
> c. Resuming all disks on controller B.
> d. Run the "lsmod" command to check the driver reference counting.
> 
> Thanks,
> Yihang
> 
>>
>>> For the issue 1, After all disks and controller are suspended, FLR command
>>> will resuming the controller and all sas ports. libsas layer will call
>>> ata_sas_port_resume() to resume ata port and schedule EH to recover it.
>>> In libata standard error handler ata_std_error_handler(), it will call ata
>>> reset function, revalidate ATA devices and issue ATA device command
>>> ATA_CMD_READ_NATIVE_MAX_EXT to read native max address. This command will
>>> failed due to the controller enter suspend state again and libata disable
>>> the device finally. The controller enter suspend state again because FLR
>>> command completes and the runtime PM usage counter is 0.
>>>
>>> In commit 0c76106cb975 ("scsi: sd: Fix TCG OPAL unlock on system resume")
>>> and 626b13f015e0 ("scsi: Do not rescan devices with a suspended queue"),
>>> use blk_queue_pm_only() to check the device request queue state, if the
>>> device request queue is not running, the device will not be rescanned.
>>> Therefore, the runtime PM usage counter of the controller will not
>>> increase so that the controller enters the suspended state again.
>>>
>>> For the issue 2, the cause is unknown.
>>>
>>> How to solve these two issues?
>>>
>>> regards,
>>> Yihang
>>>
>>

-- 
Damien Le Moal
Western Digital Research


