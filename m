Return-Path: <linux-pci+bounces-9186-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FA2E91495D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 14:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99F44B219BA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jun 2024 12:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E0DB13B2B0;
	Mon, 24 Jun 2024 12:10:56 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9874813A86A;
	Mon, 24 Jun 2024 12:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719231056; cv=none; b=dyDOcGESfh5ilZPfTcCRhQftpkPoCJz840YevgJDBr3g6lepWbQJGCwwtpIh8qzFZAKP6GGwFv38gAnvg/Mnw08raWanYWAJVcQllnzx5p2G1qB4etS9YjZKKYSwBhutvLRVr0ZOPMfetLMjrCkICkT8etSCEDAnTSR6H7Bc42w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719231056; c=relaxed/simple;
	bh=kgH5a1rrVfSiHxc+mfi50UFfbzMrNkpzSKOxUuNd/Ps=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=MWSoi5W0X9AxUDMWduzPfydfGCMMFYDVASoVfneEGeuxdVwocVH+7PLMrNm5OHpYqmN1udDcTkf5nQ9eIkctYv1aLTnFIM/nQjpeAPzi/Y9q5C7ANq5Ra56ygJOLpYCYBK8+HOYD4KjIKNtbhGLpCOFu9Z8gooNWHqhMMmBPrRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W76HV0jmYznXLg;
	Mon, 24 Jun 2024 20:10:46 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 4F01A1402E2;
	Mon, 24 Jun 2024 20:10:49 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Jun 2024 20:10:48 +0800
Subject: Re: [bug report] scsi: SATA devices missing after FLR is triggered
 during HBA suspended
To: Damien Le Moal <dlemoal@kernel.org>, <cassel@kernel.org>
References: <20240618132900.2731301-1-liyihang9@huawei.com>
 <0c5e14eb-5560-48cb-9086-6ad9c3970427@kernel.org>
 <f27d6fa7-3088-0e60-043e-e71232066b12@huawei.com>
 <b39b4a5b-07b7-483b-9c42-3ac80503120d@kernel.org>
CC: <cassel@kernel.org>, <James.Bottomley@HansenPartnership.com>,
	<martin.petersen@oracle.com>, <john.g.garry@oracle.com>,
	<yanaijie@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
	<chenxiang66@hisilicon.com>, <prime.zeng@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>, <liyihang9@huawei.com>
From: Yihang Li <liyihang9@huawei.com>
Message-ID: <0d9bce26-c45b-5ce1-93c0-ca8af50547ae@huawei.com>
Date: Mon, 24 Jun 2024 20:10:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b39b4a5b-07b7-483b-9c42-3ac80503120d@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500008.china.huawei.com (7.221.188.139)

Hi Damien, Niklas,

Thanks for discussion here

