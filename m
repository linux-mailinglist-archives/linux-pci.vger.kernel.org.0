Return-Path: <linux-pci+bounces-26822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F597A9DC6B
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 19:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ACAB74A18BE
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CC3A1CBEB9;
	Sat, 26 Apr 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l3UR78Ns"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B88A256D;
	Sat, 26 Apr 2025 17:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745687395; cv=none; b=Y9EH02F1+IvGUzkPNrmNXLhYGIUXj6iWf5lZy3k3ekiSR6k+HlbaQwgmBZFf74kU2iUS8vUiGEtxdg11oBquPN8CHbl2uueYlHQBUjBUZ7Sus5HpA5UwJwWeXa9XX0qYbrJ5tkdqZ2P8NGQiSYhI5LMLRPelwZR75/wsuGVD9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745687395; c=relaxed/simple;
	bh=1F5lseiUmudIV0d8a9n5j4zwuRaUWR3uS5tvNveGfX8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DJhz+DGZxZyut3luuSnO+F14i6LiUv64xU1xRh8MQcnQG8VLn3BlouUi4f8rgdqtwLT2GfbldIFdMS9T/n+EHOh70lsnF/tzZ09hr2PfAvdvtJTTqK36ggZa0eDD19Q0adfb/Ean5+6bOt4xwTL+z6Eqey/n0ZvlEOluXmyK3WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l3UR78Ns; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so18015195e9.2;
        Sat, 26 Apr 2025 10:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745687392; x=1746292192; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VZpCowXn8Bq+SIL5om4pijJl5H/YfzoxfjSisSEzwMo=;
        b=l3UR78NsEG/85EwTLB/g8aquG/eNn5Yz19YAX7gvm8T+KE1lrA+WAEWAiAUFKecMTl
         iTOFjpX5S0y9Uro9zZzHTbMiOBeVwGjQR6ukj4V30jLdAXsN9qbBa2k4l5Wf6OCZ6UMA
         2qSLeZF7H2qRp78kdMmOnKpJFRnnBOirxE957naUEcILaEeXCl5Y7PqPkEdQknbX9qSa
         NGOEqhAls3uctDx17k37gHXU7o+VTioE3CMYBN2ODqktYHSW+C1tbwcEGdci4RSATRh8
         3mBms1EwojbaIe8Ol6+arp3oOv9KmbogHiooSrUroCdJZpEAuVnpqs7vrwWJ9oFdrqlG
         PFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745687392; x=1746292192;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VZpCowXn8Bq+SIL5om4pijJl5H/YfzoxfjSisSEzwMo=;
        b=Fv9rWrhOqWeRmKqCiJgjyjIgWRxGA0AItbr7YGOcAEQL9LVYDzuQiEh6keM7O7jYRS
         R5acaaxOkh8fcOuVr/FtvOTj7xPJNflyS4dsq8EJqU+YugEnnw+/T1ayM+g0VwxHZIDC
         8ELJUC0vlgi/xnJ+ptDFyS/lPnmjLAxu1uS9omL4VlZfo0ABXpLgBfbqGAg2Z0FurpN6
         r6dTXcW5mJt0ztK6K9x8Dmf4zalxzXqbes5QTTo56rK08ocWlAj0NppPZVaqQjORoe6N
         xk/FRfsHsPCR/AbAyODwztM+nsQhPnrAXDY9i6kiP5CW8xmoOpJ90bUrCAHjroCUZXew
         NkXw==
X-Forwarded-Encrypted: i=1; AJvYcCU78j8NNsFItDavSu9nRhbVsUkT9rsKbjzP1tBB+jni5LoInbJ1Y8FDYcdjBeUmG97B4jUXyGJ4sZc7@vger.kernel.org, AJvYcCVhpvEG2GSY70s3/e/QPekjrQBRotxqx7rXaHEKOOkBUgmQQRdQ7K/BUQZ0esrcHg5w343XHJ5HsYy+NAA=@vger.kernel.org, AJvYcCWj4IcqdciajtdMda3Z0M8BdW6cSxm1lMYekgNRipq9eisKfRMbjmhk6nbnj3iwPuixNKfuWMKuczItXIdheUQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLvZyVpJo37o9sHc6BygrNxIaTuGcD80mIU2NQRgMcp3pE+cWW
	+VBK16PIrbnRohsC46p5UzIdLUxcoS/l09oqZFsHMcrWvtR7AEPY
