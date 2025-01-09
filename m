Return-Path: <linux-pci+bounces-19598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5507EA0714F
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 10:20:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5650516750B
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2025 09:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D40B6201009;
	Thu,  9 Jan 2025 09:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="pGqniJnk"
X-Original-To: linux-pci@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43D0BA2D;
	Thu,  9 Jan 2025 09:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736414400; cv=none; b=lFZM2uaI+mJrrnAVW242HGtVaYD/ZE3IemwvCn9cLb5ycm3dDppMx5YDvN6F2JVjqf43Nw36ZH+CM2IPddqUPZKmmVGP2nr0HiVLOlWyccOjKe0PgcMGr5ZOmxlYDQbM9PvvejER/Wq6hvlK+tNrD2aQXxYfQTMVrmt8iFBGVBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736414400; c=relaxed/simple;
	bh=P3zlq4ygJF5FDTVCLeWZPwkLrLumivHFTcdRzR7n1zw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UJyTjcO9PYIQzTcXDUE0vUbEDtvs4cY1UtnVF7siSeVHnAU88XSwg13XuajnK2FP5HZcnDO7HSnAjta2gEUMntm/xiDPq7Il/dYho7MS1kfuec3zqCGNPAp415F8PpykecMqr0wCTu8KnQor0J2Sqsa8bnu1uF9FRBxaNxdv4gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=pGqniJnk; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=Message-ID:Date:MIME-Version:Subject:From:
	Content-Type; bh=5PLuhhtZ97rikCQogLx1vtpUFsvhxOgRrEPjxo8AgNY=;
	b=pGqniJnkG19u8sGJJX+P3wSSqUZKdpn7VfLpoNT3tAY2rRiGP0PQNjk1C1Ugxd
	SeM0VJIEypT1aIEy9sxl6wMQXl/NW2lJqwMXqDknjA9AtaboIXxjH9Bln6UYGYPR
	8WX878coXguIkH/6MbBD3nVCuv9jTPB56yIZkH9vTdBYM=
Received: from [192.168.174.52] (unknown [])
	by gzsmtp4 (Coremail) with SMTP id PygvCgC3w+2blH9nYovLEA--.32969S2;
	Thu, 09 Jan 2025 17:19:24 +0800 (CST)
Message-ID: <bcb4e21c-f7e9-4b5e-8712-9ab462bdf46c@163.com>
Date: Thu, 9 Jan 2025 17:19:23 +0800
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [v8] misc: pci_endpoint_test: Fix overflow of bar_size
To: Arnd Bergmann <arnd@arndb.de>, Niklas Cassel <cassel@kernel.org>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
 Kishon Vijay Abraham I <kishon@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, rockswang7@gmail.com
References: <Z3vDLcq9kWL4ueq7@ryzen>
 <d79d5a72-d1b0-4442-a0a3-e53516726204@163.com> <Z30CywAKGRYE_p28@ryzen>
 <96b3a0f7-f144-4f2a-9f84-82c31d8ec23e@163.com> <Z30RFBcOI61784bI@ryzen>
 <270783b7-70c6-49d5-8464-fb542396e2dd@163.com> <Z30UXDVZi3Re_J9p@ryzen>
 <4bfb6c46-6f93-431b-9a8c-038bc7f77241@163.com> <Z31O8B14sKd5eac-@ryzen>
 <7e025613-3516-4957-b83a-70b125a24fa7@app.fastmail.com>
 <Z36IJ6ql09I_dO98@ryzen> <f2901d4f-52c8-496d-9939-3b0e113cba4b@163.com>
 <2b6eabad-ebd1-4e7d-b4bf-6b818dfc20ac@app.fastmail.com>
Content-Language: en-US
From: Hans Zhang <18255117159@163.com>
In-Reply-To: <2b6eabad-ebd1-4e7d-b4bf-6b818dfc20ac@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:PygvCgC3w+2blH9nYovLEA--.32969S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uw4rCFWfCF1xAryrXw43Jrb_yoW8Jw13pF
	yxAF40kayDtry3JrZ29r4rZF4avrnrJ3y3uryrGrya9r90yF97AFW8KFWFka1DCr13Kw4F
	qr17JayfX39rAaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jSAp8UUUUU=
X-CM-SenderInfo: rpryjkyvrrlimvzbiqqrwthudrp/xtbBDxHPo2d-iJak1gABsH



On 2025/1/9 14:29, Arnd Bergmann wrote:
>> On 2025/1/8 22:13, Niklas Cassel wrote:
>>>>> Ok. Looking at do_div(), it seems to be the correct API to use
>>>>> for this problem. Just change bar_size type to u64 (instead of casting)
>>>>> and use do_div() ? That is how it is seems to be used in other drivers.
>>>>
>>>> I think using div_u64_rem() instead of do_div() would make this
>>>> more readable as this is always an inline function, so the type can
>>>> remain resource_size_t, and the division gets optimized well when
>>>> that is a 32-bit type.
>>>
>>> After patch 1/2, we no longer care about the remainder, so I guess
>>> div64_u64() is the correct function to use then?
> 
> div_u64() is the correct interface here, div64_u64() is the
> even slower version where both arguments are 64-bit wide.
> 
>>   >> drivers/misc/pci_endpoint_test.c:311:11: warning: comparison of
>> distinct pointer types ('typeof ((bar_size)) *' (aka 'unsigned int *')
>> and 'uint64_t *' (aka 'unsigned long long *'))
>> [-Wcompare-distinct-pointer-types]
>>        311 |         remain = do_div(bar_size, buf_size);
>>            |                  ^~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> You don't use div_u64() or div64_u64() here, do_div() is the macro
> version that must be called with a 64-bit argument.
> 
>      Arnd

Thank you so much Niklas and Arnd.

Best regards
Hans


