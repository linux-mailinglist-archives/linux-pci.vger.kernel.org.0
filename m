Return-Path: <linux-pci+bounces-31684-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AC04AFCA3B
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 14:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91712188A8E1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 12:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FD62DBF45;
	Tue,  8 Jul 2025 12:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ozAnVNHI"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA972DAFD6;
	Tue,  8 Jul 2025 12:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751977182; cv=none; b=naNenjRimpL1jCcYv5tNVH7ifrUt3uTaLnhpDEs84fBzkbRJyQ/ZCEIV6Uaw47A916S5bR99IFEfX2Z/iI/wRL0f+AcDWnWIjmIQtMxGDkClUer/C6CrUjWTqUX/cFvpiqBCJHJXSSHF3WcB1q3ZFP/xUmFgGc9bQdsvfYuLlvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751977182; c=relaxed/simple;
	bh=Y0tx0EqPvKxbehRPywzbQ+5cZgkvvq1HBIkZ2VN76bI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dNu0bU23H9auLJamggDpV51ivDPs23ATRe2hyQEuyEzOzCVabv9JSRHr926LEzfJNsiX1nqAk5JMLi88l+fEBDW/29ICOvzTIYXKV1TSb1vxGkV4/tDiaquiZlULWJ8Tnp03ObQ/gTp21YNFe3JdhZkQpag4cCpz4euqxPjb17I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ozAnVNHI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06506C4CEF0;
	Tue,  8 Jul 2025 12:19:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751977182;
	bh=Y0tx0EqPvKxbehRPywzbQ+5cZgkvvq1HBIkZ2VN76bI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ozAnVNHIzqETLDXhpZCG89MPrOOYSHfaBye6kqsGuu1tB+jM0BrM09AV2Yw/3jb56
	 rgZ/M3jzjEtVWPZByBjK5N1SMedO9fmymiBhG4UPf2y9S9GMWpxhLf26RZgGa2JhQ4
	 BJcPA0+O986jLCtaywlvLRXE7bw+wPrydKjc0ZyK80LPvyOKFMGBbtRICLvMovwMya
	 dMCaIQn3WIoCe18kP3XcMAFVoa/UItVgoA0vI3vqLlnWZhyL2XIFaURTCR20nFEj5t
	 iPwEKEJsX82ECqKlPJPB5wHC6AB9/fs7PX11WZDx9nTBQEGlkXMAj4J+zivndoUbzk
	 nImiChjTIuMTQ==
Message-ID: <dd81bc6d-5694-4051-a4aa-9d01e1cfb488@kernel.org>
Date: Tue, 8 Jul 2025 14:19:37 +0200
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
To: Dirk Behme <dirk.behme@de.bosch.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
 Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, Benno Lossin <lossin@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <abf29ebe-996e-47f6-8548-afc61ad29a89@de.bosch.com>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <abf29ebe-996e-47f6-8548-afc61ad29a89@de.bosch.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/8/25 2:15 PM, Dirk Behme wrote:
> For example for Resource the elements size, start, name and flags are
> accessible. Inspired by that, what do you think about exposing the irq
> number here, as well?
> 
> diff --git a/rust/kernel/irq/request.rs b/rust/kernel/irq/request.rs
> index bd489b8d2386..767d66e3e6c7 100644
> --- a/rust/kernel/irq/request.rs
> +++ b/rust/kernel/irq/request.rs
> @@ -123,6 +123,11 @@ impl<'a> IrqRequest<'a> {
>       pub(crate) unsafe fn new(dev: &'a Device<Bound>, irq: u32) -> Self {
>           IrqRequest { dev, irq }
>       }
> +
> +    /// Returns the IRQ number of an [`IrqRequest`].
> +    pub fn irq(&self) -> u32 {
> +        self.irq
> +    }
>   }
> 
> 
> I'm using that for some dev_info!().

Not sure that's a reasonable candidate for dev_info!() prints, but maybe it can
be useful for some debug prints.

