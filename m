Return-Path: <linux-pci+bounces-40712-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 063B6C46FAE
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 14:42:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A14218883DD
	for <lists+linux-pci@lfdr.de>; Mon, 10 Nov 2025 13:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B248A13C3F2;
	Mon, 10 Nov 2025 13:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/KyLeHb"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2401DED7B;
	Mon, 10 Nov 2025 13:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762782069; cv=none; b=ZvJnPfqTH/OlPPggW5+clHRS8vqs9s3P/zY9fv2iDaApuv70kdY0ozhMtRsp1x6N+Oe4MLuz/7iLh0uEnwdjDTCF+20L7ausYFd/QRJdM1EUMMrMymVKjkuVBTH5U4ueBwlXXoZJejcwObt0wzX1mm1s9Gq2lplYdHh0g77DnLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762782069; c=relaxed/simple;
	bh=YyvEILKZOPaCVdYywI5ynhrjxIxQw+U5jV/llmxJWmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Eahi6qIkqgTyASFNZ20Yzu7OUVlY64ZSifhI9TGg60TTHVyeKyKxXu3phclSYklXqpCyBd/iPqc8S0bGfERCHJyvL4R96Scch+xpGFwiYcpD9xg/k11nWOgSDHEEeyi36jbJaKi0dWY9+DoHPPIeBuHmhS8oJ25x3271kqKLBio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/KyLeHb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49F4EC4CEFB;
	Mon, 10 Nov 2025 13:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762782065;
	bh=YyvEILKZOPaCVdYywI5ynhrjxIxQw+U5jV/llmxJWmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R/KyLeHbVTG85KmeM2p+RjVp3d2RIC9vKlxVoeYyMtFnnZVq8Bv/PjBeQWFxZ7yi7
	 h45NIs/Sk3wnniA7bsUNalcD++sDa8oQXxUe3HkGJ3rFRYWxzLf3Dm7QtR06zCumN5
	 sqxZCEZA3pXAn4FqK/z5rbhbB4BalWIjMfGSYh/tM80LxXP0bbWQpS5hhCT4yxWKd+
	 IO2ltmJeuYhy8xcoJNIqifrP0SyGsafOhXluqfjC1onGgoXe+Dd8aWnLdc6dx2egxb
	 Bh9yQVugGUspb3VrXacOHtZIMWacqgv+epE1VAe2omnMVCHHEDpsQ4dSqxG1cw4VrQ
	 sDI6tNGHBTbeA==
Date: Mon, 10 Nov 2025 13:40:58 +0000
From: Lee Jones <lee@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: Markus Probst <markus.probst@posteo.de>,
	Pavel Machek <pavel@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Dave Ertman <david.m.ertman@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, Leon Romanovsky <leon@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
	bjorn3_gh@protonmail.com, Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	rust-for-linux@vger.kernel.org, linux-leds@vger.kernel.org,
	linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/2] rust: leds: add led classdev abstractions
Message-ID: <20251110134058.GC1949330@google.com>
References: <20251027200547.1038967-1-markus.probst@posteo.de>
 <DDVLMBC40199.2BVFYHDGQP4Q4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DDVLMBC40199.2BVFYHDGQP4Q4@kernel.org>

On Thu, 30 Oct 2025, Danilo Krummrich wrote:

> Hi Markus,
> 
> On Mon Oct 27, 2025 at 9:06 PM CET, Markus Probst wrote:
> > Markus Probst (2):
> >   rust: Add trait to convert a device reference to a bus device
> >     reference
> >   rust: leds: add basic led classdev abstractions
> 
> I don't see an entry in the MAINTAINERS file for the added LED code.
> 
> Did you hear back from the LED maintainers already?
> 
> @Lee, Pavel: What's your take on this?

I'd be happy to take LED Rust patches at face value so long as they come
with a quality Rust-specific Reviewed-by.  Reviewing professional level
Rust code is presently beyond my capabilities.

-- 
Lee Jones [李琼斯]

