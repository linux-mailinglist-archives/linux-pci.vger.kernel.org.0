Return-Path: <linux-pci+bounces-32782-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 14346B0EA19
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 07:35:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 106D43B0BD4
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 05:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D67D523A;
	Wed, 23 Jul 2025 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DSvXK+N7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E1C217666
	for <linux-pci@vger.kernel.org>; Wed, 23 Jul 2025 05:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753248942; cv=none; b=Mzbcu1txtGHINVAhVHFP8/rHq1LMk8Z4kv5QYHyJvTAJ1nSqu5HKxTPrjrpkSQM2aY/IIPJg2HH+PW7pNGhJvgtfPBs7KzMKmpUtc/KsS1v/Q5DpiHRM/PETnJ2mMKV3a6Ql0+ZAq4jKhXnAz77skorQBUt9jNcoO3DqXYACE/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753248942; c=relaxed/simple;
	bh=6weO+11TPaueEmO+N60k2RS34e686tvkJkAMxwxUUQU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O3rFJXFlNKXTFZjFIr2FMU4Bfv4StpZXCZQ8SViKY2GMhAOBkZh2zQ/poTPcInuYroz/BJW3NsO2s6XH6u5vqNhlU7T1MgdT4c2PsNR/HaJXV1N3dXj7/4k1IrFWwrgsUUWFHtTCzcNdt24StN6qNfAtTihySiMdzs9sDqgw/Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DSvXK+N7; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-45618ddd62fso64018105e9.3
        for <linux-pci@vger.kernel.org>; Tue, 22 Jul 2025 22:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1753248939; x=1753853739; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=misDX3xhhey1/Ee4g6Fah55nt1o0Q3BJJpIzd+EQspQ=;
        b=DSvXK+N7RoRNM2a/x+4TDUZ4GgF5QJU0YtFxjAjhbQg29iEE7qiMCQJRKd3vU6Tvfz
         xYOzoncDh/98HzYHF1msuZEMzWj62BVL7x1sTyzhOtfRv5oKXvNLthZqkH/ygO4KXNn1
         Xc4OWVfh0CfSQcu2QjvTwXUrJdK2rMCLFvmCwELmRo0ADNgjycKVg2N0MsNL8tCF9fUE
         XMIdAUWYsp97XIIbzjyBpuZZynHC7Z1+vnVmeahPiQBEQeXr/m4Qta4HEzOmVWNX6cl5
         4yqL1k+QIGPGOxHnPJK8eFRQk21zxJCyZ1Cwnw8AGcu6VDWukxpU9KeomluKtuPm7Sak
         /FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753248939; x=1753853739;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=misDX3xhhey1/Ee4g6Fah55nt1o0Q3BJJpIzd+EQspQ=;
        b=PThCjv0t/gKou4Pben/c/ffHnLilbbRTuP9oDM6kieRtaMxLyScWU8xcEvQaPVSBsW
         P1m3Im868qjDstnCYCW6fq4qfGh0NETWKTZXblKp5H2bGP0o24MaEkNa8msshFkc2/3r
         pAanwfPLw7CJWtHLaLWBiuaPAKaOPaTWo7UlnuqHNYBrnTb5vgXgowkKbVNKNz8XNqCH
         65CGdQ8OL5FykLyQrZ7FhSLSK7vuaK9NV8DfPri94Mc/2yYkvsk4RkM4YJ8WTy26ZQHb
         HEEXqR01xrdf62IcAJReecIoozHTNuxwXACVW/aleHdMVyp+ddqkmg25c/fmUDhpA157
         XvbA==
X-Forwarded-Encrypted: i=1; AJvYcCXyBcuAqZCa1SGWiNfzcQE63Ill1hJLMOyBAgF4W/c1bN4pS/vN9Z+cQc1M9J6R97eXeTJLAXzX+xM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhe8zbAk9/+nQb6X5IcmNoyXQCE98XPZj3p40tLwz2EDQ6LE7f
	UXrVXweIdbOIOhqWptnL90eJrleyevI0bA1YKzE2DJmn86jvQY0NuApAi2v/hAnSMKpKSVP8Djg
	8P+1RlSrTbj3AP9LVOoNRilbLkaI/wBP8M0lBfS2L
X-Gm-Gg: ASbGnctriAfDQnRUU49sVT7DFeGwazHF9WBb6kDn4UEHVoblGJSx4qDy4895M3Pac3b
	OeunuLxvPyreETtykJKtwqPRavX3b/Gbrcwf4lF6uu3g8nviLlpFqUnDEBErc1O3mLmSxeirvHH
	70pfHGlkEIlNpoSjqXjCxfO6mX8Vsb2AwHEiMFHu2xJueWFlDeoKEKaxJBd1sYCucgFPBIOACGf
	QJt+6uT
X-Google-Smtp-Source: AGHT+IHNShXoWdYryFdvfM0BEQvsY8qvEO9TCxAKKFyJqyIWBzC7bz3ZFyJKohqqa1RffQgDHIkvL0pc5faxAU2GEzQ=
X-Received: by 2002:a05:600c:c049:b0:439:643a:c8d5 with SMTP id
 5b1f17b1804b1-4586954d017mr7246425e9.0.1753248938828; Tue, 22 Jul 2025
 22:35:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com> <aIBl6JPh4MQq-0gu@tardis-2.local>
In-Reply-To: <aIBl6JPh4MQq-0gu@tardis-2.local>
From: Alice Ryhl <aliceryhl@google.com>
Date: Wed, 23 Jul 2025 07:35:26 +0200
X-Gm-Features: Ac12FXzZP0H1FA0yYS9XjdZ_C7JXHhbQOSI5Z-r3NcsXNOMmC54uhBL6c-4crs0
Message-ID: <CAH5fLgjsRMuN8NDgXD_4R3Wk4PqcZhZnnruAC+0WRYkz=U7rJw@mail.gmail.com>
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and handlers
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Bjorn Helgaas <bhelgaas@google.com>, =?UTF-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>, 
	Benno Lossin <lossin@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 23, 2025 at 6:32=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> On Tue, Jul 15, 2025 at 12:16:40PM -0300, Daniel Almeida wrote:
> > This patch adds support for non-threaded IRQs and handlers through
> > irq::Registration and the irq::Handler trait.
> >
> > Registering an irq is dependent upon having a IrqRequest that was
> > previously allocated by a given device. This will be introduced in
> > subsequent patches.
> >
> > Signed-off-by: Daniel Almeida <daniel.almeida@collabora.com>
> > ---
> [...]
> > diff --git a/rust/kernel/irq.rs b/rust/kernel/irq.rs
> > index 9abd9a6dc36f3e3ecc1f92ad7b0040176b56a079..01bd08884b72c2a3a946089=
7bce751c732a19794 100644
> > --- a/rust/kernel/irq.rs
> > +++ b/rust/kernel/irq.rs
> > @@ -12,3 +12,8 @@
> >
> >  /// Flags to be used when registering IRQ handlers.
> >  pub mod flags;
> > +
> > +/// IRQ allocation and handling.
> > +pub mod request;
> > +
> > +pub use request::{Handler, IrqRequest, IrqReturn, Registration};
>
> I woulde use #[doc(inline)] here for these re-export. It'll give a list
> of struct/trait users can use in the `irq` module.

You get the same effect by making `mod request` a private module.

Alice

