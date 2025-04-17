Return-Path: <linux-pci+bounces-26073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EEFA91626
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 10:08:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F016319078C9
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 08:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 505BB22D7B1;
	Thu, 17 Apr 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="RYGvreS4"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513EA22DF86;
	Thu, 17 Apr 2025 08:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744877315; cv=none; b=a7U88fl7f3/JoXMXggFAnxbb5u8aNxWvjljcgOcjwSIa/93brVfQFZNoGlvNGt0K0jol/2lOnjVIMtZipIbdQsig+HU7OkAdH4v0zsw1nLJWVXzLAF+nWkBKUzFNm16WTwjdK+6xsR64lDtVo3xrZeyDa9AYoQFQnYXiK6prcmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744877315; c=relaxed/simple;
	bh=wsSYuEeEfzcuxI4QZjsSIfleahK+9e1G2ym2wIqY87M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJwcGBtw99HkDTY4fdUUTzRW/mrazFBp9OFEw30hbGTi2SsYrHtuCPUQgWPOKckogzcEVeApWQj8GJCLhu1iPTKua2yEvPzSiCOA+OpvGD4IK6h8bwJO/TnAzYHOvgLBvWnBdSE3niwmB46E5S2VuHglOL2rAimNRcHOOtqehf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=RYGvreS4; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=HlgWpR09t/bSRSkE9n5lqQqIokkyYXuy0tioT6D2/gU=;
	b=RYGvreS4Se2WbeLN10BDpFsbNJdMWqT3wCNTLrz8G2chlNdbl9oubsIcSiZp09
	zKFwqAeB1t2wfiAGmwsN8s6b+irHTW/vvx8X+7ra05p6uoOxwLQpeVAzHA8VGUcq
	sVA8EuQdLYybGjyc3Tk1jt/NssiajnDWEm1DjQg7z+GUk=
Received: from [192.168.142.52] (unknown [])
	by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wAX613XtgBo09yjAg--.7973S2;
	Thu, 17 Apr 2025 16:07:53 +0800 (CST)
Message-ID: <52a2f6dc-1e13-4473-80f2-989379df4e95@163.com>
Date: Thu, 17 Apr 2025 16:07:51 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PCI: dw-rockchip: Configure max payload size on host init
To: Niklas Cassel <cassel@kernel.org>, Shawn Lin <shawn.lin@rock-chips.com>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, manivannan.sadhasivam@linaro.org, robh@kernel.org,
 jingoohan1@gmail.com, thomas.richard@bootlin.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org
References: <20250416151926.140202-1-18255117159@163.com>
 <aACoEpueUHBLjgbb@ryzen>
 <85643fe4-c7df-4d64-e852-60b66892470a@rock-chips.com>
 <aACsJPkSDOHbRAJM@ryzen>
 <ca283065-a48c-3b39-e70d-03d4c6c8a956@rock-chips.com>
 <aACyRp8S9c8azlw9@ryzen>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <aACyRp8S9c8azlw9@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wAX613XtgBo09yjAg--.7973S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCr4kCr47Jw4rArWrXryrZwb_yoWrGF18p3
	y5Xa1Ykrs8tw45Jrs7t3Wv9rWYyFsxXFy5Wwn8JryUJwn0kr13tr4vkr4UKF17Xr4rGF4j
	qFyUJryfX3WDAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UHrWwUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWxcyo2gAsnuqcwAAsl



