Return-Path: <linux-pci+bounces-30504-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F56AE6553
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 060233A860A
	for <lists+linux-pci@lfdr.de>; Tue, 24 Jun 2025 12:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05AA622B5A3;
	Tue, 24 Jun 2025 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TbKSiOw8"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBDA156B81;
	Tue, 24 Jun 2025 12:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750769189; cv=none; b=Yd2S6oaNi9JsFcUSImvzlQbRRv8dbHS3aeCpQ+dSeeEKboPi/SvQaESd75pzCPMvkvZ6mhjTeulIHvYd+pUHopsSjHx+tYGUazX1/LzkWQ6SfWLwrN/sv9CIwhYtnIzxns+fB8FsQwhVvapU4SapybRZxgSTNP20dK272F+CUbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750769189; c=relaxed/simple;
	bh=RdmvkU7zbsp1GGLnDF1okwRvijnnAgoRsQAHXDHpULM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Q7GCTaD5wnG2ryeUMr6SwPHIo1hbHtAtRuhwobed+c3rilfJSlMWKY/CaGa6MLbYc97Q5/cpF6E0gwmGuLHYKwkplZKebThELoqxWXmLbqlgoyGQnCv7g04HojhR71hMhdcJijxtwc9ra+gD2TKcpNlcGqXMgWxfz91KU2fmVsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TbKSiOw8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FC6C4CEE3;
	Tue, 24 Jun 2025 12:46:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750769188;
	bh=RdmvkU7zbsp1GGLnDF1okwRvijnnAgoRsQAHXDHpULM=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=TbKSiOw8qOeDDDpO0G4u2IR+zED7E6RjYG4IyxZIdZjBRaqK8TkSxwz/Zxh2CB6tv
	 VPuNpPLmIlNVRS4a54Y42deOed29dHUcWQCkFdn4bfISW52QsSDGu+Cm0s/4JC+xiS
	 sGwMBKoJrJN1CZ/6E1prZZDSSZ2HuM/2EyP9J1yR3DBC4wa9bXY+R5EgZwPRpdruhp
	 nej8i1IpvPioEt+zdObcQ1xJPmKDs3flKtmTb3szLJEdxfVxJ5VL9zUNsny6Y1M/OP
	 gxeIBA15jDbDp1JzIY84KSlo46AoxG4B19HGDKBUqIgskVVVBYgcQ3hk2cpHfI7Ydz
	 RkLHZBCMimPnQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Jun 2025 14:46:23 +0200
Message-Id: <DAURVNHM7PKM.PLUFKFRVXR25@kernel.org>
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Danilo Krummrich" <dakr@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: "Benno Lossin" <lossin@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
X-Mailer: aerc 0.20.1
References: <20250608-topics-tyr-request_irq-v4-0-81cb81fb8073@collabora.com> <20250608-topics-tyr-request_irq-v4-3-81cb81fb8073@collabora.com> <aEbJt0YSc3-60OBY@pollux> <CAH5fLghDbrgO2PiKyKZ87UrtouG25xWhVP_YmcgO0fFcnvZRkQ@mail.gmail.com> <DAU0NHTHTDG4.2HNEABNAI8GHZ@kernel.org> <aFmPZMLGngAE_IHJ@tardis.local> <aFmodsQK6iatXKoZ@tardis.local> <DAU5TAFKJQOF.2DFO7YAHZA4V2@kernel.org> <DB7F39EC-5F7D-49DA-BF2B-6200998B45E2@collabora.com>
In-Reply-To: <DB7F39EC-5F7D-49DA-BF2B-6200998B45E2@collabora.com>

On Tue Jun 24, 2025 at 2:31 PM CEST, Daniel Almeida wrote:
> On 23 Jun 2025, at 16:28, Benno Lossin <lossin@kernel.org> wrote:
>> On Mon Jun 23, 2025 at 9:18 PM CEST, Boqun Feng wrote:
>>>    try_pin_init!(&this in Self {
>>>        handler,
>>>        inner: Devres::new(
>>>            dev,
>>>            RegistrationInner {
>>>                // Needs to use `handler` address as cookie, same for
>>>                // request_irq().
>>>                cookie: &raw (*(this.as_ptr().cast()).handler),
>>>                irq: {
>>>                     to_result(unsafe { bindings::request_irq(...) })?;
>>>  irq
>>> }
>>>             },
>>>             GFP_KERNEL,
>>>        )?,
>>>        _pin: PhantomPinned
>>>    })
>>=20
>> Well yes and no, with the Devres changes, the `cookie` can just be the
>> address of the `RegistrationInner` & we can do it this way :)
>>=20
>> ---
>> Cheers,
>> Benno
>
>
> No, we need this to be the address of the the whole thing (i.e.
> Registration<T>), otherwise you can=E2=80=99t access the handler in the i=
rq
> callback.

Gotcha, so you keep the cookie field, but you should still be able to
use `try_pin_init` & the devres improvements to avoid the use of
`pin_init_from_closure`.

---
Cheers,
Benno

