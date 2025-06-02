Return-Path: <linux-pci+bounces-28822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E9AACBB29
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 20:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B05321621FF
	for <lists+linux-pci@lfdr.de>; Mon,  2 Jun 2025 18:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0110225768;
	Mon,  2 Jun 2025 18:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uYHS+K1o"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DEA218EA2
	for <linux-pci@vger.kernel.org>; Mon,  2 Jun 2025 18:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748889784; cv=none; b=nRLM9zCTLVO7n0KSCrQULHGWeiU0PtjnAV44LXKhb0b9FQ+wpLLSim/oXwK/BFanlKMPt0RZ2yH4zthnWkz3eCi98XMVSpdSzr+DdKRVjHdJ7qZM5aoZMa4IyWyMynBzFcB+Je/VCENTN6U9EhNm75tR7puEqeS0As5CkOf0Ac8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748889784; c=relaxed/simple;
	bh=p+wD3zMTOWI0HISbGROLTVC+KJOh+kfgMSn79zqvOmY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LgzFIQRtr6/u3AuwW7LVBhXTnV8dp1jpPff+Zu1SqZll5yog+X0lNVTmcnpxnWzt5LKuUnPFnA/GrqB1D/cLYZqYVEJ3jr8napjvqRj/jY8KqBGMkFcxqtkq3bW2BIWEiqR0yEmq6PX6lR9VSIxLMA1vql7xOJlUZgD5ZeaYnOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uYHS+K1o; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-604e2a2f200so9167410a12.1
        for <linux-pci@vger.kernel.org>; Mon, 02 Jun 2025 11:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748889780; x=1749494580; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vnvUjNE/+RVrDDbHkhezYePJuDWmPp+oybHgIE8H+Rg=;
        b=uYHS+K1oj0WgCIk3e8h0ncTbqM/HGd7x87OL/eqkSN4YZxLu5FFKF5qhbv4F12f7VN
         oozntXURwdyt56jNvro+rTuLDlYnqQ1Cl3tSwvvsZEcsqcaQDX9pD9KsEDv4V1zfid2r
         SrQakZkxhUczy3nKekQwv96mFQ1lm2iXOtXF7+KJZRm3D47+GLyW1RLtlGsGOmdQuxig
         G60I4VxRmNEMiGtg9p7zTSw52jsAMGwShefVjDgSYrV/vVkcyXwQ2VTiXivJC4iDNhvQ
         LyAjTiIXWuk/jn2wPAf5ePTlXSZVIf6zb8wlrtgt++ayO2Yle4Q0GDnGIYlOLrzsuzXB
         3dAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748889780; x=1749494580;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vnvUjNE/+RVrDDbHkhezYePJuDWmPp+oybHgIE8H+Rg=;
        b=Ix2FVjEsTII38E8iWGGqkbZNwgcpNNLm0NkLs8yXL1D0Pq4qt5zntAq0+088o8BlUT
         o+SWFfc7NmFFTbfy2DSAyNu6HmL9cSjnyALbAygg8aKh11cfRuYZ370tuK9E2Ck6pxm/
         GtJYZ5wyLQYE4Pm8Qgo9xGc7A9zPl0SKkjsLTbZI6OGXnjfAPilAsUDbAZSRo0T5+zK8
         vMMXMmOJ08BpTvEkeyGMEDA2oTn5uXovmHWlKFs+ZdMsB8EVhZ3z3kvmkmBahX85nN2c
         wAuw1u6VOtYYeX7w+Dgr0eRr62ApyMfNHC+Z+8ME00dWgkc8PA5bbFetiVQ0mErad9Wn
         Rb+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUzPfv7FwjtAY4Ss2XxHr7lf8gJob34CtmIRItAzZfGB+esdu0EZZAu8WvWsu9U/pjYxM80ZdBeyrw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3CF/iSaK73N0UP44Bex4JJDmtzDQR1FbgMFtWEmzXV/vxzbm/
	rKLsTO9DszaxmOS2X4u1LcixwD4CYDneF5JqeesirCCGWy585DCcPbo/3FKJyIthNXA=
