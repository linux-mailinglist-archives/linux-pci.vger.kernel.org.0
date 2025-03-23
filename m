Return-Path: <linux-pci+bounces-24450-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBA8A6CECB
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 11:34:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19C7C16D5A0
	for <lists+linux-pci@lfdr.de>; Sun, 23 Mar 2025 10:34:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5108B2045A2;
	Sun, 23 Mar 2025 10:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="h3DNwPro"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-24418.protonmail.ch (mail-24418.protonmail.ch [109.224.244.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60ECD1FFC40;
	Sun, 23 Mar 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742726086; cv=none; b=YbnkcnhFDnHuPjgSSNHIJCFHJuRT6ylbW+FEhmbK317VPVzpeicxwz9vvzb0nn/dJw6aQ7H7A24ddSoFDNDpaDtdl3dUuDlsA7FtcRwXqLsYeUP1y+edR0TM7a5PJPU/vvDgthT9ZonbQD966YYBZlB45fjwWFCmUInSJxB2Ndc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742726086; c=relaxed/simple;
	bh=AOoQJSZoCfVh/DMcYIEGlzKQ8ilZUJmiQ6wgcZl3BPM=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Q+glsVjt0GT/jgS1H0Zo9Xp7Vz/1GBI4BkerSJYYOoXmCFH/UR2os7ElsoYVPHbR2uE2MlQfx+2juRpz6rTY1JdZQ3MalmzN8UktKpDg1S9TBxano6oyohimU0U6RAC+gdPX8hQMxzuLSuei7ZXvwPlVtgKtR19lPU3rk3B3Frs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=h3DNwPro; arc=none smtp.client-ip=109.224.244.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1742726080; x=1742985280;
	bh=6eVI5KoGshdxXUZl16evHFInS0PBerXPeQd71UB8Z18=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=h3DNwProrzioMNzGi6D+jOZL9O+rmQ20LWnucEBM5Vh85nnGuTJrnh1UPjBeexzt2
	 6iJM8mpSuWvXMV4tfajjP44gSSShUMGPo6q8qs1iZWKnEnmR75dPXT73I1tuTUdRTp
	 c+AFUdfK0Jw0GdjFlTlZRGvyqvD0I8bMCxvXZ778LiQ76p8WeU7wum+ZrcrN/cneL4
	 ScxCCaiVXWcJ1crF/dJt87shUozwC1sVDeRMsXqeBNXb3kRYrSRZlyTYA0sH8N4nIy
	 mxcYSSuXox0yFBFYNy9fWtXWeT2s/uIA1WzmHLDvQxykWRJWDhNBvbImi1LwQ3x33B
	 LrOvloTc56fCQ==
Date: Sun, 23 Mar 2025 10:34:34 +0000
To: Antonio Hickey <contact@antoniohickey.com>, Bjorn Helgaas <bhelgaas@google.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 07/17] rust: pci: refactor to use `&raw [const|mut]`
Message-ID: <D8NKTZUCG413.1TYKB5UPDAA4E@proton.me>
In-Reply-To: <20250320020740.1631171-8-contact@antoniohickey.com>
References: <20250320020740.1631171-1-contact@antoniohickey.com> <20250320020740.1631171-8-contact@antoniohickey.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a774bdd3374969cf2b4725de92f0f608a126fa23
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu Mar 20, 2025 at 3:07 AM CET, Antonio Hickey wrote:
> Replacing all occurrences of `addr_of_mut!(place)`
> with `&raw mut place`.

Again.

> This will allow us to reduce macro complexity, and improve consistency
> with existing reference syntax as `&raw mut` is similar to `&mut`
> making it fit more naturally with other existing code.
>
> Suggested-by: Benno Lossin <benno.lossin@proton.me>
> Link: https://github.com/Rust-for-Linux/linux/issues/1148
> Signed-off-by: Antonio Hickey <contact@antoniohickey.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/pci.rs | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)


