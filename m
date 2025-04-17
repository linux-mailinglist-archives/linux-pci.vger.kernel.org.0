Return-Path: <linux-pci+bounces-26064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F14BA91517
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 09:26:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B1E5444DF8
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 07:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043BC21B9C2;
	Thu, 17 Apr 2025 07:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b="ItIT98LN"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-m19731106.qiye.163.com (mail-m19731106.qiye.163.com [220.197.31.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161E6219A9D;
	Thu, 17 Apr 2025 07:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744874754; cv=none; b=TIXtXDxzAJ+6DBxPQ3qB9tpH0iAhMSp3MqrgXHsJd/AzhjUqWmY5sBbXlRcgb756ypRKhE1T35OuP1bU0nX0p9aD9nFVYIWCzhVsTytHfzrYH/2mB53aPm5Tj741n2+colY6X96iTZplwa5CfMo3fsM77xHV/bhu6AqpW4IP+nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744874754; c=relaxed/simple;
	bh=N5ef3o/HFYFEl3oTu6ekvSxq6JxDjlQK4f96yFMRzRM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TCPGbsh3aXMU5vu2yJRMzhoI0ZpoVolppKuhu0l2jFdWsXMd6h9r90XSIdX083Q6QXj0hQQjwwgBcjpefgB6mAcaAZV7dHW0GgtYdGEssVQU4GalRhzeOEJJpZ9Wt235j8aVY/J1kyPXaiVtMJ9l3gdQgDqn79vTgO+n8AIjR7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com; spf=pass smtp.mailfrom=rock-chips.com; dkim=pass (1024-bit key) header.d=rock-chips.com header.i=@rock-chips.com header.b=ItIT98LN; arc=none smtp.client-ip=220.197.31.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rock-chips.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rock-chips.com
Received: from [172.16.12.129] (unknown [58.22.7.114])
	by smtp.qiye.163.com (Hmail) with ESMTP id 1233a2cdc;
	Thu, 17 Apr 2025 15:25:41 +0800 (GMT+08:00)
Message-ID: <ca283065-a48c-3b39-e70d-03d4c6c8a956@rock-chips.com>
Date: Thu, 17 Apr 2025 15:25:06 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Cc: shawn.lin@rock-chips.com, lpieralisi@kernel.org, kw@linux.com,
 bhelgaas@google.com, heiko@sntech.de, manivannan.sadhasivam@linaro.org,
 robh@kernel.org, jingoohan1@gmail.com, thomas.richard@bootlin.com,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
To: Hans Zhang <18255117159@163.com>
References: <20250416151926.140202-1-18255117159@163.com>
 <aACoEpueUHBLjgbb@ryzen>
 <85643fe4-c7df-4d64-e852-60b66892470a@rock-chips.com>
 <aACsJPkSDOHbRAJM@ryzen>
From: Shawn Lin <shawn.lin@rock-chips.com>
In-Reply-To: <aACsJPkSDOHbRAJM@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkkfT1YYGh0YQ0tPThpJQ0NWFRQJFh
	oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSU9PT0
	hVSktLVUpCS0tZBg++
X-HM-Tid: 0a9642a3a11e09cckunm1233a2cdc
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NRg6EAw*LjJCHhAsNQ8ZDjkt
	VisKFDJVSlVKTE9PQ0xPTE9IQ09PVTMWGhIXVQgTGgwVVRcSFTsJFBgQVhgTEgsIVRgUFkVZV1kS
	C1lBWU5DVUlJVUxVSkpPWVdZCAFZQUhMTEM3Bg++
DKIM-Signature:a=rsa-sha256;
	b=ItIT98LNpFdr+LN3qpvVBueCPohPToRuA3M+VFYxIN+pTgbAm25/vWhApyWFMy6oxAlqpC5i2wsE8inB6fXgXukULBFpKhVNw/hwUlSwtJdC2pnQ4CGrv6rga/mrw18V1sF3k2TDLCkgFJgGpv1q2IgXyb84yN8ZCw95ludXhfI=; c=relaxed/relaxed; s=default; d=rock-chips.com; v=1;
	bh=B6iTx3Lr3Y/E/h3fgZVym20bL7MC/yae8ZyHNmoM91E=;
	h=date:mime-version:subject:message-id:from;

在 2025/04/17 星期四 15:22, Niklas Cassel 写道:
> On Thu, Apr 17, 2025 at 03:08:34PM +0800, Shawn Lin wrote:
>> 在 2025/04/17 星期四 15:04, Niklas Cassel 写道:
>>> Hello Hans,
>>>
>>> On Wed, Apr 16, 2025 at 11:19:26PM +0800, Hans Zhang wrote:
>>>> The RK3588's PCIe controller defaults to a 128-byte max payload size,
>>>> but its hardware capability actually supports 256 bytes. This results
>>>> in suboptimal performance with devices that support larger payloads.
>>>
>>> Patch looks good to me, but please always reference the TRM when you can.
>>>
>>> Before this patch:
>>> 		DevCap: MaxPayload 256 bytes
>>> 		DevCtl: MaxPayload 128 bytes
>>>
>>>
>>> As per rk3588 TRM, section "11.4.3.8 DSP_PCIE_CAP Detail Registers Description"
>>>
>>> DevCap is per the register description of DSP_PCIE_CAP_DEVICE_CAPABILITIES_REG,
>>> field PCIE_CAP_MAX_PAYLOAD_SIZE.
>>> Which claims that the value after reset is 0x1 (256B).
>>>
>>> DevCtl is per the register description of
>>> DSP_PCIE_CAP_DEVICE_CONTROL_DEVICE_STATUS, field PCIE_CAP_MAX_PAYLOAD_SIZE_CS.
>>> Which claims that the reset value is 0x0 (128B).
>>>
>>> Both of these match the values above.
>>>
>>> As per the description of PCIE_CAP_MAX_PAYLOAD_SIZE_CS:
>>> "Permissible values that
>>> can be programmed are indicated by the Max_Payload_Size
>>> Supported field (PCIE_CAP_MAX_PAYLOAD_SIZE) in the Device
>>> Capabilities (DEVICE_CAPABILITIES_REG) register (for more
>>> details, see section 7.5.3.3 of PCI Express Base Specification)."
>>>
>>> So your patch looks good.
>>>
>>> I guess I'm mostly surprised that the e.g. pci_configure_mps() does not
>>> already set DevCtl to the max(DevCap.MPS of the host, DevCap.MPS of the
>>> endpoint).
>>>
>>> Apparently pci_configure_mps() only decreases MPS from the reset values?
>>> It never increases it?
>>>
>>
>> Actually it does:
>>
>> https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.txt#L4757
> 
> If that is the case, then explain the before/after with Hans lspci output here:
> https://lore.kernel.org/linux-pci/bb40385c-6839-484c-90b2-d6c7ecb95ba9@163.com/
> 
> His patch changes the default value of DevCtl.MPS (from 128B to 256B), but if
> pci_configure_mps() can bump DevCtl.MPS to a higher value, his patch should not
> be needed, since the EP (an NVMe SSD in his case) has DevCap.MPS 512B, and the
> RC itself has DevCap.MPS 256B.
> 
> Seems like we are missing something here.

So Hans, could you please help set pci=pcie_bus_safe or
pci=pcie_bus_perf in your cmdline, and see how lspci dump different
without your patch?

> 
> 
> Kind regards,
> Niklas
> 
> 

