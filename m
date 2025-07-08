Return-Path: <linux-pci+bounces-31686-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610FCAFCDB8
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 16:34:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 08240162AB1
	for <lists+linux-pci@lfdr.de>; Tue,  8 Jul 2025 14:33:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA2C223DDD;
	Tue,  8 Jul 2025 14:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NOkBWj+b"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C0222127E;
	Tue,  8 Jul 2025 14:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751985208; cv=none; b=irnBvY/z9ZDmZfxC6ZY7IWakI4hLYX+HluXqhzf4qxiJX33JnjtNKmxC8hMx6VbGnypXUI+8Q1LEFKSNmWMvf33NF70pKrV9TpQXJLc1EKR+/bBXtn1m800YSXxuBeklOnSJxsF11FNi5b2sWtVNt9aELVLIXtlpTnxV6a6DugQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751985208; c=relaxed/simple;
	bh=jq8UW/oXK9a4f8Ww539jeWCh+2ltVHEiop7wKc5ohmk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=usgghdcQ/8jWZt25cnc436MVuKh1GGvySt/S9CVO/avt79cHHX3CTlstcN7Ce02FswezG4O5KXnV4fYAM9fqiN6PhEPNY5Qr2e9ePHe/NEKhls0q6cYaQ1zc3DRh5rQ+CL1YoXSV1POP6uUTvNSe/6iwVac/u0U1RBOQQB8wXSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NOkBWj+b; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD192C4CEED;
	Tue,  8 Jul 2025 14:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751985207;
	bh=jq8UW/oXK9a4f8Ww539jeWCh+2ltVHEiop7wKc5ohmk=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=NOkBWj+b9vFN6R58mjMBnju3lsvdMBgXePf5tezo9q7ik4cGIBO5yj/2iL/9bgvTy
	 zRCC30OVEBQ7Jc1mcsc5iNK6xZs8KCv5QzvMHzzzWoy4oLH0owx1/o0An1a2EQNRHA
	 cdu8Ah59yv5z/Ga5zygw27+JsvkyM2BL9A1/DKCTS1KzOmiNjj+SmFVRenEKu6TtfD
	 42g+iAU/h0a+S/9ycOBnQjwgeK/cGvdU0MyLl7KMRZ5Onm7Ig1kwTlYXQ+aSmpHUIe
	 UlsXJ9ju3uPc/MvjRDENO26nytkXuirdM318jfW9mc3nd0XdIiGzGqvevojWm4tdrO
	 qPL5Jr4A6z8Fg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Jul 2025 16:33:23 +0200
Message-Id: <DB6QX7AK77DQ.1OOCW0I0VLRXA@kernel.org>
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng"
 <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: "Benno Lossin" <lossin@kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
X-Mailer: aerc 0.20.1
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <aGeIF_LcesUM9DHk@google.com> <F3D3BD51-65D8-44BE-9007-FBA556DFB7E5@collabora.com> <DB63W1N89KFT.2J2X3Y7SEX1KF@kernel.org> <aG0F2nFpjrW1HmKR@google.com>
In-Reply-To: <aG0F2nFpjrW1HmKR@google.com>

On Tue Jul 8, 2025 at 1:49 PM CEST, Alice Ryhl wrote:
> On Mon, Jul 07, 2025 at 10:30:27PM +0200, Benno Lossin wrote:
>> On Mon Jul 7, 2025 at 6:18 PM CEST, Daniel Almeida wrote:
>> > Alice,
>> >
>> > [=E2=80=A6]
>> >
>> >>> +/// The value that can be returned from an IrqHandler or a Threaded=
IrqHandler.
>> >>> +pub enum IrqReturn {
>> >>> +    /// The interrupt was not from this device or was not handled.
>> >>> +    None,
>> >>> +
>> >>> +    /// The interrupt was handled by this device.
>> >>> +    Handled,
>> >>> +}
>> >>> +
>> >>> +impl IrqReturn {
>> >>> +    fn into_inner(self) -> u32 {
>> >>> +        match self {
>> >>> +            IrqReturn::None =3D> bindings::irqreturn_IRQ_NONE,
>> >>> +            IrqReturn::Handled =3D> bindings::irqreturn_IRQ_HANDLED=
,
>> >>=20
>> >> One option is to specify these in the enum:
>> >>=20
>> >> /// The value that can be returned from an IrqHandler or a ThreadedIr=
qHandler.
>> >> pub enum IrqReturn {
>> >>    /// The interrupt was not from this device or was not handled.
>> >>    None =3D bindings::irqreturn_IRQ_NONE,
>> >>=20
>> >>    /// The interrupt was handled by this device.
>> >>    Handled =3D bindings::irqreturn_IRQ_HANDLED,
>> >> }
>> >
>> > This requires explicitly setting #[repr(u32)], which is something that=
 was
>> > reverted at an earlier iteration of the series on Benno=E2=80=99s requ=
est.
>>=20
>> Yeah I requested this, because it increases the size of the enum to 4
>> bytes and I think we should try to make rust enums as small as possible.
>>=20
>> @Alice what's the benefit of doing it directly in the enum?
>
> Basically all uses of this enum are going to look like this:
>
> 	fn inner() -> IrqReturn {
> 	    if !should_handle() {
> 	        return IrqReturn::None;
> 	    }
> 	    // .. handle the irq
> 	    IrqReturn::Handled
> 	}
> =09
> 	fn outer() -> u32 {
> 	    match inner() {
> 	        IrqReturn::None =3D> bindings::irqreturn_IRQ_NONE,
> 	        IrqReturn::Handled =3D> bindings::irqreturn_IRQ_HANDLED,
> 	    }
> 	}
>
> Setting the discriminant to the values ensures that the match in outer()
> is a no-op. The enum is never going to be stored long-term anywhere so
> its size doesn't matter.

Hmm in this particular case, I think the optimizer will be able to
remove the additional branch too. But I haven't checked.

I usually give the advice to not explicitly set the discriminants and
let the compiler do it. I don't have a strong opinion on this, but we
should figure out which one is better in which cases.

---
Cheers,
Benno

