Return-Path: <linux-pci+bounces-42685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 75492CA76C1
	for <lists+linux-pci@lfdr.de>; Fri, 05 Dec 2025 12:33:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DBAE4362B54D
	for <lists+linux-pci@lfdr.de>; Fri,  5 Dec 2025 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567873469F5;
	Fri,  5 Dec 2025 08:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="Le2aIywW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731115.qiye.163.com (mail-m19731115.qiye.163.com [220.197.31.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A663533EAFF
	for <linux-pci@vger.kernel.org>; Fri,  5 Dec 2025 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.115
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764922026; cv=none; b=V8xVLaFMJxuWkAbFWVTSSHcAJ9oAuHS4oQvvcPGMbMEjszl9w7Orkrh4IGVIh4CLPHFlSLbvylsT7ir3LJINzuf+LV6bYpE6BC/DJIhoTZseLXfvhahAzI1NQVINKnP3mFdT1CwxMoeppeKayxOPwWx/CoT0oKm6g/Yxql0M+KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764922026; c=relaxed/simple;
	bh=7j4H05TorvxkdY34RqxVUrXKrsx2EyEpYf6gsywsA64=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=czzmUxx0q1EjID5qAzYKbhde4OqHb0M+LaABRkBKijCxkj3GZifO/B4vgZyCiLhuuPijlXIr3EgOydV6Orkh8qfqIfIkVqKq3/NZUNHpc+SPU/z8Ln1RKE5hZDgZTfNMSUQ0GiSvjKtMmKBJzYVHHHc2rjoIvypn9THYNiJiCNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=Le2aIywW; arc=none smtp.client-ip=220.197.31.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2c1c00fbe;
	Fri, 5 Dec 2025 15:31:27 +0800 (GMT+08:00)
Message-ID: <0a4e73d2-a474-493d-8827-8e4b46fd7081@rock-chips.com>
Date: Fri, 5 Dec 2025 15:31:25 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: RFC: Is pci_wake_from_d3(true) allowed to be called in EP
 drivers' .shutdown()?
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
References: <a6dae914-972e-45c4-90be-b52615edafa4@rock-chips.com>
 <5fbf0df7-4835-4765-9cdd-36e252f166cb@oss.qualcomm.com>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <5fbf0df7-4835-4765-9cdd-36e252f166cb@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9aed6c441b09cckunmd22d2441b8d753
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh1JSVZJSEofT05MTUoZGBpWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=Le2aIywWq2bwd6eZCWL/06H0ql5RaUGCDw/8MNy9GVNeNEwm/m2IolhMfmdiOrRFXSrkd9JUsqvyhjDhWAAxR3P7rJvD3LEQIxpYtFTHzYhDRz4s1+7lL2/cxN6Jj7KJmM9KTspiC9AjubGfoTl11+3j9cgUuan9llN1BdZ66Qk=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=KQPUlV6M1na/NozU9MOD0ei79QG8Cy3jCTKY2Q45bbM=;
	h=date:mime-version:subject:message-id:from;

Hi Krishna,

在 2025/12/05 星期五 11:42, Krishna Chaitanya Chundru 写道:
> 
> 
> On 12/4/2025 6:56 PM, Shawn Lin wrote:
>> Hi folks,
>>
>> I ran into an occasional system hang when adding .shutdown() support 
>> to pcie-dw-rockchip.c. Here's what I found.
>>
>> The Problem:
>>
>> During shutdown, my system would sometimes just hang. The call trace 
>> shows a race between a NIC driver's shutdown and the PCIe host 
>> driver's shutdown.
>>
>> What's Happening:
>>
>> My NIC driver (like r8168) calls pci_wake_from_d3(pdev, true)in 
>> its .shutdown().
>>
>> This eventually queues a delayed work with a 1-second delay 
>> (queue_delayed_work(pci_pme_work, PME_TIMEOUT)).
>>
>> pci_wake_from_d3(pdev, true)
>>      -> pci_enable_wake(true)
>>        -> __pci_enable_wake(true)
>>          -> pci_pme_active(dev, true)
>>            -> queue_delayed_work(pci_pme_work, PME_TIMEOUT) #1 second
>>
>> After the NIC driver finishes, the PCIe host driver's .shutdown() 
>> kicks in. It starts cleaning up – gating clocks, powering down the IP, 
>> etc.
>>
>> The Race:​ If that 1-second delayed work runs after the host 
>> controller has begun its cleanup, it tries to read the PCI config 
>> space. But the hardware might already be partially down, causing a hang.
> As you are keeping PCIe link in D3cold, you should inform PCI framework 
> that you are keeping link in D3cold whether you are in shutdown call or 
> normal call.
> Before gatting clocks and powering down the IP inform the PCI framework 
> that you are going to D3cold by updating the Dstate to D3cold with this API
> pci_bus_set_current_state(pp->bridge->bus, PCI_D3cold);