X-Gm-Gg: ASbGncv2rUIROMvAFOcIBmxa7vx749y/je3o/On/njpHnyCjhkF327ZUXNiS8Nvyoqa
	1iEGd95h5wpHyPtUrPx82s/QwPj7SxAN+gfMhAxvSevg7EKTl1iIC9MjPWBxZbr+CthKyx3bx5j
	wN4aMdkaoziQPnQD/swJ72lb/50ROB+njUujAhrUlGGe13lf2tJmOkJz1OgaAqaGuAynWG7xUsC
	YLI4cRux/hXINh5ro4S4TKp74/JVZYMTs2Rpw1B3flfJOvlJgUTj+S0SVu6INsHQYpQP6ptYqGt
	e7iGcR6Mhvmi24AwEtwg1woxLwX1Le7e2BX+k6uUbaqDWPaRDUoNSw==
X-Google-Smtp-Source: AGHT+IGbqFRzvsYkFKg5nngD2IA02FN5+hFghRZXftRZRJNXiK1vKT0j0QNqOJSPo8KqXIXdjMvg9w==
X-Received: by 2002:a05:600c:1e03:b0:43d:24d:bbe2 with SMTP id 5b1f17b1804b1-440a66b7b14mr44715965e9.28.1745687391635;
        Sat, 26 Apr 2025 10:09:51 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-440a53108f2sm66564295e9.19.2025.04.26.10.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 10:09:51 -0700 (PDT)
Message-ID: <03fc7763-86ac-4b14-acd6-b1e400676dab@gmail.com>
Date: Sat, 26 Apr 2025 19:09:49 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: revocable: implement Revocable::access()
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com,
 jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com,
 joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, gary@garyguo.net,
 bjorn3_gh@protonmail.com, benno.lossin@proton.me, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 Boqun Feng <boqun.feng@gmail.com>
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-2-dakr@kernel.org>
 <aa747122-fc78-45db-a410-ceb53b4df65e@gmail.com> <aA0P4lr0A2s--5bI@Mac.home>
 <aA0RgOL09bBa0M19@pollux>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <aA0RgOL09bBa0M19@pollux>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.04.25 7:01 PM, Danilo Krummrich wrote:
> On Sat, Apr 26, 2025 at 09:54:58AM -0700, Boqun Feng wrote:
>> On Sat, Apr 26, 2025 at 06:44:03PM +0200, Christian Schrefl wrote:
>>> On 26.04.25 3:30 PM, Danilo Krummrich wrote:
>>>> Implement an unsafe direct accessor for the data stored within the
>>>> Revocable.
>>>>
>>>> This is useful for cases where we can proof that the data stored within
>>>> the Revocable is not and cannot be revoked for the duration of the
>>>> lifetime of the returned reference.
>>>>
>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>>> ---
>>>> The explicit lifetimes in access() probably don't serve a practical
>>>> purpose, but I found them to be useful for documentation purposes.
>>>> --->  rust/kernel/revocable.rs | 12 ++++++++++++
>>>>  1 file changed, 12 insertions(+)
>>>>
>>>> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
>>>> index 971d0dc38d83..33535de141ce 100644
>>>> --- a/rust/kernel/revocable.rs
>>>> +++ b/rust/kernel/revocable.rs
>>>> @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
>>>>          self.try_access().map(|t| f(&*t))
>>>>      }
>>>>  
>>>> +    /// Directly access the revocable wrapped object.
>>>> +    ///
>>>> +    /// # Safety
>>>> +    ///
>>>> +    /// The caller must ensure this [`Revocable`] instance hasn't been revoked and won't be revoked
>>>> +    /// for the duration of `'a`.
>>>> +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
>>> I'm not sure if the `'s` lifetime really carries much meaning here.
>>> I find just (explicit) `'a` on both parameter and return value is clearer to me,
>>> but I'm not sure what others (particularly those not very familiar with rust)
>>> think of this.
>>
>> Yeah, I don't think we need two lifetimes here, the following version
>> should be fine (with implicit lifetime):
>>
>> 	pub unsafe fn access(&self) -> &T { ... }
>>
>> , because if you do:
>>
>> 	let revocable: &'1 Revocable = ...;
>> 	...
>> 	let t: &'2 T = unsafe { revocable.access() };
>>
>> '1 should already outlive '2 (i.e. '1: '2).
> 
> Yes, this is indeed sufficient, that's why I wrote
> 
> 	"The explicit lifetimes in access() probably don't serve a practical
> 	purpose, but I found them to be useful for documentation purposes."
> 
> below the commit message. :)
> 
> Any opinions in terms of documentation purposes?

I would prefer just one explicit lifetime, but I'm
not sure about others.
But I think either way is fine.

Maybe I should have written it more clearly that I 
only meant that the second lifetime makes it 
IMO unnecessarily complicated when reading it.

Cheers
Christian

