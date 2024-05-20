Return-Path: <linux-pci+bounces-7685-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B8EC8CA1DC
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 20:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B02501F2202C
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 18:15:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1590513792E;
	Mon, 20 May 2024 18:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jTFBNKml"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4490138490;
	Mon, 20 May 2024 18:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716228901; cv=none; b=OkoupTStRTWmGu2u6pZurMuKaNokfRQMaAQQl/lWTbOc/rXs/um6SMZ6lXEulICfwth1CLO7t3tEMaAFs3fBr5OSHb3Jfc8UaETaurNYnH2P9jAcW5vAqCrUMNaesFyoC+PJtnalEku+hRz4WTf1/Y0yShj1Qa6INUJv7PZvy4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716228901; c=relaxed/simple;
	bh=sdl7xmPQOgHmv8GHNzjY9FDVM4BY1dyuK3qdPCbMb4I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A2xM/DbcEI/BxC5uDt2x+Y4/q4Y0asMpnDxcKkc8mnTwsUG/LPbH2BgHyD4xAZPt4/Sb03A/iM6XqPpMfXkkRohZpGeNDXu6qoeHAyB4rlXb52IQw62tgQAU8/zX3qCW8T+AVtP+KzSIROe2LRVGcMeduTGNAJshtG89j/U67Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jTFBNKml; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8F9C2BD10;
	Mon, 20 May 2024 18:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716228900;
	bh=sdl7xmPQOgHmv8GHNzjY9FDVM4BY1dyuK3qdPCbMb4I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jTFBNKmlOScjmHMgVjKzvuxl4P/2jz+ogsZGgw1W4Q6qqpRrKxkSiEUB/OdEOMxRl
	 FnsKm7YnC5Dh9n/BTGYBHSlm/futsDGIx1scdsbwpwfR87bmbzi+0NE0HOUkB6K+IV
	 EKV8KhcefwOIhT06hI2UMnvQKe+wcBfOcA9P4bGQ=
Date: Mon, 20 May 2024 20:14:57 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Danilo Krummrich <dakr@redhat.com>
Cc: rafael@kernel.org, bhelgaas@google.com, ojeda@kernel.org,
	alex.gaynor@gmail.com, wedsonaf@gmail.com, boqun.feng@gmail.com,
	gary@garyguo.net, bjorn3_gh@protonmail.com, benno.lossin@proton.me,
	a.hindborg@samsung.com, aliceryhl@google.com, airlied@gmail.com,
	fujita.tomonori@gmail.com, lina@asahilina.net, pstanner@redhat.com,
	ajanulgu@redhat.com, lyude@redhat.com,
	rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [RFC PATCH 00/11] [RFC] Device / Driver and PCI Rust abstractions
Message-ID: <2024052029-unbridle-wildcard-fbf8@gregkh>
References: <20240520172554.182094-1-dakr@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240520172554.182094-1-dakr@redhat.com>

On Mon, May 20, 2024 at 07:25:37PM +0200, Danilo Krummrich wrote:
> This patch sereis implements basic generic device / driver Rust abstractions,
> as well as some basic PCI abstractions.
> 
> This patch series is sent in the context of [1], and the corresponding patch
> series [2], which contains some basic DRM Rust abstractions and a stub
> implementation of the Nova GPU driver.
> 
> Nova is intended to be developed upstream, starting out with just a stub driver
> to lift some initial required infrastructure upstream. A more detailed
> explanation can be found in [1].
> 
> Some patches, which implement the generic device / driver Rust abstractions have
> been sent a couple of weeks ago already [3]. For those patches the following
> changes have been made since then:
> 
> - remove RawDevice::name()
> - remove rust helper for dev_name() and dev_get_drvdata()
> - use AlwaysRefCounted for struct Device
> - drop trait RawDevice entirely in favor of AsRef and provide
>   Device::from_raw(), Device::as_raw() and Device::as_ref() instead
> - implement RevocableGuard
> - device::Data, remove resources and replace it with a Devres abstraction
> - implement Devres abstraction for resources
> 
> As mentioned above, a driver serving as example on how these abstractions are
> used within a (DRM) driver can be found in [2].
> 
> Additionally, the device / driver bits can also be found in [3], all
> abstractions required for Nova in [4] and Nova in [5].
> 
> [1] https://lore.kernel.org/dri-devel/Zfsj0_tb-0-tNrJy@cassiopeiae/T/#u
> [2] https://lore.kernel.org/dri-devel/20240520172059.181256-1-dakr@redhat.com/
> [3] https://github.com/Rust-for-Linux/linux/tree/staging/rust-device
> [4] https://github.com/Rust-for-Linux/linux/tree/staging/dev
> [5] https://gitlab.freedesktop.org/drm/nova/-/tree/nova-next
> 
> Danilo Krummrich (2):
>   rust: add abstraction for struct device
>   rust: add devres abstraction
> 
> FUJITA Tomonori (1):
>   rust: add basic PCI driver abstractions
> 
> Philipp Stanner (2):
>   rust: add basic abstractions for iomem operations
>   rust: PCI: add BAR request and ioremap
> 
> Wedson Almeida Filho (6):
>   rust: add driver abstraction
>   rust: add rcu abstraction
>   rust: add revocable mutex
>   rust: add revocable objects
>   rust: add device::Data
>   rust: add `dev_*` print macros.

No list of the changes made since the last time this was submitted?

No versioning of this submission?

Why not?

thanks,

greg k-h

