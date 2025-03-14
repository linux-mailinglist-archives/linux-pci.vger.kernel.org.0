Return-Path: <linux-pci+bounces-23776-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9819A61A4A
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 20:22:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0075B3A4662
	for <lists+linux-pci@lfdr.de>; Fri, 14 Mar 2025 19:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3287D204C0F;
	Fri, 14 Mar 2025 19:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="nHOTwdJm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-40131.protonmail.ch (mail-40131.protonmail.ch [185.70.40.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803BA204C09;
	Fri, 14 Mar 2025 19:22:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.40.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741980141; cv=none; b=qhxiVoY46G9MWJTmlKaaBPb6oc+FSG3+4lqjKP4vFkaB6BeCS4Ij5uz5B8DGAtGBXXKdmlUneI/rBf4KE6aVuHU5hUH0yynDClLQdJEjJKUqVXI4TjzHoyGVT0pcQJgZ8AS7yq2usW/ZMSKTtanKB+tmm6D1WEmD26u1Dc9INJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741980141; c=relaxed/simple;
	bh=5wStfRse0ijF6zcJLGwhrVt53N+8xSvK12PqiJP104I=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W7iSydCqMfi7drZLZJ3VCJJdB/mU1Z7nBG6cgK2T9cRtka4dJw/14kXnuuuRmf9juyKzjwNnsIqYq+miBVElsICI1VjgrWgmYyCtFFinl54KVCUDb1wX3P462a/gmLBS0w49K3VWHLTm8PVd6eF/FekEY2/YaFAeJ+tnyVd95T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=nHOTwdJm; arc=none smtp.client-ip=185.70.40.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1741980137; x=1742239337;
	bh=thJECz48gUXx5fCuiQ2QxMOjva1RYIRgnYdCOp04aPY=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=nHOTwdJmcWno63mC9jXXayErfsOlb4jB/UTVTv2YFHjVL7+vS4gpYe2ZyPyZrVRnM
	 XnASK1Wpj3hr8Sjn/DFCl27B/vXILM94ttXwyaJSyhfRYtogn3TCVMJVHvx8iWFGzN
	 L6qUvw2bIjnWduyVJSzVs1cSM6dR3DofPS0h1VUA4yorSxN3K3mvU0kierHrXIWU1w
	 9HO1c7PzupM2+KrT6mZOAl3F6C+r5ASTdz2Ksx5ERfGLXD2BWff9+OamPIz2oON7x8
	 pOh8VmFOg9Y+2lCGcGOB+pWU+CkyHHeR7roTqxBXx9diUlv82TXvPBIh7YewNdYkn1
	 uD+IuNiAtkWVA==
Date: Fri, 14 Mar 2025 19:22:09 +0000
To: Tamir Duberstein <tamird@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Bjorn Helgaas <bhelgaas@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>
From: Benno Lossin <benno.lossin@proton.me>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH 1/2] rust: retain pointer mut-ness in `container_of!`
Message-ID: <D8G8F0X59XBY.1ZCW3BOLXCYP5@proton.me>
In-Reply-To: <20250307-no-offset-v1-1-0c728f63b69c@gmail.com>
References: <20250307-no-offset-v1-0-0c728f63b69c@gmail.com> <20250307-no-offset-v1-1-0c728f63b69c@gmail.com>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: a5798fbb667a529e08d919bf50c046bee6c0afa8
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Mar 7, 2025 at 10:58 PM CET, Tamir Duberstein wrote:
> Avoid casting the input pointer to `*const _`, allowing the output
> pointer to be `*mut` if the input is `*mut`. This allows a number of
> `*const` to `*mut` conversions to be removed at the cost of slightly
> worse ergonomics when the macro is used with a reference rather than a
> pointer; the only example of this was in the macro's own doctest.
>
> Signed-off-by: Tamir Duberstein <tamird@gmail.com>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/lib.rs      |  5 ++---
>  rust/kernel/pci.rs      |  2 +-
>  rust/kernel/platform.rs |  2 +-
>  rust/kernel/rbtree.rs   | 23 ++++++++++-------------
>  4 files changed, 14 insertions(+), 18 deletions(-)


