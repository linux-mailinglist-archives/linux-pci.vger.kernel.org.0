Return-Path: <linux-pci+bounces-42632-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2E4CA3DD1
	for <lists+linux-pci@lfdr.de>; Thu, 04 Dec 2025 14:42:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EA603303DDF1
	for <lists+linux-pci@lfdr.de>; Thu,  4 Dec 2025 13:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D885C33F8C4;
	Thu,  4 Dec 2025 13:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="RAxSh8WK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m15574.qiye.163.com (mail-m15574.qiye.163.com [101.71.155.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6818398F97
	for <linux-pci@vger.kernel.org>; Thu,  4 Dec 2025 13:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764855741; cv=none; b=M4pyOLwJMfbHzhLp3ayaMmPXS17IMX0RBDVl5aHAX/Zop7r4VOAX8S1pIwOJXcn+lfIRydfIK0Ct47cXnCbHzM0qxuJCymUS66AFDoNU/iwlYRW4oOopfivHsm2EZiEq3R81sVQzTDwwkKG/Ir7jsc956AiJtM+JD9Ib67nU2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764855741; c=relaxed/simple;
	bh=k/Msf9uf/vVGss6OXiYSSYR0hxK43g3j68LHqEzxrG8=;
	h=Message-ID:Date:MIME-Version:Cc:From:Subject:To:Content-Type; b=pV1VkT9lbQH3eJOI7UN367xWf12qq9fyx+oti9Yo52r4DlGEisTQ+KDzKkLom+VqkJ6XbMDc+l7sWMpQ+B758WJ1kbDe87vJjZjFj1ZYalfAOdhnWJeXmchZTLyM+CevyBo/xO/+S6J58reOP8pQ5ls9ijkyE27y18D0nynuJPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=RAxSh8WK; arc=none smtp.client-ip=101.71.155.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.14] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 2c013cb76;
	Thu, 4 Dec 2025 21:26:50 +0800 (GMT+08:00)
Message-ID: <a6dae914-972e-45c4-90be-b52615edafa4@rock-chips.com>
Date: Thu, 4 Dec 2025 21:26:48 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com,
 "open list:PCI NATIVE HOST BRIDGE AND ENDPOINT DRIVERS"
 <linux-pci@vger.kernel.org>
From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: RFC: Is pci_wake_from_d3(true) allowed to be called in EP drivers'
 .shutdown()?
To: Bjorn Helgaas <bhelgaas@google.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9ae98b486409cckunmcadc5ce6791b5a
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkwYGFZPTk8fT0JOH0NIQ0lWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=RAxSh8WKi++PZAXHGaPG1zjt55TFacrDOSlTx3+39tHbrvJAn+9zbtzOUWf2XzWdeYzEA3lQocH+u6z9kNJfT9kvriJJUWCXak8ahq0pXEtm41TRL0bBAorfR//HXfexnhTaPDaMcYkoyH9/R5o2qO3H/iMDmT6gegxe6qzZJko=; s=default; c=relaxed/relaxed; d=rock-chips.com; v=1;
	bh=+YV0DFHPA7tDn6HnPt4j+qY3X935C5mMGKW6U5/hhGs=;
	h=date:mime-version:subject:message-id:from;

Hi folks,

I ran into an occasional system hang when adding .shutdown() support to 
pcie-dw-rockchip.c. Here's what I found.

The Problem:

During shutdown, my system would sometimes just hang. The call trace 
shows a race between a NIC driver's shutdown and the PCIe host driver's 
shutdown.

What's Happening:

My NIC driver (like r8168) calls pci_wake_from_d3(pdev, true)in its 
.shutdown().

This eventually queues a delayed work with a 1-second delay 
(queue_delayed_work(pci_pme_work, PME_TIMEOUT)).

