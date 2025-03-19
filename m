Return-Path: <linux-pci+bounces-24138-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35349A692E0
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 16:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DBD78467550
	for <lists+linux-pci@lfdr.de>; Wed, 19 Mar 2025 15:09:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0141DE89C;
	Wed, 19 Mar 2025 15:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="H/LL6Ac+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-40133.protonmail.ch (mail-40133.protonmail.ch [185.70.40.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D92A1DED78;
	Wed, 19 Mar 2025 15:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742396560; cv=none; b=qXRXuSVkObR/MUzDap7xWPXNd6W7PUSzI7jD8Lz9PIDpYL5NyZOSPt9aKDh0P2s9VgtiLVY39qVejRtCLVlpbWDDD+DmX7/5XI/wT7nPzW4uGRq9Mxj9A7FH7ym2tfcU+YFgL2NCEFLJwPnjjk+WIDKiAELYDUEb9LJ1O3BWO9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742396560; c=relaxed/simple;
	bh=4D2+8aGVe4QkSjthIto/zgZ6PvyVLX0cNGhuA5OBVCw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fbV+A7L1dClqHhQxRoyIG2BLdbHuS8T9918ZmB8Zrlug0Q1NLPAxgwAwlhtQhjvHvghT69RE9tykG4HOYJ89Qg/jilvS6NeItftAyauKG5LCro+bA/oTPVuUemUoS6Yf306GHJLhuCFWyKKOeipBzH1CRjDvhcR8qw6toI7WKdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=H/LL6Ac+; arc=none smtp.client-ip=185.70.40.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742396556; x=1742655756;
	bh=mAK7ljkqrLvv2ILU+ldozQgfrMSW5hXpjPvcc6kqTXU=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=H/LL6Ac+WRtWKvJg9AgWO0HV+5SbItXbZaSaQuEVi9nBKuMEMK3loJT7wkSlARlyw
	 ZtCC+ndadBvabtXOAJA1CBHfG/R/exvu/gE6ltwxAYxcD5wQP4MhUqBc/oCHCjkOf5
	 3it4NrU3a7spWGq5P6He4ix9g+FL66pfUUDzj2CSTRKGhlnsh5ZksSObcg5hgBgfkr
	 KiIOy/KsX7f7LGelntxyzZrj6Em+Msd7pkjtwirZbtTGx8PyiBHwX/CEflIkQlJQ4X
	 rFYcqKbT/fjSQ6k1S0nXxq4cqj+Yn1A0oa4lIPpoiLFG+r5cGf2bJg1uWposuUczAn
	 /Am8MjpQCLROQ==
Date: Wed, 19 Mar 2025 15:02:30 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, gregkh@linuxfoundation.org, rafael@kernel.org, ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] rust: platform: require Send for Driver trait implementers
Message-ID: <D8KC0YODQ29U.MR1GUFKWS93J@proton.me>
In-Reply-To: <20250319145350.69543-2-dakr@kernel.org>
References: <20250319145350.69543-1-dakr@kernel.org> <20250319145350.69543-2-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d0e586a50f8355844dba8236a4586a8c8ca51250
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Wed Mar 19, 2025 at 3:52 PM CET, Danilo Krummrich wrote:
> The instance of Self, returned and created by Driver::probe() is
> dropped in the bus' remove() callback.
>
> Request implementers of the Driver trait to implement Send, since the
> remove() callback is not guaranteed to run from the same thread as
> probe().
>
> Fixes: 683a63befc73 ("rust: platform: add basic platform device / driver =
abstractions")
> Reported-by: Alice Ryhl <aliceryhl@google.com>
> Closes: https://lore.kernel.org/lkml/Z9rDxOJ2V2bPjj5i@google.com/
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Good catch Alice!

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/platform.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/platform.rs b/rust/kernel/platform.rs
> index 2811ca53d8b6..e37531bae8e9 100644
> --- a/rust/kernel/platform.rs
> +++ b/rust/kernel/platform.rs
> @@ -149,7 +149,7 @@ macro_rules! module_platform_driver {
>  ///     }
>  /// }
>  ///```
> -pub trait Driver {
> +pub trait Driver: Send {
>      /// The type holding driver private data about each device id suppor=
ted by the driver.
>      ///
>      /// TODO: Use associated_type_defaults once stabilized:



