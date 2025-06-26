Return-Path: <linux-pci+bounces-30841-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 345EAAEA8AC
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE103AD47C
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 21:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACED425D1F1;
	Thu, 26 Jun 2025 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MpFWpcNv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F21019D06A;
	Thu, 26 Jun 2025 21:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750972827; cv=none; b=CBWVKeBwDla/PlVCjP5q/3hZto5ITFC4tzcswO34qO3pJMtWFnoKiyln7IUCkKUOGSaztgzFbuJaduVs7R2lCtB30O6LVJyKhHp7BWhKozRuyq9NCugd9ZzLC4ipv0yxa1CXAlVijA6Tgc8bhLYHqqOS4252N7cntQBXUMAhZwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750972827; c=relaxed/simple;
	bh=OHrl1UV24sECLcdoKKUjl/MCEiD+j72S/KlN+z+3AjI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DBG22lQhgrRuzkhpHnyaTGNPpoVQT4ZtqY7p/LTz2yz5UwJQfOucqePmnB2Hk25fbTfy4IfXJFyGlIvuFq+eGnVw459S01RRPN0Ec7SvJibOHHkT/rV8OacV25vB88mIkJr2rjB7meamtQlwdqErxl1yXA7ggoAfqgZa+SVO1qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MpFWpcNv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 992F0C4CEEB;
	Thu, 26 Jun 2025 21:20:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750972827;
	bh=OHrl1UV24sECLcdoKKUjl/MCEiD+j72S/KlN+z+3AjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MpFWpcNvFBHW/TbrieGMr4V1H2s1BBYKWVkwaRbaQ7Sm8tElnJLBnwacBK0F9bGYZ
	 Yrf8OHy23Kuh5dssuyaRv4xwivExURGjtSXOaqnKtV7Ezgy4ZBuhBX4RdjHBKYr2qP
	 8Y7jv2XJLy5MaXjQpVAObecEuJPAscbHDdv69vMaRazqMuVgxGpHR7SB6RG2nzNWKJ
	 abS02ndvyN01J7Voy3M1lADdJQ3xRrhMqF1EKbkab17mjnbsJGX9LJyVnHwTx1lvQy
	 BKnblLfxpGgFJEDyLNlSlrUSEMuhl8rd+9cws1GsjK3720fYrGh83beFbF/ulLB67D
	 ePCEW99EXibjQ==
Message-ID: <411adfbb-1110-434f-a22d-d60914be6968@kernel.org>
Date: Thu, 26 Jun 2025 23:20:21 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] rust: devres: implement register_release()
To: Boqun Feng <boqun.feng@gmail.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org,
 alex.gaynor@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
 lossin@kernel.org, a.hindborg@kernel.org, aliceryhl@google.com,
 tmgross@umich.edu, david.m.ertman@intel.com, ira.weiny@intel.com,
 leon@kernel.org, kwilczynski@kernel.org, bhelgaas@google.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-6-dakr@kernel.org> <aF2vgthQlNA3BsCD@tardis.local>
 <aF2yA9TbeIrTg-XG@cassiopeiae> <aF24vbtHgP-kYuBg@tardis.local>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <aF24vbtHgP-kYuBg@tardis.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 6/26/25 11:16 PM, Boqun Feng wrote:
> On Thu, Jun 26, 2025 at 10:48:03PM +0200, Danilo Krummrich wrote:
>> On Thu, Jun 26, 2025 at 01:37:22PM -0700, Boqun Feng wrote:
>>> On Thu, Jun 26, 2025 at 10:00:43PM +0200, Danilo Krummrich wrote:
>>>> register_release() is useful when a device resource has associated data,
>>>> but does not require the capability of accessing it or manually releasing
>>>> it.
>>>>
>>>> If we would want to be able to access the device resource and release the
>>>> device resource manually before the device is unbound, but still keep
>>>> access to the associated data, we could implement it as follows.
>>>>
>>>> 	struct Registration<T> {
>>>> 	   inner: Devres<RegistrationInner>,
>>>> 	   data: T,
>>>> 	}
>>>>
>>>> However, if we never need to access the resource or release it manually,
>>>> register_release() is great optimization for the above, since it does not
>>>> require the synchronization of the Devres type.
>>>>
>>>> Suggested-by: Alice Ryhl <aliceryhl@google.com>
>>>> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>>>> ---
>>>>   rust/kernel/devres.rs | 73 +++++++++++++++++++++++++++++++++++++++++++
>>>>   1 file changed, 73 insertions(+)
>>>>
>>>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>>>> index 3ce8d6161778..92aca78874ff 100644
>>>> --- a/rust/kernel/devres.rs
>>>> +++ b/rust/kernel/devres.rs
>>>> @@ -353,3 +353,76 @@ pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flag
>>>>   
>>>>       register_foreign(dev, data)
>>>>   }
>>>> +
>>>> +/// [`Devres`]-releaseable resource.
>>>> +///
>>>> +/// Register an object implementing this trait with [`register_release`]. Its `release`
>>>> +/// function will be called once the device is being unbound.
>>>> +pub trait Release {
>>>> +    /// The [`ForeignOwnable`] pointer type consumed by [`register_release`].
>>>> +    type Ptr: ForeignOwnable;
>>>> +
>>>> +    /// Called once the [`Device`] given to [`register_release`] is unbound.
>>>> +    fn release(this: Self::Ptr);
>>>> +}
>>>> +
>>>
>>> I would like to point out the limitation of this design, say you have a
>>> `Foo` that can ipml `Release`, with this, I think you could only support
>>> either `Arc<Foo>` or `KBox<Foo>`. You cannot support both as the input
>>> for `register_release()`. Maybe we want:
>>>
>>>      pub trait Release<Ptr: ForeignOwnable> {
>>>          fn release(this: Ptr);
>>>      }
>>
>> Good catch! I think this wasn't possible without ForeignOwnable::Target.
>>
>> Here's the diff for the change:
>>
> 
> Looks good to me.
> 
>> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
>> index 92aca78874ff..42a9cd2812d8 100644
>> --- a/rust/kernel/devres.rs
>> +++ b/rust/kernel/devres.rs
>> @@ -358,12 +358,9 @@ pub fn register<T, E>(dev: &Device<Bound>, data: impl PinInit<T, E>, flags: Flag
>>   ///
>>   /// Register an object implementing this trait with [`register_release`]. Its `release`
>>   /// function will be called once the device is being unbound.
>> -pub trait Release {
>> -    /// The [`ForeignOwnable`] pointer type consumed by [`register_release`].
>> -    type Ptr: ForeignOwnable;
>> -
>> +pub trait Release<Ptr: ForeignOwnable> {
> 
> My bad, is it possible to do
> 
> 	pub trait Release<Ptr: ForeignOwnable<Target=Self>> {
> 
> ? that's better IMO.

Sure, that works.

