Return-Path: <linux-pci+bounces-30760-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E0864AEA128
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 16:48:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 266955A52DE
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 457D52E7F25;
	Thu, 26 Jun 2025 14:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F2kAUTRm"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F04218858;
	Thu, 26 Jun 2025 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750948921; cv=none; b=aROavpeOFlYwkz4WLXRQpBkFJ9JukRM0ICj0njKXzxDLbJYBv5x9owa2FwbmQbrHncJDvdUghNC7YUoAYXyq2HOBX271INLPEw+xTZMVX4Fsrcl3Us7BwmI7B2tDNDt5z4V0KvG/9ekTR/0mOAQnJDs8TjLJQMNdefEqriSRboM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750948921; c=relaxed/simple;
	bh=42OjuS98WxGG89iYw29vlodU1GzD56kRmxMHKIDo8Ao=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=DELwbyFsoglM9bVPVgNJvF9IfxwwCXiw1lBTY86kUbRUJFBqQtIZjwJSVaepQuG8NySCvHXk082ks7RNBprWpjG9RIsDfIeToX49Adu24r6ELdL7eEOqbdt0FKhVfuJgE8rbCdAJn8kGxomRkRy3F4NfLGZd/gh+8sL02Vu31dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F2kAUTRm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26455C4CEEB;
	Thu, 26 Jun 2025 14:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750948920;
	bh=42OjuS98WxGG89iYw29vlodU1GzD56kRmxMHKIDo8Ao=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=F2kAUTRmhh2r5WO93+pK/HVDynCmy/G5fdUgNn6aGkfu4+HaoBuU5QGoRvNQeZOa7
	 cUygQT6QTn7ATW8GkraAtLkiCgK/jHG72B1GEB++fEhZHiOkaay11eoGgGHFe7d56Z
	 l2u8v3F7fFn48HfEALXXMcgnsnDjmRW19qx1PzSyrbwNqamJubXcQJWN1TmTHMZNGF
	 LB6gtaTdVWeFqPUWYVJ3ok31gBbDjBnLeIup9lGfiHn5ZoutzvsHYNZao65naIz6tS
	 w6zJjdslGbxYDOuNwzdXoTT2TQyKfXY6Dv8FPDb587vqTxwCN7woYt3M/OBHp9jKGG
	 8gRmwsvvsgOhw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 26 Jun 2025 16:41:55 +0200
Message-Id: <DAWJL7B9577H.3HY4CULLAHGCU@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>
Cc: <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <ojeda@kernel.org>,
 <alex.gaynor@gmail.com>, <boqun.feng@gmail.com>, <gary@garyguo.net>,
 <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <aliceryhl@google.com>, <tmgross@umich.edu>, <david.m.ertman@intel.com>,
 <ira.weiny@intel.com>, <leon@kernel.org>, <kwilczynski@kernel.org>,
 <bhelgaas@google.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 4/4] rust: devres: implement register_release()
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250624215600.221167-1-dakr@kernel.org>
 <20250624215600.221167-5-dakr@kernel.org>
 <DAWED7BIC32G.338MXRHK4NSJG@kernel.org> <aF0rzzlKgwopOVHV@pollux>
 <aF1TEuotIIwcKODM@cassiopeiae>
In-Reply-To: <aF1TEuotIIwcKODM@cassiopeiae>

On Thu Jun 26, 2025 at 4:02 PM CEST, Danilo Krummrich wrote:
> On Thu, Jun 26, 2025 at 01:15:34PM +0200, Danilo Krummrich wrote:
>> On Thu, Jun 26, 2025 at 12:36:23PM +0200, Benno Lossin wrote:
>> > Or, we could change `Release` to be:
>> >=20
>> >     pub trait Release {
>> >         type Ptr: ForeignOwnable;
>> >=20
>> >         fn release(this: Self::Ptr);
>> >     }
>> >=20
>> > and then `register_release` is:
>> >=20
>> >     pub fn register_release<T: Release>(dev: &Device<Bound>, data: T::=
Ptr) -> Result
>> >=20
>> > This way, one can store a `Box<T>` and get access to the `T` at the en=
d.
>>=20
>> I think this was also the case before? Well, it was P::Borrowed instead.
>>=20
>> > Or if they store the value in an `Arc<T>`, they have the option to clo=
ne
>> > it and give it to somewhere else.
>>=20
>> Anyways, I really like this proposal of implementing the Release trait.
>
> One downside seems to be that the compiler cannot infer T anymore with th=
is
> function signature.

Yeah... That's a bit annoying.

We might be able to add an associated type to `ForeignOwnable` like
`Target` or `Inner` or whatever.

Then we could do:

    pub fn register_release<P>(dev: &Device<Bound>, data: P) -> Result
    where
        P: ForeignOwnable,
        P::Inner: Release<Ptr =3D P>,

---
Cheers,
Benno

