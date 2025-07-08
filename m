Return-Path: <linux-pci+bounces-31682-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97171AFC9D8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 13:49:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A5DF482BE3
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C414C2D9EE2;
	Tue,  8 Jul 2025 11:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zw8X+kzY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 156CF2C15A6
	for <linux-pci@vger.kernel.org>; Tue,  8 Jul 2025 11:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751975391; cv=none; b=jyGk7BznDZKPhac/2yj74uBv5hDSKdlVrGs7+g/4cNHHephKrCTYi+aylmz60/8O3Bv1Z+zyVRRNZUVsw+7FpxxLzdNNS9UIGyAOKpHSoVCfoNRGzvUPid0MJmBUGLuBlx850kS5FzeV6YsDD/M8QNb+abGxcmgosW8lMRM0mbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751975391; c=relaxed/simple;
	bh=Vkvwc6PqUHJYMxuZWBD0Ix8x7TFVjO+QBzrO1/WRmy0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=E6j0GHUkjDv79DEC94/7NSA9NKZTWIOboq6AuRFRRcKe1NkFxzIa44ywwWyVrJjtGUfnqE2ou6pRdduVlXu9nEziXqdb+wlOnCa9VfyHy7ja3k4Lpwglg6avMBh/v5ZG5M4wfs0qFiX/D0gs6EkXz4u8vBU2Dd+0LcE7Z+a02rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zw8X+kzY; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-3a4eee2398bso1831092f8f.1
        for <linux-pci@vger.kernel.org>; Tue, 08 Jul 2025 04:49:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751975388; x=1752580188; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PY6QNxjg77faTmjRXPTnc6BZ6+1q/R3i4YmrdcTB0oQ=;
        b=Zw8X+kzYwgwIDM4Ubj9cl5YLy7hlFVDA3N189a1AwVBFFC3kSxjG+x99D4xCOD36ek
         FqPFz+trOw1RiRiI8l+r0i10ZVUc23OBenvLt6pQMLkyGJmVngVH7yroelY9noYwBhOn
         H4U7ELKgGZ/zEwX7rbqy6FGjsQOWKqFOeajCGFQlR810rKFkXYMfl1gUVuoLC0obQqP/
         9fiZYdO7m08ivfl2D2n2P1tk5sEAsFsJV/aGStePbud2cWIMQdfGkQVIHTobeJZ6zwWZ
         puSBYF3uTZOPP3ZKgWCwio20yYbT1eekKsD1uppBOOc7yORnaiWGsiMiDVYsmIPwS4qw
         sKMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751975388; x=1752580188;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PY6QNxjg77faTmjRXPTnc6BZ6+1q/R3i4YmrdcTB0oQ=;
        b=BwbltnfXvtPN9dq97cj9vDwQM7n2dSL/Z4UcYetXHXOlFrSfH8Zg810LxER42RxiqE
         sk1+uLkHyhJwsqdteXUznyC56/bIg4oZs+n5KilNHOksRiKnyLX7VEkLH78QFY6NWn5g
         EcI1swAVA29LmaT21gu152ZtXmiHlatupAYRO3WW4UV4KEDCSMyHfGmyqPO8kqvLhKTE
         wFxApj5GxqjohOMCPl0gVzhqGv3zHqIeFUIl+7RBG7pAeShM0uYkJFIEV1rAPXx49V5C
         IVZgD1eQQGiYX5rEwO3dTM/CohJ8+6x4M/jYhN0eOQFjbQpKNuARbkYd/wJVoo72PG7Z
         AbzA==
X-Forwarded-Encrypted: i=1; AJvYcCXwua02at094TZi+hpraOsmzGWBJYI1TpJKqGSCxyGpq6Q14NhegnnIsZMccfaWXpJLwWIHd2FMmwk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxA/TLRqhv7ohjtsuYLHrFJE+tLnSz+YsbfvkAkAwFhT2gZN/64
	859P5nTyWmt4ESVT8FYNjO+zfcOVau2Mv2UXSLMruE0uRcVqQKKmRXmeBt0byepz12CtmLTlTcl
	EB9AsU+mUD5fKnMNwmA==
