Return-Path: <linux-pci+bounces-17828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B54749E6754
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 07:39:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7A8B4284735
	for <lists+linux-pci@lfdr.de>; Fri,  6 Dec 2024 06:39:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E791D89EC;
	Fri,  6 Dec 2024 06:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+N+5AYx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F215196C6C;
	Fri,  6 Dec 2024 06:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733467148; cv=none; b=maLls9oNZi6ELQsNo0+m9objLE7QTWRKzKqTEMVNQfB6sgKpKhz0eEmfrzDGu5eX3L9l3PpWfTbZk/QLmorwflBoIgtGfbSxDH4iL+MsiTnDX91nR5vm5HEH+MkN74CDDMHzcKlk1AbS02Pykjk1mqGB+AFd44j/qE1oN1YFHyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733467148; c=relaxed/simple;
	bh=gf/iKJKG7MSXBLNBSZesL4mVM9fFiTpPLt8UjWlYIhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DH6y1FuLyN2YdDhAlg+KbfQDAfgA59GzS1Ar/Mf+kSuOPfNeg7oWw9zlQYsdSuvl/zEaqG4St2+7FV+HxQCZpsewSNmjVIiv9iw/jWnfIS9IMQAQzTZhov4Vc9oekbX+iC1/p/mUKTrc/nWBW1q5XJ2gZD4yrVnEEJox4NeScYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+N+5AYx; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-aa63dbda904so61421266b.3;
        Thu, 05 Dec 2024 22:39:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733467145; x=1734071945; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RouDWMtrNmhK5uGTuKr0acx+tj8K0d2J2Vphj7alK/o=;
        b=M+N+5AYxxpAITRrpoyfCrMf9wCdCID8UjNgxTQzGPxhe0MP8IDMkLivapeGgFS2W6A
         cwlZ0z8bcTNFuCx30MX5dh8rsa5/w5ds7FpA/hKNMH0Dv0+pcvlzgSiQWI0YkHqCXVwa
         E80F7ELl+lfEszYv60j/vLK3DQ/noJy3S4QChhzAOkAktqOlW2xH4ektalo+B+x1T7+/
         g/NXmzvK3wpxhczQNmYkhTrey1VYaFW3nGNvMPTzieiJAdyta7iz5zikDsesd5FTFw8u
         HaS8blVOn+4jdYybOcH9whkHHDnwsprlsGDrDEhFWUQPWjp5Au1U5uq+7bYggMOFX2AN
         8r2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733467145; x=1734071945;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RouDWMtrNmhK5uGTuKr0acx+tj8K0d2J2Vphj7alK/o=;
        b=cWyGc318Cb3TkPfouBbfKz51M1wivsTLBXJWBraNJy2K3nrWyUFIuBTHsXW2fiGpvE
         pNYrpk9t6WImhcZozXPGRmhxQw9p2n0v11sFHhsJt6mD1UrZ1VQ8He8BG1IWa3MTybK9
         eoWAzg9v63z7lcSFPDNzlzy5qb74J+6P3quAw2gINbndGHSxfvygJtrk4ODEomIge2/q
         u30EJLT7tbmwJ2rGK6/pUeRz7/FYu/3YJlOqFCZRxX47U7nZ2pP/KX8lqpQcqXqo64X6
         KAT0ADU9eQIwcmE0Z7anjmqGkaxpfCCpAtVb/jf7ZUsBGwuDeQQoXk14uX/8Hq0fg2MX
         mY7Q==
X-Forwarded-Encrypted: i=1; AJvYcCVyqo/tewXih9quaWkuWYwUPpFR4ZD1+MtV9WlwnSxoklqbifeq307zYWe8FKKK0OT0XgzNVrjYg0WV@vger.kernel.org, AJvYcCWCSyV49awgIjlU/kNAAqw4YvCXQSHN0iO1XKPaSPbQv5QbUvfK3q4MLzq8aqn9tLwWvzNU3pSMoCl6@vger.kernel.org, AJvYcCWeuT0pZ+9dwCvIjxcgfvVbwu1GzVasinpOI2sPDoTgLYtYj3OPUJ8oiTWUEbLYnLQqlgE0MO78bbBTZDoH@vger.kernel.org, AJvYcCX/S3pavHUxWVCswg0/oiNHKOAyv91vKmxZtok9WtSDEI0Ae/X3iD/TPsWgVBncqTz2DubvaGPoPNEpteVF2JU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzioJ12WBanbaakS9R/kABBkUQQoXmPGPBn0dHfZKTasXfZ0te/
	ykvKfsdb2OCSkqkqbjlawARuyRdSd9gNM1AE8e3qUnAlKjjYmhat9NoWOUgN