pci_wake_from_d3(pdev, true)
      -> pci_enable_wake(true)
        -> __pci_enable_wake(true)
          -> pci_pme_active(dev, true)
            -> queue_delayed_work(pci_pme_work, PME_TIMEOUT) #1 second

After the NIC driver finishes, the PCIe host driver's .shutdown() kicks 
in. It starts cleaning up – gating clocks, powering down the IP, etc.

The Race:​ If that 1-second delayed work runs after the host controller 
has begun its cleanup, it tries to read the PCI config space. But the 
hardware might already be partially down, causing a hang.

Here are the actual logs from a hung system showing the two sides of the 
race:

Log 1: NIC driver setting up the work during shutdown

[ 49.961836][ T1] Hardware name: Rockchip RK3588 Decenta OPS C41 V10 
Board (DT)
[ 49.962494][ T1] Call trace:
[ 49.962782][ T1] dump_backtrace+0xf4/0x114
[ 49.963188][ T1] show_stack+0x18/0x24
[ 49.963555][ T1] dump_stack_lvl+0x6c/0x90
[ 49.963945][ T1] dump_stack+0x18/0x38
[ 49.964301][ T1] pci_pme_active+0x80/0x1dc
[ 49.964701][ T1] pci_wake_from_d3+0xc8/0x100
[ 49.965111][ T1] rtl8168_shutdown+0x15c/0x194 [r8168]
[ 49.965705][ T1] pci_device_shutdown+0x34/0x44
[ 49.966138][ T1] device_shutdown+0x164/0x21c
[ 49.966551][ T1] kernel_power_off+0x3c/0x14c
[ 49.966961][ T1] __arm64_sys_reboot+0x268/0x270
[ 49.967391][ T1] invoke_syscall+0x40/0x104
[ 49.967791][ T1] el0_svc_common+0xb8/0x164
[ 49.968190][ T1] do_el0_svc+0x1c/0x28
[ 49.968556][ T1] el0_svc+0x1c/0x48
[ 49.968890][ T1] el0t_64_sync_handler+0x68/0xb4
[ 49.969320][ T1] el0t_64_sync+0x164/0x168

Log 2: The delayed work trying to run after host cleanup, causing the hang

[ 51.258983][ T1] Call trace:
[ 51.259261][ T1] dump_backtrace+0xf4/0x114
[ 51.259663][ T1] show_stack+0x18/0x24
[ 51.260020][ T1] dump_stack_lvl+0x6c/0x90
[ 51.260409][ T1] dump_stack+0x18/0x38
[ 51.260764][ T1] pci_generic_config_read+0x30/0xd0
[ 51.261229][ T1] dw_pcie_rd_other_conf+0x18/0x5c
[ 51.261673][ T1] pci_bus_read_config_word+0x74/0xd4
[ 51.262136][ T1] pci_read_config_word+0x40/0x4c
[ 51.262568][ T1] pci_pme_list_scan+0xd8/0x180
[ 51.262989][ T1] process_one_work+0x1a8/0x3b8
[ 51.263411][ T1] worker_thread+0x24c/0x420
[ 51.263810][ T1] kthread+0xe8/0x1b4
[ 51.264156][ T1] ret_from_fork+0x10/0x20


This seems common as I found several upstream  PCI NIC drivers that call
pci_wake_from_d3 during shutdown (like in igb_main.c, i40e_main.c, 
atl1.c). Also, 7 other PCIe host drivers already implement .shutdown. 
For example, pci-imx6.cresets the controller in its shutdown – I'm not 
sure what happens on imx platforms, but it definitely causes hangs on 
Rockchip.

My main question is:

Is it really a good idea for NIC drivers to call pci_wake_from_d3(true) 
in .shutdown()? This queues a delayed work that needs to access PCI 
config space, but the host controller might be shutting down at the same 
time. This feels like a risky pattern. Are these drivers doing the right 
thing? Or should this wake-up setup happen differently to avoid this race?

Would love to hear your thoughts on how to properly fix this.

