Return-Path: <linux-pci+bounces-14236-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DDE1F99943D
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 23:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 618E81F28634
	for <lists+linux-pci@lfdr.de>; Thu, 10 Oct 2024 21:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539961CF2A6;
	Thu, 10 Oct 2024 21:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Y5xNwFL4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A1A1E2841;
	Thu, 10 Oct 2024 21:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728594305; cv=none; b=OzQGsvQNqLaRXa84aOu0DG/LLOumdC17Z0MMyLzUVgg7lGrNTGK+KfpFDn5YerMiX8hBTuJo1CyXFBkdyhsmVsBkMESRjr87G1k7GicCKp+r6Ww+iANRmE7ZKRffzMrjtoJ4nnBZ1pd0YrwbIIRuzYvgVtuYfoDlpdGZdgN18U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728594305; c=relaxed/simple;
	bh=OGCdjb0PviudeTxSwRVQK+kJU3rbpW/ts2cXnqwwQVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WrMtBuYypG7QuAOHm2FRRR9InrFXS6ZjQmTwvWiL6sZj9zph5ErX9xLDMbIVgIQqn5sXHQukLhmBtgG3wzPUm1GFMQau+vpcSjnm18Hvl9T0gkmCaKNf0pBTd7WOFxcvxGleizGN9xGyWNq49LK31DImYFthXFVwqRQibfnlKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Y5xNwFL4; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49ACZX5K026260;
	Thu, 10 Oct 2024 21:04:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Zyykvm6pDNn59OvYkBeV7aVW15zLbT44lNfkqVNpQvU=; b=Y5xNwFL4etlgUA3P
	lI0kpqLKERknG+BrHdIQQaDsO771Xz328hJFdbY38LC1CnMyuMPDqLea/VkXd9Uz
	eWCcsTGo9N86IQRCqz7/DG6Q0SPQNCTe/nt4eCy8QjTM28QPoW+hJOKLmjwDJ7pK
	aKrO8+Ioi9QtlVF6wp4kfAKZJNFeQtuI4Le50FDM3/oFD4NgL38R/YmpgF098MHy
	yJ45HLLDWV6Du7Jp+szXBzKuckiHPnqKefXTV00zwsLUMjWy1wqnlsSNExPnYmFN
	m5woNLsRAdwhog20GkYQ+NoDlwAUKcv/N/Fc6MSoYED1+z7aEVlLmt0xOFFO7k6V
	NNEakg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 425c8qy3n8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 21:04:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49AL4fAl000921
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Oct 2024 21:04:41 GMT
Received: from [10.110.112.240] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Thu, 10 Oct
 2024 14:04:40 -0700
Message-ID: <bb896e5d-cd92-41b1-af83-228461ab79ec@quicinc.com>
Date: Thu, 10 Oct 2024 14:04:40 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: starfive: Enable PCIe controller's PM runtime before
 probing host bridge
To: Bjorn Helgaas <helgaas@kernel.org>
CC: <kevin.xie@starfivetech.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_krichai@quicinc.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
References: <20241010205230.GA577266@bhelgaas>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20241010205230.GA577266@bhelgaas>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 9J5UDBdJ3m9j8UPu1qydWlv-EV3FhoZY
X-Proofpoint-ORIG-GUID: 9J5UDBdJ3m9j8UPu1qydWlv-EV3FhoZY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 phishscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410100138

Hi Bjorn

