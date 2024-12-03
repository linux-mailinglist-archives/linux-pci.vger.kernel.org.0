Return-Path: <linux-pci+bounces-17565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1024F9E17D0
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 10:37:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2F645B361FF
	for <lists+linux-pci@lfdr.de>; Tue,  3 Dec 2024 09:22:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 560921DED4D;
	Tue,  3 Dec 2024 09:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I613wnmC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C951CD204;
	Tue,  3 Dec 2024 09:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733217675; cv=none; b=P4AQUV3W4c+/IGl+tgSZWH8qafCqsrzXNA2llwxs6MlZqMIEJB5g+B5p27X+CAnGTLI2x2g/2yCZt07Y07tmAztrYieMZNKC3yXaFrtMrHjx5Y/2nFvfIrvcfBHrpwCTq+w4grTojfJAWZXgmXFyFTDfT8Y/nM1ULDYNEOzZOMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733217675; c=relaxed/simple;
	bh=cPYxrvjdP6SGqJbH8TZQtoM+u/6iqcvQ/yJ8kNSftb0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=T7gb8RJbA5KmKDzeNyRr7m1gKKEZKoambeG77th9g3yNwX3mUFEy+CQUXCRY+bmsGGq6BI2LAi0fdfTiXB6VmXxn7uZ24gjeKaohIJtaH968/ofKGzngMB0Ls8YDZLwYg3wLlYvNjgDWCOqq+he/3/ZOGLkTQYTpOUPGoPhmVH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I613wnmC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DB9DC4CECF;
	Tue,  3 Dec 2024 09:21:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733217673;
	bh=cPYxrvjdP6SGqJbH8TZQtoM+u/6iqcvQ/yJ8kNSftb0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=I613wnmCIOKB15gqKYn613rxiX9OCD+ZyVVZ0fdR2WDw3y6R35QUap4YmrOQl9G4M
	 mwvfoBCKYaj3bg9pw9wXeBlHZyiOqHDdh4EEYkf1/0fabi+WFZemOAbDBDkxT062uG
	 Zb2Jztog5RsBdsYi7054ut+oKquO1QmbE5qnnjv9vYdiK08WqHzptNQFVToLqikPW+
	 o/YTkv07I/vOagqwWeIvVbj99ZQ27uOuKUbaiPKIazE/xHYUI+khDZ3WwyvWUZCMf5
	 zMOlxWKsZSfS2lUslV2y0Q15OmM+m5hgl5FNHW1eigyW3w61e/BEpzP7+rBaJIeDZi
	 RIzt/9q5DKWbw==
Message-ID: <a25f7cfe-ef43-4841-ab81-0ecf59b20f15@kernel.org>
Date: Tue, 3 Dec 2024 10:21:06 +0100
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
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <CAH5fLgjcy=DQrCYt-k40D4_NcwgdrykUW9d74srGn5hxxo2Xmw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/29/24 2:26 PM, Alice Ryhl wrote:
> On Tue, Oct 22, 2024 at 11:33 PM Danilo Krummrich <dakr@kernel.org> wrote:
>> +/// A guard that allows access to a revocable object and keeps it alive.
>> +///
>> +/// CPUs may not sleep while holding on to [`RevocableGuard`] because it's in atomic context
>> +/// holding the RCU read-side lock.
>> +///
>> +/// # Invariants
>> +///
>> +/// The RCU read-side lock is held while the guard is alive.
>> +pub struct RevocableGuard<'a, T> {
>> +    data_ref: *const T,
>> +    _rcu_guard: rcu::Guard,
>> +    _p: PhantomData<&'a ()>,
>> +}
> 
> Is this needed? Can't all users just use `try_access_with_guard`?

Without this guard, how to we access `T` with just the `rcu::Guard`?

> 
> Alice
> 


