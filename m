Return-Path: <linux-pci+bounces-31642-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8522FAFBC8D
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 22:30:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769287AF2A4
	for <lists+linux-pci@lfdr.de>; Mon,  7 Jul 2025 20:29:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E60B4140E5F;
	Mon,  7 Jul 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJ4zCZAl"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB96621ABB7;
	Mon,  7 Jul 2025 20:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751920232; cv=none; b=IRJuqDfj8koryThlqF+ocHSRrX3h1PzlWut52mcsLZaLmrMChAgkTM/UHtGPoBEh71kLMA0KQvXH656Nw4eAWK+DZRH7xUEqow/59h0bvnUDZeWJTCDpCSp9p99TRIQdDguxfQD37gXiipYG6mbMV5WbkwlKTyAdLi9yVDbqKTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751920232; c=relaxed/simple;
	bh=C0ELEEnglIhvtCBJRI+7bckrda+P++efeIdBibyAEps=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Xxg9VD49UYwviqvKjTPC9Br8uaInwau/Lbj0vHq2Ue+rTAmiIO7oE/mcWyfZuQZ/mVJfQkCtAis3Bi8brx06IbfyDu85AMG15qQSbGWkarTTSphDyUfZnasex4+vkXT0yFzfVVKoZ7fy/ZLzKOXDN5XBcVP4nBuSq9GoD5ZXa4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJ4zCZAl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E052BC4CEE3;
	Mon,  7 Jul 2025 20:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751920232;
	bh=C0ELEEnglIhvtCBJRI+7bckrda+P++efeIdBibyAEps=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=nJ4zCZAlyjGDjSCdRpyeWnC9SZbTFHChqTTXnkuVzo3j+0OK3cZvcyI3vg66gaHSY
	 vAml93ZPMQqFwYI/ZAqmQWf/MJNW2D0SWocat7HYl9Zspml/2dvaJtK2hdFFPVtId1
	 znrzTeXDRuh5zqfQkJrXKmMPbINE71zCxBUVbLdBOGvYkdcXngWTUk8ZoTv3syRhMk
	 6W3zYC2hfxTRKXSYxvkgNZHSZMArIkyIJdmSsBlIXpGKzAKC+dVuBzGnikxVIh8lH9
	 2IhUaADWeJ7Y5I02NWIRyshagX7BaJpp0rbdmf3rmQEk7OtYIpUd0dvSyH67zr27Xl
	 up2f60jGraCNw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 07 Jul 2025 22:30:27 +0200
Message-Id: <DB63W1N89KFT.2J2X3Y7SEX1KF@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: "Benno Lossin" <lossin@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Alice Ryhl"
 <aliceryhl@google.com>
X-Mailer: aerc 0.20.1
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <aGeIF_LcesUM9DHk@google.com> <F3D3BD51-65D8-44BE-9007-FBA556DFB7E5@collabora.com>
In-Reply-To: <F3D3BD51-65D8-44BE-9007-FBA556DFB7E5@collabora.com>

On Mon Jul 7, 2025 at 6:18 PM CEST, Daniel Almeida wrote:
> Alice,
>
> [=E2=80=A6]
>
>>> +/// The value that can be returned from an IrqHandler or a ThreadedIrq=
Handler.
>>> +pub enum IrqReturn {
>>> +    /// The interrupt was not from this device or was not handled.
>>> +    None,
>>> +
>>> +    /// The interrupt was handled by this device.
>>> +    Handled,
>>> +}
>>> +
>>> +impl IrqReturn {
>>> +    fn into_inner(self) -> u32 {
>>> +        match self {
>>> +            IrqReturn::None =3D> bindings::irqreturn_IRQ_NONE,
>>> +            IrqReturn::Handled =3D> bindings::irqreturn_IRQ_HANDLED,
>>=20
>> One option is to specify these in the enum:
>>=20
>> /// The value that can be returned from an IrqHandler or a ThreadedIrqHa=
ndler.
>> pub enum IrqReturn {
>>    /// The interrupt was not from this device or was not handled.
>>    None =3D bindings::irqreturn_IRQ_NONE,
>>=20
>>    /// The interrupt was handled by this device.
>>    Handled =3D bindings::irqreturn_IRQ_HANDLED,
>> }
>
> This requires explicitly setting #[repr(u32)], which is something that wa=
s
> reverted at an earlier iteration of the series on Benno=E2=80=99s request=
.

Yeah I requested this, because it increases the size of the enum to 4
bytes and I think we should try to make rust enums as small as possible.

@Alice what's the benefit of doing it directly in the enum?

---
Cheers,
Benno

