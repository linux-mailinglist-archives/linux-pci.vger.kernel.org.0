Return-Path: <linux-pci+bounces-34180-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6742B29C0D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 10:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB73F1961E8E
	for <lists+linux-pci@lfdr.de>; Mon, 18 Aug 2025 08:24:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C75304BAA;
	Mon, 18 Aug 2025 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZbggAU+P"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0529E0FD;
	Mon, 18 Aug 2025 08:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755505412; cv=none; b=AShRPaTLF/8uD3f6apHAmOFV4l9ZTU9O7Fb1wWIu4NSbEI03JVGS4kgVysUivV8kg95A1oulBd75VIv45waW93hEQq4BdSx9XYeNNyVzQmj1yEKxNrJXRbH7DZPe9an4JIrQ3bhSFQ9CwuzIARqxIK/xHWCyzJovBipaOISboe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755505412; c=relaxed/simple;
	bh=u6GAt90hanys0b3MiNsesXpPjjtcQ0gIDwbSkJKsM8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BNSv/TFTDQ2xdeIo0v7GTE1LTCkkyf2PKXI76HAtDgsjo2F96W3AxqFoe43HoRJGcEz2x/DAwhRuLx7NVugP6obL93g3JXOCE9SjtK6xVN7Mh7xvFegYUQ1D1M7nZU0nV1dZe8kcYGc9ASL4ZzMu7JY1N5GbBXNmUsAu8nnFrGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZbggAU+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 645A9C4CEEB;
	Mon, 18 Aug 2025 08:23:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755505412;
	bh=u6GAt90hanys0b3MiNsesXpPjjtcQ0gIDwbSkJKsM8k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=ZbggAU+PfOD+nSVZG25ad8arPO/fiQPki1nRSkHPJMPVdL/bk530TJRl7QmJb8M0m
	 p7MMyNq0eo8VWbN1Xmkf2+ksBvZmguNIeefGg5fa76Td2uBldwYXKnk9dLfk0oOGNf
	 W3Ju2DwOMvZle2sQPrH55d8glA6RyJoZ6B0DNtRLTJO6b8S79QYZq+dyVjXAAPEvnc
	 DzWaLcwlRms+VLYjwU0qqdBsrdCqa50RkHKcatRc0scNk2je7HKgKG8oICZaYDbRQj
	 e4lfmFzZpbHQf2MFMm6DEYNWoNHLierduucl7A/5/Hrls6ESpbHdOFjarXTS/pr92i
	 ONnfjPpPBHc6w==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
 =?utf-8?Q?Bj=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Alice Ryhl <aliceryhl@google.com>,
 Trevor Gross <tmgross@umich.edu>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Bjorn
 Helgaas <bhelgaas@google.com>, Krzysztof =?utf-8?Q?Wilczy=C5=84ski?=
 <kwilczynski@kernel.org>, Benno Lossin <lossin@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 linux-pci@vger.kernel.org, Joel Fernandes <joelagnelf@nvidia.com>, Dirk
 Behme <dirk.behme@de.bosch.com>
Subject: Re: [PATCH v9 0/7] rust: add support for request_irq
In-Reply-To: <DC0OOFT2RTO7.2PCAP981HCCN3@kernel.org>
References: <20250811-topics-tyr-request_irq2-v9-0-0485dcd9bcbf@collabora.com>
 <bL5l0lXohHy-SbvhHpQTRfWPqfZWJg3DiOfkBU7ehVCq3rC6yzFvYQN6d9rSU_ELZr8zh-lKNKPEeUfbgeu2Mw==@protonmail.internalid>
 <DC0OOFT2RTO7.2PCAP981HCCN3@kernel.org>
Date: Mon, 18 Aug 2025 10:23:21 +0200
Message-ID: <87tt25ca2u.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Danilo Krummrich" <dakr@kernel.org> writes:

> On Mon Aug 11, 2025 at 6:03 PM CEST, Daniel Almeida wrote:
>
> Applied to driver-core-testing, thanks!
>
>> Alice Ryhl (1):
>>       rust: irq: add &Device<Bound> argument to irq callbacks
>>
>> Daniel Almeida (6):
>>       rust: irq: add irq module
>>       rust: irq: add flags module
>
>     [ Use expect(dead_code) for into_inner(), fix broken intra-doc link and
>       typo. - Danilo ]
>
>>       rust: irq: add support for non-threaded IRQs and handlers
>
>     [ Remove expect(dead_code) from Flags::into_inner(), add
>       expect(dead_code) to IrqRequest::new(), fix intra-doc links. - Danilo ]
>
>>       rust: irq: add support for threaded IRQs and handlers
>
>     [ Add now available intra-doc links back in. - Danilo ]
>
>>       rust: platform: add irq accessors
>
>     [ Remove expect(dead_code) from IrqRequest::new(), re-format macros and
>       macro invocations to not exceed 100 characters line length. - Danilo ]
>
>>       rust: pci: add irq accessors

I somehow missed that you already applied this, so I just sent comments
for patch 3. I think there are some issues. If you want my comments for
the rest of the series, let me know. Otherwise I'll just skip that.


Best regards,
Andreas Hindborg



