Return-Path: <linux-pci+bounces-23601-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248AAA5F18C
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 11:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A2D33AF114
	for <lists+linux-pci@lfdr.de>; Thu, 13 Mar 2025 10:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D3E1EE013;
	Thu, 13 Mar 2025 10:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="M4NkC8rQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-10630.protonmail.ch (mail-10630.protonmail.ch [79.135.106.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C001EE028
	for <linux-pci@vger.kernel.org>; Thu, 13 Mar 2025 10:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=79.135.106.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863010; cv=none; b=RKFjAiUir8YNhsDs85PZwsuN/svhMpMLBEVAha6myoQYAX28ApTRgw1/0Rc3z61UP/OExpJCbShxU9Czc9d9LfzCwC+V+Cx1Eaf6ZAX+mIiwSw++VxAsgl++2yVe+GLDWqyEH/nc9k6rNbyaeH7q9YOiq3u+SQhgoRL2J4H4KQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863010; c=relaxed/simple;
	bh=HXJ7WHTub6+7OTn4SWrnYEzLOsCmf8QXsqGo9r9tNFU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0mFtpptZbxXpty2X1uYPy9xoawk3GD10VoAbg/EdduzpftSomR8t1X0n1nGnMbKXFznVwRntt0dTCCDAj4Q5fmSAh5XgUN3FndGIOsyzzaJEU2vWJofkP4gonh7RF70UszrcH+B9mO+UKNCycnEtRMOUaN/z3wWdWoyOY9q7Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=M4NkC8rQ; arc=none smtp.client-ip=79.135.106.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=zubnz3yjhfb4hidix4jire25mi.protonmail; t=1741863006; x=1742122206;
	bh=b4baiq+sYN1JA67C0kMX0NiHX7boDTOyVSRutUpR4d4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=M4NkC8rQyFnyExAcleej5pXgCL0fWw/BnGjQusXGFqm5Z662WXEbU2rqQrF4zndnx
	 qOIy6Oj2zazW0zncztSi3ZvmaCljeQNuRKYoMUNf3Ohqdb0LxsQJx71PxJBOsuwm2X
	 kixwBP8S+xU8vVJUapwTipOqspfxt/Q4TaKYNPloMeS+KQaxvxyQgs9dQqeecw1G9/
	 /VLkNEKb8MeIArwD/ERjat4nWqJ/StqfI/7wcioZM9g8gDwbtU4pLgwGFJitZreWHq
	 etKN+Roid/yTJjbIgab/PbGJhXCXABu7aFe/WgdN6qw5xfQc1EWk0+Wvu3jRRGJlvv
	 U6yUfAXaN6GjQ==
Date: Thu, 13 Mar 2025 10:49:59 +0000
To: Danilo Krummrich <dakr@kernel.org>, gregkh@linuxfoundation.org, rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 4/4] rust: platform: fix unrestricted &mut platform::Device
Message-ID: <D8F2WCIXO6RQ.3OQHU95WZFB61@proton.me>
In-Reply-To: <20250313021550.133041-5-dakr@kernel.org>
References: <20250313021550.133041-1-dakr@kernel.org> <20250313021550.133041-5-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 21baaf96d1e4ca0a59c0c62d66c39566228f41de
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 13, 2025 at 3:13 AM CET, Danilo Krummrich wrote:
> As by now, platform::Device is implemented as:
>
> =09#[derive(Clone)]
> =09pub struct Device(ARef<device::Device>);
>
> This may be convenient, but has the implication that drivers can call
> device methods that require a mutable reference concurrently at any
> point of time.

Similar to the other patch, I didn't find any methods taking `&mut self`
but I might have missed them.

> Instead define platform::Device as
>
> =09pub struct Device<Ctx: DeviceContext =3D Normal>(
> =09=09Opaque<bindings::platform_dev>,
> =09=09PhantomData<Ctx>,
> =09);
>
> and manually implement the AlwaysRefCounted trait.
>
> With this we can implement methods that should only be called from
> bus callbacks (such as probe()) for platform::Device<Core>. Consequently,
> we make this type accessible in bus callbacks only.
>
> Arbitrary references taken by the driver are still of type
> ARef<platform::Device> and hence don't provide access to methods that are
> reserved for bus callbacks.
>
> Fixes: 683a63befc73 ("rust: platform: add basic platform device / driver =
abstractions")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

The same two nits from patch #3 also apply.

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/platform.rs              | 93 ++++++++++++++++++----------
>  samples/rust/rust_driver_platform.rs | 16 +++--
>  2 files changed, 74 insertions(+), 35 deletions(-)


