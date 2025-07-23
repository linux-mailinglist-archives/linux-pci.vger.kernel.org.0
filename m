Return-Path: <linux-pci+bounces-32814-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E73AAB0F4A2
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:56:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3733A2193
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 13:55:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 182262EF2AB;
	Wed, 23 Jul 2025 13:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="IZ2wD8Ps"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325B91E1DFC;
	Wed, 23 Jul 2025 13:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753278976; cv=pass; b=jg9iLohtpcOSgqp/5yKWEa/43CUyRjNZIYdy1x1K7ebCDTxOPVTPd+e+2dMJKKoTlRU7y8dg/pGBORU/Yv6nkMJG7tV9zNWiguB8ZyJi/AsjOafr2dpDcJEeBBm5aWuc2tyhdzuFlYEcZW3AFa4Z7MWfxSbj1IMbk/ahYQSAgG4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753278976; c=relaxed/simple;
	bh=WCPfY/H6sVXmQLD73jk8jLMrVqtURXHo0WINkodokrs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=o05DhvCmFx708nfpluZXJAhDqSF7sxp1rn6cegZkM1VyhKRuP3Wj6+ohjSqfAb/Ll8YJKfco0rWnpFR4UCWmAp52gvoNGbXpNR9HxP1CKtQBoFAce1mg3NuvD0I2hXeg1+F+fvTBtyw3mi2ogRUBzgoO/NLkglsIDBxEt7Jyj2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=IZ2wD8Ps; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1753278938; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=F8gs2g7hKwFc7BwN6rxu4M6pFEKQacTgEAn3SmaiE9w9rOJWn+GKB3D5uoiSE50c+79GSMYqrnqxwj98dxaRZ21S5H22W/vyvIB/Ho9w2INSxxphb2zbrKKqvyBx93L/jGIxeucCwGUj2z5QmoiKsez/PlOeruDbrHI2K7jsFoo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1753278938; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=rODhMVdHO/UJ1Fnh2P4yz+pCaAyafvDrmoklW4PJVeU=; 
	b=Fw4qPuZTBGeJ6IbIayxmjjEomdfuIaZtsc35zxbKD1gY2/GtTDdutjLrB2pi3lmw69qh6DyqCgRDYf+KE0MQQ4lhXzmw295bH4rJhpB/3SBKf4roG9Fdi9wk5BhAgYFv670dK7/O4uacZiO6t0QVnN3HV52aE9r7+ffYRgpcwoc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1753278938;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=rODhMVdHO/UJ1Fnh2P4yz+pCaAyafvDrmoklW4PJVeU=;
	b=IZ2wD8Ps8PbvuuLCak8rMXitUs5osuaR+XfGSyv66EmFBWzrbP3nCm25BA1ri8/d
	Bc6Hn8VZG3Ve1p+v8L+wcRfW85NvAMMY9vsDgst1AXGOrbQKyqXa4qoa5Rq3+yqfibR
	oaC2g+wOdLinc60rkbLes9eCuVVx+NzerlMa8HAw=
Received: by mx.zohomail.com with SMTPS id 1753278936364407.2406058677078;
	Wed, 23 Jul 2025 06:55:36 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <aIBl6JPh4MQq-0gu@tardis-2.local>
Date: Wed, 23 Jul 2025 10:55:20 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C2=B4nski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com>
 <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com>
 <aIBl6JPh4MQq-0gu@tardis-2.local>
To: Boqun Feng <boqun.feng@gmail.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi Boqun,

[=E2=80=A6]

>> +        IrqRequest { dev, irq }
>> +    }
>> +
>> +    /// Returns the IRQ number of an [`IrqRequest`].
>> +    pub fn irq(&self) -> u32 {
>> +        self.irq
>> +    }
>> +}
>> +
>> +/// A registration of an IRQ handler for a given IRQ line.
>> +///
>> +/// # Examples
>> +///
>> +/// The following is an example of using `Registration`. It uses a
>> +/// [`AtomicU32`](core::sync::AtomicU32) to provide the interior =
mutability.
>=20
> We are going to remove all usage of core::sync::Atomic* when the LKMM
> atomics [1] land. You can probably use `Completion` here (handler does
> complete_all(), and registration uses wait_for_completion()) because
> `Completion` is irq-safe. And this brings my next comment..

How are completions equivalent to atomics? I am trying to highlight =
interior
mutability in this example.

Is the LKMM atomic series getting merged during the upcoming merge =
window? Because my
understanding was that the IRQ series was ready to go in 6.17, pending a =
reply
from Thomas and some minor comments that have been mentioned in v7.

If the LKMM series is not ready yet, my proposal is to leave the
Atomics->Completion change for a future patch (or really, to just use =
the new
Atomic types introduced by your series, because again, I don't think =
Completion
is the right thing to have there).


=E2=80=94 Daniel=

