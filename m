Return-Path: <linux-pci+bounces-26114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F7DA92110
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 17:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97169447194
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 15:14:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F176253328;
	Thu, 17 Apr 2025 15:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTcCvCNg"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F79E24E01F;
	Thu, 17 Apr 2025 15:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744902848; cv=none; b=a0PMwq28G6baYroLX/mXZANXLG3IPJ4ntQPqsPT2mZjtJTfsv5LN2HWgkBa6Pe602Q/0ePARVZRWs+fKYrs6UjKlYJY8bCec08WzoHPr4Ld/vetU5zlxmwRKVEepZc0JtVxdvH/0BVGsrDjAB8Ef0j9nKQb3uNRVRYRuGGkusMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744902848; c=relaxed/simple;
	bh=EP97wmXESng5EY5BT5Sy+b2r7SMfbW3Af0nkrEO3vX0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HvbpzjNrSZgVvoo7kkEgp3TxLXXcUb19tPrKyUok1qDWozLPL1qfD2b2djCMHcLbP2RwjG2V2ja8wNhH51Zn0eqb08rZ4sNjZGA5Mbnb+ZcqYcuYJz4CpfkE8Or1AwdrX5uvluE6yN8XJ6suB1j+IhwmsAP/kh0Sn9xe4IuxLOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTcCvCNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E230C4CEEA;
	Thu, 17 Apr 2025 15:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744902847;
	bh=EP97wmXESng5EY5BT5Sy+b2r7SMfbW3Af0nkrEO3vX0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=FTcCvCNg1AE6weIgg7SbqM1lwrzGDeoVYtbqYBA0hVnKq9otsiZbCs0+wxYMUKSTd
	 FdlWPJAuSbJ0lUYHv/4ddSEozz0/MhMu2MkWrYAWn4Jd77uxVrArOEQt+SpD2HAAbF
	 AJhcqu8+0luaDe0/GbVDQA3H9jS2Txpb/EDI/0UYA9FJ0Bk36vHWKSDLAM3FfJjsle
	 7ZaqxlvQdVqYpAq9GeQBSb1MNizUYXDi6AZ9RwUSlmqW7IClQHV2rVKUazJkwwDAK0
	 QqIcCkUATATRuXg7vGBwbR64PJZSUBWZdcK+10baeCicucvtsNXAnTYzKsN0Yk9vwU
	 8qPwr9vf4JxWg==
Date: Thu, 17 Apr 2025 17:14:01 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: bhelgaas@google.com, kwilczynski@kernel.org, gregkh@linuxfoundation.org,
	rafael@kernel.org, abdiel.janulgue@gmail.com
Cc: ojeda@kernel.org, alex.gaynor@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu,
	daniel.almeida@collabora.com, robin.murphy@arm.com,
	linux-pci@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/9] Implement "Bound" device context
Message-ID: <aAEaubIVd9XDflxc@cassiopeiae>
References: <20250413173758.12068-1-dakr@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250413173758.12068-1-dakr@kernel.org>

On Sun, Apr 13, 2025 at 07:36:55PM +0200, Danilo Krummrich wrote:
> Currently, we do not ensure that APIs that require a bound device instance can
> only be called with a bound device.
> 
> Examples of such APIs are Devres, dma::CoherentAllocation and
> pci::Device::iomap_region().
> 
> This patch series introduces the "Bound" device context such that we can ensure
> to only ever pass a bound device to APIs that require this precondition.
> 
> In order to get there, we need some prerequisites:
> 
> (1) Implement macros to consistently derive Deref implementations for the
>     different device contexts. For instance, Device<Core> can be dereferenced to
>     Device<Bound>, since all device references we get from "core" bus callbacks
>     are guaranteed to be from a bound device. Device<Bound> can always be
>     dereferenced to Device (i.e. Device<Normal>), since the "Normal" device
>     context has no specific requirements.
> 
> (2) Implement device context support for the generic Device type. Some APIs such
>     as Devres and dma::CoherentAllocation work with generic devices.
> 
> (3) Preserve device context generics in bus specific device' AsRef
>     implementation, such that we can derive the device context when converting
>     from a bus specific device reference to a generic device reference.
> 
> With this, Devres::new(), for instance, can take a &Device<Bound> argument and
> hence ensure that it can't be called with a Device reference that is not
> guaranteed to be bound to a driver.
> 
> A branch containing the patches can be found in [1].
> 
> [1] https://web.git.kernel.org/pub/scm/linux/kernel/git/dakr/linux.git/log/?h=rust/device-bound

With the following changes, applied to driver-core/topic/device-context, thanks!

  *  Add missing `::` prefix in macros.
  *  Fix typos pointed out by Bjorn.

- Danilo