On 10/10/2024 1:52 PM, Bjorn Helgaas wrote:
> On Thu, Oct 10, 2024 at 01:29:50PM -0700, Mayank Rana wrote:
>> Commit 02787a3b4d10 ("PCI/PM: Enable runtime power management for host
>> bridges") enables runtime PM for host bridge enforcing dependency chain
>> between PCIe controller, host bridge and endpoint devices. With this,
>> Starfive PCIe controller driver's probe enables host bridge (child device)
>> PM runtime before parent's PM runtime (Starfive PCIe controller device)
>> causing below warning and callstack:
> 
> I don't want the bisection hole that would result if we kept
> 02787a3b4d10 ("PCI/PM: Enable runtime power management for host
> bridges") and applied this patch on top of it.
> 
> If this is the fix, we'll apply it *first*, followed by 02787a3b4d10
> (which will obviously become a different commit), so the locking
> problem below described below should never exist in -next or the
> upstream tree.
> 
> So we need to audit other drivers to make sure they don't have the
> same problem as starfive, then make a series with this patch and any
> others that need similar fixes, followed by the "PCI/PM: Enable
> runtime power management for host bridges" patch.
> 
> Presumably this patch fixes a problem all by itself, even without
> considering 02787a3b4d10, so the commit message should describe that
> problem.

Ok. Thank you for quick response and above suggestion.
I shall reword this patch commit text, and resend it.

Regards,
Mayank
>> pcie-starfive 940000000.pcie: Enabling runtime PM for inactive device
>> with active children
>>
>> ======================================================
>> WARNING: possible circular locking dependency detected
>> 6.12.0-rc1+ #15438 Not tainted
>> ------------------------------------------------------
>> systemd-udevd/159 is trying to acquire lock:
>> ffffffff81822520 (console_owner){-.-.}-{0:0}, at:
>> console_lock_spinning_enable+0x3a/0x60
>>
>> but task is already holding lock:
>> ffffffd6c0b3d980 (&dev->power.lock){-...}-{2:2}, at:
>> pm_runtime_enable+0x1e/0xb6
>>
>> which lock already depends on the new lock.
>>
>> the existing dependency chain (in reverse order) is:
>>
>> -> #2 (&dev->power.lock){-...}-{2:2}:
>>          lock_acquire.part.0+0xa2/0x1d4
>>          lock_acquire+0x44/0x5a
>>          _raw_spin_lock_irqsave+0x3a/0x64
>>          __pm_runtime_resume+0x40/0x86
>>          __uart_start+0x40/0xb2
>>          uart_write+0x90/0x220
>>          n_tty_write+0x10a/0x40e
>>          file_tty_write.constprop.0+0x10c/0x230
>>          redirected_tty_write+0x84/0xbc
>>          do_iter_readv_writev+0x100/0x166
>>          vfs_writev+0xc6/0x398
>>          do_writev+0x5c/0xca
>>          __riscv_sys_writev+0x16/0x1e
>>          do_trap_ecall_u+0x1b6/0x1e2
>>          _new_vmalloc_restore_context_a0+0xc2/0xce
>>
>> -> #1 (&port_lock_key){-.-.}-{2:2}:
>>          lock_acquire.part.0+0xa2/0x1d4
>>          lock_acquire+0x44/0x5a
>>          _raw_spin_lock_irqsave+0x3a/0x64
>>          serial8250_console_write+0x2a0/0x474
>>          univ8250_console_write+0x22/0x2a
>>          console_flush_all+0x2f6/0x3c8
>>          console_unlock+0x80/0x1a8
>>          vprintk_emit+0x10e/0x2e0
>>          vprintk_default+0x16/0x1e
>>          vprintk+0x1e/0x3c
>>          _printk+0x36/0x50
>>          register_console+0x292/0x418
>>          serial_core_register_port+0x6d6/0x6dc
>>          serial_ctrl_register_port+0xc/0x14
>>          uart_add_one_port+0xc/0x14
>>          serial8250_register_8250_port+0x288/0x428
>>          dw8250_probe+0x422/0x518
>>          platform_probe+0x4e/0x92
>>          really_probe+0x10a/0x2da
>>          __driver_probe_device.part.0+0xb2/0xe8
>>          driver_probe_device+0x78/0xc4
>>          __device_attach_driver+0x66/0xc6
>>          bus_for_each_drv+0x5c/0xb0
>>          __device_attach+0x84/0x13c
>>          device_initial_probe+0xe/0x16
>>          bus_probe_device+0x88/0x8a
>>          deferred_probe_work_func+0xd4/0xee
>>          process_one_work+0x1e0/0x534
>>          worker_thread+0x166/0x2cc
>>          kthread+0xc4/0xe0
>>          ret_from_fork+0xe/0x18
>>
>> -> #0 (console_owner){-.-.}-{0:0}:
>>          check_noncircular+0x10e/0x122
>>          __lock_acquire+0x105c/0x1f4a
>>          lock_acquire.part.0+0xa2/0x1d4
>>          lock_acquire+0x44/0x5a
>>          console_lock_spinning_enable+0x58/0x60
>>          console_flush_all+0x2cc/0x3c8
>>          console_unlock+0x80/0x1a8
>>          vprintk_emit+0x10e/0x2e0
>>          dev_vprintk_emit+0xea/0x112
>>          dev_printk_emit+0x2e/0x48
>>          __dev_printk+0x40/0x5c
>>          _dev_warn+0x46/0x60
>>          pm_runtime_enable+0x98/0xb6
>>          starfive_pcie_probe+0x12e/0x228 [pcie_starfive]
>>          platform_probe+0x4e/0x92
>>          really_probe+0x10a/0x2da
>>          __driver_probe_device.part.0+0xb2/0xe8
>>          driver_probe_device+0x78/0xc4
>>          __driver_attach+0x54/0x162
>>          bus_for_each_dev+0x58/0xa4
>>          driver_attach+0x1a/0x22
>>          bus_add_driver+0xec/0x1ce
>>          driver_register+0x3e/0xd8
>>          __platform_driver_register+0x1c/0x24
>>          starfive_pcie_driver_init+0x20/0x1000 [pcie_starfive]
>>          do_one_initcall+0x5e/0x28c
>>          do_init_module+0x52/0x1ba
>>          load_module+0x1440/0x18f0
>>          init_module_from_file+0x76/0xae
>>          idempotent_init_module+0x18c/0x24a
>>          __riscv_sys_finit_module+0x52/0x82
>>          do_trap_ecall_u+0x1b6/0x1e2
>>          _new_vmalloc_restore_context_a0+0xc2/0xce
>>
>> other info that might help us debug this:
>>
>> Chain exists of:
>>     console_owner --> &port_lock_key --> &dev->power.lock
>>
>>    Possible unsafe locking scenario:
>>
>>          CPU0                    CPU1
>>          ----                    ----
>>     lock(&dev->power.lock);
>>                                  lock(&port_lock_key);
>>                                  lock(&dev->power.lock);
>>     lock(console_owner);
>>
>>    *** DEADLOCK ***
>>
>> 4 locks held by systemd-udevd/159:
>>    #0: ffffffd6c0b3d8f8 (&dev->mutex){....}-{3:3}, at:
>> __driver_attach+0x4c/0x162
>>    #1: ffffffd6c0b3d980 (&dev->power.lock){-...}-{2:2}, at:
>> pm_runtime_enable+0x1e/0xb6
>>    #2: ffffffff818223b0 (console_lock){+.+.}-{0:0}, at:
>> dev_vprintk_emit+0xea/0x112
>>    #3: ffffffff81822448 (console_srcu){....}-{0:0}, at:
>> console_flush_all+0x4e/0x3c8
>>
>> stack backtrace:
>> CPU: 1 UID: 0 PID: 159 Comm: systemd-udevd Not tainted 6.12.0-rc1+ #15438
>> Hardware name: StarFive VisionFive 2 v1.2A (DT)
>> Call Trace:
>> [<ffffffff80006a02>] dump_backtrace+0x1c/0x24
>> [<ffffffff80b70b3e>] show_stack+0x2c/0x38
>> [<ffffffff80b7f8f8>] dump_stack_lvl+0x7a/0xb4
>> [<ffffffff80b7f946>] dump_stack+0x14/0x1c
>> [<ffffffff8007fbc2>] print_circular_bug+0x2aa/0x350
>> [<ffffffff8007fd76>] check_noncircular+0x10e/0x122
>> [<ffffffff80082a3c>] __lock_acquire+0x105c/0x1f4a
>> [<ffffffff80084148>] lock_acquire.part.0+0xa2/0x1d4
>> [<ffffffff800842be>] lock_acquire+0x44/0x5a
>> [<ffffffff8008b3e8>] console_lock_spinning_enable+0x58/0x60
>> [<ffffffff8008c0c2>] console_flush_all+0x2cc/0x3c8
>> [<ffffffff8008c23e>] console_unlock+0x80/0x1a8
>> [<ffffffff8008c710>] vprintk_emit+0x10e/0x2e0
>> [<ffffffff80b79ec8>] dev_vprintk_emit+0xea/0x112
>> [<ffffffff80b79f1e>] dev_printk_emit+0x2e/0x48
>> [<ffffffff80b7a006>] __dev_printk+0x40/0x5c
>> [<ffffffff80b7a2be>] _dev_warn+0x46/0x60
>> [<ffffffff807037ae>] pm_runtime_enable+0x98/0xb6
>> [<ffffffff02763240>] starfive_pcie_probe+0x12e/0x228 [pcie_starfive]
>> [<ffffffff806f83f6>] platform_probe+0x4e/0x92
>> [<ffffffff80b7a680>] really_probe+0x10a/0x2da
>> [<ffffffff80b7a902>] __driver_probe_device.part.0+0xb2/0xe8
>> [<ffffffff806f6112>] driver_probe_device+0x78/0xc4
>> [<ffffffff806f6278>] __driver_attach+0x54/0x162
>> [<ffffffff806f42e6>] bus_for_each_dev+0x58/0xa4
>> [<ffffffff806f5c9e>] driver_attach+0x1a/0x22
>> [<ffffffff806f54ce>] bus_add_driver+0xec/0x1ce
>> [<ffffffff806f7112>] driver_register+0x3e/0xd8
>> [<ffffffff806f80cc>] __platform_driver_register+0x1c/0x24
>> [<ffffffff027ea020>] starfive_pcie_driver_init+0x20/0x1000 [pcie_starfive]
>> [<ffffffff800027ba>] do_one_initcall+0x5e/0x28c
>> [<ffffffff800bb4d8>] do_init_module+0x52/0x1ba
>> [<ffffffff800bcc8a>] load_module+0x1440/0x18f0
>> [<ffffffff800bd2f0>] init_module_from_file+0x76/0xae
>> [<ffffffff800bd4b4>] idempotent_init_module+0x18c/0x24a
>> [<ffffffff800bd5fc>] __riscv_sys_finit_module+0x52/0x82
>> [<ffffffff80b804a0>] do_trap_ecall_u+0x1b6/0x1e2
>> [<ffffffff80b8c536>] _new_vmalloc_restore_context_a0+0xc2/0xce
>>
>> Fix this issue by enabling starfive pcie controller device's PM runtime
>> status before calling into pci_host_probe() through plda_pcie_host_init().
>>
>> Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Fixes: 02787a3b4d10 ("PCI/PM: Enable runtime power management for host bridges")
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
>> ---
>>   drivers/pci/controller/plda/pcie-starfive.c | 10 +++++++---
>>   1 file changed, 7 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/pci/controller/plda/pcie-starfive.c b/drivers/pci/controller/plda/pcie-starfive.c
>> index 0567ec373a3e..e73c1b7bc8ef 100644
>> --- a/drivers/pci/controller/plda/pcie-starfive.c
>> +++ b/drivers/pci/controller/plda/pcie-starfive.c
>> @@ -404,6 +404,9 @@ static int starfive_pcie_probe(struct platform_device *pdev)
>>   	if (ret)
>>   		return ret;
>>   
>> +	pm_runtime_enable(&pdev->dev);
>> +	pm_runtime_get_sync(&pdev->dev);
>> +
>>   	plda->host_ops = &sf_host_ops;
>>   	plda->num_events = PLDA_MAX_EVENT_NUM;
>>   	/* mask doorbell event */
>> @@ -413,11 +416,12 @@ static int starfive_pcie_probe(struct platform_device *pdev)
>>   	plda->events_bitmap <<= PLDA_NUM_DMA_EVENTS;
>>   	ret = plda_pcie_host_init(&pcie->plda, &starfive_pcie_ops,
>>   				  &stf_pcie_event);
>> -	if (ret)
>> +	if (ret) {
>> +		pm_runtime_put_sync(&pdev->dev);
>> +		pm_runtime_disable(&pdev->dev);
>>   		return ret;
>> +	}
>>   
>> -	pm_runtime_enable(&pdev->dev);
>> -	pm_runtime_get_sync(&pdev->dev);
>>   	platform_set_drvdata(pdev, pcie);
>>   
>>   	return 0;
>> -- 
>> 2.25.1
>>

