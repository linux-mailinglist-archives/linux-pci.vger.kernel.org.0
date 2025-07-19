Return-Path: <linux-pci+bounces-32587-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1529B0AE1F
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 07:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8137B587F8B
	for <lists+linux-pci@lfdr.de>; Sat, 19 Jul 2025 05:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC6D71CD1E4;
	Sat, 19 Jul 2025 05:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVlE7ZeT"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2935078F24;
	Sat, 19 Jul 2025 05:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752904026; cv=none; b=BNUVEPi2HntuJxfe1ZZodmuiU8PZutoFWI1YjoxWrfnOACYxc1QNG3/Sve8sgMppvnEyj4XfCcANYUl9KQVDyZIIVlhEvYfbt8oc7Op8BzErmft94yi+b71FRir+S8sy4WfXdyW3hbMRvcdFs9WCqVFcweXMUw4Wisev6VCeBoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752904026; c=relaxed/simple;
	bh=PU6+bMtwG6ODi/VMJSmBjlzuFarP7fURfVdOuDQxstk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VTUiVHClDQHv5CEqvH45hluVfJXN0iizDCE0ij3KV6u3Z9apATKF2MBdrnOMBJx3Zo2MJO3FByH9Zm5hXgIXeL+NGmPk7FmMojZ462w1UilHBaLpcusjdD0uEZvvB6rRGGJZaGWR35ww+DumPUUfjLuuNVjuQLi57RTUVc3+A5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVlE7ZeT; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4538bc52a8dso21453685e9.2;
        Fri, 18 Jul 2025 22:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752904023; x=1753508823; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45DRJ943PH1uZjkYeA3qrUyN7AHk/vSSFSJZSM0zO8g=;
        b=NVlE7ZeTog1wEZs5gGplFcO+bPY048Rohsj9dofHMfvjZ/gnTPUKZ03CKWq+xpwHkI
         67s9KnX+9u26uaKTt74jiBfHDA7WFj+hwedK84J21SP9jwrfC3FmUGRi+kuaLEln4s9D
         GM1J79+dSHDCdLuhn1I3raLZKop/+qGB+bKiU9eJdWjab2xQl5rHy7Op30t5ZKZxm41s
         Div+Pk0DIBv3kMjAWpEo/5+cW5z1NIf9tDZez0JsrmSSwUeGLsF3Ufe8apt0EgUIwb9p
         pTHnknfnqUJIfoZ7DiJeCOEMZM0wNmS/CEInd+2cC7ykmQVVcAiSSWDukYvnrjr9frmP
         wgFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752904023; x=1753508823;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45DRJ943PH1uZjkYeA3qrUyN7AHk/vSSFSJZSM0zO8g=;
        b=FmbKMNWUNNmIjxUAdzV99KkmzhhNkpT+Gs7zKfYWTDiTOIkmZSRGhxAqBdu/XMVmvK
         lu/0yB0Dxr/ygMz2h1qpFUS8DVZ21s6lTnfUJ2e2XwmKHRbTox/OnjmidbxvT8hf87P1
         xlI+m7UUX8SGKkpwgW+FIDEnisFdWmCqzFDHO4ADFRBZ5VsGbamXqOrD2tm157kntENp
         RrSELgj5hA1lQnGWJwkXtvz0rIcct+6aGVgI9JLceGOTJ3wtvirXVOA78LMUyfMxsGBs
         EzoWSWc+lqsh5mTnGHSxbm+9OBg3G8HZ+RT7h/TIC4diYbepHfot/5AOWvE3XCgWzmkr
         Rb5A==
X-Forwarded-Encrypted: i=1; AJvYcCW/UEDwOfDX5uOiYET0kMHqW2XEp/cdywQj9Z+cd3kcfdOWFk7beIvdbilTyq+E6YdUHTXwY5cok+sN@vger.kernel.org, AJvYcCW9SBdLvm5C46brR15jeXWAJVtaGYKTsnBR2jVkRR0y3J4u49PKHYtGBWto5ORNHvQLLUJFdz/4mUhJnPQ=@vger.kernel.org, AJvYcCWAsRNOsxjLJzoNYXChQS5kCva63eKRgm+tKmTKPVD+jxiP+AZG2Nb7VqigTSqv7dcWJN87zjZEvxi9Vn3p9zY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWm9UpCKMvUnQeuyzsCL7SXU6ABExakAXrxnTgDSpZJ1JhuObn
	H0+MVLW9grMwjLXZ38nafdpADV+por+IoR8N9XjgcP306LnUnmb1DXrv
