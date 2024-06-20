Return-Path: <linux-pci+bounces-9021-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F40DC91086F
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 16:33:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFE8128318D
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2024 14:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EE961AD9E6;
	Thu, 20 Jun 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BUMk0Mla"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C977626AE8;
	Thu, 20 Jun 2024 14:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718893895; cv=none; b=SYcbeQGq4jvMrUD9GQn/7D47+5ru7/YCnvuO/Ty1P9WTw+EJatBsSO3nDLo0roQAIOPqHIeQs6VlsY+MIbrh47XZMCugj4chXvUilg8MwhOQTMfZNDWsXvD1LRSs9UXd2iE/X/x+fXzSeUVYT4vCZ2f8X/pUVsDBcfEu1VwbIEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718893895; c=relaxed/simple;
	bh=twOrqBFFqDvTjWbRrwIUvXugDfBRMo2UYCoRXgolWI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NqL6BbTPzsPD9v49SBOlyGzBpRx7OdKSwT2zLl6shbajln2xOEIR/cIGMVYM0Kn1XmiHO24whyps8WXNqQ3TBE8o8mItcsCU6PqVb6d4zg+1k3d09Ztj5F8pDcmnLaaBn2q03E1NhMKsjC7svBDYhqU9kBubqhJpZnoDjLs2SNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BUMk0Mla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7307C2BD10;
	Thu, 20 Jun 2024 14:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718893895;
	bh=twOrqBFFqDvTjWbRrwIUvXugDfBRMo2UYCoRXgolWI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BUMk0Mlawif2Lh2C1AebggyiEXjcm3wOz6JLwY49Dc61L/oBnYnpETH0cXKssDnBY
	 oFfvs3fqcpIM3S24NG+DpFGuc6CKMZ8bDF2BFLrQiMDBjG+JNbeLsHY/L0nHuVOMXH
	 nJvMCelrN+kJxCDWRbtfbmtM3EJBfXmTonUlvy3M=
Date: Thu, 20 Jun 2024 16:31:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com, robh@kernel.org,
	daniel.almeida@collabora.com, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 03/10] rust: implement `IdArray`, `IdTable` and
 `RawDeviceId`
Message-ID: <2024062031-untracked-opt-3ff1@gregkh>
References: <20240618234025.15036-1-dakr@redhat.com>
 <20240618234025.15036-4-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240618234025.15036-4-dakr@redhat.com>

On Wed, Jun 19, 2024 at 01:39:49AM +0200, Danilo Krummrich wrote:
> From: Wedson Almeida Filho <wedsonaf@gmail.com>
> 
> Most subsystems use some kind of ID to match devices and drivers. Hence,
> we have to provide Rust drivers an abstraction to register an ID table
> for the driver to match.

Let's not.

For now, let's stick with the C arrays please.  That way it's simple,
makes it easy to understand, and you can put the array in a .c file and
access it that way.  That way also all of our existing infrastructure
will work properly (I don't know how you deal with the modinfo sections
here...)


> 
> Generally, those IDs are subsystem specific and hence need to be
> implemented by the corresponding subsystem. However, the `IdArray`,
> `IdTable` and `RawDeviceId` types provide a generalized implementation
> that makes the life of subsystems easier to do so.
> 
> Co-developed-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Asahi Lina <lina@asahilina.net>
> Signed-off-by: Wedson Almeida Filho <wedsonaf@gmail.com>
> Co-developed-by: Danilo Krummrich <dakr@redhat.com>
> Signed-off-by: Danilo Krummrich <dakr@redhat.com>
> ---
>  rust/kernel/device_id.rs | 336 +++++++++++++++++++++++++++++++++++++++
>  rust/kernel/lib.rs       |   2 +
>  2 files changed, 338 insertions(+)
>  create mode 100644 rust/kernel/device_id.rs
> 
> diff --git a/rust/kernel/device_id.rs b/rust/kernel/device_id.rs
> new file mode 100644
> index 000000000000..c490300f29bb
> --- /dev/null
> +++ b/rust/kernel/device_id.rs

While I see the temptation to attempt to create a generic class for ids,
this is all VERY bus specific.  Please just stick with a simple C array
for now, trying to mess with generic array types of arbitrary structures
and values and fields is a fun exercise in rust macros, but ick, let's
worry about that much later.

Try to do something "simple" if you really must, like just a pci device
id list, and if that works, then try USB ids.  And then, if you think
they look comon, THEN think about maybe combining them into something
that looks crazy like this.

But not now, no, please, keep it simple.  Stick to C arrays.

greg k-h

