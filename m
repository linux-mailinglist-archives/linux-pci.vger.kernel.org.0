Return-Path: <linux-pci+bounces-26834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC295A9DD15
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 22:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069E91B63110
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 20:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572851F463C;
	Sat, 26 Apr 2025 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="G1V1/x6z"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66AFE1E521D;
	Sat, 26 Apr 2025 20:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745699064; cv=none; b=N12gHJBeANVqIsipSPSyNmiRTn2KARNXA4QedPqRZJa8TQw1GI8qph+XGxkPiXIShjfPaNNvLUNfgQS3P8X7G0Uzrnouf8zf9k7ZTwrSffhSVGxim8OIQUn70kDwfDEJACheArOnS1rpo/nEqWQBVmFYWaTCS1lRpm70WTPoiiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745699064; c=relaxed/simple;
	bh=W7yJt/mvMYn+AiXd1ocYGzWFxGZn+D21+8VJo8/aaAs=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YyrsVaDpt/sxGr/mN2w6Wf8rIEJCz0i6hOSPGAxmsMSZd4NNVgdiasjY5mVw4w68KsZ3gsyPxC2e5D1bPK5FfojpXr53yVs4G8KuVov7y/HXA17VjbQzi4yarZOYV6734HpqFUG7VKDjYZt7OOYkXCBR7rUgNcFnrP186BPMzwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=G1V1/x6z; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1745699059; x=1745958259;
	bh=ZqrMC1FBNaZtDqXi2xjyzgHvSnX3qnhRhW+5yfJ/Aro=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=G1V1/x6zzOKEkMJ7zGXT+JLr04MbpU7eMX4BtnZlONpB7t2RnpGW+i2W+F/Ne9Si4
	 PTu/IOk0R0R5v5Qru3vUQrwS00B7C2Ol8TBnUxq7dIqpnpiIsqslt/AARIDmzAcOp0
	 B4WInww5pIudaXFfeuIEWdyRpiPFAvyLs53eayKlkqOubQh7LKbFnEpmwmb303cXJS
	 JT2ePdH+MOWJX93txbs/RE3IUsHiAPxV0BrfTBDsQbqfyaIzegotpjaEjGviCuxwut
	 NZ1QE2MsWsV2nqU036iF0A68JCBy8C03liECIa7r8Z578y9Gi5EWW5gE53VtpKEsU6
	 Xvn/A5ZCDEDEQ==
Date: Sat, 26 Apr 2025 20:24:14 +0000
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: revocable: implement Revocable::access()
Message-ID: <D9GUNZ0PMDA4.AZXA0FWQUSB0@proton.me>
In-Reply-To: <20250426133254.61383-2-dakr@kernel.org>
References: <20250426133254.61383-1-dakr@kernel.org> <20250426133254.61383-2-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 70eec72072a9ad48951960ba6eba8511d3c908ee
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
> Implement an unsafe direct accessor for the data stored within the
> Revocable.
>
> This is useful for cases where we can proof that the data stored within
> the Revocable is not and cannot be revoked for the duration of the
> lifetime of the returned reference.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> The explicit lifetimes in access() probably don't serve a practical
> purpose, but I found them to be useful for documentation purposes.
> ---
>  rust/kernel/revocable.rs | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/rust/kernel/revocable.rs b/rust/kernel/revocable.rs
> index 971d0dc38d83..33535de141ce 100644
> --- a/rust/kernel/revocable.rs
> +++ b/rust/kernel/revocable.rs
> @@ -139,6 +139,18 @@ pub fn try_access_with<R, F: FnOnce(&T) -> R>(&self,=
 f: F) -> Option<R> {
>          self.try_access().map(|t| f(&*t))
>      }
> =20
> +    /// Directly access the revocable wrapped object.
> +    ///
> +    /// # Safety
> +    ///
> +    /// The caller must ensure this [`Revocable`] instance hasn't been r=
evoked and won't be revoked
> +    /// for the duration of `'a`.

Ah I missed this in my other email, in case you want to directly refer
to the lifetime, you should keep it defined. I would still remove the
`'s` lifetime though.
> +    pub unsafe fn access<'a, 's: 'a>(&'s self) -> &'a T {
> +        // SAFETY: By the safety requirement of this function it is guar=
anteed that
> +        // `self.data.get()` is a valid pointer to an instance of `T`.

I don't see how the "not-being revoked" state makes the `data` ptr be
valid. Is that an invariant of `Revocable`? (it's not documented to have
any invariants)

---
Cheers,
Benno

> +        unsafe { &*self.data.get() }
> +    }
> +
>      /// # Safety
>      ///
>      /// Callers must ensure that there are no more concurrent users of t=
he revocable object.



