Return-Path: <linux-pci+bounces-32315-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FDEDB07CF7
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 20:32:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02F421C27385
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jul 2025 18:32:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D502853F8;
	Wed, 16 Jul 2025 18:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bbgCDidi"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEC2C214818;
	Wed, 16 Jul 2025 18:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752690732; cv=none; b=hrkMm75lUiICgIllDr8KsXooJ4pvPTvsc3ILOx/eiJC+D/3+Fbj+DIgOfp5lcvPBfKdrO5NX159me9oGahrEpRFkJZAG1JilX9g3IBWfTydfIs5S7TMEWXWZGtKAmZj7wA8CP2HNY37NvPnY+lOu0QHIjsIBc8tfug26ZtBDnMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752690732; c=relaxed/simple;
	bh=e5V6NxpLHkzaydOCpBkdLBKCHAWL2cajEdlz8tgTuk0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=sEFkedsKjn4hLc3b+470Gh6OdSBMa+qIGjrPBEsrkMfwfmjF3tpeV+TcqCMUGoFWoZl/VStbzZqMESUcDsyCNrKxJG9fUzHs3QIomp0qkU16r54p91t1OR01GjcBp8Z0aHLVnk1jc1oSF12rQuSX26Uz6BmghGAqgf+z0EeAHy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bbgCDidi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCCF2C4CEE7;
	Wed, 16 Jul 2025 18:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752690730;
	bh=e5V6NxpLHkzaydOCpBkdLBKCHAWL2cajEdlz8tgTuk0=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To:From;
	b=bbgCDidi13Jncl1K4t0wBOQo8Lg97LONoZqiPwipvjnT5BLIaVAf8QQfQ0MHC5N0J
	 9LZfnrZYixVoa3QtKnLypUcwzI2ZVQfgPqQz/vXVbTI8+A6g5eKVS2vbF27uyATMTA
	 lOSjMWytC0CYekcajCybcjhWDB/ivZnF9+lPsihDuD8lk1Jd20ANBASVBPVP6oiPUH
	 uoOZiqOsDHFfouZH8pMLLGo4x1HWnQ6wgRuKJosn3pmjvxgc3BvsZ5WqIp5yVEv3bF
	 Ce/aq1xvGVXlxvwo6oIyntH4Wl+nLP2Yz3094rl7VLMMWVWDjfIx/cJYMHchqMUE+q
	 PGWQ8eJ7++wcg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 16 Jul 2025 20:32:05 +0200
Message-Id: <DBDP0BJW9VAZ.5KRU4V4288R8@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/5] rust: dma: add DMA addressing capabilities
Cc: <abdiel.janulgue@gmail.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <bhelgaas@google.com>, <kwilczynski@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
References: <20250716150354.51081-1-dakr@kernel.org>
 <20250716150354.51081-3-dakr@kernel.org>
 <0984E8E7-C442-42E6-A8E7-691616304F6F@collabora.com>
 <DBDO8FVL9NKE.201JEW4MRHS6F@kernel.org>
In-Reply-To: <DBDO8FVL9NKE.201JEW4MRHS6F@kernel.org>

On Wed Jul 16, 2025 at 7:55 PM CEST, Danilo Krummrich wrote:
> On Wed Jul 16, 2025 at 7:32 PM CEST, Daniel Almeida wrote:
>> Hi Danilo,
>>
>>> +    #[inline]
>>> +    pub const fn new(n: usize) -> Result<Self> {
>>> +        Ok(Self(match n {
>>> +            0 =3D> 0,
>>> +            1..=3D64 =3D> u64::MAX >> (64 - n),
>>> +            _ =3D> return Err(EINVAL),
>>> +        }))
>>> +    }
>>> +
>>
>> Isn=E2=80=99t this equivalent to genmask_u64(0..=3Dn) ? See [0].
>
> Instead of the match this can use genmask_checked_u64() and convert the O=
ption
> to a Result, once genmask is upstream.
>
>> You should also get a compile-time failure if n is out of bounds by defa=
ult using
>> genmask.
>
> No, we can't use genmask_u64(), `n` is not guaranteed to be known at comp=
ile
> time, so we'd need to use genmask_checked_u64().
>
> Of course, we could have a separate DmaMask constructor, e.g. with a cons=
t
> generic -- not sure that's worth though.

On the other hand, it doesn't hurt. Guess I will add another constructor wi=
th a
const generic. :)

I also quickly tried genmask and I have a few questions:

  (1) Why does genmask not use a const generic? I think this makes it more
      obvious that it's only intended to be used from const context.

  (2) Why is there no build_assert() when the range exceeds the number of b=
its
      of the target type? I would expect genmask_u64(0..100) to fail.

  (3) OOC, why did you choose u32 as argument type?

