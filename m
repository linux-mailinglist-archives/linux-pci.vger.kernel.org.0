Return-Path: <linux-pci+bounces-4379-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6072786F6D6
	for <lists+linux-pci@lfdr.de>; Sun,  3 Mar 2024 20:35:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8E391F211DB
	for <lists+linux-pci@lfdr.de>; Sun,  3 Mar 2024 19:35:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17C0768E5;
	Sun,  3 Mar 2024 19:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RP/SGSZM"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F42276402
	for <linux-pci@vger.kernel.org>; Sun,  3 Mar 2024 19:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709494510; cv=none; b=BQwWdZClamlgvuL/wDSLSOBlHdACi8N07aw6N7e+5gKihS/CmzLPz70f/VNb91PzjYeEKsZNEsu1l7mNEwTgB3X6Z6wYRR+Gu2sgMxgQvd4WmWtiCmRJ7wjjNTgOVtbfIvgjOBAsNS2EUa7/8VzR4TxzSe5yL6q0eqfuFSrse3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709494510; c=relaxed/simple;
	bh=FOZMBhoQFjMTOzeAEwtDwCCnhFwPAXF22Ux8FV5GfcU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ENMy8vA3UsDYFW1NmMogoPH7siGRxNRdlwADjNNy6uR9QIEGjN5rY0rCcJrJWNNq0Sb//i6J1991QR+8KXDEuh35AUS9NzjHaqqN/sAl5mlmm//dP1gdTrFyQrXGapdhTMYrTNi/Zju/iAQAQmJfjVombV206V8cRNd6Hgb4WPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RP/SGSZM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709494507;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fmM6euBgk7sKjR9y+kZziDjsPjVPCkf2jEPQ1Pkeqb4=;
	b=RP/SGSZMaYSO1z9ZCAOLA4GqYpDjHhYYHTLJedoH6H7mCWQ4F55GSTikCsR3fzfDbKsz28
	oKVXVgSHCWROcCL9o1j5LwFP2k+mVF4qf9QfNYE+z0zbx1yRDHiMA/cukrZkzLNZ7GCBWJ
	lO/igRot2K5tgcgtXDHeKpGfOIRZtHc=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-D7fK9t1JP1aq8Vj6qzuYkA-1; Sun, 03 Mar 2024 14:35:03 -0500
X-MC-Unique: D7fK9t1JP1aq8Vj6qzuYkA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a45447fec91so17215366b.1
        for <linux-pci@vger.kernel.org>; Sun, 03 Mar 2024 11:35:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709494502; x=1710099302;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fmM6euBgk7sKjR9y+kZziDjsPjVPCkf2jEPQ1Pkeqb4=;
        b=DE3ZLEdW3CotK4mIn83+8OG+erLhnBWFkWs38aO79M9ewSGxiYKmkutj5K5Pb7Zll/
         NexYGfPdEzGUc659WSHzu2mc935YVy/yGgdPSCqN5cnCtfKVOfGRA8zm0xgWKlu14X39
         vcABgiarX2HHoNcjkueH3aBAeXM4jzqm4pTRUfDxHvHBJ5I8eQjRX5nj9PzvXj0Dp3UA
         ySOuLCUdfpoL2W847CyvnYfkunJLrA2Ef4jGfZyqoO5uX0/HcSzoFY6y3M8NTWxrnkeZ
         GIUeJOnc83+J54fUCH0nVeGKecmBTv3RagTq+NZeRGV4S2mp793WOjv4FqAthgLGRmDK
         xROg==
X-Forwarded-Encrypted: i=1; AJvYcCW4XMhanVn6i0sU6v82icTnh9VTid+y4ctxdzh4UVHfIj22e4TyclgY8BG+r9lYA0HthxhQQl9qW7Qw6fe5Woa2h8x6CQswXV3I
X-Gm-Message-State: AOJu0YzmarVaT1wRkWANRWXGT46LuZr9BYt/Ys/QQRlij3qG3KGUhLxe
	o9GwX0TnuuqjU10eCPM5bYxIkIegDZbahMDVnJNaKcQFWqIw6fD3sUy7okQoxnY8HJMXQS2LPRZ
	zU5us9mtMu9qjbkdvupnY2tDETu7SItayTgIqI99NPsxtBodGHcugJxvsJg==
X-Received: by 2002:a17:906:24d7:b0:a45:fdf:1e68 with SMTP id f23-20020a17090624d700b00a450fdf1e68mr1634304ejb.33.1709494502391;
        Sun, 03 Mar 2024 11:35:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGyyynbOGBqGy2HD/NUVB2yu4fKwyCdDbTA5Qbdil0nPmifaM3+/RbS12eUKpAxRG108Bye+A==
X-Received: by 2002:a17:906:24d7:b0:a45:fdf:1e68 with SMTP id f23-20020a17090624d700b00a450fdf1e68mr1634293ejb.33.1709494502019;
        Sun, 03 Mar 2024 11:35:02 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906475600b00a449d6184dasm2642103ejs.6.2024.03.03.11.35.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 11:35:01 -0800 (PST)
Message-ID: <7935add6-a643-43dd-82a8-b7bcfb94d297@redhat.com>
Date: Sun, 3 Mar 2024 20:35:01 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: p2sb: Defer P2SB device scan when P2SB
 device has func 0
Content-Language: en-US, nl
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "danilrybakov249@gmail.com" <danilrybakov249@gmail.com>,
 Lukas Wunner <lukas@wunner.de>, Klara Modin <klarasmodin@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20240302012813.2011111-1-shinichiro.kawasaki@wdc.com>
 <gl7rsalwdwdo4rdes6akcnd7llrz75jjje2hchy5cdvzse6vei@367ddi3u6n2e>
 <a26554d3-bee9-4030-a06c-f886ba2fffb0@redhat.com>
 <r6ezdjqb5hz5jvvaj2beyulr2adwht2sonxw3bhcjdvwduyt66@2hlsmnppfsk2>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <r6ezdjqb5hz5jvvaj2beyulr2adwht2sonxw3bhcjdvwduyt66@2hlsmnppfsk2>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shinichiro,

