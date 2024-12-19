Return-Path: <linux-pci+bounces-18765-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4AC9F79A2
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 11:29:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C922E160980
	for <lists+linux-pci@lfdr.de>; Thu, 19 Dec 2024 10:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EC1222257A;
	Thu, 19 Dec 2024 10:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="hc/NiKWE"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DFBE222570;
	Thu, 19 Dec 2024 10:29:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734604184; cv=none; b=hpSsb/REXGTcRrBNXMqpScIVjwMfyZGiSQbB8FeDYTaeR/n52+4irjzaSZgPCvOfewsP55zTH8YN8qRGrGPQ+thufMUetRIWl0MBvX59qqWSFXtkU5Ky+EwuBzcGZokreNREYAWDGaPuMsRmLCcH7Yzo+sZwP8Tv3MxABPxYlfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734604184; c=relaxed/simple;
	bh=jF12o2JOycZKwjEBvWucqkKiIlmqfyh//WAhIR2lFSs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=umuH4BMKmU9znvONlE8F39E1nb6rbdH9Bw+IB6KXGrFlaYadOHMo0x6gDTsIrH/aUGOj1vj2cw3KqXxf5lWhRuUL1/9L//yanvMkvCGZ2KxK+6WQZEgGs7SrpxkTbaaYLD/DMzrtdy+H6aJBHLK68HNUpHEXyh92/IdRPiJOp6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=hc/NiKWE; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=kjy5FafMGFO54fNVWaTOgwGx6EnFv4VhvWlZw59xeZg=;
	b=hc/NiKWEIF7MsZqaQ070CLhsZbYSvxiINwIDvsV7SflhTS7bVYgis8ftgdPhYk
	AzpagWPcBf4et4X1IQPdELIJNoEMkGFHy5y268XiMikCAdstMT6OAzkqs0n1GTil
	+gPy3v/8UZzjEw5s3c6vZ0w0tasryb9n0Hfi9XHGionvY=
Received: from [192.168.60.52] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wB3Zd1u9WNnXSHzAA--.9331S2;
	Thu, 19 Dec 2024 18:29:03 +0800 (CST)
Message-ID: <c16dc225-4116-c966-7278-cc645f16c8a4@163.com>
Date: Thu, 19 Dec 2024 05:29:01 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] PCI: cadence: Fixed cdns_pcie_host_link_setup return
 value.
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Siddharth Vadapalli <s-vadapalli@ti.com>, lpieralisi@kernel.org,
 kw@linux.com, robh@kernel.org, bhelgaas@google.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <20241219081452.32035-1-18255117159@163.com>
 <hldbrb5rgzwibq3xiak2qpy5jawsgmhwjxrhersjwfighljyim@noxzbf4cre3m>
 <999ad91d-9b61-b939-a043-4ab3f07c72a1@163.com>
 <v623jkaz4u4dpzlr5dtnjfolc5nk7az24aqhjth4lpjffen4ct@ypjekbr4o54q>
 <f2c8be62-7ff6-f0d0-f34a-ddb6915df0a4@163.com>
 <20241219094906.wzn7ripjxrvbmwbh@thinkpad>
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20241219094906.wzn7ripjxrvbmwbh@thinkpad>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wB3Zd1u9WNnXSHzAA--.9331S2
X-Coremail-Antispam: 1Uf129KBjvJXoW3AF1fArykAryDXF18uFW3ZFb_yoWxAF13pa
	yaqayvkr4kAw10krsFv3WjgF1IkFsYya98Xr9rK34Uuw1q9ry7tw42vrWYkas8Gw4kGr17
	tFWqqFWIqrWDAaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jDGYJUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwK6o2dj7vOjQQABsu



