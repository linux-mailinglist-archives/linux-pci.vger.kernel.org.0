Return-Path: <linux-pci+bounces-31834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FED9AFFB8F
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 10:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67A24643995
	for <lists+linux-pci@lfdr.de>; Thu, 10 Jul 2025 08:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB05242D71;
	Thu, 10 Jul 2025 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DVZBLLKl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFA94A0C;
	Thu, 10 Jul 2025 08:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752134471; cv=none; b=KYu46awj9m0rD3kGJu/NPVdIaZLWsZlAovwqbqrwKo3q7Wqw20iqpWbtXxOKFXUR/pP9Gg9bdji9dtlC5YgLwr21CtEfEZo9Jy0uEmswuGL4Mqbx+Lrs/0X4mH45+LCyBDK9XUdua1WLx/BIxqc6naC8b0hsLT08qf8D/ezOtPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752134471; c=relaxed/simple;
	bh=LSkqtv/Jm6atWS2WbV4u56HiviuAMPR7h1WDIBqd+kI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=ssnduwR2gwZ0Vc4XPxBcO79wdYajAMsiwIB/Ly4JcKfH8Xnhm/y5RotDYGCRTTBQDn0bkj4Ia0h+uHzQ4X4j3u6TE0izj8ZSk5B03GRqXHDgB3wGFMPChWEbGhTSCDPO0e95Hwnm1GKayhhjcoepZuMeZ46yxEHt7evCCIzEVfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DVZBLLKl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 504A5C4CEE3;
	Thu, 10 Jul 2025 08:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752134470;
	bh=LSkqtv/Jm6atWS2WbV4u56HiviuAMPR7h1WDIBqd+kI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=DVZBLLKl00oQNEGXVxmLxLf8rW/NcitEm041FBrSH+sHSrIpD8itPkHVCb+oR4kQj
	 HzZUAI8Y5TdYwRl1pXvBZLNN+/FBLT/KPub1kLcBlO3dabNEXmwDvwJFRZLCgzpXD4
	 1ephKeAe0zb+36wsUkFNF3hCIKYD7LeSJdfhJVnbNvKqjZJy0fRfBVhfQdeStMX0Le
	 nav/JS8BYbDDkU6B3L90QtxmA+Hl5BoKdMfU2yAmwwqV4/nT4O5u+CEIr7WRCMC8GP
	 rwSdYeF+wcOMzZG9n/JT24ehgts6KHBchTEAgORZQx+7LY/MsTXxlnowbRsft+GRkB
	 u5gZ4OUEWT8cA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 10 Jul 2025 10:01:05 +0200
Message-Id: <DB87TX9Y5018.N1WDM8XRN74K@kernel.org>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "John Hubbard" <jhubbard@nvidia.com>, "Alexandre
 Courbot" <acourbot@nvidia.com>, <linux-pci@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] rust: Update PCI binding safety comments and add
 inline compiler hint
From: "Benno Lossin" <lossin@kernel.org>
To: "Alistair Popple" <apopple@nvidia.com>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.20.1
References: <20250710022415.923972-1-apopple@nvidia.com>
In-Reply-To: <20250710022415.923972-1-apopple@nvidia.com>

On Thu Jul 10, 2025 at 4:24 AM CEST, Alistair Popple wrote:
> diff --git a/rust/kernel/pci.rs b/rust/kernel/pci.rs
> index 8435f8132e38..5c35a66a5251 100644
> --- a/rust/kernel/pci.rs
> +++ b/rust/kernel/pci.rs
> @@ -371,14 +371,18 @@ fn as_raw(&self) -> *mut bindings::pci_dev {
> =20
>  impl Device {
>      /// Returns the PCI vendor ID.
> +    #[inline]
>      pub fn vendor_id(&self) -> u16 {
> -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        // SAFETY: by its type invariant `self.as_raw` is always a valid=
 pointer to a

s/by its type invariant/by the type invariants of `Self`,/
s/always//

Also, which invariant does this refer to? The only one that I can see
is:

    /// A [`Device`] instance represents a valid `struct device` created by=
 the C portion of the kernel.

And this doesn't say anything about the validity of `self.as_raw()`...

> +        // `struct pci_dev`.
>          unsafe { (*self.as_raw()).vendor }
>      }
> =20
>      /// Returns the PCI device ID.
> +    #[inline]
>      pub fn device_id(&self) -> u16 {
> -        // SAFETY: `self.as_raw` is a valid pointer to a `struct pci_dev=
`.
> +        // SAFETY: by its type invariant `self.as_raw` is always a valid=
 pointer to a
> +        // `struct pci_dev`.

Ditto here.

---
Cheers,
Benno

>          unsafe { (*self.as_raw()).device }
>      }
> =20


