Return-Path: <linux-pci+bounces-8742-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52F909077F1
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 18:12:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 589791C21A52
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 16:12:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 933E812F5BB;
	Thu, 13 Jun 2024 16:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb8WkEjd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 515A512DDA5
	for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718295124; cv=none; b=KgY8ti2DQWkZFcuvrVpg5jEAZhtVW0Lg6rZZCqQ17/X5gtaplzddEBUsm6JESTguioEpjYpaX/a3OQQKOJOwxFngI4aGZHwBMBjdMorIREUjfsyYXIs854XHmQwBS5k3d/GSRUzdlhtYKg9Z21MyIsJpo7Wkhdr+MbodkBkgVWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718295124; c=relaxed/simple;
	bh=Lk6UyCJEl4pM3o/4V6Oj3AvFdg50OnL/b7mY/2Isplc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=em98JHdQhg4R5zEuYHpx5g8ZUIU7572V6sHT77Y3YiycR3gkuelk/YLW/uOcvRejoMhyVpnQxLS6AVM6Fgf636l8u25n6u9iJHy4v8fg9+KTO8UZEtRp4i2PO8p8Y2OMFxaHKvu7iO1OaVX0MmkaYpmsIvohVfSdnZo2iZMhzZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb8WkEjd; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-25488f4e55aso441569fac.0
        for <linux-pci@vger.kernel.org>; Thu, 13 Jun 2024 09:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718295118; x=1718899918; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ii2iEeYhDLODXpwHPE7STNPq2sK5spOcG/Ii3JTuHUI=;
        b=Lb8WkEjdyzN3hiUPLcE7GLF3KF+i3QUE2+yHaNxHpCtA6+684/h3/gYLG7XFjZRN0M
         5OD46rLk6oDFvUGnvxP5HeSRtbDuy10FoS8ENG2AmqHkr7ZohGUMpwU2obpMt1aWn4gA
         SmMozBHovbPFnlsQqVzpFuuWJC+V//0ssC2PT8JAv6WhqCXqp4dYbEvbEsyQbiVgBpTK
         UIcXmPVYPMQzXY/kJgZvxg1CmRB1UpL9e8RN+K37DHDts4unZXMiCYk+W7XjbRcCedYp
         o8xlQCa2+m1lx1fcL9V8mjKlNz67z9FHrC8qzwenb/JFrkQrVvZTNlaVzxghTx/1jHex
         7wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718295118; x=1718899918;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ii2iEeYhDLODXpwHPE7STNPq2sK5spOcG/Ii3JTuHUI=;
        b=K+N1oIUesN9/PSJ2m6FeIzZDjLOsH8vhNdq2VTlEVnKwqRZfAXyKwLAKZmvQVGbxRl
         Ta6k/jae93zyv8eiP53J9Zj+4S9bJkGvHXDZsB8cbf12qABVB//sNPGUMdqjLQEqKMrQ
         eHO5732uyrRfTEmddOi3J53C2labNTiRkgbmLFNj48MbN6eAUR240gtb17zeuZbWAJIo
         GNDTQype0tv91zTDy8oC/QIDBbzfcjOLqFKIsnUS638h6KWqUI+QjzqA49MHzJnRGRUK
         2/dSYwRETn4ljBXi9KI04nIc0PTuCU/KSrKoQ+liaz8od+A2/lqSGaStJvigtpVT2DV0
         ISlA==
X-Forwarded-Encrypted: i=1; AJvYcCV6lO4JcaNLavr0XLC4A7JrUAveAC838D165c2sDiNqXMOkwHNggxodo+Sd0UG/hZUzJ0/hWBNQkiqfPhXC3YvmcUzFwDdHMJsz
X-Gm-Message-State: AOJu0YwJY2M/LR28XXLtrDFYWkaH5cakulrI/Yfd+OAesQSPK0R74Pfk
	4pa2PWqxvT9kl6TPTcKerXDqsbUu1MczahqqcbTAZJvH8gDP0q2m
X-Google-Smtp-Source: AGHT+IE8mRI1am4E+3w0K5DKeozosgpaemzjkcD1Z1KxWsz4QUZtV2mg/ziIMNkQzD3hewyCQpP+SA==
X-Received: by 2002:a05:6870:23a4:b0:24f:cddc:ccff with SMTP id 586e51a60fabf-258428eb2d2mr38029fac.21.1718295118182;
        Thu, 13 Jun 2024 09:11:58 -0700 (PDT)
Received: from [192.168.1.224] (syn-067-048-091-116.res.spectrum.com. [67.48.91.116])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2567a94e772sm454254fac.2.2024.06.13.09.11.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jun 2024 09:11:57 -0700 (PDT)
Message-ID: <d0f266f8-7052-4de7-b589-1cf1d28d03f6@gmail.com>
Date: Thu, 13 Jun 2024 11:11:55 -0500
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] PCI/NPEM: Add Native PCIe Enclosure Management
 support
