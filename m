Return-Path: <linux-pci+bounces-26881-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B597A9E407
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 19:11:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A91F03B5CA3
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 17:11:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66B981D6DDD;
	Sun, 27 Apr 2025 17:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="G6ioXuuh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10631.protonmail.ch (mail-10631.protonmail.ch [79.135.106.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFBAB1531DB;
	Sun, 27 Apr 2025 17:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.31
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745773882; cv=none; b=IhB+ASCtPbFMMOX+pfcgok8lPL70b3M5EQIQgcOk8O1zrPZxQdCyXm0AFuV1nod/7TmayDZik4aF2LK0oo8uv5JRgkMmGsdSSSW/9Z/8Ok8VJp3kG4nRyogtHVp1wqwucCTXfuCCRwzu3A7m+9gAkjqC6fUaBhSGUFSOUFUH9vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745773882; c=relaxed/simple;
	bh=ZPGLVu8FvaYMH4Z77PMv1s7904q6EfdpkXZ1p6zVfSc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rej2+bheBcQjBa1xK5Hw+T9yFx7Yue8z/Oy/kcb6kNDC7seD7sNZjbqvzfgYhaYoLfM2gyCkY9R/KWI8igkb6vcOcjkl8tbDs0Ei727JY9zB0QfwjO6SSe3jmTKqNOEILNpfJ7QdzZ7mRcy8mjzy6giYtKJmxyEWIKsw5wmq4xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=G6ioXuuh; arc=none smtp.client-ip=79.135.106.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1745773878; x=1746033078;
	bh=0sUVJfqumoE4FsVJpVo0rxr3H29ChmgT8uN7KP0YQmY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=G6ioXuuhKMPZzzuA8WMSm4BjupksyNKoJTPRcB1I15gFnB2NJB60awB3VqolCnJIi
	 mnyGdlsBF+rd8P75NOywVqpgBKqYY7IfTD6EqlmB1M/4pCCo6Hjao3RXIa/LsjPRrc
	 Pr3kXzowamJ6k7mqcPkMtQ3dkkJ5/KAzXG5NiyeKz+t7v7jPNeArP8IXht24fXrJP4
	 MUQfp+6yA+OBd9Hu3H4/tyEmobUHPjm/CDFxudcKhVlgpxVb4GhYlxPBtu/DWzFbuv
	 1NMZHeJO+pMWjP5sZZUhVIg/QVsPOLHQTFT9M7ZUbev162neDyXTEws8ZeWQrYI3Nv
	 gcREqdupVxEiA==
Date: Sun, 27 Apr 2025 17:11:12 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: devres: implement Devres::access_with()
Message-ID: <D9HL6SERYCVX.24AUGLK06TV41@proton.me>
In-Reply-To: <aA4ChLR5xf0I7YJY@pollux>
References: <D9GUR8Y08PQ6.2ULV6V4UJAGQB@proton.me> <aA1O8Wem1FhyybF5@pollux> <D9HAC6KW2GTG.ICOFCQX4A2U3@proton.me> <aA4ChLR5xf0I7YJY@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 70b5f1b0f59e304be70722d2d285d8fa2e95187a
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 27, 2025 at 12:10 PM CEST, Danilo Krummrich wrote:
> On Sun, Apr 27, 2025 at 08:41:02AM +0000, Benno Lossin wrote:
>> On Sat Apr 26, 2025 at 11:24 PM CEST, Danilo Krummrich wrote:
>> > On Sat, Apr 26, 2025 at 08:28:30PM +0000, Benno Lossin wrote:
>> >> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
>> >> > +    pub fn access_with<'s, 'd: 's>(&'s self, dev: &'d Device<Bound=
>) -> Result<&'s T> {
>> >>=20
>> >> I don't think that we need the `'d` lifetime here (if not, we should
>> >> remove it).
>> >
>> > If the returned reference out-lives dev it can become invalid, since i=
t means
>> > that the device could subsequently be unbound. Hence, I think we indee=
d need to
>> > require that the returned reference cannot out-live dev.
>>=20
>> I meant the following signature:
>>=20
>>     pub fn access_with<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&=
'a T>
>>=20
>> You don't need to specify the additional `'d` one, since lifetimes allow
>> subtyping [1]. So if I have a `&'s self` and a `&'d Device<Bound>` and
>> `'d: 's`, then I can supply those arguments to my suggested function and
>> the compiler will shorten `'d` to be `'s` or whatever is correct in the
>> context.
>>=20
>> [1]: https://doc.rust-lang.org/nomicon/subtyping.html#subtyping
>
> Makes sense, and I don't mind changing it, but I still think the orignal =
version
> makes the actual requirement more obvious to the reader, i.e. dev must li=
ve *at
> least* as long as self, but not dev must live *exactly* as long as self.

I think it makes the function harder to read, since you have multiple
lifetimes around. Once one gets used to the subtyping rule, it's much
better to reduce the total amount of lifetimes. Otherwise it seems to me
as if it's more complicated.

---
Cheers,
Benno


