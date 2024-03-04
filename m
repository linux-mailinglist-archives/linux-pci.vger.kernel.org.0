Return-Path: <linux-pci+bounces-4409-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0036F86FE14
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 10:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9D22818E4
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 09:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4A13208A2;
	Mon,  4 Mar 2024 09:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bhYdEZEi"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0EB219E0
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 09:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709546122; cv=none; b=kbPabZ8g6K1ViRr9yIO1coX9meAJVBRtwDJKky2kRp8+BBD9BhgRgGv5VOYRKumtMzS4j7MqA/u0dwA2F4zri6aB4fSEDf47NTJil0XH5Tkcw8uv8lAp0OOEI8qBz2cq+NzDitC74iUhXcvUs2StjFDSdCTyBkNnE703xRwpsm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709546122; c=relaxed/simple;
	bh=nt7lWRNl9rrRaZF10vIalnwKv7AY1hf7d3GdTlaY8WE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oFyrfnuLiX9zmUW6IxnfRqenEK9DtkHWG0an+Br0l34wBc6XRTZr0wLWfzQmmflFCqgKggPx/pVfJGKDv3v5tiajiNBhLnCGlNl+VD7YIt7PsDhIe7soaR1o55PvA6XRurJzKnFHX+4OaZE8uZY002FHK1ov4IYTN08X8ie/kaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bhYdEZEi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709546120;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=es+dRdUM8pF5fSKeM+s1q8Z5S+9uRfhQVEGJ8pCfshU=;
	b=bhYdEZEiJ2C4C667CpYTnHCV6iAoawN7MYz3/n5qO4Nna+J5QU4cjsMTMN0cfZEcBDytXt
	ultkp3yaQcBxtR0cUb4HQqPorCdS8lRHDz6rV01BWQM3Xks85//AouBmlN7N+ubTX6PR9Q
	fxk4SP9d+J3+X8fT2E4UWrlBTivDD0w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-UCWdUBBeN42VqbY67igvvg-1; Mon, 04 Mar 2024 04:55:17 -0500
X-MC-Unique: UCWdUBBeN42VqbY67igvvg-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-56451e5801dso2867821a12.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2024 01:55:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709546116; x=1710150916;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=es+dRdUM8pF5fSKeM+s1q8Z5S+9uRfhQVEGJ8pCfshU=;
        b=R0EJOYUr6j5yHnpYBV52cJqqbGA+GXvDh6xH6MwWShElE0a1Q/qDcxAVfeeD2nuepg
         FTmUBvtZYeuX7wTGrplOrbJRIU+kaDSCChmPjeZn4bWGPZyFQHOpz/D/rgM4IjNKlVb3
         SgbKliiDFsOWCHc7gpY5Rdqh9wNpRMxBFHlKRckBXTXMifTcbDPXZhUMgLpRpRcFzNuz
         lmFnLem6U1gSDAeInlyBe/8tE5U0Qu0ow3NPWVrw9c47ZKVWQ1NKr04fCDsROlMIggRl
         vGwVw34vBmd+MsuYSxNaCbeK4sqd9G/NO+t1E7r3qcXM+3MhEhFt6YvGd9kYP/4d3MZ0
         QPKg==
X-Forwarded-Encrypted: i=1; AJvYcCUGecLLAPOUg74+uadOuXoAO5uLz40oM/CuKa0YTuJ0XHCoY+qCBr1yJrSF9IfFpXCAKgcUw1yWItAd54DaSLec2x/RKlT6oqbc
X-Gm-Message-State: AOJu0Yw/kyDtbUOgvQta+4OlN67b6NI2XpwiiDA4C/rQVGryYHFuHMTI
	NUiWuchtDjewlkkghSk6goOF4VYfcUumhnsK6UUkfUOHZz6wGMktEoSD/VXRf8Uqc/B+WBUtf9l
	ujEcchqz54CL05MSe0nXgAV8tz8Tf7SBYsylecM0OOweKJhgrNf56+HlRKw==
X-Received: by 2002:a17:906:b806:b0:a45:1fe5:10b7 with SMTP id dv6-20020a170906b80600b00a451fe510b7mr2044671ejb.43.1709546116123;
        Mon, 04 Mar 2024 01:55:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFLNjHtMz8OICaqwUPloFXvB7K0QaeOR5hxuWVEHn1S5Ki9FixTg10j50IgxC8aOUTUrSTiMQ==