To: Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
 Lukas Wunner <lukas@wunner.de>, Pavel Machek <pavel@ucw.cz>
Cc: Dan Williams <dan.j.williams@intel.com>, linux-pci@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>, Bjorn Helgaas <bhelgaas@google.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Ilpo Jarvinen <ilpo.jarvinen@linux.intel.com>,
 Keith Busch <kbusch@kernel.org>, Marek Behun <marek.behun@nic.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>
References: <20240528131940.16924-1-mariusz.tkaczyk@linux.intel.com>
 <20240528131940.16924-3-mariusz.tkaczyk@linux.intel.com>
 <6656bb4654a65_16687294c0@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <Zlb3hGR45SWJ1KuL@wunner.de> <20240612134009.00002864@linux.intel.com>
Content-Language: en-US
From: stuart hayes <stuart.w.hayes@gmail.com>
In-Reply-To: <20240612134009.00002864@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 6/12/2024 6:40 AM, Mariusz Tkaczyk wrote:
> Hi,
> Thanks for feedback Dan!
> 
> On Wed, 29 May 2024 11:38:12 +0200
> Lukas Wunner <lukas@wunner.de> wrote:
> 
>> On Tue, May 28, 2024 at 10:21:10PM -0700, Dan Williams wrote:
>>> Mariusz Tkaczyk wrote:
>>>> +config PCI_NPEM
>>>> +	bool "Native PCIe Enclosure Management"
>>>> +	depends on LEDS_CLASS=y
>>>
>>> I would have expected
>>>
>>>      depends on NEW_LEDS
>>>      select LEDS_CLASS
>>
>> Hm, a quick "git grep -C 2 'depends on NEW_LEDS'" shows that noone else
>> does that.  Everyone else either selects both NEW_LEDS and LEDS_CLASS
>> or depends on both or depends on just LEDS_CLASS.
>>
>> (Since LEDS_CLASS is constrained to "if NEW_LEDS", depending on both
>> seems pointless, so I'm not sure why some people do that.)
>>
>> I guess it would be good to get guidance from leds maintainers what
>> the preferred modus operandi is.
> 
> Pavel, could you please advice?
> I have no clue which way I should take so I prefer to keep current approach.
> 
>>
>>
>>>> +#define for_each_indication(ind, inds) \
>>>> +	for (ind = inds; ind->bit; ind++)
>>>> +
>>>> +/* To avoid confusion, do not keep any special bits in indications */
>>>
>>> I am confused by this comment. What "special bits" is this referring to?
>>
>> I think it's referring to bit 0 in the Status and Control register,
>> which is a master "NPEM Capable" and "NPEM Enable" bit.
> 
> Yes, there are 2 special bits for capability/control
> NPEM_CAP_CAPABLE/NPEM_ENABLE and NPEM_CAP_RESET/NPEM_RESET.
> 
> I wanted to highlight that these bits are not included in the cache. I will try
> to make it more precise in v3.
> 
>>
>>
>>>> +struct npem_ops {
>>>> +	const struct indication *inds;
>>>
>>> @inds is not an operation, it feels like something that belongs as
>>> another member in 'struct npem'. What drove this data to join 'struct
>>> npem_ops'?
>>
>> The native NPEM register interface supports enclosure-specific indications
>> which the DSM interface does not support.  So those indications are
>> present in the native npem_ops->inds and not present in the DSM
>> npem_ops->inds.
> 
> Yes, I need to differentiate DSM and NPEM indications. DSM has own indications
> list.
> 
>>
>>
>>>> --- a/include/uapi/linux/pci_regs.h
>>>> +++ b/include/uapi/linux/pci_regs.h
>> [...]
>>>> +#define  PCI_NPEM_IND_SPEC_0		0x00800000
>>>> +#define  PCI_NPEM_IND_SPEC_1		0x01000000
>>>> +#define  PCI_NPEM_IND_SPEC_2		0x02000000
>>>> +#define  PCI_NPEM_IND_SPEC_3		0x04000000
>>>> +#define  PCI_NPEM_IND_SPEC_4		0x08000000
>>>> +#define  PCI_NPEM_IND_SPEC_5		0x10000000
>>>> +#define  PCI_NPEM_IND_SPEC_6		0x20000000
>>>> +#define  PCI_NPEM_IND_SPEC_7		0x40000000
>>>
>>> Given no other driver needs this, I would define them locally in
>>> drivers/pci/npem.c.
>>
>> This is a uapi header, so could be used not just by other drivers
>> but by user space.
>>
>> It's common to add spec-defined register bits to this header file
>> even if they're only used by a single source file in the kernel.
>>
> 
> I will stay with current state while waiting for Bjorn's voice here.
> 
> I will send v3 with fixes requested by Dan and Ilpo but I still need Stuart
> feedback on DSM patch.
> 
> Thanks,
> Mariusz

I'm working on testing this now, sorry for the delay.
Thanks!  Stuart

