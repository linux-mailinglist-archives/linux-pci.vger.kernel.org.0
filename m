Return-Path: <linux-pci+bounces-27598-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC28AB455A
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 22:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75D21465464
	for <lists+linux-pci@lfdr.de>; Mon, 12 May 2025 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB7E298CCA;
	Mon, 12 May 2025 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f24Md++a"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8E4229B0E;
	Mon, 12 May 2025 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747080457; cv=none; b=ZYuFLqz+P3y+BIo525WlzIcCdwBBe+Nj4q+DIkNXUxYAXhD5zyJQqqJqZ/TmemeGkRAJ0Tymyk9CJqjMSKZNePI+abuOupZXhQquwnrdMRwydmia1Lm1CPIO0SuNqAZQVQydOoAGBP3RMTMYX7QNFRFmxmMSjkGy0H7EQRoeCRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747080457; c=relaxed/simple;
	bh=Az4ibXiBakDxOB/LA6OaUS+wvOTTZFFucoLFx2LzIag=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=LeQhrfw6RAj/MK2lKqFBGTtnp+XzSQAGbRjn7L3T6Vb6t//qBZjpxLtt58EkV8SdgHVBlhF/MyOFJRDrBTCcyM06laGUxGIMxip1evNWPFP6pQa/SZCAI9Ag23fbwA0gQ8g3JkognkMUQlsUOtAAnBQf4BfMjI6YiJV3WhFYHzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f24Md++a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3828C4CEE7;
	Mon, 12 May 2025 20:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747080457;
	bh=Az4ibXiBakDxOB/LA6OaUS+wvOTTZFFucoLFx2LzIag=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f24Md++aQzEQfOEm96/rYw7SthZNEh2UBcHOBy4HSkJeILcPVetuY/eQlWUGfZGLi
	 UCmBc554nVfbXefiHzddrpkAKkGxxlW3Vkruj96EVb5aBVrjf8FV//hijvQgauRkpa
	 SYuBBJlCg+9IDSjtOKtyICE8RaB2A7xUFM3K4EkgItlNofzJD8bc2M8KQejyuW4ttd
	 /ecCmjUQJ2QnAAy2UUpfy4wVdpdoSFjgqmP23xUoct9Qw+QyU7T+00rIVqaxEbOm+b
	 SG4aIVoNwBMESSgux1qRwhIdG9UiXf1qKh6lsUVUGbfpNa9luyaU8BAAHCTDjF3BHv
	 60jLvXnJrlfGQ==
Date: Mon, 12 May 2025 15:07:34 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Andrew Ballance <andrewjballance@gmail.com>
Cc: dakr@kernel.org, airlied@gmail.com, simona@ffwll.ch,
	akpm@linux-foundation.org, ojeda@kernel.org, alex.gaynor@gmail.com,
	boqun.feng@gmail.com, gary@garyguo.net, bjorn3_gh@protonmail.com,
	benno.lossin@proton.me, a.hindborg@kernel.org, aliceryhl@google.com,
	tmgross@umich.edu, gregkh@linuxfoundation.org, rafael@kernel.org,
	bhelgaas@google.com, kwilczynski@kernel.org, raag.jadav@intel.com,
	andriy.shevchenko@linux.intel.com, arnd@arndb.de, me@kloenk.dev,
	fujita.tomonori@gmail.com, daniel.almeida@collabora.com,
	nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: Re: [PATCH 02/11] rust: io: Replace Io with MMIo using IoAccess trait
Message-ID: <20250512200734.GA1120867@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250509031524.2604087-3-andrewjballance@gmail.com>

On Thu, May 08, 2025 at 10:15:15PM -0500, Andrew Ballance wrote:
> From: Fiona Behrens <me@kloenk.dev>
> 
> Replace the Io struct with a new MMIo struct that uses the different
> traits (`IoAccess`, `IoAccess64`, `IoAccessRelaxed` and
> `IoAccess64Relaxed).
> This allows to later implement PortIo and a generic Io framework.

Add blank line between paragraphs.

> +    /// Read data from a give offset known at compile time.

s/give/given/

> +    /// Bound checks are perfomed on compile time, hence if the offset is not known at compile
> +    /// time, the build will fail.

s/perfomed on/performed at/

> +    /// Bound checks are performed on runtime, it fails if the offset (plus type size) is
> +    /// out of bounds.

s/on runtime/at runtime/

> +/// This Takes either `@read` or `@write` to generate a single read or write accessor function.

s/This Takes/This takes/

