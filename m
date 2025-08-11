Return-Path: <linux-pci+bounces-33729-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 271A3B208FB
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 14:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D69937B14A0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Aug 2025 12:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EC4E2D3A7B;
	Mon, 11 Aug 2025 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b="Ioa9F5oY"
X-Original-To: linux-pci@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE41E41C62;
	Mon, 11 Aug 2025 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754915960; cv=pass; b=ABA8cMBCK1vf6eHJyAiVz7LQX8ZR1OYgHGDVx5AM2ZEGtICpbtKz8C3S7rohMFQ3I/cMnGS4tXCsjHPs+BozVOhkNtRt1YEjMwvo+CYritKcJcrESdNLgAO/sWrmqm/zAEqAx1H6LuLKlGcfiH8dkV/Jk2debR2gBMkjOhtzkyU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754915960; c=relaxed/simple;
	bh=z2hzk4IfGXWa4JuejGkWiKQo0s3XKBlVLEK9kN6K/lQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=rrkZhqRg81Dc41JDzKQ1n6lYtX5pZtacV9cVUwSLYnGBBZB0eoK+2B4GNE2m3KH6JX1BZev9Rp0t2x0SB7k430unM3M+gSpbSSsSspkH9+SNlU3j7UImIzRzuWvuH5JPGMMICgQX80ls5+tC6D+sdfmOdige+QQp6joCBqA1zrg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=daniel.almeida@collabora.com header.b=Ioa9F5oY; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1754915938; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=nFW+hitDNKztHDu3BY4oB26P8s1cDDMjiYZZvAHQP5SgaD0Pzfj88cX82zVRXVbMBTWSkUbCBGpwvp2AgRXhGNcK5vcgeKpKPUM6WglbrLm2wDCvC6VDrMmLllsTM42+BpoLkqtDikk/bQyRDcLX/vfyqYzjyRGRsDBEBHW28b8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754915938; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=z2hzk4IfGXWa4JuejGkWiKQo0s3XKBlVLEK9kN6K/lQ=; 
	b=mlLlyQmV0FiKndRvBftVnQheamwngjhNkOa5mtzX58SiBNTB0kPTlBd0NtKnKJcgi0DIRnQUHkkrPEoVs+JV7+kLbK+P2gzL31CEefE8uvqMYVab1jH86PC4NiVURvWSvjgYQV9+/g883fuffRrpf4tZpowgYcG0MLFM1F0nAlI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=daniel.almeida@collabora.com;
	dmarc=pass header.from=<daniel.almeida@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754915938;
	s=zohomail; d=collabora.com; i=daniel.almeida@collabora.com;
	h=Content-Type:Mime-Version:Subject:Subject:From:From:In-Reply-To:Date:Date:Cc:Cc:Content-Transfer-Encoding:Message-Id:Message-Id:References:To:To:Reply-To;
	bh=z2hzk4IfGXWa4JuejGkWiKQo0s3XKBlVLEK9kN6K/lQ=;
	b=Ioa9F5oY46jWlA7KeXvEZYb0FxA0buIINAMXinW4lTNZLYMxlGK4jtl7Onfbm6sB
	72venE5LRq61e2yHh8qW0dwQt/JwbB9nLsCRGtdEcWRXzic5Y/ZixmkvZS9jc0ejM7M
	P878dHjWIv5cD1s9zFbGWP+jhK+vmWZmiNUvYXfI=
Received: by mx.zohomail.com with SMTPS id 1754915936203205.61364902100854;
	Mon, 11 Aug 2025 05:38:56 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.600.51.1.1\))
Subject: Re: [PATCH v2] rust: irq: add &Device<Bound> argument to irq
 callbacks
From: Daniel Almeida <daniel.almeida@collabora.com>
In-Reply-To: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com>
Date: Mon, 11 Aug 2025 09:38:41 -0300
Cc: Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>,
 Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
 Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Bjorn Helgaas <bhelgaas@google.com>,
 =?utf-8?Q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
 Benno Lossin <lossin@kernel.org>,
 Dirk Behme <dirk.behme@gmail.com>,
 linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <19D30F1F-BA10-4C38-A0A8-1C0072516B55@collabora.com>
References: <20250811-irq-bound-device-v2-1-d73ebb4a50a2@google.com>
To: Alice Ryhl <aliceryhl@google.com>
X-Mailer: Apple Mail (2.3826.600.51.1.1)
X-ZohoMailClient: External



> On 11 Aug 2025, at 09:33, Alice Ryhl <aliceryhl@google.com> wrote:
>=20
> When working with a bus device, many operations are only possible =
while
> the device is still bound. The &Device<Bound> type represents a proof =
in
> the type system that you are in a scope where the device is guaranteed
> to still be bound. Since we deregister irq callbacks when unbinding a
> device, if an irq callback is running, that implies that the device =
has
> not yet been unbound.
>=20
> To allow drivers to take advantage of that, add an additional argument
> to irq callbacks.
>=20
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> This patch is a follow-up to Daniel's irq series [1] that adds a
> &Device<Bound> argument to all irq callbacks. This allows you to use
> operations that are only safe on a bound device inside an irq =
callback.
>=20
> [1]: =
https://lore.kernel.org/all/20250810-topics-tyr-request_irq2-v8-0-8163f4c4=
c3a6@collabora.com/
> ---
> Changes in v2:
> - Rebase on v8 of [1] (and hence v6.17-rc1).
>=20

Thanks, I=E2=80=99ll apply on top of the series as a convenience to the =
maintainers.

=E2=80=94 Daniel=20


