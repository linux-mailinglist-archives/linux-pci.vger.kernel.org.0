Return-Path: <linux-pci+bounces-4372-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F4C86F04D
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 12:43:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19AE71C218E6
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC7715EA2;
	Sat,  2 Mar 2024 11:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NTlcRcbc"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FE0171A5
	for <linux-pci@vger.kernel.org>; Sat,  2 Mar 2024 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709379813; cv=none; b=H/8YkkhFjwW3owssn4lXIAOI4/qZHtyGtCBFv0/XJZ6HVPbeeiMF+4ws0gWfRLL9X9evPMXeF/mWa1FtRKUoflzx2vao1dpC8Q+oTcBRS2z+flAhHClkHsFykJrxoLQH4kN4Hr1oc6HpJst+NmRJmAikk4DSjr+lrPagZWAEpxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709379813; c=relaxed/simple;
	bh=nK66dEg8/qsSkEbp7aoagGukh4FtVJ1oiodaEknFkKI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c+rdIOr5uVLGxu6+W0wQAQgP+Bjk/6CGVpmJ7wY/oCxAx2V07gnKCJ0bDj7fCYyk0zqd+w7or7IoFfIs1VnyvAF4tSKu6HnrPNg/aDN7bcLbwJGS0y/UKaJcAoFYB5MDSYSULn6xdubvDRE/ddtz1VtYdpc9ImpLeLvMU9ReEoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NTlcRcbc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709379809;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mX0O9HcYO/TJDyoxXlv2pDaG8MJ2VAiV/QfLiCRgihA=;
	b=NTlcRcbcqdGnMI9n+eT3jhoAOEYt6IPCfEMRQ76fyohloROmySdLDfF50izVGFgsCoN0tA
	yEvVBxTUrpF0TPXCaZCuXLtjQajGEaNkaOUr4mF8ktWqZkQDl3lqX/oUE4dO0XFG7NjHmT
	tXJKOmYpK5ngIWUgIeZpu97p7yP5M1g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-7jnzwtL7Ntum250vrPgXcQ-1; Sat, 02 Mar 2024 06:43:28 -0500
X-MC-Unique: 7jnzwtL7Ntum250vrPgXcQ-1
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-a443f00e9a7so172344866b.1
        for <linux-pci@vger.kernel.org>; Sat, 02 Mar 2024 03:43:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709379807; x=1709984607;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mX0O9HcYO/TJDyoxXlv2pDaG8MJ2VAiV/QfLiCRgihA=;
        b=l9Lrwv2rG2O55hCLlvVGA7F7sz8lDWibUiYr0umqEWcj4FXY9JTJg1sxQ4lV6rZLwe
         J5R0DQqK5G5rbzApt5Ae7wkC5QtYXhRK+XYqeb7V0NP68vk2mghC29z744aQhCmBtxY2
         VeliSfsxh+kzGLKDTyhXghurHcGT5gLKhSYWPk4mfvtIz49r412Q+jfXgQg5qjL/7uLV
         9K730bZBEl1SLcy4H42RiyDSBz1WnUuKl4kKw2mek1miaHHU3rRVHMsig/mtjPD0o4UQ
         cAZuvK4om6La8i5zfzPpT9CVI2dwuMzsWuikbA4RSDznPROYXhnoJ1Gmv8yb+Zy8tiqx
         Sgmw==
X-Forwarded-Encrypted: i=1; AJvYcCUt0OoxsI5GrvKaumy6KwPIUQhoFggmsZAV9cTpjLFxqcD9UCxeG/QEzN8AOyXUslJ2YlLElJj9uLqdrPtIcIDzTJPh+AvpiClQ
X-Gm-Message-State: AOJu0Yzbx9BACZ28dc1SCKc2ljgTLYUe8kQR3MBWniXdYnkf4A10MYhE
	lIyAcX89thxBe9/LleisZxuTY9P9aXz07p6YkSRi2UyeU8ZKKDlvu6HeFnBHCn498tGONUpEXB8
	E4HQgfv8mc19oawHE7UxoQcyc4cBrH5dTvkKwLZCCeopTGHKEucUU0dIWTA==
X-Received: by 2002:a17:907:367:b0:a44:47e3:839b with SMTP id rs7-20020a170907036700b00a4447e3839bmr3238222ejb.10.1709379807229;
        Sat, 02 Mar 2024 03:43:27 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEcJEDn78QQxADf3gvnBmKYFcsxzPY4RxxbrxjDbLfZmarbU91oWIlSbafR5x3o6QZpClbdzw==
X-Received: by 2002:a17:907:367:b0:a44:47e3:839b with SMTP id rs7-20020a170907036700b00a4447e3839bmr3238213ejb.10.1709379806942;
        Sat, 02 Mar 2024 03:43:26 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id hu17-20020a170907a09100b00a3e881b4b25sm2600283ejc.164.2024.03.02.03.43.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Mar 2024 03:43:26 -0800 (PST)
Message-ID: <a26554d3-bee9-4030-a06c-f886ba2fffb0@redhat.com>
Date: Sat, 2 Mar 2024 12:43:25 +0100
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
To: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 "platform-driver-x86@vger.kernel.org" <platform-driver-x86@vger.kernel.org>
Cc: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 "danilrybakov249@gmail.com" <danilrybakov249@gmail.com>,
 Lukas Wunner <lukas@wunner.de>, Klara Modin <klarasmodin@gmail.com>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
References: <20240302012813.2011111-1-shinichiro.kawasaki@wdc.com>
 <gl7rsalwdwdo4rdes6akcnd7llrz75jjje2hchy5cdvzse6vei@367ddi3u6n2e>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <gl7rsalwdwdo4rdes6akcnd7llrz75jjje2hchy5cdvzse6vei@367ddi3u6n2e>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Shinichiro,

Thank you for your work on this.

On 3/2/24 08:28, Shinichiro Kawasaki wrote:
> On Mar 02, 2024 / 10:28, Shin'ichiro Kawasaki wrote:
>> The commit 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls
>> during PCI device probe") triggered repeated ACPI errors on ASUS
>> VivoBook D540NV-GQ065T [1]. It was confirmed that the P2SB device scan
>> and remove at the fs_initcall stage triggered the errors.
>>
>> To avoid the error, defer the P2SB device scan on the concerned device.
>> The error was observed on the system with Pentium N4200 in Goldmont micro-
>> architecture, and on which P2SB has function 0. Then refer to the P2SB
>> function to decide whether to defer or not.
>>
>> When the device scan is deferred, do the scan later when p2sb_bar() is
>> called for the first time. If this first scan is triggered by sysfs
>> pci bus rescan, deadlock happens. In most cases, the scan happens during
>> system boot process, then there is no chance of deadlock.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=218531 [1]
>> Fixes: 5913320eb0b3 ("platform/x86: p2sb: Allow p2sb_bar() calls during PCI device probe")
>> Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
> 
> Let me drop this patch. danilrybakov found that the ACPI errors are still
> reported even with this patch. Will try another fix approach.

Can we not simply just skip scanning function 0 all together when
on Goldmont? I don't think any drivers actually ask for the bar
of function 0 on Goldmont ?

This is likely also why we never had the issue with the old p2sb_bar()
code, because that never touched function 0.

I think this is actually what you did in one of your first test
patches in the bugzilla, right ?

So maybe audit all the callers of p2sb_bar() and see if any
caller asks for function 0 on goldmont ?

Let me know if you need help with this audit.

Regards,

Hans


