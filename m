Return-Path: <linux-pci+bounces-9356-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 54ECC91A14B
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 10:20:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A4FC6B21FB5
	for <lists+linux-pci@lfdr.de>; Thu, 27 Jun 2024 08:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20539770F9;
	Thu, 27 Jun 2024 08:20:02 +0000 (UTC)
X-Original-To: linux-pci@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F12073176;
	Thu, 27 Jun 2024 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719476402; cv=none; b=LlUqW7fRbqJAczEN2noVC3/Qigqh0nb/NcnimbuCTCaWWnw0S1peVzqsXHkAUAyBa/A7JNDCfNJw5emWHbQ24emyAOi67d7vl02T/ZafMNnEmz15To9M2Bcu+MdLR5GI6mak704CkOPVAIqEHgjv10qoVFTg4U1NbeB1QqaDGRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719476402; c=relaxed/simple;
	bh=c86qN1okEQV0GKJhSlcguaAKEoTzRnCv7sBPABO1vNE=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=qWVqCfvulz+domlzMwJ+G2ViT55Q0o1XsvuK3z/MgPwAN2xlBnqYB5ZNawoBzZKqLC+q9A2ndvJ0jfsU2ZRkfH21z2lhfWlDlyrbbS3gCOmObeYJ24aO2wS1GIKNmY3i1gCY0FxN9kZ35jv/2tnJ22Zkur1uXjNLgyPXuEUOWyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4W8rxW1nDgz1ytpQ;
	Thu, 27 Jun 2024 16:16:15 +0800 (CST)
Received: from kwepemi500008.china.huawei.com (unknown [7.221.188.139])
	by mail.maildlp.com (Postfix) with ESMTPS id 3A81C1A0188;
	Thu, 27 Jun 2024 16:19:56 +0800 (CST)
Received: from [10.67.120.126] (10.67.120.126) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 27 Jun 2024 16:19:55 +0800
Subject: Re: [bug report] scsi: SATA devices missing after FLR is triggered
 during HBA suspended
To: Damien Le Moal <dlemoal@kernel.org>, Bjorn Helgaas <helgaas@kernel.org>
References: <20240626151546.GA1466906@bhelgaas>
 <a6e86954-4ab7-4bb0-b78d-56f44556318e@kernel.org>
CC: <cassel@kernel.org>, <James.Bottomley@hansenpartnership.com>,
	<martin.petersen@oracle.com>, <john.g.garry@oracle.com>,
	<yanaijie@huawei.com>, <linux-kernel@vger.kernel.org>,
	<linux-scsi@vger.kernel.org>, <linuxarm@huawei.com>,
	<chenxiang66@hisilicon.com>, <prime.zeng@huawei.com>,
	"linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
From: Yihang Li <liyihang9@huawei.com>
Message-ID: <9377d812-2e64-aec0-8abb-5c542b42922e@huawei.com>
Date: Thu, 27 Jun 2024 16:19:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <a6e86954-4ab7-4bb0-b78d-56f44556318e@kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi500008.china.huawei.com (7.221.188.139)