Good point. Indeed, none of the existing native PCIe host drivers call 
this function in their .shutdown()path. But as they break the link, the 
common issue likely exists. Thanks for the suggestion, I'll investigate 
this.

> 
> - Krishna Chaitanya.
>>
>> Here are the actual logs from a hung system showing the two sides of 
>> the race:
>>
>> Log 1: NIC driver setting up the work during shutdown
>>
>> [ 49.961836][ T1] Hardware name: Rockchip RK3588 Decenta OPS C41 V10 
>> Board (DT)
>> [ 49.962494][ T1] Call trace:
>> [ 49.962782][ T1] dump_backtrace+0xf4/0x114
>> [ 49.963188][ T1] show_stack+0x18/0x24
>> [ 49.963555][ T1] dump_stack_lvl+0x6c/0x90
>> [ 49.963945][ T1] dump_stack+0x18/0x38
>> [ 49.964301][ T1] pci_pme_active+0x80/0x1dc
>> [ 49.964701][ T1] pci_wake_from_d3+0xc8/0x100
>> [ 49.965111][ T1] rtl8168_shutdown+0x15c/0x194 [r8168]
>> [ 49.965705][ T1] pci_device_shutdown+0x34/0x44
>> [ 49.966138][ T1] device_shutdown+0x164/0x21c
>> [ 49.966551][ T1] kernel_power_off+0x3c/0x14c
>> [ 49.966961][ T1] __arm64_sys_reboot+0x268/0x270
>> [ 49.967391][ T1] invoke_syscall+0x40/0x104
>> [ 49.967791][ T1] el0_svc_common+0xb8/0x164
>> [ 49.968190][ T1] do_el0_svc+0x1c/0x28
>> [ 49.968556][ T1] el0_svc+0x1c/0x48
>> [ 49.968890][ T1] el0t_64_sync_handler+0x68/0xb4
>> [ 49.969320][ T1] el0t_64_sync+0x164/0x168
>>
>> Log 2: The delayed work trying to run after host cleanup, causing the 
>> hang
>>
>> [ 51.258983][ T1] Call trace:
>> [ 51.259261][ T1] dump_backtrace+0xf4/0x114
>> [ 51.259663][ T1] show_stack+0x18/0x24
>> [ 51.260020][ T1] dump_stack_lvl+0x6c/0x90
>> [ 51.260409][ T1] dump_stack+0x18/0x38
>> [ 51.260764][ T1] pci_generic_config_read+0x30/0xd0
>> [ 51.261229][ T1] dw_pcie_rd_other_conf+0x18/0x5c
>> [ 51.261673][ T1] pci_bus_read_config_word+0x74/0xd4
>> [ 51.262136][ T1] pci_read_config_word+0x40/0x4c
>> [ 51.262568][ T1] pci_pme_list_scan+0xd8/0x180
>> [ 51.262989][ T1] process_one_work+0x1a8/0x3b8
>> [ 51.263411][ T1] worker_thread+0x24c/0x420
>> [ 51.263810][ T1] kthread+0xe8/0x1b4
>> [ 51.264156][ T1] ret_from_fork+0x10/0x20
>>
>>
>> This seems common as I found several upstream  PCI NIC drivers that call
>> pci_wake_from_d3 during shutdown (like in igb_main.c, i40e_main.c, 
>> atl1.c). Also, 7 other PCIe host drivers already implement .shutdown. 
>> For example, pci-imx6.cresets the controller in its shutdown – I'm not 
>> sure what happens on imx platforms, but it definitely causes hangs on 
>> Rockchip.
>>
>> My main question is:
>>
>> Is it really a good idea for NIC drivers to call 
>> pci_wake_from_d3(true) in .shutdown()? This queues a delayed work that 
>> needs to access PCI config space, but the host controller might be 
>> shutting down at the same time. This feels like a risky pattern. Are 
>> these drivers doing the right thing? Or should this wake-up setup 
>> happen differently to avoid this race?
>>
>> Would love to hear your thoughts on how to properly fix this.
>>
> 
> 


