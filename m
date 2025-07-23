Return-Path: <linux-pci+bounces-32824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED1D3B0F6AD
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 17:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83E5B1C2628C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Jul 2025 15:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB6B2FC3AB;
	Wed, 23 Jul 2025 15:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVLbBCAc"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF712F85FE;
	Wed, 23 Jul 2025 15:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753283001; cv=none; b=RMHNVwQ72OB97AZt+etlG7uUPbvnO/kOiIwKjzjjscqDkBhcwl5brQA/AV+aZr9EUq8DnRiQoQU9N/QimnXk9vup/JnbMZk7/OCo1rGXj3JNP6xV1G/+L18X5O0S+5kU61v+xCe64STaSw4Uu9nJ8mFn+8VuAJgaQk+6NxNzIM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753283001; c=relaxed/simple;
	bh=WWTb+6ti3vUKjHVhd54re/0m6tya3/HZoN8eV4EAb/o=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=fwsdjZ+WAlGAXyvpzn6dgUInlgcSo44gDIqR2A5hxwNXP5SrSnducR07JwSH8Ol+LcJDL/mDkd+amfcsm42yXlVKTvXt/dTuZwVx+Nm6BiHEpl3x1geTpvM0XI7CdMIJSaHdJaKuImHU818aSSJP6cbbm/F7arS77ZgeiVHoEmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVLbBCAc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5ADEBC4CEE7;
	Wed, 23 Jul 2025 15:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753282997;
	bh=WWTb+6ti3vUKjHVhd54re/0m6tya3/HZoN8eV4EAb/o=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=hVLbBCAcYVOFDM3Nyy2EgZ5pZ/3YXoCq0ii5ijFaDiFBQqaXqkhnxkeTUugCyFx4z
	 RPypRjiyLJwhKj3HfE+SMxuYbHm4mdO6Rq2R+0sRPj0WwMmNpoL7qFrQDtLLBeTsoF
	 AMwDa0smanMdbwJLs5SRYWsUSPYUMCEpADLetJpZFGzeQF4QQJkhHpURZztRQT6btD
	 /ky5+nrz6fow1kPuA2kgmOeNHInktm3LbTFmm+0T07MlYhfOntAjRrvzaEHw1+LWO8
	 4sESgJX/PjiAyJ2xDGzQjvpJ+fU7ggTbcOBxbqdJS9ZsJ40RRd/05soWrIFPptKu8C
	 NpJ8HZMJ1CmvA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 23 Jul 2025 17:03:12 +0200
Message-Id: <DBJIY7IKSNVH.1Q2QD6X30GIRC@kernel.org>
Subject: Re: [PATCH v7 3/6] rust: irq: add support for non-threaded IRQs and
 handlers
Cc: "Boqun Feng" <boqun.feng@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Alex Gaynor" <alex.gaynor@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>, "Bjorn Helgaas"
 <bhelgaas@google.com>, =?utf-8?q?Krzysztof_Wilczy=C2=B4nski?=
 <kwilczynski@kernel.org>, "Benno Lossin" <lossin@kernel.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
To: "Daniel Almeida" <daniel.almeida@collabora.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250715-topics-tyr-request_irq2-v7-0-d469c0f37c07@collabora.com> <20250715-topics-tyr-request_irq2-v7-3-d469c0f37c07@collabora.com> <aIBl6JPh4MQq-0gu@tardis-2.local> <ED19060D-265A-4DEF-A12B-3F5901BBF4F3@collabora.com> <aIDxFoQV_fRLjt3h@tardis-2.local> <7fa90026-d2ac-4d39-bbd8-4e6c9c935b34@kernel.org> <8742EFD5-1949-4900-ACC6-00B69C23233C@collabora.com>
In-Reply-To: <8742EFD5-1949-4900-ACC6-00B69C23233C@collabora.com>

On Wed Jul 23, 2025 at 4:56 PM CEST, Daniel Almeida wrote:
>> On 23 Jul 2025, at 11:35, Danilo Krummrich <dakr@kernel.org> wrote:
>> On 7/23/25 4:26 PM, Boqun Feng wrote:
>>> On Wed, Jul 23, 2025 at 10:55:20AM -0300, Daniel Almeida wrote:
>>> But sure, this and the handler pinned initializer thing is not a blocke=
r
>>> issue. However, I would like to see them resolved as soon as possible
>>> once merged.
>>=20
>> I think it would be trivial to make the T an impl PinInit<T, E> and use =
a
>> completion as example instead of an atomic. So, we should do it right aw=
ay.
>>=20
>> - Danilo
>
>
> I agree that this is a trivial change to make. My point here is not to po=
stpone
> the work; I am actually somewhat against switching to completions, as per=
 the
> reasoning I provided in my latest reply to Boqun. My plan is to switch di=
rectly
> to whatever will substitute AtomicU32.

I mean, Boqun has a point. AFAIK, the Rust atomics are UB in the kernel.

So, this is a bit as if we would use spin_lock() instead of spin_lock_irq()=
,
it's just not correct. Hence, we may not want to showcase it until it's act=
ually
resolved.

The plain truth is, currently there's no synchronization primitive for gett=
ing
interior mutability in interrupts.

You can use a normal spinlock or mutex in the threaded handler though.

And in the hard IRQ you can use a completion to indicate something has
completed.

Once we have proper atomics and spin_lock_irq() we can still change it.

> The switch to impl PinInit is fine.

