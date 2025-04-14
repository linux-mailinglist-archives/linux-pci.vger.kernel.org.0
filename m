Return-Path: <linux-pci+bounces-25811-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72042A87DD7
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7851E188E233
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:41:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3252326AAA1;
	Mon, 14 Apr 2025 10:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="cwpMpSMz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4322.protonmail.ch (mail-4322.protonmail.ch [185.70.43.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E27D26B091
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 10:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744627292; cv=none; b=bEFy5ne4Mm/UARmH1CdBeyjV2Ql/ah4w904O48bdXCJsv2sUVe9k6BbWs7mzOf+b51uGyB5HwHOIvhdSvZ4AnEOsOoko+Hw7LDEAOd+2cUexSeb58YyvEYNdtAxyLpx8AxtNlXj1Zci7B2RE72+5t1w/XmPlRNvNheo+FBwoPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744627292; c=relaxed/simple;
	bh=Nug9Q62+3aayhu9v8ZVJhL4dYNFDNug81UIRbQgqO44=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nt7wmJw5yBGLBwBVJELRe5khuebjPvflyh9YsY5IZ6SpCXPxh04+gpMSrmYs/1rMgbbRfOJeAy83Rr689tU46BlIewx3ltd+rUYIXLqOc4T7paR+FiLYxl7KBi+geu/geJzv+7j37hili4sFtiZ59Bg9evGDamOguO388e2OoTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=cwpMpSMz; arc=none smtp.client-ip=185.70.43.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744627288; x=1744886488;
	bh=Blq4drQ3QF4Ja9cHh+gKnVsH2R3dEHTZSB6RBotBXjw=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=cwpMpSMzh53Ifxjx5DeUwk4GmqM8AMp4R74Ut/J/UuEYUZNZYshbT8q28YLs1sqc0
	 8fIqbNwlJ+uxZiLb4r2+KgdGalymqwGIKsTNjXZYbXYJJ4+zQkKCRtHSeJZ04HrP2u
	 1hNidH677P+OFnfk6gSaGf0LGBPYsxvcjjs45K5o0pgsf25cV85Rr47m8ZqintUdD6
	 6EKHBjjvseyEahb+n5ObO+J7psDwBa8Z8uUyndAnXQRUOsVyhafZ4tWS+5cjTRxzmI
	 4rpcCu4raUNH/lQKWFB4svvJxCinY6Le1BKpAaoqU5WP/If2lpo8iwE5NY+wC9C6ZH
	 DzvlAQJrKyszA==
Date: Mon, 14 Apr 2025 10:41:23 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, abdiel.janulgue@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com, robin.murphy@arm.com, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] rust: device: implement impl_device_context_deref!
Message-ID: <D96AR6IOMJ0I.1YH5KT3QX2YHF@proton.me>
In-Reply-To: <20250413173758.12068-2-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org> <20250413173758.12068-2-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 3112fc7797939f0f2ca1bccdcd1961884f9eab8e
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 13, 2025 at 7:36 PM CEST, Danilo Krummrich wrote:
> +/// Implement [`core::ops::Deref`] traits for allowed [`DeviceContext`] =
conversions of a (bus
> +/// specific) device.
> +///
> +/// # Safety
> +///
> +/// The type given as `$device` must be a transparent wrapper of a type =
that doesn't depend on the
> +/// generic argument of `$device`.
> +#[macro_export]
> +macro_rules! impl_device_context_deref {
> +    (unsafe { $device:ident }) =3D> {
> +        // SAFETY: This macro has the exact same safety requirement as
> +        // `__impl_device_context_deref!`.
> +        kernel::__impl_device_context_deref!(unsafe {

Missing `::` in front of `kernel`.

---
Cheers,
Benno

> +            $device,
> +            $crate::device::Core =3D> $crate::device::Normal
> +        });
> +    };
> +}
> +
>  #[doc(hidden)]
>  #[macro_export]
>  macro_rules! dev_printk {