On 2024/6/27 8:56, Damien Le Moal wrote:
> On 6/27/24 00:15, Bjorn Helgaas wrote:
>>>> Yes, I am talking about the PCI "Function Level Reset"
>>>>
>>>>> FLR and disk/controller suspend execution timing are unrelated. FLR can be
>>>>> triggered at any time through sysfs. So please give details here. Why is FLR
>>>>> done when the system is being suspended ?
>>>>
>>>> Yes, it is because FLR can be triggered at any time that we are testing the
>>>> reliability of executing FLR commands after disk/controller suspended.
>>>
>>> "can be triggered" ? FLR is not a random asynchronous event. It is an action
>>> that is *issued* by a user with sys admin rights. And such users can do a lot
>>> of things that can break a machine...
>>>
>>> I fail to see the point of doing a function reset while the device is
>>> suspended. But granted, I guess the device should comeback up in such case,
>>> though I would like to hear what the PCI guys have to say about this.
>>>
>>> Bjorn,
>>>
>>> Is reseting a suspended PCI device something that should be/is supported ?
>>
>> I doubt it.  The PCI core should be preserving all the generic PCI
>> state across suspend/resume.  The driver should only need to
>> save/restore device-specific things the PCI core doesn't know about.
>>
>> A reset will clear out most state, and the driver doesn't know the
>> reset happened, so it will expect most device state to have been
>> preserved.
> 
> That is what I suspected. However, checking the code, reset_store() in
> pci-sysfs.c does:
> 
> 	pm_runtime_get_sync(dev);
> 	result = pci_reset_function(pdev);
> 	pm_runtime_put(dev);
> 
> and pm_runtime_get_sync() calls __pm_runtime_resume() which will resume a
> suspended device.
> 
> So while I still think it is not a good idea to reset a suspended device, things
> should still work as execpected and not cause any problem with the device state,
> right ?
> 
> Yihang,
> 
> I think that the issue at hand here is that once the reset finishes, the
> controller goes back to suspended state, and I suspect that is because of the
> "auto" setting for its power/control. That triggers because the FLR is done
> after the controller resumed but *before* the revalidation of the drives
> connected to it completes. So FLR makes the revalidation fail (scsi
> scan/revalidation is asynchronous...).
> 
> This seems to me to be the expected behavior for what you are doing and I fail
> to see how that ever worked correctly, even before 0c76106cb975 and 626b13f015e0.

I think that before 0c76106cb975 and 626b13f015e0, sd_resume() will be called in the
scsi scan process, which will bump up power.usage_count of the controller so that
the controller cannot goes back to suspended state. Then revalidation will not fail.

> 
> Could you try this: add a call to msleep(30000) at the end of _resume_v3_hw(). I.e.:
> 
> diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> index feda9b54b443..54224568d749 100644
> --- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> +++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
> @@ -5104,6 +5104,8 @@ static int _resume_v3_hw(struct device *device)
> 
>         dev_warn(dev, "end of resuming controller\n");
> 
> +       msleep(30000);
> +
>         return 0;
>  }
> 
> To see if it makes any difference to actually wait for the connected disks to
> resume correctly before doing the FLR.	

On my system, it takes about 50s for all disks to resume properly, so I waited
about 60s before doing FLR, and finally it looks like the revalidation is successful.

