Return-Path: <linux-pci+bounces-26852-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 474FEA9E139
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 10:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 902BE17EE2F
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 08:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C159E247288;
	Sun, 27 Apr 2025 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="RW4uMR0H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D53B7246326
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745744198; cv=none; b=U7YdNtiHl5W+vtYvMEf1sKa+W1+GfMxghpij4KDxS/YCYqcBiLEWWT1LNbjCcsN04arsM1HdBim4S5I4qc8AJlNLLCvKGPGKj+0h7ILcUqfgatZXJbGnoC+jY1TNozdJJB1d5GQPS25Uqjtt1Yo+ONC8N6wzW7NFLnVI+X8AruM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745744198; c=relaxed/simple;
	bh=eS7yzfDWlqN6IRBfAXgT8yj7yIjtM1geYYgjXUyjIUc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CSrXg5q1g9SjJ0jEOlzSo0wLFOgmzAjcyl2sRsHPj6grGr7ai5wz29tAtsoSCthBWTaPSqe4yF9/N+OLeMUx27q0aoFEugzxm1TOzefNmQNombMx1X8CH6DzZ845DNcVILAE32e+xG/Jl6h2npvKZsH6x+qv5XXEORpEgOimNDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=RW4uMR0H; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=ttfjfcex3bdgxjbbczeexkt3ae.protonmail; t=1745744193; x=1746003393;
	bh=WIsNNrHNWvNmxZ3FsMH+MSWRK3+6s9rB7du+OZv23xg=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=RW4uMR0Haf5ghjyQC/oHwitNUD52iHRmBSFxM63IEP0BhBkwBr1FpZOsnkbfQYi8/
	 f7rCmQ9XNi5bFlLGE+4ndWzmaak1potJ1us0ibISznCyr4Red2XrPHkL5imBucWgKh
	 OrLY6Y0QUgY0frdPaEevqEuaj8fQEhV2ucvbYwlbNe4PI81beeDaa68qlynfne+jOW
	 AAbG8Uj4CLg17hvEEXXGcvGnSeP2zFilAEJ5WFxczlyCErTS7xg3Gq6+TLk6Wa2eH4
	 GBtD8InIh7qXlwChbHCzVVNwXg662Ur7eI+JxEcITXM5WSn1kSEk+5velE1SngpumQ
	 iA5/neHqX3jPg==
Date: Sun, 27 Apr 2025 08:56:29 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] samples: rust: pci: take advantage of Devres::access_with()
Message-ID: <D9HAO06XMT9X.1NL63T3GBQG7B@proton.me>
In-Reply-To: <aA1PjHrG4yT7XpCI@pollux>
References: <20250426133254.61383-1-dakr@kernel.org> <20250426133254.61383-4-dakr@kernel.org> <D9GUSVZY3ZT7.O3RTG4N0ZIK0@proton.me> <aA1PjHrG4yT7XpCI@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 9b50c9087772bc346d8770f942d75f0cd6d416ef
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Apr 26, 2025 at 11:26 PM CEST, Danilo Krummrich wrote:
> On Sat, Apr 26, 2025 at 08:30:39PM +0000, Benno Lossin wrote:
>> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
>> > For the I/O operations executed from the probe() method, take advantag=
e
>> > of Devres::access_with(), avoiding the atomic check and RCU read lock
>> > required otherwise entirely.
>> >
>> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> > ---
>> >  samples/rust/rust_driver_pci.rs | 12 ++++++------
>> >  1 file changed, 6 insertions(+), 6 deletions(-)
>> >
>> > diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_drive=
r_pci.rs
>> > index 9ce3a7323a16..3e1569e5096e 100644
>> > --- a/samples/rust/rust_driver_pci.rs
>> > +++ b/samples/rust/rust_driver_pci.rs
>> > @@ -83,12 +83,12 @@ fn probe(pdev: &pci::Device<Core>, info: &Self::Id=
Info) -> Result<Pin<KBox<Self>
>> >              GFP_KERNEL,
>> >          )?;
>> > =20
>> > -        let res =3D drvdata
>> > -            .bar
>> > -            .try_access_with(|b| Self::testdev(info, b))
>> > -            .ok_or(ENXIO)??;
>> > -
>> > -        dev_info!(pdev.as_ref(), "pci-testdev data-match count: {}\n"=
, res);
>> > +        let bar =3D drvdata.bar.access_with(pdev.as_ref())?;
>>=20
>> Since this code might inspire other code, I don't think that we should
>> return `EINVAL` here (bubbled up from `access_with`). Not sure what the
>> correct thing here would be though...
>
> I can't think of any other error code that would match better, EINVAL see=
ms to
> be the correct thing. Maybe one could argue for ENODEV, but I still think=
 EINVAL
> fits better.

The previous iteration of the sample used the ENXIO error code.

In this sample it should be impossible to trigger the error path. But
others might copy the code into a context where that is not the case and
then might have a horrible time debugging where the `EINVAL` came from.
I don't know if our answer to that should be "improve debugging errors
in general" or "improve the error handling in this case". I have no
idea how the former could look like, maybe something around
`#[track_caller]` and noting the lines where an error was created? For
the latter case, we could do:

    let bar =3D match drvdata.bar.access_with(pdev.as_ref()) {
        Ok(bar) =3D> bar,
        Err(_) =3D> {
            // `bar` was just created using the `pdev` above, so this shoul=
d never happen.
            return Err(ENXIO);
        }
    };

---
Cheers,
Benno


