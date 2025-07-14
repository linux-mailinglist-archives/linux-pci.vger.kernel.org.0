Return-Path: <linux-pci+bounces-32073-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A55B04343
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 17:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373B216CB74
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jul 2025 15:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8B425BF13;
	Mon, 14 Jul 2025 15:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="JZjoEz6t"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 006F2246BB6;
	Mon, 14 Jul 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506015; cv=pass; b=IPz6loCuS8Ip+ikVeJOXQepNtHJ6sp+2sPSsGkOibRhH7EyF1fvBhyF1tmhlIjGYhA/5fKgBFLxWe8jQlrCutytRfpQJU3HZUpbPzumSZUc7L5ceHBprTad9dON0otmAebPKghEkSKoRX5xp5gkV0wpufRU7nzeomxbtCQNLIKQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506015; c=relaxed/simple;
	bh=nJiikquzfUrzFUhNIuX0ECRmGYdrZHV3lqYtqRvTxBs=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mpZWrVGSTP/1YtKGI52r7UabIIhAwTzS3oIrAmiPcoKNBWS/ukree69PI6h86g7MGGSaZUDz1ZkjulSheqX+NOMKDg76PjBjj2+xT4a2ftfjRafzgjrKFY87fHzGHh9KFES4e8EekkqMa+CIe+upRqFUhjfn2gKBuM3DzmFlDYY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=JZjoEz6t; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752505977; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=km5zAZoLfL/WUb967j5t6pTQLOqlE/hCyn4dfValQ33r2PPYF1clj4JizQQYVye64EJc9AaSBrz6mlDgJbILLGjJ6PpHTeNWPotaSD3VXu/wbIlGM9YBnKNIu9cC1iK9URk3uxOnsa359HKdD+v5flNBJaZGxbrSI8H4Q52+LQA=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752505977; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yBrlm4HyOYxQkzzRxHxRaO+Keb2kNTFdYZHjEVJuhcQ=; 
	b=Tr/UWc97z9Yzs8IwsT9Y0vxxHidUvmLru3XRHR1hcVlxME9MJTHIepbdOH6H6RGEsaqmYMYfP60GG+//I5Td8c4bZw4RLvfa7gRk9xVpuzgY4rff4enlfMZM9M5UdEX5kkMQ5vFTUXboArZMVT9vOsKUQLi9ssTKHfyXLV51zd8=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752505977;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=yBrlm4HyOYxQkzzRxHxRaO+Keb2kNTFdYZHjEVJuhcQ=;
	b=JZjoEz6tslhhAyRvEcXPkQQ0Q4J294ajkKGf//YP5vKaaV4+f0z246Jq7QFFfoYX
	62Q76oL9uB2FHdoJ4ybI8bcs5KlzG1/XgNZi3R6BDkfqJ/xIFVPxjCgU/wuArvAFiK6
	+LxfaTyABQztaoAL2h7EsDCc9gstcNnIuPc4fvzg=
Received: by mx.zohomail.com with SMTPS id 1752505974334461.4752414079642;
	Mon, 14 Jul 2025 08:12:54 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v6 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>
Date: Mon, 14 Jul 2025 12:12:37 -0300
Cc: Benno Lossin <lossin@kernel.org>,
 Miguel Ojeda <ojeda@kernel.org>,
 Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <C72C6915-3BB2-431F-89ED-7743D8A62B7E@collabora.com>
References: <20250703-topics-tyr-request_irq-v6-0-74103bdc7c52@collabora.com>
 <20250703-topics-tyr-request_irq-v6-3-74103bdc7c52@collabora.com>
 <DBAE5TCBT8F8.25XWHTO92R9V4@kernel.org>
 <DAD3292B-2DBF-442A-8B60-A999AE0F6511@collabora.com>
 <DBAURC9BEFI0.1LQCRIDT6ZBV9@kernel.org>
 <DBAVXQTMR38Z.2782EGR84L7OP@kernel.org>
 <DBAWQG1PX5TO.6I2ARFGLX88N@kernel.org> <DBAX59YKO0FV.ANLOWRHDDS92@kernel.org>
 <DBAXP68U809C.2G8DMB52M3UZ7@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External

Hi,

>=20
>>>=20
>>>  (2) It is guaranteed that the device pointer is valid because (1) =
guarantees
>>>      it's even bound and because Devres<RegistrationInner> itself =
has a
>>>      reference count.
>>=20
>> Yeah but I would find it much more natural (and also useful in other
>> circumstances) if `Devres<T>` would give you access to `Device` (at
>> least the `Normal` type state).
>=20
> If we use container_of!() instead or just pass the address of Self =
(i.e.
> Registration) to request_irq() instead,


Boqun, Benno, are you ok with passing the address of Registration<T> as =
the cookie?

Recall that this was a change requested in v4, so I am checking whether =
we are
all on the same page before going back to that.

See [0], i.e.:

> > > >> Well yes and no, with the Devres changes, the `cookie` can just =
be the
> > > >> address of the `RegistrationInner` & we can do it this way :)
> > > >>
> > > >> ---
> > > >> Cheers,
> > > >> Benno
> > > >
> > > >
> > > > No, we need this to be the address of the the whole thing (i.e.
> > > > Registration<T>), otherwise you can=E2=80=99t access the handler =
in the irq
> > > > callback.
>=20
> You only need the access of `handler` in the irq callback, right? I.e.
> passing the address of `handler` would suffice (of course you need
> to change the irq callback as well).


=E2=80=94 Daniel

[0] https://lore.kernel.org/all/aFq3P_4XgP0dUrAS@Mac.home/=

