Return-Path: <linux-pci+bounces-26810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BAE2A9DBDF
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:37:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACF10171B7B
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 15:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99B86253F24;
	Sat, 26 Apr 2025 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="XykLgF22"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADDBA3208;
	Sat, 26 Apr 2025 15:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745681838; cv=none; b=S00NdU3a7R06Nzh53FQXAEEHbhcIuKZQgexQ8fevnKmEoEHZPhwuI3nIZwyPlAYYgUXQ71TyBb5PyNN/ywED7H1y0PuEGKMC7uB1e2oo4Yj77lWQeUGzFcIV3vG5XZRwKnSdNj1gK3pudUnmt4iUzc7CbuXVRfl9rh1tieLBUsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745681838; c=relaxed/simple;
	bh=UNmEORGIRTFZO2nDjWGv+So8tDdlKJ5Bjz2t6uxaODY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=b8LqahjHTd4VoS6UojgB9eENphBOPN0LU6+vVl+QZ7W82RyJJ3qA1qFRUEyJ6KdP2HPIA3BLq4H/ItUqzgEUxGyfMqlemzwv3nnUDmy8M8EzsN9/pS8QGxC0p3/ZmIFiRnI/0QtefiOfKbOFfyFaGwh+DfU2HPos2vuWwkVoS94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=XykLgF22; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=vUM7vf0vXe7N2oH0oe3DEg8G2pM3KxBEYmjLGlpyeQI=;
	b=XykLgF22/iL6/iZpwTQ6uMB0pT5VlkDM8hPhc+/Hec6fOqHV/1C9/xveBE9CIU
	S7ZITsIp5u5cX2ute/9ADqyEhp6H5yR2epcbwdWq8/06amgxvZY5fK1fOj0+Abkv
	eE611yM3hVj/g2JXM2zmId9J3jmagbkF+/sGJF9BoIR/g=
Received: from [192.168.71.89] (unknown [])
	by gzga-smtp-mtada-g1-1 (Coremail) with SMTP id _____wCX+C2_+Qxo0RWfCg--.59461S2;
	Sat, 26 Apr 2025 23:20:33 +0800 (CST)
Message-ID: <4e5a60dc-fb0b-413e-9ed9-82f926abd023@163.com>
Date: Sat, 26 Apr 2025 23:20:32 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] PCI: Remove redundant MPS configuration
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: lpieralisi@kernel.org, kw@linux.com, bhelgaas@google.com,
 heiko@sntech.de, thomas.petazzoni@bootlin.com,
 manivannan.sadhasivam@linaro.org, yue.wang@Amlogic.com,
 neil.armstrong@linaro.org, robh@kernel.org, jingoohan1@gmail.com,
 khilman@baylibre.com, jbrunet@baylibre.com,
 martin.blumenstingl@googlemail.com, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-amlogic@lists.infradead.org, linux-rockchip@lists.infradead.org
References: <20250425095708.32662-1-18255117159@163.com>
 <20250425095708.32662-3-18255117159@163.com>
 <20250425181345.bybgcht5tweyg43k@pali>
 <5e2844cc-8359-4b87-a8ce-eb5ebb85f8ff@163.com>
 <20250426150650.c63x62ugtnwx5nzy@pali>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <20250426150650.c63x62ugtnwx5nzy@pali>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCX+C2_+Qxo0RWfCg--.59461S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7Ary3JFW8ZF1kKr1xXw4UXFb_yoW8Kr1Upw
	45JFs3JF4qqF15uF1Iqa1vgr1ftasIyr15Wws8GrW7AasIq3srtFy2yr45CasrXwn7CF12
	va42qFWSyFsxtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UPR6cUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWwo7o2gM8qeGtQABsK



On 2025/4/26 23:06, Pali Rohár wrote:
> On Saturday 26 April 2025 23:02:08 Hans Zhang wrote:
>> On 2025/4/26 02:13, Pali Rohár wrote:
>>> On Friday 25 April 2025 17:57:08 Hans Zhang wrote:
>>>> diff --git a/drivers/pci/controller/pci-aardvark.c b/drivers/pci/controller/pci-aardvark.c
>>>> index a29796cce420..d8852892994a 100644
>>>> --- a/drivers/pci/controller/pci-aardvark.c
>>>> +++ b/drivers/pci/controller/pci-aardvark.c
>>>> @@ -549,9 +549,7 @@ static void advk_pcie_setup_hw(struct advk_pcie *pcie)
>>>>    	reg = advk_readl(pcie, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>>>    	reg &= ~PCI_EXP_DEVCTL_RELAX_EN;
>>>>    	reg &= ~PCI_EXP_DEVCTL_NOSNOOP_EN;
>>>> -	reg &= ~PCI_EXP_DEVCTL_PAYLOAD;
>>>>    	reg &= ~PCI_EXP_DEVCTL_READRQ;
>>>> -	reg |= PCI_EXP_DEVCTL_PAYLOAD_512B;
>>>>    	reg |= PCI_EXP_DEVCTL_READRQ_512B;
>>>>    	advk_writel(pcie, reg, PCIE_CORE_PCIEXP_CAP + PCI_EXP_DEVCTL);
>>>> -- 
>>>> 2.25.1
>>>>
>>>
>>> Please do not remove this code. It is required part of the
>>> initialization of the aardvark PCI controller at the specific phase,
>>> as defined in the Armada 3700 Functional Specification.
>>
>> Hi Pali,
>>
>> This series of patches is discussing the initialization of DevCtl.MPS by the
>> Root Port. Please look at the first patch I submitted. If there is a
>> reasonable method in the end, DevCtl.MPS will also be configured
>> successfully.
> 
> This does not matter what would be configured in DevCtl.MPS at the end.
> 
>> The PCIe maintainer will give the review opinions. Please rest
>> assured that it will not affect the functions of the aardvark PCI
>> controller.
> 
> This patch is modifying initialization of the aardvark PCIe controller
> and is removing the mandatory step of the controller configuration as
> required and defined in the Armada 3700 Functional Specification.
> It says exactly in which order and which values to which registers has
> to be written.

Hi Pali,

Is the maximum MPS supported by Armada 3700 512 bytes? What are the 
default values of DevCap.MPS and DevCtl.MPS?

Because the default value of DevCtl.MPS is not 512 bytes, it needs to be 
configured here, right?

If it's my guess, RK3588 also has the same requirements as you, just 
like the first patch I submitted.

Best regards,
Hans



