Return-Path: <linux-pci+bounces-38736-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35595BF0E55
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 13:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A5B41895E01
	for <lists+linux-pci@lfdr.de>; Mon, 20 Oct 2025 11:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E04F2F657A;
	Mon, 20 Oct 2025 11:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5Mwn2+W"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325AD2C21F7;
	Mon, 20 Oct 2025 11:43:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760960601; cv=none; b=pWuSb+yAYP12TYHegv3I9MxQl30fsltpo2ZKhWQOqTuIgLUsOUu11E+V+PFzn/ulmWGjQjagTHDxw/E8XkoVbzfBtGYmOYYOg/B4CJlKev4L8Ay1+NSeEw8c9/hVZIwh6OeXUbkhwUxXyB3iMzmqPy405wGUKQJGF3vIxx3iQGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760960601; c=relaxed/simple;
	bh=B69GDjU7rcIN6aWKrOCldO5I8FMquM4tO9WqlxbscYQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=oZXFwujXi3C7L3QLV8PujTWTBn/70aqZjmW6niPrMXf5cUvw4m5/fP472MCTgEx0RZ2cHoHN8mywz2Dc4hRf6Ymb8SOTgtS4MGdmnadYNnJP8q+seYDI3qrm4eZdPQ1waFVRHC3y4/7ep+Htjzr125JQu+cc0ofIf5r/hZyJ2VE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5Mwn2+W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5F2C4CEF9;
	Mon, 20 Oct 2025 11:43:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760960600;
	bh=B69GDjU7rcIN6aWKrOCldO5I8FMquM4tO9WqlxbscYQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=B5Mwn2+WokAdLapBqYFNpXn/UrcEksJVpETcyUsBHAWihpPmEeehcnqgxA2t1grFy
	 UZ/HoFLloYhWah1yiky+C3cNhmKXu1aao5zapBFrrmkM122ZMT2U9pU4tak398lOtt
	 7V0lWafqj4yzvhdoXYfRAsOgd6SICIHEZAPjOkWiudhy4dVmmc7jXSRws8ZaEG2U7A
	 3HE+VB+cdJJ+KLvuz1/SsNi5gxPX6ROS9o4FJ7SyXf6lG8jmI3fqNKAu4YeC5dU2Ep
	 YSyuMAwc7a99jVCCcn/EtltyE7AEoD5L3EQrjHFEJrIadgzd1j0nj59BGz3bPpTtPM
	 ZVcGZ+d9ZtBbg==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 20 Oct 2025 13:43:16 +0200
Message-Id: <DDN4FLSD09W9.30I0BJXFAU5YB@kernel.org>
Subject: Re: [PATCH 0/2] rust: pci: consistently use INTx and PCI BAR in
 comments
Cc: "Miguel Ojeda" <ojeda@kernel.org>, "Alex Gaynor"
 <alex.gaynor@gmail.com>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <linux-pci@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Peter Colberg" <pcolberg@redhat.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20251019045620.2080-1-pcolberg@redhat.com>
In-Reply-To: <20251019045620.2080-1-pcolberg@redhat.com>

Hi Peter,

On Sun Oct 19, 2025 at 6:56 AM CEST, Peter Colberg wrote:
> This patch series normalises the comments of the Rust PCI abstractions
> to consistently refer to legacy as INTx interrupts and use the spelling
> PCI BAR, as a way to familiarise myself with the Rust for Linux project.

That's great to hear! :)

Can you please rebase the two patches on driver-core-testing [1]?

[1] https://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core=
.git/log/?h=3Ddriver-core-testing

