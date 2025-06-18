Return-Path: <linux-pci+bounces-30064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2631ADEF1E
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 16:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5D8B3BD64B
	for <lists+linux-pci@lfdr.de>; Wed, 18 Jun 2025 14:23:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 510852EAD14;
	Wed, 18 Jun 2025 14:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="czIhzIDv"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC3B2E8E00;
	Wed, 18 Jun 2025 14:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750256597; cv=none; b=j1poCJ1KWLK9Bm6MI6ciIpwsbmnHcj2Y0DApRne/yIlTxWxLx4DHZj3TX8DElN5b78UZnqYoOo5RF15EH089zljBp1dXADj+cxYJdbOTdjZedQ46j++MUVNRd9107WKdq7Cn2dXKzc13FnkWOHnKp3o7FLlA+PgrYhfc07l0DME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750256597; c=relaxed/simple;
	bh=/kCZED307PxRlzLUByha5TboyLgGFMQyb8rQaxCxbi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fANY8Tw80BdPuVH6/nPgYiw+YsdyHShQ3y4GSA8/f9Ej+6J2Idpy1lD0Hc4L4t6IbqinTIHQNj4aHS+jA/tWFQvq6gYS/Sm0A8qe5Bj2djB6R+csWvOiKYvBtmyeWWnBITmVsSO4fqhbD+1PW/rCS/msDXyDIUz7s5HestC0+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=czIhzIDv; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:To:From:
	Content-Type; bh=aKN5Xb4pqwecPj9X55VM7S0C9aEQ1Y9s1xKnCpxeegI=;
	b=czIhzIDv0vExDetuwquUJKrYUO53fjMO4UCjAlc9rWtkNKUKWDmbGcZxmkhrGh
	pnVWLb7puWTNmuknm9dqGRZtgrsybZ+88DaATFV0/JRgcx8iCPy7iUUimCAGkcHN
	lGHrmbBJ2B4ybopt7h8vv/1qloEhAX9KLlMwIyFMJb5T8=
Received: from [IPV6:240e:b8f:919b:3100:8440:da7c:be7e:927f] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgAn_qq1y1JonKCoAA--.5729S2;
	Wed, 18 Jun 2025 22:22:46 +0800 (CST)
Message-ID: <9203cf6e-ca59-416a-9c98-a2d6a5c6ce6f@163.com>
Date: Wed, 18 Jun 2025 22:22:45 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] dt-bindings: PCI: Extend max-link-speed to support
 PCIe Gen5/Gen6
To: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>
Cc: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
 krzk+dt@kernel.org, manivannan.sadhasivam@linaro.org, conor+dt@kernel.org,
 linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20250529021026.475861-1-18255117159@163.com>
 <20250529021026.475861-2-18255117159@163.com>
 <q5ltnilbdhfxwh6ucjnm3wichrmu5wyjsx6eheiazqypveu3sm@euuvpjwu77h4>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <q5ltnilbdhfxwh6ucjnm3wichrmu5wyjsx6eheiazqypveu3sm@euuvpjwu77h4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgAn_qq1y1JonKCoAA--.5729S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF1rJFW5ur48Zr4fuF4rZrb_yoW8CFWDpa
	y5Ja1xKFyrZFySqrZ7Wr1F9r45AanrJ3y0yr45Gry7A3sxXF1rJFZaga1rWr17trZ5AFyx
	uF1UZwnxGa15AFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0zRepBDUUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/1tbiWx9wo2hSygcmiQAAsP



On 2025/6/18 00:45, Manivannan Sadhasivam wrote:
> On Thu, May 29, 2025 at 10:10:24AM +0800, Hans Zhang wrote:
>> Update the device tree binding documentation for PCI to include
>> PCIe Gen5 and Gen6 support in the `max-link-speed` property.
>> The original documentation limited the value to 1~4 (Gen1~Gen4),
>> but the kernel now supports up to Gen6. This change ensures the
>> documentation aligns with the actual code implementation.
>>
>> Signed-off-by: Hans Zhang <18255117159@163.com>
>> ---
>>   dtschema/schemas/pci/pci-bus-common.yaml | 2 +-
> 
> As Rob commented in v1, this file lives in dtschema project. So update it there:
> https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/pci/pci-bus-common.yaml
> 

Dear Mani,

I made the patch based on the latest dtschema code pulled from github.

Also, I saw similar submissions as follows:
https://lore.kernel.org/linux-pci/advhonmqnxm4s6r3cl7ll5y3jfc566fcjvetvlzvy7bztzetev@t75xmo5fktde/

I don't know if Rob obtained this patch from here and then applied it to 
the dtschema project? Is there still a special process to submit this patch?


Dear Rob,

Can you apply this patch directly to the dtschema project?

Best regards,
Hans

> - Mani
> 
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/dtschema/schemas/pci/pci-bus-common.yaml b/dtschema/schemas/pci/pci-bus-common.yaml
>> index ca97a00..413ef05 100644
>> --- a/dtschema/schemas/pci/pci-bus-common.yaml
>> +++ b/dtschema/schemas/pci/pci-bus-common.yaml
>> @@ -121,7 +121,7 @@ properties:
>>         unnecessary operation for unsupported link speed, for instance, trying to
>>         do training for unsupported link speed, etc.
>>       $ref: /schemas/types.yaml#/definitions/uint32
>> -    enum: [ 1, 2, 3, 4 ]
>> +    enum: [ 1, 2, 3, 4, 5, 6 ]
>>   
>>     num-lanes:
>>       description: The number of PCIe lanes
>> -- 
>> 2.25.1
>>
> 