On 2025/4/17 15:48, Niklas Cassel wrote:
> On Thu, Apr 17, 2025 at 03:25:06PM +0800, Shawn Lin wrote:
>> 在 2025/04/17 星期四 15:22, Niklas Cassel 写道:
>>> On Thu, Apr 17, 2025 at 03:08:34PM +0800, Shawn Lin wrote:
>>>> 在 2025/04/17 星期四 15:04, Niklas Cassel 写道:
>>>>> Hello Hans,
>>>>>
>>>>> On Wed, Apr 16, 2025 at 11:19:26PM +0800, Hans Zhang wrote:
>>>>>> The RK3588's PCIe controller defaults to a 128-byte max payload size,
>>>>>> but its hardware capability actually supports 256 bytes. This results
>>>>>> in suboptimal performance with devices that support larger payloads.
>>>>>
>>>>> Patch looks good to me, but please always reference the TRM when you can.
>>>>>
>>>>> Before this patch:
>>>>> 		DevCap: MaxPayload 256 bytes
>>>>> 		DevCtl: MaxPayload 128 bytes
>>>>>
>>>>>
>>>>> As per rk3588 TRM, section "11.4.3.8 DSP_PCIE_CAP Detail Registers Description"
>>>>>
>>>>> DevCap is per the register description of DSP_PCIE_CAP_DEVICE_CAPABILITIES_REG,
>>>>> field PCIE_CAP_MAX_PAYLOAD_SIZE.
>>>>> Which claims that the value after reset is 0x1 (256B).
>>>>>
>>>>> DevCtl is per the register description of
>>>>> DSP_PCIE_CAP_DEVICE_CONTROL_DEVICE_STATUS, field PCIE_CAP_MAX_PAYLOAD_SIZE_CS.
>>>>> Which claims that the reset value is 0x0 (128B).
>>>>>
>>>>> Both of these match the values above.
>>>>>
>>>>> As per the description of PCIE_CAP_MAX_PAYLOAD_SIZE_CS:
>>>>> "Permissible values that
>>>>> can be programmed are indicated by the Max_Payload_Size
>>>>> Supported field (PCIE_CAP_MAX_PAYLOAD_SIZE) in the Device
>>>>> Capabilities (DEVICE_CAPABILITIES_REG) register (for more
>>>>> details, see section 7.5.3.3 of PCI Express Base Specification)."
>>>>>
>>>>> So your patch looks good.
>>>>>
>>>>> I guess I'm mostly surprised that the e.g. pci_configure_mps() does not
>>>>> already set DevCtl to the max(DevCap.MPS of the host, DevCap.MPS of the
>>>>> endpoint).
>>>>>
>>>>> Apparently pci_configure_mps() only decreases MPS from the reset values?
>>>>> It never increases it?
>>>>>
>>>>
>>>> Actually it does:
>>>>
>>>> https://github.com/torvalds/linux/blob/master/Documentation/admin-guide/kernel-parameters.txt#L4757
>>>
>>> If that is the case, then explain the before/after with Hans lspci output here:
>>> https://lore.kernel.org/linux-pci/bb40385c-6839-484c-90b2-d6c7ecb95ba9@163.com/
>>>
>>> His patch changes the default value of DevCtl.MPS (from 128B to 256B), but if
>>> pci_configure_mps() can bump DevCtl.MPS to a higher value, his patch should not
>>> be needed, since the EP (an NVMe SSD in his case) has DevCap.MPS 512B, and the
>>> RC itself has DevCap.MPS 256B.
>>>
>>> Seems like we are missing something here.
>>
>> So Hans, could you please help set pci=pcie_bus_safe or
>> pci=pcie_bus_perf in your cmdline, and see how lspci dump different
>> without your patch?
> 
> It seems that the default MPS strategy can be set using Kconfigs:
> https://github.com/torvalds/linux/blob/v6.15-rc2/drivers/pci/pci.c#L126-L136
> https://github.com/torvalds/linux/blob/v6.15-rc2/include/linux/pci.h#L1110-L1116
> 
> Note that the these Kconfigs are hidden behind CONFIG_EXPERT.
> So unless you have explicitly set one of these Kconfigs, the default should be:
> PCIE_BUS_DEFAULT,	/* Ensure MPS matches upstream bridge */


Hi Niklas and Shawn,

Thank you very much for your discussion and reply.

I tested it on RK3588 and our platform. By setting pci=pcie_bus_safe, 
the maximum MPS will be automatically matched in the end.

So is my patch no longer needed? For RK3588, does the customer have to 
configure CONFIG_PCIE_BUS_SAFE or pci=pcie_bus_safe?

Also, for pci-meson.c, can the meson_set_max_payload be deleted?


Best regards,
Hans



