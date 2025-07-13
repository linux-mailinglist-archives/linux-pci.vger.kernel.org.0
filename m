Return-Path: <linux-pci+bounces-32025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 74B21B031A5
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 17:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42DE87ACBFA
	for <lists+linux-pci@lfdr.de>; Sun, 13 Jul 2025 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E468F149DF0;
	Sun, 13 Jul 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bIeh/aTE"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F101D52B;
	Sun, 13 Jul 2025 15:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752418933; cv=none; b=cdfJpj4VSxTe+DAKM4DLGEi35ubcgnI914fx0cVQWEYbFz9ZwSfWUomgP6PcfDrTNITFps7H1IdMBF0TJUm4UHh8DUjpVHWLzoE4xcBj42ZDb5z0XhhX8t840Ou31sUIV4FXzwjacpPgr/BhYsrPYfH8qYEgNNV7y7A2++C00tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752418933; c=relaxed/simple;
	bh=A90dj3oV1j45yOLP7rA3zvAhG3d+NaOyZ31cVZY6Dks=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=WbmOaVE3OqYyPUFf3GLncRmymd2YZz7JmeK/OQZVQTB9iIWuGRXEq+3ua3hFDLeVc+GgV+vJ4MaSVOyGwueK7bbFVGXWHiFvC8PQNIEXVjIGOP4CJlP05ufTnsFPTTXfb/ybybzSl6Y067uqavgfKDm926c6jFgNbnmHgi2y9r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bIeh/aTE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5E1DC4CEE3;
	Sun, 13 Jul 2025 15:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752418933;
	bh=A90dj3oV1j45yOLP7rA3zvAhG3d+NaOyZ31cVZY6Dks=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=bIeh/aTE0YGF6T8fxhq+aVNvdTdpMCPDwzfINdvmivl8/J+rT61XTxkY6Nw6sIk/I
	 IDn863rEeIU5JN13wEuRJSKGdX9qBUndzcbiCLfYMecnO8H8ArDITYq6FktJSbCnC3
	 SOak7vttoRCYAK3oK8k4lVVCKpPMBdLUqq8hrM9dRQsxzgjkYp2SqmKeva/0/Qdl5s
	 tKc0nJs7LUOK/4ud7qDK8G1TK5bELPiIM+hem2pUGOj1mhNzSB6GTgLtyXQVj+W7Bm
	 eSIOb7xHgQY16COFFbvKOz6/EhCgrYhIyb6DR8dQbGiB8p/T6ogXF83yg6A42HoqsO
	 b3GXPnevzBmKA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 13 Jul 2025 17:02:08 +0200
Message-Id: <DBB0NXU86D6G.2M3WZMS2NUV10@kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Benno Lossin" <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>,
 "Gary Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org> <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org> <C4A101A7-282D-4A67-A966-CF39850952EA@collabora.com> <DBAZRNHGIGL8.3L2NGPCVXLI25@kernel.org> <DBAZXDRPYWPC.14RI91KYE16RM@kernel.org> <18B23FD3-56E9-4531-A50C-F204616E7D17@collabora.com>
In-Reply-To: <18B23FD3-56E9-4531-A50C-F204616E7D17@collabora.com>

On Sun Jul 13, 2025 at 4:48 PM CEST, Daniel Almeida wrote:
>
>
>> On 13 Jul 2025, at 11:27, Danilo Krummrich <dakr@kernel.org> wrote:
>>=20
>> On Sun Jul 13, 2025 at 4:19 PM CEST, Danilo Krummrich wrote:
>>> On Sun Jul 13, 2025 at 4:09 PM CEST, Daniel Almeida wrote:
>>>> On a second look, I wonder how useful this will be.
>>>>=20
>>>> fn handle(&self, dev: &Device<Bound>) -> IrqReturn
>>>>=20
>>>> Sorry for borrowing this terminology, but here we offer Device<Bound>,=
 while I
>>>> suspect that most drivers will be looking for the most derived Device =
type
>>>> instead. So for drm drivers this will be drm::Device, for example, not=
 the base
>>>> dev::Device type. I assume that this pattern will hold for other subsy=
stems as
>>>> well.
>>>>=20
>>>> Which brings me to my second point: drivers can store an ARef<drm::Dev=
ice> on
>>>> the handler itself, and I assume that the same will be possible in oth=
er
>>>> subsystems.
>>>=20
>>> Well, the whole point is that you can use a &Device<Bound> to directly =
access
>>> device resources without any overhead, i.e.
>>>=20
>>> fn handle(&self, dev: &Device<Bound>) -> IrqReturn {
>>>   let io =3D self.iomem.access(dev);
>>>=20
>>>   io.write32(...);
>>> }
>>=20
>> So, yes, you can store anything in your handler, but the &Device<Bound> =
is a
>> cookie for the scope.
>
> Fine, but can=E2=80=99t you get a &Device<Bound> from a ARef<drm::Device>=
, for example?
> Perhaps a nicer solution would be to offer this capability instead?

I think you're confusing quite some things here.

  (1) I'm talking about the bus device the IRQ is registered for (e.g. PCI,
      platform, etc.). drm::Device represents a class device, which do not
      have DeviceContext states, such as Bound.

  (2) Owning a reference count of a device (i.e. ARef<Device>) does *not*
      guarantee that the device is bound. You can own a reference count to =
the
      device object way beyond it being bound. Instead, the guarantee comes=
 from
      the scope.

      In this case, the scope is the IRQ callback, since the irq::Registrat=
ion
      guarantees to call and complete free_irq() before the underlying bus
      device is unbound.

