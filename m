Return-Path: <linux-pci+bounces-30876-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E23A1AEAAAE
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1E36405B3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E78AE2253EE;
	Thu, 26 Jun 2025 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hm8+br9h"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA444224228;
	Thu, 26 Jun 2025 23:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980826; cv=none; b=WjQNOkBs8u4jnS6uX+75Wzs6udpUUZ/R+7bUKM5sAAR6z3e2JAZxvB+Im5LuWvHnEeqS/uT88LPhXM4ZsSo613u3/fb8FyJYSEzAMyXfNhfJy3+9OCHZZJh/giUuTl/LSLbr+DQEgZJlsIpeDXSQwRfeMzhJ9bwkH+uuE4uC0Yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980826; c=relaxed/simple;
	bh=LKw9ZjvUtBOniKomanSgvb3piQT6FZcqgxkJakUQCwU=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=qUp4ozACyA4pku/gicMswKM81Cz8yZSwVZ4qxIEETU3/oBXh6FnylN6pS+IMC+jj32T/LNxu30eq1kzI6Zd0tns+cKiGIenI1OR//8ht405eHC9xdkjHA5DDGQEpfDF0rXt8MDMiYNO4eM6Ox5TuVZSPuQzC188IlMS/K9n3yp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hm8+br9h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412B2C4CEEB;
	Thu, 26 Jun 2025 23:33:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750980826;
	bh=LKw9ZjvUtBOniKomanSgvb3piQT6FZcqgxkJakUQCwU=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=hm8+br9hJIjap6cvt5Nsi/5ZOy4+7fqdTOeeXkk8GiBk+LdFIssA7GF+NPmRHK0Qc
	 s2p+PqZx3Q1rTSMjXx5kPPhGE/jpa3WYtVAEfvaEIeJJ36uDFmWeqEun8ga1GEYFqV
	 ZfoJASmwrzlj2YoK4StZc/cQE5ULHckChEBC/93iCaaNA7X8rYTx5nCOpODyTp1chS
	 i6WmoxJSUv+Sldb3uVaxIPPBz3NflpGHpUTbXat15rLVMUo6Kf1ArNTOP7TeWIbSex
	 55QStVUWdk0YJgAKsxCJLicLxT2f/wfzV9CFmR5Iuz38Ahn4RDzQJ7tFloIzTuQLnH
	 dZQPQPBvXrYpA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 01:33:41 +0200
Message-Id: <DAWUWCQCW7WD.29U1POJFXTLXS@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] rust: devres: get rid of Devres' inner Arc
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>
X-Mailer: aerc 0.20.1
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-4-dakr@kernel.org>
In-Reply-To: <20250626200054.243480-4-dakr@kernel.org>

On Thu Jun 26, 2025 at 10:00 PM CEST, Danilo Krummrich wrote:
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 60b86f370284..47653c14838b 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs

> @@ -161,14 +161,14 @@ fn new(bar: &Bar0) -> Result<Spec> {
>  pub(crate) struct Gpu {
>      spec: Spec,
>      /// MMIO mapping of PCI BAR 0
> -    bar: Devres<Bar0>,
> +    bar: Arc<Devres<Bar0>>,

Can't you store it inline, given that you return an `impl PinInit<Self>`
below?

>      fw: Firmware,
>  }
> =20
>  impl Gpu {
>      pub(crate) fn new(
>          pdev: &pci::Device<device::Bound>,
> -        devres_bar: Devres<Bar0>,
> +        devres_bar: Arc<Devres<Bar0>>,
>      ) -> Result<impl PinInit<Self>> {

While I see this code, is it really necessary to return `Result`
wrapping the initializer here? I think it's probably better to return
`impl PinInit<Self, Error>` instead. (of course in a different patch/an
issue)

>          let bar =3D devres_bar.access(pdev.as_ref())?;
>          let spec =3D Spec::new(bar)?;

> @@ -44,6 +49,10 @@ struct DevresInner<T: Send> {
>  /// [`Devres`] users should make sure to simply free the corresponding b=
acking resource in `T`'s
>  /// [`Drop`] implementation.
>  ///
> +/// # Invariants
> +///
> +/// [`Self::inner`] is guaranteed to be initialized and is always access=
ed read-only.
> +///

Let's put this section below the examples, I really ought to write the
safety docs one day and let everyone vote on this kind of stuff...

>  /// # Example
>  ///
>  /// ```no_run

> @@ -213,44 +233,63 @@ pub fn new(dev: &Device<Bound>, data: T, flags: Fla=
gs) -> Result<Self> {
>      /// }
>      /// ```
>      pub fn access<'a>(&'a self, dev: &'a Device<Bound>) -> Result<&'a T>=
 {
> -        if self.0.dev.as_raw() !=3D dev.as_raw() {
> +        if self.dev.as_raw() !=3D dev.as_raw() {
>              return Err(EINVAL);
>          }
> =20
>          // SAFETY: `dev` being the same device as the device this `Devre=
s` has been created for
> -        // proves that `self.0.data` hasn't been revoked and is guarante=
ed to not be revoked as
> -        // long as `dev` lives; `dev` lives at least as long as `self`.
> -        Ok(unsafe { self.0.data.access() })
> +        // proves that `self.data` hasn't been revoked and is guaranteed=
 to not be revoked as long
> +        // as `dev` lives; `dev` lives at least as long as `self`.

What if the device has been unbound and a new device has been allocated
in the exact same memory?

---
Cheers,
Benno

> +        Ok(unsafe { self.data().access() })
>      }

