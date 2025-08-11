Return-Path: <linux-pci+bounces-33726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A37AB2083E
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 13:56:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 961A7424F4F
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 11:56:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473622D3743;
	Mon, 11 Aug 2025 11:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="datoEnGf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC558248B
	for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 11:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754913374; cv=none; b=et8A3DOYYUwXxd93z+KiuUutup2j0wXZZcNWLG2HCFCbbWiVOoDi/5QJmkESiUGizgEPpeSWkUvQv8qN0ap6hw9wIfs+MzULMsH5d6a4ghhli1maufsHu99bv+ZN/OV5H5gns3dRGmnPhY1zdsQLgYCtIZzCVsBbadd5lPf6R8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754913374; c=relaxed/simple;
	bh=pd8lw1Twkw+fuqqT14unQ6QdaUdFv4aeM1OwRlQoG/o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r+xaZ7KpbZEZbTDi6o3o+xtBZ0t9DkZ8Kg5IX4rfaVlv9oXC5yksU1EOXyL8z/gAGTgj/m/U+bPn+0h7Tsl44FqwbjdLuTSLXCXwdFtkubj9qUC/7XB9/OpQzHWT/JrnruInKpy47v6q6/KD39rWLvPeJ3CPpvd+3m4H47XxgOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=datoEnGf; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b786421e36so2268496f8f.3
        for <linux-pci@vger.kernel.org>; Mon, 11 Aug 2025 04:56:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1754913369; x=1755518169; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pd8lw1Twkw+fuqqT14unQ6QdaUdFv4aeM1OwRlQoG/o=;
        b=datoEnGfKjJspiLzUr8daDj7jT22Xi93bgOgko2M77PvlE76pyZFG1nasSTmDsmZLq
         oYTnedTsZ/fgp6Mtf6YaxbNEilVYD2wlVuaxEll/TWW/IP1uL5L6TWm28wZ1JydAzGw0
         LKMYuKzXs0G9h7DuwU/sc2MkEam2gHughRg0ID+MaGCEmC06neTQpVnSJKPoWWCkzRnQ
         iRKlqFjFeUxo9TVDw9nJ4KHW2LdYSOdPglC/iAh+LDx/GQk7KnOpDgDKrDr3jLLOuAd1
         g/htJh8JyeQ10951XCvbln6YMC2WapO0bRXC0KllkLEzMGjftPrQyykXjGbgoKeUu896
         SQCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754913369; x=1755518169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pd8lw1Twkw+fuqqT14unQ6QdaUdFv4aeM1OwRlQoG/o=;
        b=okzjKivakrxJlSYnTVXgevIRb3XGIFqeQ1h9kFDckfpvmvQinOynxGpREUDiNyXkpg
         kcDPNt9zrlgR0MUmX3Sr4YOKlT0M3jY7xLooG1D6Zq7xDjLRkP/UgpCg6YKJDsS9oOTF
         +tyHXPReTqrThK1qFEg+xwOIGvG6iShIuklnbI0300IN3AyX2OX7UCC+uF6nQTHJIu8p
         b3RwIGFG8IXjkC3EhoginddanAo3NxzG7b9AVKlvo7fd/4ZtSBgBWGQTzj1l8h9WHeSY
         /boO1ahu+dScei3M5ZP82VXeYJcRouzOlzmr5wdEaA21U1wuvgiNrexjEcKvc7wcpRhL
         f8Ww==
X-Forwarded-Encrypted: i=1; AJvYcCU13cF1dZonOxhGa8aZeJrUn4tYyqhbxPg4PKFY7WcPvlNofzAhAr3egMCytN4QT7e0YYKpiijnvUM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4NZoV/oVwB80CUNPWkLbF84sA35qIkLs/MhKMECzjSS9rqByw
	TTGeLJrkhH6Rc6C2c9q0/8gjHcdeVLskG5i0jcKkRl8LKASY+3VifvyEUobMo5x9XL1C1FJAgFT
	MsA266xCYVofoxQst4CBGciTh1BBGqvsKV8VKDRCX
X-Gm-Gg: ASbGnctAgUi1pP6RMC2MlmOF+0B/CA/0tBLghs8OCwCQgeWM7NI1TBagE1YSQxXL/B4
	6TXFzTi3pThGYyT9EBWRg5CFGp+4Aidf3M7fnW8tbwPjRfNb2gHEPQptNBBxkM3Lw/IXCSnIv1g
	NGc96F6Q9HMsyP+3jaofC3JOHHgABlkWghEacC9nXdCNiRw69czjlvu48zyIG6nmkTUUTaow/Z5
	zSenE/H57/fX/rcfQU=
