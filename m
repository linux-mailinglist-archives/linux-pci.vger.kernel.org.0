Return-Path: <linux-pci+bounces-30872-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B8CAEAA82
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 01:22:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C241A4E1B8B
	for <lists+linux-pci@lfdr.de>; Thu, 26 Jun 2025 23:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB03B21FF47;
	Thu, 26 Jun 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z6hNP3Yf"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDBC1DED7B;
	Thu, 26 Jun 2025 23:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750980170; cv=none; b=eS3nWcNNSIRu2onAkfpF1YUj1+lJ6oTLzrfGfspEXSOzfY7mB2XRAs0/BLFI7V36klbDt1r2cyoOVzTNk2k6j/Asxrdb/qtFBJKJWJ8y32MPLSaLXBzpfstXchipVe28EmjFEIFZREgB1OFlAIUGgZ0bIbXJOsE7oqmNNbU7Bbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750980170; c=relaxed/simple;
	bh=HCpZZ2kIgwrcphOaysvAn9jGJPKkVlzJsoz19ZBQ4FI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=m4QzMLHNzF1MSkKnAXfN4sa4unNEkvrAfCeNpjoHeGwga7bjVPi8sJdQ3I5atU+groNSBJpSZiubb51YHcSzug9+jIuIvzMFixKlKJyHNJaIqIWZ/ZbkfcraFLFJZfA+QRCN7FWNeXECn6VRoqeJhryUa4bM+/Heueqa3IjQ/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z6hNP3Yf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3BBEC4CEEB;
	Thu, 26 Jun 2025 23:22:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750980170;
	bh=HCpZZ2kIgwrcphOaysvAn9jGJPKkVlzJsoz19ZBQ4FI=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:From;
	b=Z6hNP3YfoTR8AkAh2bzoDcPYK+4oZ3WCUFQAsMhpqA8GlzxH0fiy3Yb7aGLzxfa7H
	 V36wG5MMAEKAoPQtHYLCW/B9Y5a9I6LoNUxNMCY1RaNtT4Qd9fiYRhYnOwNcRlW8KR
	 DyPDYaCYX04Vb7z6Ewa5++/fA2YNZ92PjGjZhZ0gFQX2lTDDpOKbs7VsoKPL3mpufP
	 hJrqHQVYGGXqRfcj7qlb1bvy1bL6CX0CmHdkBqEW7Ebzk7V9ITu7rKvUmWWepcS3Yc
	 G7XI9F9jJ0+RB9qToOqI9aVKAZFHu5QYWGvxVfDI8mO9kuq7mkc5Z1h2w+jGZT1j6i
	 tARpnaWBqQ2Uw==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 01:22:45 +0200
Message-Id: <DAWUNZ33A0DJ.1RCZSO3S0Q1JB@kernel.org>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 4/5] rust: types: ForeignOwnable: Add type Target
From: "Benno Lossin" <lossin@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>
X-Mailer: aerc 0.20.1
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-5-dakr@kernel.org>
In-Reply-To: <20250626200054.243480-5-dakr@kernel.org>

On Thu Jun 26, 2025 at 10:00 PM CEST, Danilo Krummrich wrote:
> ForeignOwnable::Target defines the payload data of a ForeignOwnable. For
> Arc<T> for instance, ForeignOwnable::Target would just be T.
>
> This is useful for cases where a trait bound is required on the target
> type of the ForeignOwnable. For instance:
>
> 	fn example<P>(data: P)
> 	   where
> 	      P: ForeignOwnable,
> 	      P::Target: MyTrait,
> 	{}
>
> Suggested-by: Benno Lossin <lossin@kernel.org>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <lossin@kernel.org>

We might also be able to add a `Deref<Target =3D Self::Target>` bound on
`Borrowed` and `BorrowedMut`, but we should only do that when necessary.

---
Cheers,
Benno

> ---
>  rust/kernel/alloc/kbox.rs | 2 ++
>  rust/kernel/sync/arc.rs   | 1 +
>  rust/kernel/types.rs      | 4 ++++
>  3 files changed, 7 insertions(+)

