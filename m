Return-Path: <linux-pci+bounces-26835-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1DAA9DD1B
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 22:28:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E8BE7A82B6
	for <lists+linux-pci@lfdr.de>; Sat, 26 Apr 2025 20:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403D81F78F2;
	Sat, 26 Apr 2025 20:28:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="YJrh6AHZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 600431F4C9D;
	Sat, 26 Apr 2025 20:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745699320; cv=none; b=X48w2o+2vsHxo2YNAXf3c4WeggxOWqYl7qXWIGjkK1CGm/zX8VAym8TpSaigJjEkjaQWkaHZeVp9nUE3NSMqasTQ0l3+JBC6Ls+TxIv/Tx/viJS80zufmn/n0fY62bZMNYSzZqKEgAhRq09BLjj/Hey1lAQBB8ryKPLJ3+pxipY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745699320; c=relaxed/simple;
	bh=88EtV/mGcZoHKKDXGKVNBEhHCGTptwKCLaNpfDc5wdQ=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rVU2KDLq5NadKYfMYt+dER6u1dgVOztKW9w9yTTgIwnKf09jDOCH3HKquQC1J8kL5xgWq4pi9esmmMgVXhd4+LgM91aEGW/rZj0ufGlj3h7AkNNbGUrCStbvck9rCMChtOTWFYq0Lm+oiXDMGKjRei0yxLg1roeW25q+6dD67mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=YJrh6AHZ; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1745699315; x=1745958515;
	bh=MPleTffi9PJatIhTljtKprfEHz/ZbPvLwsb0DsnbTE8=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector:
	 List-Unsubscribe:List-Unsubscribe-Post;
	b=YJrh6AHZmsQFFuuK+bRIB3yycU+/sZMG6pW9c0pmUwPvzmnG43SkCjvRnyfCkxagb
	 DhJVx6tndaCN1JUub93tG6oeQ+AqIDM/W9ODJ49uj9P5Yp93w717Scq4whfHwzocn+
	 wNKj0YHovpp40TixDT++SaNx4eckzuM9PVGtuI4H3sm9qH1QGDubMJPxLMpIGg60ic
	 8OeTR335EHcE13B9v1CMNgIBbKd9zjsjZ4tSKoqr6wW1t0ElAnHbRXszl6pezePX/T
	 XiKdNu9M0eT8tWsGjERVyF2RCDWQu8IevWquRmcITzsO+LLmjCcAsiqSws9TLtTqBW
	 drtoK+Ry7KGYA==
Date: Sat, 26 Apr 2025 20:28:30 +0000
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, kwilczynski@kernel.org, zhiw@nvidia.com, cjia@nvidia.com, jhubbard@nvidia.com, bskeggs@nvidia.com, acurrid@nvidia.com, joelagnelf@nvidia.com, ttabi@nvidia.com, acourbot@nvidia.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] rust: devres: implement Devres::access_with()
Message-ID: <D9GUR8Y08PQ6.2ULV6V4UJAGQB@proton.me>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 49d762bcc2a01b4562a57c62ea85d48cb293f34b
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sat Apr 26, 2025 at 3:30 PM CEST, Danilo Krummrich wrote:
> Implement a direct accessor for the data stored within the Devres for
> cases where we can proof that we own a reference to a Device<Bound>
> (i.e. a bound device) of the same device that was used to create the
> corresponding Devres container.
>
> Usually, when accessing the data stored within a Devres container, it is
> not clear whether the data has been revoked already due to the device
> being unbound and, hence, we have to try whether the access is possible
> and subsequently keep holding the RCU read lock for the duration of the
> access.
>
> However, when we can proof that we hold a reference to Device<Bound>
> matching the device the Devres container has been created with, we can
> guarantee that the device is not unbound for the duration of the
> lifetime of the Device<Bound> reference and, hence, it is not possible
> for the data within the Devres container to be revoked.
>
> Therefore, in this case, we can bypass the atomic check and the RCU read
> lock, which is a great optimization and simplification for drivers.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/devres.rs | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/rust/kernel/devres.rs b/rust/kernel/devres.rs
> index 1e58f5d22044..ec2cd9cdda8b 100644
> --- a/rust/kernel/devres.rs
> +++ b/rust/kernel/devres.rs
> @@ -181,6 +181,41 @@ pub fn new_foreign_owned(dev: &Device<Bound>, data: =
T, flags: Flags) -> Result {
> =20
>          Ok(())
>      }
> +
> +    /// Obtain `&'a T`, bypassing the [`Revocable`].
> +    ///
> +    /// This method allows to directly obtain a `&'a T`, bypassing the [=
`Revocable`], by presenting
> +    /// a `&'a Device<Bound>` of the same [`Device`] this [`Devres`] ins=
tance has been created with.
> +    ///
> +    /// An error is returned if `dev` does not match the same [`Device`]=
 this [`Devres`] instance
> +    /// has been created with.
> +    ///
> +    /// # Example
> +    ///
> +    /// ```no_run

The `no_run` is not necessary, as you don't run any code, you only
define a function.

> +    /// # use kernel::{device::Core, devres::Devres, pci};
> +    ///
> +    /// fn from_core(dev: &pci::Device<Core>, devres: Devres<pci::Bar<0x=
4>>) -> Result<()> {
> +    ///     let bar =3D devres.access_with(dev.as_ref())?;
> +    ///
> +    ///     let _ =3D bar.read32(0x0);
> +    ///
> +    ///     // might_sleep()
> +    ///
> +    ///     bar.write32(0x42, 0x0);
> +    ///
> +    ///     Ok(())
> +    /// }

Missing '```'?

> +    pub fn access_with<'s, 'd: 's>(&'s self, dev: &'d Device<Bound>) -> =
Result<&'s T> {

I don't think that we need the `'d` lifetime here (if not, we should
remove it).

> +        if self.0.dev.as_raw() !=3D dev.as_raw() {
> +            return Err(EINVAL);
> +        }
> +
> +        // SAFETY: `dev` being the same device as the device this `Devre=
s` has been created for
> +        // proofes that `self.0.data` hasn't been revoked and is guarant=
eed to not be revoked as

s/proofes/proves/

---
Cheers,
Benno

> +        // long as `dev` lives; `dev` lives at least as long as `self`.
> +        Ok(unsafe { self.deref().access() })
> +    }
>  }
> =20
>  impl<T> Deref for Devres<T> {