On 3/3/24 00:37, Shinichiro Kawasaki wrote:
> On Mar 02, 2024 / 12:43, Hans de Goede wrote:

<snip>

>> Can we not simply just skip scanning function 0 all together when
>> on Goldmont? I don't think any drivers actually ask for the bar
>> of function 0 on Goldmont ?
> 
> Hi Hans, thank you for the idea. If we can take this appraoch, the fix patch
> will be simpler.
> 
>>
>> This is likely also why we never had the issue with the old p2sb_bar()
>> code, because that never touched function 0.
>>
>> I think this is actually what you did in one of your first test
>> patches in the bugzilla, right ?
> 
> To be precise, the first test patch did P2SB scan only for the function 2.
> To make sure your idea works, it's the better to test to scan all the function
> numbers except 0, from 1 to 7.
> 
>>
>> So maybe audit all the callers of p2sb_bar() and see if any
>> caller asks for function 0 on goldmont ?
>>
>> Let me know if you need help with this audit.
> 
> Help for the audit will be appreciated.
> 
> With the quick grep for p2sb_bar() [2], there are five p2sb_bar() callers:

Ack, I have found the same 5 callers, let go over them one by one:

>  1) edac/pnd2_edac             devfn = 0

Hmm, ok so this one binds based on CPU-ids:

static const struct x86_cpu_id pnd2_cpuids[] = {
        X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT,       &apl_ops),
        X86_MATCH_INTEL_FAM6_MODEL(ATOM_GOLDMONT_D,     &dnv_ops),
        { }
};
MODULE_DEVICE_TABLE(x86cpu, pnd2_cpuids);

And the 0 passed here will get replaced by PCI_DEVFN(13, 0),
so there goes my theory of p2sb() never being called for
function 0.

So I have taken a quick look at your latest patch from:
https://bugzilla.kernel.org/show_bug.cgi?id=218531

I think that skipping the caching at fs_initcall() on goldmont
is a good idea.

But you still cache *all* the bars for goldmont on the first
p2sb_bar(bus, 0, &res) call .

If we delay caching the bars till there first use, why not
just do that for all the bars and also drop p2sb_scan_and_cache()
which for non goldmont is equivalent to p2sb_scan_and_cache_devfn()
but on goldmont caches all the functions.

Since you now delay caching (on goldmont) to the first p2sb_bar()
call I think that you can just drop p2sb_scan_and_cache()
altogether and just directly call p2sb_scan_and_cache_devfn()
in its place.

This means that on goldmont where both the p2sb devfn
PCI_DEVFN(13, 0) and the SPI controller PCI_DEVFN(13, 2)
are used we end up going through p2sb_cache_resources()
twice, assuming both are actually requested at least once.
But with your current patch this will also happen when
PCI_DEVFN(13, 2) gets requested first because then
p2sb_scan_and_cache() will enter the "not function 0"
path and only cache the one resource.

So I think that it would make things more KISS if
p2sb_bar() always only caches the requested devfn bar0
instead of treating function0 special as it does now.

Also talking about making things more KISS, how
about completely dropping the fs_initcall and
simply always delay the caching of a devfn until
the first call of p2sb_bar() for that devfn ?

That way fixing the issue will also actually reduce /
simplify the code :)

Regards,

Hans


p.s.

FWIW here is a quick analysis of the other callers:

>  2) i2c/busses/i2c-i801        devfn = 0

Goldmont platforms use PCI_DEVICE_ID_INTEL_BROXTON_SMBUS for the i801
i2c adapter and that does not have FEATURE_TCO_* set in its
feature flags so the p2sb_bar() call there is never made
on broxton.

>  3) mfd/lpc_ich for pinctrl    devfn = 0

This one is made on Apollo Lake devices, which use goldmont
CPU cores, so this is another case where function 0 is
actually queried through p2sb_bar()...

>  4) mfd/lpc_ich for spi        devfn = PCI_DEVFN(13, 2)

Not function 0.

>  5) watchdog/simatic-ipc-wdt   devfn = 0

This is actually a similar usage to the mfd/lpc_ich to get
to the GPIO controller when its not exported through ACPI,
but before the code switched to the p2sb_bar() helper it
was looking at PCI_DEVFN(31, 1), so this does not run
on goldmont.

Regards,

Hans




> 
> [2]
> 
> $ git grep p2sb_bar
> drivers/edac/pnd2_edac.c:                       ret = p2sb_bar(NULL, 0, &r);
> drivers/i2c/busses/i2c-i801.c:  ret = p2sb_bar(pci_dev->bus, 0, res);
> drivers/mfd/lpc_ich.c:  ret = p2sb_bar(dev->bus, 0, &base);
> drivers/mfd/lpc_ich.c:          ret = p2sb_bar(dev->bus, PCI_DEVFN(13, 2), res);
> drivers/platform/x86/p2sb.c: * p2sb_bar - Get Primary to Sideband (P2SB) bridge device BAR
> drivers/platform/x86/p2sb.c:int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
> drivers/platform/x86/p2sb.c:EXPORT_SYMBOL_GPL(p2sb_bar);
> drivers/watchdog/simatic-ipc-wdt.c:             ret = p2sb_bar(NULL, 0, res);
> include/linux/platform_data/x86/p2sb.h:int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem);
> include/linux/platform_data/x86/p2sb.h:static inline int p2sb_bar(struct pci_bus *bus, unsigned int devfn, struct resource *mem)
> 


