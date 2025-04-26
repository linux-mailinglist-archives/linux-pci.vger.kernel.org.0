Return-Path: <linux-pci+bounces-26819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08B6BA9DC5B
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 19:03:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 531F69264D5
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 17:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A2CC25D540;
	Sat, 26 Apr 2025 17:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0S3V1QR"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7CE1DF759;
	Sat, 26 Apr 2025 17:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745686994; cv=none; b=Hi4D1QXrY1gLsEiEpiPOO83bL8Jg2UZKmlkKc42kIfo6FIANC+dDOnYD+i86daZFFmBdhCJGdoSmApjqhw1tYfKiLqjanuW/2MCiHwzM2xfwDglQ3RZldYrxvLojDiRI/bRQte/kiGsiJfVTD5K0OPHEe+plbvWI3QWCb5t2g+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745686994; c=relaxed/simple;
	bh=03zwjvkFYEhG92+qrn2T8pzd8ejfnuU4rL0Z97HZbwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G2rz8GBubWfSYLzMycAXipGSM79dHfWJp3weaAKrdR3KVyIka6HXOydEbWnY/Qehsa+tTzOjvkw5+4m4NJUs8q0Q4N2cpLK5E4teX8QJaTBQimTnnnWOETos1kShU+ORqK/zpPNXMTx3Cq1W8nVa9eCmw5X/5KsuDCDWQaHETpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0S3V1QR; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-39ee5ac4321so3328458f8f.1;
        Sat, 26 Apr 2025 10:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745686991; x=1746291791; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Cp/74oQlHgQhlB2p0NP6nWfW2urC5wbKdAuUswkKDNc=;
        b=H0S3V1QR7z2S1xe2BB+RJQZdfaxieTE8sbjV07XGuKGreK57srBDr2gfkiDxqD6Ehq
         Gch/kNiWMXb0ltxeuFLGt/xUvOKd3gjwFWICMBIcBLCunpzDEE8nutC4fWgasrN+mJ5h
         lWn5X8Az88ElzBiwsjM05Y3oBTXhVEsEqvRSLH3D8JpMI8Rf/5HY97Om1R6S/Avd5qGr
         VEoS6HFHBQmFevYfKGIR3sCSqqv1+q0+fEl6strWFbubY9OW/Jr0rL3w6hL5ZuEMmRBd
         0gB5yOcmVTnzXq1oirtFcvjeBxxYuDfZpepEajfTZG/dAOKCAtW+A3eguBRDGfyM8PPi
         rt2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745686991; x=1746291791;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Cp/74oQlHgQhlB2p0NP6nWfW2urC5wbKdAuUswkKDNc=;
        b=lYaU4pyjIyTi9XOvK3YPfwJEaK5945rLomjg0AWmrbpVqrk4qO4osdwE9RKQW4JIhY
         YSfCG3Hdd75pHGnsdLY07TCTyz2nicyEDoIS0y8aumZKkItxZJAVxX2NPJSbYDCCFoek
         WKRbaMvS9YytcF/jHOwRLqDch96TaybrERBc6iFgu3YT7uxLB1e5s4xB8AYHN3cWPwYf
         WbU6dsElFFtKQgGKOCzdDLqYN0jznLaC9ESSAHZprhKndkYv9eYeHXvSr/veTl+EiMNV
         n5QrnbO381wC3ytS/VPa1LN1GPsdOo4dQnxS9SIi9yn5penCC5uqh0OowX3ecLXLLriO
         qOSg==
X-Forwarded-Encrypted: i=1; AJvYcCU7osbvLNJNrWwucl1IacPQpPakdmGuEZH+GzrAaosP5KXuIvRXMB448IUhyvxYfdBi5WYsLt1rjksL@vger.kernel.org, AJvYcCUJuf6XZTX1gyen7z1QfzTa48hTenTRzqXs8nYoykRk/LPV3ilsiYYcQQhhsCwcb64GXatqWHiCb3q5u4o=@vger.kernel.org, AJvYcCXNfB1BfKVhbTFHqkW8+gqcA5/YYscgIVPP30+H7DmfQ5S0GkvQNwRiIWse5pDMNQggfsW256hOwaupvGbN60M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/tBGQ0m5GexVwipXisceP4c+ydOIXMNKA1lt+Vt0/xr9Grvet
	P3GJR0K8IQHBOqTF3ugOGTVvQJWv5rxp3Vfd8zmWxuFq163+6f1r