X-Google-Smtp-Source: AGHT+IEGVBkp2x/KhrY8Zgqx6AZWD4y2LDNS7/l9boWXtXnyNFOEnp0BDX65Tj4kRBIwgxeQCsYcSUVImsutNIs=
X-Received: from wrbfi14.prod.google.com ([2002:a05:6000:440e:b0:3a6:e2a0:595d])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:5888:0:b0:3a4:eecf:b8cb with SMTP id ffacd0b85a97d-3b5dde8bc33mr2486256f8f.28.1751975388118;
 Tue, 08 Jul 2025 04:49:48 -0700 (PDT)
Date: Tue, 8 Jul 2025 11:49:46 +0000
In-Reply-To: <DB63W1N89KFT.2J2X3Y7SEX1KF@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <aGeIF_LcesUM9DHk@google.com> <F3D3BD51-65D8-44BE-9007-FBA556DFB7E5@collabora.com>
 <DB63W1N89KFT.2J2X3Y7SEX1KF@kernel.org>
Message-ID: <aG0F2nFpjrW1HmKR@google.com>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and handlers
From: Alice Ryhl <aliceryhl@google.com>
To: Benno Lossin <lossin@kernel.org>
Cc: Daniel Almeida <daniel.almeida@collabora.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, 
	Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Bjorn Helgaas <bhelgaas@google.com>, 
	"Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=" <kwilczynski@kernel.org>, linux-kernel@vger.kernel.org, 
	rust-for-linux@vger.kernel.org, linux-pci@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 07, 2025 at 10:30:27PM +0200, Benno Lossin wrote:
> On Mon Jul 7, 2025 at 6:18 PM CEST, Daniel Almeida wrote:
> > Alice,
> >
> > [=E2=80=A6]
> >
> >>> +/// The value that can be returned from an IrqHandler or a ThreadedI=
rqHandler.
> >>> +pub enum IrqReturn {
> >>> +    /// The interrupt was not from this device or was not handled.
> >>> +    None,
> >>> +
> >>> +    /// The interrupt was handled by this device.
> >>> +    Handled,
> >>> +}
> >>> +
> >>> +impl IrqReturn {
> >>> +    fn into_inner(self) -> u32 {
> >>> +        match self {
> >>> +            IrqReturn::None =3D> bindings::irqreturn_IRQ_NONE,
> >>> +            IrqReturn::Handled =3D> bindings::irqreturn_IRQ_HANDLED,
> >>=20
> >> One option is to specify these in the enum:
> >>=20
> >> /// The value that can be returned from an IrqHandler or a ThreadedIrq=
Handler.
> >> pub enum IrqReturn {
> >>    /// The interrupt was not from this device or was not handled.
> >>    None =3D bindings::irqreturn_IRQ_NONE,
> >>=20
> >>    /// The interrupt was handled by this device.
> >>    Handled =3D bindings::irqreturn_IRQ_HANDLED,
> >> }
> >
> > This requires explicitly setting #[repr(u32)], which is something that =
was
> > reverted at an earlier iteration of the series on Benno=E2=80=99s reque=
st.
>=20
> Yeah I requested this, because it increases the size of the enum to 4
> bytes and I think we should try to make rust enums as small as possible.
>=20
> @Alice what's the benefit of doing it directly in the enum?

Basically all uses of this enum are going to look like this:

	fn inner() -> IrqReturn {
	    if !should_handle() {
	        return IrqReturn::None;
	    }
	    // .. handle the irq
	    IrqReturn::Handled
	}
=09
	fn outer() -> u32 {
	    match inner() {
	        IrqReturn::None =3D> bindings::irqreturn_IRQ_NONE,
	        IrqReturn::Handled =3D> bindings::irqreturn_IRQ_HANDLED,
	    }
	}

Setting the discriminant to the values ensures that the match in outer()
is a no-op. The enum is never going to be stored long-term anywhere so
its size doesn't matter.

Alice

