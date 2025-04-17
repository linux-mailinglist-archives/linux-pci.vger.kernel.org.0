Return-Path: <linux-pci+bounces-26079-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EACA91848
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 11:49:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFE921901F46
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 09:49:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18662227E9C;
	Thu, 17 Apr 2025 09:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="iCgWg4Nl"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F65189B8C;
	Thu, 17 Apr 2025 09:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744883357; cv=none; b=UYBqqU+IOFcWE23XmhweNlElfyzXq1JwdvIJiBMykbQnK7dc5EteGMS8883NoatS8dqXoZMc7dFaEYFboULTwvsZ6ouBM7+bkXbWZUP8u42Rzm5snDqRh1GSb18rk3fH9j5vLygH5ug34IpOwR8MdYKKflQDWzthrwS2q3sd0tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744883357; c=relaxed/simple;
	bh=q/55UHq6/1jiQ0EDhmM8zKPPjfUQ7XHvpmwEISmA0/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m46DbbBuodKgASN107vApO64SeipyoeDG341nRIsg1/qV921k74obFQvL9l6uaRzA6Fd3Z4s4MyMmyxObHZdEMubbxEE99VKZHqgvFEA3hv/BFMGKNXu94GeC8ykmutv/eHvtJ3DG4UIAXZM3tudPLnxwlltasuCc0Gsp/JAmQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=iCgWg4Nl; arc=none smtp.client-ip=220.197.31.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=hL2lxyNLK9Lw4I33AnMedhe2Sg2bxSiO1M7Cg/oEGJ4=;
	b=iCgWg4Nl0Gcm7cXFrN1Rp8Xwwn2SKnMrvwUHYk/cEwmHbwPOl6cpJKmFwMZJPs
	lyn4MS/HYP+bHx8pgmz3s/HnqwSp3dQz91/nhA4eD9y6O4n5byZAtdZLLkYcwGvx
	x9LJt2GB+AsfDZF0frdf66ZWReyiHBUXXD1I8I8Es9FAk=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3_+lVzgBo48jBAQ--.33700S2;
	Thu, 17 Apr 2025 17:48:07 +0800 (CST)
Message-ID: <4c2a94b4-e483-426f-b7d8-ed98ac474c63@163.com>
Date: Thu, 17 Apr 2025 17:48:04 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
To: Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, lpieralisi@kernel.org,
 kw@linux.com, bhelgaas@google.com, heiko@sntech.de,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250416151926.140202-1-18255117159@163.com>
 <aACoEpueUHBLjgbb@ryzen>
 <85643fe4-c7df-4d64-e852-60b66892470a@rock-chips.com>
 <aACsJPkSDOHbRAJM@ryzen>
 <ca283065-a48c-3b39-e70d-03d4c6c8a956@rock-chips.com>
 <aACyRp8S9c8azlw9@ryzen> <52a2f6dc-1e13-4473-80f2-989379df4e95@163.com>
 <aAC-VTqJpCqcz6NK@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aAC-VTqJpCqcz6NK@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wD3_+lVzgBo48jBAQ--.33700S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGrykWF1rZrWrAryDGr1rZwb_yoW5uFy7pF
	Z0gF45Kr48XayIgr4kAa18KFyUtr9xAFWaqr98W3yqvw17uryrKryq9a90ya4Uurn3Ja4f
	ArWkZrWYqF15AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Uf739UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxoyo2gAxuH92gAAs4



On 2025/4/17 16:39, Niklas Cassel wrote:
> On Thu, Apr 17, 2025 at 04:07:51PM +0800, Hans Zhang wrote:
>> On 2025/4/17 15:48, Niklas Cassel wrote:
>>
>> Hi Niklas and Shawn,
>>
>> Thank you very much for your discussion and reply.
>>
>> I tested it on RK3588 and our platform. By setting pci=pcie_bus_safe, the
>> maximum MPS will be automatically matched in the end.
>>
>> So is my patch no longer needed? For RK3588, does the customer have to
>> configure CONFIG_PCIE_BUS_SAFE or pci=pcie_bus_safe?
>>
>> Also, for pci-meson.c, can the meson_set_max_payload be deleted?
> 
> I think the only reason why this works is because
> pcie_bus_configure_settings(), in the case of
> pcie_bus_config == PCIE_BUS_SAFE, will walk the bus and set MPS in
> the bridge to the lowest of the downstream devices:
> https://github.com/torvalds/linux/blob/v6.15-rc2/drivers/pci/probe.c#L2994-L2999
> 
> 
> So Hans, if you look at lspci for the other RCs/bridges that don't
> have any downstream devices connected, do they also show DevCtl.MPS 256B
> or do they still show 128B ?
> 

Hi Niklas,

It will show DevCtl.MPS 256B.


oot@firefly:~# lspci
00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3588 
(rev 01)
root@firefly:~# lspci -vvv
00:00.0 PCI bridge: Fuzhou Rockchip Electronics Co., Ltd Device 3588 
(rev 01) (prog-if 00 [Normal decode])
         Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- 
ParErr- Stepping- SERR+ FastB2B- DisINTx+
         Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- >SERR- <PERR- INTx-
         Latency: 0
         Interrupt: pin A routed to IRQ 79
         Bus: primary=00, secondary=01, subordinate=ff, sec-latency=0
         I/O behind bridge: 0000f000-00000fff [disabled]
         Memory behind bridge: fff00000-000fffff [disabled]
         Prefetchable memory behind bridge: 
00000000fff00000-00000000000fffff [disabled]
         Secondary status: 66MHz- FastB2B- ParErr- DEVSEL=fast >TAbort- 
<TAbort- <MAbort- <SERR- <PERR-
         Expansion ROM at f0200000 [virtual] [disabled] [size=64K]
         BridgeCtl: Parity- SERR+ NoISA- VGA- VGA16- MAbort- >Reset- 
FastB2B-
                 PriDiscTmr- SecDiscTmr- DiscTmrStat- DiscTmrSERREn-
         Capabilities: [40] Power Management version 3
                 Flags: PMEClk- DSI- D1+ D2+ AuxCurrent=375mA 
PME(D0+,D1+,D2-,D3hot+,D3cold-)
                 Status: D0 NoSoftRst+ PME-Enable- DSel=0 DScale=0 PME-
         Capabilities: [50] MSI: Enable+ Count=16/32 Maskable+ 64bit+
                 Address: 00000000fe670040  Data: 0000
                 Masking: fffffeff  Pending: 00000000
         Capabilities: [70] Express (v2) Root Port (Slot-), MSI 08
                 DevCap: MaxPayload 256 bytes, PhantFunc 0
                         ExtTag+ RBE+
                 DevCtl: CorrErr- NonFatalErr- FatalErr- UnsupReq-
                         RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop-
                         MaxPayload 256 bytes, MaxReadReq 512 bytes

Best regards,
Hans

> 
> One could argue that for all policies (execept for maybe PCIE_BUS_TUNE_OFF),
> pcie_bus_configure_settings() should start off by initializing DevCtl.MPS to
> DevCap.MPS (for the bridge itself), and after that pcie_bus_configure_settings()
> can override it depending on policy, e.g. set MPS to 128B in case of
> pcie_bus_config == PCIE_BUS_PEER2PEER, or walk the bus in case of
> pcie_bus_config == PCIE_BUS_SAFE.
> 
> That way, we should be able to remove the setting for pci-meson.c as well.
> 
> Bjorn, thoughts?
> 
> 
> Kind regards,
> Niklas


