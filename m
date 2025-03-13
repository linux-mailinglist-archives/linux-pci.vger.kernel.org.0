Return-Path: <linux-pci+bounces-23595-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DCF6A5F083
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE8D619C1463
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 10:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C41265616;
	Thu, 13 Mar 2025 10:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="chRVdD5c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-40134.protonmail.ch (mail-40134.protonmail.ch [185.70.40.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3131EE028;
	Thu, 13 Mar 2025 10:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741861288; cv=none; b=l1EqIFw6NbqK+AA1ylr154iAStLy+xErwutORF9VdXAbkx8Vy9AVKBgGJpxzQzmzA2STch7FB0KliVJZyPw14FhzplzWOLwJ6dLOMX0LdmeHH15RoqYQmnNTRvQR8EP5kgTuZjAIOE5tg/cpsDBWEyAGBPplWtvI/F7fBl5HiS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741861288; c=relaxed/simple;
	bh=cfebVLUHNUezFRL9YCM9hxV/pp652rwNYdE3gxbbonM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U4Nt3AemMB94p9wZnpt340s1/GzX0RS9JWqxk8wW9vwoseQslrxaYLy3dbtTNIMeu0VoU6GsfNfPB3v202lTOGtYTxOJ/AjBx64Nvrc22jUoQrxtP4+amhAgoMbAA/DDgSsUGTUBFyvvuQWfkmOO8iVicsvqac7cgP6lGQo/JYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=chRVdD5c; arc=none smtp.client-ip=185.70.40.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=xdvi7iawbva2dofelbrkhjtklu.protonmail; t=1741861283; x=1742120483;
	bh=oSHmWh3vAbBN7vdlEzmuzXiqy2c6RHhX3Wjngq/DT6w=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=chRVdD5cD5bMyhhzC7qUlj1mgmQaBNY2avdn/wyhbmYM6pGc9Jm2uH373MKcXtSAs
	 19YHh2ecQb40Kz7MGBM7EMCbz8Vz95hSkbdPq7l6KGmeXy4wmm5fzM3wZibATHGxZ+
	 ZvFoeTD9BP96vW4XGKYT6aycnhmSTugSELsEp/W7BkIq7HDzGN1v+mb40fPXkah5Hl
	 Q4GhI63BKUYqIONJyZUx73wZ4IdFKiCqoYb1VVbbn05tswo0XlTIcS7gld4QWMae+B
	 b6w3Iw9bGyrJKvktt4mfJnWNkG9yqi4KPca5HMw86GAnrVXLjXjHEAdcPm9QCvC1V2
	 iZJC8m6NDfLHQ==
Date: Thu, 13 Mar 2025 10:21:18 +0000
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 1/4] rust: pci: use to_result() in enable_device_mem()
Message-ID: <D8F2AE364QC3.11HU88HZQCS43@proton.me>
In-Reply-To: <20250313021550.133041-2-dakr@kernel.org>
References: <20250313021550.133041-1-dakr@kernel.org> <20250313021550.133041-2-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: cd9fd983219177ffe633db16d80de1f2dce5082b
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
> Simplify enable_device_mem() by using to_result() to handle the return
> value of the corresponding FFI call.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/pci.rs | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 4c98b5b9aa1e..386484dcf36e 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -382,12 +382,7 @@ pub fn device_id(&self) -> u16 {
>      /// Enable memory resources for this device.
>      pub fn enable_device_mem(&self) -> Result {
>          // SAFETY: `self.as_raw` is guaranteed to be a pointer to a vali=
d `struct pci_dev`.
> -        let ret =3D unsafe { bindings::pci_enable_device_mem(self.as_raw=
()) };
> -        if ret !=3D 0 {
> -            Err(Error::from_errno(ret))
> -        } else {
> -            Ok(())
> -        }
> +        to_result(unsafe { bindings::pci_enable_device_mem(self.as_raw()=
) })
>      }
> =20
>      /// Enable bus-mastering for this device.