X-Gm-Gg: ASbGncvJ2+4dHbNWZPfcK85Buzbl9p8wPmC6yNmJBty9iphbFSq/gTUllH6sNL+TIYp
	F477Vbq8yam7tt94ZgBtCR8987zOqo2FsOjTEob1wmkrPqYAqbX7zF9uVs1cFtWr62usz7QTwu+
	2UHLfI/1ElDtogQoeRgtu2193WEngwC5LDeUSHAh5nwi1QBhvP7HRqESCR7/NX57rEfaPrSyQT1
	uLHw2cxwdS9MDnOsMujQ4kYkVWHrAT5VJRlgemx1GNTFhrJVn2C2L3+vgiW2NWBBaC/IV5VQ7R4
	s2ArP9aeHBXa64WQzkWFiZ9+QZq8DHZkPXKrGVQmCIv4NDw9zQ6pLFsfwlfuwWH7f4kDlSxQZk/
	huQWj
X-Google-Smtp-Source: AGHT+IFJ/fmPqlLI1xs1kQIdWrguQXYZLNV4oahPunuD+7Yh+pew/6do8m1nbzlvPSYYP3h1lQd2KQ==
X-Received: by 2002:a05:6402:26c9:b0:602:3e4:54de with SMTP id 4fb4d7f45d1cf-605b751ac19mr9468088a12.10.1748889780341;
        Mon, 02 Jun 2025 11:43:00 -0700 (PDT)
Received: from [192.168.0.14] ([79.115.63.75])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ada5d84e76csm828077866b.86.2025.06.02.11.42.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jun 2025 11:42:59 -0700 (PDT)
Message-ID: <f2d149c6-41a4-4a9a-9739-1ea1c4b06f4b@linaro.org>
Date: Mon, 2 Jun 2025 19:42:58 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 24/25] PCI: Perform reset_resource() and build fail list
 in sync
To: =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>,
 Igor Mammedov <imammedo@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>,
 William McVicker <willmcvicker@google.com>
References: <20241216175632.4175-1-ilpo.jarvinen@linux.intel.com>
 <20241216175632.4175-25-ilpo.jarvinen@linux.intel.com>
 <5f103643-5e1c-43c6-b8fe-9617d3b5447c@linaro.org>
 <8f281667-b4ef-9385-868f-93893b9d6611@linux.intel.com>
 <3a47fc82-dc21-46c3-873d-68e713304af3@linaro.org>
 <f6ee05f7-174b-76d4-3dbe-12473f676e4d@linux.intel.com>
 <867e47dc-9454-c00f-6d80-9718e5705480@linux.intel.com>
 <a56284a4-755d-4eb4-ba77-9ea30e18d08f@linaro.org>
 <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <7e882cfb-a35a-bab0-c333-76a4e79243b6@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 6/2/25 4:08 PM, Ilpo Järvinen wrote:
>>> I think I figured out more about the reason. It's not related to that 
>>> bridge window resource.
>>>
>>> pbus_size_mem() will add also that ROM resource into realloc_head 
>>> as it is considered (intentionally) optional after the optional change
>>> (as per "tudor: 2:" line). And that resource is never assigned because 

cut

>>> pdev_sort_resources() didn't pick it up into the head list. The next 
>>> question is why the ROM resource isn't in the head list.
>>>
>> It seems the ROM resource is skipped at:
>> https://web.git.kernel.org/pub/scm/linux/kernel/git/next/linux-
>> next.git/tree/drivers/pci/setup-bus.c#n175
>>
>> tudor: pdev_sort_resources: ROM [??? 0x00000000 flags 0x0] resource
>> skipped due to !(r->flags) || r->parent
> I don't see the device in this print, hope it is for the same device.
> 
> In any case, I don't understand what reset resource's flags in between 
> pbus_size_mem() and pdev_sort_resources(), or alternative, why type 
> checking in pbus_size_mem() matches if flags == 0 at that point.
> 
> Those two functions should work on the same resources, if one skips 
> something, the other should too. Disparity between them can cause issues, 
> but despite reading the code multiple times, I couldn't figure out how 
> that disparity occurs (except for the !pdev_resources_assignable() case).

cut

> It is of interest to know why the same resource is treated differently.
> So what were the resource flags, type* args when it's processed by
> pbus_size_mem()? If resource's flags are zero at that point but it matches 

This is the full output: https://termbin.com/mn1x
for the following prints: https://termbin.com/q57h

It seems ROM resource is of type 2 at pbus_size_mem() time.

> one of the types, that would be a bug.

I'll give another try tomorrow. Thanks,
ta

