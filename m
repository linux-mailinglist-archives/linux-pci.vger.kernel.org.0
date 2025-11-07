Return-Path: <linux-pci+bounces-40563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FA8C3E9A0
	for <lists+linux-pci@lfdr.de>; Fri, 07 Nov 2025 07:16:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 040C0188D240
	for <lists+linux-pci@lfdr.de>; Fri,  7 Nov 2025 06:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 540341FDE01;
	Fri,  7 Nov 2025 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="LF6Bymw1"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m21467.qiye.163.com (mail-m21467.qiye.163.com [117.135.214.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066B62AD25;
	Fri,  7 Nov 2025 06:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.214.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762496177; cv=none; b=hTGm/zKZZc6nD9HuT6RYDmQIJIMNGmTiz/+sAqP647OFutqDi+uePxwPwlzdvDNd3TZysdCYAkt3bImjPY0opKeCm/KTwN+KjY68fy0LwvqE6EgKlJpOcXla2N9Jdj/p9NAZft42Kklhhku/ryFmpVCkxz1Io+3cg4ANxpM9tz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762496177; c=relaxed/simple;
	bh=H4d8ndChuo5fOqeYlTRqAiQcjbJGXGTeSzXoDpPoqfY=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=XC45r6J5EyOGMzmOhOmQPB13PXzk0GfblbA8Y4+pTlJVPoJza1crgOWt8iXCPlz/Sjq2fQaG559szKwzOIZO4OsK9XCil5zH8bAN1UF+5FwHsgUnf8GfxhQb1zhQa8V1IjXEdPKBahkQ8JCO7PjE2DmzWyJRmNGLhX29lPDKM6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=LF6Bymw1; arc=none smtp.client-ip=117.135.214.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 28be2acaa;
	Fri, 7 Nov 2025 14:16:03 +0800 (GMT+08:00)
Message-ID: <a46b93b6-b5ea-46d1-95df-de0333a24124@rock-chips.com>
Date: Fri, 7 Nov 2025 14:16:02 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: shawn.lin@rock-chips.com, Bjorn Helgaas <helgaas@kernel.org>,
 linux-pci@vger.kernel.org, Christian Zigotzky <chzigotzky@xenosoft.de>,
 mad skateman <madskateman@gmail.com>, "R . T . Dickinson" <rtd2@xtra.co.nz>,
 Darren Stevens <darren@stevens-zone.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Lukas Wunner <lukas@wunner.de>, luigi burdo <intermediadc@hotmail.com>,
 Al <al@datazap.net>, Roland <rol7and@gmx.com>,
 Hongxing Zhu <hongxing.zhu@nxp.com>, hypexed@yahoo.com.au,
 linuxppc-dev@lists.ozlabs.org, debian-powerpc@lists.debian.org,
 linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [PATCH 1/2] PCI/ASPM: Cache Link Capabilities so quirks can
 override them
To: Manivannan Sadhasivam <mani@kernel.org>
References: <20251106183643.1963801-1-helgaas@kernel.org>
 <20251106183643.1963801-2-helgaas@kernel.org>
 <944388a9-1f5d-41e4-8270-ac1fb6cf73e1@rock-chips.com>
 <6fni6w6aolqgxazmepiw2clwjq54yt76pjswx7zmdgebj4svqz@mggk4qyhdrrt>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <6fni6w6aolqgxazmepiw2clwjq54yt76pjswx7zmdgebj4svqz@mggk4qyhdrrt>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9a5cf52e6609cckunmf756b770fb550d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUsZSVYYHRhMSEJMSUxLSRhWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=LF6Bymw1uO2GLOHKZ39MphmMakxHNXX5HbabmEb9sf7wbvw02qUotrI3y0/kGxHzV6mBXD0PiFdmimLjGZ7dOkUOfubo9DHJPOZ6mjvzPEQmHt3NIREuSe1XVdxEPRagqqvlKWQxxk70+29L4E+eixKweMSrWhnjLcVhU7LUdFc=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=FlX6gFMtwDHl9ivNUeei3dgvvXHvUT1d8ckke2uZGpE=;
	h=date:mime-version:subject:message-id:from;

在 2025/11/07 星期五 14:03, Manivannan Sadhasivam 写道:
> On Fri, Nov 07, 2025 at 09:17:09AM +0800, Shawn Lin wrote:
>> 在 2025/11/07 星期五 2:36, Bjorn Helgaas 写道:
>>> From: Bjorn Helgaas <bhelgaas@google.com>
>>>
>>> Cache the PCIe Link Capabilities register in struct pci_dev so quirks can
>>> remove features to avoid hardware defects.  The idea is:
>>>
>>>     - set_pcie_port_type() reads PCIe Link Capabilities and caches it in
>>>       dev->lnkcap
>>>
>>>     - HEADER quirks can update the cached dev->lnkcap to remove advertised
>>>       features that don't work correctly
>>>
>>>     - pcie_aspm_cap_init() relies on dev->lnkcap and ignores any features not
>>>       advertised there
>>>
>>
>> Quick test with a NVMe shows it works.
>>
>> Before this patch,  lspci -vvv dumps:
>>
>>   LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
>>           ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>>   LnkCtl: ASPM L1 Enabled; RCB 64 bytes, LnkDisable- CommClk+
>>
>>
>> Capabilities: [21c v1] L1 PM Substates
>>           L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>> L1_PM_Substates+
>>                     PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
>>           L1SubCtl1: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>>                      T_CommonMode=0us LTR1.2_Threshold=26016ns
>>
>> After this patch + a local quirk patch like your patch 2, it shows:
>>
>>   LnkCap: Port #0, Speed 16GT/s, Width x4, ASPM L1, Exit Latency L1 <64us
>>           ClockPM+ Surprise- LLActRep- BwNot- ASPMOptComp+
>>   LnkCtl: ASPM Disabled; RCB 64 bytes, LnkDisable- CommClk-
>>
>> Capabilities: [21c v1] L1 PM Substates
>>            L1SubCap: PCI-PM_L1.2+ PCI-PM_L1.1+ ASPM_L1.2+ ASPM_L1.1+
>> L1_PM_Substates+
>>                      PortCommonModeRestoreTime=10us PortTPowerOnTime=10us
>>            L1SubCtl1: PCI-PM_L1.2- PCI-PM_L1.1- ASPM_L1.2- ASPM_L1.1-
>>                       T_CommonMode=0us LTR1.2_Threshold=0ns
>>
>>
>>
>> One things I noticed is CommClk in LnkCtl is changed.
> 
> That's not because of this series, but because of your quirk that disables L0s
> and L1. Common Clock Configuration happens only when ASPM is enabled, if it is
> disabled, PCI core will not configure it (the value remains untouched). That's
> why it was enabled before your quirk and disabled afterwards.
> 

Thanks for the detailed explanation, I have no more questions now.

> This bit is also only used to report the L0s and L1 Exit latencies by the
> devices.
> 
> - Mani
> 


