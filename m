Return-Path: <linux-pci+bounces-25814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A40A87E00
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:50:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646BA1751CB
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D46F1278159;
	Mon, 14 Apr 2025 10:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cgT0RMnc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA23126770E;
	Mon, 14 Apr 2025 10:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627800; cv=none; b=pyC9yIjlX1I0acXuVLZ+rYpS5KonMZubh1HDOacLfbmxVw41yRlCi55srUJRy3xVySHrY5+mdPup7eH98iIQvPqBZl1oBYUS9BK16/HnZcESF2wmY9gCY7ot28/L/TNZCntdhqtgcRbzeKB6e2IyT1zgUgDzNBj7YbnsTioumnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627800; c=relaxed/simple;
	bh=CzkyEWh1sE7HBtK/0v+QMbrgGUGQNe+UkIbezvWOkL0=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aaieyG/v0UTymdkGiLe376hmGNFoX5ty/hE1+WvzLTHgiHMUlerjKzhXI8luyL3UPFixIs7SzkfeORZK5+yuB1QR9uZbmYXjmQAtmN9WVkMjg3eEdAYAeDKpBfK/xSB/Sdm75sym3gV6KU4xfzxrIS6E5t16CaqJj1g18nVwb7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cgT0RMnc; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744627796; x=1744886996;
	bh=iMBhs2JiirFFXeARfh001EWhBL3xf29IVwkB/4ajPgo=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=cgT0RMncgS3U93r9FcbI6Pa4hCtAzDnvQI97lzdvOPeNCxd+5Khqr62BhC97IyXhd
	 VPqYfhC29NOWN89jJ+DSq0N7dQWbNlFPnShjCO30R3eN4vxVVcIN4Jp+8EtJw432hP
	 aNRi2jmro3yEVBqUsLNi11wHrvbcUP1TODwQR1/8JUPLff1s3cbC9A0+YSHC+uyaU5
	 sP4y2gG/93sD6VQ7NAj94QpuljA36d3Oh4oXuD26t/o10s2vo2VQZG8BgOzJUIuO48
	 QLsLQ6NkYbNHAjb/9gmwmcSKzxRbqPFEsBVXXqsrX4hQGM+Vf9H8DotK2TqFagl4Rh
	 tHd6kBeF6BT5w==
Date: Mon, 14 Apr 2025 10:49:49 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, abdiel.janulgue@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com, robin.murphy@arm.com, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/9] rust: device: implement Bound device context
Message-ID: <D96AXNJRUAA0.3E5KYNM5PZZPG@proton.me>
In-Reply-To: <20250413173758.12068-7-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org> <20250413173758.12068-7-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: d65abdb282b018130f7a52d26ce21322fecb2432
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 13, 2025 at 7:37 PM CEST, Danilo Krummrich wrote:
> The Bound device context indicates that a device is bound to a driver.
> It must be used for APIs that require the device to be bound, such as
> Devres or dma::CoherentAllocation.
>
> Implement Bound and add the corresponding Deref hierarchy, as well as the
> corresponding ARef conversion for this device context.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/kernel/device.rs | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
>
> diff --git a/rust/kernel/device.rs b/rust/kernel/device.rs
> index 487211842f77..585a3fcfeea3 100644
> --- a/rust/kernel/device.rs
> +++ b/rust/kernel/device.rs
> @@ -232,13 +232,19 @@ pub trait DeviceContext: private::Sealed {}
>  /// any of the bus callbacks, such as `probe()`.
>  pub struct Core;
> =20
> +/// The [`Bound`] context is the context of a bus specific device refere=
nce when it is guranteed to
> +/// be bound for the duration of its lifetime.
> +pub struct Bound;

One question about this: is it possible for me to
1. have access to a `ARef<Device<Bound>>` (or `Core`) via some callback,
2. store a clone of the `ARef` in some datastructure,
3. wait for the device to become unbound,
4. use a `Bound`-only context function and blow something up?

Depending on the severity of the "blow something up" we probably need to
change the design. If it's "only a bug" (and not a memory
vulnerability), then this is fine, since people should then "just not do
that" (and I think this design makes that painfully obvious when someone
tries to do something funny with a `Device<Bound>`).

---
Cheers,
Benno


