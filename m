Return-Path: <linux-pci+bounces-21680-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 192A4A38F14
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 23:29:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249673AC8A1
	for <lists+linux-pci@lfdr.de>; Mon, 17 Feb 2025 22:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC111A83F4;
	Mon, 17 Feb 2025 22:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XWbYDc4I"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30F1019F115;
	Mon, 17 Feb 2025 22:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739831387; cv=none; b=Co+zjZwVWvu4ZBRCj6n/cJ2qN3OmvglaIIdyO4ZX+QzNPOTOy8KQ4Fz1Icy1Bd2rofy1d3n/1wgUsh1++t047P02oDts6WtnqXgE+ODZYQaMQ+J43PYH8MuKTxaI3Aai9tFVb4ZHbVew6tQzG24rYazzf8I8THLS8qcDDsCMzw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739831387; c=relaxed/simple;
	bh=l2diEQnJlWhhlB32ExiFPYSIR4DSsw4YcZ3zO9O5nDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZiKzBv/5E5kgn04wwMtkr8Eo/BVQk+pQfmAwQ3Nt7tLmqICGQpZldp09I6c1ND3/6bj2Wmk9qtIWJOWzefwbFRleKdYJBKgao0gNEc6NluyCIKGqJEMFmG7OVZ8e2HLIj7s6MzhC+kc/foqDnD+6fotOHniBJs+I2ndKBlgbg5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XWbYDc4I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D544C4CED1;
	Mon, 17 Feb 2025 22:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739831386;
	bh=l2diEQnJlWhhlB32ExiFPYSIR4DSsw4YcZ3zO9O5nDw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XWbYDc4IT8t/UB7OrOs0IGbsVwtvDlBWzy+p3q83HQGkKU0t8uuOGKu8D0uiIBvmx
	 KV1AC4S7hcqfSK/BwmLwmr5iO6/ZL9jN6EcbsX3aST8IWYjKCcGOtiWlHdZgnHyFUe
	 31YRqQKoeG0NtCMaBBjr6wiaCxl21g6YUV/CScL4GHdacnWTWHBHldscqowwCtfGsY
	 etr/ovFsEjxpLI38irMcqw2tmJCZFfTzENGmOrCTPkcgrZC5T0M5F399WgI8umHS/Y
	 bLDwhQxV2UG3fxUF1w/t9KSEtOYIwSiUU4I4zC123A8YSmW1KAyzP78av9J0rLIya1
	 liUUJU0+/6fBA==
Date: Mon, 17 Feb 2025 23:29:40 +0100
From: Danilo Krummrich <dakr@kernel.org>
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc: Daniel Almeida <daniel.almeida@collabora.com>,
	Fiona Behrens <me@kloenk.dev>, Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <benno.lossin@proton.me>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH] rust: io: rename `io::Io` accessors
Message-ID: <Z7O4VHWZPk1yNwC7@pollux>
References: <20250217-io-generic-rename-v1-1-06d97a9e3179@kloenk.dev>
 <2244CEBA-3AF2-4572-B32E-8BA9F86417C9@collabora.com>
 <CANiq72n=a+TjXNe13HuiuiLA+TE4pfMk6SB49AjpHkYju4pVag@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANiq72n=a+TjXNe13HuiuiLA+TE4pfMk6SB49AjpHkYju4pVag@mail.gmail.com>

On Mon, Feb 17, 2025 at 10:59:58PM +0100, Miguel Ojeda wrote:
> On Mon, Feb 17, 2025 at 10:37 PM Daniel Almeida
> <daniel.almeida@collabora.com> wrote:
> >
> > IMHO, the `writel` and `readl` nomenclature is extremely widespread, so it’s a bit confusing to see this renamed.
> 
> We could generate `#[doc(alias = "...")]`s if that helps -- it would
> appear if you type `writel` in the search, for instance.

This is a good idea, I think.

> 
> (I guess the rename could be justified (just a bit) by the fact that
> in Rust we are using fixed-width integers and so on more...)

This is a good reason too. My main reason for proposing this was that if we back
the trait with both MMIO and PIO `writel` and `readl` nomenclature might falsely
be read as if it is limited to MMIO.