kernel message is as follows:
[root@localhost ~]# echo 1 > /sys/bus/pci/devices/0000:b4:02.0/reset
[  320.872531] hisi_sas_v3_hw 0000:b4:02.0: resuming from operating state [D0]
[  322.112424] hisi_sas_v3_hw 0000:b4:02.0: waiting up to 25 seconds for 7 phys to resume
[  322.112974] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy7 link_rate=10(sata)
[  322.127517] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy0 link_rate=10(sata)
[  322.127530] hisi_sas_v3_hw 0000:b4:02.0: dev[8:5] found
[  322.127727] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy5 link_rate=10(sata)
[  322.128053] hisi_sas_v3_hw 0000:b4:02.0: dev[9:5] found
[  322.128062] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  322.128074] sas: ata5: end_device-6:0: dev error handler
[  322.128079] sas: ata6: end_device-6:1: dev error handler
[  322.128083] sas: ata7: end_device-6:2: dev error handler
[  322.128086] sas: ata8: end_device-6:3: dev error handler
[  322.128088] sas: ata10: end_device-6:5: dev error handler
[  322.128087] sas: ata9: end_device-6:4: dev error handler
[  322.128321] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy6 link_rate=10(sata)
[  322.128557] hisi_sas_v3_hw 0000:b4:02.0: dev[10:5] found
[  322.128729] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy7 phy_state=0x61
[  322.128922] hisi_sas_v3_hw 0000:b4:02.0: dev[11:5] found
[  322.129113] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy7 down
[  322.221484] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy1 link_rate=10(sata)
[  322.228246] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy3 link_rate=11
[  322.228253] hisi_sas_v3_hw 0000:b4:02.0: dev[12:5] found
[  322.228425] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy4 link_rate=10(sata)
[  322.246798] hisi_sas_v3_hw 0000:b4:02.0: dev[13:1] found
[  322.252300] hisi_sas_v3_hw 0000:b4:02.0: dev[14:5] found
[  322.252309] hisi_sas_v3_hw 0000:b4:02.0: end of resuming controller	------> 60s wait starts
[  322.285369] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy7 link_rate=10(sata)
[  322.292150] sas: sas_form_port: phy7 belongs to port0 already(1)!
[  322.454227] ata5.00: configured for UDMA/133
[  322.458896] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  322.468976] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  322.476376] sas: ata5: end_device-6:0: dev error handler
[  322.476380] sas: ata6: end_device-6:1: dev error handler
[  322.476385] sas: ata7: end_device-6:2: dev error handler
[  322.476387] sas: ata8: end_device-6:3: dev error handler
[  322.476391] sas: ata10: end_device-6:5: dev error handler
[  322.476390] sas: ata9: end_device-6:4: dev error handler
[  322.512627] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy0 phy_state=0xfa
[  322.519225] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy0 down
[  322.696838] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy0 link_rate=10(sata)
[  322.703610] sas: sas_form_port: phy0 belongs to port2 already(1)!
[  327.884363] ata7.00: qc timeout after 5000 msecs (cmd 0x27)
[  330.774555] ata7.00: failed to read native max address (err_mask=0x4)
[  330.784372] ata7.00: HPA support seems broken, skipping HPA handling
[  330.790898] ata7.00: revalidation failed (errno=-5)
[  330.796785] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy0 phy_state=0xfa
[  330.803408] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy0 down
[  331.190903] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy0 link_rate=10(sata)
[  331.197699] sas: sas_form_port: phy0 belongs to port2 already(1)!
[  331.358141] ata7.00: configured for UDMA/100
[  331.366659] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  331.376728] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  331.384382] sas: ata5: end_device-6:0: dev error handler
[  331.384388] sas: ata6: end_device-6:1: dev error handler
[  331.384393] sas: ata7: end_device-6:2: dev error handler
[  331.384398] sas: ata8: end_device-6:3: dev error handler
[  331.384402] sas: ata9: end_device-6:4: dev error handler
[  331.384403] sas: ata10: end_device-6:5: dev error handler
[  331.417834] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy5 phy_state=0xdb
[  331.424468] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy5 down
[  331.578409] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy5 link_rate=10(sata)
[  331.585200] sas: sas_form_port: phy5 belongs to port1 already(1)!
[  331.755728] ata6.00: configured for UDMA/133
[  331.764497] ata6.00: Entering active power mode
[  341.964384] ata6.00: qc timeout after 10000 msecs (cmd 0x40)
[  344.874106] ata6.00: VERIFY failed (err_mask=0x4)
[  344.880648] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy5 phy_state=0xdb
[  344.887617] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy5 down
[  345.048407] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy5 link_rate=10(sata)
[  345.055238] sas: sas_form_port: phy5 belongs to port1 already(1)!
[  345.224989] ata6.00: configured for UDMA/133
[  345.232464] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  345.242523] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  345.252377] sas: ata5: end_device-6:0: dev error handler
[  345.252381] sas: ata6: end_device-6:1: dev error handler
[  345.252386] sas: ata7: end_device-6:2: dev error handler
[  345.252391] sas: ata8: end_device-6:3: dev error handler
[  345.252396] sas: ata9: end_device-6:4: dev error handler
[  345.252397] sas: ata10: end_device-6:5: dev error handler
[  345.252608] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy6 phy_state=0xbb
[  345.252612] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy6 down
[  345.424843] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy6 link_rate=10(sata)
[  345.431625] sas: sas_form_port: phy6 belongs to port3 already(1)!
[  350.668364] ata8.00: qc timeout after 5000 msecs (cmd 0x27)
[  353.731804] ata8.00: failed to read native max address (err_mask=0x4)
[  353.740363] ata8.00: HPA support seems broken, skipping HPA handling
[  353.746961] ata8.00: revalidation failed (errno=-5)
[  353.752314] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy6 phy_state=0xbb
[  353.759186] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy6 down
[  354.156360] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy6 link_rate=10(sata)
[  354.163189] sas: sas_form_port: phy6 belongs to port3 already(1)!
[  354.330161] ata8.00: configured for UDMA/100
[  354.338661] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  354.348719] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  354.356381] sas: ata5: end_device-6:0: dev error handler
[  354.356387] sas: ata6: end_device-6:1: dev error handler
[  354.356393] sas: ata7: end_device-6:2: dev error handler
[  354.356398] sas: ata8: end_device-6:3: dev error handler
[  354.356403] sas: ata10: end_device-6:5: dev error handler
[  354.356403] sas: ata9: end_device-6:4: dev error handler
[  354.389685] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy1 phy_state=0xf9
[  354.396304] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy1 down
[  354.579128] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy1 link_rate=10(sata)
[  354.585924] sas: sas_form_port: phy1 belongs to port5 already(1)!
[  362.320531] ata10.00: configured for UDMA/133
[  362.328435] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  362.338494] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  362.348383] sas: ata5: end_device-6:0: dev error handler
[  362.348387] sas: ata6: end_device-6:1: dev error handler
[  362.348392] sas: ata7: end_device-6:2: dev error handler
[  362.348397] sas: ata8: end_device-6:3: dev error handler
[  362.348401] sas: ata9: end_device-6:4: dev error handler
[  362.348401] sas: ata10: end_device-6:5: dev error handler
[  362.348631] hisi_sas_v3_hw 0000:b4:02.0: phydown: phy4 phy_state=0xeb
[  362.348635] hisi_sas_v3_hw 0000:b4:02.0: ignore flutter phy4 down
[  362.531118] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy4 link_rate=10(sata)
[  362.537917] sas: sas_form_port: phy4 belongs to port4 already(1)!
[  370.299911] ata9.00: configured for UDMA/133
[  370.308446] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  382.412358] hisi_sas_v3_hw 0000:b4:02.0: FLR prepare			------> 60s wait ends
[  384.873251] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy7 link_rate=10(sata)
[  384.880073] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy5 link_rate=10(sata)
[  384.880081] sas: sas_form_port: phy7 belongs to port0 already(1)!
[  384.884906] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy0 link_rate=10(sata)
[  384.887280] sas: sas_form_port: phy5 belongs to port1 already(1)!
[  384.887565] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy6 link_rate=10(sata)
[  384.887903] sas: sas_form_port: phy0 belongs to port2 already(1)!
[  384.903979] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy1 link_rate=10(sata)
[  384.907420] sas: sas_form_port: phy6 belongs to port3 already(1)!
[  384.907804] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy4 link_rate=10(sata)
[  384.908202] sas: sas_form_port: phy1 belongs to port5 already(1)!
[  384.946977] sas: sas_form_port: phy4 belongs to port4 already(1)!
[  384.951984] hisi_sas_v3_hw 0000:b4:02.0: phyup: phy3 link_rate=11
[  384.968358] sas: sas_form_port: phy3 belongs to port6 already(1)!
[  385.030251] hisi_sas_v3_hw 0000:b4:02.0: FLR done
[  388.662363] hisi_sas_v3_hw 0000:b4:02.0: entering suspend state
[  389.079453] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  389.085530] sas: ata5: end_device-6:0: dev error handler
[  389.085535] sas: ata6: end_device-6:1: dev error handler
[  389.085538] sas: ata7: end_device-6:2: dev error handler
[  389.085542] sas: ata8: end_device-6:3: dev error handler
[  389.085548] sas: ata10: end_device-6:5: dev error handler
[  389.085547] sas: ata9: end_device-6:4: dev error handler
[  389.085799] sas: lldd_execute_task returned: -22
[  389.124371] ata5.00: Check power mode failed (err_mask=0x40)
[  389.130250] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  389.140306] hisi_sas_v3_hw 0000:b4:02.0: dev[8:5] is gone
[  389.148375] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  389.154605] sas: ata5: end_device-6:0: dev error handler
[  389.154610] sas: ata6: end_device-6:1: dev error handler
[  389.154615] sas: ata7: end_device-6:2: dev error handler
[  389.154620] sas: ata8: end_device-6:3: dev error handler
[  389.154621] sas: ata9: end_device-6:4: dev error handler
[  389.154624] sas: ata10: end_device-6:5: dev error handler
[  389.188449] sas: lldd_execute_task returned: -22
[  389.193265] ata6.00: Check power mode failed (err_mask=0x40)
[  389.199101] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  389.209155] hisi_sas_v3_hw 0000:b4:02.0: dev[10:5] is gone
[  389.216375] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  389.222612] sas: ata5: end_device-6:0: dev error handler
[  389.222616] sas: ata6: end_device-6:1: dev error handler
[  389.222620] sas: ata7: end_device-6:2: dev error handler
[  389.222624] sas: ata8: end_device-6:3: dev error handler
[  389.222628] sas: lldd_execute_task returned: -22
[  389.222628] sas: ata9: end_device-6:4: dev error handler
[  389.222629] sas: ata10: end_device-6:5: dev error handler
[  389.222631] ata7.00: Check power mode failed (err_mask=0x40)
[  389.266550] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  389.282963] hisi_sas_v3_hw 0000:b4:02.0: dev[9:5] is gone
[  389.292377] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  389.298581] sas: ata5: end_device-6:0: dev error handler
[  389.298585] sas: ata6: end_device-6:1: dev error handler
[  389.298589] sas: ata7: end_device-6:2: dev error handler
[  389.298593] sas: ata8: end_device-6:3: dev error handler
[  389.298594] sas: ata9: end_device-6:4: dev error handler
[  389.298595] sas: ata10: end_device-6:5: dev error handler
[  389.298599] sas: lldd_execute_task returned: -22
[  389.298603] ata8.00: Check power mode failed (err_mask=0x40)
[  389.342460] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  389.358932] hisi_sas_v3_hw 0000:b4:02.0: dev[11:5] is gone
[  389.368379] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  389.374656] sas: ata5: end_device-6:0: dev error handler
[  389.374661] sas: ata6: end_device-6:1: dev error handler
[  389.374666] sas: ata7: end_device-6:2: dev error handler
[  389.374671] sas: ata8: end_device-6:3: dev error handler
[  389.374671] sas: ata9: end_device-6:4: dev error handler
[  389.374674] sas: ata10: end_device-6:5: dev error handler
[  389.374676] sas: lldd_execute_task returned: -22
[  389.374678] ata9.00: Check power mode failed (err_mask=0x40)
[  389.418651] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  389.435009] hisi_sas_v3_hw 0000:b4:02.0: dev[14:5] is gone
[  389.444379] sas: Enter sas_scsi_recover_host busy: 0 failed: 0
[  389.450645] sas: ata5: end_device-6:0: dev error handler
[  389.450651] sas: ata6: end_device-6:1: dev error handler
[  389.450656] sas: ata7: end_device-6:2: dev error handler
[  389.450660] sas: ata8: end_device-6:3: dev error handler
[  389.450664] sas: ata10: end_device-6:5: dev error handler
[  389.450664] sas: ata9: end_device-6:4: dev error handler
[  389.450668] sas: lldd_execute_task returned: -22
[  389.450670] ata10.00: Check power mode failed (err_mask=0x40)
[  389.494657] sas: --- Exit sas_scsi_recover_host: busy: 0 failed: 0 tries: 1
[  389.510999] hisi_sas_v3_hw 0000:b4:02.0: dev[12:5] is gone
[  389.520363] hisi_sas_v3_hw 0000:b4:02.0: dev[13:1] is gone
[  389.526056] hisi_sas_v3_hw 0000:b4:02.0: end of suspending controller

Yihang

> 

