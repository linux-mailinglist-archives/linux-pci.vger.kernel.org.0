Return-Path: <linux-pci+bounces-26880-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 41580A9E405
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 19:06:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 987EC17A648
	for <lists+linux-pci@lfdr.de>; Sun, 27 Apr 2025 17:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 712ED1E521A;
	Sun, 27 Apr 2025 17:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="iPamqrLl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24417.protonmail.ch (mail-24417.protonmail.ch [109.224.244.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9A61E0E01
	for <linux-pci@vger.kernel.org>; Sun, 27 Apr 2025 17:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745773573; cv=none; b=BNmNqT/gaoad/RJJ7AmRyNkBlcmGTpL42m5xhwDR3rIFw3kncp4Y5FPEzG/5V57S3RIpxaoBSVzehBBuzN0wtnx+VnJMSsJyquF1kIgsOxOtDz/c/UxPisj+LHOIbXCoySUZ7slifnpU80nAYobYdV1w8HDZNSZeD2+CO03MIe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745773573; c=relaxed/simple;
	bh=pV3PHwKTgo/fGQ48R/1Ltm/Nj4C+sb4O1tTESuwOiAc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rAtH2pdzsQdx4Lw5xPcA4cySdxKVJ5ZsBTHssyKcco9b2t7sbBvsjBSDZSERpAqvTGXGV+U3QoFyCTjRMxYLgpL4RAKwySPmzXhYmgt5FoGYlEaLxIYpouI1aSbRtvL+6mjpIrEWHKJfhPxDcYgUH9c+nrxndsYpLMGO3E8Fyp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=iPamqrLl; arc=none smtp.client-ip=109.224.244.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1745773563; x=1746032763;
	bh=qB13Ncw+xj0Xhb42A0Q5J/hEAGY7+ItgOBIwOjJoDts=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=iPamqrLltQnvWKw1wYt7gNziIujISKhVa5O8/pJZQThqswbfqbnAYUgJ2K4Xkpwxt
	 7gIVccK/mPq/SJO1buD7OZDD/Q+6wwmmm45jdmzaViTGerDXWVxYpMuNo/INwTINUc
	 p2Nm+PET+yhlX12J5ZTKziBiH1tmYUNay34RY1SWH5n8j0ROyorkTrriHCqCrWMTGr
	 sH4WCsOsCvEf3/g518oeFMhXAEPP9zJ7ou7iNxcNysSja00bFFWaGF4hKb2nUu14K+
	 f7QDzNAT7knhprGI00KtepQyRuLBefHzMZtGsDvqK9P2+7SmJWOZvZHiDotTI2k7B4
	 94jk3YyO6j2lA==
Date: Sun, 27 Apr 2025 17:05:57 +0000
To: Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] samples: rust: pci: take advantage of Devres::access_with()
Message-ID: <D9HL2RIII0LY.PV0IXOUW5PMV@proton.me>
In-Reply-To: <aA4E1itCT7RczSD6@pollux>
References: <20250426133254.61383-1-dakr@kernel.org> <20250426133254.61383-4-dakr@kernel.org> <D9GUSVZY3ZT7.O3RTG4N0ZIK0@proton.me> <aA1PjHrG4yT7XpCI@pollux> <D9HAO06XMT9X.1NL63T3GBQG7B@proton.me> <aA4E1itCT7RczSD6@pollux>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 8dc340c71d4785a8f66db291154fd8eb935f9f5b
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 27, 2025 at 12:20 PM CEST, Danilo Krummrich wrote:
> On Sun, Apr 27, 2025 at 08:56:29AM +0000, Benno Lossin wrote:
>> On Sat Apr 26, 2025 at 11:26 PM CEST, Danilo Krummrich wrote:
>> > On Sat, Apr 26, 2025 at 08:30:39PM +0000, Benno Lossin wrote:
>> >> On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
>> >> > For the I/O operations executed from the probe() method, take advan=
tage
>> >> > of Devres::access_with(), avoiding the atomic check and RCU read lo=
ck
>> >> > required otherwise entirely.
>> >> >
>> >> > Signed-off-by: Danilo Krummrich <dakr@kernel.org>
>> >> > ---
>> >> >  samples/rust/rust_driver_pci.rs | 12 ++++++------
>> >> >  1 file changed, 6 insertions(+), 6 deletions(-)
>> >> >
>> >> > diff --git a/samples/rust/rust_driver_pci.rs b/samples/rust/rust_dr=
iver_pci.rs
>> >> > index 9ce3a7323a16..3e1569e5096e 100644
>> >> > --- a/samples/rust/rust_driver_pci.rs
>> >> > +++ b/samples/rust/rust_driver_pci.rs
>> >> > @@ -83,12 +83,12 @@ fn probe(pdev: &pci::Device<Core>, info: &Self:=
:IdInfo) -> Result<Pin<KBox<Self>
>> >> >              GFP_KERNEL,
>> >> >          )?;
>> >> > =20
>> >> > -        let res =3D drvdata
>> >> > -            .bar
>> >> > -            .try_access_with(|b| Self::testdev(info, b))
>> >> > -            .ok_or(ENXIO)??;
>> >> > -
>> >> > -        dev_info!(pdev.as_ref(), "pci-testdev data-match count: {}=
\n", res);
>> >> > +        let bar =3D drvdata.bar.access_with(pdev.as_ref())?;
>> >>=20
>> >> Since this code might inspire other code, I don't think that we shoul=
d
>> >> return `EINVAL` here (bubbled up from `access_with`). Not sure what t=
he
>> >> correct thing here would be though...
>> >
>> > I can't think of any other error code that would match better, EINVAL =
seems to
>> > be the correct thing. Maybe one could argue for ENODEV, but I still th=
ink EINVAL
>> > fits better.
>>=20
>> The previous iteration of the sample used the ENXIO error code.
>
> Yes, because the cause of error for try_access_with() failing would have =
been
> that the device was unbound already, hence a different error code.

Ah I see.

>> In this sample it should be impossible to trigger the error path. But
>> others might copy the code into a context where that is not the case and
>> then might have a horrible time debugging where the `EINVAL` came from.
>
> I think it should always pretty unlikely design wise to supply a non-matc=
hing
> device.
>
>> I don't know if our answer to that should be "improve debugging errors
>> in general" or "improve the error handling in this case". I have no
>> idea how the former could look like, maybe something around
>> `#[track_caller]` and noting the lines where an error was created? For
>> the latter case, we could do:
>>=20
>>     let bar =3D match drvdata.bar.access_with(pdev.as_ref()) {
>>         Ok(bar) =3D> bar,
>>         Err(_) =3D> {
>>             // `bar` was just created using the `pdev` above, so this sh=
ould never happen.
>>             return Err(ENXIO);
>
> If the caller really put in a non-matching device we can't say for sure t=
hat the
> cause is ENXIO, the only thing we know is that the code author confused d=
evice
> instances, so I think EINVAL is still the correct thing to return.
>
> The problem that it might be difficult to figure out the source of the er=
ror
> code has always been present in the kernel, and while I'm not saying we
> shouldn't aim for improving this, I don't think this patch is quite the p=
lace
> for this.

Agreed.

---
Cheers,
Benno


