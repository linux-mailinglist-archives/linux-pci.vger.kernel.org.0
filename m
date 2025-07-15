Return-Path: <linux-pci+bounces-32139-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E40B056DA
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 11:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD25C16356C
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 09:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FF772D4B75;
	Tue, 15 Jul 2025 09:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eTOZxnBj"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01A6D34545;
	Tue, 15 Jul 2025 09:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572520; cv=none; b=l52Q0MZQUx10Yr7Ts74F+V519DXlpFHpp+qgHqr7qcKAEXiITDrjvxuR/lJOgQyB11PEN599K2iI581kZQge6Ed5KvFFt1ehsKXO8oyYrsFlUBxC+zuqVmR6S5CPXWflsCJp8CSDdTB0HoVacutfhyxTh+ceHDwxuteoE/RcXpg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572520; c=relaxed/simple;
	bh=So9/pKa+ojKVsBIdBvJ+WLlEeTfjisRwZyC0vlqYb/U=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=Lu8Q8Fzs1gCLBMCyCix6kPUImQlBbSA0EuBPTilqT1z7Hl/OrEYCxG/7WGEeRv9OUpALJPy4Ia+CvVfr6ED/DGWGIwEGmBBKZ3w6LHkv5vVgKGiu7Koa2x7mmHiamRuaNzcLx2mzVuqvPfZWem0C2uyffZdzlMqCf16t2NunZX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eTOZxnBj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0DB0C4CEE3;
	Tue, 15 Jul 2025 09:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752572519;
	bh=So9/pKa+ojKVsBIdBvJ+WLlEeTfjisRwZyC0vlqYb/U=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=eTOZxnBjT4CaWI/ETNIsmthZr+NBkKtGWMEtafOmdjG/kKRHfw9RXkYmr1/IfSTtd
	 GQiULVrZpPPNF6JUfoicu3EHp07ex/0D/sI5u4zzj9xACP+MSK0AckTFvZ/RTRKmTL
	 4XvJMIXbtJMDYsUhLB+84f2sYuFJMfglR7AW1EKPgcnlPKQqmUwMN7RWjNJ0OxE8b9
	 UQfG5tUb1gFlWmagLciWXYZ3KrnJ6+lmrxv8oIY9pan8AOnQWSzmSrtiIA6cqTEilb
	 as4+h2dxnaZmITvfxosclBJ5XozGd6nbNkRf3MFgGas2s2J0u/9+QNvH/DoNjFFOKL
	 jZBRRAdQa4btQ==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 11:41:53 +0200
Message-Id: <DBCJ3U18L8UL.1A93V6DZ764FR@kernel.org>
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Alice Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn
 Helgaas" <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: "Benno Lossin" <lossin@kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>, "Danilo Krummrich"
 <dakr@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org> <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org> <C72C6915-3BB2-431F-89ED-7743D8A62B7E@collabora.com>
In-Reply-To: <C72C6915-3BB2-431F-89ED-7743D8A62B7E@collabora.com>

On Mon Jul 14, 2025 at 5:12 PM CEST, Daniel Almeida wrote:
> Hi,
>
>>=20
>>>>=20
>>>>  (2) It is guaranteed that the device pointer is valid because (1) gua=
rantees
>>>>      it's even bound and because Devres<RegistrationInner> itself has =
a
>>>>      reference count.
>>>=20
>>> Yeah but I would find it much more natural (and also useful in other
>>> circumstances) if `Devres<T>` would give you access to `Device` (at
>>> least the `Normal` type state).
>>=20
>> If we use container_of!() instead or just pass the address of Self (i.e.
>> Registration) to request_irq() instead,
>
>
> Boqun, Benno, are you ok with passing the address of Registration<T> as t=
he cookie?
>
> Recall that this was a change requested in v4, so I am checking whether w=
e are
> all on the same page before going back to that.

I looked at the conversation again and the important part is that you
aren't allowed to initialize the `RegistrationInner` before the
`request_irq` call was successful (because the drop will run
`irq_free`). What pointer you use as the cookie doesn't matter for this.

Feel free to double check again with the concrete code.

---
Cheers,
Benno

> See [0], i.e.:
>
>> > > >> Well yes and no, with the Devres changes, the `cookie` can just b=
e the
>> > > >> address of the `RegistrationInner` & we can do it this way :)
>> > > >>
>> > > >> ---
>> > > >> Cheers,
>> > > >> Benno
>> > > >
>> > > >
>> > > > No, we need this to be the address of the the whole thing (i.e.
>> > > > Registration<T>), otherwise you can=E2=80=99t access the handler i=
n the irq
>> > > > callback.
>>=20
>> You only need the access of `handler` in the irq callback, right? I.e.
>> passing the address of `handler` would suffice (of course you need
>> to change the irq callback as well).
>
>
> =E2=80=94 Daniel
>
> [0] https://lore.kernel.org/all/aFq3P_4XgP0dUrAS@Mac.home/


