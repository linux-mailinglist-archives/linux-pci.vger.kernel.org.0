Return-Path: <linux-pci+bounces-18860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4984F9F8D37
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 08:25:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E6B247A3AE2
	for <lists+linux-pci@lfdr.de>; Fri, 20 Dec 2024 07:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA171A83E6;
	Fri, 20 Dec 2024 07:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GMjKp2Sg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22CF119FA9D;
	Fri, 20 Dec 2024 07:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734679492; cv=none; b=Cxr9n/32PiAcCiKOXbUSOMMm6R7SmKPx1z4ciVUu2U8hVDxCPzNu8k6aenDAr66C7ba5dgpsa4/QNJ+zyQHOX+KRrkszap/9S8WH+Trws5GA+IKekMb0JO3HY9JNhL/rwQlJSyn4JvVV6mhnZzSuqpwy/y00nooEvMfUWoEVqbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734679492; c=relaxed/simple;
	bh=wI74LX221mPtoUsM7Ghs9jBZJLJE4lCDTW38aEi1dyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A8lxNRDRxmyS/5+x1BspoSV/NMZIUihEW7GVHnlO7HvIjZ38fGMclgkTMWCMmPh8weh9UtxyEbnhHIhibSRWtZrF9IVhS5HKczjzlif3QgoP1DzlyU+wPI0v02XQAffMWTMeIIfOZcwSQWHqdU7YTJFyONz02taucifu0nVrV3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GMjKp2Sg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5d3bdccba49so2671927a12.1;
        Thu, 19 Dec 2024 23:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734679487; x=1735284287; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ORTg5dVLT+DfsB7NLY9HYeMdx6LrBrYY3N/RITbt1kI=;
        b=GMjKp2SguJSv41vHdYhi9sV10s6NwRhyjXsdmdoaOPjLVyBxOjE+ZDZFwLnbY52Yrx
         TsrUENyBcsFoFWEO5mqvv/agQMGs2RtdbwKyHLQ8t6erYWEn0Qxc1sRU4nMui/lv/IPz
         qm/QsGTxuxjg1QZaI9x8R5Ocex4bxGXuRcuHHxa9LkrMnc5hTc5Mu+ydwPfcBhRzYuBZ
         8hiEmRyq7MwMwtJ6X+5Gu5ApuD4q4iNcnIiFf0U2WYnxSVu4lCx8slCYeRNGsJuq5tUx
         DNPANakINLjKYh1wFN96ZG1xQZeyJ9/Jy91muH2CQVsxs87XQF44ji+5lNPuCxGvTyzN
         KdUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734679487; x=1735284287;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ORTg5dVLT+DfsB7NLY9HYeMdx6LrBrYY3N/RITbt1kI=;
        b=JBrbIVNFFnMHUJ9icD6KJyAHOMxtvRblrgOK6es9BL0V8jwRzL+xW4S+nel1f8+QHG
         sTuVB+pIY35yeifpuYj8p/W1L+v7c1/I9LlS03Nm+nYQaKGgT2A3Bh8jzSJCa0N7ZteM
         y5wMRDW4gMsgXw1SbLCrzbkfrnAIiDp0KBfxHpqD0GG2c31dVpidrv1x/rAI/WXWooDa
         VO4xeuHEPckwdS+RBmPWA9Rd3FD/3rowuTeftDw5cw914UbDAGzrgxNyuH/g8Cqf4Oob
         ZMjvJVoXHJCDzpLshgbjJjuKaE7+9slSq8QhRiaAnT+Wz9I2ES7ZCeaefkziqKbv1R9V
         EZzg==
X-Forwarded-Encrypted: i=1; AJvYcCUmfoB0mPLt2RblAvzoL8ky2VKlWX3nGjo/ikq4GY99HGS+xRLWQ3P4PSVXu6FteV0TH9LUPB0ZmC1C@vger.kernel.org, AJvYcCV4AuoM+3Cfib6Qc17dxYvL2W0/lTYOLwEoyhoQ6MnpY4CKYB24Pq8A6Cju/OjmSOfXpAqH@vger.kernel.org, AJvYcCVtRjx+xRIOoD9yoXIa0XceHScMsrfF3QzgJ7sdSoBVxG0vTSAIeDl1GM4weuY4amUOH+JOfvkCKZtmGOlO@vger.kernel.org, AJvYcCW/XjIDw+8USZ8Y0CCeeMMXwODJaNKdvKgynSOuzM54+4znj5IrlYzFUl4cl7IPilgWtwtq6VH1FMuG@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyqf0CrsK+tSBDMzog5honTa0JEVfao2ajewVDTnoLHkj/ei90
	hZ9isi0SK3QXkl2Dho09VPaTTwwwVcOfIhyUupK4xbXXpiR35SWy