X-Gm-Gg: ASbGnctanglkHHho2k4vCd2pAd7FUFPbYE7j61+tEkBZMYyedUbXhR9pXCItIJY5WxM
	M+RxevDG+G9TK/YzrO7eGDwUUwpRZ14iEMNSR5La4N33BPsdZOmb4L9t9pGyRO43KCAifGqH1Qg
	7m/yE0JdjLT7hoXIYT1zitvOsTasw+ece/n15dLJJLhqwvUyKBWbX+fkZxY6C4Lvu59xyHZqv90
	Zbagy+0B+Yr7wtxkmIf7MIdqF2cT/N7+PINguzPAiuReqbUxWoMcVR5vQvldP+ZP8yGVca51yje
	xrSU8onoRxqMEOfwOUtLyE3vewO4MCPwKBG7hOQ1vUk4f3nYkC1gclN4+TrFVmyBytrlwzTar6/
	5aPrjM/Ae1STOqd/ByhhGs+4+jA4J20hk+ZN/JVfVrdcS0jB5cCPNzbSsVob/grGKLPNQC42XQA
	XMhAuNCheVBGvvzo3x1alPXZlNwjPH21UCrEAnWAoZLieq03Xam2xemA==
X-Google-Smtp-Source: AGHT+IHhS6bMWenEzNVcabowMKTZAcZtfPDP6MZZSiz4rLlTpiKudauUsqi5phKuGMQKtOrDPXLdMg==
X-Received: by 2002:a05:600c:8415:b0:456:191b:9e8d with SMTP id 5b1f17b1804b1-4563b8aa5f5mr50762895e9.11.1752904023028;
        Fri, 18 Jul 2025 22:47:03 -0700 (PDT)
Received: from ?IPV6:2003:df:bf40:e500:3f40:b5c8:4953:8f80? (p200300dfbf40e5003f40b5c849538f80.dip0.t-ipconnect.de. [2003:df:bf40:e500:3f40:b5c8:4953:8f80])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e57200csm97765325e9.0.2025.07.18.22.47.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 22:47:02 -0700 (PDT)
Message-ID: <ce656239-08a1-49e8-86b1-b33d0cdfbcd3@gmail.com>
Date: Sat, 19 Jul 2025 07:47:00 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Benno Lossin <lossin@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org>
 <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>
 <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org>
 <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org>
 <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>
 <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>
 <C4A101A7-282D-4A67-A966-CF39850952EA@collabora.com>
 <DBAZRNHGIGL8.3L2NGPCVXLI25@kernel.org>
 <DBAZXDRPYWPC.14RI91KYE16RM@kernel.org>
 <18B23FD3-56E9-4531-A50C-F204616E7D17@collabora.com>
 <DBB0NXU86D6G.2M3WZMS2NUV10@kernel.org>
 <1F0227F0-8554-4DD2-BADE-0184D0824AF8@collabora.com>
 <AACC99CD-086A-45AB-929C-7F25AABF8B6E@collabora.com>
Content-Language: de-AT-frami, en-US
From: Dirk Behme <dirk.behme@gmail.com>
In-Reply-To: <AACC99CD-086A-45AB-929C-7F25AABF8B6E@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Daniel,

On 13.07.25 17:32, Daniel Almeida wrote:
> 
> 
>> On 13 Jul 2025, at 12:28, Daniel Almeida <daniel.almeida@collabora.com> wrote:
>>
>>
>>
>>>
>>> (2) Owning a reference count of a device (i.e. ARef<Device>) does *not*
>>>     guarantee that the device is bound. You can own a reference count to the
>>>     device object way beyond it being bound. Instead, the guarantee comes from
>>>     the scope.
>>>
>>>     In this case, the scope is the IRQ callback, since the irq::Registration
>>>     guarantees to call and complete free_irq() before the underlying bus
>>>     device is unbound.
>>>
>>
>>
>> Oh, I see. I guess this is where I started to get a bit confused indeed.
>>
>> — Daniel
> 
> Fine, I guess I can submit a newer version and test that on Tyr.
> 
> Dirk, can you also test the next iteration on your driver? It will possibly
> solve your use case as well.


Now, I'm slightly confused ;) I just saw your version 7 of this

[PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and handlers
https://lore.kernel.org/rust-for-linux/20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com/

and somehow was expecting something like

fn handle(&self, dev: &Device<Bound>) -> IrqReturn

there. I.e. to get a bound device passed into the handler.

If I misunderstood the discussion and this is supposed to not be
added: Any hint how to get the &Device<Bound> from the probe
function/irq registration into the irq handler, then? To be able to do
something like

fn handle(&self) -> IrqReturn {
  let dev = ??;
  let io = self.iomem.access(dev);

Thanks,

Dirk