X-Google-Smtp-Source: AGHT+IF4j2dTcuEKoeVrEs0LnxH/wwJzu3dY9/6+IagtUrz5IU3n/yiEg1z50JJj/y1DUx8YcpNTnAk71FQMEFepVEs=
X-Received: by 2002:a05:6000:2304:b0:3b7:9613:adef with SMTP id
 ffacd0b85a97d-3b900b5745cmr9997123f8f.55.1754913369119; Mon, 11 Aug 2025
 04:56:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250810-topics-tyr-request_irq2-v8-0-8163f4c4c3a6@collabora.com>
 <20250810-topics-tyr-request_irq2-v8-3-8163f4c4c3a6@collabora.com>
 <aJnM1LgUYjTloVwV@google.com> <4EE6F260-5AC9-47AD-9F34-0D6C224A8559@collabora.com>
In-Reply-To: <4EE6F260-5AC9-47AD-9F34-0D6C224A8559@collabora.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 11 Aug 2025 13:55:56 +0200
X-Gm-Features: Ac12FXw8w6nvRitqzrHquTMt56TrN9V27e6YCIsMGOZIZy8zbO8BtH0S7cK5f34
Message-ID: <CAH5fLghV0aVZBBEmjf9CF9gFyG08dH7nFzKHnHM6RiANuSZaMw@mail.gmail.com>
Subject: Re: [PATCH v8 3/6] rust: irq: add support for non-threaded IRQs and handlers
To: Daniel Almeida <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, 
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org, 
	Joel Fernandes <joelagnelf@nvidia.com>, Dirk Behme <dirk.behme@de.bosch.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 11, 2025 at 1:47=E2=80=AFPM Daniel Almeida
<daniel.almeida@collabora.com> wrote:
>
> Hi Alice,
>
> > On 11 Aug 2025, at 07:58, Alice Ryhl <aliceryhl@google.com> wrote:
> >
> > On Sun, Aug 10, 2025 at 09:32:16PM -0300, Daniel Almeida wrote:
> >> This patch adds support for non-threaded IRQs and handlers through
> >> irq::Registration and the irq::Handler trait.
> >>
> >> Registering an irq is dependent upon having a IrqRequest that was
> >> previously allocated by a given device. This will be introduced in
> >> subsequent patches.
> >>
> >> Tested-by: Joel Fernandes <joelagnelf@nvidia.com>
> >> Tested-by: Dirk Behme <dirk.behme@de.bosch.com>
> >> Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> >
> > Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> >
> >> diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> >> index d6306415f561f94a05b1c059eaa937b0b585471d..f7d89a46ad1894dda5a0a0=
f53683ff97f2359a4e 100644
> >> --- a/rust/kernel/irq.rs
> >> +++ b/rust/kernel/irq.rs
> >> @@ -13,5 +13,11 @@
> >> /// Flags to be used when registering IRQ handlers.
> >> pub mod flags;
> >>
> >> +/// IRQ allocation and handling.
> >> +pub mod request;
> >
> > Same comment here about removing `pub` from `mod request`.
> >
> >> #[doc(inline)]
> >> pub use flags::Flags;
> >> +
> >> +#[doc(inline)]
> >> +pub use request::{Handler, IrqRequest, IrqReturn, Registration};
> >
> > With `pub` removed above, you don't need doc(inline) here.
> >
> > Alice
> >
>
> This was not forgotten, i.e.: from the cover letter:
>
> - Re-exported irq::flags::Flags through a "pub use" (Alice).
> - Note: left the above as optional as it does not hurt to specify the ful=
l
> path anyway. As a result, no modules were made private.
>
> I chose Boqun=E2=80=99s idea, as we don=E2=80=99t have to enforce access =
through the
> re-exports.

I think private module is better:
https://lore.kernel.org/all/aIDo7I9QdIk-VvL7@tardis.local/

> Also, I was getting tons of =E2=80=9Cunreachable_pub=E2=80=9D warnings
> otherwise, FYI.

If you got unreachable_pub warnings, then you are missing re-exports.

Alice

