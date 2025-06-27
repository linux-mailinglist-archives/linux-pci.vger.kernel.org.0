Return-Path: <linux-pci+bounces-30970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 90B1CAEC07E
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 21:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9427D3BE2D5
	for <lists+linux-pci@lfdr.de>; Fri, 27 Jun 2025 19:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2987E2E8DE9;
	Fri, 27 Jun 2025 19:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNdX04SC"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF18F212D97;
	Fri, 27 Jun 2025 19:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751054362; cv=none; b=Ahx7ccoGknFsTO1bTYeDSG2NZGE0EeBFCiQvZJ8iQTFb5t9ZZVqpjaRfD6FUZoaqOXVlyiyCUbgOMTXE9lFMKAFEbmprXAEeG5gHZzvij4kf7vtjWXdlcRYvSzRhRIfLEfiLgGTW9x0pBYou5C6RdpXA8THxraArIuzS7PeSZ3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751054362; c=relaxed/simple;
	bh=FxCyO5AUIucb+mVJoILJ0mKThytxO5/jSMZ6GOpF2B0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=SMoCFOlsT8QPAOrJpbrs0L9yXluY1CnIUDhAjjQn64Xpir2JL2ebL/gWwbf3xTD/9U+DtLKSqYICtvQuu59qNuxV39oWfMFAMe/csh4oAQKPo4kiEYMZ9V4gzkVKuO61jk2vEr4TPCvIhOIKFTjAFTdKzEfFUiYDtJqtLjEynUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNdX04SC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8075C4CEE3;
	Fri, 27 Jun 2025 19:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751054361;
	bh=FxCyO5AUIucb+mVJoILJ0mKThytxO5/jSMZ6GOpF2B0=;
	h=Date:To:Cc:Subject:From:References:In-Reply-To:From;
	b=VNdX04SC6YCuEldsxezVQLGuSgcUiOD+kH+dnNiqydVt5ERJbYrvGjy2FRCfHshmw
	 Xs2Qv0xDqqtCjqYYFBl9JWzOXnHeOiWVYGT2xqnLLueDU6y/LlqMFGjaopfQCB+Yqm
	 bqc8TVR+KEs9I1RP0axg2VaDmmbBvMXMALTTn2Ly0wTUGhdNZOCF6Y7IVp8XlDuahF
	 2by3IM1C8I+njjz3hwUbXurHHMcDJFTtso9rqYgaV3xn0BsUn5QzZiz1YEiBUTnybC
	 x9DM2hDg7yFRzAyzu6Tk8fVJQsa2RMbKbQO9QPSl5h0jv2o7cG29u0Qtnrjcf0e2v/
	 NCJKv30GeBb8A==
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Jun 2025 21:59:14 +0200
Message-Id: <DAXKYPCR5D4I.1B44OH77BGRTQ@kernel.org>
To: "Danilo Krummrich" <dakr@kernel.org>, <gregkh@linuxfoundation.org>,
 <rafael@kernel.org>, <ojeda@kernel.org>, <alex.gaynor@gmail.com>,
 <boqun.feng@gmail.com>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <a.hindborg@kernel.org>, <aliceryhl@google.com>, <tmgross@umich.edu>,
 <david.m.ertman@intel.com>, <ira.weiny@intel.com>, <leon@kernel.org>,
 <kwilczynski@kernel.org>, <bhelgaas@google.com>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v4 3/5] rust: devres: get rid of Devres' inner Arc
From: "Benno Lossin" <lossin@kernel.org>
X-Mailer: aerc 0.20.1
References: <20250626200054.243480-1-dakr@kernel.org>
 <20250626200054.243480-4-dakr@kernel.org>
In-Reply-To: <20250626200054.243480-4-dakr@kernel.org>

On Thu Jun 26, 2025 at 10:00 PM CEST, Danilo Krummrich wrote:
> So far Devres uses an inner memory allocation and reference count, i.e.
> an inner Arc, in order to ensure that the devres callback can't run into
> a use-after-free in case where the Devres object is dropped while the
> devres callback runs concurrently.
>
> Instead, use a completion in order to avoid a potential UAF: In
> Devres::drop(), if we detect that we can't remove the devres action
> anymore, we wait for the completion that is completed from the devres
> callback. If, in turn, we were able to successfully remove the devres
> action, we can just go ahead.
>
> This, again, allows us to get rid of the internal Arc, and instead let
> Devres consume an `impl PinInit<T, E>` in order to return an
> `impl PinInit<Devres<T>, E>`, which enables us to get away with less
> memory allocations.
>
> Additionally, having the resulting explicit synchronization in
> Devres::drop() prevents potential subtle undesired side effects of the
> devres callback dropping the final Arc reference asynchronously within
> the devres callback.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

With the invariants section moved:

Reviewed-by: Benno Lossin <lossin@kernel.org>

---
Cheers,
Benno

> ---
>  drivers/gpu/nova-core/driver.rs |   7 +-
>  drivers/gpu/nova-core/gpu.rs    |   6 +-
>  rust/kernel/devres.rs           | 213 +++++++++++++++++++-------------
>  rust/kernel/pci.rs              |  20 +--
>  samples/rust/rust_driver_pci.rs |  19 +--
>  5 files changed, 154 insertions(+), 111 deletions(-)

