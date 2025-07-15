Return-Path: <linux-pci+bounces-32153-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3645EB05A5A
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 14:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20883BB141
	for <lists+linux-pci@lfdr.de>; Tue, 15 Jul 2025 12:37:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB992E03EF;
	Tue, 15 Jul 2025 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YoAptYmF"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 708641EDA09;
	Tue, 15 Jul 2025 12:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583043; cv=none; b=UkuQ39j/fGA1//m7scASPuQDOaYsz8NPuXzsHRvoAYD32TXbgriQWnMGfJ0Rr5llDoyDHQOdO0h3HRrmc+M81j/4OZ0/X0x2DDL+zEexXPLY/t6LC1xafJsVi7CilBo9NfAtokVYUIr83eKSKDAS/Lh/k7Ur32sKdoJXpfU9E8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583043; c=relaxed/simple;
	bh=4H+aBzxKOxX4fKGY9phd6BfYevXHiHL6VFDuZqqNKCs=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=iy8dHi7+NvnOFjn0XfyxqC48f0iDMZ3VCG9dPyHRaMIP5tApSwwNKa74Hh7kdpShfIq+0RGdu1qhVNS1569BvHqsKwgdyiVI31eN3TX29V+f+EDFwwTI0zYlbjG+1c+Ec7EfSQh2tAu+UXidXLZcQFstKevX5WzVOo4ouCaGVaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YoAptYmF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6479DC4CEE3;
	Tue, 15 Jul 2025 12:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752583042;
	bh=4H+aBzxKOxX4fKGY9phd6BfYevXHiHL6VFDuZqqNKCs=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=YoAptYmFnHkB8l8z5+wd8IuAvgyVyt66ThExmXk01SrG0IKbi7aVoi/Wv37kGXaLM
	 tdNIaqmJscgbyaCVS+GQ/WQfVLWUTn2uv0USEFIPXmarBlXNqCx8vNicuXDj2fDo4T
	 8oFxcsJciX64VINjE/wPExoSczVs2pCkENZwbV2K7qYr43Gxy/NQbVprltcTykbiMO
	 8ys18LLUlEGM5mPDFTEWX/RZJ7++R1NV8phrLhM5p/9voJURlSwz5g7+kvfjl0vbMl
	 4Kt0xTlVLKZAGTVS/k7omgaBGDyfanjn/rmBG7EiY7FUAHY3mRXHLwu2WIvSY502zl
	 hXxoSDy7H+hcw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Jul 2025 14:37:17 +0200
Message-Id: <DBCMU4L9I666.BQSFUQGO18TF@kernel.org>
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Daniel Almeida" <daniel.almeida@collabora.com>, "Benno Lossin"
 <lossin@kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Andreas Hindborg" <a.hindborg@kernel.org>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, <linux-pci@vger.kernel.org>
To: "Alice Ryhl" <aliceryhl@google.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com> <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com> <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org> <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com> <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org> <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org> <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org> <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org> <C72C6915-3BB2-431F-89ED-7743D8A62B7E@collabora.com> <CAH5fLgibCtmgFpKNrC+jcSEqSUctyVMuYwEC0QSo+vzyDXK0zg@mail.gmail.com>
In-Reply-To: <CAH5fLgibCtmgFpKNrC+jcSEqSUctyVMuYwEC0QSo+vzyDXK0zg@mail.gmail.com>

On Tue Jul 15, 2025 at 2:33 PM CEST, Alice Ryhl wrote:
> On Mon, Jul 14, 2025 at 5:13=E2=80=AFPM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
>>
>> Hi,
>>
>> >
>> >>>
>> >>>  (2) It is guaranteed that the device pointer is valid because (1) g=
uarantees
>> >>>      it's even bound and because Devres<RegistrationInner> itself ha=
s a
>> >>>      reference count.
>> >>
>> >> Yeah but I would find it much more natural (and also useful in other
>> >> circumstances) if `Devres<T>` would give you access to `Device` (at
>> >> least the `Normal` type state).
>> >
>> > If we use container_of!() instead or just pass the address of Self (i.=
e.
>> > Registration) to request_irq() instead,
>>
>>
>> Boqun, Benno, are you ok with passing the address of Registration<T> as =
the cookie?
>>
>> Recall that this was a change requested in v4, so I am checking whether =
we are
>> all on the same page before going back to that.
>>
>> See [0], i.e.:
>> [0] https://lore.kernel.org/all/aFq3P_4XgP0dUrAS@Mac.home/
>
> After discussing this, Daniel and I agreed that I will implement the
> change adding a Device<Bound> argument to the callback. I will be
> sending a patch adding it separately as a follow-up to Daniel's work.

That works for me, thanks!

