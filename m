Return-Path: <linux-pci+bounces-34451-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 230DDB2F5AB
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 12:52:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 884251CC5E8B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Aug 2025 10:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEC733090C1;
	Thu, 21 Aug 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IB04F8o0"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5882308F11;
	Thu, 21 Aug 2025 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755773492; cv=none; b=pxlEQSvnScYX4PmS1DsUPCO37FLGOVFY8We6dwGjL0TtScPBc/890+RtrPmh0wSaJ/mCMBZN1iDZFbvOXhscs60oisNcIMJ2LOVimJfVQ1o7MHe/hPvAOWOqRIifI+CwmCrWw/s94gR30Y36nhg5loivS4M9IJ/nKP3i0vjC89E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755773492; c=relaxed/simple;
	bh=cMytUFE1fmlfUaGX9cWvvFMAHcz0yzHNBDICGtrf7sk=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=PpA5ZONW2jL18+xXW7JPqhxSz4WFXcmxmbx37zBD/xcBu+gWhHpk0hHaZBL8wIaYos/ExlTY0RKo8blnRyG6wuxtCb1geuDbq2AKyyKswOVjVFXmF10rp6qLzm8o2BH+1Ryv0q6T5IbglbDDAk+f2ZtF+5xBp14ODDP0sevTzFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IB04F8o0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D22FC4CEEB;
	Thu, 21 Aug 2025 10:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755773492;
	bh=cMytUFE1fmlfUaGX9cWvvFMAHcz0yzHNBDICGtrf7sk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:From;
	b=IB04F8o0JStewSEpV2ymvEO/zxxGwgvH1bK6Jr2UUPMiahi7qVV2NkjTaCjC00iZ8
	 BBv36c6YLtgB7Dl5ddxh3qtB0JFm6HgEoUG78aRRQBArXGRHlUeFJ7V4dB28g/tNaO
	 1RkdVuZSm6ueWKFtwQAZ1s4JKLRHKOv+Tz4P6B0FsR0YMycztEt2sDxfITlSvhYjdi
	 4Q1zdq6f3oz9kqvLBfDD4gEidTRkppcS8ClTsTQX+n80DKy8I/WXLW1UUn3HC+REU8
	 d5vKL5tMXNFT4vtyCuWzJ+2lyDJDiuGGwYdk+dLjbAwiL98bFT3qfLjmo/rHNFVv/i
	 iS7H8QZ8pfwAA==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 21 Aug 2025 12:51:26 +0200
Message-Id: <DC81R8RHTHTC.3J58ODZD3UQLQ@kernel.org>
Subject: Re: [PATCH v5 1/4] rust: pci: provide access to PCI Class and
 Class-related items
Cc: "Alexandre Courbot" <acourbot@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Bjorn Helgaas" <bhelgaas@google.com>,
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, "Miguel
 Ojeda" <ojeda@kernel.org>, "Alex Gaynor" <alex.gaynor@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>,
 <nouveau@lists.freedesktop.org>, <linux-pci@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "LKML" <linux-kernel@vger.kernel.org>,
 "Elle Rhumsaa" <elle@weathered-steel.dev>
To: "John Hubbard" <jhubbard@nvidia.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20250821044207.3732-1-jhubbard@nvidia.com>
 <20250821044207.3732-2-jhubbard@nvidia.com>
In-Reply-To: <20250821044207.3732-2-jhubbard@nvidia.com>

On Thu Aug 21, 2025 at 6:42 AM CEST, John Hubbard wrote:
> Allow callers to write Class::STORAGE_SCSI instead of
> bindings::PCI_CLASS_STORAGE_SCSI, for example.
>
> New APIs:
>     Class::STORAGE_SCSI, Class::NETWORK_ETHERNET, etc.
>     Class::as_raw()
>     Class: From<u32> for Class
>     ClassMask: Full, ClassSubclass
>     Device::pci_class()
>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Alexandre Courbot <acourbot@nvidia.com>
> Cc: Elle Rhumsaa <elle@weathered-steel.dev>
> Signed-off-by: John Hubbard <jhubbard@nvidia.com>
> ---
>  rust/kernel/pci.rs    |  10 ++
>  rust/kernel/pci/id.rs | 239 ++++++++++++++++++++++++++++++++++++++++++

Please add rust/kernel/pci/ to the maintainers entry.

(Would have done on apply, but I have another comment on patch 3.)

>  2 files changed, 249 insertions(+)
>  create mode 100644 rust/kernel/pci/id.rs

