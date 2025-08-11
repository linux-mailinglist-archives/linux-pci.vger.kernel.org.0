Return-Path: <linux-pci+bounces-33717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF31B206B3
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 12:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE0D816BA20
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 10:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1A6275B19;
	Mon, 11 Aug 2025 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3MtQ2wBk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79B09275AF9
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 10:58:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754909912; cv=none; b=pGINX7KQsWSe5yUhc5Wo7FjyYN7j+mzUHi5uuflUCDzuBoslBvkiibPOa8valqTCd/ZjbfuFc4MZtCSejjPzkV7+Hgn5nvBu6Gtnf4KcBQQXsdmrH9Joiw42PpTHyz6Zza1U5+hxSgqPJpg1kVt5wn4y+u0gaLAUyt2ImzkQ0xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754909912; c=relaxed/simple;
	bh=TOxT2K8UzAbuHX//OTejCpfdS4ER15Cjb0TOQpxNcJk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=UsajDRb6Dtfa/6/WF+8nLdqiiy+LzMBoEMR/lRo0P7RJCQTWt4e7j/7/OdZel5OEwXrXYSinUGQPw42mn8vAuedh8OwVk99XU69lexI1EPGpATcoP8/hTtu/MaDTsSvyFBVJsLwESjIbN8QTO/PPuE4WNRoT1llD8G4+GrZjlSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3MtQ2wBk; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-451d30992bcso40727045e9.2
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 03:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754909909; x=1755514709; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=6VBe2G11vJFi6UMiG8m5vVj3u8k4cJ5Bq1V5ylB2VXQ=;
        b=3MtQ2wBksb1lMRjHRPwZQ6G9jnuyzPmCMHYI/9n33KJ9ls1EAltDbX8KRbGWB+EvDI
         V9/OdBUNL4kZDh7I5yJo3DkvU//PVyjySbXSWzkbODbLWc7VF+VV58umQkYrRtJrVj5q
         Zp+5aCnlFGQIhnVqXrgK73l0rwtSuo1Fe1w6LSc6fdD/qe6akNbKgh4GEL6/3yPaTsXz
         zXAolUDuSxi0HKNDDi4qKjaqkawoO5onSaI2m5p2kBHctmXlJolBXM8ArERg4jaPWs3h
         04gEMQT+UaExqHoEVe9T/OIdM5OmTn3ZEBuXy2kWfgu7wnldLqRTySLc7dYwsOGyW1gu
         tYww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754909909; x=1755514709;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6VBe2G11vJFi6UMiG8m5vVj3u8k4cJ5Bq1V5ylB2VXQ=;
        b=puGwEbhEiBoofzM50t05DCAhxe9b2/dK15ifMyT09aX7XSHx8Mm5EpzgIuAJwHEGQI
         mYmLIikFmb5v1RJOuYyLsQAn00e26a7x3pt3bsjGZRodZKlSWaHnlFi78Co7mG0+jcjw
         ftOE3T6wXO2GRwbxYPGSK7FmK4adB5hMZSFPmtwQtPXT+YqirxgvMX0Dzb3Q/nYbkTr8
         bVsXogjGe2Hw5ZB26Z0qoxca6g/tGmnQn1tdybc+EXb9C4ZWlEXjyQt+pxogaQVVPvqI
         wgJ7hcenTChnCrkwP9fpBQQ2DRzT29D2tOJeCdCtcQT51pHWQWcwNOq2ZJbTIpemmQ0/
         MGqQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeNoz4ntvy/WDJRhkQ/m6e0QFp8Gha3uB4TTnLqqiKPgXvs/4pZm0I7sXaijcChT6yGF7cIhXspHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1xg56aHzMFk/fY1Hf7UtXwQCZz1MdqYR2Tu+x3THSNGvrShxE
	ZsiTAqNYiKEJx9irvL2qmBOmT8ESoApcIHFSqfl8Z69lz0sODjMKXCcGhc9qCUTXrk1aI8DQAqZ
	c+eKJqeduoyvr8AoWgA==
X-Google-Smtp-Source: AGHT+IG8sKzGdKyWVo6N+Tazm1JzwCygSw4ih7pHvSmuGIdELFLS7ZBU3K2iJtSgj1DIhq+h6UpYCJqpemM7GTw=
X-Received: from wmbhj11.prod.google.com ([2002:a05:600c:528b:b0:458:b662:fbc4])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:310d:b0:456:a1b:e906 with SMTP id 5b1f17b1804b1-459f4fc2d8emr103138305e9.33.1754909908982;
 Mon, 11 Aug 2025 03:58:28 -0700 (PDT)
Date: Mon, 11 Aug 2025 10:58:28 +0000
In-Reply-To: <20250810-topics-tyr-request_irq2-v8-3-8163f4c4c3a6@collabora.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com> <20250810-topics-tyr-request_irq2-v8-3-8163f4c4c3a6@collabora.com>
Message-ID: <aJnM1LgUYjTloVwV@google.com>
Subject: Re: [PATCH v8 3/6] rust: irq: add support for non-threaded IRQs and handlers
From: Alice Ryhl <aliceryhl@google.com>
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dirk Behme <dirk.behme@de.bosch.com>
Content-Type: text/plain; charset="utf-8"

On Sun, Aug 10, 2025 at 09:32:16PM -0300, Daniel Almeida wrote:
> This patch adds support for non-threaded IRQs and handlers through
> irq::Registration and the irq::Handler trait.
> 
> Registering an irq is dependent upon having a IrqRequest that was
> previously allocated by a given device. This will be introduced in
> subsequent patches.
> 
> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> index d6306415f561f94a05b1c059eaa937b0b585471d..f7d89a46ad1894dda5a0a0f53683ff97f2359a4e 100644
> --- a/rust/kernel/irq.rs
> +++ b/rust/kernel/irq.rs
> @@ -13,5 +13,11 @@
>  /// Flags to be used when registering IRQ handlers.
>  pub mod flags;
>  
> +/// IRQ allocation and handling.
> +pub mod request;

Same comment here about removing `pub` from `mod request`.

>  #[doc(inline)]
>  pub use flags::Flags;
> +
> +#[doc(inline)]
> +pub use request::{Handler, IrqRequest, IrqReturn, Registration};

With `pub` removed above, you don't need doc(inline) here.

Alice