X-Gm-Gg: ASbGncvlIowlQecT32NEJOhCu1yTz/ZAAHPJbSmFGwrBxXfWX7RzfExrXESUr2GDOrq
	USV5r7/3Gs4J45Re7UOmQ+VfYL5dPgAu/0ZzA70x0YA5flJ6ywShkUqxDbPnEEysMtAaSXnzPmG
	JtWJbB2T1ozDMpELUBrcF1fNydGYwD3uAFsXz2GDPOOXniWWc0wjFE5QwBDjHR3AgyRC5cNnhYE
	JCvWqvpcWD4QNOTr3Iw683F88yLq/aaPghCeiiJhAwTXhacT0gKdpDapS61kI/DBImkKjZ/tLNb
	uo/g38EpCUMitA5jfsPTPpmVUCPmJ0ksG21cubNNRltRPXW6YBGIMvROXH1ijYinbSY5I+TUAHJ
	4Sq2LGlWaJJed
X-Google-Smtp-Source: AGHT+IGbbKKdBnxcE917q6Ei+pU8l+/ETyCtOsYjSEOWzPRg71Rrv86cR/bfi3NhUj0QgDs/d+CLAw==
X-Received: by 2002:a05:6402:5241:b0:5d0:e826:f0dc with SMTP id 4fb4d7f45d1cf-5d81dd9cc74mr1175724a12.12.1734679487017;
        Thu, 19 Dec 2024 23:24:47 -0800 (PST)
Received: from ?IPV6:2003:df:bf0d:b400:75b4:5445:d424:a5f6? (p200300dfbf0db40075b45445d424a5f6.dip0.t-ipconnect.de. [2003:df:bf0d:b400:75b4:5445:d424:a5f6])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d80701c822sm1426756a12.77.2024.12.19.23.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 23:24:46 -0800 (PST)
Message-ID: <a6346fd1-3161-4130-8121-5d0e98fd5141@gmail.com>
Date: Fri, 20 Dec 2024 08:24:45 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 00/16] Device / Driver PCI / Platform Rust abstractions
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
 alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, tmgross@umich.edu,
 a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
 fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
 daniel.almeida@collabora.com, saravanak@google.com, dirk.behme@de.bosch.com,
 j@jannau.net, fabien.parent@linaro.org, chrisi.schrefl@gmail.com,
 paulmck@kernel.org
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org, rcu@vger.kernel.org
References: <20241219170425.12036-1-dakr@kernel.org>
Content-Language: de-AT-frami, en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <20241219170425.12036-1-dakr@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.12.24 18:04, Danilo Krummrich wrote:
> This patch series implements the necessary Rust abstractions to implement
> device drivers in Rust.
> 
> This includes some basic generalizations for driver registration, handling of ID
> tables, MMIO operations and device resource handling.
> 
> Those generalizations are used to implement device driver support for two
> busses, the PCI and platform bus (with OF IDs) in order to provide some evidence
> that the generalizations work as intended.
> 
> The patch series also includes two patches adding two driver samples, one PCI
> driver and one platform driver.
> 
> The PCI bits are motivated by the Nova driver project [1], but are used by at
> least one more OOT driver (rnvme [2]).
> 
> The platform bits, besides adding some more evidence to the base abstractions,
> are required by a few more OOT drivers aiming at going upstream, i.e. rvkms [3],
> cpufreq-dt [4], asahi [5] and the i2c work from Fabien [6].
> 
> The patches of this series can also be [7], [8] and [9].
> 
> Changes in v7:
> ==============
> - Revocable:
>   - replace `compare_exchange` with `swap`
> 
> - Driver:
>   - fix warning when CONFIG_OF=n
> 
> - I/O:
>   - remove unnecessary return statement in rust_helper_iounmap()
>   - fix cast in doctest for `bindings::ioremap`
> 
> - Devres:
>   - fix cast in doctest for `bindings::ioremap`
> 
> - PCI:
>   - remove `Deref` of `pci::DeviceId`
>   - rename `DeviceId` constructors
>     - `new`       -> `from_id`
>     - `with_class -> `from_class`
> 
> - MISC:
>   - use `kernel::ffi::c_*` instead of `core::ffi::c_*`
>   - rebase onto latest rust-next (0c5928deada15a8d075516e6e0d9ee19011bb000)


Not sure if resending is required, but after a quick retest the
Tested-by from v6 still stands:

Tested-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks

Dirk