X-Received: by 2002:a17:906:b806:b0:a45:1fe5:10b7 with SMTP id dv6-20020a170906b80600b00a451fe510b7mr2044653ejb.43.1709546115818;
        Mon, 04 Mar 2024 01:55:15 -0800 (PST)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id wk15-20020a170907054f00b00a4519304f8bsm1545831ejb.14.2024.03.04.01.55.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 01:55:15 -0800 (PST)
Message-ID: <a5dac02b-c16a-45d1-8157-0dae1b034418@redhat.com>
Date: Mon, 4 Mar 2024 10:55:14 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] platform/x86: p2sb: Defer P2SB device scan when P2SB
 device has func 0
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
 <7935add6-a643-43dd-82a8-b7bcfb94d297@redhat.com>
 <6sbllfapnclmu5sjdtjcs4tyzkkr76ipg3i3rtqyyj7syhtkwd@d2l6zq2co7zt>
Content-Language: en-US
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <6sbllfapnclmu5sjdtjcs4tyzkkr76ipg3i3rtqyyj7syhtkwd@d2l6zq2co7zt>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 3/4/24 4:19 AM, Shinichiro Kawasaki wrote:
> On Mar 03, 2024 / 20:35, Hans de Goede wrote:
>> Hi Shinichiro,
>>
>> On 3/3/24 00:37, Shinichiro Kawasaki wrote:

<snip>

>> So I have taken a quick look at your latest patch from:
>> https://bugzilla.kernel.org/show_bug.cgi?id=218531
>>
>> I think that skipping the caching at fs_initcall() on goldmont
>> is a good idea.
>>
>> But you still cache *all* the bars for goldmont on the first
>> p2sb_bar(bus, 0, &res) call .
>>
>> If we delay caching the bars till there first use, why not
>> just do that for all the bars and also drop p2sb_scan_and_cache()
>> which for non goldmont is equivalent to p2sb_scan_and_cache_devfn()
>> but on goldmont caches all the functions.
>>
>> Since you now delay caching (on goldmont) to the first p2sb_bar()
>> call I think that you can just drop p2sb_scan_and_cache()
>> altogether and just directly call p2sb_scan_and_cache_devfn()
>> in its place.
>>
>> This means that on goldmont where both the p2sb devfn
>> PCI_DEVFN(13, 0) and the SPI controller PCI_DEVFN(13, 2)
>> are used we end up going through p2sb_cache_resources()
>> twice, assuming both are actually requested at least once.
>> But with your current patch this will also happen when
>> PCI_DEVFN(13, 2) gets requested first because then
>> p2sb_scan_and_cache() will enter the "not function 0"
>> path and only cache the one resource.
>>
>> So I think that it would make things more KISS if
>> p2sb_bar() always only caches the requested devfn bar0
>> instead of treating function0 special as it does now.
> 
> Thank you again for looking into the patch. I agree that the "function 0" path
> in p2sb_scan_and_cache() is not meaningful any more. When I prepare v3 patch,
> I will modify the patch to call p2sb_scan_and_cache_devfn() in place of
> p2sb_scan_and_cache().

I've seen you've posted v3, this looks good, thanks.

>> Also talking about making things more KISS, how
>> about completely dropping the fs_initcall and
>> simply always delay the caching of a devfn until
>> the first call of p2sb_bar() for that devfn ?
>>
>> That way fixing the issue will also actually reduce /
>> simplify the code :)
> 
> This will simplify the code more, but it has two drawabacks:
> 
> 1) It still leaves the rare deadlock scenario. If the drivers which call
>    p2sb_bar() are not probed during boot, and if they are probed afterwards by
>    sysfs pci bus rescan, pci_rescan_remove_lock causes the deadlock.
> 
> 2) It triggers lockdep splat for pci_rescan_remove_lock at sysfs pci bus rescan,
>    even for devices unrelated to p2sb (This is what I regularly observe during
>    kernel tests for storage sub-system.)
> 
> I suggest to limit these drawbacks only on goldmont.

I was not aware of the lockdep triggering issue. I agree that should be avoided
when possible. I see you have kept the fs_initcall() for this in v3, good.

Regards,

Hans