X-Gm-Gg: ASbGncsNbCXIgQ/cXHZ06jpcSqBsXI4I+erYpoE+oCDAOcv9bcpTU8f+gkJNgigM7Cy
	/W8LFVSAiHTD261CFtJ8vtNRUUr3JLc6n4HEvubP5yzMJ0pp+wm1aIQyN7f71GaBUWDLGZ1/cEO
	8Zohnl9PPytcV6QuDa8ubYvmNat2V7Dpgr8t36zAYBCq2N17jcmtW5wSRonIUJz8EyR0p9S7bZB
	dwUg5ViPwg8cWKmqy7RN7TTq68eKjrY0Rts65BdeX0LsNJ8vmPvC8/o6s9Opoq0KRyAH1bx25ny
	ne2FkkwzieMdCLdzhKU3ygkK28DP1n7zDpsROfRwoTtr7dB9/MLQUg==
X-Google-Smtp-Source: AGHT+IHywWch+T5IWv3eRg7oA6vXiUjd8/epyZW9drC7HEQUbATbsi7aXsStUfAMRqKcbF+s2iLN+w==
X-Received: by 2002:a05:6000:290c:b0:391:47d8:de25 with SMTP id ffacd0b85a97d-3a074f39725mr4296416f8f.41.1745686990820;
        Sat, 26 Apr 2025 10:03:10 -0700 (PDT)
Received: from ?IPV6:2001:871:22a:99c5::1ad1? ([2001:871:22a:99c5::1ad1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a073e5e198sm6219061f8f.97.2025.04.26.10.03.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 26 Apr 2025 10:03:10 -0700 (PDT)
Message-ID: <6dbec9b3-b1a2-4fe7-9861-6bc879d7332c@gmail.com>
Date: Sat, 26 Apr 2025 19:03:09 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] rust: revocable: implement Revocable::access()
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org,
 rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org,
 zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com,
 acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com,
 acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
 linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250426133254.61383-1-dakr@kernel.org>
 <20250426133254.61383-2-dakr@kernel.org>
 <aa747122-fc78-45db-a410-ceb53b4df65e@gmail.com> <aA0P4lr0A2s--5bI@Mac.home>
Content-Language: en-US, de-DE
From: Christian Schrefl <chrisi.schrefl@gmail.com>
In-Reply-To: <aA0P4lr0A2s--5bI@Mac.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.04.25 6:54 PM, Boqun Feng wrote:
> On Sat, Apr 26, 2025 at 06:44:03PM +0200, Christian Schrefl wrote:
>> On 26.04.25 3:30 PM, Danilo Krummrich wrote:
>>> Implement an unsafe direct accessor for the data stored within the
>>> Revocable.
>>>
>>> This is useful for cases where we can proof that the data stored within
>>> the Revocable is not and cannot be revoked for the duration of the
>>> lifetime of the returned reference.
>>>
>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>> ---
>>> The explicit lifetimes in access() probably don't serve a practical
>>> purpose, but I found them to be useful for documentation purposes.
>>> --->  rust/kernel/revocable.rs | 12 ++++++++++++
>>>  1 file changed, 12 insertions(+)
>>>
>>> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
>>> index 971d0dc38d83..33535de141ce 100644
>>> --- a/rust/kernel/revocable.rs
>>> +++ b/rust/kernel/revocable.rs
>>> @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self, f: F) -> Option<R> {
>>>          self.try_access().map(|t| f(&*t))
>>>      }
>>>  
>>> +    /// Directly access the revocable wrapped object.
>>> +    ///
>>> +    /// # Safety
>>> +    ///
>>> +    /// The caller must ensure this [`Revocable`] instance hasn't been revoked and won't be revoked
>>> +    /// for the duration of `'a`.
>>> +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
>> I'm not sure if the `'s` lifetime really carries much meaning here.
>> I find just (explicit) `'a` on both parameter and return value is clearer to me,
>> but I'm not sure what others (particularly those not very familiar with rust)
>> think of this.
> 
> Yeah, I don't think we need two lifetimes here, the following version
> should be fine (with implicit lifetime):
> 
> 	pub unsafe fn access(&self) -> &T { ... }
> 
> , because if you do:
> 
> 	let revocable: &'1 Revocable = ...;
> 	...
> 	let t: &'2 T = unsafe { revocable.access() };
> 
> '1 should already outlive '2 (i.e. '1: '2).

I understand that implicit lifetimes desugars to 
effectively the same code, I just think that keeping
a explicit 'a makes it a bit more obvious that the
lifetimes need to be considered here.

But I'm also fine with just implicit lifetimes here.

Cheers
Christian

