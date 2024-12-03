Return-Path: <linux-pci+bounces-17568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3590C9E17D2
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 10:37:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2B828374B
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 09:37:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C7AA1DFDA7;
	Tue,  3 Dec 2024 09:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kk3OqcZf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D611E1037;
	Tue,  3 Dec 2024 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733218566; cv=none; b=QiQjIfn+bRq6ogqm+KDYEOTMEQW+12YIcbHlYexCPpy69zfoyTxbEggqnv74lbCgGKbHHAiX8x/0aIllODnf1ID6UsFDx1EZ9f5nehNo8+ZMDMYEUxCMq2Cvyf32LZSd4kLOFIjTB84CFmzX/VPrjgY797Y6qSAJsxZ1G++AzUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733218566; c=relaxed/simple;
	bh=zpqXFt5tnf1YCq+B4voS99/2kGzb284Wk0LsjetHOIg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=taLwGmYzODoyLM+Pm9CGRsA9zTAGdum72Q5THTRa5irlE5j9ry6z9JAO9Gy1x8Wvd3l6tHi4S3g0EB9V2zgPz8m11H61CSMdGQPsBYfBKkDpkro6eSTc3LPj9YKajDpl8/GW5v0dB7aZf/+pHCBwhz8BdEzDxj2VL+6XgWE9AsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kk3OqcZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA4CC4CED9;
	Tue,  3 Dec 2024 09:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733218565;
	bh=zpqXFt5tnf1YCq+B4voS99/2kGzb284Wk0LsjetHOIg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kk3OqcZferWnLmoN0Lp1VCUcmnXrJmOe0dONqTADouwZi28dHF5k8tZGzc7/kQivi
	 QEj3DsxGsfcpcEgKPlThPA100bs6FxR467Xw43JSFvzGzR36EqiyvIbnsC3Ww+dDlx
	 YIB4AJqnFoBc5UGkB89P/BO/cgRy9R/xTxIe40fOPqyfu9aPdiHj9YXH4PjVziiG8l
	 zF1D4m+VfLZJ1+fpt/SqdIR+Psg7UJebiZW570Zh2ZnIDVMQWds0Jv6rvss6yWLTFg
	 d3yMoQlSjB7dCMWDJ4HpBTK3HT4CcrEU831ZJiWQ8+QiqWJSHB1Pvw22cT3Vd7+rMS
	 MxZrF1tKP+3xg==
Message-ID: <5f34564a-618e-457c-868b-0a3901b6d69b@kernel.org>
Date: Tue, 3 Dec 2024 10:35:59 +0100
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/16] rust: add `Revocable` type
To: Alice Ryhl <aliceryhl@google.com>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com,
 ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
 gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
 tmgross@umich.edu, a.hindborg@samsung.com, airlied@gmail.com,
 fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
 ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
 daniel.almeida@collabora.com, saravanak@google.com,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 Wedson Almeida Filho <wedsonaf@gmail.com>
References: <20241022213221.2383-1-dakr@kernel.org>
 <20241022213221.2383-8-dakr@kernel.org>
 <CAH5fLgjcy=DQrCYt-k40D4_NcwgdrykUW9d74srGn5hxxo2Xmw@mail.gmail.com>
 <a25f7cfe-ef43-4841-ab81-0ecf59b20f15@kernel.org>
 <CAH5fLgjgvq40mEsFZZLGi1s_OHNBsOXPT1Si6vM2sruM=tibQg@mail.gmail.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAH5fLgjgvq40mEsFZZLGi1s_OHNBsOXPT1Si6vM2sruM=tibQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/3/24 10:24 AM, Alice Ryhl wrote:
> On Tue, Dec 3, 2024 at 10:21 AM Danilo Krummrich <dakr@kernel.org> wrote:
>>
>> On 10/29/24 2:26 PM, Alice Ryhl wrote:
>>> On Tue, Oct 22, 2024 at 11:33 PM Danilo Krummrich <dakr@kernel.org> wrote:
>>>> +/// A guard that allows access to a revocable object and keeps it alive.
>>>> +///
>>>> +/// CPUs may not sleep while holding on to [`RevocableGuard`] because it's in atomic context
>>>> +/// holding the RCU read-side lock.
>>>> +///
>>>> +/// # Invariants
>>>> +///
>>>> +/// The RCU read-side lock is held while the guard is alive.
>>>> +pub struct RevocableGuard<'a, T> {
>>>> +    data_ref: *const T,
>>>> +    _rcu_guard: rcu::Guard,
>>>> +    _p: PhantomData<&'a ()>,
>>>> +}
>>>
>>> Is this needed? Can't all users just use `try_access_with_guard`?
>>
>> Without this guard, how to we access `T` with just the `rcu::Guard`?
> 
> I don't think `try_access_with_guard` provides any access that you
> can't get by doing `try_access_with_guard`.
> 
> That said, I guess this guard functions as a convenience accessors, so
> I don't mind it.

What I mean is, how does the following work without `RevocableGuard`?

```
struct Foo;

impl Foo {
    pub fn bar() { ... }
}

let data: Revocable<Foo> = ...;
let guard = data.try_access()?;

guard.bar();
```

> 
> Alice
> 