X-Gm-Gg: ASbGncvgZhUwNQoRgdX0uGKNNE4o5rlXW6Bl+oqmNABM16Em/d4bbCmP1lv75wAFWhJ
	dfgm0c68hHlYFxnX0pJaokbUJf2hAX2ic+aiuZUU+ug7cFBr4rsSTr03UCNIkAJOOcCEEbLAT0f
	bQYskpHUZXqO22kY403p9Wy8ht8v3Yjh4FpYAf+H4umHdspIvaBJjMHf9y9z20r+xQuJzTRfChH
	YyezTDrD2KcPPHY7/Nc33bY8idlUBxjb53NGsNDpx+TPxxlgb5MtTfA9decEuCBngAmk6u5WWyq
	e6qzqtCJlCq1rPMLBCCoDURWcGc7cc+96A0ETDpvvyP3O9FXOplj1z7xpJkDFPm92CN6pyQq0pC
	AQYP5Pw==
X-Google-Smtp-Source: AGHT+IGO33J7vW1h11O8By/EYSH2CHjkY31KMy759bZRbZKW/KpYXSdhit8XvWbJ7veAfaEdCrHIcQ==
X-Received: by 2002:a17:907:2da9:b0:aa6:1f84:9791 with SMTP id a640c23a62f3a-aa63a2875aemr164679966b.51.1733467144727;
        Thu, 05 Dec 2024 22:39:04 -0800 (PST)
Received: from ?IPV6:2003:df:bf0d:b400:44f9:3850:f4a9:a264? (p200300dfbf0db40044f93850f4a9a264.dip0.t-ipconnect.de. [2003:df:bf0d:b400:44f9:3850:f4a9:a264])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa6260288e1sm192892266b.102.2024.12.05.22.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 05 Dec 2024 22:39:04 -0800 (PST)
Message-ID: <626b3707-c2cb-4239-b6f8-8b33e45e7874@gmail.com>
Date: Fri, 6 Dec 2024 07:39:02 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/13] samples: rust: add Rust platform sample driver
To: Rob Herring <robh@kernel.org>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
 a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
 fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, daniel.almeida@collabora.com,
 saravanak@google.com, dirk.behme@de.bosch.com, j@jannau.net,
 fabien.parent@linaro.org, chrisi.schrefl@gmail.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org
References: <20241205141533.111830-1-dakr@kernel.org>
 <20241205141533.111830-14-dakr@kernel.org>
 <e2c202c1-6bbe-4b6c-ae97-185fe2aed0e5@gmail.com>
 <CAL_JsqJn=bAF4OYVJNDmiyCNQTAte4wmLhpo0Ca5Pv_oGTg73g@mail.gmail.com>
Content-Language: de-AT-frami, en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <CAL_JsqJn=bAF4OYVJNDmiyCNQTAte4wmLhpo0Ca5Pv_oGTg73g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Rob,

On 05.12.24 19:03, Rob Herring wrote:
> On Thu, Dec 5, 2024 at 11:09 AM Dirk Behme <dirk.behme@gmail.com> wrote:
>>
>> Hi Danilo,
>>
>> On 05.12.24 15:14, Danilo Krummrich wrote:
>>> Add a sample Rust platform driver illustrating the usage of the platform
>>> bus abstractions.
>>>
>>> This driver probes through either a match of device / driver name or a
>>> match within the OF ID table.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>
>> Not a review comment, but a question/proposal:
>>
>> What do you think to convert the platform sample into an example/test?
>> And drop it in samples/rust then? Like [1] below?
>>
>> We would have (a) a complete example in the documentation and (b) some
>> (KUnit) test coverage and (c) have one patch less in the series and
>> (d) one file less to maintain long term.
> 
> I think that's going to become unwieldy when/if we add properties,
> iomem, and every other thing a driver can call in probe.


Yes, I agree. In your property RFC you added some (nice!) property
access examples to the sample we are talking about here. That would
become difficult with the documentation/Kunit example proposed here.
So I think there are pros & cons for both options ;)


> OTOH, the need for the sample will quickly diminish once there are
> real drivers using this stuff.
> 
>> I think to remember that it was mentioned somewhere that a
>> documentation example / KUnit test is preferred over samples/rust (?).
> 
> Really? I've only figured out how you build and run the samples. I
> started looking into how to do the documentation kunit stuff and still
> haven't figured it out. 

If you like try CONFIG_KUNIT=y and CONFIG_RUST_KERNEL_DOCTESTS=y.

I guess it will run automatically at boot, then. For me that was the
easiest way. But yes, everything else will need some additional steps.

Dirk

> I'm sure it is "easy", but it's not as easy as
> the samples and yet another thing to go learn with the rust stuff. For
> example, just ensuring it builds is more than just "compile the
> kernel". We already have so many steps for submitting things upstream
> and rust is just adding more on top.



