Return-Path: <linux-pci+bounces-24273-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B5FA6B134
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 23:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B655487A38
	for <lists+linux-pci@lfdr.de>; Thu, 20 Mar 2025 22:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E31EB22CBE6;
	Thu, 20 Mar 2025 22:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="kpdT7ZmQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10629.protonmail.ch (mail-10629.protonmail.ch [79.135.106.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC2922A4F6;
	Thu, 20 Mar 2025 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742510689; cv=none; b=kvouCobETHc7tR6w7ZG3Oc2fgmOAuUmjJwY0HUk5T+LiFyXfHK1oVtLTMB52vqnLpYu4ho43fIvTBOF+87Qu/V6HRRXyRRw50cj+QrRQ4aks9Uy9ttZM2YYsBlOokmqew1UmsWCUrZESwMVXhqrqJG6oEXlQY+texBs4rRBQsIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742510689; c=relaxed/simple;
	bh=40BW+We2nULTEHa6DHwaIs9HCvCGKiHZ63/cMV/sFtU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYPLLBF/y3+d0uLurSpS1LOEmEbZxRL1p4P3VBpDFFVJ87wzQFqz4bTxywwpPmeLyTURJmy23dXNaBdUdxobwy1z8GN7A07uSx8pDuEQNgpVHr/4AIKQdyAxKKkXSSfunOESUBPVVomXBD56jZfC9p+mH/Wj+unj5Oxo65yjtm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=kpdT7ZmQ; arc=none smtp.client-ip=79.135.106.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742510685; x=1742769885;
	bh=eMIKFH+4BplOMHp9sw3+b1wsh6xUXS4OrypEx48ZjbU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=kpdT7ZmQBc9eoxhepvNEsgAPULs7gXD17lG/vdx0DnLMFWS+0/mGVdd+qG44+YVHm
	 a6nbZv0fYJpl5E5D4sbTE+iePpwz5o0TcmdolpvuZVxPw+kieC2V3U5TcEnhxJzDbF
	 ushyIkH7rCrNIkq4tR4uiMDQgP1Es8tOjfm8KqXoAoHaLKSUGo1gmQNxn90lMeZmyo
	 cm28nLPpDvfBzuncMRo1M62368QzKy19hl7Vtlu2qEvYWshsX4gfXalrUPi+mfYegj
	 9hKFX5eWuKXvyR7+5fx02Z6L7WzsHyq1zTDlxSN+i1iLm5V0sUvowF8hSC2X58EJYt
	 HzfOenKN3Rm5g==
Date: Thu, 20 Mar 2025 22:44:38 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/4] rust: device: implement Device::parent()
Message-ID: <D8LGHC6DMPIW.29Y3XD1X6Q1L3@proton.me>
In-Reply-To: <20250320222823.16509-2-dakr@kernel.org>
References: <20250320222823.16509-1-dakr@kernel.org> <20250320222823.16509-2-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 2dfcc79fa82cd5cd9ae2ba0513cb32c715df3875
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 11:27 PM CET, Danilo Krummrich wrote:
> Device::parent() returns a reference to the device' parent device, if
> any.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 21b343a1dc4d..f6bdc2646028 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -65,6 +65,21 @@ pub(crate) fn as_raw(&self) -> *mut bindings::device {
>          self.0.get()
>      }
> =20
> +    /// Returns a reference to the parent device, if any.
> +    pub fn parent<'a>(&self) -> Option<&'a Self> {
> +        // SAFETY:
> +        // - By the type invariant `self.as_raw()` is always valid.
> +        // - The parent device is only ever set at device creation.
> +        let parent =3D unsafe { (*self.as_raw()).parent };
> +
> +        if parent.is_null() {
> +            None
> +        } else {
> +            // SAFETY: Since `parent` is not NULL, it must be a valid po=
inter to a `struct device`.
> +            Some(unsafe { Self::as_ref(parent) })

Why is this valid for `'static`? Since you declare the lifetime `'a`
independently from the elided one on `&self`, the user can set it to
`'static`.

---
Cheers,
Benno

> +        }
> +    }
> +
>      /// Convert a raw C `struct device` pointer to a `&'a Device`.
>      ///
>      /// # Safety