On 2024/6/24 8:10, Damien Le Moal wrote:
> On 6/22/24 12:31 PM, Yihang Li wrote:
>> Hi Damien,
>>
>> Thanks for your reply.
>>
>> On 2024/6/19 7:11, Damien Le Moal wrote:
>>> On 6/18/24 22:29, Yihang Li wrote:
>>>> Hi Damien,
>>>>
>>>> I found out that two issues is caused by commit 0c76106cb975 ("scsi: sd:
>>>> Fix TCG OPAL unlock on system resume") and 626b13f015e0 ("scsi: Do not
>>>> rescan devices with a suspended queue").
>>>>
>>>> The two issues as follows for the situation that there are ATA disks
>>>> connected with SAS controller:
>>>
>>> Which controller ? What is the driver ?
>>
>> I'm using the hisi_sas_v3_hw driver and it supports HiSilicon's SAS controller.
> 
> I do not have access to this HBA, but I have one that uses libsas/pm8001 driver
> so I will try to test with that.

I will help with some tests if needed.

> 
>>>> (1) FLR is triggered after all disks and controller are suspended. As a
>>>> result, the number of disks is abnormal.
>>>
>>> I am assuming here that FLR means PCI "Function Level Reset" ?
>>
>> Yes, I am talking about the PCI "Function Level Reset"
>>
>>> FLR and disk/controller suspend execution timing are unrelated. FLR can be
>>> triggered at any time through sysfs. So please give details here. Why is FLR
>>> done when the system is being suspended ?
>>
>> Yes, it is because FLR can be triggered at any time that we are testing the
>> reliability of executing FLR commands after disk/controller suspended.
> 
> "can be triggered" ? FLR is not a random asynchronous event. It is an action
> that is *issued* by a user with sys admin rights. And such users can do a lot
> of things that can break a machine...
> 
> I fail to see the point of doing a function reset while the device is
> suspended. But granted, I guess the device should comeback up in such case,
> though I would like to hear what the PCI guys have to say about this.

I agree with the view that the device should comeback up to normal operation.
But at the moment, that's not the case.

> 
> Bjorn,
> 
> Is reseting a suspended PCI device something that should be/is supported ?
> 
>> Also, the system does not suspended because we have multiple controllers and
>> we only suspend one of them and the attached disk devices while the system is
>> running in the other controller.
>>
>>>
>>>> (2) After all disks and controller are suspended, and resuming all disks
>>>> again, the driver reference counting is not 0 (The value of "Used" in the
>>>> lsmod command output is not 0).
>>>
>>> Resuming all disks again ? So you mean system resume ?
>>> Are we talking about system suspend to ram ? Hybernation ? or something else ?
>>> (e.g. a controller reset through PCI FLR ?)
>>
>> As mentioned earlier, we have multiple controllers, only suspend one of them and
>> the attached data disks, and then resuming the disks again.
>>
>>>
>>> Please clarify exactly what your adapter is and the full procedure you do to
>>> trigger the issue so that we can try to recreate it.
>>
>> The system has two HiSilicon's SAS controllers. Controller A is connected to the
>> system disk, and controller B is connected to multiple SATA disks.
>>
>> The issue 1:
>> a. Suspend all disks on controller B.
>> b. Suspend controller B.
>> c. Trigger the PCI FLR on controller B through sysfs.
>> d. The SATA disks connected to controller B is disabled by libata layer.
> 
> Thank you for the explanation, but as Niklas said, it would be a lot easier for
> me to recreate the issue if you send the exact commands you execute to trigger
> the issue. E.g. "suspend all disks" in step a can have a lot of different
> meaning depending on which type os suspend you are using... So please send the
> exact commands you use.
> is what exactly ? autosuspend ? or something else ?

OK, first of all, I have the following controllers and disks in my system:
[root@localhost ~]# lsscsi -v
[6:0:0:0]    disk    ATA      SAMSUNG MZ7KM480 104Q  /dev/sda
  dir: /sys/bus/scsi/devices/6:0:0:0  [/sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:0/end_device-6:0/target6:0:0/6:0:0:0]
[6:0:1:0]    disk    ATA      HGST HUS724040AL A8B0  /dev/sdb
  dir: /sys/bus/scsi/devices/6:0:1:0  [/sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:1/end_device-6:1/target6:0:1/6:0:1:0]
[6:0:2:0]    disk    ATA      MG04ACA400N      FJ3J  /dev/sdc
  dir: /sys/bus/scsi/devices/6:0:2:0  [/sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:2/end_device-6:2/target6:0:2/6:0:2:0]
[6:0:3:0]    disk    ATA      MG04ACA400N      FJ3J  /dev/sdd
  dir: /sys/bus/scsi/devices/6:0:3:0  [/sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:3/end_device-6:3/target6:0:3/6:0:3:0]
[6:0:4:0]    disk    ATA      ST4000NM0035-1V4 TN03  /dev/sde
  dir: /sys/bus/scsi/devices/6:0:4:0  [/sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:4/end_device-6:4/target6:0:4/6:0:4:0]
[6:0:5:0]    disk    ATA      ST4000NM0035-1V4 TN03  /dev/sdf
  dir: /sys/bus/scsi/devices/6:0:5:0  [/sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:5/end_device-6:5/target6:0:5/6:0:5:0]
[6:0:6:0]    disk    SEAGATE  ST4000NM0025     N003  /dev/sdg
  dir: /sys/bus/scsi/devices/6:0:6:0  [/sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:6/end_device-6:6/target6:0:6/6:0:6:0]
[N:0:1:1]    dsk/nvm HWE56P433T2M002N__1                        /dev/nvme0n1	------> this is my system disk
  dir: /sys/class/nvme/nvme0/nvme0n1  [/sys/devices/pci0000:00/0000:00:0c.0/0000:03:00.0/nvme/nvme0/nvme0n1]

All disks are connected to the HiSilicon's SAS controller (0000:b4:02.0),
and my system disk is connected to another controller (0000:03:00.0).

In step a, I suspend all disks by issuing the following command to all disks
attached to the SAS controller 0000:b4:02.0:
[root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:0/end_device-6:0/target6:0:0/6:0:0:0/power/control
[root@localhost ~]# echo 5000 > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:0/end_device-6:0/target6:0:0/6:0:0:0/power/autosuspend_delay_ms
...
[root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:6/end_device-6:6/target6:0:6/6:0:6:0/power/control
[root@localhost ~]# echo 5000 > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:6/end_device-6:6/target6:0:6/6:0:6:0/power/autosuspend_delay_ms

Step b, Suspend the SAS controller:
[root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/power/control

At this point, the SAS controller is suspended. Next step c is trigger PCI FLR.
[root@localhost ~]# echo 1 > /sys/bus/pci/devices/0000:b4:02.0/reset

These are the exact commands triggered by issue 1.

> 
>>
>> kernel message is as follows:
>> [root@localhost]# echo 1 > /sys/bus/pci/devices/0000:b4:02.0/reset		------> trigger PCI FLR
>> [  270.479991] hisi_sas_v3_hw 0000:b4:02.0: resuming from operating state [D0]	------> resuming SAS controller
>> [  271.819775] hisi_sas_v3_hw 0000:b4:02.0: waiting up to 25 seconds for 7 phys to resume
>> [  271.820324] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy7 link_rate=10(sata)
>> [  271.835183] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy0 link_rate=10(sata)
>> [  271.835199] hisi_sas_v3_hw 0000:b4:02.0: dev[8:5] found
>> [  271.835786] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy5 link_rate=10(sata)
>> [  271.835791] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy6 link_rate=10(sata)
>> [  271.846911] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy4 link_rate=10(sata)
>> [  271.851676] hisi_sas_v3_hw 0000:b4:02.0: dev[9:5] found
>> [  271.851688] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
>> [  271.851702] sas: ata5: end_device-6:0: dev error handler
>> [  271.851708] sas: ata6: end_device-6:1: dev error handler
>> [  271.851710] sas: ata7: end_device-6:2: dev error handler
>> [  271.851716] sas: ata8: end_device-6:3: dev error handler
>> [  271.851717] sas: ata9: end_device-6:4: dev error handler
>> [  271.851718] sas: ata10: end_device-6:5: dev error handler
>> [  271.855161] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy1 link_rate=10(sata)
>> [  271.855547] hisi_sas_v3_hw 0000:b4:02.0: dev[10:5] found
>> [  271.855760] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy7 phy_state=0x73
>> [  271.855763] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy7 down
>> [  271.899322] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy3 link_rate=11
>> [  271.902737] hisi_sas_v3_hw 0000:b4:02.0: dev[11:5] found
>> [  271.950079] hisi_sas_v3_hw 0000:b4:02.0: dev[12:5] found
>> [  271.955569] hisi_sas_v3_hw 0000:b4:02.0: dev[13:5] found
>> [  271.961037] hisi_sas_v3_hw 0000:b4:02.0: dev[14:1] found
>> [  271.961052] hisi_sas_v3_hw 0000:b4:02.0: end of resuming controller	------> end of resuming controller
>> [  271.973073] hisi_sas_v3_hw 0000:b4:02.0: FLR prepare			------> PCI FLR start
>> [  272.032623] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy7 link_rate=10(sata)
>> [  272.039656] sas: sas_form_port: phy7 belongs to port0 already(1)!
>> [  272.201518] ata5.00: configured for UDMA/133
>> [  272.207713] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
>> [  272.217777] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
>> [  272.227672] sas: ata5: end_device-6:0: dev error handler
>> [  272.227676] sas: ata6: end_device-6:1: dev error handler
>> [  272.227682] sas: ata7: end_device-6:2: dev error handler
>> [  272.227688] sas: ata8: end_device-6:3: dev error handler
>> [  272.227695] sas: ata10: end_device-6:5: dev error handler
>> [  272.227694] sas: ata9: end_device-6:4: dev error handler
>> [  274.888594] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy7 link_rate=10(sata)
>> [  274.895614] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy5 link_rate=10(sata)
>> [  274.895616] sas: sas_form_port: phy7 belongs to port0 already(1)!
>> [  274.900251] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy0 link_rate=10(sata)
>> [  274.902647] sas: sas_form_port: phy5 belongs to port1 already(1)!
>> [  274.902833] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy6 link_rate=10(sata)
>> [  274.903023] sas: sas_form_port: phy0 belongs to port2 already(1)!
>> [  274.914529] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy1 link_rate=10(sata)
>> [  274.916099] sas: sas_form_port: phy6 belongs to port3 already(1)!
>> [  274.916259] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy4 link_rate=10(sata)
>> [  274.916439] sas: sas_form_port: phy1 belongs to port5 already(1)!
>> [  274.961013] sas: sas_form_port: phy4 belongs to port4 already(1)!
>> [  274.967338] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy3 link_rate=11
>> [  274.983663] sas: sas_form_port: phy3 belongs to port6 already(1)!
>> [  275.037230] hisi_sas_v3_hw 0000:b4:02.0: FLR done			------> PCI FLR done
>> [  275.037232] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy0 phy_state=0xfa
>> [  275.049223] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy0 down
>> [  275.204142] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy0 link_rate=10(sata)
>> [  275.211001] sas: sas_form_port: phy0 belongs to port2 already(1)!
>> [  278.223079] hisi_sas_v3_hw 0000:b4:02.0: entering suspend state	------> the controller suspend again
>> [  280.527655] ata7.00: qc timeout after 5000 msecs (cmd 0x27)		------> revalidate ATA devices
>> [  280.535667] sas: sas_ata_internal_abort: Task 00000000682de2e7 already finished.
>> [  280.543483] ata7.00: failed to read native max address (err_mask=0x4)
>> [  280.551671] ata7.00: HPA support seems broken, skipping HPA handling
>> [  280.558317] ata7.00: revalidation failed (errno=-5)
>> [  280.563437] sas: Executing internal abort failed 5000000000000600 (-22)
>> [  280.571670] hisi_sas_v3_hw 0000:b4:02.0: I_T nexus reset: internal abort (-22)
>> [  280.579338] sas: ata7: end_device-6:2: Unable to reset ata device?
>> [  280.751675] sas: lldd_execute_task returned: -22
>> [  280.759664] ata7.00: failed to IDENTIFY (I/O error, err_mask=0x40)
>> [  280.766063] ata7.00: revalidation failed (errno=-5)
>> [  285.911663] sas: Executing internal abort failed 5000000000000600 (-22)
>> [  285.919667] hisi_sas_v3_hw 0000:b4:02.0: I_T nexus reset: internal abort (-22)
>> [  285.927353] sas: ata7: end_device-6:2: Unable to reset ata device?
>> [  286.095677] sas: lldd_execute_task returned: -22
>> [  286.103666] ata7.00: failed to IDENTIFY (I/O error, err_mask=0x40)
>> [  286.110078] ata7.00: revalidation failed (errno=-5)			------> revalidation failed due to the controller is suspend state
>> [  286.119424] ata7.00: disable device					------> disable device due to revalidation failed
>> [  286.123185] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
>> [  286.133236] sas: sas_resume_sata: for direct-attached device 5000000000000600 returned -19
>> ...
>>
>> The issue 2:
>> a. Suspend all disks on controller B.
>> b. Suspend controller B.
>> c. Resuming all disks on controller B.
>> d. Run the "lsmod" command to check the driver reference counting.

The following is the exact commands triggered by issue 2, and it's also on this
same machine.

Step a is to suspend all disks attached to the SAS controller:
[root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:0/end_device-6:0/target6:0:0/6:0:0:0/power/control
[root@localhost ~]# echo 5000 > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:0/end_device-6:0/target6:0:0/6:0:0:0/power/autosuspend_delay_ms
...
[root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:6/end_device-6:6/target6:0:6/6:0:6:0/power/control
[root@localhost ~]# echo 5000 > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:6/end_device-6:6/target6:0:6/6:0:6:0/power/autosuspend_delay_ms

Step b is to suspend the SAS controller:
[root@localhost ~]# echo auto > /sys/devices/pci0000:b4/0000:b4:02.0/power/control

Step c is to resuming all suspend disks:
[root@localhost ~]# echo on > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:0/end_device-6:0/target6:0:0/6:0:0:0/power/control
...
[root@localhost ~]# echo on > /sys/devices/pci0000:b4/0000:b4:02.0/host6/port-6:6/end_device-6:6/target6:0:6/6:0:6:0/power/control

Step d is to check the driver reference counting:
[root@localhost ~]# lsmod | grep hisi_sas_v3_hw
hisi_sas_v3_hw         77824  1436

>>
>> Thanks,
>> Yihang
>>
>>>
>>>> For the issue 1, After all disks and controller are suspended, FLR command
>>>> will resuming the controller and all sas ports. libsas layer will call
>>>> ata_sas_port_resume() to resume ata port and schedule EH to recover it.
>>>> In libata standard error handler ata_std_error_handler(), it will call ata
>>>> reset function, revalidate ATA devices and issue ATA device command
>>>> ATA_CMD_READ_NATIVE_MAX_EXT to read native max address. This command will
>>>> failed due to the controller enter suspend state again and libata disable
>>>> the device finally. The controller enter suspend state again because FLR
>>>> command completes and the runtime PM usage counter is 0.
>>>>
>>>> In commit 0c76106cb975 ("scsi: sd: Fix TCG OPAL unlock on system resume")
>>>> and 626b13f015e0 ("scsi: Do not rescan devices with a suspended queue"),
>>>> use blk_queue_pm_only() to check the device request queue state, if the
>>>> device request queue is not running, the device will not be rescanned.
>>>> Therefore, the runtime PM usage counter of the controller will not
>>>> increase so that the controller enters the suspended state again.
>>>>
>>>> For the issue 2, the cause is unknown.
>>>>
>>>> How to solve these two issues?
>>>>
>>>> regards,
>>>> Yihang
>>>>
>>>
> 