On 12/19/24 04:49, Manivannan Sadhasivam wrote:
> On Thu, Dec 19, 2024 at 04:38:11AM -0500, Hans Zhang wrote:
>>
>> On 12/19/24 03:59, Siddharth Vadapalli wrote:
>>> On Thu, Dec 19, 2024 at 03:49:33AM -0500, Hans Zhang wrote:
>>>> On 12/19/24 03:33, Siddharth Vadapalli wrote:
>>>>> On Thu, Dec 19, 2024 at 03:14:52AM -0500, Hans Zhang wrote:
>>>>>> If the PCIe link never came up, the enumeration process
>>>>>> should not be run.
>>>>> The link could come up at a later point in time. Please refer to the
>>>>> implementation of:
>>>>> dw_pcie_host_init() in drivers/pci/controller/dwc/pcie-designware-host.c
>>>>> wherein we have the following:
>>>>> 	/* Ignore errors, the link may come up later */
>>>>> 	dw_pcie_wait_for_link(pci);
>>>>>
>>>>> It seems to me that the logic behind ignoring the absence of the link
>>>>> within cdns_pcie_host_link_setup() instead of erroring out, is similar to
>>>>> that of dw_pcie_wait_for_link().
>>>>>
>>>>> Regards,
>>>>> Siddharth.
>>>>>
>>>>>
>>>>> If a PCIe port is not connected to a device. The PCIe link does not
>>>>> go up. The current code returns success whether the device is connected
>>>>> or not. Cadence IP's ECAM requires an LTSSM at L0 to access the RC's
>>>>> config space registers. Otherwise the enumeration process will hang.
>>> The ">" symbols seem to be manually added in your reply and are also
>>> incorrect. If you have added them manually, please don't add them at the
>>> start of the sentences corresponding to your reply.
>>>
>>> The issue you are facing seems to be specific to the Cadence IP or the way
>>> in which the IP has been integrated into the device that you are using.
>>> On TI SoCs which have the Cadence PCIe Controller, absence of PCIe devices
>>> doesn't result in a hang. Enumeration should proceed irrespective of the
>>> presence of PCIe devices and should indicate their absence when they aren't
>>> connected.
>>>
>>> While I am not denying the issue being seen, the fix should probably be
>>> done elsewhere.
>>>
>>> Regards,
>>> Siddharth.
>> We are the SOC design company and we have confirmed with the designer and
>> Cadence. For the Cadence's IP we are using, ECAM must be L0 at LTSSM to be
>> used. Cadence will fixed next RTL version.
>>
> 
> I don't understand what you mean by 'ECAM must be L0 at LTSSM'. If you do not
> connect the device, LTSSM would still be in 'detect' state until the device is
> connected. Is that different on your SoC?
> 
>> If the cdns_pcie_host_link_setup return value is not modified. The following
>> is the
>> log of the enumeration process without connected devices. There will be hang
>> for
>> more than 300 seconds. So I don't think it makes sense to run the
>> enumeration
>> process without connecting devices. And it will affect the boot time.
>>
> 
> We don't know your driver, so cannot comment on the issue without understanding
> the problem, sorry.
> 
> - Mani
> 
>> [ 2.681770] xxx pcie: xxx_pcie_probe starting!
>> [ 2.689537] xxx pcie: host bridge /soc@0/pcie@xxx ranges:
>> [ 2.698601] xxx pcie: IO 0x0060100000..0x00601fffff -> 0x0060100000
>> [ 2.708625] xxx pcie: MEM 0x0060200000..0x007fffffff -> 0x0060200000
>> [ 2.718649] xxx pcie: MEM 0x1800000000..0x1bffffffff -> 0x1800000000
>> [ 2.744441] xxx pcie: ioremap rcsu, paddr:[mem 0x0a000000-0x0a00ffff],
>> vaddr:ffff800089390000
>> [ 2.756230] xxx pcie: ioremap msg, paddr:[mem 0x60000000-0x600fffff],
>> vaddr:ffff800089800000
>> [ 2.769692] xxx pcie: ECAM at [mem 0x2c000000-0x2fffffff] for [bus c0-ff]
>> [ 2.780139] xxx.pcie_phy: pcie_phy_common_init end
>> [ 2.788900] xxx pcie: waiting PHY is ready! retries = 2
>> [ 3.905292] xxx pcie: Link fail, retries 10 times
>> [ 3.915054] xxx pcie: ret=-110, rc->quirk_retrain_flag = 0
>> [ 3.923848] xxx pcie: ret=-110, rc->quirk_retrain_flag = 0
>> [ 3.932669] xxx pcie: PCI host bridge to bus 0000:c0
>> [ 3.940847] pci_bus 0000:c0: root bus resource [bus c0-ff]
>> [ 3.948322] pci_bus 0000:c0: root bus resource [io 0x0000-0xfffff] (bus
>> address [0x60100000-0x601fffff])
>> [ 3.959922] pci_bus 0000:c0: root bus resource [mem 0x60200000-0x7fffffff]
>> [ 3.968799] pci_bus 0000:c0: root bus resource [mem
>> 0x1800000000-0x1bffffffff pref]
>> [ 339.667761] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
>> [ 339.677449] rcu: 5-...0: (20 ticks this GP) idle=4d94/1/0x4000000000000000
>> softirq=20/20 fqs=2623
>> [ 339.688184] (detected by 2, t=5253 jiffies, g=-1119, q=2 ncpus=12)
>> [ 339.696193] Sending NMI from CPU 2 to CPUs 5:
>> [ 349.703670] rcu: rcu_preempt kthread timer wakeup didn't happen for 2509
>> jiffies! g-1119 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
>> [ 349.718710] rcu: Possible timer handling issue on cpu=2 timer-softirq=1208
>> [ 349.727418] rcu: rcu_preempt kthread starved for 2515 jiffies! g-1119 f0x0
>> RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=2
>> [ 349.739642] rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM
>> is now expected behavior.
>> [ 349.750546] rcu: RCU grace-period kthread stack dump:
>> [ 349.757319] task:rcu_preempt state:I stack:0 pid:14 ppid:2
>> flags:0x00000008
>> [ 349.767439] Call trace:
>> [ 349.771575] __switch_to+0xdc/0x150
>> [ 349.776777] __schedule+0x2dc/0x7d0
>> [ 349.781972] schedule+0x5c/0x100
>> [ 349.786903] schedule_timeout+0x8c/0x100
>> [ 349.792538] rcu_gp_fqs_loop+0x140/0x420
>> [ 349.798176] rcu_gp_kthread+0x134/0x164
>> [ 349.803725] kthread+0x108/0x10c
>> [ 349.808657] ret_from_fork+0x10/0x20
>> [ 349.813942] rcu: Stack dump where RCU GP kthread last ran:
>> [ 349.821156] CPU: 2 PID: 0 Comm: swapper/2 Tainted: G S xxx-build-generic
>> #8
>> [ 349.831887] Hardware name: xxx Reference Board, BIOS xxx
>> [ 349.843583] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS
>> BTYPE=--)
>> [ 349.852294] pc : arch_cpu_idle+0x18/0x2c
>> [ 349.857928] lr : arch_cpu_idle+0x14/0x2c
>>
>> Regards Hans
>>
> 

I am very sorry that the previous email said that I included HTML 
format, so I resend it twice.


 > I don't understand what you mean by 'ECAM must be L0 at LTSSM'. If 
you do not
 > connect the device, LTSSM would still be in 'detect' state until the 
device is
 > connected. Is that different on your SoC?

If a PCIe port is not connected to a device. Then run pci_host_probe and 
perform the enumeration process. During the enumeration process, VID and 
PID are read. If the LTSSM is not in L0, the CPU send AXI transmission 
will not be sent, that is, the AXI slave will hang. This is the problem 
with the Cadence IP we are using.

Regards
Hans


