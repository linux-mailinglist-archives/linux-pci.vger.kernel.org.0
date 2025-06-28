Return-Path: <linux-pci+bounces-31003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C58D7AEC85D
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 17:41:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 297513AEFE7
	for <lists+linux-pci@lfdr.de>; Sat, 28 Jun 2025 15:41:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDCB21A445;
	Sat, 28 Jun 2025 15:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="YT5nx9sE"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.5])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C25DB2046B3;
	Sat, 28 Jun 2025 15:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751125297; cv=none; b=jsdGFkVc0bDRqGw6j2T/oehqX+LItrb/9IxHDVoIJvzW1NN4/dWj6v0UDBE2aBZTpfEIWkDJxUbD5HpbYBQAqoguq2Zp/7ADpj2eSkBCybhvHvIZicytKXbXC4EsZ2N3bvjS4fTT9Cqe6qhO3HY4fE1739vIjf/5nkgOgmSWyB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751125297; c=relaxed/simple;
	bh=udMastp57gciJQEzvVcYCwTuRaTZ5pT71cUP8mFGTWs=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=NukJA3kCHmOSLPTYpntldsMKeubWX4MNdiMCsldhlBcSFLEDEFAjXJlFGXZ4SaAD9iu5m9iSItdyRAS2KXJKU5U8gRVnxvWAcVlyWjC0ZAhEQLxQT9jMZUgyiV3DUXlzpHT7V+4gFScHSEkkK8hE4I13dIZ3CxG3XWTvZd2u/hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=YT5nx9sE; arc=none smtp.client-ip=117.135.210.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:To:
	Content-Type; bh=n/l1HyF04aNgdp5rJ9CksqiHtOcAKrApwE2nQgpLbbY=;
	b=YT5nx9sEkKwKs7RpT6eNAiAb+Phs320VaD4DRklT2FrcDSS0IXdJriyC1EJ1Sn
	5fMSyHXZ4RoCjgEX6fF7y9Ii3HLzRd2co9spLrJv5buGXfeZ15tGVqqPxSjIgM6q
	freUZQHIlWDvtu/cc220mhjLNqpW304zCXJU/9GxPQcDE=
Received: from [IPV6:240e:b8f:919b:3100:5951:e2f3:d3e5:8d13] (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wB3B_YGDWBoZ6vbBA--.25517S2;
	Sat, 28 Jun 2025 23:40:55 +0800 (CST)
Message-ID: <21c6164e-fa2e-4207-910f-1db3ac3df545@163.com>
Date: Sat, 28 Jun 2025 23:40:55 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: Extend max-link-speed to support
 PCIe Gen5/Gen6
From: Hans Zhang <18255117159@163.com>
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 krzk+dt@kernel.org, manivannan.sadhasivam@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250529021026.475861-1-18255117159@163.com>
 <20250529021026.475861-2-18255117159@163.com>
 <q5ltnilbdhfxwh6ucjnm3wichrmu5wyjsx6eheiazqypveu3sm@euuvpjwu77h4>
 <9203cf6e-ca59-416a-9c98-a2d6a5c6ce6f@163.com>
Content-Language: en-US
In-Reply-To: <9203cf6e-ca59-416a-9c98-a2d6a5c6ce6f@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wB3B_YGDWBoZ6vbBA--.25517S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7ZrWDAFWrXF1xtr1DKr43Awb_yoW8ur1Dpa
	y3Ja1FkFWrZFySqrs7Wr1Fgr45Aanrt3y0yr45Gry7Aas3uFyrJFWSga1Ygr1jqrZ5ZFyx
	ZF1jv3s3Ga1UAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRwL0rUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiOgx6o2hgBsV5LwAAsy



On 2025/6/18 22:22, Hans Zhang wrote:
> 
> 
> On 2025/6/18 00:45, Manivannan Sadhasivam wrote:
>> On Thu, May 29, 2025 at 10:10:24AM +0800, Hans Zhang wrote:
>>> Update the device tree binding documentation for PCI to include
>>> PCIe Gen5 and Gen6 support in the `max-link-speed` property.
>>> The original documentation limited the value to 1~4 (Gen1~Gen4),
>>> but the kernel now supports up to Gen6. This change ensures the
>>> documentation aligns with the actual code implementation.
>>>
>>> Signed-off-by: Hans Zhang <18255117159@163.com>
>>> ---
>>>   dtschema/schemas/pci/pci-bus-common.yaml | 2 +-
>>
>> As Rob commented in v1, this file lives in dtschema project. So update 
>> it there:
>> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml
>>
> 
> Dear Mani,
> 
> I made the patch based on the latest dtschema code pulled from github.
> 
> Also, I saw similar submissions as follows:
> https://lore.kernel.org/linux-pci/advhonmqnxm4s6r3cl7ll5y3jfc566fcjvetvlzvy7bztzetev@t75xmo5fktde/
> 
> I don't know if Rob obtained this patch from here and then applied it to 
> the dtschema project? Is there still a special process to submit this 
> patch?
> 
> 
> Dear Rob,
> 
> Can you apply this patch directly to the dtschema project?
> 

Dear Rob,

Gentle ping.

Best regards,
Hans

> Best regards,
> Hans
> 
>> - Mani
>>
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml 
>>> b/dtschema/schemas/pci/pci-bus-common.yaml
>>> index ca97a00..413ef05 100644
>>> --- a/dtschema/schemas/pci/pci-bus-common.yaml
>>> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
>>> @@ -121,7 +121,7 @@ properties:
>>>         unnecessary operation for unsupported link speed, for 
>>> instance, trying to
>>>         do training for unsupported link speed, etc.
>>>       $ref: /schemas/types.yaml#/definitions/uint32
>>> -    enum: [ 1, 2, 3, 4 ]
>>> +    enum: [ 1, 2, 3, 4, 5, 6 ]
>>>     num-lanes:
>>>       description: The number of PCIe lanes
>>> -- 
>>> 2.25.1
>>>
>>


