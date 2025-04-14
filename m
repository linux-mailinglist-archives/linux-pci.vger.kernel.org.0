Return-Path: <linux-pci+bounces-25810-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55C7AA87DBE
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 12:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB75D3AEED9
	for <lists+linux-pci@lfdr.de>; Mon, 14 Apr 2025 10:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 545F1267F7F;
	Mon, 14 Apr 2025 10:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=proton.me header.i=@proton.me header.b="ek6qKmTj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5B625F96A
	for <linux-pci@vger.kernel.org>; Mon, 14 Apr 2025 10:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744626803; cv=none; b=k/WZLKSQH8ie+cRYuOyUADOQLVeoj/9soqP0Rjbf7mOdT0p3P0FcZUZj2Xo1DYQ+1MxFr6Vh/61aG4carQAhpOTn9cEIGemTcNiDDIdTWW0HHTbt83HoxpEZZvvGn6FHRP6sStf3SgkEYos+B77+tU7IYeAV3hQKyXzH3fjr4qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744626803; c=relaxed/simple;
	bh=MvETamnQNFquSrVGNuckzIaSyUm/Z0fG2Yw6wm5zVMc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YKXqp4q71Yyc5s7cNgSoIDUnarNkjonY4sYiR8T1Odx7pTncset9FbdzdeUrHgkZIUh+4OqZS+RnLKRxfVIiijjjYGESjJcu12+DzIyhLjXQkONfb7ZchOamAdY/Ud1Y4xy6hg1hKeroJt2GTuLfH61LqnS1jyfWOpJK/3t2deE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=ek6qKmTj; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1744626799; x=1744885999;
	bh=1/FUQUEwg0hppn1C7WXQsrRcHjWtqFn3jfxC8tHOJ8U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=ek6qKmTjXoobF+9qjTcuYBZYJsm9RAzE6c9OEKrVDfzbEmaDCx9IabEfPaJBEl1f5
	 p/5+xCLuqNeLU0S4XaHh3DkxcOIA1GRp24goct7J+vZjkZUtAo93mSYxWMry7BF29c
	 Uicui3mrVHh3Y1DLkFt/Y/yh7YjQgs/5aaxUkaBTeXueux4FYej5DJKQZBCTHZqqf9
	 hLRbFN6h/p4D43mlxMk5UCaq8xYIYPH04xu35b9g9FJR7fT23tHq2RBB7DFOtkSunB
	 ez2UYp/SeQTOVZmsxjgpE0cG/nluJZNu+UcgYUIR37rkb50B830LczCQaOk2xhxhi0
	 XKgwMj2fnU0CA==
Date: Mon, 14 Apr 2025 10:33:16 +0000
To: Danilo Krummrich <dakr@kernel.org>, bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org, rafael@kernel.org, abdiel.janulgue@gmail.com
From: Benno Lossin <benno.lossin@proton.me>
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com, a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, daniel.almeida@collabora.com, robin.murphy@arm.com, linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 5/9] rust: pci: preserve device context in AsRef
Message-ID: <D96AKZ50JTGD.3829T3YHKYOI2@proton.me>
In-Reply-To: <20250413173758.12068-6-dakr@kernel.org>
References: <20250413173758.12068-1-dakr@kernel.org> <20250413173758.12068-6-dakr@kernel.org>
Feedback-ID: 71780778:user:proton
X-Pm-Message-ID: 43ad78aa5c66966d5540a68db2b86a533a9ea7c3
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Sun Apr 13, 2025 at 7:37 PM CEST, Danilo Krummrich wrote:
> Since device::Device has a generic over its context, preserve this
> device context in AsRef.
>
> For instance, when calling pci::Device<Core> the new AsRef implementation
> returns device::Device<Core>.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

Reviewed-by: Benno Lossin <benno.lossin@proton.me>

---
Cheers,
Benno

> ---
>  rust/kernel/pci.rs | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)


