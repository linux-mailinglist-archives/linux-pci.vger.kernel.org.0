Return-Path: <linux-pci+bounces-26219-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE55A93726
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 14:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CDF61B606E8
	for <lists+linux-pci@lfdr.de>; Fri, 18 Apr 2025 12:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B049221F0C;
	Fri, 18 Apr 2025 12:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bJvzxzPl"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A89F31A3168;
	Fri, 18 Apr 2025 12:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744979647; cv=none; b=hB0SoLL2q0W5b8esAImvasCVg3StKWfLDu89JtyQfmnzAIS8GOxsbBOa5ML2nRSscrMgglK6qKx1VERZWSSPu1m5je27w8nLLO2dIwB8kbX+gnjZjHqJrpxvHkemmuztgQ4C0wz1fbq3KMQ3ZB1jvExB1EO/M8s1Ui/Yd1LJyRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744979647; c=relaxed/simple;
	bh=EYjpeUAANM8+5uNFVCZfMTzKPxQienpfphayIHsTXTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Mtq0xkHEF8TT/kDVF5B92TsRO/tLgjHfbmMo/iukernoHsRQ1misG27TU7Wxum9lsqklgcuYcE09KPTQOXqXax5BtdsEAN9vA2UD8LEskjHuel+L/yfCvECBP8E6n6eG2Yf/sZQmH5D/urF80iSNE2dCAOVlliGPKdoBBvW92Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bJvzxzPl; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=UBDa95ya3cXHyPB4tt8cCTy+Vp36SNsAM/119FvW6N4=;
	b=bJvzxzPlNdGkw+LZC9dvPrYW8aqNO6eGW8ZI3fbxhzW7pvN1GW+LJpa+uDxhPK
	ebJvUlDMfYrQp0SIiVtO/C98MDAXCMT47eYpfWD2oB33MOZupFs/kxCAr8fxfaDZ
	0P6UlRP8rMCpLq4lua26jUN0JW7yEy7sqCYR6ghEjl8dU=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id _____wDXH0qFRgJosq3aAw--.53778S2;
	Fri, 18 Apr 2025 20:33:10 +0800 (CST)
Message-ID: <22720eef-f5a3-4e72-9c41-35335ec20f80@163.com>
Date: Fri, 18 Apr 2025 20:33:08 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
To: Bjorn Helgaas <helgaas@kernel.org>, Niklas Cassel <cassel@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, lpieralisi@kernel.org,
 kw@linux.com, bhelgaas@google.com, heiko@sntech.de,
 manivannan.sadhasivam@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250417165219.GA115235@bhelgaas>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250417165219.GA115235@bhelgaas>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_____wDXH0qFRgJosq3aAw--.53778S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGw1xCw47Kw47Gr45WryfZwb_yoW5CF1Upa
	yag3W5Kr1DGF4fJw4kZw1F9Fy0yrnxAFW3Xw15t3yDZ3s8AFW3ArWqka12kFyxWrn7G3W3
	JFyF9FW3Xwn8ZFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Ul0PhUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDwgzo2gCPnz1oQAAsr



On 2025/4/18 00:52, Bjorn Helgaas wrote:
> On Thu, Apr 17, 2025 at 10:39:49AM +0200, Niklas Cassel wrote:
>> On Thu, Apr 17, 2025 at 04:07:51PM +0800, Hans Zhang wrote:
>>> On 2025/4/17 15:48, Niklas Cassel wrote:
>>>
>>> Hi Niklas and Shawn,
>>>
>>> Thank you very much for your discussion and reply.
>>>
>>> I tested it on RK3588 and our platform. By setting pci=pcie_bus_safe, the
>>> maximum MPS will be automatically matched in the end.
>>>
>>> So is my patch no longer needed? For RK3588, does the customer have to
>>> configure CONFIG_PCIE_BUS_SAFE or pci=pcie_bus_safe?
>>>
>>> Also, for pci-meson.c, can the meson_set_max_payload be deleted?
>>
>> I think the only reason why this works is because
>> pcie_bus_configure_settings(), in the case of
>> pcie_bus_config == PCIE_BUS_SAFE, will walk the bus and set MPS in
>> the bridge to the lowest of the downstream devices:
>> https://github.com/torvalds/linux/blob/v6.15-rc2/drivers/pci/probe.c#L2994-L2999
>>
>> So Hans, if you look at lspci for the other RCs/bridges that don't
>> have any downstream devices connected, do they also show DevCtl.MPS 256B
>> or do they still show 128B ?
>>
>> One could argue that for all policies (execept for maybe PCIE_BUS_TUNE_OFF),
>> pcie_bus_configure_settings() should start off by initializing DevCtl.MPS to
>> DevCap.MPS (for the bridge itself), and after that pcie_bus_configure_settings()
>> can override it depending on policy, e.g. set MPS to 128B in case of
>> pcie_bus_config == PCIE_BUS_PEER2PEER, or walk the bus in case of
>> pcie_bus_config == PCIE_BUS_SAFE.
>>
>> That way, we should be able to remove the setting for pci-meson.c as well.
> 
> Thanks, I came here to say basically the same thing.  Ideally I think
> the generic code in pcie_bus_configure_settings() should be able to
> increase MPS or decrease it such that neither meson_set_max_payload()
> nor rockchip_pcie_set_max_payload() is required.
> 
> However, the requirement to pick a Kconfig setting makes it a mess.  I
> would love to get rid of those Kconfig symbols.  I don't like the
> command-line parameters either, but it would definitely be an
> improvement if we could nuke the Kconfig symbols and rely on the
> command-line parameters.
> 
> It's also a problem when devices are hot-added after the hierarchy has
> already been set up because the new device might not work correctly in
> the existing config.
> 
> It's a hard problem to solve.
> 
> For new platforms without an install base, maybe it would be easier to
> rely on the command-line parameters since there aren't a bunch of
> users that would have to change the Kconfig.
> 

Dear Bjorn,

Thanks your for reply. Niklas and I attempted to modify the relevant 
logic in drivers/pci/probe.c and found that there was a lot of code 
judging the global variable pcie_bus_config. At present, there is no 
good method. I will keep trying.

I wonder if you have any good suggestions? It seems that the code logic 
regarding pcie_bus_config is a little complicated and cannot be modified 
for the time being?

Best regards,
Hans


